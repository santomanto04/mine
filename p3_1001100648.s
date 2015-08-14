/******************************************************************************
* @FILE p3_1001100648.s
* 
* Simple program to implement Euclid's algorithms for computing the GCD of 
* two positive integers recursively
*
* @AUTHOR Santosh Pradhan
******************************************************************************/    

  .global main
  .func main
main:
    BL _Operand                         @ branch to _Operand procedure with return
    MOV R5, R0                          @ move return value from R0 to R5
    BL _Operand                         @ branch to _Operand procedure with return
    MOV R6, R0                          @ move return value from R0 to R6
    MOV R1, R5                          @ move R5 to R1
    MOV R2, R6                          @ move R6 to R2
    BL GCD_EUCLID                       @ branch to GCD_ITERATIVE procedure with return
    MOV R1, R0                          @ move R0 to R1
    LDR R0, =Printf_Output              @ R0 contains formatted string address
    BL printf                           @ call printf
    B main                              @ call main (to form a loop)
    
_Operand:
    MOV R4, LR                          @ store LR since printf call overwrites
    SUB SP, SP, #4                      @ make room for stack
    LDR R0, =Operand_Prompt             @ RO contains formatted string address
    BL printf                           @ call printf
    LDR R0, =Input_Value                @ R0 contains formatted string address
    MOV R1, SP                          @ move SP to R1 to store entry of stack
    BL scanf                            @ call scanf
    LDR R0, [SP]                        @ load value at SP into R0
    ADD SP, SP, #4                      @ remove value from stack
    MOV PC, R4                          @ return
    
GCD_EUCLID:
    PUSH {LR}                           @ store the return address
    CMP R2, #0                          @ compare the input argument to 0
    MOVEQ R0, R1                        @ set return value to R1 if equal
    POPEQ {PC}                          @ restore stack pointer and return if equal
    
    CMP R1, R2                          @ check to see if R1 >= R2
    MOVHS R4, #1                        @ swap R4 and 1 if 1 > R4
    CMP R2, #0                          @ compare the input argument to 0
    MOVGT R5, #1                        @ overrite R5 with 1 if 1 > R5
    B _modCheck                         @ call _modCheck
    
    _mod1:
          SUB R1, R1, R2                @ subtract R2 from R1 and copy to R1
    _modCheck:
          CMP R1, R2                    @ check to see if R1 >= R7
          BHS _mod1                     @ continue loop if R1 >= R7
          MOV R0, R1                    @ move R1 to R0
    
    MOV R1, R2                          @ copy input register R2 to input register R1
    MOV R2, R0                          @ copy return register R0 to input register R2
    CMP R4, R5                          @ check to see if R4 >= R5
    MOV R4, #0                          @ set a constant value for printing
    MOV R5, #0                          @ set a constant value for printing
    BEQ GCD_EUCLID                      @ branch to equal handler
    POP {PC}                            @ restore the stack pointer and return
    
    
    .data
Operand_Prompt: .asciz "Please enter a positive number: "
Input_Value: .asciz "%d"
Printf_Output: .asciz "The GCD of two given numbers is : %d\n"
