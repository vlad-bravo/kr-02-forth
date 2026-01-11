; Форт

.target "8080"
.format "bin"
.org 0x0000

   jmp start

l340E: .word 0x0000
l3412: .word 0x0000
l341e: .word 0x0000
l3442: .word 0x0000

start:

_HH:
   call _FCALL
   .word __28_22_29   ; (")
   .byte 12,"HELLO, HABR!"
   .word _COUNT
   .word _TYPE
   .word _EXIT

_FCALL:
   lhld l341e    ; $02e4 2a 1e 34
   dcx h         ; $02e7 2b      
   mov m,b       ; $02e8 70      
   dcx h         ; $02e9 2b      
   mov m,c       ; $02ea 71      
   shld l341e    ; $02eb 22 1e 34
   pop b         ; $02ee c1      
l02ef:
   ldax b        ; $02ef 0a      
   mov l,a       ; $02f0 6f      
   inx b         ; $02f1 03      
   ldax b        ; $02f2 0a      
   mov h,a       ; $02f3 67      
   inx b         ; $02f4 03      
   pchl          ; $02f5 e9      

__28_22_29:      ; (")
   push b        ; $0a53 c5      
   ldax b        ; $0a54 0a      
   mov l,a       ; $0a55 6f      
   mvi h,$00     ; $0a56 26 00   
   inx h         ; $0a58 23      
   dad b         ; $0a59 09      
   mov b,h       ; $0a5a 44      
   mov c,l       ; $0a5b 4d      
   jmp l02ef     ; $0a5c c3 ef 02

_COUNT:          ; 0F6F
   pop h         ; $0f6f e1      
   mvi d,$00     ; $0f70 16 00   
   mov e,m       ; $0f72 5e      
   inx h         ; $0f73 23      
   push h        ; $0f74 e5      
   push d        ; $0f75 d5      
   jmp l02ef     ; $0f76 c3 ef 02

_TYPE:           ; 157E - 15A7
   call _FCALL
   .word _LIT             ; 1581 0A2B - LIT
   .word l3412            ; 1583 3412
   .word __40             ; 1585 0984 - @
   .word __3FDUP          ; 1587 03E0 - ?DUP
   .word __3FBRANCH       ; 1589 0A7A - ?BRANCH
   .word l1591            ; 158B 1591
   .word _EXECUTE         ; 158D 032C - EXECUTE
   .word _EXIT            ; 158F 0315 - EXIT
l1591:
   .word _0               ; 1591 0EC8 - 0
   .word __28_3FDO_29     ; 1593 0B0C - (?DO)
   .word l15A3            ; 1595 15A3
l1597:
   .word _DUP             ; 1597 03D3 - DUP
   .word _C_40            ; 1599 0991 - C@
   .word _EMIT            ; 159B 153D - EMIT
   .word _1_2B            ; 159D 0477 - 1+
   .word __28LOOP_29      ; 159F 0B2E - (LOOP)
   .word l1597            ; 15A1 1597
l15A3:
   .word _DROP            ; 15A3 0382 - DROP
   .word _EXIT            ; 15A5 0315 - EXIT

_EXIT:           ; 0315
   lhld l341e    ; $0315 2a 1e 34
   mov c,m       ; $0318 4e      
   inx h         ; $0319 23      
   mov b,m       ; $031a 46      
   inx h         ; $031b 23      
   shld l341e    ; $031c 22 1e 34
   jmp l02ef     ; $031f c3 ef 02

_LIT:            ; 0A2B
   ldax b        ; $0a2b 0a      
   mov l,a       ; $0a2c 6f      
   inx b         ; $0a2d 03      
   ldax b        ; $0a2e 0a      
   mov h,a       ; $0a2f 67      
   inx b         ; $0a30 03      
   push h        ; $0a31 e5      
   jmp l02ef     ; $0a32 c3 ef 02

l0984:
__40:            ; @
   pop h         ; $0984 e1      
   mov e,m       ; $0985 5e      
   inx h         ; $0986 23      
   mov d,m       ; $0987 56      
   push d        ; $0988 d5      
   jmp l02ef     ; $0989 c3 ef 02

__3FDUP:         ; ?DUP
   pop h
   push h        ; $03e1 e5      
   mov a,h       ; $03e2 7c      
   ora l         ; $03e3 b5      
   jz l02ef      ; $03e4 ca ef 02
   push h        ; $03e7 e5      
   jmp l02ef     ; $03e8 c3 ef 02

_BRANCH:         ; BRANCH
   mov h,b       ; $0a68 60      
   mov l,c       ; $0a69 69      
   mov c,m       ; $0a6a 4e      
   inx h         ; $0a6b 23      
   mov b,m       ; $0a6c 46      
   jmp l02ef     ; $0a6d c3 ef 02

__3FBRANCH:      ; ?BRANCH
   pop d         ; $0a7a d1      
   mov a,d       ; $0a7b 7a      
   ora e         ; $0a7c b3      
   jz _BRANCH    ; $0a7d ca 68 0a
   inx b         ; $0a80 03      
   inx b         ; $0a81 03      
   jmp l02ef     ; $0a82 c3 ef 02

_EXECUTE:        ; 032C
   ret           ; $032c c9      

_0:              ; 0EC8 - 0ECD
   call __40
   .word $0000

__28DO_29:       ; (DO)
   pop h         ; e1
   xthl          ; $0ae6 e3      
   push h        ; $0ae7 e5      
   lhld l341e    ; $0ae8 2a 1e 34
   ldax b        ; $0aeb 0a      
   mov d,a       ; $0aec 57      
   inx b         ; $0aed 03      
   ldax b        ; $0aee 0a      
   inx b         ; $0aef 03      
   dcx h         ; $0af0 2b      
   mov m,a       ; $0af1 77      
   dcx h         ; $0af2 2b      
   mov m,d       ; $0af3 72      
   pop d         ; $0af4 d1      
   dcx h         ; $0af5 2b      
   mov m,d       ; $0af6 72      
   dcx h         ; $0af7 2b      
   mov m,e       ; $0af8 73      
   pop d         ; $0af9 d1      
   dcx h         ; $0afa 2b      
   mov m,d       ; $0afb 72      
   dcx h         ; $0afc 2b      
   mov m,e       ; $0afd 73      
   shld l341e    ; $0afe 22 1e 34
   jmp l02ef     ; $0b01 c3 ef 02

__28_3FDO_29:    ; (?DO)
   pop h         ; $0b0c e1      
   pop d         ; $0b0d d1      
   push d        ; $0b0e d5      
   push h        ; $0b0f e5      
   mov a,l       ; $0b10 7d      
   cmp e         ; $0b11 bb      
   jnz __28DO_29 ; $0b12 c2 e5 0a
   mov a,h       ; $0b15 7c      
   cmp d         ; $0b16 ba      
   jnz __28DO_29 ; $0b17 c2 e5 0a
   ldax b        ; $0b1a 0a      
   mov d,a       ; $0b1b 57      
   inx b         ; $0b1c 03      
   ldax b        ; $0b1d 0a      
   mov b,a       ; $0b1e 47      
   mov c,d       ; $0b1f 4a      
   pop h         ; $0b20 e1      
   pop h         ; $0b21 e1      
   jmp l02ef     ; $0b22 c3 ef 02

_DUP:            ; DUP
   pop h         ; $03d3 e1      
   push h        ; $03d4 e5      
   push h        ; $03d5 e5      
   jmp l02ef     ; $03d6 c3 ef 02

_C_40:           ; C@
   pop h         ; $0991 e1      
   mov e,m       ; $0992 5e      
   mvi d,$00     ; $0993 16 00   
   push d        ; $0995 d5      
   jmp l02ef     ; $0996 c3 ef 02

_EMIT:           ; 153D - 154E
   call _FCALL
   .word _LIT             ; 1540 0A2B - LIT
   .word l340E            ; 1542 340E
   .word __40             ; 1544 0984 - @
   .word _EXECUTE         ; 1546 032C - EXECUTE
   .word __3EOUT          ; 1548 02A6 - >OUT
   .word _1_2B_21         ; 154A 0A0A - 1+!
   .word _EXIT            ; 154C 0315 - EXIT

_1_2B:             ; 1+
   pop h         ; $0477 e1      
   inx h         ; $0478 23      
   push h        ; $0479 e5      
   jmp l02ef     ; $047a c3 ef 02

__28LOOP_29:     ; (LOOP)
   lhld l341e    ; $0b2e 2a 1e 34
   mov e,m       ; $0b31 5e      
   inx h         ; $0b32 23      
   mov d,m       ; $0b33 56      
   inx h         ; $0b34 23      
   inx d         ; $0b35 13      
   mov a,m       ; $0b36 7e      
   inx h         ; $0b37 23      
   cmp e         ; $0b38 bb      
   jnz l0b4c     ; $0b39 c2 4c 0b
   mov a,m       ; $0b3c 7e      
   cmp d         ; $0b3d ba      
   jnz l0b4c     ; $0b3e c2 4c 0b
   inx h         ; $0b41 23      
   inx h         ; $0b42 23      
   inx h         ; $0b43 23      
   shld l341e    ; $0b44 22 1e 34
   inx b         ; $0b47 03      
   inx b         ; $0b48 03      
   jmp l02ef     ; $0b49 c3 ef 02
l0b4c:
   dcx h         ; $0b4c 2b      
   dcx h         ; $0b4d 2b      
   mov m,d       ; $0b4e 72      
   dcx h         ; $0b4f 2b      
   mov m,e       ; $0b50 73      
   mov h,b       ; $0b51 60      
   mov l,c       ; $0b52 69      
   mov c,m       ; $0b53 4e      
   inx h         ; $0b54 23      
   mov b,m       ; $0b55 46      
   jmp l02ef     ; $0b56 c3 ef 02

_DROP:           ; 0382
   pop h         ; $0382 e1      
   jmp l02ef     ; $0383 c3 ef 02

__3EOUT:         ; >OUT
   call l0984    ; $02a6 cd 84 09
   .word l3442   ; $02a9 42      

_1_2B_21:        ; 1+!
   pop h         ; $0a0a e1      
   inr m         ; $0a0b 34      
   jnz l02ef     ; $0a0c c2 ef 02
   inx h         ; $0a0f 23      
   inr m         ; $0a10 34      
   jmp l02ef     ; $0a11 c3 ef 02

.end
