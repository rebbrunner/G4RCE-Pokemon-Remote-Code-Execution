.arch armv5te
.text
.code   32
.thumb
.global start

src             .req r0
dest            .req r1
size            .req r2
base            .req r3
offset          .req r4

_start:
.code   16
.thumb_func
push {r0-r7,lr}

@ read in base pointer, set src pointer to data location
ldr src, = _data
ldr base,[src]
ldr base,[base]
add src,#0x4

_loop:
ldrh offset, [src]
cmp offset, #0x0
beq _end

ldrh size,[src,#0x2]       @ r0 = src, r1 = dest, r2 = size -> copy data swi call
add dest,base,offset
add src,src,#0x4
swi 0xB
add src,src,size
b _loop

_end:
pop {r0-r7,pc}

.balign 4
_data:
.word 0x2111880             @ base address
