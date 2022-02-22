;程序名：MBRANCH.asm
;功能：程序每次只接收一个单键命令 "A" 至 "H"，然后根据命令打印相应的字符COMA~COMH。如果接收到的输入不是规定的字母，则不处理。
assume ds:data,cs:code

data segment
tab db 'COMA','COMB','COMC','COMD','COME','COMF','COMG','COMH'
result dd 0,'$'
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;判断
    mov ah,7
    int 21h
    and al,0dfh  ;将小写转换为大写
    ;and al,dfh
    cmp al,'A'
    jb stop
    cmp al,'H'
    ja stop
    ;计算偏移
    xor ah,ah
    sub al,41h
    mov dl,4
    mul dl
    mov bx,ax
    ;存储数据
    mov cx,word ptr tab[bx]
    mov word ptr result,cx
    mov cx,word ptr tab[bx+2]
    mov word ptr result+2,cx
    ;输出
    mov dx,offset result
    mov ah,9
    int 21h
stop:
    mov ax,4c00h
    int 21h
code ends
end start