;
; Button handling with debouncing
;
; Buttons are read at 100Hz and button_dec/inc counters are
; Updated at 10Hz.
; button_dec/inc tells for how long button has been pressed (in 1/10 seconds)
;
; DEC button on PORTB1
; INC button on PORTB4
;

#include "p18cxxx.inc"

	global button_init
	global button_irq
	global button_dec
	global button_inc

DEBOUNCE_COUNT	equ 10

	idata
debounce_counter	db  DEBOUNCE_COUNT
btn_dec_count		db  -DEBOUNCE_COUNT/2
btn_inc_count		db  -DEBOUNCE_COUNT/2

button_dec		db  0
button_inc		db  0

	udata
w_tmp			res 1
status_tmp		res 1
bsr_tmp			res 1

	code

button_init
	movlw	0x0F
	movwf	ADCON1		; digital inputs
	bcf	INTCON2, RBPU	; enable pull-ups
	bcf	INTCON2, TMR0IP	; timer0 low priority interrupt
	movlw	b'10000001'
	movwf	T0CON		; prescaler 1:4
	bsf	INTCON, TMR0IE

button_irq

	movwf	w_tmp
	movf	STATUS, w
	movwf	status_tmp
	movf	BSR, w
	movwf	bsr_tmp;

	; Set TMR0 to 65535-25000.
	; With prescaler of 1:4 and 10MHz FOSC, timer is ~100Hz
	movlw	0x9E
	movwf	TMR0H
	movlw	0x57
	movwf	TMR0L
	bcf	INTCON, TMR0IF

	btfss	PORTB, 4
	incf	btn_dec_count
	btfss	PORTB, 1
	incf	btn_inc_count

	decfsz	debounce_counter
	bra	exit_irq

	incf	button_dec
	btfsc	btn_dec_count, 7
	clrf	button_dec

	incf	button_inc
	btfsc	btn_inc_count, 7
	clrf	button_inc

	movlw	DEBOUNCE_COUNT
	movwf	debounce_counter

	movlw	-DEBOUNCE_COUNT/2
	movwf	btn_dec_count
	movwf	btn_inc_count

exit_irq
	movf	bsr_tmp, w
	movwf	BSR
	movf	status_tmp, w
	movwf	STATUS
	swapf	w_tmp, f
	swapf	w_tmp, w

	retfie	0

	end
