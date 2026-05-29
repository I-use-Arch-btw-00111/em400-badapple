; notes and rests - assembly constants

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
;			Using the RTC interrupt generator (5th bit on RZ register, apparently - according to DTR) could help control the durations in a deterministic manner.
;			According to DTR, the clock can fire an interrupt every 20, 10, 8, 4 or 2 miliseconds - for best precision, I guess 2 miliseconds should be used.
;			That is to be configured within em400 config file, probably with "clock_period = 2" in "[cpu]" block. To be consulted. 
;			Probably one of registers could serve as a counter that would count the interrupts and thus allow for emiting tone with duration precision of ~2 ms

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
