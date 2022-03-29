onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dct_tb/DCT/clk
add wave -noupdate /dct_tb/DCT/start
add wave -noupdate /dct_tb/DCT/reset
add wave -noupdate /dct_tb/DCT/state
add wave -noupdate -expand -group {k coefficients} /dct_tb/DCT/k1
add wave -noupdate -expand -group {k coefficients} /dct_tb/DCT/k2
add wave -noupdate /dct_tb/DCT/c
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1192 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 264
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
WaveRestoreZoom {31386 ps} {45722 ps}
