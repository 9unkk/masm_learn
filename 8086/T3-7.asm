;程序名：T3-7.asm
;功能：实现把一个十六进制数转换为对应的 ASCII 码的程序。
assume ds:data,cs:code

data segment
number db 0Fh
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov al,number
    and al,0fh
    cmp al,0ah
    jb num_add
    add al,37h
    mov dl,al
    jmp output
num_add:
    add al,30h
    mov dl,al
output:
    mov ah,2
    int 21h
    mov ax,4c00h
    int 21h
code ends
end start