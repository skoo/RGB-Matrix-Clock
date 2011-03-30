
#include "p18cxxx.inc"

RCK_PORT	equ PORTD
RCK_TRIS	equ TRISD
RCK_PIN		equ 4
SCK_PORT	equ PORTC
SCK_TRIS	equ TRISC
SCK_PIN		equ 3
SDO_PORT	equ PORTC
SDO_TRIS	equ TRISC
SDO_PIN		equ 5

	global matrix_fb
	global matrix_brightness

	global matrix_init
	global matrix_start
	global matrix_irq

fb	udata 0x100		; must be aligned to 128 bytes
matrix_fb	res 2*4*8 	; 2 displays, RGBA, 8 rows.
calib idata 0x140		; must be directly after 64-byte fb
cal			db	0x00, 0x00, 0x00, 0x00,  0x00, 0xff, 0xff, 0x00

	udata
blanking		res 1
matrix_brightness 	res 1
brightness		res 1
brcounter		res 1
calcounter		res 1
bytecounter		res 1
fsrl			res 1
fsrh			res 1
tmp			res 1
	code

matrix_init
	movlw	0x0f
	movwf	matrix_brightness
	clrf	brcounter
	clrf	calcounter
	clrf	bytecounter

	bcf	RCK_TRIS, RCK_PIN
	bcf	SDO_TRIS, SDO_PIN
	bcf	SCK_TRIS, SCK_PIN

	bsf	RCK_PORT, RCK_PIN

	bcf	SSPCON1, SSPEN
	clrf	SSPSTAT
	movlw	b'00010000'
	movwf	SSPCON1;
	bsf	SSPCON1, SSPEN
	bsf	PIE1, SSPIE

	return

matrix_start
	movwf	SSPBUF ; send dummy byte to start irq loop
	return

matrix_irq
	bcf	PIR1, SSPIF

	movf	FSR0L, w
	movwf	fsrl
	movf	FSR0H, w
	movwf	fsrh

	lfsr	FSR0, matrix_fb
	movf	bytecounter, w
	movwf	FSR0L

	btfss	FSR0L, 6 ; 64-bytes sent?
	bra	_latchcheck

_nextcycle
	movf	matrix_brightness, w
	movwf	brightness
	lfsr	FSR0, matrix_fb
	btg	calcounter, 2
	btfsc	calcounter, 2
	bra	_latchcheck

	clrf	blanking
	incf	brcounter, w
	andlw	0x0f
	movwf	brcounter
	subwf	brightness, w
	bc	_latchcheck
	setf	blanking

_latchcheck
	movf	FSR0L, w
	andlw	0x07
	bnz	_sendbyte

	; sent 8 bytes, latch.
	bcf	RCK_PORT, RCK_PIN
	bsf	RCK_PORT, RCK_PIN

_sendbyte

	movf	INDF0, w
	iorwf	blanking, w

	movwf	tmp

	movf	FSR0L, w
	movwf	bytecounter

	andlw	0x03		; 0 ..3 (RGBA)
	iorlw	0x40		; 64 bytes after fb
	iorwf	calcounter, w	; 0 or 4 bytes
	movwf	FSR0L
	movf	INDF0, w
	iorwf	tmp, w
	movwf	SSPBUF

	incf	bytecounter, f

	movf	fsrl, w
	movwf	FSR0L
	movf	fsrh, w
	movwf	FSR0H

	retfie	1

	end
