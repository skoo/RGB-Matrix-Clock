#ifndef _RTC_H_
#define _RTC_H_

void rtc_init(void);
unsigned char rtc_update(void);

unsigned char rtc_year_bcd(void);
unsigned char rtc_month_bcd(void);
unsigned char rtc_date_bcd(void);
unsigned char rtc_day_bcd(void);
unsigned char rtc_hour_bcd(void);
unsigned char rtc_min_bcd(void);
unsigned char rtc_sec_bcd(void);

void rtc_setclock(const unsigned char* rtcdata);

#define BCD_TO_DEC(x) ((x>>4)*10+(x&0x0f))

#endif _RTC_H_