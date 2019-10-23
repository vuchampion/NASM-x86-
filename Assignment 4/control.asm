;  Author name: Darren Vu
;  Author email: vuchampion@csu.fullerton.edu
;  Date of last update: October 19, 2019
;  Useful resource: http://www.egr.unlv.edu/~ed/assembly64.pdf
;  Page: 177

extern printf
extern scanf
extern fill
extern display
extern sum
extern clearerr
extern stdin

global control

segment .data

char_format db " %c", 0 ;https://stackoverflow.com/questions/27463964/scanf-function-skipped-in-x86-assembly
                        ;i need a space in front of this char format or else it skips the second scanf
                        ;https://stackoverflow.com/questions/6582322/what-does-space-in-scanf-mean/6582378#6582378
confirmation db "Are these values correct? (y/n)", 10, 0
random_msg db "This is a random message", 10, 0
ready_msg db "Are you ready? Press 'c' to continue. Press 'x' to exit.", 10, 0
ready_false db "You are not ready...", 10, 0
ready_true db "You are ready!", 10, 0
welcome_msg db "The control.asm module has begun executing", 10, 0
goodbye_msg db "You are leaving the control.asm module", 10, 0
print_register db "The sum of the array is: %ld ", 10, 0
clear_ss db "Clear stream state", 10, 0

segment .bss
array_one resq 10

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
mov r15, array_one

mov rax, 0
mov rdi, welcome_msg
call printf

mov rax, 0
mov rdi, ready_msg
call printf

push qword 0
push qword 0
mov rax, 0
mov rdi, char_format
mov rsi, rsp
call scanf
mov r14, [rsp]
pop rax
pop rax

cmp r14, 'c'
je continue
mov rax, 0
mov rdi, ready_false
call printf
jmp exit_program

continue:
mov rax, 0
mov rdi, ready_true
call printf

refill:
mov r13, 0
mov rax, 0
mov rdi, array_one
mov rsi, 10
call fill

mov r13, rax    ;r13 holds the size of the array

mov rax, 0
mov rdi, [stdin]
call clearerr

mov rax, 0
mov rdi, array_one
mov rsi, r13
call display

mov rax, 0
mov rdi, confirmation
call printf

push qword 0
push qword 0
mov rax, 0
mov rdi, char_format
mov rsi, rsp
call scanf
mov r13, [rsp]
pop rax
pop rax

cmp r13, 'y'
je correct
jmp refill

correct:
mov rax, 0
call sum

mov rax, 0
mov rdi, print_register
mov rsi, r14  ;contains the sum of our array
call printf

exit_program:
mov rax, 0
mov rdi, goodbye_msg
call printf

mov rax, r14  ;return code
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
