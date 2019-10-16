extern printf

global sum

segment .data

segment .bss
sum_value resq 1

segment .text
welcome_message db "The sum.asm module has begun executing", 10, 0
print_i db "From Sum: register r10 contains: %ld", 10, 0

sum:

push rbp                                                    ;Backup the base pointer
mov  rbp,rsp                                                ;Advance the base pointer to start of the current stack frame
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
;push r10                                                    ;Backup r10
push r11                                                    ;Backup r11: printf often changes r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags
;--------------------------------------------------------------------------------------------------

mov rax, 0
mov rdi, welcome_message
call printf

mov r10, 0 ;sum of all the indexes
mov r8, [r15+8*0]
mov r9, [r15+8*1]
mov r11, [r15+8*2]
mov r12, [r15+8*3]
mov r13, [r15+8*4]

add r10, r8
add r10, r9
add r10, r11
add r10, r12
add r10, r13

mov rax, 0
mov rdi, print_i
mov rsi, r10
call printf

;--------------------------------------------------------------------------------------------------
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
;pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

mov rax, r10
ret
