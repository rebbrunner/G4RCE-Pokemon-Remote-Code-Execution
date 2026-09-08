.arch armv5te
.text
.code	32
.global start
_start:

push {lr}

ldr r0,_first_call
blx r0

ldr r0,_target
ldr r1,_rewire
@str r1,[r0]

ldr r0,_second_call
blx r0

pop {pc}

.balign 4
_first_call:
.word 0x01ff82c8
_second_call:
.word 0x01ff81e8
_target:
.word 0x2007878
_rewire:
.word 0xfc6af3b8
