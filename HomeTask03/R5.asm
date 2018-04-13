section	.data					

prompt1: db "FINDING ELEMENT IN SORTED ARRAT",10,"    ===================",10,"Enter the  number of array element: ",10,0								;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
prompt2: db "Enter the %ld numbers in ascending order: ",10,0
prompt3: db "The key is  present at index %ld",10,0
prompt4: db "The key is not present in the array",10,0
prompt5: db "Enter the search key: ",10,0

n: dq 0
key: dq 0
res: dq 0
array: times 1000 dq 0

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
	lea RSI,[n]
	mov RAX,0
	call scanf

	
	
	lea RDI,[prompt2]    												;parameter passing order -->>  rdi,rax,rdx,rsi,r8....r9
	mov RSI,[n]
	mov RAX,0 
	call printf
	
	xor RCX,RCX
	
inputLoop:	

	push RCX
	
	lea RDI,[fmt_Slong]
	lea RSI,[array+RCX*8]
	mov RAX,0
	call scanf
	
	pop RCX
	
	inc RCX
	mov RSI,[n]
	cmp RCX,RSI
	jl inputLoop
	
	

inputSearchKey:
	
	lea RDI,[prompt5]
	mov RAX,0
	call printf
	
	lea RDI,[fmt_Slong]
	lea RSI,[key]    												;parameter passing order -->>  rdi,rax,rdx,rsi,r8....r9
	mov RAX,0 
	call scanf
	
binarySearch:
	
	mov RAX,[key]  ;a 
 	push RAX
	mov RAX,0  ;b
	push RAX
	mov RAX,[n]
	dec RAX
	push RAX
	call search
	pop RAX
	pop RAX
	pop RAX
	
exit:
	 												;parameter passing order -->>  rdi,rax,rdx,rsi,r8....
	mov RAX,60
	pop RBP            ;RAX must always be 0 before return
	ret			;return the function
	            ;	//run command on terminal		
		;nasm -f elf64 file_name.asm
		;gcc file_name.o -o hljj									
		;./hljj														
										;							
										;stack pos decreases ...  0 8 16 24 32 40 48 56 64 .......
search:
	
	
	push RBP
	mov RBP,RSP
	
	mov RAX,[RBP+32]   ;k   key
	mov RBX,[RBP+24]   ;l   left
	mov RCX,[RBP+16]   ;r   right
	
	
	cmp RBX,RCX
	jge END
	
	
	add RBX,RCX  ;l+r
	mov RAX,RBX  ;rax=dividend
	xor RDX,RDX  ;rdx=0
	mov RBX,2    
	div RBX      ;rax/=2
	mov RCX,[array+RAX*8] ;accessing the element at index rax
	cmp RCX,[key] ;comparing key and index element
	je   found    ;element found
	
	jle  goRight  ; go to right of the array

goLeft:	
	mov RCX,RAX  ;mid assinged to right 
	mov RAX,[RBP+32] ;key 
	mov RBX,[RBP+24] ; left value
	push RAX
	push RBX
	push RCX
	 
	call search
	
	leave
	ret
	
found:
	
	lea RDI,[prompt3]
	mov RSI,RAX
	mov RAX,0
	call printf
	leave
	ret
	
goRight: 
	
	mov RCX,RAX ; mid assigned to left
	inc RCX
	mov RAX,[RBP+32] ;key
	mov RBX,[RBP+16] ;right value
	
	push RAX
	push RCX
	push RBX
	call search
	
	leave 
	ret
	
END:
	lea RDI,[prompt4]
	mov RAX,0
	call printf
	leave
	ret
