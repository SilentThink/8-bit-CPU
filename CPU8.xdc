#Clock
set_property -dict {PACKAGE_PIN K21 IOSTANDARD LVCMOS33} [get_ports CLK] ;#50MHz main clock in
create_clock -period 20.000 -name clk_50M -waveform {0.000 10.000} [get_ports CLK]

#Touch Button
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports reset_btn] ;#BTN6

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets reset_btn_IBUF]

#CPLD GPIO 12-16
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {uart_wrn}]
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports {uart_rdn}]
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {uart_tbre}]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {uart_tsre}]
set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports {uart_dataready}]

#Ext serial
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN H18} [get_ports txd] ;#GPIO5
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN J20} [get_ports rxd] ;#GPIO6

#Digital Video
set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports video_clk]
set_property -dict {PACKAGE_PIN E26 IOSTANDARD LVCMOS33} [get_ports {video_red[2]}]
set_property -dict {PACKAGE_PIN F24 IOSTANDARD LVCMOS33} [get_ports {video_red[1]}]
set_property -dict {PACKAGE_PIN K23 IOSTANDARD LVCMOS33} [get_ports {video_red[0]}]
set_property -dict {PACKAGE_PIN F23 IOSTANDARD LVCMOS33} [get_ports {video_green[2]}]
set_property -dict {PACKAGE_PIN E23 IOSTANDARD LVCMOS33} [get_ports {video_green[1]}]
set_property -dict {PACKAGE_PIN K22 IOSTANDARD LVCMOS33} [get_ports {video_green[0]}]
set_property -dict {PACKAGE_PIN D25 IOSTANDARD LVCMOS33} [get_ports {video_blue[1]}]
set_property -dict {PACKAGE_PIN E25 IOSTANDARD LVCMOS33} [get_ports {video_blue[0]}]
set_property -dict {PACKAGE_PIN J24 IOSTANDARD LVCMOS33} [get_ports video_hsync]
set_property -dict {PACKAGE_PIN H24 IOSTANDARD LVCMOS33} [get_ports video_vsync]
set_property -dict {PACKAGE_PIN G24 IOSTANDARD LVCMOS33} [get_ports video_de]

#DIP_SW
set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS33} [get_ports CLRn]

#LEDS
set_property -dict {PACKAGE_PIN B24 IOSTANDARD LVCMOS33} [get_ports T0]
set_property -dict {PACKAGE_PIN E21 IOSTANDARD LVCMOS33} [get_ports T1]
set_property -dict {PACKAGE_PIN A24 IOSTANDARD LVCMOS33} [get_ports T2]
set_property -dict {PACKAGE_PIN D23 IOSTANDARD LVCMOS33} [get_ports T3]
set_property -dict {PACKAGE_PIN C22 IOSTANDARD LVCMOS33} [get_ports T4]
set_property -dict {PACKAGE_PIN C21 IOSTANDARD LVCMOS33} [get_ports T5]
set_property -dict {PACKAGE_PIN E20 IOSTANDARD LVCMOS33} [get_ports T6]
set_property -dict {PACKAGE_PIN B22 IOSTANDARD LVCMOS33} [get_ports T7]

#DPY0
;#set_property -dict {PACKAGE_PIN B19 IOSTANDARD LVCMOS33} [get_ports {dpy0[0]}] ;#dot
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports LED7_1[2]] ;#右下
set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS33} [get_ports LED7_1[3]] ;#下
set_property -dict {PACKAGE_PIN A19 IOSTANDARD LVCMOS33} [get_ports LED7_1[4]] ;#左下
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports LED7_1[1]] ;#右上
set_property -dict {PACKAGE_PIN C19 IOSTANDARD LVCMOS33} [get_ports LED7_1[0]] ;#上
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports LED7_1[5]] ;#左上
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports LED7_1[6]] ;#中

#DPY1
;#set_property -dict {PACKAGE_PIN A17 IOSTANDARD LVCMOS33} [get_ports {dpy0[0]}]
set_property -dict {PACKAGE_PIN D16 IOSTANDARD LVCMOS33} [get_ports LED7_2[2]]
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports LED7_2[3]]
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS33} [get_ports LED7_2[4]]
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports LED7_2[1]]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports LED7_2[0]]
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports LED7_2[5]]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports LED7_2[6]]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

