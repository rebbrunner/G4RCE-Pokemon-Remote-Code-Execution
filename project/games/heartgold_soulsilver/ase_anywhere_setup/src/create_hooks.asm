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

push {r0-r7}

@ load base, target, and hook locations
ldr base,_data
ldr base,[base]
ldrh target,_payloadOffset
ldr target,[base,target]
ldr start,_hookPoint

@ create hook
bl calcImmediates
str return,[start]

mov temp,target
mov target,start
mov start,temp
bl calcImmediates
str return,[target,#0x4]

b _end

calcImmediates:
@ calc offset
sub return,target,start
sub return,return,#0x4
asr return,target,#0x1

@ extract lower
mov lower,#0x7F
lsl lower,#0x8
add lower,#0xF
and lower,lower,return

@ extract upper
asr return,#0xb

@ add opcode lower
mov temp,#0xF8
lsl temp,#0x8
orr lower,lower,temp

@ add opcode upper
mov temp,#0xF0
lsl temp,#0x8
orr upper,upper,temp

@ flip endian
mov return,lower
bl byteFlip
mov lower,return
mov return,upper
bl byteFlip
mov upper,return

@ combine into single instruction
lsl return,upper,#0x10
add return,return,lower
bx lr

byteFlip:
mov temp,return
lsr temp,#0x8
lsl return,#0x18
lsr return,#0x10
orr return,return,temp
bx lr

_end:
pop {r0-r7}

.balign 4
_data:
.word 0x2111880
_hookPoint:
.word 0x020400d6
_payloadOffset:
.hword 0x9F28
