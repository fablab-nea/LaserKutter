; Configuration file for Duet 3 Mini 5+ (firmware version 3.3)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.3.5 on Thu Nov 18 2021 22:17:45 GMT+0000 (UTC)

; General preferences
M575 P1 S1 B57600                        ; enable support for PanelDue
G90                                      ; send absolute coordinates...
M83                                      ; ...but relative extruder moves
M550 P"LaserKutter"                      ; set printer name

; Network
M551 P"foobar"                           ; set password
M552 P0.0.0.0 S1                         ; enable network and acquire dynamic address via DHCP
M586 P0 S1                               ; enable HTTP
M586 P1 S0                               ; disable FTP
M586 P2 S0                               ; disable Telnet

; Drives
M569 P0.5 S1                             ; physical drive 0.5 goes forwards
M569 P0.6 S1                             ; physical drive 0.6 goes forwards
M569 P0.0 S0                             ; physical drive 0.0 goes backwards
M584 X0.5 Y0.6 Z0.0                      ; set drive mapping
M350 X16 Y16 Z16 I1                      ; configure microstepping with interpolation
M92 X69.48 Y69.48 Z1000.00               ; set steps per mm
M566 X720.00 Y480.00 Z60.00              ; set maximum instantaneous speed changes (mm/min)
M203 X24000.00 Y14000.00 Z360.00         ; set maximum speeds (mm/min)
M201 X1600.00 Y800.00 Z20.00             ; set accelerations (mm/s^2)
M906 X800 Y800 Z800 I30                  ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                  ; Set idle timeout

; Axis Limits
M208 X0 Y0 Z0 S1                         ; set axis minima
M208 X1220 Y900 Z42 S0                   ; set axis maxima

; Endstops
M574 X2 S1 P"^io1.in"                    ; configure switch-type (e.g. microswitch) endstop for high end on Y via pin ^io1.in
M574 Y2 S1 P"^io2.in"                    ; configure switch-type (e.g. microswitch) endstop for high end on Y via pin ^io2.in
M574 Z2 S1 P"!^io5.in"                   ; configure switch-type (e.g. microswitch) endstop for high end on Z via pin !^io5.in

; Z-Probe
M950 S0 C"io3.out"                       ; create servo pin 0 for BLTouch
M558 P9 C"io3.in+io4.out" H10 F120 T6000 ; set Z probe type to bltouch and the dive height + speeds
G31 P500 X0 Y0 Z2.5                      ; set Z probe trigger value, offset and trigger height
M557 X15:215 Y15:195 S20                 ; define mesh grid

; Heaters
M140 H-1                                 ; disable heated bed (overrides default heater mapping)

; Fans
M950 F0 C"out1" Q0                       ; create fan 0 on pin out1 and set its frequency
M106 P0 C"Abluft" S0 H-1                 ; set fan 0 name and value. Thermostatic control is turned off
M950 F1 C"out2" Q0                       ; create fan 1 on pin out2 and set its frequency
M106 P1 C"Luftpumpe" S0 H-1              ; set fan 1 name and value. Thermostatic control is turned off
M950 F2 C"out5" Q0                       ; create fan 2 on pin out5 and set its frequency
M106 P2 C"Sauerstoff" S0 H-1             ; set fan 2 name and value. Thermostatic control is turned off

; Tools

; Custom settings
; Laser
M452 C"out6" R255 S1 F20000              ; Enable Laser mode, on out6, with max intensity being 255, and a PWM frequency of 20000Hz, sticky mode

; Timings
M569 P0.5 T5:5:10:0                      ; 5us minimum step pulse, 5us minimum step interval, 10us DIR setup time and no hold time
M569 P0.6 T5:5:10:0                      ; 5us minimum step pulse, 5us minimum step interval, 10us DIR setup time and no hold time

