;程序名：T3-28.asm
;功能：设已在地址F000:000H开始的内存区域安排了100个字节的无符号8位二进制数。请编写一个程序求他们的和，并转换为对应十进制数的ASCII码串。
assume cs:code,ds:data

data segment
    sum dw 0
    result dw 0,0
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov ax,0f000h
    mov es,ax
    ;
    xor ax,ax
    mov cx,100
summer:
    add ax,es:[si]
    adc dx,0
    add si,2
    loop summer
    ;
    call far ptr H_TO_A
    ;
    mov ax,4c00h
    int 21h

H_TO_A proc far
    push dx
    push ax
    push cx
    pushf
    xor dx,dx
    mov cl,4
loop0:
    mov dl,al
    xchg ah,al
    shl dx,cl
    shr dl,cl
    cmp dl,09h
    jbe next1
    mov dl,37h
next1:
    cmp dh,09h
    jbe number
    add dh,37h
    jmp loop1
number:
    add dx,3030h
loop1:
    xchg dh,dl
    mov result[bx],dx
    add bx,2
    cmp bx,4
    jnz loop0
    lea si,result
    ;
    popf
    pop cx
    pop ax
    pop dx
    ret
H_TO_A endp
code ends
end start