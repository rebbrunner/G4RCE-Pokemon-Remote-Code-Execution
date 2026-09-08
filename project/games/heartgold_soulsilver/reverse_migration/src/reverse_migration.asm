.arch armv5te
.text
.code	16
.global start
_start:
push {r0-r7, lr}

@ only check for one pokemon
mov r0,#0x1
ldr r1,_num_checks_loc
strb r0,[r1]

@ which pokemon to copy over
ldr r0,_poke_id
ldr r1,_poke_id_loc
strh r0,[r1]

_end:
pop {r0-r7,pc}

.balign 4
_data:
.word 0x2111880               @ base
_num_checks_loc:
.word 0x2233614               @ how many pokemon to check for
_poke_id_loc:
.word 0x2231976               @ which pokemon to copy over
_poke_id:
.word 0x96                    @ Mew
