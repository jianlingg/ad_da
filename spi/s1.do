onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/clk
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/rst_n
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/cs_key
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/cs
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/cs_dw
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/sclk
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/writ_data
add wave -noupdate -radix unsigned -childformat {{{/spi_m_tb/spi_m_u/writ_data_tmp[31]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[30]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[29]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[28]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[27]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[26]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[25]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[24]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[23]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[22]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[21]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[20]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[19]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[18]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[17]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[16]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[15]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[14]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[13]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[12]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[11]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[10]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[9]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[8]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[7]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[6]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[5]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[4]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[3]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[2]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[1]} -radix unsigned} {{/spi_m_tb/spi_m_u/writ_data_tmp[0]} -radix unsigned}} -subitemconfig {{/spi_m_tb/spi_m_u/writ_data_tmp[31]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[30]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[29]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[28]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[27]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[26]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[25]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[24]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[23]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[22]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[21]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[20]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[19]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[18]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[17]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[16]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[15]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[14]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[13]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[12]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[11]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[10]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[9]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[8]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[7]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[6]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[5]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[4]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[3]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[2]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[1]} {-radix unsigned} {/spi_m_tb/spi_m_u/writ_data_tmp[0]} {-radix unsigned}} /spi_m_tb/spi_m_u/writ_data_tmp
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/mosi
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/read_flag
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/writ_flag
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/read_data
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/rdy
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/miso
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/cnt
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/end_cnt
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/add_cnt
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/idle_to_read_start
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/idle_to_writ_start
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/read_to_idle_start
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/writ_to_idle_start
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/state_c
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/state_n
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/clk_en
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/edges
add wave -noupdate -radix unsigned /spi_m_tb/spi_m_u/cs_up
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {140 ns} 0} {{Cursor 2} {460 ns} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {106 ns} {497 ns}
