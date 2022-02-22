;程序名：jmp.asm
;转移指令
;=============================

assume cs:code

code segment
start:

N:
    mov ax,0
    mov bx,0
    jmp short N
    add ax,1

S:
    inc ax

    mov ax,4c00h
    int 21h
code ends
end start
