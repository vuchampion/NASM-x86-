extern printf
extern scanf
global control_d

segment .data

intro_message db "Welcome, this program was built by Darren Vu", 10, 0
intro_message2 db "Let us compute using integers only.", 10, 0
end_message db "The integer 5 will be returned to the calling program", 10, 0
prompt db "Enter a sequence of long integers seperated by white space.", 0
prompt2 db "After the last input press Control+D.", 0
confirmation db "You entered %d", 10, 0
sum_result db "The sum of these two integers is %d.", 10, 0
product_result db "The product of these two integers is %d.", 10, 0
integer_f db "%d", 0

segment .bss

segment .text

control_d:

mov rax, 0
mov rdi, intro_message
call printf

mov rax, 0
mov rdi, intro_message2
call printf

mov rax, 0
mov rdi, prompt
call printf

mov rax, 0
mov rdi, prompt2
call printf

mov r15, 0      ;Initialize the loop-counter to zero





ret
