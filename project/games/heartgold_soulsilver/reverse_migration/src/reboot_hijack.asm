.arch armv5te
.text
.code	16
.global start
_start:
push {r0-r7, lr}

@ copy payload to ununsed space
adr r0,_data
ldr r1,_dest
mov r2,#0x2
swi 0xb

@ rewire reboot to call function in unused space
ldr r0,_reboot_func
ldr r1,_rewire
str r1,[r0]

_end:
pop {r0-r7,pc}

.balign 4
_dest:
.word 0x23C0120
_reboot_func:
.word 0x1FF81D4
_rewire:
.word 0xeb0f1fd1
_data:
