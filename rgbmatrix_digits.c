#include "rgbmatrix.h"

#define DG(x,y) ~(0b ## x ## 0 ## y ## 0)

rom static const unsigned char digits[5*8 + 5*8] =
{
	/* 3x7 */

	/* 0    1 */
	DG(111, 001),
	DG(101, 001),
	DG(101, 001),
	DG(101, 001),
	DG(101, 001),
	DG(101, 001),
	DG(111, 001),
	DG(000, 000),

	/* 2    3 */
	DG(111, 111),
	DG(001, 001),
	DG(001, 001),
	DG(111, 111),
	DG(100, 001),
	DG(100, 001),
	DG(111, 111),
	DG(000, 000),

	/* 4    5 */
	DG(101, 111),
	DG(101, 100),
	DG(101, 100),
	DG(111, 111),
	DG(001, 001),
	DG(001, 001),
	DG(001, 111),
	DG(000, 000),

	/* 6    7 */
	DG(111, 111),
	DG(100, 001),
	DG(100, 001),
	DG(111, 001),
	DG(101, 001),
	DG(101, 001),
	DG(111, 001),
	DG(000, 000),

	/* 8    9 */
	DG(111, 111),
	DG(101, 101),
	DG(101, 101),
	DG(111, 111),
	DG(101, 001),
	DG(101, 001),
	DG(111, 111),
	DG(000, 000),

	/* 3x5 */

	/* 0    1 */
	DG(000, 000),
	DG(111, 001),
	DG(101, 001),
	DG(101, 001),
	DG(101, 001),
	DG(111, 001),
	DG(000, 000),
	DG(000, 000),

	/* 2    3 */
	DG(000, 000),
	DG(111, 111),
	DG(001, 001),
	DG(111, 111),
	DG(100, 001),
	DG(111, 111),
	DG(000, 000),
	DG(000, 000),

	/* 4    5 */
	DG(000, 000),
	DG(101, 111),
	DG(101, 100),
	DG(111, 111),
	DG(001, 001),
	DG(001, 111),
	DG(000, 000),
	DG(000, 000),

	/* 6    7 */
	DG(000, 000),
	DG(111, 111),
	DG(100, 001),
	DG(111, 001),
	DG(101, 001),
	DG(111, 001),
	DG(000, 000),
	DG(000, 000),

	/* 8    9 */
	DG(000, 000),
	DG(111, 111),
	DG(101, 101),
	DG(111, 111),
	DG(101, 001),
	DG(111, 111),
	DG(000, 000),
	DG(000, 000),
};

void matrix_set_digit(
	unsigned char pos,
	unsigned char color,
	unsigned char dig)
{
	unsigned char* fb = matrix_fb;
	unsigned char shift;
	unsigned char d_off;
	unsigned char d_shift;
	unsigned char y;
	unsigned char c;

	fb  += (pos & 0xfe) << 1;
	shift = (pos & 1) << 2;

	d_off = (dig & 0x0fe) << 2;
	d_shift = (dig & 1) << 2;

	/* drawing only 7 rows (3x7 digits) */
	for (y=0;y<7;y++)
	{
		unsigned char d;
		unsigned char s;

		s = (digits[d_off++] | 0x0f<<d_shift);

		if (shift != d_shift)
		{
			unsigned char tmp;
			tmp = s >> 4;
			s = (s << 4) | tmp;
		}

		for (c=4;c;c>>=1)
		{
			d = *fb | (0xf0>>shift);
			if (color & c)
				d &= s;

			*fb++ = d;
		}

		fb += 5;
	}
}
