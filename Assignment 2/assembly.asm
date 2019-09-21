extern printf
extern scanf
global assignment2

segment .data

welcome_message db "The X86 Program has begun", 10, 0
first_integer_prompt db "Please enter the first integer and press enter: ", 0
second_integer_prompt db "Please enter the second integer and press enter: ", 0
integer_format db "%ld", 0
two_numbers db "The two numbers we have are: %ld & %ld", 10, 0
confirmation db "The number you have entered is: %ld", 10, 0
print_register db "This register contains the value: %ld", 10, 0
division_result db "The quotient is: %ld The remainder is: %ld", 10, 0

segment .bss

segment .text

assignment2:
push       rbp                                              ;Save a copy of the stack base pointer
mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
push       rbx                                              ;Back up rbx
push       rcx                                              ;Back up rcx
push       rdx                                              ;Back up rdx
push       rsi                                              ;Back up rsi
push       rdi                                              ;Back up rdi
push       r8                                               ;Back up r8
push       r9                                               ;Back up r9
push       r10                                              ;Back up r10
push       r11                                              ;Back up r11
push       r12                                              ;Back up r12
push       r13                                              ;Back up r13
push       r14                                              ;Back up r14
push       r15                                              ;Back up r15
pushf

;registers r10 and r11 do not function properly
;registers r8 and r9 also do not function properly                                                     ;Back up rflags


mov rax, 0
mov rdi, welcome_message
call printf

mov rax, 0
mov rdi, first_integer_prompt
call printf

push qword 0
push qword 0
mov rax, 0
mov rdi, integer_format
mov rsi, rsp
call scanf
mov r12, [rsp]
pop rax
pop rax

mov rax, 0
mov rdi, print_register
mov rsi, r12
call printf

mov rax, 0
mov rdi, second_integer_prompt
call printf

push qword 0
push qword 0
mov rax, 0
mov rdi, integer_format
mov rsi, rsp
call scanf
mov r13, [rsp]
pop rax
pop rax

mov rax, 0
mov rdi, print_register
mov rsi, r13
call printf

mov rax, 0
mov rdi, two_numbers
mov rsi, r12
mov rdx, r13
call printf

;mov rax, r14
;cqo
;idiv r15
;mov r13, rax
;mov r12, rdx

;mov rax, 0
;mov rdi, division_result
;mov rsi, r13
;mov rdx, r12
;call printf

popf                                                        ;Restore rflags
pop        r15                                              ;Restore r15
pop        r14                                              ;Restore r14
pop        r13                                              ;Restore r13
pop        r12                                              ;Restore r12
pop        r11                                              ;Restore r11
pop        r10                                              ;Restore r10
pop        r9                                               ;Restore r9
pop        r8                                               ;Restore r8
pop        rdi                                              ;Restore rdi
pop        rsi                                              ;Restore rsi
pop        rdx                                              ;Restore rdx
pop        rcx                                              ;Restore rcx
pop        rbx                                              ;Restore rbx
pop        rbp                                              ;Restore rbp

mov r9, 0
mov rax, r9 ;return 0 to the OS
ret
