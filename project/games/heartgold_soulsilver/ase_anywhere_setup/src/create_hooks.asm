.arch armv5te
.text
.code	32
.thumb
.global start

base .req                               r0
start .req                              r1
target .req                             r2
temp .req                               r3
return .req                             r4
lower .req                              r5
upper .req                              r6

_start:
.code	16
.thumb_func

push {r0-r7,lr}

@ switch menu for pokedex to retire
adr r0,FUN_handlePokedex
ldr r1,[r0]
add r0,#0x4
ldr r2,[r0]
str r2,[r1]
add r1,#0x4
add r0,#0x4
ldr r2,[r0]
str r2,[r1]

@ make retire call invalid script ID
adr r0,FUN_handleRetire
ldr r1,[r0]
add r0,#0x4
ldrh r2,[r0]
strh r2,[r1]
ldrh r2,[r0,#0x2]
strh r2,[r1,#0x2]
add r1,#0x6
add r0,#0x4
ldr r2,[r0]
str r2,[r1]

@ load base, target, and hook locations
ldr base,_data
ldr base,[base]
ldr target,_payloadOffset
add target,base,target
ldr start,_hookPoint

@ create hook
bl calcImmediates
strh upper,[start]
strh lower,[start,#0x2]

mov start,target
ldr target,_hookTo
add start,#0x2
bl calcImmediates
strh upper,[start]
strh lower,[start,#0x2]

b _end

calcImmediates:
@ calc offset
sub return,target,start
sub return,return,#0x4
asr return,#0x1

@ extract lower
mov temp,#0x7F
lsl temp,#0x4
add temp,#0xF
mov lower,temp
and lower,lower,return

@ extract upper
lsr upper,return,#0xb
and upper,upper,temp

@ add opcode lower
mov temp,#0xF8
lsl temp,#0x8
orr lower,lower,temp

@ add opcode upper
mov temp,#0xF0
lsl temp,#0x8
orr upper,upper,temp
bx lr

_end:
pop {r0-r7,pc}

.balign 4
_data:
.word 0x2111880
_hookPoint:
.word 0x020400d6
_hookTo:
.word 0x020400e8
_payloadOffset:
.word 0x9F04
_hookStart:
.word 0x0023
_hookEnd:
.word 0x201c

FUN_handlePokedex:
.word 0x203C8FC
.word 0xF000B500
.word 0xBD00FDC3

FUN_handleRetire:
.word 0x0203d4b6
.hword 0x21f0
.hword 0x0209
.word 0x310D0000
