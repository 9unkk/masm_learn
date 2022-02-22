;程序名：hello.asm
;功能：显示一个字符串--调用 DOS 功能函数
;=======================

;cs(代码段)地址标号为code，ds(数据段)地址标号为data，ss(栈段)地址标号为stack。assume 假设
;SS:stack
assume cs:code,ds:data

;开辟 16 个字节的栈段,并填充为0
;stack segment
	;db 16 dup(0)
;stack ends

;定义数据段
data segment
string db 'hello welcome to asm!','$'	;在数据段偏移地址0处，定义字符串，以 "$" 表示结束
data ends

code segment
start:
	;mov ax,stack
	;mov ss,ax
	;mov sp,16
	
	mov bx,data
	mov ds,bx
	
	mov si,0
	mov ax,word ptr ds:[si]	;word 取一个字，也就是 2 个字节 he
	
	mov dx,offset string
	mov ah,9				;21号中断9号功能：显示字符串
	int 21h					;21号中断
	
	;mov ax,4c00h
	mov al,0				;21号中断0h号功能：终止程序
	mov ah,4ch			
	int 21h
code ends
	end start	;告诉编译器代码的起始位置在 start