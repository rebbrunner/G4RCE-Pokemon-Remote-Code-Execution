.arch armv5te
.text
.code	32
.thumb
.global start

base .req                           r0
src .req                            r1
dest .req                           r2
data .req                           r3

_start:
.code	16
.thumb_func

push {r0-r7,lr}

@ load base address
adr src,_data
ldr base,[src]
ldr base,[base]
add src,#0x4

_loop:
ldr dest,[src]
ldr data,[src,#0x4]
cmp dest,#0x0
beq _end

strh data,[dest]
add src,#0x8

b _loop

_end:
pop {r0-r7,pc}

.balign 4
_data:
.word 0x2111880                     @ base address

@ 280E0002 00000000
@ 46230002 00210000
@ EE020202 0C1C0000
@ F0020202 18480000
@ 1E030202 10BD0000
@ 20030202 2D3C0000
@ 22030202 E5E70000
@ 2E030202 DFD00000
@ 3A030202 F1E70000
@ 00000000
