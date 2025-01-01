.arch armv5te
.text
.code   16
.thumb
.global start

_start:
push {r1-r7, lr}

add r3, #0x?? => start of 'data'
ldmia r3, {r1, r2, r4, r5}
@ r1 = base address
@ r2 = end script
@ r4 = gift id offset
@ r5 = dot artist app offset

@ get base
ldr r1,[r1]

@ reset gift ID
mov r6,0x6
str r6, [r1, r4]

@ enable dots artist if needed
ldr r6, [r1, r5]
cmp r6, #0x1
beq _return

mov r6,#0x1
str r6,[r1,r5]

@ end script (no jump to dot artist)
blx r2

_return
pop {r1-r7, pc}

_data:
.word 0x02101D40                        @ base pointer
.word 0x0203E76D                        @ end script mode function
.hword 0xB5D4                           @ gift ID offset (assuming first gift slot)
.hword 0x1188                           @ dots artist enabled boolean