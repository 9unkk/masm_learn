;程序名：T3-17.asm
;功能：设一个32位有符号数存放在DX:AX中，请写一个求其补码的程序。
assume cs:code,ds:data

data segment
number dd -12345
result db 4 dup(?)
data ends

code segment
start:
    xor si,si
    xor bx,bx
    mov bx,3
    mov di,4
    ;
    mov ax,word ptr number[si]
    mov dx,word ptr number[si+2]
    ;and dx,80h 这里最好用 test，and 会改变寄存器的值
    test dx,80h
    jnz f_num
    mov word ptr result[si],ax
    mov word ptr result[si+2],dx
    jmp loop_start
f_num:
    xor dx,07FFFh
    not ax
    or ax,1
    mov word ptr result[si],ax
    mov word ptr result[si+2],dx
loop_start:
    mov cx,8
    mov dh,result[si+bx]
output:
    shl dh,1
    adc ch,0
    add ch,30h
    mov dl,ch
    mov ah,2
    int 21h
    xor ch,ch
    loop output
    mov dl,0
    mov ah,2
    int 21h
    dec bx
    dec di
    jnz loop_start
    mov ax,4c00h
    int 21h
code ends
    end start