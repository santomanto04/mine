/******************************************************************************
* @FILE p2_1001100648.s
* @BRIEF simple calculator for the Raspbian OS using ARM assembly
*
* Simple program to find sum, difference, product and maximum out of 2 numbers
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
    BL GCD_ITERATIVE                    @ branch to GCD_ITERATIVE procedure with return
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
    
GCD_ITERATIVE:
    CMP      R2, R1
    SUBGT    R0, R2, R1
    SUBLE    R0, R0, R1
    BNE      GCD_ITERATIVE
  
    
    .data
Operand_Prompt: .asciz "Please enter a positive number: "
Input_Value: .asciz "%d"
Printf_Output: .asciz "The GCD of two given numbers is : %d\n"
