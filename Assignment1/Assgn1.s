# *********************************************************************************************************************
# Deepank Agrawal
# 17CS30011
# Compilers Assignment 1 
# Date:- 21/07/2019
# Add comments for each of the assembly language instruction. Your comment should explain
# the functionality of the instruction and the connection to the original C program.
# *********************************************************************************************************************
# include <stdio.h>
# define DIM 20
# void ReadMat(int n, int data[][DIM]);
# void TransMat(int n, int data[][DIM]);
# int VectMult(int n, int firstMat[], int secondMat[]);
# void MatMult(int n, int firstMat[][DIM], int secondMat[][DIM], int M[][DIM]);
# int main()
# {
#         int n, i, j;
#         int A[DIM][DIM],B[DIM][DIM],C[DIM][DIM];
#         printf("Enter the dimension of a square matrix: ");
#         scanf("%d", &n);
#         printf("Enter the first matix (row-major): ");
#         ReadMat(n, A);
#         printf("Enter the second matix (row-major): ");
#         ReadMat(n, B);
#         MatMult(n, A, B, C);
#         printf("\nThe result matrix:\n");
#         for(i=0; i<n; ++i){
#                 for(j=0; j<n; ++j) {
#                         printf("%d ", C[i][j]);
#                 }
#                 printf("\n");
#         }
#         return 0;
# }
# void ReadMat(int n, int data[][DIM])
# {
#         int i, j;
#         for(i=0; i<n; ++i) {
#                 for(j=0; j<n; ++j) {
#                         scanf("%d", &data[i][j]);
#                 }
#         }
# }
# void TransMat(int n, int data[][DIM])
# {
#         int i, j, t;
#         for(i=0; i<n; i++) {
#                 for(j=0; j<i; j++) {
#                         t = data[i][j];
#                         data[i][j] = data[j][i];
#                         data[j][i] = t;
#                 }
#         }
#         printf("\nThe transpose of the second matrix:\n");
#         for(i=0; i<n; ++i){
#                 for(j=0; j<n; ++j) {
#                         printf("%d ", data[i][j]);
#                 }
#                 printf("\n");
#         }
# }
# int VectMult(int n, int firstMat[], int secondMat[])
# {
#         int i, result = 0;
#         for(i=0; i<n; i++) {
#                 result+=firstMat[i]*secondMat[i];
#         }
#         return result;
# }
# void MatMult(int n, int firstMat[][DIM], int secondMat[][DIM], int M[][DIM])
# {
#         int i, j;
#         TransMat(n, secondMat);
#         for(i=0; i<n; i++) {
#                 for(j=0; j<n; j++) {
#                         M[i][j] = VectMult(n, &firstMat[i][0], &secondMat[j][0]);
#                 }
#         }
# }
# *********************************************************************************************************************



# *********************************************************************************************************************
	.file	"Assgn1.c"		# name of the source file
	.section	.rodata		# read-only data section
	.align 8				# align with 8-byte boundary
.LC0:						# Label of f-string-1st printf(which prints below statement in C)
	.string	"Enter the dimension of a square matrix: "
.LC1:						# Label of f-string scanf(which takes the input of dimension)
	.string	"%d"
	.align 8				# align with 8-byte boundary
.LC2:						# Label of f-string-2nd printf(which prints below statement in C)
	.string	"Enter the first matix (row-major): "
	.align 8				# align with 8-byte boundary
.LC3:						# Label of f-string-2nd printf(which prints below statement in C)
	.string	"Enter the second matix (row-major): "
.LC4:						# Label of f-string-2nd printf(which prints below statement in C)
	.string	"\nThe result matrix:"
.LC5:						# Label for printing the result of the matrix.
	.string	"%d "
	.text					# This part defines the start of code
	.globl	main 			# main is the global name
	.type	main, @function # main is a function: (i.e. type of main is function)
main:						# The main function starts
.LFB0:
	.cfi_startproc			# Initializes some internal data structures and emits initial CFI instructions.
	pushq	%rbp			# Save old base pointer 
	.cfi_def_cfa_offset 16  # Change rule for CFA to use offset 16. Register remains the same.
	.cfi_offset 6, -16		# Generate a rule saying that register 6 is saved at offset -16 from CFA.
	movq	%rsp, %rbp		# rbp <-- rsp, set new stack base pointer
	.cfi_def_cfa_register 6 # Change rule for CFA to use offset 6. Register remains the same.
	subq	$4832, %rsp		# Create space for local arrays and variables.
	movq	%fs:40, %rax	# Copy address of far segment + offset:40 to %rax
	movq	%rax, -8(%rbp)	# point to the 8 address below base pointer into the created space
	xorl	%eax, %eax 		# %eax = %eax^%eax ie %eax = 0
	movl	$.LC0, %edi		# Stores the address of the Label LC0 in %edi for printf
	movl	$0, %eax 		# printf has variable number of arguments
	call	printf			# Calls printf to print string stored in Label LC0
	leaq	-4828(%rbp), %rax	# point to 4 bytes address above base pointer to %rax in control stack
	movq	%rax, %rsi 			# copy that allocated space to scan new variable
	movl	$.LC1, %edi			# load the type format for scanning i.e. Label LC1.
	movl	$0, %eax 			# scanf has variable number of arguments
	call	__isoc99_scanf		# Calls scanf to scan dimension of matrix n
	movl	$.LC2, %edi			# Print message to scan first matrix A
	movl	$0, %eax 			# printf has variable number of arguments
	call	printf				# Call printf function to print message in Label LC2
	movl	-4828(%rbp), %eax 	# Store the second arguemnt of the function: n
	leaq	-4816(%rbp), %rdx	# Store the head pointer of the array to pass as first arguement
	movq	%rdx, %rsi 			# rsi stores the second arguement of the function: n
	movl	%eax, %edi			# edi stores the first arguement of the function: matrix A
	call	ReadMat 			# function call to ReadMat is made for scanning the matrix A
	movl	$.LC3, %edi			# store the address to the message to pass to printf
	movl	$0, %eax 			# set flag for printf as it has variable arguements
	call	printf				# call printf function to print the message
	movl	-4828(%rbp), %eax 	# address the second arguemnt of the function: n
	leaq	-3216(%rbp), %rdx	# Store the head pointer of the array to pass as first arguement
	movq	%rdx, %rsi 			# rsi stores the second arguement of the function: n
	movl	%eax, %edi			# edi stores the first arguement of the function: matrix B
	call	ReadMat 			# function call to ReadMat is made for scanning the matrix B
	movl	-4828(%rbp), %eax 	# store the address to the variable n to pass into MatMult function
	leaq	-1616(%rbp), %rcx	# store the address of matrix C as 4th arguement
	leaq	-3216(%rbp), %rdx	# store the address of matrix B as 3rd arguement
	leaq	-4816(%rbp), %rsi 	# store the address of matrix A as 2nd arguement
	movl	%eax, %edi			# store the first arguement : n in edi
	call	MatMult 			# function call to mutlipy A, B and store the result in C
	movl	$.LC4, %edi			# store the address of the print message to pass to the print function
	call	puts				# print the message using puts since only arguement is there.
	movl	$0, -4824(%rbp)		# store the iterator i with value 0
	jmp	.L2 					# start of the nested for loops
.L5:
	movl	$0, -4820(%rbp)		# assign j = 0 for the nested loop
	jmp	.L3
.L4:
	movl	-4820(%rbp), %eax 	# store j in the local variable eax
	movslq	%eax, %rcx			# to access the array element, convert j to signed integer and store in rcx
	movl	-4824(%rbp), %eax 	# store i in the local variable eax
	movslq	%eax, %rdx			# to access the array element, convert i to signed integer and store in rdx
	movq	%rdx, %rax			# storing i in rax to use for iteration in row-major form
	salq	$2, %rax			# rax shifted by 4 bytes to the left --> rax = rax*4
	addq	%rdx, %rax			# rax = 4*i + i = 5*i
	salq	$2, %rax			# rax = 4*(5*i) = 20*i
	addq	%rcx, %rax			# rax = 20*i + j = 20*n + column
	movl	-1616(%rbp,%rax,4), %eax 	# access C[i][j] and store in eax.
	movl	%eax, %esi			# pass result into second arguement of printf
	movl	$.LC5, %edi			# print message LC5 into first arguement of printf
	movl	$0, %eax 			# variable number of arguements for printf, eax = 0
	call	printf				# print the message and result
	addl	$1, -4820(%rbp)		# increment j by 1
.L3:
	movl	-4828(%rbp), %eax 	# store n in the variable eax
	cmpl	%eax, -4820(%rbp)	# compare j with n for iteration
	jl	.L4 					# start the for loop for nested iteration
	movl	$10, %edi			# if j >=n, pass newline character as ASCII code to print
	call	putchar				# print the new line character
	addl	$1, -4824(%rbp)		# increment i by 1
.L2:							# the outer for loop for printing the value
	movl	-4828(%rbp), %eax 	# store the value of n in the variable eax
	cmpl	%eax, -4824(%rbp)	# compare the iterator i with n
	jl	.L5 					# if i < n, proceed to nested loop
	movl	$0, %eax 			# preparing to end the main function
	movq	-8(%rbp), %rcx		# accessing the value stored initially from the far-segment with offset:40
	xorq	%fs:40, %rcx		# comparing the value with that in the far-segment with offset:40
	je	.L7 					# if matches, can exit without any stack error.
	call	__stack_chk_fail	# else, print stack error message
.L7:
	leave						# Copy EBP to ESP and then restore the old EBP from the stack
	.cfi_def_cfa 7, 8			# Set a rule for computing CFA to: take content of register 7 and add 8 to it.
	ret 						# Pop return address from stack and jump to popped address( Here it goes to the main function in C)
	.cfi_endproc				# Opens .eh_frame, generates appropriate binary structures (CIE, FDE) and sets up relocation records.
.LFE0:
	.size	main, .-main
	.globl	ReadMat 			# ReadMat is the global name
	.type	ReadMat, @function 	# ReadMat is a function
ReadMat:						# start of the function
.LFB1:
	.cfi_startproc			# Initializes some internal data structures and emits initial CFI instructions.
	pushq	%rbp			# Save old base pointer 
	.cfi_def_cfa_offset 16  # Change rule for CFA to use offset 16. Register remains the same.
	.cfi_offset 6, -16		# Generate a rule saying that register 6 is saved at offset -16 from CFA.
	movq	%rsp, %rbp		# rbp <-- rsp, set new stack base pointer
	.cfi_def_cfa_register 6 # Change rule for CFA to use offset 6. Register remains the same.
	subq	$32, %rsp		# allocate some space for local variables and arrays
	movl	%edi, -20(%rbp)	# store the first arguement in stack : n
	movq	%rsi, -32(%rbp) # store the second arguement in stack : head pointer for the array 
	movl	$0, -8(%rbp)	# assignment operation : i = 0
	jmp	.L9 				# iteration begins : enter the first for loop
.L12:
	movl	$0, -4(%rbp)	# assignment operation : j = 0
	jmp	.L10				# nested for loop starts
.L11:
	movl	-8(%rbp), %eax 	# store i in local variable eax
	movslq	%eax, %rdx		# to access the array element, convert i to signed integer and store in rdx
	movq	%rdx, %rax		# storing i in rax to use for iteration in row-major form
	salq	$2, %rax		# rax = 4*i
	addq	%rdx, %rax		# rax = 4*i + i = 5*i
	salq	$4, %rax		# rax = 80*i
	movq	%rax, %rdx		# rdx = 80*i
	movq	-32(%rbp), %rax	# store the head pointer of the array in rax
	addq	%rax, %rdx		# rdx = 80*i + arr[0]
	movl	-4(%rbp), %eax 	# eax = j
	cltq					# to access the array element, convert j to signed integer and store in rax
	salq	$2, %rax		# rax = 4*j
	addq	%rdx, %rax		# rax = arr + 80*i + 4*j
	movq	%rax, %rsi 		# store the value in rsi and pass as second arguement to scanf
	movl	$.LC1, %edi		# pass the string message in the first arguement to scanf
	movl	$0, %eax 		# set eax = 0 for scanf with variable number of arguements
	call	__isoc99_scanf 	# call scanf for getting matrix element
	addl	$1, -4(%rbp)	# increment j by 1
.L10:
	movl	-4(%rbp), %eax 		# store j in local variable eax
	cmpl	-20(%rbp), %eax 	# compare j and n
	jl	.L11					# if j < n, jump to L11
	addl	$1, -8(%rbp)		# increment i by 1
.L9:
	movl	-8(%rbp), %eax 		# store i in local variable eax
	cmpl	-20(%rbp), %eax 	# compare n and i
	jl	.L12 					# if i < n, jump to L12
	nop							# these command does nothing
	leave						# leave the function
	.cfi_def_cfa 7, 8			# return to main(same as commented in main)
	ret 						# Pop return address from stack and jump to popped address( Here it goes to the main function in C)
	.cfi_endproc				# Opens .eh_frame, generates appropriate binary structures (CIE, FDE) and sets up relocation records.
.LFE1:
	.size	ReadMat, .-ReadMat
	.section	.rodata			# this section is read-only
	.align 8					# align with 8-byte boundary
.LC6:
	.string	"\nThe transpose of the second matrix:"
	.text
	.globl	TransMat
	.type	TransMat, @function
TransMat:
.LFB2:
	.cfi_startproc			# Initializes some internal data structures and emits initial CFI instructions.
	pushq	%rbp			# Save old base pointer 
	.cfi_def_cfa_offset 16  # Change rule for CFA to use offset 16. Register remains the same.
	.cfi_offset 6, -16		# Generate a rule saying that register 6 is saved at offset -16 from CFA.
	movq	%rsp, %rbp		# rbp <-- rsp, set new stack base pointer
	.cfi_def_cfa_register 6 # Change rule for CFA to use offset 6. Register remains the same.
	subq	$32, %rsp		# allocate some space for local variables and arrays
	movl	%edi, -20(%rbp)	# store the first arguement in stack : n
	movq	%rsi, -32(%rbp) # store the second arguement in stack : head pointer for the array 
	movl	$0, -12(%rbp)	# iterator i = 0
	jmp	.L14				# jump to the for loops
.L17:
	movl	$0, -8(%rbp)	# iterator j = 0
	jmp	.L15				# jump to label 15
.L16:
	movl	-12(%rbp), %eax # store i in local variable eax
	movslq	%eax, %rdx		# to access the array element, convert i to signed integer and store in rdx
	movq	%rdx, %rax		# rax = rdx = i
	salq	$2, %rax		# rax = 4*i
	addq	%rdx, %rax		# rax = 4*i + i = 5*i
	salq	$4, %rax		# rax = 20*i
	movq	%rax, %rdx		# rdx = 20*i
	movq	-32(%rbp), %rax # rax = arr[0] address
	addq	%rax, %rdx		# rdx = 20*i + arr[0]
	movl	-8(%rbp), %eax 	# store j in local variable eax
	cltq					# to access the array element, convert j to signed integer and store in rax
	movl	(%rdx,%rax,4), %eax 	# eax = arr[0] + 80*i + 4*j
	movl	%eax, -4(%rbp)	# store data[i][j] into temp variable for swaping
	movl	-12(%rbp), %eax # move i into eax: eax = i
	movslq	%eax, %rdx		# to access the array element, convert i to signed integer and store in rdx
	movq	%rdx, %rax		# rax = rdx = i
	salq	$2, %rax		# rax = 4*i
	addq	%rdx, %rax		# rax = 4*i + i = 5*i
	salq	$4, %rax		# rax = 80*i
	movq	%rax, %rdx		# rdx = 80*i
	movq	-32(%rbp), %rax	# rax = arr[0]
	leaq	(%rdx,%rax), %rcx 	# rcx = 80*i + 1*rax = 80*i + arr[0]
	movl	-8(%rbp), %eax 	# store j in local variable eax
	movslq	%eax, %rdx		# to access the array element, convert j to signed integer and store in rdx
	movq	%rdx, %rax		# rax = rdx = j
	salq	$2, %rax		# rax = 4*j
	addq	%rdx, %rax		# rax = 4*j + j = 5*j
	salq	$4, %rax		# rax = 80*j
	movq	%rax, %rdx		# rdx = 80*j
	movq	-32(%rbp), %rax # rax = arr[0]
	addq	%rax, %rdx		# rdx = 80*j + arr[0]
	movl	-12(%rbp), %eax # eax = i
	cltq					# to access the array element, convert i to signed integer and store in rax
	movl	(%rdx,%rax,4), %edx		# edx = arr[0] + 80*j + 4*i = arr[j][i]
	movl	-8(%rbp), %eax 	# eax = j
	cltq					# to access the array element, convert j to signed integer and store in rax
	movl	%edx, (%rcx,%rax,4)		# rcx + 4*rax = edx = arr[0] + 80*i + 4*j ==> arr[j][i] = arr[i][j]
	movl	-8(%rbp), %eax 		# eax = j
	movslq	%eax, %rdx			# to access the array element, convert j to signed integer and store in rdx
	movq	%rdx, %rax			# rax = rdx = j
	salq	$2, %rax			# rax = 4*j
	addq	%rdx, %rax			# rax = 4*j + j = 5*j
	salq	$4, %rax			# rax = 80*j
	movq	%rax, %rdx			# rdx = 80*j
	movq	-32(%rbp), %rax		# rax = arr[0]
	leaq	(%rdx,%rax), %rcx	# rcx = arr[0] + 80*j
	movl	-12(%rbp), %eax 	# eax = i
	cltq						# to access the array element, convert i to signed integer and store in rdx
	movl	-4(%rbp), %edx		# edx = temp
	movl	%edx, (%rcx,%rax,4)	# arr[j][i] = temp
	addl	$1, -8(%rbp)		# increment j by 1
.L15:
	movl	-8(%rbp), %eax 		# store j in local variable eax
	cmpl	-12(%rbp), %eax 	# compare j and n
	jl	.L16					# if j < n, jump to L16
	addl	$1, -12(%rbp)		# increment i  by 1
.L14:
	movl	-12(%rbp), %eax 	# store i in local variable eax
	cmpl	-20(%rbp), %eax 	# compare i and n
	jl	.L17					# if i < n, jump to L17
	movl	$.LC6, %edi			# store the print message address to edi 
	call	puts				# print the print message
	movl	$0, -12(%rbp)		# update i = 0
	jmp	.L18					# jump to L18 for printing of the transpose
.L21:
	movl	$0, -8(%rbp)		# store j = 0 for iteration
	jmp	.L19					# jump to L19
.L20:
	movl	-12(%rbp), %eax 	# store i in local variable eax
	movslq	%eax, %rdx			# to access the array element, convert i to signed integer and store in rdx
	movq	%rdx, %rax			# rax = rdx = i
	salq	$2, %rax			# rax = 4*i
	addq	%rdx, %rax			# rax = 4*i + i = 5*i
	salq	$4, %rax			# rax = 80*i
	movq	%rax, %rdx			# rdx = rax = 80*i
	movq	-32(%rbp), %rax		# rax = arr[0], the head pointer of the array
	addq	%rax, %rdx			# rdx = 80*i + arr[0]
	movl	-8(%rbp), %eax 		# store j in local variable eax
	cltq						# to access the array element, convert j to signed integer and store in rdx
	movl	(%rdx,%rax,4), %eax # eax = arr[0] + 80*i + j = arr[i][j]
	movl	%eax, %esi			# pass the arr[i][j] as the second arguement to printf
	movl	$.LC5, %edi			# pass the print message as first arguement to printf
	movl	$0, %eax 			# since printf has variable number of arguements
	call	printf				# Call printf to print values
	addl	$1, -8(%rbp)		# increment j by 1
.L19:
	movl	-8(%rbp), %eax 		# eax = j
	cmpl	-20(%rbp), %eax 	# compare j and n
	jl	.L20					# if j < n, jump to L20
	movl	$10, %edi			# pass the new line character as ASCII code
	call	putchar				# print the new line character
	addl	$1, -12(%rbp)		# increment i by 1
.L18:
	movl	-12(%rbp), %eax 	# eax = i
	cmpl	-20(%rbp), %eax 	# compare i and n
	jl	.L21 					# if i < n, jump to L21
	nop							# these is for no operation
	leave						# leave the function and return to callee
	.cfi_def_cfa 7, 8			# return to main(same as commented in main)
	ret 						# Pop return address from stack and jump to popped address( Here it goes to the main function in C)
	.cfi_endproc				# Opens .eh_frame, generates appropriate binary structures (CIE, FDE) and sets up relocation records.
.LFE2:
	.size	TransMat, .-TransMat
	.globl	VectMult
	.type	VectMult, @function
VectMult:						# the vector multiply routine
.LFB3:
	.cfi_startproc			# Initializes some internal data structures and emits initial CFI instructions.
	pushq	%rbp			# Save old base pointer 
	.cfi_def_cfa_offset 16  # Change rule for CFA to use offset 16. Register remains the same.
	.cfi_offset 6, -16		# Generate a rule saying that register 6 is saved at offset -16 from CFA.
	movq	%rsp, %rbp		# rbp <-- rsp, set new stack base pointer
	.cfi_def_cfa_register 6 # Change rule for CFA to use offset 6. Register remains the same.
	movl	%edi, -20(%rbp)	# store the first arguement of the function in the stack: n
	movq	%rsi, -32(%rbp)	# store the 2nd arguement i.e. a row of the matrix A
	movq	%rdx, -40(%rbp)	# store the 3rd arguement i.e. a column of the matrix B
	movl	$0, -4(%rbp)	# init result = 0
	movl	$0, -8(%rbp)	# init i = 0
	jmp	.L23				# start the for loop
.L24:
	movl	-8(%rbp), %eax 	# store i in local variable eax
	cltq					# type cast i into signed integer to access the array index, and store in rax
	leaq	0(,%rax,4), %rdx	# load effective address of i in rdx
	movq	-32(%rbp), %rax		# store A's head pointer in a local variable rax
	addq	%rdx, %rax			# rax = 4*i + A[0]
	movl	(%rax), %edx		# store the A[i] element in edx
	movl	-8(%rbp), %eax 		# store i in local variable eax
	cltq						# type cast i into signed integer to access the array index, and store in rax
	leaq	0(,%rax,4), %rcx	# load effective address of i in rcx
	movq	-40(%rbp), %rax		# store B's head pointer in a local variable rax
	addq	%rcx, %rax			# rax = 4*i + B[0]
	movl	(%rax), %eax 		# store the B[i] element in eax
	imull	%edx, %eax 			# multiply A[i] and B[i] and store in eax
	addl	%eax, -4(%rbp)		# add A[i]*B[i] to the result
	addl	$1, -8(%rbp)		# increment i by 1
.L23:
	movl	-8(%rbp), %eax 	# store i in local variable eax
	cmpl	-20(%rbp), %eax # comapre i with n
	jl	.L24				# iterate the loop
	movl	-4(%rbp), %eax 	# store the result for returning
	popq	%rbp			# empty the temp base pointer
	.cfi_def_cfa 7, 8			# return to main(same as commented in main)
	ret 						# Pop return address from stack and jump to popped address( Here it goes to the matrix multiplication in C)
	.cfi_endproc				# Opens .eh_frame, generates appropriate binary structures (CIE, FDE) and sets up relocation records.
.LFE3:
	.size	VectMult, .-VectMult
	.globl	MatMult
	.type	MatMult, @function
MatMult:					# function for matrix multiplication
.LFB4:
	.cfi_startproc			# Initializes some internal data structures and emits initial CFI instructions.
	pushq	%rbp			# Save old base pointer 
	.cfi_def_cfa_offset 16  # Change rule for CFA to use offset 16. Register remains the same.
	.cfi_offset 6, -16		# Generate a rule saying that register 6 is saved at offset -16 from CFA.
	movq	%rsp, %rbp		# rbp <-- rsp, set new stack base pointer
	.cfi_def_cfa_register 6 # Change rule for CFA to use offset 6. Register remains the same.
	pushq	%rbx
	subq	$56, %rsp		# create space for local variables and arrays
	.cfi_offset 3, -24		# Generate a rule saying that register 3 is saved at offset -24 from CFA.
	movl	%edi, -36(%rbp)	# store the 1st agruement: n
	movq	%rsi, -48(%rbp)	# store A
	movq	%rdx, -56(%rbp)	# store B
	movq	%rcx, -64(%rbp)	# store C
	movq	-56(%rbp), %rdx	# store B to pass 2nd agruement into TransMat
	movl	-36(%rbp), %eax # store n to pass 1st arguement into TransMat
	movq	%rdx, %rsi 		# 2nd arguement of the function
	movl	%eax, %edi		# 1st arguement of the function
	call	TransMat 		# Call the TransMat function to take transpose of B
	movl	$0, -24(%rbp)	# init i = 0
	jmp	.L27				# jump to L27 to start for loops
.L30:
	movl	$0, -20(%rbp)	# init j = 0
	jmp	.L28				# jump to L28 for nested for loop
.L29:
	movl	-24(%rbp), %eax # store i in local variable eax
	movslq	%eax, %rdx		# type case i into signed integer to access array element
	movq	%rdx, %rax		# rax = i
	salq	$2, %rax		# rax = 4*i
	addq	%rdx, %rax		# rax = 4*i + i = 5*i
	salq	$4, %rax		# rax = 80*i
	movq	%rax, %rdx		# rdx = 80*i
	movq	-64(%rbp), %rax		# load C head pointer in rax
	leaq	(%rdx,%rax), %rbx	# rbx = 80*i + C[0] = &C[i]
	movl	-20(%rbp), %eax 	# move j into eax
	movslq	%eax, %rdx			# rdx = j with j being signed for array access
	movq	%rdx, %rax			# rax = rdx = j
	salq	$2, %rax			# rax = 4*j
	addq	%rdx, %rax			# rax = 4*j + j = 5*j
	salq	$4, %rax			# rax = 80*j
	movq	%rax, %rdx			# rdx = 80*j
	movq	-56(%rbp), %rax		# store B head pointer into rax
	addq	%rdx, %rax			# rax = B[0] + 80*j = &B[j]
	movq	%rax, %rsi 			# pass B[i] as 3rd arguement for the VectMult function
	movl	-24(%rbp), %eax 	# store i in eax
	movslq	%eax, %rdx			# type cast i into signed for array access
	movq	%rdx, %rax			# rax = rdx = i
	salq	$2, %rax			# rax = 4*i
	addq	%rdx, %rax			# rax = 4*i + i = 5*i
	salq	$4, %rax			# rax = 80*i
	movq	%rax, %rdx			# rdx = 80*i
	movq	-48(%rbp), %rax		# load A head pointer into rax
	addq	%rdx, %rax			# rax = A[0] + 80*i = A[i]
	movq	%rax, %rcx			# rcx = A[i], 2nd arguement of the VectMult function
	movl	-36(%rbp), %eax 	# load n as 1st arguement of the VectMult function
	movq	%rsi, %rdx			# rdx is the 3rd arguement, so pass B[i] into it
	movq	%rcx, %rsi 			# rsi is the 2nd arguement, so pass A[i] into it
	movl	%eax, %edi			# pass n into edi as the 1st arguement
	call	VectMult 			# Call the function VectMult
	movl	%eax, %edx 			# store n into edx
	movl	-20(%rbp), %eax 	# store j in eax
	cltq						# type cast into signed for array access, and store in rax
	movl	%edx, (%rbx,%rax,4)	# store return value edx in C[i] + 4*j = C[i][j]
	addl	$1, -20(%rbp)		# increment j by 1
.L28:
	movl	-20(%rbp), %eax 		# move j to eax
	cmpl	-36(%rbp), %eax 		# compare j with n
	jl	.L29						# jump if j < n
	addl	$1, -24(%rbp)			# increment i by 1
.L27:
	movl	-24(%rbp), %eax 		# store i in local variable in eax
	cmpl	-36(%rbp), %eax 		# compare i and n
	jl	.L30						# jump if i < n
	nop								# this no operation command
	addq	$56, %rsp
	popq	%rbx					# pop the declared variable
	popq	%rbp					# pop the local base pointer
	.cfi_def_cfa 7, 8			# return to main(same as commented in main)
	ret 						# Pop return address from stack and jump to popped address( Here it goes to the main function in C)
	.cfi_endproc				# Opens .eh_frame, generates appropriate binary structures (CIE, FDE) and sets up relocation records.
.LFE4:
	.size	MatMult, .-MatMult
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
