;程序名：T3-9.asm
;功能：求内存中从地址 0040:0000H 开始的 1024 个字的字校验和。
assume cs:code,ds:data

data segment
sum dw 0
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov ax,0040h
    mov es,ax
    ;
    xor ax,ax
    mov cx,1024
summer:
    add ax,es:[si]
    add si,2
    loop summer
    mov sum,ax
    mov ax,4c00h
    int 21h
code ends
end start