    ; --hex option test (main focus), creates file: "hex_to_file.raw"
    ORG     $1234
    DB      "HEX only\n"
start:
    DB      "per 16 bytes\n"
    ORG     $3456
    DB      "change adr by ORG\n"
    di                  ; try some instructions
    ld      hl,$ABCD
    jr      $

    END     start

/*

; OUTHEX will collide with --hex, because only one HEX file can be active at time (also SAVEHEX vs --hex)
;     OUTHEX  "hex_to_file.tap", start    ; this *will* affect also --hex start address (like END <addr> would)
; things to test in directive tests to test this thoroughly:
; - syntax errors of OUTHEX
; - OUTHEX default name? (with END <start addr>)
; - HEX does *NOT* support SIZE (unless somebody provides use case). And no FPOS/append/rewind/...
; - no plans to add support of banks/lonptr in first version (until use case emerges)
; - DEVICE + SAVEHEX combination
;   - (maybe not possible together with OUTHEX because of buffer? or collecting buffer vs device mem for lower level fn.)
; - test OUTHEX implicit close by EOF

== implementation notes:

- block 00 Data
- block 01 End of file
- block 03 start segment address?? Not sure if this is compatible with Z80 machines, but at least try
- everything else seems out of scope, especially as I don't plan banking support initially
- in case of banking I guess block 04 may be of interest
*/
