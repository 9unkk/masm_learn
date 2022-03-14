;程序名：T3-25.asm
;功能：把寄存器AL和BL中的位依次交叉，得到的16位结果存放在DX寄存器中

assume cs:code,ds:data

data segment
    one db 0aah
    two db 55h
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    xor ax,ax
    xor bx,bx
    mov al,one
    mov bl,two
reset:
    mov cx,4
    cmp bl,0
    jz stop
loop1:
    rol ax,1
    rol ah,1
    dec cx
    cmp cx,2
    ja loop1
    rol bx,1
    rol bh,1
    cmp cx,0
    jnz loop1
    rol bx,1
    or ah,bh
    mov dh,ah
    xchg dh,dl
    xor ah,ah
    xor bh,bh
    jmp reset
stop:
    mov ax,4c00h
    int 21h
code ends
end start

算法
ax=0000 0000 1234 5678

 rol ax,1   ax=0000 0001 2345 6780
 rol ah,1   ax=0000 0010 2345 6780
 rol ax,1   ax=0000 0102 3456 7800
 rol ah,1   ax=0000 1020 3456 7800
 rol ax,1   ax=0001 0203 4567 8000
 rol ah,1   ax=0010 2030 4567 8000
 rol ax,1   ax=0102 0304 5678 0000
 rol ah,1   ax=1020 3040 5678 0000


bx=0000 0000 abcd efgh
 rol bx,1   bx=0000 000a bcde fgh0
 rol bh,1   bx=0000 00a0 bcde fgh0
 rol bx,1   bx=0000 0a0b cdef gh00
 rol bh,1   bx=0000 a0b0 cdef gh00
 rol bx,1   bx=000a 0b0c defg h000
 rol bh,1   bx=00a0 b0c0 defg h000
 rol bx,1   bx=0a0b 0c0d efgh 0000   0001 0001


ah+bh=1020 3040+0a0b 0c0d

xchg（交换规则）
dh:dl=1234:0000
dh:dl=0000:1234
dh:dl=5678:1234
dh:dl=1234:5678

al=AA
+
bl=55
---------
1$0$ 1$0$
$0$1 $0$1
---------
1001 1001

ax=0254
ax=08A8
bx=00AA
ax=2250
bx=0254
ax=88A0
bx=08A8
bx=1150