# 1 "C:\\Users\\qipq\\Desktop\\imx6_none\\devices\\MCIMX6G2\\gcc\\startup_MCIMX6G3.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "C:\\Users\\qipq\\Desktop\\imx6_none\\devices\\MCIMX6G2\\gcc\\startup_MCIMX6G3.S"
# 40 "C:\\Users\\qipq\\Desktop\\imx6_none\\devices\\MCIMX6G2\\gcc\\startup_MCIMX6G3.S"
    .syntax unified
    .arch armv7-a

    .section .isr_vector, "a"
    .align 2
    .globl __isr_vector
__isr_vector:
    ldr pc, =Reset_Handler
    ldr pc, =Undefined_Handler
    ldr pc, =SVC_Handler
    ldr pc, =PrefAbort_Handler
    ldr pc, =DataAbort_Handler
    .word 0
    ldr pc, =IRQ_Handler
    ldr pc, =FIQ_Handler

    .size __isr_vector, . - __isr_vector

    .text
    .arm



    .arm
    .align 2
    .globl Reset_Handler
    .weak Reset_Handler
    .type Reset_Handler, %function
Reset_Handler:
    cpsid i


    mrc p15, 0, r0, c1, c0, 0
    bic r0, r0, #(0x1 << 12)
    bic r0, r0, #(0x1 << 2)
    bic r0, r0, #0x2
    bic r0, r0, #(0x1 << 11)
    bic r0, r0, #0x1
    mcr p15, 0, r0, c1, c0, 0


    cps #0x12
    ldr sp, =__IStackTop

    cps #0x1F
    ldr sp, =__CStackTop

    cps #0x13
    ldr sp, =__CStackTop


    ldr r0,=SystemInit
    blx r0

    cpsie i
# 103 "C:\\Users\\qipq\\Desktop\\imx6_none\\devices\\MCIMX6G2\\gcc\\startup_MCIMX6G3.S"
    ldr r1, =__etext





    ldr r2, =__noncachedata_start__
    ldr r3, =__noncachedata_end__

.LC0:
    cmp r2, r3
    ittt lt
    ldrlt r0, [r1], #4
    strlt r0, [r2], #4
    blt .LC0
# 128 "C:\\Users\\qipq\\Desktop\\imx6_none\\devices\\MCIMX6G2\\gcc\\startup_MCIMX6G3.S"
    ldr r1,=__DATA_ROM


    ldr r2, =__data_start__
    ldr r3, =__data_end__

.LC2:
    cmp r2, r3
    ittt lt
    ldrlt r0, [r1], #4
    strlt r0, [r2], #4
    blt .LC2
# 157 "C:\\Users\\qipq\\Desktop\\imx6_none\\devices\\MCIMX6G2\\gcc\\startup_MCIMX6G3.S"
    ldr r2, =__ocram_data_start__
    ldr r3, =__ocram_data_end__


.LC4:
    cmp r2, r3
    ittt lt
    ldrlt r0, [r1], #4
    strlt r0, [r2], #4
    blt .LC4
# 202 "C:\\Users\\qipq\\Desktop\\imx6_none\\devices\\MCIMX6G2\\gcc\\startup_MCIMX6G3.S"
    ldr r0,=_start
    blx r0






    .pool
    .size Reset_Handler, . - Reset_Handler

    .align 2
    .arm
    .weak Undefined_Handler
    .type Undefined_Handler, %function
Undefined_Handler:
    b Undefined_Handler
    .size Undefined_Handler, . - Undefined_Handler

    .align 2
    .arm
    .weak SVC_Handler
    .type SVC_Handler, %function
SVC_Handler:
    ldr r0,=SVC_Handler
    bx r0
    .size SVC_Handler, . - SVC_Handler

    .align 2
    .arm
    .weak PrefAbort_Handler
    .type PrefAbort_Handler, %function
PrefAbort_Handler:
    ldr r0,=PrefAbort_Handler
    bx r0
    .size PrefAbort_Handler, . - PrefAbort_Handler

    .align 2
    .arm
    .weak DataAbort_Handler
    .type DataAbort_Handler, %function
DataAbort_Handler:
    ldr r0,=DataAbort_Handler
    bx r0
    .size DataAbort_Handler, . - DataAbort_Handler

    .align 2
    .arm
    .weak IRQ_Handler
    .type IRQ_Handler, %function
IRQ_Handler:
    push {lr}
    push {r0-r3, r12}

    MRS r0, spsr
    push {r0}

    MRC P15, 4, r1, C15, C0, 0
    ADD r1, r1, #0x2000
    LDR r0, [r1, #0xC]

    push {r0, r1}

    CPS #0x13

    push {lr}
    LDR r2, =SystemIrqHandler
    BLX r2
    POP {lr}

    CPS #0x12

    POP {r0, r1}

    STR r0, [r1, #0x10]

    POP {r0}
    MSR spsr_cxsf, r0

    POP {r0-r3, r12}
    POP {lr}
    SUBS pc, lr, #4
    .size IRQ_Handler, . - IRQ_Handler

    .align 2
    .arm
    .weak FIQ_Handler
    .type FIQ_Handler, %function
FIQ_Handler:
    ldr r0,=FIQ_Handler
    bx r0
    .size FIQ_Handler, . - FIQ_Handler

    .end
