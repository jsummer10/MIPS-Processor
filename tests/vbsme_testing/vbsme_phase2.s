
########################################################################################################################
### data
########################################################################################################################
.data

asize1:  .word    32, 32, 8, 16    #i, j, k, l
frame1:  .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8,
         
window1: .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 
         
newline: .asciiz     "\n" 


#####################################################################
### vbsme
#####################################################################

.text
.globl  vbsme

# Preconditions:
#   1st parameter (a0) address of the first element of the dimension info (address of asize[0])
#   2nd parameter (a1) address of the first element of the frame array (address of frame[0][0])
#   3rd parameter (a2) address of the first element of the window array (address of window[0][0])
# Postconditions:	
#   result (v0) x coordinate of the block in the frame with the minimum SAD
#          (v1) y coordinate of the block in the frame with the minimum SAD


# ------------------------------------------------------------------
# Name      : vbsme
# Purpose   : This function finds the section of the frame that 
#             resembles the provided window the closest
#
# Arguments : a0 = window
#             a1 = frame
#             a2 = asize (frame_y, frame_x, window_y, window_x)
#             
#             
#
# Return    : v0 = x-coordinate of the section with the smallest SAD
#             v1 = y-coordinate of the section with the smallest SAD
#
# Notes     : s0 = starting point index(y, x)
#             s2 = buffers (top, right, bottom, left)
#             s3 = smallest_SAD
#             s4 = direction
#             s5 = direction_changes
# ------------------------------------------------------------------

vbsme:

    add     $t0, $a0, $0
    add     $t1, $a2, $0
    add     $a0, $t1, $0
    add     $a2, $t0, $0    # Swap $a0 and $a2

    ori     $a3, $0, 0      # starting point (y,x)

    add     $s1, $0, $0     # 
    add     $s2, $0, $0     # 
    add     $s4, $0, $0
    add     $s5, $0, $0

    #-------------------------------------
    # initial getSAD function call
    #-------------------------------------

    jal     getSAD

    add     $s3, $s1, $0        # cur_sad value

    add     $s1, $s1, $0        # reset $s1

vbsmeLoop:
    
    addi    $t0, $0, 0
    beq     $t0, $s4, vbsmeDirection1

    addi    $t1, $0, 1
    beq     $t1, $s4, vbsmeDirection2

    addi    $t2, $0, 2
    beq     $t2, $s4, vbsmeDirection3

    addi    $t3, $0, 3
    beq     $t3, $s4, vbsmeDirection4

#-------------
# Direction 1
#-------------

vbsmeDirection1:                # top-left to top-right
  
    eh      $t0, $a3, 1         # (x) starting_point[1]     // CUSTOM INSTRUCTION - Extract Half

    lw      $t1, 12($a2)        # asize[3]
    lw      $t2,  4($a2)        # asize[1]

    eb      $t3, $s2, 1         # right_buffer              // CUSTOM INSTRUCTION - Extract Byte

    add     $t1, $t0, $t1
    sub     $t2, $t2, $t3

    slt     $t1, $t1, $t2       # starting_point[0] + asize[2] < asize[0] - right_buffer
    beq     $t1, $0, vbsmeChangeDir1

    ih      $a3, $a3, 1         # (x) starting_point[1] ++  // CUSTOM INSTRUCTION - Increment Half

    add     $s5, $0, $0         # direction_changes = 0;
    j       vbsmeTransition

vbsmeChangeDir1:
    
    ib      $s2, $s2, 0         # top_buffer ++             // CUSTOM INSTRUCTION - Increment Byte

    addi    $s4, $0, 1          # direction = 1;
    addi    $s5, $s5, 1         # direction_changes ++;
    j       vbsmeTransition


#-------------
# Direction 2
#-------------

vbsmeDirection2:                # top-right to bottom-right

    eh      $t0, $a3, 0         # (y) starting_point[0] // CUSTOM INSTRUCTION - Extract Half

    lw      $t1,  8($a2)        # asize[2]
    lw      $t2,  0($a2)        # asize[0]

    eb      $t3, $s2, 2         # bottom_buffer         // CUSTOM INSTRUCTION - Extract Byte

    add     $t1, $t0, $t1
    sub     $t2, $t2, $t3

    slt     $t1, $t1, $t2       # starting_point[0] + asize[2] < asize[0] - bottom_buffer
    beq     $t1, $0, vbsmeChangeDir2

    ih      $a3, $a3, 0         # (y) starting_point[0] ++  // CUSTOM INSTRUCTION - Increment Half

    add     $s5, $0, $0         # direction_changes = 0;
    j       vbsmeTransition

vbsmeChangeDir2:
    
    ib      $s2, $s2, 1         # right_buffer ++       // CUSTOM INSTRUCTION - Increment Byte

    addi    $s4, $0, 2          # direction = 2;
    addi    $s5, $s5, 1         # direction_changes ++;
    j       vbsmeTransition


#-------------
# Direction 3
#-------------

vbsmeDirection3:                # bottom-right to bottom-left

    eh      $t0, $a3, 1         # (x) starting_point[1] // CUSTOM INSTRUCTION - Extract Half

    eb      $t1, $s2, 3         # left_buffer         // CUSTOM INSTRUCTION - Extract Byte

    slt     $t1, $t1, $t0       # left_buffer < starting_point[1]
    beq     $t1, $0, vbsmeChangeDir3

    dh      $a3, $a3, 1         # (x) starting_point[1] --  // CUSTOM INSTRUCTION - Decrement Half

    add     $s5, $0, $0         # direction_changes = 0;
    j       vbsmeTransition

vbsmeChangeDir3:
    
    ib      $s2, $s2, 2         # bottom_buffer ++      // CUSTOM INSTRUCTION - Increment Byte

    addi    $s4, $0, 3          # direction = 3;
    addi    $s5, $s5, 1         # direction_changes ++;
    j       vbsmeTransition


#-------------
# Direction 4
#-------------

vbsmeDirection4:                # bottom-left to top-left

    eh      $t0, $a3, 0         # (y) starting_point[0] // CUSTOM INSTRUCTION - Extract Half

    eb      $t1, $s2, 0         # top_buffer         // CUSTOM INSTRUCTION - Extract Byte

    slt     $t1, $t1, $t0       # top_buffer < starting_point[0]
    beq     $t1, $0, vbsmeChangeDir4

    dh      $a3, $a3, 0         # (y) starting_point[0] --  // CUSTOM INSTRUCTION - Decrement Half

    add     $s5, $0, $0         # direction_changes = 0;
    j       vbsmeTransition

vbsmeChangeDir4:
    
    ib      $s2, $s2, 3         # left_buffer ++        // CUSTOM INSTRUCTION - Increment Byte

    addi    $s4, $0, 0          # direction = 0;
    addi    $s5, $s5, 1         # direction_changes ++;


#------------
# Transition 
#------------

vbsmeTransition:

    beq     $s5, $0, vbsmeGetSAD

    addi    $t0, $0, 4
    beq     $s5, $t0, vbsmeDone

    j       vbsmeLoop


#-------------
# Get New SAD 
#-------------

vbsmeGetSAD:

    #-------------------------------------
    # getSAD function call
    #-------------------------------------

    jal     getSAD

    add     $t0, $s1, $0        # cur_sad value
    addi    $s1, $s1, 0         # reset $s1

    #-------------
    # Compare SAD
    #-------------

    slt     $t1, $t0, $s3
    beq     $t1, $0, vbsmeLoop  # if cur_SAD >= smallest_SAD -> loop again

    add     $s3, $t0, $0        # smallest_SAD = cur_SAD;
    
    eh      $v0, $a3, 1         # x-coordinate      // CUSTOM INSTRUCTION - Extract Half
    eh      $v1, $a3, 0         # y-coordinate      // CUSTOM INSTRUCTION - Extract Half

    bne     $t0, $0, vbsmeLoop  # if current SAD != 0 -> loop again

#-----------
# End vbsme 
#-----------

vbsmeDone:
    j       vbsmeDone
    nop

# ------------------------------------------------------------------
# Name      : getSAD
# Purpose   : This function returns the SAD value between the 
#             comparison array and the provided window array
#
# Arguments : a0 = window
#             a1 = frame
#             a2 = asize
#             a3 = starting_point
#
# Return    : s1 = SAD value
# ------------------------------------------------------------------

getSAD:

    lw      $t2, 8($a2)             # asize[2]
    lw      $t3, 12($a2)            # asize[3]

    add     $t0, $0, $0             # t0 = sum
    add     $t1, $0, $0             # t1 = iterator

    eh      $t4, $a3, 0             # t4 = y = starting_point[0]    // CUSTOM INSTRUCTION - Extract Half
    eh      $t5, $a3, 1             # t5 = x = starting_point[1]    // CUSTOM INSTRUCTION - Extract Half

    mul     $t2, $t2, $t3           # t2 = asize[2] * asize[3]

    addi    $t3, $t3, -1            # t3 = asize[3] - 1

    add     $t6, $0, $0             # t6 = comp_index

getSADLoop:

    lw      $t7, 4($a2)            
    mul     $t7, $t7, $t4 
    add     $t6, $t7, $t5           # comp_index = x + (y * asize[1])

    sll     $t7, $t1, 2
    add     $t7, $t7, $a0
    lw      $t7, 0($t7)             # window[i]

    sll     $t8, $t6, 2
    add     $t8, $t8, $a1
    lw      $t8, 0($t8)             # frame[comp_index]
 
    sub     $t7, $t7, $t8           
    abs     $t7, $t7                # absolute value    // CUSTOM INSTRUCTION - Absolute Value

    add     $t0, $t0, $t7           # sum += abs(window[i] - frame[comp_index])

    eh      $t7, $a3, 1             # // CUSTOM INSTRUCTION - Extract Half
    sub     $t7, $t5, $t7
    slt     $t7, $t7, $t3           # x - starting_point[1] < asize[3] - 1
    beq     $t7, $0, getSADNewRow

    addi    $t5, $t5, 1             # x++

    addi    $t1, $t1, 1             # i++

    slt     $t7, $t1, $t2           # i < 16
    beq     $t7, $0, getSADEnd      # if iterator < length -> getSADEnd
    j       getSADLoop

getSADNewRow:

    eh      $t5, $a3, 1             # t5 = x = starting_point[1]    // CUSTOM INSTRUCTION - Extract Half
    addi    $t4, $t4, 1             # y++
    
    addi    $t1, $t1, 1             # i++
    beq     $t1, $t2, getSADEnd     # if iterator == asize[2] * asize[3] -> getSADEnd
    j       getSADLoop 
 
getSADEnd: 
 
    add     $s1, $t0, $0            # return sum (t0)
    jr      $ra
    nop
   
