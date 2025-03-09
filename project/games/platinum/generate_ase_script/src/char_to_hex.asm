.arch armv5te
.text
.code   16
.thumb
.global start

_start:
push {r0-r7,lr}

@ load data
add r3,#0x31
ldrh r0,[r3]

mov r1,#0x4         @ Initial offset location
lsl r1,#0xC
add r2,r1,#0x1      @ Read location
ldrb r3,[r1]
add r3,r1,r3        @ Write location
mov r4,#0x4         @ Loop counter

_loop:
cmp r4,#0x0
beq _end
sub r4,r4,#0x1

ldrh r5,[r2]
ldrh r6,[r2,#0x2]
sub r5,r5,r0
sub r6,r6,r0
lsl r5,r5,#0x4
add r5,r5,r6
strb r5,[r3]
add r3,r3,#0x1
add r2,r2,#0x4
@b _loop

sub r3,r3,r1
strb r3,[r1]

_end:
pop {r0-r7,pc}

_data:
.hword 0x121
.hword 0x0
