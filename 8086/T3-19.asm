;程序名：T3-19.asm
;功能：依次重复四次寄存器AL中的每一位，得到32位的结果存放dx:ax寄存器中

assume cs:code,ds:data

data segment
    x db 12h
    y dd ?
data ends

code segment
    mov ax,data
    mov ds,ax

    mov al,x
    mov bl,al
    xor ah,ah
    mov cl,8
    rol ax,cl
    mov al,bl
    mov dx,ax

    mov word ptr y,ax
    mov word ptr y+2,dx

    mov ax,4c00h
    int 21h
code ends