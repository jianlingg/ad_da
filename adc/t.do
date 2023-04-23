onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/top_u/clk
add wave -noupdate /top_tb/top_u/rst_n
add wave -noupdate /top_tb/top_u/key
add wave -noupdate /top_tb/top_u/shcp
add wave -noupdate /top_tb/top_u/ds
add wave -noupdate /top_tb/top_u/shu_hc5_dat_vld
add wave -noupdate /top_tb/top_u/clo_shu_dat
add wave -noupdate /top_tb/top_u/shu_hc5_dat
add wave -noupdate /top_tb/top_u/shuma_u/seg
add wave -noupdate /top_tb/top_u/shuma_u/sel
add wave -noupdate -radix binary /top_tb/top_u/shuma_u/dout
add wave -noupdate /top_tb/top_u/shuma_u/dout_vld
add wave -noupdate /top_tb/top_u/stcp
add wave -noupdate /top_tb/top_u/hc595_u/end_cnt_div
add wave -noupdate /top_tb/top_u/hc595_u/cnt
add wave -noupdate /top_tb/top_u/hc595_u/din_vld
add wave -noupdate /top_tb/top_u/hc595_u/flag_add
add wave -noupdate /top_tb/top_u/hc595_u/din_tmp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25120 ns} 0}
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
WaveRestoreZoom {24705 ns} {26879 ns}
