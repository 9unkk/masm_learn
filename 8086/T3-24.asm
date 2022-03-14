;程序名：T3-24.asm
;功能：把某个十进制数ASCII码串转换为对应的非压缩BCD和压缩BCD
assume cs:code,ds:data

data segment
    asc db '12'
    ybcd db 0
    nbcd dw 0
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov ax,word ptr asc[si]
    sub ax,3030h
    mov nbcd,ax
    xchg ah,al
    mov cl,4
    shl al,cl
    shr ax,cl
    mov ybcd,al
    ;
    mov ax,4c00h
    int 21h
code ends
end start