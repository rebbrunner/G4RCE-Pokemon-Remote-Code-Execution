.arch armv5te
.text
.code 16
.thumb
.global start

r_address .req r0
r_tidsid .req r1

_start:
push {r0-r7,lr}

ldr r_address,_data
ldr r_address,[r_address]
ldr r_tidsid,tidsid
mov r2,#0x84
str r_tidsid,[r_address,r2]

pop {r0-r7, pc}

.balign 4
_data:
.word 0x02111880
tidsid:
.word 0x00000000
