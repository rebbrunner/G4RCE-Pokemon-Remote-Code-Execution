.arch armv5te
.text
.code	32
.global start
_start:
push {r0-r2}

@ copy payload to ununsed space
adr r0,_data
ldr r1,_dest
mov r2,#0x40
swi 0xb

@ rewire reboot to call function in unused space
ldr r0,_reboot_func
ldr r1,_rewire
str r1,[r0]

_end:
pop {r0-r2}

mov r0,#0x1
pop {r4,pc}

.balign 4
_dest:
.word 0x23C0120
_reboot_func:
.word 0x1FF81D4
_rewire:
.word 0xeb0f1fd1
_data:
