;程序名：T3-3.asm
;功能：把压缩存放的 8421 BCD码，转换为对应十进制数字 ASCII 码的程序。
assume cs:code,ds:data

data segment
number db 12h
result db 0,0,'$'
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov al,number
    mov cl,4
    shr al,cl
    add al,30h
    mov result,al
    mov al,number
    and al,0fh
    add al,30h
    mov result+1,al
    ;
    mov dx,offset result
    mov ah,9
    int 21h
    ;
    mov ax,4c00h
    int 21h
code ends
end start