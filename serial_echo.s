.include "serial.s"

.segment "CODE"

reset:
    phx
    plx
    jsr init_serial

    lda #$0d
    jsr send_char

    lda #$0a
    jsr send_char

    lda #':'
    jsr send_char

loop:
rx_wait:
    lda ACIA_STATUS
    and #$08
    beq rx_wait

    ; read byte from serial
    lda ACIA_DATA

    ; write the byte back
    jsr send_char

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
