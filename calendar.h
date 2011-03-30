#ifndef _CALENDAR_H_
#define _CALENDAR_H_

#define SUMMERTIME_MONTH_BEGIN 3
#define SUMMERTIME_MONTH_END 10

/* At what hour summter time changes, UTC */
#define SUMMERTIME_HOUR_BEGIN 1
#define SUMMERTIME_HOUR_END 1

#define WEEKDAY_SUNDAY 7

unsigned char days_in_month(unsigned char month, unsigned short year);
unsigned char is_summertime(unsigned short year, unsigned char month,
	unsigned char date, unsigned char hour, unsigned char day);

#endif // CALENDAR_H_
