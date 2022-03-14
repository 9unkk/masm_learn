;程序名：T3-18.asm
;功能：依次重复寄存器AL中的每一位，得到16位的结果存放到DX寄存器中。

assume cs:code,ds:data

data segment
    x db 12h
    y dw ?
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    mov al,x
    mov bl,al
    xor ah,ah
    mov cl,8
    rol ax,cl

    add al,bl
    mov dx,ax

    mov ax,4c00h
    int 21h
code ends
end start