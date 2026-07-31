.arch armv5te
.text
.code	32
.arm
.global start

src .req                                    r0
target .req                                 r1
size .req                                   r2
base .req                                   r3

_start:
add r0,pc,#0x1
bx r0

.thumb
push {r0-r7}

adr src,_payload
ldr base,_data
ldr base,[base]
ldr target,_baseToTarget
add target,base,target
ldr size,_size
swi 0xB

_end:
pop {r0-r7}
mov r0,#0x1
pop {r4, pc}

.balign 4
_data:
.word 0x2111880                             @ base
_baseToTarget:
.word 0x9F04                                @ offset -> target
_size:
.word 0xF8                                  @ size

_payload:
