;程序名：T3-15.asm
;功能：设 BUFFER 缓冲区中有10各单字节无符号正数，使用冒泡排序将它们由小到大排序
assume cs:code,ds:data

data segment
number db 4,1,6,0,3,2,5,8,7,9
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    mov es,ax
    ;
    mov cx,9
    xor si,si
loop_start:
    mov dx,si
    add dx,1
    mov di,dx
    mov al,number[si]
change_start:
    mov bl,number[di]
    cmp al,bl
    jle change_end
    xchg al,bl
    mov number[si],al
    mov number[di],bl
change_end:
    inc di
    cmp di,cx
    jb change_start
    inc si
    loop loop_start
    ;
    mov ax,4c00h
    int 21h
code ends
    end start