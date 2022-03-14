;程序名：T3-21.asm
;功能：统计字符串的长度，设字符串以0结尾
assume cs:code,ds:data

data segment
char db 'Hello Word!!!',0
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    xor bx,bx
loop_start:
    mov al,char[bx]
    cmp al,0
    jz output
    inc bx
    jmp loop_start
output:
    xor ah,ah
    mov al,bl
    mov bl,10
    cmp bl,0ah
    jb num
    div bl
    add al,30h
    add ah,30h
    mov bh,ah
    ;
    mov dl,al
    mov ah,2
    int 21h
    ;
    mov dl,bh
    mov ah,2
    int 21h
    jmp stop
num:
    add bl,30h
    mov dl,bl
    mov ah,2
    int 21h
stop:
    mov ax,4c00h
    int 21h
code ends
    end start