.arch armv5te
.text
.code	16
.global start
_start:
push {r0-r1}

@ only check for one pokemon
mov r0,#0x1
ldr r1,_num_checks_loc
strb r0,[r1]

@ which pokemon to copy over
adr r0,_poke_id
ldr r1,_poke_id_loc
ldrh r2,[r0]
strh r2,[r1]
ldrh r2,[r0,#0x2]
strh r2,[r1,#0x2]
ldrh r2,[r0,#0x4]
strh r2,[r1,#0x4]

_end:
pop {r0-r1}
pop {r3-r7,pc}

.balign 4
_num_checks_loc:
.word 0x2233614               @ how many pokemon to check for
_poke_id_loc:
.word 0x022319ae
_poke_id:
.hword 0x2500
.hword 0x022D
.hword 0x3597                 @ Mew
