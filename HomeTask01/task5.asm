segment	.data					

prompt1: db "Enter 5 integer numbers:",10,0								;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
prompt2: db "First odd number in the list is: %ld",10,0
prompt3: db "Last  odd number in the list is: %ld",10,0
prompt4: db "No odd Number in the list.",10,0
prompt: db "The 3rd largest number is: %ld",10,0
promptS: db "Smallest number %d was found at location %ld",10,0
promptL: db "Largest number %ld was found at location %ld",10,0

fmt_Pstr: db "%s",10,0	;newline is 10
fmt_Pint: db "%d",10,0
fmt_Plong: db "%ld",10,0
fmt_Pfloat:db "%lf",10,0

fmt_Sstr: db "%s",0
fmt_Sint: db "%d",0
fmt_Slong: db "%ld",0
fmt_Sfloat: db "%lf",0


num: times 5 dq 0
copy: times 5 dq 0

index: dq 0

segment .bss

segment .text

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
    
    pop RCX
    mov RAX,[num+RCX*8]
    mov [copy+RCX*8],RAX
    INC RCX
    cmp RCX,5
	jl loop1
	
	mov RBX,0
	         ;bubble sorting
	         
	         
outerLoop:
	
	push RBX
	mov RCX,RBX
    INC RCX
    
	innerLoop:
		push RCX
		mov RDI,[num+RCX*8]
		mov RSI,[num+RBX*8]
		cmp RDI,RSI
		jl change
		jmp down
			change:
		
				mov [num+RCX*8],RSI
				mov [num+RBX*8],RDI
			
			down:
		
		pop RCX
		INC RCX
		cmp RCX,5
		jl innerLoop
	pop RBX
	INC RBX
	cmp RBX,4
	jl outerLoop


mov RDX,[num+4*8]
mov RCX,0


largestNUM:
	push RCX
	mov RSI,[copy+RCX*8]
	
	pop RCX
	INC RCX
	cmp RSI,RDX
	jne largestNUM
	DEC RCX
	 
	 lea RDI,[promptL]
	 mov RSI,[copy+RCX*8]
	 mov RDX,RCX
	 mov RAX,0
	 call printf
	 
mov RDX,[num]
mov RCX,0

smallestNUM:
	push RCX
	mov RSI,[copy+RCX*8]
	
	pop RCX
	INC RCX
	cmp RSI,RDX
	jne smallestNUM
	DEC RCX
	 
	 lea RDI,[promptS]
	 mov RSI,[copy+RCX*8]
	 mov RDX,RCX
	 call printf
	
exit:
	mov RAX,60
	pop RBP                                               ;RAX must always be 0 before return
	ret			;return the function
	;	//run command on terminal		
		;nasm -f elf64 file_name.asm
		;gcc file_name.o -o hljj
		;./hljj



