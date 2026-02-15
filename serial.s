; ACIA Registers (addresses)
ACIA_DATA   = $5000
ACIA_STATUS = $5001
ACIA_CMD    = $5002
ACIA_CTRL   = $5003

; Control register flags
ACIA_CTRL_115k     = %00000000
ACIA_CTRL_19200pbs = %00001111
ACIA_CTRL_9600pbs  = %00001110
ACIA_CTRL_50bps    = %00000001

ACIA_CTRL_RCS_BAUD = %00010000
ACIA_CTRL_RCS_EXT  = %00000000

ACIA_CTRL_8bits    = %00000000
ACIA_CTRL_7bits    = %00100000
ACIA_CTRL_6bits    = %01000000
ACIA_CTRL_5bits    = %01100000

ACIA_CTRL_STOP_1   = %00000000
ACIA_CTRL_STOP_2   = %10000000

; Command register flags
; 7,6 - Parity Mode Control (PMC) - Zeroes for WDC W65C51N
; 5 - Parity Mode Enabled (PME)   - Must be zero for WDC W65C51N
; Bit 4: Receiver Echo Mode
ACIA_CMD_RX_NO_ECHO = %00000000
ACIA_CMD_RX_ECHO    = %00010000

; Bits 3,2:  TX Interrupt Control (TIC)

; Bit 1: RX IRQ Disabled (IRD)
ACIA_CMD_IRQ_ENABLED  = %00000000
ACIA_CMD_IRQ_DISABLED = %00000010

; Bit 0: DTR
ACIA_CMD_DTR_NOT_READY = %00000000
ACIA_CMD_DTR_READY     = %00000001

.segment "CODE"

init_serial:
    pha
    ; soft reset
    lda #$00
    sta ACIA_STATUS

    lda #(ACIA_CTRL_19200pbs | ACIA_CTRL_RCS_BAUD | ACIA_CTRL_8bits | ACIA_CTRL_STOP_1)
    sta ACIA_CTRL

    lda #%00001011 ; No parity, no IRQ
    sta ACIA_CMD

    pla
    rts
