@echo off

del hh.bin 2>nul

python compiler.py hh

..\retroassembler\retroassembler.exe hh.asm
