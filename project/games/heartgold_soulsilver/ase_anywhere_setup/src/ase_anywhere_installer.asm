.arch armv5te
.text
.code	32
.thumb
.global start

src .req                                    r0
target .req                                 r1
size .req                                   r2
base .req                                   r3
data .req                                   r4

_start:
.code	16
.thumb_func
push {r0-r7,lr}

adr r0,_data
ldmia r0,{r1-r4}
ldr base,[base]
add target,base,target
swi 0xB

_end:
pop {r0-r7,pc}

.balign 4
_data:
.word 0x2111880                             @ base
.word 0x23AB000                             @ src
.word 0x9EEC                                @ offset -> target
.word 0x99                                  @ size
