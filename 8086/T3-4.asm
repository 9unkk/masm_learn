;程序名：T3-4.asm
;功能：把 16 进制数转换成七段数码管并输出
assume cs:code,ds:data

data segment
tab db 1000000B,1111001B,0100100B,0110000B,0011001B,0010010B,0000010B,1111000B,00000000B,0010000B,0001000B,0000011B,1000110B,0100001B,0000110B,0001110B
number db 0
result db 0
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    xor bx,bx
    mov bx,number
    ;
    mov dl,tab[bx]
    mov ah,2
    int 21h
    ;
    mov ax,4c00h
    int 21h

code ends
    end start