.arch armv5te
.text
.code   16
.thumb
.global start

_start:
push {r0-r7,lr}

add r3,#0xE
ldmia r3,{r0,r1,r2}
ldr r0,[r0]
str r2,[r0,r1]

pop  {r0-r7, pc}

_data:
.word 0x02101D40                @ base pointer
.word 0x8c                      @ tid/sid offset
.word 0x00000000                @ id/sid
