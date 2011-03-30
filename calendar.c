
#include "calendar.h"

unsigned char days_in_month(unsigned char month, unsigned short year)
{
	static const unsigned char days_in_month[12] = {
		31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
	};

	if (month != 2)
		return days_in_month[month-1];

	if ((!(year % 4) && (year % 100)) || !(year % 400))
		return 29;
	else
		return 28;
}

/* European Summer time check.
 * From the last Sunday in March to the last Sunday in October
 */
unsigned char is_summertime(unsigned short year, unsigned char month, unsigned char date,
	unsigned char hour, unsigned char day)
{
	unsigned char ns;
	unsigned char dim;

	if (month < SUMMERTIME_MONTH_BEGIN || month > SUMMERTIME_MONTH_END)
		return 0;

	if (month != SUMMERTIME_MONTH_BEGIN && month != SUMMERTIME_MONTH_END)
		return 1;

	dim = days_in_month(month, year);

	/* if currently not sunday, date of the next one */
	ns = date + (WEEKDAY_SUNDAY-day);

	if (ns > dim) {
		/* last sunday of the month was already */
		return month == SUMMERTIME_MONTH_BEGIN ? 1 : 0;
	} else if (ns == date) {
		/* last sunday of the month */
		if (month == SUMMERTIME_MONTH_BEGIN)
			return hour >= SUMMERTIME_HOUR_BEGIN ? 1 : 0;
		else
			return hour >= SUMMERTIME_HOUR_END ? 0 : 1;
	} else {
		/* last sunday of the month still ahead */
		return month == SUMMERTIME_MONTH_BEGIN ? 0 : 1;
	}
}