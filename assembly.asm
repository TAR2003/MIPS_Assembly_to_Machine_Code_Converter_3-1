addi $t1, $zero, 3
addi $t0, $zero, 4
sub $t2, $t0, $t1
addi $t2, $zero, 5
subi $t2, $t2, 3
beq $t0, $t1, cd
bneq $t0, $t1, cd
cd: addi $t1, $t1, 1
beq $t0, $t1, ab
bneq $t0, $t1, ab
ab: sll $t1, $t1, 1
addi $t1, $t1, 0
srl $t1, $t1, 2
addi $t1, $t1, 0
add $t4, $t0, $t1
addi $t4, $t4, 0
addi $t0, $zero, 5
addi $t1, $zero, 15
or $t4, $t0, $t1
addi $t4, $zero, 0
ori $t0, $t0, 12
addi $t0, $t0, 0
and $t4, $t0, $t1
addi $t4, $t4, 0
andi $t3, $t0, 15
addi $t3, $t3, 0
nor $t4, $t0, $t1
addi $t4, $t4, 0
addi $t4, $zero, 3
addi $t3, $zero, 4
addi $t1, $zero, 0
push $t4
push $t4
sw $t4, 2($t3)
addi $t3, $zero, 5
lw $t2, 1($t3)
addi $t2, $t2, 0
lvl: addi $t1, $zero, 0
addi $t2, $zero, 0
beq $t1, $t2, lvl
pop $t2
pop $t4
j cd
j ab