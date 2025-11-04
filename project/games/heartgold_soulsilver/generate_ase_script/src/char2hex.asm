.arch armv5te
.text
.code 16
.thumb
.global start

_start:
push {r0-r7, lr}

@ load data
add r3,#0x6F
ldmia r3,{r0,r1,r2,r4,r5}
push {r2,r4,r5}
ldr r0,[r0]                      @ load base pointer
@ stack order: gift -> box name -> execution trigger

@ reset gift
pop {r2}                         @ stack: box name -> execution trigger
mov r5,#0x6
strb r5,[r0,r2]

_check_op_mode:
pop {r2}                         @ stack: execution trigger
add r4,r0,r2
ldrb r5,[r4]
cmp r5,#0x41
bne _trigger

_setup_write:
add r4,r4,#0x2
bl _decode
mov r7,r5
add r4,r4,#0x4
bl _decode
pop {r2}                        
add r2,r2,r0                    @ r2 = location; r7 = size;
add r2,r2,r5
add r4,r4,#0xA

_write:
cmp r7,#0x0                     @ if size 0; end
beq _end
sub r7,r7,#0x1                  @ decrement loop counter (size)

add r4,r4,#0x18
mov r5,#0x5
push {r5}

_mini_loop:
pop {r5}
sub r5,r5,#0x1
cmp r5,#0x0
beq _write
push {r5}

bl _decode                      @ decode r4 command into r5 (destroys data in r6 as well)
strb r5,[r2]                      @ store value of r5 in location r2
add r4,r4,#0x4                  @ increment read location
add r2,r2,#0x1                  @ increment write location
b _mini_loop

pop {r2}
b _end

_trigger:
pop {r2}                        @ stack fixed!
add r1,r0,r2
blx r1
b _end

_decode:
ldrh r5,[r4]
ldrh r6,[r4,#0x2]
sub r5,r5,r1
sub r6,r6,r1
lsl r5,r5,#0x4
add r5,r5,r6
bx lr

_end:
pop {r0-r7, pc}

_data:
.word 0x2111880                 @ base pointer
.word 0x121                     @ character encoding value
.word 0x9E4C                    @ base -> gift offset
.word 0x21718                   @ base -> box name
.word 0x9ED8                    @ base -> execution spot

@ test payload
@ W0403 02 01
