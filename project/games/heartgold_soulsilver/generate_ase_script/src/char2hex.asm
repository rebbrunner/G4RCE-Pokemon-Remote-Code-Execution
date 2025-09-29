.arch armv5te
.text
.code 16
.thumb
.global start

_start:
push {r0-r7, lr}

@ load data
add r3,#0x45
ldmia r3,{r0,r1,r2,r4,r5}
push {r2,r4,r5}
ldr r0,[r0]                      @ load base pointer
@ stack order: gift -> box name -> execution trigger

@ reset gift
pop {r2}                         @ stack: box name -> execution trigger
mov r5,#0x6
strb r5,[r0,r2]

_check_op_mode:
pop {r2}                         @ stack: execution trigger
add r4,r0,r2
ldrb r5,[r4]
cmp r5,#0x41
bne _trigger

_setup_write:
mov r5,#0x2
add r4,r4,r5
bl _decode
push {r5}
mov r5,#0x4
add r4,r4,r5
bl _decode
pop {r4}                        @ r4 = execution -> current write offset; r5 = size;

_write:
pop {r2}
b _end

_trigger:
pop {r2}                        @ stack fixed!
b _end

_decode:
ldrh r5,[r4]
ldrh r6,[r4,#0x2]
sub r5,r5,r1
sub r6,r6,r1
lsl r5,r5,#0x4
add r5,r5,r6
bx lr

_end:
pop {r0-r7, pc}

_data:
.word 0x2111880                 @ base pointer
.word 0x121                     @ character encoding value
.word 0x9E4C                    @ base -> gift offset
.word 0x21718                   @ base -> box name
.word 0x9999                    @ base -> execution spot
