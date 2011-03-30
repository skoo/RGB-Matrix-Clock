
#include "rgbmatrix.h"

/* anode (row selection) data is in fb data
 * to simplify display update in irq code.
 */
void matrix_init_fb(void)
{
	unsigned char i;
	unsigned char sel = 0x80;
	unsigned char* fb = matrix_fb;

	/* set the row selection data in fb. */
	for (i = 0; i < 8; i++) {
		*fb++ = 0xff;
		*fb++ = 0xff;
		*fb++ = 0xff;
		*fb++ = sel;
		*fb++ = 0xff;
		*fb++ = 0xff;
		*fb++ = 0xff;
		*fb++ = sel;

		sel >>= 1;
	}
}

void matrix_dot(
	unsigned char x,
	unsigned char y,
	unsigned char c)
{
	unsigned char i;
	unsigned char* fb = matrix_fb;
	unsigned char b;

	fb += y << 3;
	fb += (x & 0xf8) >> 1;

	b = (0x80 >> (x & 7));

	for (i = 4; i; i >>= 1) {
		if (c & i)
			*fb &= ~b;
		else
			*fb |= b;

		fb++;
	}
}
