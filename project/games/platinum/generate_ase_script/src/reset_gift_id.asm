.arch armv5te
.text
.code    16
.thumb
.global start

_start:
push {r0-r2, lr}

ldr r1,[pc,#0xC]
ldr r0,[r1]
ldr r2,[pc,#0xC]
mov r1,#0x0
str r1,[r0, r2]

pop {r0-r2, pc}

_data:
nop
.word 0x02101D40
.hword 0xB4F1
.hword 0x0
