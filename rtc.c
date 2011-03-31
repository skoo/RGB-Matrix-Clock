/*
 * DS1307 RTC
 */

#include "rtc.h"
#include <p18cxxx.h>
#include <i2c.h>

static unsigned char rtc[8];

void rtc_init(void)
{
	TRISDbits.TRISD0 = 1;	// SCL2
	TRISDbits.TRISD1 = 1;	// SDA2

	OpenI2C2(MASTER, SLEW_OFF);

	SSP2ADD = 99; // 100kHz @ 40MHz FOSC
}

unsigned char rtc_update(void)
{
	unsigned char ret = 0xff;
	int i;

	StartI2C2();
	if (WriteI2C2(0b11010000) == 0) {
		if (WriteI2C2(0x00) == 0) {
			RestartI2C2();
			if (WriteI2C2(0b11010001) == 0) {
				i = 0;
				do {
					rtc[i++] = ReadI2C2();
					if (i<8) {
						AckI2C2();
					} else {
						NotAckI2C2();
					}
				} while (i<8);
				ret = 0;
			}
		}
	}
	StopI2C2();
	return ret;
}

unsigned char rtc_year_bcd(void)
{
	return rtc[6];
}

unsigned char rtc_month_bcd(void)
{
	return rtc[5];
}

unsigned char rtc_date_bcd(void)
{
	return rtc[4];
}

unsigned char rtc_day_bcd(void)
{
	return rtc[3];
}

unsigned char rtc_hour_bcd(void)
{
	return rtc[2] & 0x3f;
}

unsigned char rtc_min_bcd(void)
{
	return rtc[1];
}

unsigned char rtc_sec_bcd(void)
{
	return rtc[0] & 0x7f;
}

void rtc_setclock(const unsigned char* rtcdata)
{
	unsigned char i;

	StartI2C2();
	if (WriteI2C2(0b11010000) == 0) {
		if (WriteI2C2(0x00) == 0) {
			for (i = 0; i < 8; i++) {
				WriteI2C2(rtcdata[i]);
			}
		}
	}
	StopI2C2();
}
