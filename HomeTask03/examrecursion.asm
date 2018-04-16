section	.data					

prompt1: db "SUPER DIGIT",10,"   ==========================",10,"Enter an integer number n: ",10,0								;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
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

input:

	lea RDI,[prompt1]    		 ;input 										;parameter passing order -->>  rdi,rax,rdx,rsi,r8....r9
	mov RAX,0 
	call printf	

	lea RDI,[fmt_Slong]
	lea RSI,[num]
	mov RAX,0
	call scanf

	
	mov RAX,[num]
	
		
	push RAX
	call RECUR
	pop RCX
	

exit:

	lea RDI,[fmt_Plong]
	mov RSI,RAX
	xor RAX,RAX
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




RECUR:

    push RBP
    mov RBP,RSP
	
	mov RAX,[RBP+16]
    cmp RAX,10
    jl BASE_CASE
    
    push RAX
    call findSUM ; finding the sum of current number
	pop RCX
	push RAX    ;the sum is in RAX
	call RECUR
	leave
	ret
BASE_CASE:
	leave 
	ret



findSUM:
	push RBP
	mov RBP,RSP
	
	mov RCX,[RBP+16] ;the numbe in RCX
	mov RBX,0 ;sum keep in RBX
 whileLoop:
	cmp RCX,0
	je finish
	xor RDX,RDX
	xor RAX,RAX
	mov RAX,RCX
	mov R8,10
	div R8
    
    add RBX,RDX  ;adding the remainder
    mov RCX,RAX  ;moving result
    jmp whileLoop
 
 finish:
   mov RAX,RBX  ;sum
   leave
   ret   
    
