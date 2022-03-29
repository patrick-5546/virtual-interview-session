onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /lut_mux_tb/cos_term
add wave -noupdate -radix hexadecimal /lut_mux_tb/k1
add wave -noupdate -radix hexadecimal /lut_mux_tb/k2
add wave -noupdate -radix hexadecimal /lut_mux_tb/n1
add wave -noupdate -radix hexadecimal /lut_mux_tb/n2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {477 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 131
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {24114 ps}
