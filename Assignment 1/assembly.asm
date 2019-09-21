extern printf
extern scanf
global adding_two_integers

segment .data

intro_message db "This program was built by Darren Vu.", 10, 0
end_message db "The integer 5 will be returned to the calling program", 10, 0
first_input db "Please input the first integer: ", 0
second_input db "Please input the second integer: ", 0
confirmation db "You entered %d", 10, 0
sum_result db "The sum of these two integers is %d.", 10, 0
product_result db "The product of these two integers is %d.", 10, 0
integer_f db "%d", 0

segment .bss

segment .text

adding_two_integers:

mov rax, 0                  ;when you mov 0 into rax it means that you aren't dealing with
mov rdi, intro_message      ;floating point numbers, if it was mov rax, 1 it would mean dealing with floats
call printf                 ;call printf to print out whatever was just moved into rdi (intro_message)

mov rax, 0
mov rdi, first_input
call printf                 ;calling printf to print out first_input just like above

push qword 0                ;reserve some space on top of the stack
mov rax, 0
mov rdi, integer_f
mov rsi, rsp
call scanf                  ;call scanf to recieve an input an input formatted by "integer_f" which is %d
mov r15, [rsp]              ;move the contents of rsp (which should be whatever you just scanf'd) into r15
pop rax

mov rax, 0
mov rdi, confirmation
mov rsi, r15
call printf

mov rax, 0
mov rdi, second_input
call printf

push qword 0
mov rax, 0
mov rdi, integer_f
mov rsi, rsp
call scanf
mov r14, [rsp]              
pop rax

mov rax, 0
mov rdi, confirmation
mov rsi, r14
call printf

mov r8, r14                 ;move the value of r14 into a new register r8
add r8, r15                 ;r8 discards its value and the new value is r14
                            ;plus the value or whatever is in r15

mov rax, 0
mov rdi, sum_result         ;sum result is %d which is how you print an integer in C
mov rsi, r8
call printf

mov r9, r14                 ;mov the value that r14 holds into r9
mov r10, r15                ;mov the value that r15 holds into r10
imul r9, r10                ;imul used to multiply registers r9 and r10
                            ;r9 holds the new value while r10 remains the same

mov rax, 0
mov rdi, product_result
mov rsi, r9
call printf

ret
