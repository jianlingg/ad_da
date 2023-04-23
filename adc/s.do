#创建work物理文件夹
vlib work

#映射work物理文件夹到modelsim里的逻辑文件夹
vmap work work

#编译测试文件
vlog spi_m_tb.v
vlog spi_m.v
vsim -voptargs=+acc work.spi_m_tb
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/*
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {53 ns} 0}
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
WaveRestoreZoom {0 ns} {1 us}
run 3us