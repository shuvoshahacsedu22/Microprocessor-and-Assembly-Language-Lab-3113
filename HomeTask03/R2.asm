section	.data					

prompt1: db "      FIBONACCI NUMBER ",10,"     ==================",10,"Enter a number: ",10,0								;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
prompt2: db "The %ld-th fibonacci number is: %ld",10,0

n: dq 0
num2: dq 0
res: dq 0

fmt_Pstr: db "%s",10,0													;newline is 10
fmt_Pint: db "%d",10,0
fmt_Plong: db "%ld",10,0
fmt_Pfloat:db "%lf",10,0

fmt_Sstr: db "%s",0
fmt_Sint: db "%d",0
fmt_Slong: db "%ld",0
fmt_Sfloat: db "%lf",0


section .bss

section .text


global main
																		;main program execution will start from here  

extern printf 															;external function printf called here 
extern scanf

main:
	
	push RBP
	mov RBP,RSP
	
	lea RDI,[prompt1]    												;parameter passing order -->>  rdi,rsi,rdx,rcx,r8,r9
	mov RAX,0 
	call printf	


	lea RDI,[fmt_Slong]
	lea RSI,[n]
	mov RAX,0
	call scanf

	mov RAX,[n]
	push RAX
	call FIBONACCI
	pop RBX
	
	mov qword [res], RAX ;result is saved in RAX
	
print:
	
	lea RDI,[prompt2]
	mov RSI,[n]
	mov RDX,[res]
	mov RAX,0
	call printf
	
	
	mov RAX,60
	pop RBP            ;RAX must always be 0 before return
	ret			;return the function
	            ;	//run command on terminal		
		;nasm -f elf64 file_name.asm
		;gcc file_name.o -o hljj									
		;./hljj														
										;							
										;stack pos decreases ...  0 8 16 24 32 40 48 56 64 .......
FIBONACCI:
	
	push RBP
	mov RBP,RSP
	
	mov RAX,[RBP+16]   ;value of n 
	
	
	
	mov RDX, 2
	cmp RAX, RDX
	jle END
	
	dec RAX
	push RAX
	
	call FIBONACCI  ;call for fib(n-1)....
	
	pop RDX
	
	push RAX ; value of fib(n-1)
	
	mov RAX,RDX
	dec RAX
	push RAX ;
	
	call FIBONACCI	;call for fib(n-2)....
	pop RDX ; rax removed
	pop RDX ;value of fib(n-1)
	add RAX,RDX ;sum of fib(n-1)+ fib(n-2)
	
	leave 
	ret
	
END:
	
	mov RAX,1
	leave
	ret
