.arch armv5te
.text
.code   16
.thumb
.global start

_start:
push {r1-r7, lr}

mov r2, #0x1F
ldrh r1, [r3, r2] @ r1 = diff gift id offset & dot artist offset 0xA44C

sub r3, #0x15
mov r2, #0x6
strb r2, [r3]

@ enable dots artist
sub r1, r3, r1
mov r2, #0x1
strb r2, [r1]

@ set ASE return point to dots artist
add r1, #0x14
str r1, [r0, #0x8]

@ write end to padding between dots artist and calendar app
mov r2, #0x2
add r1, #0x69
strb r2, [r1]

_return:
pop {r1-r7, pc}

_data:
@ .word 0x0203E76D                        @ end script mode function
.word 0xA44E                              @ diff gift id offset & dot artist offset 0xA44C