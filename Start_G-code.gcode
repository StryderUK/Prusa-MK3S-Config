M862.3 P "[printer_model]" ; printer model check
M862.1 P[nozzle_diameter] ; nozzle diameter check
M115 U3.9.1 ; tell printer latest fw version
G90 ; use absolute coordinates
M83 ; extruder relative mode
M104 S{first_layer_temperature[0]-50}; set extruder temp
M140 S[first_layer_bed_temperature] ; set bed temp
M190 S[first_layer_bed_temperature] ; wait for bed temp
M109 S{first_layer_temperature[0]-50}; wait for extruder temp
G28 W ; home all without mesh bed level
G80 N7 R5 ; mesh bed leveling
G1 Y-3.0 F1000.0 ; go outside print area
G0 Z5.0 ; 5mm wait pos
M104 S[first_layer_temperature] ; set extruder temp
M109 S[first_layer_temperature] ; set extruder temp
G0 Z0.15 ; Restore nozzle position - (thanks tim.m30)
M900 K0; Disable Linear Advance for prime line
G92 E0.0 ; reset extrusion distance
G1 Y-3.0 F1000.0 ; go outside print area
; Prime line routine
G0 Z0.15 ; Restore nozzle position - (thanks tim.m30)
M900 K0; Disable Linear Advance for prime line
G92 E0.0 ; reset extrusion distance
G1 Y-3.0 F1000.0 ; go outside print area
G1 E2 F1000 ; de-retract and push ooze
G1 X20.0 E6  F1000.0 ; fat 20mm intro line @ 0.30
G1 X60.0 E3.2  F1000.0 ; thin +40mm intro line @ 0.08
G1 X100.0 E6  F1000.0 ; fat +40mm intro line @ 0.15
G1 E-0.8 F3000; retract to avoid stringing
G1 X99.5 E0 F1000.0 ; -0.5mm wipe action to avoid string
G1 X110.0 E0 F1000.0 ; +10mm intro line @ 0.00
G1 E0.6 F1500; de-retract
G92 E0.0 ; reset extrusion distance
; Final print adjustments
M300 S40 P10 ; chirp
M221 S{if layer_height<0.075}100{else}95{endif}

; Don't change E values below. Excessive value can damage the printer.
{if print_settings_id=~/.*(DETAIL @MK3|QUALITY @MK3).*/}M907 E430 ; set extruder motor current{endif}
{if print_settings_id=~/.*(SPEED @MK3|DRAFT @MK3).*/}M907 E538 ; set extruder motor current{endif}
