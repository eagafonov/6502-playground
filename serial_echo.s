.include "serial.s"

.segment "CODE"

reset:
    jsr init_serial

loop:
rx_wait:
    lda ACIA_STATUS
    and #$08
    beq rx_wait

    ; read byte from serial
    lda ACIA_DATA
    ; write the byte back
    sta ACIA_DATA

    jmp loop

; interrupt handlers
irq:
    rti

nmi:
    rti

.segment "VECTORS"
    .word nmi
    .word reset
    .word irq
