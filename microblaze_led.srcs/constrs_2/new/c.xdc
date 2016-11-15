set_property IOSTANDARD LVCMOS33 [get_ports {led_tri_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports SCLK_S]
set_property IOSTANDARD LVCMOS33 [get_ports MOSI_S]
set_property IOSTANDARD LVCMOS33 [get_ports MISO_M]
set_property IOSTANDARD LVCMOS33 [get_ports {test_tri_i[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {CS_S[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports SCLK_M]
set_property IOSTANDARD LVCMOS33 [get_ports MOSI_M]
set_property IOSTANDARD LVCMOS33 [get_ports MISO_S]
set_property IOSTANDARD LVCMOS33 [get_ports {CS_M[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {CLK_out}];
set_property IOSTANDARD LVCMOS33 [get_ports {RST_out}];
set_property IOSTANDARD LVCMOS33 [get_ports {DRDY_N}]; #39
set_property IOSTANDARD LVCMOS33 [get_ports {R_N}]; #37
set_property IOSTANDARD LVCMOS33 [get_ports {PWRD_N}]; #35
set_property IOSTANDARD LVCMOS33 [get_ports {START}]; #36

set_property  -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {led_tri_o[0]}];
set_property  -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports SCLK_M];
set_property  -dict { PACKAGE_PIN U3   IOSTANDARD LVCMOS33 } [get_ports MOSI_M];
set_property  -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports MISO_S];
set_property  -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {CS_M[0]}];

set_property  -dict { PACKAGE_PIN J1   IOSTANDARD LVCMOS33 } [get_ports {test_tri_i[0]}];
set_property  -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports SCLK_S];
set_property  -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports MOSI_S];
set_property  -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports MISO_M];
set_property  -dict { PACKAGE_PIN C15  IOSTANDARD LVCMOS33 } [get_ports {CS_S[0]}];
set_property  -dict { PACKAGE_PIN N3  IOSTANDARD LVCMOS33 } [get_ports {CLK_out}];
set_property  -dict { PACKAGE_PIN P3  IOSTANDARD LVCMOS33 } [get_ports {RST_out}];

set_property  -dict { PACKAGE_PIN V5  IOSTANDARD LVCMOS33 } [get_ports {DRDY_N}]; #39
set_property  -dict { PACKAGE_PIN V4  IOSTANDARD LVCMOS33 } [get_ports {R_N}]; #37
#set_property  -dict { PACKAGE_PIN V3  IOSTANDARD LVCMOS33 } [get_ports {PWRD_N}]; #35
set_property  -dict { PACKAGE_PIN W6  IOSTANDARD LVCMOS33 } [get_ports {START}]; #36

