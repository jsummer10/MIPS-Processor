.data

.text
.globl main

main: 
    add     $t0, $0, $0
    add     $t1, $0, $0
    add     $t2, $0, $0
    addi    $t4, $0, 4
    addi    $t5, $0, 25

outterLoopStart:
    addi    $t0, $t0, 1     # i + 1

innerLoop:
    addi    $t2, $t2, 2
    addi    $t1, $t1, 1     # j + 1
    bne     $t1, $t4, innerLoop # if j < 4
    add     $t1, $0, $0

outterLoopEnd:
    bne     $t0, $t5, outterLoopStart   # if i < 25

done:
    j       done
    nop