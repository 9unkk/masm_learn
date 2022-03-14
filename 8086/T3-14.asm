;程序名：T3-14.asm
;功能：设缓冲区 DATA 中有一组单字节有符号数，以0为结束标志。程序功能：把前5个正数依次送入缓冲区 PDATA，把前 5 个负数依次送入缓冲区MDATA；如正数或负数不足5个，则用 0 补足

assume cs:code,ds:data

data segment
DATA1 db 1,2,-1,3,-4,-5,0
PDATA db 0Ch,0Ch,0Ch,0Ch,0Ch
MDATA db 0Ch,0Ch,0Ch,0Ch,0Ch
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    mov es,ax
    ;
    mov cx,10
    xor bx,bx
mnum:
    mov al,DATA1[si]
    cmp al,0
    jz supp1
    and al,080h
    cmp al,0
    jz pnum
    mov al,DATA1[si]
    mov MDATA[di],al
    inc di
    inc si
    loop mnum
    jmp supp1
pnum:
    mov al,DATA1[si]
    mov PDATA[bx],al
    inc bx
    inc si
    loop mnum
supp1:
    mov ax,5
    sub ax,di
    jz supp2
    mov cx,ax
P0:
    mov PDATA[di],0
    inc di
    loop P0
supp2:
    mov ax,5
    sub ax,bx
    jz stop
    mov cx,ax
m0:
    mov MDATA[BX],0
    inc bx
    loop m0
stop:
    mov ax,4c00h
    int 21h
code ends
    end start