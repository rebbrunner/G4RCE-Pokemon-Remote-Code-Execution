.arch armv5te
.text
.code 16
.thumb
.global start

_start:
push {r0-r7,lr}

@ load base pointer
add r3,#0xDC
ldr r0,[r3,#0x0]
ldr r0,[r0]                     @ loaded base poniter

@ Reset gift - o
ldr r1,[r3,#0x4]                @ gift location
mov r2,#0x6
strb r2,[r0,r1]

@ Setup NPC ASE - o
ldr r1,[r3,#0x8]                @ NPC location
ldrh r2,[r3,#0xC]
strh r2,[r0,r1]

@ Check OP mode - o
ldr r1,[r3,#0x10]
ldrb r2,[r0,r1]
cmp r2,#0x2B
bne _WRITER

@ ASE mod - o
ldr r1,[r3,#0x14]               @ base -> execution spot (-)
ldr r2,[r3,#0x18]               @ base -> ASE return point
add r1,r0,r1
str r1,[r0,r2]
b _end

_WRITER:
ldr r4,[r3,#0x1C]
add r1,r1,#0x2
bl _decode
mov r7,r5
add r1,r1,#0x4
bl _decode
ldr r2,[r3,#0x14]                        
add r2,r2,r0                    @ r2 = location; r7 = size;
add r2,r2,r5
add r1,r1,#0xA

_write:
cmp r7,#0x0                     @ if size 0; end
beq _p_end
sub r7,r7,#0x1                  @ decrement loop counter (size)

add r1,r1,#0x18
mov r5,#0x5
push {r5}

_mini_loop:
pop {r5}
sub r5,r5,#0x1
cmp r5,#0x0
beq _write
push {r5}

bl _decode                      @ decode r4 command into r5 (destroys data in r6 as well)
strb r5,[r2]                      @ store value of r5 in location r2
add r1,r1,#0x4                  @ increment read location
add r2,r2,#0x1                  @ increment write location
b _mini_loop

_decode:
ldrh r5,[r1]
ldrh r6,[r1,#0x2]
sub r5,r5,r4
sub r6,r6,r4
lsl r5,r5,#0x4
add r5,r5,r6
bx lr

_p_end:
pop {r2}
b _end

_end:
pop {r0-r7,pc}

_data:
nop                             @ odd needs nop, even no nop
.word 0x2111880                 @ base pointer
.word 0x9E4C                    @ base -> gift offset
.word 0x26250                   @ base -> NPC script offset
.word 0x9C9C                    @ NPC script offset -> nickname
.word 0x21718                   @ base -> box name
.word 0x4548                    @ base -> execution spot (-)
.word 0x2AA50                   @ base -> ASE return point
.word 0x121                     @ character encoding value

@ W0403 02 01
