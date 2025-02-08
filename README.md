<h1 align="center"> Merging arrays with assembly </h1>
This project was created to learn the basics of assembly programming by solving a common problem: **merging two sorted arrays while removing duplicates**.
The idea was first implemented in **C**, then manually translated into **x86-64 NASM assembly**. 

 ## Repository Contents
- **`merge_array.c`** – The initial implementation in C, later translated into assembly.
- **`merge_array.asm`** – The assembly version, written using NASM (x86-64).
- **`Makefile`** – Used to compile and run the C code.
- **`io64.inc`** – A library required for the assembly code. This file must be in the same directory as `merge_array.asm`.
