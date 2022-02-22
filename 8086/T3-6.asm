;程序名：T3-6.asm
;功能：实现三个无符号数的有大到小的排序

assume cs:code,ds:data

data segment
buffer db 87,234,123
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov si,offset buffer
    mov al,[si]
    mov bl,[si+1]
    mov cl,[si+2]
    cmp al,bl
    jae next1
    xchg al,bl
next1:
    cmp al,cl
    jae next2
    xchg al,cl
next2:
    cmp bl,cl
    jae next3
    xchg bl,cl
next3:
    mov [si],al
    mov [si+1],bl
    mov [si+2],cl
    mov ax,4c00h
    int 21h
code ends
    end start