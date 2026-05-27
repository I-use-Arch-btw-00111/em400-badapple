# Bad Apple!! on MERA-400

This repository will contain the code that is an effort to play **Bad Apple!!** on the MERA-400 emulator (em400 by Jakub Filipowicz).

The target language is **EMAS**, the modern cross-assembler for MERA-400 and em400.

## Project Stages

The project is to be executed in THREE stages:

### Stage A (for Audio)
In this stage:
* An accurate method to generate tones with proper frequencies on emulated Tonsil GD 6/0,5 speaker (that is, the operator panel buzzer) is to be found.
* A code-efficient way to encode note lengths, their frequencies, and the duration of pauses (compliant with theory of music) is to be determined.
* A template (preferably in Python3) to convert written note sequences (not only Bad Apple!!) to EMAS routines shall be made.

### Stage V (for Video)
In this stage:
* A proper terminal protocol and character resolution for playing Bad Apple in form of ASCII animation at reasonable frame rate should be determined (we are restrained by the 9600 baud rate).
* A proper frame-differencing algorithm should be made (we emulate a 1980s minicomputer, not a 2020s supercomputer. The memory is a precious resource and it's easy to exhaust our amount of it).
* A proper I/O routine in EMAS should be use to send the data into the terminal.

### Stage I (for Integration)
In this stage:
* A way to integrate logic from stages A and V into coherent program that does correctly play A/V using emulated hardware should be determined.

---

### Links to useful knowledge from a MERA-400 sorcerer

* https://mera400.pl/Lista_rozkaz%C3%B3w (a wiki article with details on MERA-400 instruction set and list of mnemonics)
* https://mera400.pl/EMAS (a wiki article with informations about EMAS cross-assembler)
* https://github.com/jakubfi/em400/tree/master (master branch of the em400 emulator source code)

---

## Contributing 

Usage of LLMs for assembly writing is not disallowed (my initial efforts were created with Copilot, and I am trying not to be a hypocrite), but it should be done with care. 

**Be advised that MERA-400 is neither x86, nor ARM, nor RISC, nor any other modern arch.** If you want to contribute (which would be appreciated), be prepared for quirky debugging.

---

## Special thanks

* Shout-out to Jakub Filipowicz for making the MERA-400 YouTube channel, writing the emulator, and making be discover the charm of old technology

---
Thank you very much,

*Rościsław Szymański*
