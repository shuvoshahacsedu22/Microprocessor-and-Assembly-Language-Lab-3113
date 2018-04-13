section	.data					

prompt1: db "SUM OF SERIES: 2 + 3 + 5 + 8 + 12 ....+ N ",10,"   ==========================",10,"Enter ant integer number n: ",10,0								;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
prompt2: db "Sum of the series ending with %ld is = %ld",10,0

sum: dq 0

fmt_Pstr: db "%s",10,0													;newline is 10
fmt_Pint: db "%d",10,0
fmt_Plong: db "%ld",10,0
fmt_Pfloat:db "%lf",10,0

fmt_Sstr: db "%s",0
fmt_Sint: db "%d",0
fmt_Slong: db "%ld",0
fmt_Sfloat: db "%lf",0


num:  dq 0


section .bss

section .text


global main
																		;main program execution will start from here  

extern printf 															;external function printf called here 
extern scanf

main:
	
	push RBP
	mov RBP,RSP
	
	lea RDI,[prompt1]    												;parameter passing order -->>  rdi,rax,rdx,rsi,r8....r9
	mov RAX,0 
	call printf	


	lea RDI,[fmt_Slong]
	lea RSI,[num]
	mov RAX,0
	call scanf

	mov qword [sum],0
	mov RAX,[num]
	push RAX
	mov RAX,2
	push RAX
	mov RAX,1
	push RAX
	call F
	pop RCX
	pop RBX
	pop RAX
	
	add [sum],RBX
	
print:
	
	lea RDI,[prompt2]
	mov RSI,[num]
	mov RDX,[sum]
	mov RAX,0
	call printf
	
	mov RAX,60
	pop RBP            ;RAX must always be 0 before return
	ret			;return the function
	            ;	//run command on terminal		
		;nasm -f elf64 file_name.asm
		;gcc file_name.o -o hljj									x+1|   1  |
		;./hljj														x+2|   2  |
										;							x+3|  num |
										;							x+4|      |
F:
	
	
	push RBP
	mov RBP,RSP
	
	mov RAX,[RBP+32]
	mov RBX,[RBP+24]
	mov RCX,[RBP+16]
	
	
	xor RDX,RDX
	add RDX,RBX
	add RDX,RCX
	
	cmp RDX,RAX
	
	jg END
	
	push RAX
	push RDX
	mov RCX,[RBP+16]
	inc RCX
	push RCX
	
	call F
	pop RCX
	pop RBX
	pop RAX
	add qword [sum],RBX
	
	
END:
	leave
	ret
