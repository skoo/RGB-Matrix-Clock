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
#pragma code

void main(void)
{
	unsigned char last_sec = 0x60;

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

	rtc_init();

#if defined(SET_CLOCK)
	rtc_setclock(rtcdata);
#endif

	matrix_brightness = 15;

	INTCONbits.GIE = 1;
	INTCONbits.PEIE = 1;

	matrix_start();

	while (1) {
		unsigned short year;
		unsigned char month;
		unsigned char date;
		unsigned char hour;
		unsigned char s = 0;
		unsigned char sec;
		unsigned char sec_color;
		unsigned char sec_bg;

		if (rtc_update()) {
			continue;
		}

		/* redraw only when time changes */
		if (last_sec == rtc_sec_bcd())
			continue;

		last_sec = rtc_sec_bcd();

		month = BCD_TO_DEC(rtc_month_bcd());
		date = BCD_TO_DEC(rtc_date_bcd());
		hour = BCD_TO_DEC(rtc_hour_bcd());

		year = BCD_TO_DEC(rtc_year_bcd()) + 2000;

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

		sec = rtc_sec_bcd() >> 4;

		if (sec == 3) {
			matrix_set_digit(0, RGB_DATE, date / 10);
			matrix_set_digit(1, RGB_DATE, date % 10);
			matrix_set_digit(2, RGB_DATE, month / 10);
			matrix_set_digit(3, RGB_DATE, month % 10);

			matrix_dot(7, 6, RGB_DATE_DOT);

			sec_color = RGB_DATE_SEC;
			sec_bg = RGB_DATE_SEC_BACKGROUND;
		} else {
			matrix_set_digit(0, RGB_TIME, hour / 10);
			matrix_set_digit(1, RGB_TIME, hour % 10);
			matrix_set_digit(2, RGB_TIME, rtc_min_bcd() >> 4);
			matrix_set_digit(3, RGB_TIME, rtc_min_bcd() & 0x0f);

			if (rtc_sec_bcd() & 1) {
				matrix_dot(7, 2, RGB_TIME_DOT);
				matrix_dot(7, 4, RGB_TIME_DOT);
			}

			sec_color = RGB_TIME_SEC;
			sec_bg = RGB_TIME_SEC_BACKGROUND;
		}

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

		Delay10KTCYx(10);

	}
}
