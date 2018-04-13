section	.data					

prompt1: db "          FINDING GCD ",10,"      ==================",10,"Enter the first number: ",10,0								;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
prompt2: db "Enter the second number: ",10,0
prompt3: db "The required GCD of given numbers: ",10,0

num1: dq 0
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
	
	lea RDI,[prompt1]    												;parameter passing order -->>  rdi,rax,rdx,rsi,r8....r9
	mov RAX,0 
	call printf	


	lea RDI,[fmt_Slong]
	lea RSI,[num1]
	mov RAX,0
	call scanf

	lea RDI,[prompt2]    												;parameter passing order -->>  rdi,rax,rdx,rsi,r8....r9
	mov RAX,0 
	call printf
	
	lea RDI,[fmt_Slong]
	lea RSI,[num2]
	mov RAX,0
	call scanf
	
	
	
	mov RAX,[num1]  ;a 
 	push RAX
	mov RAX,[num2]  ;b
	push RAX
	call GCD
	pop RAX
	pop RAX
	
print:
	
	lea RDI,[prompt3]    												;parameter passing order -->>  rdi,rax,rdx,rsi,r8....r9
	mov RAX,0 
	call printf
	
	lea RDI,[fmt_Plong]
	mov RSI,[res]
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
GCD:
	
	
	push RBP
	mov RBP,RSP
	
	mov RAX,[RBP+24]   ;a
	mov RBX,[RBP+16]   ;b
	 
	
	
	xor RDX,RDX	
	cmp RDX,RBX
	je END		
	
	
	push RBX
	xor RDX,RDX
	div RBX
	push RDX
	
	call GCD
	
	leave 
	ret
	
END:
	mov RAX,[RBP+24]
	mov [res],RAX
	leave
	ret
