.global main
.func main

main:
    BL _Operand
    MOV R5, R0
    BL _Operation_Code
    MOV R6, R0
    BL _Operand
    MOV R7, R0
    MOV R1, R5
    MOV R2, R6
    MOV R3, R7
    BL _Compare
    MOV R1, R0
    BL _Print
    B main
    
_Operand:
    MOV R4, LR
    SuB SP, SP #4
    LDR R0, =Operand_Prompt
    BL printf
    LDR R0, =Input_Value
    MOV R1, SP
    BL scanf
    LDR R0, [SP]
    MOV PC, #4
    
_Operation_Code:
    MOV R4, LR
    SuB SP, SP #4
    LDR R0, =Operation_Code_Prompt
    BL printf
    LDR R0, =Input_Operator
    MOV R1, SP
    BL scanf
    LDR R0, [SP]
    ADD SP, SP, #4
    MOV PC, #4
    
_Compare:
    CMP R1, # '+'
    BEQ _Sum
    CMP R1, # '-'
    BEQ _Difference
    CMP R1, # '*'
    BEQ _Product
    CMP R1, # 'M'
    BEQ _Max

_Print:
    MOV R4, LR 
    LDR R0, =Printf_Output
    BL printf
    MOV PC, LR

_Sum:
    ADD R0, R1, R2
    MOV PC, LR
    
_Difference:
    SUB R0, R1, R2
    MOV PC, LR
    
_Product:
    MUL R0, R1, R2
    MOV PC, LR

_Max:
    CMP R1, R2
    MOVGT R0, R1
    MOVLT R0, R2
    MOV PC, LR
    
.data
Operand_Prompt: .asciz "Please enter a positive number: "
Input_Value: .asciz "%d"
Operation_Code_Prompt: .asciz "Please enter one of the operation code from (+,-,*,m): "
Input_Operator: .asciz "%s"
Printf_Output: .asciz "The output based on the entered operation code is : %d\n"
    
    
    
