.arch armv5te
.text
.code	32
.global start
_start:

push {lr}

ldr r0,_target
ldr r1,_rewire
str r1,[r0]

ldr r0,_hook
blx r0

pop {pc}

.balign 4
_hook:
.word 0x2000a1c
_target:
.word 0x2007878
_rewire:
.word 0xfc80f3b8
