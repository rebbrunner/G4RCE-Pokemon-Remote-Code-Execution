.arch armv5te
.text
.code	32
.thumb
.global start

_start:
.code	16
.thumb_func

@ r6 will contain script ID
push {r0-r7,lr}

nop
nop

@ if script = target script, hijack script context
mov r1,#0x22
mov r2,#0x66
lsl r1,#0x8
add r1,r1,r2
cmp r6,r1
bne _end

ldr r2,[r0,#0x10]       @ script pointer
ldr r2,_data
ldr r2,[r2]
ldr r1,_scriptPayloadOffset
add r1,r2,r1
add r0,#0x8
str r1,[r0]

_end:
pop {r0-r7,pc}

.balign 4
_data:
.word 0x2111880
_scriptPayloadOffset:
.word 0x9E5A
