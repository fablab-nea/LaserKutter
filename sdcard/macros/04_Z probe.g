; find index of Z axis
var zAxisIdx = 0
while true
  if move.axes[var.zAxisIdx].letter == "Z"
    break
  set var.zAxisIdx = var.zAxisIdx+1

G91

G0 X59

;G53 G0 Z{move.axes[var.zAxisIdx].max} ; Move Z to top (using machine coordinates)
;G28 Z ; home Z axis

M280 P0 S60

G4 P500 ; wait for 100 milliseconds
M401 P0 ; deploy probe
G4 P500 ; wait for 100 milliseconds

G30 S-3

M402 P0 ; retract probe


;{sensors.probes[0].triggerHeight}
;G92 Z0
;G92 Z{move.axes[var.zAxisIdx].machinePosition*-1}
;G92 Z9.5 ; 12.5 - 3 (mehr abziehen um mehr "Luft" zu haben) = 9.5 
;G0 Z0
;M280 P0 S60

G0 Z4.8
G0 X-59