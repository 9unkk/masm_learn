;程序名：T3-10.asm
;功能：不使用乘法实现乘法运算(累加法)

assume ds:data,cs:code

data segment
x db 234    ;被乘数
y db 125    ;乘数
z dw 0
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov al,x
    xor ah,ah
    mov cl,y
    xor ch,ch
    xor dx,dx
    jcxz stop
muls:
    add dx,ax
    loop muls
    mov z,dx
stop:
    mov ax,4c00h
    int 21h
code ends
end start