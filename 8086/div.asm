;程序名：div.asm
;功能：除法运算
;=================================
assume cs:code,ds:data

data segment
val1 db 2
val2 db 9
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov al,val1
    mov bl,val2
    xor ah,ah
    div bl
    ;
    mov ax,-1
    xor dx,dx
    mov bx,word ptr val1
    div bx
    ;
    mov ax,-1
    cwd
    mov bx,word ptr val2
    idiv bx
    ;
    mov ax,4c00h
    int 21h

code ends
end satrt