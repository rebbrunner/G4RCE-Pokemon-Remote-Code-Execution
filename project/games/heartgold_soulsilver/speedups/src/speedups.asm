.arch armv5te
.text
.code	16
.thumb
.global start

base .req                           r0
src .req                            r1
dest .req                           r2
data .req                           r3

_start:

push {r0-r7}

@ load base address
adr src,_data
ldr base,[src]
ldr base,[base]

@ check if in battle
ldr dest,_inBattleCheckLoc
ldrh dest,[dest]
ldr data,_inBattleVal
ldr src,_capLoc
cmp dest,data
beq _uncapOn
b _uncapOff

_uncapOff:

ldr data,_uncapOffVal

@ Check if value is on already, otherwise skip
ldrh r4,[src]
cmp r4,data
beq _copySpeedups

strh data,[src]

b _copySpeedups

_uncapOn:
ldr data,_uncapOnVal

@ Check if value is off already, otherwise skip
ldrh r4,[src]
cmp r4,#0x0
beq _copySpeedups

strh data,[src]

_copySpeedups:
adr src,_instantTextAndHP

_loop:
ldr dest,[src]
ldr data,[src,#0x4]
cmp dest,#0x0
beq _end

strh data,[dest]
add src,#0x8

b _loop

_end:
pop {r0-r7}
pop {r3,r4,r5,r6,r7,pc}

.balign 4
_data:
.word 0x2111880                     @ base address

_inBattleCheckLoc:
.word 0x2247612
_capLoc:
.word 0x2000E28
_uncapOffVal:
.word 0x6325
_uncapOnVal:
.word 0x0000
_inBattleVal:
.word 0x2801

_instantTextAndHP:
@ 805A2602 201C0000
@ 8E5A2602 201C0000
@ 50170802 211C0000
@ 46230002 00210000
@ EE020202 0C1C0000
@ F0020202 18480000
@ 1E030202 10BD0000
@ 20030202 2D3C0000
@ 22030202 E5E70000
@ 2E030202 DFD00000
@ 3A030202 F1E70000
@ 00000000
