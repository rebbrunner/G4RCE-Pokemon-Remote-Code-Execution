.arch armv5te
.text
.code	32
.thumb
.global start

mon .req                   r0
param .req                 r1
val .req                   r2
base .req                  r3            
f_setMonData .req          r4

_start:
.code	16
.thumb_func

push {r1-r7, lr}

ldr base,_data
ldr base,[base]
ldr f_setMonData,_FUN_SetMonData
ldr r5,_monLoc
add mon,base,r5
ldrb param,_param
adr val,_val

blx f_setMonData

pop {r1-r7, pc}

.balign 4
_data:
.word 0x2111880             @ base address
_FUN_SetMonData:
.word 0x206ec41
_monLoc:
.word 0x194
_param:
.word 0x05
_val:
