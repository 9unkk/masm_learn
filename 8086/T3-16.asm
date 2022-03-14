;程序名：T3-16.asm
;功能：分别有两个以0结尾的字符串在不同的数据段中。如果数据段1的字符串，包含了数据段2的字符串，flag变量置为1，否则将其清0。
assume cs:code1,ds:data1,es:data2

data1 segment
char1 db 'welcome to masm!',0
data1 ends

data2 segment
char2 db 'masm',0
len = ($ - char2)-1
flag db 0
data2 ends


code1 segment
start:
    mov ax,data1
    mov ds,ax
    mov ax,data2
    mov es,ax
    ;
    mov cx,len-1
not_find:
    xor di,di
    mov bl,char1[si]
    cmp bl,0
    jz stop
    mov al,char2[di]
    cmp al,bl
    jz find
    inc si
    jmp not_find
find:
    inc si
    mov bl,char1[si]
    inc di
    mov al,char2[di]
    cmp al,bl
    jnz not_find
    loop find
    mov flag,1
stop:
    mov ax,4c00h
    int 21h
code1 ends
end start