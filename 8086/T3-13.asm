;程序名：T3-13.asm
;功能：判定从地址 0040：0000H 开始的 2048 个内存字节单元中是否有字符 'A'。
;如有则把第一个（按地址由小到大为序）含此指定字符的存储单元的地址偏移送到  0000:03FEH 单元中
;如果没有把特征值 0FFFFH 送到 0000：03FEH 单元

assume cs:code
;常量定义
segaddr = 40h   ;源地址段值
offaddr = 0     ;源地址偏移
count = 2048    ;长度（计数）
keychar = 'A'   ;指定字符
segresu = 0     ;目的保存单元段值
offresu = 03FEh ;目的保存单元偏移

code segment
start:
    mov ax,segaddr
    mov ds,ax
    mov ax,offaddr
    mov si,ax
    mov ax,segresu
    mov es,ax
    mov ax,offresu
    mov di,ax
    mov cx,count
    mov ah,keychar
    ;
find:
    mov al,[si]
    cmp ah,al
    jnz loops
    inc di
    mov [di],si
loops:
    inc si
    loop find
    mov di,03FEh
    mov dh,[di]
    cmp dh,ah
    jz stop
    mov dx,-1
    mov [di],dx
stop:
    mov ax,4c00h
    int 21h
code ends
    end start