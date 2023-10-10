; homeu.g
; called to home the U axis
G90             ; absolute positioning

; find index of Z axis
var zAxisIdx = 0
while true
  if move.axes[var.zAxisIdx].letter == "Z"
    break
  set var.zAxisIdx = var.zAxisIdx+1

; find index of U axis
var uAxisIdx = 0
while true
  if move.axes[var.uAxisIdx].letter == "U"
    break
  set var.uAxisIdx = var.uAxisIdx+1


var currentZPosition = move.axes[var.zAxisIdx].machinePosition

G53 G0 Z{move.axes[var.zAxisIdx].max} ; Move Z to top (using machine coordinates)

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

; set U position to zero
G92 U0
G92 U{move.axes[var.uAxisIdx].machinePosition * -1}

M584 U0.1:0.2   ; Move left and right motor

if !exists(param.S)              ; S parameter is set when called from "homeall.g"
  G53 G0 Z{var.currentZPosition} ; Move Z axis back to it's original position