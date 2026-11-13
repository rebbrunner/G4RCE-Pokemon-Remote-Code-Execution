@ When called, installs speedup code to freespace then jumps to it

.arch armv5te
.text
.code	16
.global start
.thumb
_start:

push {r0-r2,lr}

@ copy payload to ununsed space
adr r0,_data
ldr r1,_dest
mov r2,#0x68
swi 0xb

blx r1

_end:
pop {r0-r2,pc}

.balign 4
_dest:
.word 0x23C0120
_data:
