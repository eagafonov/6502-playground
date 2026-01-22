; W64C22 registers ($6000 base address)
; Data I/O Registers
PORTB=$6000
PORTA=$6001

; Data Direction Registers
DDRB=$6002
DDRA=$6003

IFR=$600D  ; Interrupt Flag Register
IER=$600E  ; Interrupt Enable Register

E  = %10000000
RW = %01000000
RS = %00100000

    .segment "CODE"
    .org $8000      ; ROM start

reset:
    ; lda #0$55      ; 0101 0101
    ; lda #$aa        ; 1010 1010
    ;sta $6002

    ; setup 65C22
    ; PORTB is connected to LCD data D0-D7
    lda #%11111111    ; PORTB is output
    sta DDRB

    ; PORTA
    ; bit 0   input
    ; bit 1   input
    ; bit 2   input
    ; bit 3   input
    ; bit 4   input
    ; bit 5   LCD RS
    ; bit 6   LCD RW
    ; bit 7   LCD Enable

    lda #%11100000    ; PORTA bits 5,6,7 is output
    sta DDRA

    lda #%00111000   ; Set 8-bit, 2 line, 5x7 font
    jsr lcd_send_instruction

    lda #%00001110   ; Display ON, Cursor ON, Blinking OFF
    jsr lcd_send_instruction

    lda #%00000110   ; Increment address and shift cursor
    jsr lcd_send_instruction


    lda #%00000001   ; Clear
    jsr lcd_send_instruction

    lda #'H'
    jsr lcd_send_data

    lda #'e'
    jsr lcd_send_data

    lda #'l'
    jsr lcd_send_data

    lda #'l'
    jsr lcd_send_data

    lda #'o'
    jsr lcd_send_data

    lda #'r'
    jsr lcd_send_data

    lda #'l'
    jsr lcd_send_data

    lda #'d'
    jsr lcd_send_data

    lda #'!'
    jsr lcd_send_data

loop:
    jmp loop

lcd_send_instruction:
    ; instuction is in acc
    sta PORTB

    ; toggle E ( RS and RW is 0)
    lda #E
    sta PORTA

    lda #0
    sta PORTA

    rts

lcd_send_data:
    sta PORTB

    lda #RS
    sta PORTA

    lda #(RS|E)
    sta PORTA

    lda #RS
    sta PORTA

    rts

; interrupt handlers
irq:
    rti

nmi:
    rti

    .segment "VECTORS"
    .org $fffa
    .word nmi
    .word reset
    .word irq
