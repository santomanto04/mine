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
    MOV R3, R6
    MOV R2, R7
    BL _Compare
    MOV R1, R0
    LDR R0, =Printf_Output
    BL printf
    B main
    
_Operand:
    MOV R4, LR
    SUB SP, SP #4
    LDR R0, =Operand_Prompt
    BL printf
    LDR R0, =Input_Value
    MOV R1, SP
    BL scanf
    LDR R0, [SP]
    ADD SP, SP, #4
    MOV PC, R4
    
_Operation_Code:
    MOV R4, LR
    SUB SP, SP #4
    LDR R0, =Operation_Code_Prompt
    BL printf
    LDR R0, =Input_Operator
    MOV R1, SP
    BL scanf
    LDR R0, [SP]
    ADD SP, SP, #4
    MOV PC, R4
    
_Compare:
    CMP R3, # '+'
    BEQ _Sum
    CMP R3, # '-'
    BEQ _Difference
    CMP R3, # '*'
    BEQ _Product
    CMP R3, # 'M'
    BEQ _Max

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
Operation_Code_Prompt: .asciz "Please enter one of the operation code from (+,-,*,M): "
Input_Operator: .asciz "%s"
Printf_Output: .asciz "The output based on the entered operation code is : %d\n"
    
    
    
