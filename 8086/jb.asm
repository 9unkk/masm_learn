;程序名：jb.asm
;功能：显示一个字符串
;===========================
assume cs:code,ds:data

data segment
string db "hello ,welcome to JB!","$"
number db 1,2,3,4,5,6
       db "123456"
data ends

code segment 
start:
    mov ax,data
    mov ds,ax
    ;jb(jmp below)无符号数跳转,[si] < [si+1] CF=0
    mov si,offset number
    mov al,byte ptr ds:[si]
    cmp al,[si+1]
    jb str
    ;
    mov ax,4c00h
    int 21h
    ;
str:
    mov dx,offset string
    mov ah,9
    int 21h
    mov ax,4c00h
    int 21h
code ends
    end start

