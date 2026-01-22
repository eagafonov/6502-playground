.segment "CODE"
reset:
    ; Setup 65C22
    lda #$ff        ; PORTB is outout
    sta $6002

    clc
    lda #0

loop:
    adc #1
    sta $6000
    jmp loop

out_byte:
    sta $6000
    rts

; interrupt handlers
irq:
    rti

nmi:
    rti

.segment "VECTORS"
    .word nmi
    .word reset
    .word irq
