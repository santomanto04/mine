/******************************************************************************
* @FILE p2_1001100648.s
* 
* Simple program to implement an iterative solution for computing the GCD of 
* two positive integers
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
    MOV R8, R2
    B _mainloop
    _loop1:
          MOV R1, R6
          MOV R2, R7
          SUB R8, R8, #1
          B _mainloop
    _mainloop:
          B _modloopcheck1
          
          _modloop1:
                SUB R1, R1, R8
            
          _modloopcheck1:
                CMP R1, R8
                BHS _modloop1
                
          B _modloopcheck2
          
          _modloop2:
                SUB R2, R2, R8
                
          _modloopcheck2:
                CMP R2, R8
                BHS _modloop2
          MOV R5, R1
          MOV R9, R2
          CMP R5, #0
          BNE _loop1
          CMP R9, #0
          BNE _loop1
          MOV R0, R8
          MOV PC, LR
          
    
    .data
Operand_Prompt: .asciz "Please enter a positive number: "
Input_Value: .asciz "%d"
Printf_Output: .asciz "The GCD of two given numbers is : %d\n"
