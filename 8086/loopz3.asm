;程序名：loopz.asm
;功能：查找第一个非 'A' 字符，找到 BX 保存该字符的偏移地址，找不到 BX=0FFFFh
;=========================================================================
assume cs:code,ds:data

data segment
val db 'AAABABAA'
len = $ - val
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    mov cx,len
    xor si,si
    ;
loop_start:
    mov al,val[si]
    inc si
    cmp al,41h
    ;loopz：cx不为0 and zf 标志位为 1 才会继续循环，只要其中一个条件不成立就会跳出循环
    loopz loop_start    ;寻呼那指令中集合了 dec cx，会影响 zf 位
    ;正常循环结束后的 CX = 0
    jz no_find
    mov bx,si
    jmp stop
no_find:
    mov bx,-1
stop:
    mov ax,4c00h
    int 21h
code ends
end start