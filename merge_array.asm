%include "io64.inc"

section .data
array_a dq 2, 4, 6, 8, 10              ;Em caso de alteração de vetores para teste, mantê-los ordenados
array_b dq 1, 3, 5, 7, 9               
size_a dq 5                            ;Em caso de aumento no tamanho de algum vetor, alterar o respectivo size aqui
size_b dq 5

array_principal times 100 dq 0         ;Caso seja testado com size_a+size_b>100, alterar o tamanho do vetor principal aqui

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

   cmp rax, qword [size_a]             ;Para se vetor a e b completamente verificados
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
                                    
.removing_duplicates:                  ;Removendo números duplicados    
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
   jmp .loop                           ;Recomeça o looping

.end_loop:
   xor rsi, rsi

.loop_print:                           ;Print array_principal
   cmp rsi, r9
   jge .end_loop_print
   PRINT_DEC 8, [r8+rsi*8]
   PRINT_CHAR 32
   inc rsi
   jmp .loop_print

.end_loop_print:                       ;Print do valor mais alto e mais baixo do vetor
   NEWLINE
   PRINT_STRING 'O menor numero eh: '
   PRINT_DEC 8, [r8]
   NEWLINE
   PRINT_STRING 'O maior numero eh: '
   PRINT_DEC 8, [r8+(r9-1)*8]

   ret
