onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bin_bcd_tb/u_binary_bcd/clk
add wave -noupdate /bin_bcd_tb/u_binary_bcd/din_vld
add wave -noupdate -radix hexadecimal /bin_bcd_tb/u_binary_bcd/bcd_out
add wave -noupdate -radix binary /bin_bcd_tb/u_binary_bcd/bin_in_tem1
add wave -noupdate -radix binary /bin_bcd_tb/u_binary_bcd/bcd
add wave -noupdate /bin_bcd_tb/u_binary_bcd/cnt
add wave -noupdate /bin_bcd_tb/u_binary_bcd/add_cnt
add wave -noupdate /bin_bcd_tb/u_binary_bcd/end_cnt
add wave -noupdate /bin_bcd_tb/u_binary_bcd/flag_add
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {384569 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
configure wave -timelineunits ns
update
WaveRestoreZoom {293551 ps} {432583 ps}
