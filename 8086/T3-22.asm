;程序名：T3-22.asm
;功能：写一个程序，滤去某个字符串中的空格符号（ASSCII码20h），字符串0结尾
assume cs:code,ds:data

data segment
string db 'h ell o',0
len = ($-string)-1
result db len dup(0)
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    mov es,ax
    ;
    xor si,si
    xor di,di
loop_start:
    mov dl,string[si]
    cmp dl,0
    jz stop
    cmp dl,20h
    jz space
    mov result[di],dl
    mov ah,2
    int 21h
    inc di
space:
    inc si
    jmp loop_start
stop:
    mov ax,4c00h
    int 21h
code ends
    end start