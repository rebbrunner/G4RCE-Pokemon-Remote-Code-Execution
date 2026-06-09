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

mov temp,target
mov target,start
mov start,temp
bl calcImmediates
strh upper,[start,#0x2]
strh lower,[start,#0x4]

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
_payloadOffset:
.word 0x9F28
_hookStart:
.word 0x0023
_hookEnd:
.word 0x201c
