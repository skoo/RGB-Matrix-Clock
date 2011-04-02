/**
 * Copyright (C) 2011 by Saku Kekkonen
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include <p18cxxx.h>
#include <delays.h>
#include "rgbmatrix.h"
#include "rtc.h"
#include "calendar.h"
#include "button.h"

#pragma config STVREN	= ON
#pragma config XINST	= OFF
#pragma config WDTEN	= OFF
#pragma config CP0	= OFF
#pragma config FCMEN	= ON
#pragma config IESO	= OFF
#pragma config FOSC2	= ON
#pragma config FOSC	= HSPLL

#define RGB_TIME		RGB(1,0,0)
#define RGB_TIME_SEC		RGB(1,1,1)
#define RGB_TIME_SEC_BACKGROUND RGB(1,1,0)
#define RGB_TIME_DOT		RGB(1,1,0)

#define RGB_DATE 		RGB(0,0,1)
#define RGB_DATE_SEC		RGB(0,1,1)
#define RGB_DATE_SEC_BACKGROUND RGB(1,0,1)
#define RGB_DATE_DOT		RGB(1,0,1)

// #define SET_CLOCK

#define RGB(r,g,b) ((r<<2)|(g<<1)|b)

#pragma code high_vector=0x08
void interrupt_at_high_vector(void)
{
	_asm
	GOTO matrix_irq
	_endasm
}

#pragma code low_vector=0x18
void interrupt_at_low_vector(void)
{
	_asm
	GOTO button_irq
	_endasm
}

#pragma code

static void draw_digits(char force_update);
static void draw_second_markers(void);
static char adjust_time(void);

void main(void)
{
	OSCTUNEbits.PLLEN = 1;

#if defined(SET_CLOCK)
	/* No method for setting rtc at run time.
	 * Compile with SET_CLOCK and call enabled
	 * and run once to set the UTC time.
	 */

	static const unsigned char rtcdata[8] = {
		0x00, // sec
		0x42, // min
		0x14, // hour (24 hour format)
		0x05, // day of week (01-07, 1=monday)
		0x31, // date
		0x03, // month
		0x11, // year
	};
#endif

	matrix_init();
	matrix_init_fb();

	button_init();

	rtc_init();

#if defined(SET_CLOCK)
	rtc_setclock(rtcdata);
#endif

	matrix_brightness = 15;

	RCONbits.IPEN = 1;	// enable interrupt priority
	INTCONbits.GIEH = 1;	// enable hi priority interrupts
	INTCONbits.GIEL = 1;	// enable low priority interrupts
	INTCONbits.PEIE = 1;

	matrix_start();

	while (rtc_update());
	draw_digits(1);
	draw_second_markers();

	while (1) {
		static unsigned char last_sec = 0x60;

		if (adjust_time())
		{
			if (rtc_update() == 0) {
				draw_digits(1);
				draw_second_markers();
			}
		} else {
			if (rtc_update() == 0) {
				if (last_sec != rtc_sec_bcd()) {
					last_sec = rtc_sec_bcd();
					draw_digits(0);
					draw_second_markers();
				}
			}
		}
	}
}

void draw_second_markers(void)
{
	unsigned char s = 0;
	unsigned char sec;
	unsigned char sec_color;
	unsigned char sec_bg;

	sec = rtc_sec_bcd() >> 4;

	if (sec == 3) {
		/* date display mode for seconds 30..39 */
		matrix_dot(7, 6, RGB_DATE_DOT);
		sec_color = RGB_DATE_SEC;
		sec_bg = RGB_DATE_SEC_BACKGROUND;
	} else {
		/* time display mode */
		if (rtc_sec_bcd() & 1) {
			matrix_dot(7, 2, RGB_TIME_DOT);
			matrix_dot(7, 4, RGB_TIME_DOT);
		} else {
			matrix_dot(7, 2, 0);
			matrix_dot(7, 4, 0);
		}

		sec_color = RGB_TIME_SEC;
		sec_bg = RGB_TIME_SEC_BACKGROUND;
	}

	/* draw second display lines */

	while (sec > s) {
		matrix_dot(s++, 7, sec_color);
	}

	while (s < 5) {
		matrix_dot(s++, 7, sec_bg);
	}

	s = 6;
	sec = (rtc_sec_bcd() & 0x0f) + 6;

	while (sec > s) {
		matrix_dot(s++, 7, sec_color);
	}

	while (s < 15) {
		matrix_dot(s++, 7, sec_bg);
	}
}

void draw_digits(char force_update)
{
	static unsigned char last_hour = 24;

	unsigned short year;
	unsigned char month;
	unsigned char date;
	unsigned char hour;
	unsigned char sec;

	year = BCD_TO_DEC(rtc_year_bcd()) + 2000;
	month = BCD_TO_DEC(rtc_month_bcd());
	date = BCD_TO_DEC(rtc_date_bcd());
	hour = BCD_TO_DEC(rtc_hour_bcd());

	if (hour != last_hour || force_update) {

		if (is_summertime(year, month, date, hour, BCD_TO_DEC(rtc_day_bcd())))
			hour += 3;
		else
			hour += 2;

		if (hour > 23) {
			hour -= 24;
			date++;

			if (days_in_month(month, year) < date) {
				date = 1;
				month++;
				if (month > 12)
					month = 1;
			}
		}

		if (hour < 7)
			matrix_brightness = hour+1;
		else if(hour > 20)
			matrix_brightness = (24-hour) * 2;
		else
			matrix_brightness = 15;
	}

	sec = rtc_sec_bcd();

	if (sec == 0x30 && !force_update) {
		/* date display mode for seconds 30..39 */

		matrix_set_digit(0, RGB_DATE, date / 10);
		matrix_set_digit(1, RGB_DATE, date % 10);
		matrix_set_digit(2, RGB_DATE, month / 10);
		matrix_set_digit(3, RGB_DATE, month % 10);
	} else if (sec == 0x40 || force_update) {
		/* time display mode */
		
		matrix_set_digit(0, RGB_TIME, hour / 10);
		matrix_set_digit(1, RGB_TIME, hour % 10);
		matrix_set_digit(2, RGB_TIME, rtc_min_bcd() >> 4);
		matrix_set_digit(3, RGB_TIME, rtc_min_bcd() & 0x0f);
	}

	last_hour = hour;
}

/**
 * Adjust time by using dec & inc buttons.
 *
 * TODO: Better implementation. Does not handle calendar.
 * only useful for adjusting clock drift, not for setting the time
 * after changing battery.
 *
 * @return 1 if time was adjusted.
 */
char adjust_time(void)
{
	static unsigned char dec_len = 0;
	static unsigned char inc_len = 0;

	if (button_dec > dec_len)
		dec_len = button_dec;

	if (button_inc > inc_len)
		inc_len = button_inc;

	if (button_dec < dec_len || button_inc < inc_len) {
		char sec = BCD_TO_DEC(rtc_sec_bcd());
		char min = BCD_TO_DEC(rtc_min_bcd());
		char hour = BCD_TO_DEC(rtc_hour_bcd());

		if (button_dec < dec_len) {
			sec--;
			dec_len = 0;
		}
		if (button_inc < inc_len) {
			sec++;
			inc_len = 0;
		}

		if (sec < 0) {
			sec = 59;
			min--;
			if (min < 0) {
				min = 59;
				hour--;
				if (hour < 0)
					hour = 23;
			}
		} else if (sec > 59) {
			sec = 0;
			min++;
			if (min > 59) {
				min = 0;
				hour++;
				if (hour > 23)
					hour = 0;
			}
		}

		rtc_data_set_time(rtc, hour, min, sec);
		rtc_setclock(rtc);

		return 1;
	}

	return 0;
}