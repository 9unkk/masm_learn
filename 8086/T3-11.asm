;程序名：T3-11.asm
;功能：把一个16位二进制数转换为一个5位十进制数，并输出。

assume ds:data,cs:code

data segment
number dw 0ABCDh
result db 0,0,0,0,0,'$'
jm dw 10000,1000,100,10,1
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov ax,number
    mov bx,0
    push bx
    xor dx,dx
    xor si,si
    mov cx,4
    ;
    mov bx,jm[si]
    div bx
    add ax,30h
    pop bx
    mov result[bx],al
    add si,2
    inc bx
    push bx
divs:
    mov ax,dx
    xor dx,dx
    mov bx,jm[si]
    div bx
    add ax,30h
    pop bx
    mov result[bx],al
    add si,2
    inc bx
    push bx
    loop divs
    ;
    mov dx,offset result
    mov ah,9
    int 21h
    ;
    mov ax,4c00h
    int 21h
code ends
    end start