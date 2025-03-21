.arch armv5te
.text
.code 16
.thumb
.global start

_start:
push {r0-r7, lr}

@ load data
add r3,#0x3D
ldr r0,[r3]
ldr r0,[r0]
ldrh r4,[r3,#0x4]
ldrh r1,[r3,#0x6]
add r0,r0,r4

ldrb r2,[r0]                        @ r2 = read -> write offset
add r3,r0,#0x2                      @ r3 = read location
add r4,r2,r0                        @ r4 = write location
mov r5,#0x4                         @ r5 = loop counter

_loop:
cmp r5,#0x0
beq _end
sub r5,r5,#0x1

ldrh r6,[r3]
ldrh r7,[r3,#0x2]
sub r6,r6,r1
sub r7,r7,r1
lsl r6,r6,#0x4
add r6,r6,r7
strb r6,[r4]
add r3,r3,#0x4
add r4,r4,#0x1
b _loop

sub r1,r4,r0
ldrb r2,[r0]
add r1,r2,r1
strb r1,[r0]

_end:
pop {r0-r7, pc}

_data:
nop
.word 0x2101D40                     @ base pointer
.hword 0x5BCB                       @ base -> player signature offset
.hword 0x121
