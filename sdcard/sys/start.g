G60 S2 ; Save current position to slot 2

if {fans[0].actualValue} != 1.0
  M106 P0 S255 ; Abluft an
  G4 P3000 ; warte 3 Sekunde
