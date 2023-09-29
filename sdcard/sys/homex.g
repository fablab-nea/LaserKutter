; homex.g
; called to home the X axis
;
; generated by RepRapFirmware Configuration Tool v3.3.5 on Thu Nov 18 2021 22:17:45 GMT+0000 (UTC)

; find index of Z axis
var zAxisIdx = 0
while true
  if move.axes[var.zAxisIdx].letter == "Z"
    break
  set var.zAxisIdx = var.zAxisIdx+1

var currentZPosition = move.axes[var.zAxisIdx].machinePosition

G53 G0 Z{move.axes[var.zAxisIdx].max} ; Move Z to top (using machine coordinates)
G91               ; relative positioning
G1 H1 X1225 F4800 ; move quickly to X axis endstop and stop there (first pass)
G1 H2 X-2 F6000   ; go back a few mm
G1 H1 X1225 F360  ; move slowly to X axis endstop once more (second pass)
G90               ; absolute positioning

