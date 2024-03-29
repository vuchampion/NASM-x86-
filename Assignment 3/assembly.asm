extern printf
extern scanf
extern clearerr
extern stdin
global control_d

segment .data

intro_message db "Welcome, this program was built by Darren Vu", 10, 0
intro_message2 db "Let us compute using integers only. ", 0
prompt db "Enter a sequence of long integers seperated by white space. ", 0
prompt2 db "After the last input press Control+D.", 10, 0
failed_conditional db "You have selected to not repeat the program", 10, 0
integer_f db "%d", 0
char_f db "%c", 0
print_value db "The value that lies in this register is: %d", 10, 0
print_total_numbers db "The amount of numbers entered was: %d", 10, 0
print_mean db "The integer mean was: %d", 10, 0
rerun db "Do you have more sets of integers to process (y or n)? ",10, 0

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
mov r14, 0      ;Clear whatever lies in register r14
mov r13, 0
mov r8, 0

repeat:
mov rax, 0
mov rdi, prompt
call printf

mov r15, 0      ;Initialize the loop-counter to zero
mov r14, 0      ;Clear whatever lies in register r14
mov r13, 0
mov r8, 0

loop:           ;Start the loop
push qword 0    ;Scanf some integers
mov rax, 0
mov rdi, integer_f
mov rsi, rsp
call scanf
mov r13, [rsp]  ;Move the scanned value into register r13
pop rax

cdqe           ;What does this do again?
;cmp r13, 50     ;This works better than comparing rax to 0
cmp rax, 0      ;I think this tests for the CTRL-D input, unlike the notes,
                ;negative one does not seem to work but zero does
je exit_program ;If 0 is in rax then exit the program, if not then continue
add r14, r13    ;Add all scanned numbers into register r14, r14 holds the total
inc r15         ;One cycle equates to increasing r15 by one, in other words
                ;this is the amount of numbers we have scanf'd
jmp loop        ;Perform actions above then jump to loop:

exit_program:   ;Jumping out of the loop

mov rax, 0      ;This block of code clears the stream state
mov rdi, [stdin];Needed to extern stdin & clearerr
call clearerr

mov rax, r14
cqo
idiv r15        ;dividing this way gives the mean
mov r8, rax     ;r8 holds the quotient which is total value dividied by
                ;the number of integers that I scanned
mov rax, 0
mov rdi, print_mean
mov rsi, r8
call printf

mov rax, 0
mov rdi, rerun
call printf

push qword 0    ;This block scans a character into register r9
mov rax, 0      ;(y or n)
mov rdi, char_f
mov rsi, rsp
call scanf
mov r13, [rsp]
pop rax

cmp r13, 'y'
je repeat
mov rax, 0
mov rdi, failed_conditional
call printf
jmp continue

continue:
mov rax, 0
ret
