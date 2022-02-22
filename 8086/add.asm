;程序名：add.asm
;功能：计算 1234:5678H 开始的内存中的20个16位无符号整数的和
;注意有进位值，结果保存到 DX:AX，或者 result 变量中

;程序设计：
;1、自定义一个number，将 20 个 16 位无符号整数，复制到 1234:5678H 处，主要是为了验证代码执行结果是否正确。
;2、计算整数之和使用 add 指令，如果两数之和超过ax寄存器（CF 有进位），使用 ADC 指令将最高位存到DX中
;3、使用循环执行该段代码，直到运算结束。
;4、将 DX:AX 中的结果，存放到 result 变量中，result 定义为双字 dd。
;5、使用循环将 result 中的结果，以16进制打印出来

;====================================
assume cs:code,ds:data

data segment
number dw '10',0ABh,0ABh,'40','50','60','70','80','90','00','11','22','33','44','55','66','77','88','99','00'
result dd ?
buffer db 0,0
buffer1 dw 0,0
stop db '$'
data ends

code segment
start:
;复制字符串
;========================================
	mov ax,data
	mov ds,ax
	mov ax,1234h
	mov es,ax
	mov si,offset number
	mov bx,5678H
	mov di,bx
	mov cx,20
	rep movsw				;si寄存器，默认使用ds段寄存器；di寄存器，默认使用 es 段寄存器


;计算结果，并存储到 result 中
;===============================================================
	mov ax,0
	mov dx,0
	mov bx,0
	mov di,5678h
	mov cx,20
sum:	
;计算16位无符号整数
	clc
	add ax,word ptr es:[di]
	JB ADC1
ADC1:
;判断并计算进位
	adc dx,0
	inc di
	inc di
	dec cx
	jnz sum
;复制结果到result
	mov word ptr result,ax
	mov word ptr result+2,dx


;将结果以16进制显示
;===================================================================
	mov cx,4					;定义循环次数(每次循环打印1字节)
	push cx						;堆栈中保存循环次数
	mov bx,3					;定义要打印字符串的指针位置（从最高位开始）
print:
	xor ch,ch
	pop cx						
	push cx						;使用并保存循环次数
	xor ax,ax
	mov si,offset result		;从高位开始取值
	mov al,byte ptr [si+bx]
	push ax
	
;计算高4位
	mov cl,4
	shr al,cl
	cmp al,0Ah					;如果高4位是字母就转换成字母字符
	jnb char1
	add al,30h					;如果高4位是数字就转换成数字字符
	mov buffer,al				;此时4位扩展成8位，将结果存储到 buffer 的低8位
	jmp low1					;高4位计算结束，跳转到低4位计算
char1:
	add al,37h					;此时4位扩展成8位，将结果存储到 buffer 的低8位
	mov buffer,al

low1:
;计算低4位
	pop ax
	and al,0Fh
	cmp al,0Ah					;如果低4位是字母就转换成字母字符
	jnb char2
	add al,30h					;如果低4位是数字就转换成数字字符
	mov buffer+1,al				;此时4位扩展成8位，将结果存储到 buffer 的高8位
	jmp loops
char2:
	add al,37h
	mov buffer+1,al				;此时4位扩展成8位，将结果存储到 buffer 的高8位

;将字符以大端形式打印出来
loops:
;内循环，传输高16位
	dec bx						;循环一次，指针减1
	pop cx
	dec cx
	push cx						;计算并保存循环次数
	pushf
	test cx,01h
	jz loops1					;判断此次是内循环还是外循环
	;
	mov ax,word ptr buffer
	mov buffer1,ax				;把buffer中的高16位，传给 buffer1 的低16位
	;
	popf
	jnz print					;判断循环次数是否等于0，不等于0，则继续循环

loops1:
;外循环传输低 16 位，并打印出来
	mov ax,word ptr buffer
	mov buffer1+2,ax			;把buffer中的低16位，传给 buffer1 的高16位
	mov dx,offset buffer1
	mov ah,09h
	int 21h						;打印循环结果
	popf
	jnz print					;判断是否循环结束
	mov ax,4c00h
	int 21h
code ends
	end start