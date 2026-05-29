; EMAS buzzer - Bad Apple (out of tune and rythm, but outputting sound)

/*  
	LICENSE

    Copyright (C) 2026  Rościsław Szymański

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA. 
*/

	.cpu	mera400
	.include cpu.inc
	.include constants.inc

	uj	start



; Beep sequence data: frequency, beep_duration, silence_duration
; This is definitely not Bad Apple!! yet, but it has some slight similarities
sequences:
	.word	NOTE_D5_SHARP,	QUARTER,	REST_SHORT	; D#5
	.word	NOTE_F5,		QUARTER,	REST_SHORT	; F5
	.word	NOTE_F5_SHARP,	QUARTER,	REST_SHORT	; F#5
	.word	NOTE_G5_SHARP,	QUARTER,	REST_SHORT	; G#5
	.word	NOTE_A5_SHARP,	QUARTER,	REST_SHORT	; A#5
	.word	NOTE_C6,		QUARTER,	REST_SHORT	; C#6
	.word	NOTE_A5_SHARP,	QUARTER,	REST_SHORT	; A#5
	.word	NOTE_D5_SHARP,	QUARTER,	REST_SHORT	; D#5
	
	.word	NOTE_A5_SHARP,	QUARTER,	REST_SHORT	; A#5
	.word	NOTE_G5_SHARP,	QUARTER,	REST_SHORT	; G#5
	.word	NOTE_F5_SHARP,	QUARTER,	REST_SHORT	; F#5
	.word	NOTE_F5,		QUARTER,	REST_SHORT	; F5
	.word	NOTE_D5_SHARP,	QUARTER,	REST_SHORT	; D#5
	.word	NOTE_F5,		QUARTER,	REST_SHORT	; F5
	.word	NOTE_F5_SHARP,	QUARTER,	REST_SHORT	; F#5
	.word	NOTE_G5_SHARP,	QUARTER,	REST_SHORT	; G#5
	.word	NOTE_A5_SHARP,	QUARTER,	REST_SHORT	; A#5
	.word	NOTE_G5_SHARP,	QUARTER,	REST_SHORT	; G#5
	.word	NOTE_F5_SHARP,	QUARTER,	REST_SHORT	; F#5
	.word	NOTE_F5,		QUARTER,	REST_SHORT	; F5
	.word	NOTE_D5_SHARP,	QUARTER,	REST_SHORT	; D#5
	.word	NOTE_F5,		HALF,		REST_SHORT	; F5 (ending note)
	
	.word	0		; end marker

	.org	OS_START
start:
	lw	r5, sequences	; r5 = pointer to sequence data
	
main_loop:
	lw	r3, [r5]		; load frequency from sequence
	cw	r3, 0			; check for end marker
	je	done			; if end, exit
	
	awt	r5, 1			; move to beep_duration
	lw	r1, [r5]		; r1 = beep_duration
	
	awt	r5, 1			; move to silence_duration
	lw	r2, [r5]		; r2 = silence_duration
	
	awt	r5, 1			; move to next sequence entry
	
	; ===== PLAY BEEP =====
beep:
	lwt	r0, -1
	awt	r0, 1
	
	lw	r4, r3
	
transition_loop:
	awt	r0, 1
	drb	r4, transition_loop
	
	drb	r1, beep
	
	; ===== SILENCE =====
	lw	r6, r2
	
silence:
	nop
	irb	r6, silence
	
	ujs	main_loop
	
done:
	hlt
