%include "io64.inc"

section .data
array_a dq 1, 2, 3, 4, 5               ;Keep the array sorted in case of other tests
array_b dq 4, 5, 6, 7, 8               
size_a dq 5                            ;Change the size of the respective array if needed
size_b dq 5

array_principal times 100 dq 0         ;If tested with size_a+size_b>100, change the size of the array_principal

section .text
global main

main:
   mov r8, array_principal             ;array_principal
   mov r9, qword [size_a]              ;size_principal 
   add r9, qword [size_b]                 

   mov r10, array_a                    ;array_a
   mov r11, array_b                    ;array_b
   mov rax, 0                          ;checkpoint_a
   mov rbx, 0                          ;checkpoint_b

   mov rsi, 0                          ;i
    
.loop:
   cmp rsi, r9
   jge .end_loop

   cmp rax, qword [size_a]             ;Stop if array a and b fully verified
   jne .insert_a_b
   cmp rbx, qword [size_b]
   jne .insert_a_b
   mov rsi, r9
   jmp .loop

.insert_a_b:                           ;Merging
   cmp rax, qword [size_a]
   jge .end_array_a
   cmp rbx, qword [size_b]
   jge .end_array_a

   mov r14, qword [r10+rax*8]
   mov r15, qword [r11+rbx*8]
   cmp r14, r15
   jge .insert_array_b
   mov qword [r8+rsi*8], r14           
   inc rax
   jmp .removing_duplicates

.insert_array_b:
   mov qword [r8+rsi*8], r15
   inc rbx
   jmp .removing_duplicates

.end_array_a:
   cmp rax, qword [size_a]
   jl .end_array_b
   mov r15, qword [r11+rbx*8]
   mov qword [r8+rsi*8], r15 
   inc rbx
   jmp .removing_duplicates

.end_array_b:
   cmp rbx, qword [size_b]
   jl .removing_duplicates
   mov r14, qword [r10+rax*8]
   mov qword [r8+rsi*8], r14
   inc rax
                                    
.removing_duplicates:                  ;Removing duplicates
   cmp rsi, 0
   jle .end_if
   mov r14, qword [r8+rsi*8]
   mov r15, qword [r8+(rsi-1)*8]
   cmp r14, r15
   jne .end_if
   dec rsi
   dec r9

.end_if:
   inc rsi
   jmp .loop                           ;Restarting the loop

.end_loop:
   xor rsi, rsi

.loop_print:                           ;Print array_principal
   cmp rsi, r9
   jge .end_loop_print
   PRINT_DEC 8, [r8+rsi*8]
   PRINT_CHAR 32
   inc rsi
   jmp .loop_print

.end_loop_print:                       ;Print of the lowest/highest value
   NEWLINE
   PRINT_STRING 'O menor numero eh: '
   PRINT_DEC 8, [r8]
   NEWLINE
   PRINT_STRING 'O maior numero eh: '
   PRINT_DEC 8, [r8+(r9-1)*8]

   ret
