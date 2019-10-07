extern printf
extern scanf
global adding_two_integers

segment .data
prompt db "Enter an integer.", 10, 0
confirm db "Your integer was: %d", 10, 0
greater db "Your integer was greater than 50", 10, 0
lesser db "Your integer was less than 50", 10, 0
integer_format db "%d", 0

segment .bss

segment .text

adding_two_integers:

mov rax, 0
mov rdi, prompt
call printf

push qword 0
mov rax, 0
mov rdi, integer_format
mov rsi, rsp
call scanf
mov r15, [rsp]
pop rax

mov rax, 0
mov rdi, confirm
mov rsi, r15
call printf

cmp r15, 50
jg greater_than
mov rax, 0
mov rdi, lesser
call printf
jmp exit
greater_than:
mov rax, 0
mov rdi, greater
call printf

exit:

mov rax, 0
ret
