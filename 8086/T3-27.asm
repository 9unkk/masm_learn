;程序名：T3-27.asm
;功能：从地址F000:0000H开始的64K字节内存区域的检验和，并转换为16进制数的ASCII码
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
    mov cx,65535
summer:
    add ax,es:[si]
    add si,2
    loop summer
    ;
    call far ptr H_TO_A
    ;
    mov ax,4c00h
    int 21h

H_TO_A proc far
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
    lea dx,result
    ;
    popf
    pop cx
    pop ax
    ret
H_TO_A endp
code ends
end start