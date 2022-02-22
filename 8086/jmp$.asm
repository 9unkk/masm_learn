;程序名：jmp$.asm
;转移指令
;$：表示当前地址
;=============================
assume cs:code,ds:data

data segment
x dw 1234h
y dw 5678h
z dd ?
data ends

code segment
start:
    mov ax,data
    mov ds,ax

    mov ax,0
    jmp $ + 4 ;跳转到地址 C，变成另一个地址
    NOP
    NOP
    mov bx,1
    mov cx,3

    mov dx,4

    mov ax,4c00h
    int 21h
code ends
end start