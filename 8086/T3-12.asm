;程序名：T3-12.asm
;功能：把一个字符串中的所有大写字母改写成小写。

assume ds:data,cs:code

data segment
char db 'HOW are yoU !',0
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
char_A:
    mov dl,char[si]
    cmp dl,0
    jz stop
    ;
    cmp dl,41h
    jb output
    cmp dl,5Ah
    ja output
    add dl,20h
    ;
output:
    inc si
    mov ah,2
    int 21h
    jmp char_A
    ;
stop:
    mov ax,4c00h
    int 21h
code ends
    end start