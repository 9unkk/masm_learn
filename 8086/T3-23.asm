;程序名：T3-23.asm
;功能：把两个字符串合并
assume cs:code,ds:data

data segment
string1 db 'hell',0
string2 db 'o word',0
len = ($-string1)-2
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
loop1:
    mov dl,string1[si]
    cmp dl,0
    jz next
    mov result[di],dl
    mov ah,2
    int 21h
    inc di
    inc si
    jmp loop1
next:
    xor si,si
loop2:
    mov dl,string2[si]
    cmp dl,0
    jz stop
    mov result[di],dl
    mov ah,2
    int 21h
    inc di
    inc si
    jmp loop2
stop:
    mov ax,4c00h
    int 21h
code ends
    end start