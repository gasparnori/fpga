connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Cmod A7 - 15T 210328A2B3E4A"} -index 0
loadhw D:/Nora/cmod_a7_projects/microblaze_led/microblaze_led.sdk/d_wrapper_hw_platform_0/system.hdf
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Cmod A7 - 15T 210328A2B3E4A"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Cmod A7 - 15T 210328A2B3E4A"} -index 0
dow D:/Nora/cmod_a7_projects/microblaze_led/microblaze_led.sdk/spi_slave_bsp_xspi_slave_polled_example_1/Debug/spi_slave_bsp_xspi_slave_polled_example_1.elf
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Cmod A7 - 15T 210328A2B3E4A"} -index 0
con
