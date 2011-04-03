#ifndef _RGBMATRIX_H_
#define _RGBMATRIX_H_

extern volatile unsigned char matrix_fb[2*4*8];
extern volatile unsigned char matrix_brightness;

extern void matrix_irq(void);
extern void matrix_init(void);
extern void matrix_start(void);
extern void matrix_update(void);

void matrix_init_fb(void);
void matrix_set_digit(
	unsigned char pos,
	unsigned char color,
	unsigned char dig);

void matrix_dot(
	unsigned char x,
	unsigned char y,
	unsigned char c);

#define DIGIT_3X7(x) (x)
#define DIGIT_3X5(x) (10+(x))

#endif // _RGBMATRIX_H_
