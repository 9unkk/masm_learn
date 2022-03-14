;程序名：T3-20.asm
;功能：实现把字符串中的小写字母变换为对应的大写字母，设字符串以0结尾

assume cs:code,ds:data

data segment
string db 'hello Word!',0
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    xor si,si
loop_start:
    mov dl,string[si]
    ;
    cmp dl,0
    jz stop
    ;
    cmp dl,05Ah
    jbe output
    sub dl,20h
output:
    mov ah,2
    int 21h
    inc si
    jmp loop_start
stop:
    mov ax,4c00h
    int 21h
code ends
    end start