
#ifndef _BUTTON_H_
#define _BUTTON_H_

/* time dec button has been pressed in 1/10 seconds */
extern volatile unsigned char button_dec;
/* time inc button has been pressed in 1/10 seconds */
extern volatile unsigned char button_inc;

extern void button_init(void);
extern void button_irq(void);

#endif // _BUTTON_H_
