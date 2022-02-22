;程序名：jmp2.asm
;转移指令
;=============================

assume cs:code,ds:data

data segment
val1 dw 1234h
val2 dw 5678h
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;jb,jl,ja,jg,jmp
    mov ax,val1
    cmp ax,val2
    jb L1
    mov bx,val1
    jmp over
    NOP
L1:
    mov bx,val2

over:
    mov ax,4c00h
    int 21h
code ends
end start