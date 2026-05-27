; EMAS buzzer - Bad Apple (out of tune and rythm, but outputting sound)

	.cpu	mera400
	.include cpu.inc

	uj	start

; Note period mapped to buzzer values
; Formula: frequency_value = 10094 / desired_Hz (possibly, needs verification)
; These were supposed to be frequencies, but upon inspection they more like periodic times.
; Calibration constant: 10094
.const NOTE_A4		10		; 980 Hz (measured: 980)
.const NOTE_G4_SHARP	11		; ~917 Hz
.const NOTE_B4		17		; ~594 Hz
.const NOTE_C5		19		; ~531 Hz
.const NOTE_D5		16		; ~631 Hz
.const NOTE_E5		15		; ~673 Hz
.const NOTE_G5		13		; ~776 Hz

.const NOTE_D5_SHARP	16		; 654.7 Hz (measured)
.const NOTE_F5		14		; 736.8 Hz (measured)
.const NOTE_F5_SHARP	13		; 786.5 Hz (measured)
.const NOTE_G5_SHARP	12		; 842.5 Hz (measured)
.const NOTE_A5_SHARP	11		; 907.8 Hz (measured)
.const NOTE_C6		9		; 1073.5 Hz (measured)

; Note durations
; WARN: 	The durations are problematic because when we use CPU operations for both tune frequency and length, these two variables affect each other!
;		Also, mind the fact that MERA-400 is asynchronous, so it is easy to make it go out of tune and rythm.
;		Since recently, some sort of Amepol real-time clock emulation was added, maybe it could be used to control the durations in a more deterministic manner.
.const WHOLE		13104
.const HALF		6552
.const QUARTER		3276
.const EIGHTH		1638
.const SIXTEENTH	819

; Rest durations
.const REST_WHOLE	13104
.const REST_HALF	6552
.const REST_QUARTER	3276
.const REST_EIGHTH	1638
.const REST_SIXTEENTH	819
.const REST_SHORT	500

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
