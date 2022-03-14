;程序名：T3-26.asm
;功能：把某个字变量的值转换为对应的二进制数ASII码串
assume cs:code,ds:data

data segment
 num dw 0ab12h
 string db 0,0,0,0
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov cl,4
loop0:
    xor ax,ax
    mov al,byte ptr num[bx]
    shl ax,cl
    shr al,cl
    cmp ax,0909h
    jbe number
    add al,37h
    add ah,37h
    jmp loop1
number:
    add al,30h
    add ah,30h
loop1:
    xchg ah,al
    mov word ptr string[di],ax
    add di,2
    inc bx
    cmp bx,2
    jnz loop0
    ;
    mov ax,4c00h
    int 21h
code ends
end start