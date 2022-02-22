;程序名：loop.asm
;功能：十六进制数转换成ASCII输出
;=============================
assume cs:code,ds:data

data segment
val dw 0A2B4h
result db ?,?,?,?,'H',24H
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    xor si,si
    mov cx,4
    mov ax,val[si]
    ;
loop_start:
    push cx
    mov cl,4
    rol ax,cl
    push ax
    and al,0fh
    cmp al,9
    jnb char
    add al,30h
    mov result[si],al
    jmp loop_end
    ;
char:
    add al,37h
    mov result[si],al
    ;
loop_end:
    pop ax
    pop cx
    inc si
    loop loop_start
    ;
    mov dx,offset result
    mov ah,9
    int 21h
    ;
    mov ax,4c00h
    int 21h
code ends
end start