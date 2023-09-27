; homeu.g
; called to home the U axis
;

G53 G0 Z42      ; Move Z to top (using machine coordinates)

M584 U0.1:0.2   ; Move left and right motor

G91             ; relative positioning

G1 H1 U475 F380 ; move U up until the endstop is triggered
G90             ; absolute positioning
G92 U0          ; set U position to zero

G0 U-5          ; move U down
G92 U0          ; set U position to zero

;M584 U0.1      ; Move left motor only
M584 U0.2       ; Move right motor only
G0 U-0.75
G92 U0          ; set U position to zero
M584 U0.1:0.2   ; Move left and right motor
