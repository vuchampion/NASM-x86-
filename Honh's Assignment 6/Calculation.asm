extern printf
extern scanf 

global hamonic_sum
segment .data
	welcome_message db "This machine is running Intel(R) Core(TM) i5-4278U CPU @ 2.6GHz. ",10,0
	prompt_message db "Please enter the number of terms to be included in the harmonic sum:",0
	clock_message_1st db "The clock is now %ld tics and the computation will begin immediately.",10,0
	clock_message_2nd db "The clock is now %ld tics and the computation is complete.",10,0
	time_elapsed_message db "The elapsed time was %20.10lf tics. At 2.6GHz that is %10.10lf seconds.",10,0
	sum_message db "Final sum is %10.10lf",10,0
	
	farwell_message db "This assembly program will now return the harmonic sum to the driver program."
	int_format db "%ld",0
	one_float_format db "%lf",0
	
segment .bss
segment .text

hamonic_sum:
;===== Backup all the GPRs ========================================================================================================
push rbp                                                    ;Backup the base pointer
mov  rbp,rsp                                                ;Advance the base pointer to start of the current 
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11: printf often changes r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags
;Registers rax, rip, and rsp are usually not backed up.

;=====================================welcome message ===================================================================
	mov rax,0
	mov rdi, welcome_message
	call printf

;=====================================prompt user to input number of terms  ===================================================================
	mov rax,0
	mov rdi, prompt_message
	call printf
	
;=======================get number of terms from user===================
	mov rax,0	
	push qword 0
	push qword 0
	mov rdi, one_float_format
	mov rsi, rsp
	call scanf
	movsd xmm12, [rsp]	;xmm12 hold the number of terms
	pop rax
	pop rax	
;=================================get the clock tics the first time ======================================================================= 

	rdtsc 
	shl rdx, 32	;move left == make the tics goes in rdx 
	or rdx,rax
	mov r14, rdx	;r14 hold the value of the 1st stics (long int)
	
;=====================================print out the number of 1st tics value ===================================================================
	mov rax,0
	mov rdi, clock_message_1st
	mov rsi, r14
	call printf



;=====================================loop to find the sum of Harmonic series ===================================================================
	;Note: movsd xmm15,0 is not right syntax
	
		;movsd xmm15,0	;xmm15 will hold the sum, set it to 0.0
		mov rax, 0x0000000000000000
		push rax
		movsd xmm15,[rsp]
		pop rax
		
		
		;movsd xmm14,1	;numerator ,set it to 1.0
		mov rax, 0x3FF0000000000000
		push rax
		movsd xmm14,[rsp]
		pop rax

		;movsd xmm13,1	;determinator, set it to 1.0
		mov rax, 0x3FF0000000000000
		push rax
		movsd xmm13,[rsp]
		pop rax
		
		
	loop:	
		divsd xmm14,xmm13	; xmm14 = xmm14/xmm13
		addsd xmm15,xmm14	; xmm15 = xmm15 + xmm14
		
		;movsd xmm14,1	;numerator, set it to 1.0 again
		mov rax, 0x3FF0000000000000
		push rax
		movsd xmm14,[rsp]
		pop rax
		
		addsd xmm13,xmm14	;  inceasing xmm13 by 1
		ucomisd xmm13,xmm12		;   xmmr12 == number of terms that user inputed 
		jbe loop	; jump if <= xmm12

;=====================================print out the final sum ==================================================================
		mov rax,1
		mov rdi, sum_message
		movsd xmm0, xmm15
		call printf



;=================================get the clock tics the second time =======================================================================
	mov rax,0
	mov rdx,0
	rdtsc 
	shl rdx, 32	;move left == make the tics goes  in rdx
	or rdx,rax
	mov r15, rdx	;r15 hold the value of the 2nd stics
	
;=====================================print out the number of 2nd tics value ===================================================================
	mov rax,0
	mov rdi, clock_message_2nd
	mov rsi, r15
	call printf
	
;=================diference = 2nd tics - 1st tics =============
		sub r15,r14 ; r15 = r15 - r14
		
;=====================================calculate the eslapsed time  ===================================================================
	;note: convert numerator and detomenator to float because the result may be float
	
	cvtsi2sd xmm11,r15	;convert long integer to float number, xmm11 hold the diference
	movsd xmm9,xmm11	; xmm9 hold the diference
	
	mov rax, 0x4004CCCCCCCCCCCD	;mov 2.6ghz into rax
	push rax
	movsd xmm10,[rsp]	;xmm10 hold 2.6
	pop rax
	
	divsd xmm11, xmm10	; xmm11 = xmm11/xmm10, xmm11 hold the eslapsed time in tics
	
;============================convert tics to seconds =========
		mov r11,1000000000
		cvtsi2sd xmm8, r11
		divsd xmm11,xmm8	;xmm11 = xmm11 * xmm8
		
	
;=====================================print out the number tics and eslapsed time ===================================================================
	
	
	mov rax,2
	mov rdi, time_elapsed_message
	movsd xmm0,xmm9
	movsd xmm1, xmm11
	call printf
;send back the hamornic sum back to driver 
	movsd xmm0, xmm15	
			
;===== Restore original values to integer registers ===============================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret
