#����work�����ļ���
vlib work

#ӳ��work�����ļ��е�modelsim����߼��ļ���
vmap work work

#��������ļ�
vlog dac_c_tb.v
vlog dac_c.v

#��������ļ�
vsim -voptargs=+acc work.dac_c_tb
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dac_c_tb/dac_c_u/clk
add wave -noupdate /dac_c_tb/dac_c_u/rst_n
add wave -noupdate /dac_c_tb/dac_c_u/din
add wave -noupdate /dac_c_tb/dac_c_u/din_vld
add wave -noupdate /dac_c_tb/dac_c_u/cs
add wave -noupdate /dac_c_tb/dac_c_u/sclk
add wave -noupdate /dac_c_tb/dac_c_u/sdi
add wave -noupdate /dac_c_tb/dac_c_u/ldac
add wave -noupdate /dac_c_tb/dac_c_u/flag_add
add wave -noupdate /dac_c_tb/dac_c_u/cnt_div
add wave -noupdate /dac_c_tb/dac_c_u/add_cnt_div
add wave -noupdate /dac_c_tb/dac_c_u/end_cnt_div
add wave -noupdate /dac_c_tb/dac_c_u/clk_neg
add wave -noupdate /dac_c_tb/dac_c_u/clk_pos
add wave -noupdate /dac_c_tb/dac_c_u/cnt
add wave -noupdate /dac_c_tb/dac_c_u/add_cnt
add wave -noupdate /dac_c_tb/dac_c_u/end_cnt
add wave -noupdate /dac_c_tb/dac_c_u/din_tmp
add wave -noupdate /dac_c_tb/dac_c_u/rdy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2023 ns} 0}
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
WaveRestoreZoom {0 ns} {10500 ns}
run 5us