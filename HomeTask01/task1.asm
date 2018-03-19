section	.data					
prompt1: db "Enter 20 integer numbers",10,0								;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
prompt2: db "Sum of 20 numbers is: %ld",10,0
sum: dq 0x00
fmt_Pstr: db "%s",10,0	;newline is 10
fmt_Pint: db "%d",10,0
fmt_Plong: db "%ld",10,0
fmt_Pfloat:db "%lf",10,0

fmt_Sstr: db "%s",0
fmt_Sint: db "%d",0
fmt_Slong: db "%ld",0
fmt_Sfloat: db "%lf",0


num: times 20 dq 0

section .bss

section .text

global main
   								;main program execution will start from here  
extern printf 								;external function printf called here 
extern scanf

main:
	push RBP
	
	lea RDI,[prompt1]
	mov RAX,0 
	call printf	
	
	mov RCX,0
loop1:
	push RCX
	lea RDI, [fmt_Slong]
	lea RSI,[num+RCX*8]
	mov RAX,0
	call scanf
	mov RAX,[num+RCX*8]
    pop RCX
    mov RAX,[num+RCX*8]
    add [sum],RAX
    INC RCX
    cmp RCX,20
	jl loop1
	
	lea RDI,[prompt2]
	mov RSI,[sum]
	mov RAX,0
	call printf

	
	mov RCX,0
	
loop2:
	push RCX
	lea RDI,[fmt_Plong]
	mov RSI,[num+RCX*8]
	mov RAX,0
	call printf
	pop RCX
	INC RCX
	cmp RCX,20
	jl loop2
	
	
	
	mov RAX,60
	pop RBP                                               ;RAX must always be 0 before return
	ret			;return the function
	;	//run command on terminal		
		;nasm -f elf64 file_name.asm
		;gcc file_name.o -o hljj
		;./hljj



