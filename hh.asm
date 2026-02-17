; Форт

.target "8080"
.format "bin"
.org 0x0000

   jmp start

ptr_EMIT: .word __28EMIT_29
ptr_TYPE: .word 0x0000
ptr_RP:   .word 0x3000  ; r-stack
ptr_OUT:  .word 0x3002

start:
   lxi b,_START
   jmp _FNEXT

_START:
   .word _MAIN, _BYE

_MAIN:
   call _FCALL
   .word __28_22_29   ; (")
   .byte 12,"HELLO, HABR!"
   .word _COUNT, _TYPE, _EXIT

_FCALL:
   lhld ptr_RP
   dcx h
   mov m,b
   dcx h
   mov m,c
   shld ptr_RP
   pop b
_FNEXT:
   ldax b
   mov l,a
   inx b
   ldax b
   mov h,a
   inx b
   pchl

_EXIT:
   lhld ptr_RP
   mov c,m
   inx h
   mov b,m
   inx h
   shld ptr_RP
   jmp _FNEXT

__28_22_29:      ; (")
   push b
   ldax b
   mov l,a
   mvi h,$00
   inx h
   dad b
   mov b,h
   mov c,l
   jmp _FNEXT

_COUNT:
   pop h
   mvi d,$00
   mov e,m
   inx h
   push h
   push d
   jmp _FNEXT

_TYPE:
   call _FCALL
   .word _LIT,ptr_TYPE         ; LIT,ptr_TYPE
   .word __40               ; @
   .word __3FDUP            ; ?DUP
   .word __3FBRANCH,l1591   ; ?BRANCH,l1591
   .word _EXECUTE           ; EXECUTE
   .word _EXIT              ; EXIT
l1591:
   .word _0                 ; 0
   .word __28_3FDO_29,l15A3 ; (?DO),l15A3
l1597:
   .word _DUP               ; DUP
   .word _C_40              ; C@
   .word _EMIT              ; EMIT
   .word _1_2B              ; 1+
   .word __28LOOP_29,l1597  ; (LOOP),l1597
l15A3:
   .word _DROP              ; DROP
   .word _EXIT              ; EXIT

_BYE:
   call _FCALL
   .word _LIT, $F800, _EXECUTE, _EXIT

_LIT:
   ldax b
   mov l,a
   inx b
   ldax b
   mov h,a
   inx b
   push h
   jmp _FNEXT

__40:            ; @
   pop h
   mov e,m
   inx h
   mov d,m
   push d
   jmp _FNEXT

__3FDUP:         ; ?DUP
   pop h
   push h
   mov a,h
   ora l
   jz _FNEXT
   push h
   jmp _FNEXT

_BRANCH:
   mov h,b
   mov l,c
   mov c,m
   inx h
   mov b,m
   jmp _FNEXT

__3FBRANCH:      ; ?BRANCH
   pop d
   mov a,d
   ora e
   jz _BRANCH
   inx b
   inx b
   jmp _FNEXT

_EXECUTE:
   ret

_0:
   call __40
   .word $0000

__28DO_29:       ; (DO)
   pop h
   xthl
   push h
   lhld ptr_RP
   ldax b
   mov d,a
   inx b
   ldax b
   inx b
   dcx h
   mov m,a
   dcx h
   mov m,d
   pop d
   dcx h
   mov m,d
   dcx h
   mov m,e
   pop d
   dcx h
   mov m,d
   dcx h
   mov m,e
   shld ptr_RP
   jmp _FNEXT

__28_3FDO_29:    ; (?DO)
   pop h
   pop d
   push d
   push h
   mov a,l
   cmp e
   jnz __28DO_29 ; (DO)
   mov a,h
   cmp d
   jnz __28DO_29 ; (DO)
   ldax b
   mov d,a
   inx b
   ldax b
   mov b,a
   mov c,d
   pop h
   pop h
   jmp _FNEXT

_DUP:
   pop h
   push h
   push h
   jmp _FNEXT

_C_40:           ; C@
   pop h
   mov e,m
   mvi d,$00
   push d
   jmp _FNEXT

_EMIT:
   call _FCALL
   .word _LIT             ; LIT
   .word ptr_EMIT         ; ptr(EMIT)
   .word __40             ; @
   .word _EXECUTE         ; EXECUTE
   .word __3EOUT          ; >OUT
   .word _1_2B_21         ; 1+!
   .word _EXIT            ; EXIT

_1_2B:             ; 1+
   pop h
   inx h
   push h
   jmp _FNEXT

__28LOOP_29:     ; (LOOP)
   lhld ptr_RP
   mov e,m
   inx h
   mov d,m
   inx h
   inx d
   mov a,m
   inx h
   cmp e
   jnz l0b4c
   mov a,m
   cmp d
   jnz l0b4c
   inx h
   inx h
   inx h
   shld ptr_RP
   inx b
   inx b
   jmp _FNEXT
l0b4c:
   dcx h
   dcx h
   mov m,d
   dcx h
   mov m,e
   mov h,b
   mov l,c
   mov c,m
   inx h
   mov b,m
   jmp _FNEXT

_DROP:
   pop h
   jmp _FNEXT

__3EOUT:         ; >OUT
   call __40
   .word ptr_OUT

_1_2B_21:        ; 1+!
   pop h
   inr m
   jnz _FNEXT
   inx h
   inr m
   jmp _FNEXT

__28EMIT_29:         ; (EMIT)
   pop h
   push b
   mov c,l
   call $f809
   pop b
   jmp _FNEXT

.end
