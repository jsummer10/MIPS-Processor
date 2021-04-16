.data
.text
.globl main

main:
    addi    $t0, $0, 4
    addi    $t0, $0, 8
    addi    $t0, $0, 12
    addi    $t0, $0, 16
    addi    $t0, $0, 20

    j       startTest

returnReg:
    addi    $sp, $sp, -4    # Make space on stack
    sw      $ra, 0($sp)     # Save return address

    add     $ra, $0, $0

    addi    $t0, $0, 12
    addi    $t1, $0, 14
    addi    $t2, $0, 16

    lw      $ra, 0($sp)     # restore the return address
    addi    $sp, $sp, 4     # adjust stack pointer to pop 1 item

    jr      $ra

startTest: 
    addi    $t0, $0, 2
    addi    $t1, $0, 4

    jal     returnReg

    addi    $t0, $0, 22
    addi    $t1, $0, 24
    j       done
    nop

done:
    j       done
    nop