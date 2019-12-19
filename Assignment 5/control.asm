;  Author name: Darren Vu
;  Author email: vuchampion@csu.fullerton.edu
;  Date of last update: December 18, 2019

extern printf
extern scanf

global control

segment .data
welcome_msg db "Welcome to CPSC 240 brought to you by Darren Vu", 10, 0
return_msg db "This module will now return the hypotenuse to the caller.", 10, 0
rt_tri_msg db "Welcome to Right Triangle Analyzer", 10, 0
prompt_msg db "Enter the lengths of the two legs of a right triangle seperated by whitespace and press enter.", 10, 0
confirm db "Thank you for the nice numbers.", 10, 0
input_format db "%lf", 0
print_area db "The area of the triangle is (base * height)/2 which is: %lf units squared.", 10, 0
print_hypotenuse db "The hypotenuse has length: %lf units.", 10, 0
print_number db "Your number is: %lf", 10, 0
print_two_numbers db "Your numbers are: %lf and %lf", 10, 0

segment .bss

segment .text

control:

push rbp                                                    ;Backup the base pointer
mov  rbp,rsp                                                ;Advance the base pointer to start of the current stack frame
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
;--------------------------------------------------------------------------------------------------
mov rax, 0
mov rdi, welcome_msg
call printf

mov rax, 0
mov rdi, rt_tri_msg
call printf

mov rax, 0
mov rdi, prompt_msg
call printf

push qword 0
push qword 0
mov rax, 1
mov rdi, input_format
mov rsi, rsp
call scanf
movsd xmm13, [rsp]
pop rax
pop rax

push qword 0
push qword 0
mov rax, 1
mov rdi, input_format
mov rsi, rsp
call scanf
movsd xmm14, [rsp]
pop rax
pop rax

;Save the values for later manipulation
movsd xmm10, xmm13
movsd xmm11, xmm14

;Print out two numbers, use xmm0 & xmm1 as argument 1 and 2.
;When using floating point xmm registers the arguments differ slightly.
mov rax, 1
mov rdi, print_two_numbers
movsd xmm0, xmm13
movsd xmm1, xmm14
call printf

;0x4000000000000000 is 2.0 in decimal
;We do these next set of instructions to place a 2 in xmm15
;The two is used to divide base * height
;This is necessary because it is illegal to movsd xmm15, 2.0
mov        r15, 0x4000000000000000
push       r15                                              ;Place the constant on the integer stack
movsd      xmm15, [rsp]                                     ;Copy the divisor to xmm13
pop        rax                                              ;Discard the divisor from the integer stack

;Multiply register xmm13 by xmm14
;The product is stored in xmm13
mulsd xmm13, xmm14

;Check to see if the product of the first two numbers is correct
;mov rax, 1
;mov rdi, print_number
;movsd xmm0, xmm13
;call printf

;Check to make sure xmm15 still holds 2.0
;mov rax, 1
;mov rdi, print_number
;movsd xmm0, xmm15
;call printf

;divsd instruction set: xmm13 = xmm13 / xmm15
;divsd does not hold any remainders
divsd xmm13, xmm15

mov rax, 1
mov rdi, print_area
movsd xmm0, xmm13
call printf


;Recall that the hypotenuse is the square root of A squared + B squared.
;Recall that we saved A and B in xmm10 & xmm11 respectively.
;Find the squares of A and B:
mulsd xmm10, xmm10
mulsd xmm11, xmm11

;Add A and B
addsd xmm10, xmm11

;Find the square root
sqrtsd xmm10, xmm10

mov rax, 1
mov rdi, print_hypotenuse
movsd xmm0, xmm10
call printf


;In order to return we dont "mov rax, <return value>" like usual.
;Instead, we have to move the return value into xmm0.
movsd xmm0, xmm10
;--------------------------------------------------------------------------------------------------
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
