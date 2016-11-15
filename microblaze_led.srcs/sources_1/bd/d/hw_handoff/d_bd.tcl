
################################################################
# This is a generated script based on design: d
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source d_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# adc_io

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a15tcpg236-1
   set_property BOARD_PART digilentinc.com:cmod_a7-15t:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
set design_name d

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB

  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 lmb_bram ]
  set_property -dict [ list \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set LED [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 LED ]
  set cellular_ram [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 cellular_ram ]
  set push_buttons_1bit [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 push_buttons_1bit ]
  set rgb_led [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rgb_led ]
  set usb_uart [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 usb_uart ]

  # Create ports
  set CLK_out [ create_bd_port -dir O CLK_out ]
  set CS_M [ create_bd_port -dir O -from 0 -to 0 CS_M ]
  set CS_S [ create_bd_port -dir I -from 0 -to 0 CS_S ]
  set DRDY_N [ create_bd_port -dir I DRDY_N ]
  set MISO_M [ create_bd_port -dir I MISO_M ]
  set MISO_S [ create_bd_port -dir O MISO_S ]
  set MOSI_M [ create_bd_port -dir O MOSI_M ]
  set MOSI_S [ create_bd_port -dir I MOSI_S ]
  set R_N [ create_bd_port -dir O R_N ]
  set SCLK_M [ create_bd_port -dir O SCLK_M ]
  set SCLK_S [ create_bd_port -dir I -type clk SCLK_S ]
  set START [ create_bd_port -dir O START ]
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list \
CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $reset
  set sys_clock [ create_bd_port -dir I -type clk sys_clock ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {12000000} \
CONFIG.PHASE {0.000} \
 ] $sys_clock

  # Create instance: SPI_S, and set properties
  set SPI_S [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 SPI_S ]
  set_property -dict [ list \
CONFIG.C_FIFO_DEPTH {256} \
CONFIG.C_USE_STARTUP {0} \
CONFIG.C_USE_STARTUP_INT {0} \
CONFIG.Master_mode {0} \
 ] $SPI_S

  # Create instance: adc_gpio, and set properties
  set adc_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 adc_gpio ]
  set_property -dict [ list \
CONFIG.C_ALL_INPUTS {1} \
CONFIG.C_ALL_OUTPUTS_2 {1} \
CONFIG.C_GPIO2_WIDTH {1} \
CONFIG.C_GPIO_WIDTH {1} \
CONFIG.C_INTERRUPT_PRESENT {0} \
CONFIG.C_IS_DUAL {1} \
 ] $adc_gpio

  # Create instance: adc_io_0, and set properties
  set block_name adc_io
  set block_cell_name adc_io_0
  if { [catch {set adc_io_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $adc_io_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: axi_emc_0, and set properties
  set axi_emc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 axi_emc_0 ]
  set_property -dict [ list \
CONFIG.EMC_BOARD_INTERFACE {cellular_ram} \
CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_emc_0

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
CONFIG.C_ALL_INPUTS {1} \
CONFIG.C_ALL_OUTPUTS_2 {0} \
CONFIG.C_GPIO2_WIDTH {3} \
CONFIG.C_GPIO_WIDTH {1} \
CONFIG.C_IS_DUAL {1} \
CONFIG.GPIO2_BOARD_INTERFACE {rgb_led} \
CONFIG.GPIO_BOARD_INTERFACE {push_buttons_1bit} \
CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_gpio_0

  # Create instance: axi_gpio_1, and set properties
  set axi_gpio_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_1 ]
  set_property -dict [ list \
CONFIG.C_ALL_INPUTS_2 {1} \
CONFIG.C_ALL_OUTPUTS {1} \
CONFIG.C_ALL_OUTPUTS_2 {0} \
CONFIG.C_GPIO2_WIDTH {1} \
CONFIG.C_GPIO_WIDTH {1} \
CONFIG.C_INTERRUPT_PRESENT {0} \
CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_1

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
 ] $axi_mem_intercon

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
CONFIG.UARTLITE_BOARD_INTERFACE {usb_uart} \
CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_uartlite_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.3 clk_wiz_0 ]
  set_property -dict [ list \
CONFIG.CLKIN1_JITTER_PS {833.33} \
CONFIG.CLKOUT1_JITTER {479.872} \
CONFIG.CLKOUT1_PHASE_ERROR {668.310} \
CONFIG.CLKOUT2_JITTER {653.260} \
CONFIG.CLKOUT2_PHASE_ERROR {668.310} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {16.000} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.CLK_IN1_BOARD_INTERFACE {sys_clock} \
CONFIG.MMCM_CLKFBOUT_MULT_F {62.500} \
CONFIG.MMCM_CLKIN1_PERIOD {83.333} \
CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {7.500} \
CONFIG.MMCM_CLKOUT1_DIVIDE {47} \
CONFIG.MMCM_COMPENSATION {ZHOLD} \
CONFIG.MMCM_DIVCLK_DIVIDE {1} \
CONFIG.NUM_OUT_CLKS {2} \
CONFIG.RESET_BOARD_INTERFACE {reset} \
CONFIG.USE_BOARD_FLOW {true} \
 ] $clk_wiz_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.CLKIN1_JITTER_PS.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKIN1_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKIN2_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_COMPENSATION.VALUE_SRC {DEFAULT} \
 ] $clk_wiz_0

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:10.0 microblaze_0 ]
  set_property -dict [ list \
CONFIG.C_CACHE_BYTE_SIZE {8192} \
CONFIG.C_DCACHE_BYTE_SIZE {8192} \
CONFIG.C_DEBUG_ENABLED {1} \
CONFIG.C_D_AXI {1} \
CONFIG.C_D_LMB {1} \
CONFIG.C_I_LMB {1} \
CONFIG.C_USE_DCACHE {1} \
CONFIG.C_USE_ICACHE {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {6} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: rst_clk_wiz_0_100M, and set properties
  set rst_clk_wiz_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_0_100M ]
  set_property -dict [ list \
CONFIG.RESET_BOARD_INTERFACE {reset} \
CONFIG.USE_BOARD_FLOW {true} \
 ] $rst_clk_wiz_0_100M

  # Create instance: spi_M, and set properties
  set spi_M [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 spi_M ]
  set_property -dict [ list \
CONFIG.C_FIFO_DEPTH {256} \
CONFIG.C_NUM_TRANSFER_BITS {8} \
CONFIG.C_USE_STARTUP {0} \
CONFIG.C_USE_STARTUP_INT {0} \
 ] $spi_M

  # Create interface connections
  connect_bd_intf_net -intf_net axi_emc_0_EMC_INTF [get_bd_intf_ports cellular_ram] [get_bd_intf_pins axi_emc_0/EMC_INTF]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports push_buttons_1bit] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO2 [get_bd_intf_ports rgb_led] [get_bd_intf_pins axi_gpio_0/GPIO2]
  connect_bd_intf_net -intf_net axi_gpio_1_GPIO [get_bd_intf_ports LED] [get_bd_intf_pins axi_gpio_1/GPIO]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_emc_0/S_AXI_MEM] [get_bd_intf_pins axi_mem_intercon/M00_AXI]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports usb_uart] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DC [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins microblaze_0/M_AXI_DC]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_IC [get_bd_intf_pins axi_mem_intercon/S01_AXI] [get_bd_intf_pins microblaze_0/M_AXI_IC]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins axi_gpio_1/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins SPI_S/AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI] [get_bd_intf_pins spi_M/AXI_LITE]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins adc_gpio/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]

  # Create port connections
  connect_bd_net -net CS_1 [get_bd_ports CS_S] [get_bd_pins SPI_S/spisel]
  connect_bd_net -net DRDY_N_1 [get_bd_ports DRDY_N] [get_bd_pins adc_io_0/DRDY_N]
  connect_bd_net -net MOSI_1 [get_bd_ports MOSI_S] [get_bd_pins SPI_S/io0_i]
  connect_bd_net -net SCLK_1 [get_bd_ports SCLK_S] [get_bd_pins SPI_S/sck_i]
  connect_bd_net -net adc_io_0_GPIO_DRDY [get_bd_pins adc_gpio/gpio_io_i] [get_bd_pins adc_io_0/GPIO_DRDY]
  connect_bd_net -net adc_io_0_R_N [get_bd_ports R_N] [get_bd_pins adc_io_0/R_N]
  connect_bd_net -net adc_io_0_START [get_bd_ports START] [get_bd_pins adc_io_0/START]
  connect_bd_net -net axi_gpio_2_gpio2_io_o [get_bd_pins adc_gpio/gpio2_io_o] [get_bd_pins adc_io_0/GPIO_OUT]
  connect_bd_net -net axi_quad_spi_0_io1_o [get_bd_ports MISO_S] [get_bd_pins SPI_S/io1_o]
  connect_bd_net -net axi_quad_spi_1_io0_o [get_bd_ports MOSI_M] [get_bd_pins spi_M/io0_o]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_ports CLK_out] [get_bd_pins clk_wiz_0/clk_out2]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins rst_clk_wiz_0_100M/dcm_locked]
  connect_bd_net -net io1_i_1 [get_bd_ports MISO_M] [get_bd_pins spi_M/io1_i]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_clk_wiz_0_100M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins SPI_S/ext_spi_clk] [get_bd_pins SPI_S/s_axi_aclk] [get_bd_pins adc_gpio/s_axi_aclk] [get_bd_pins axi_emc_0/rdclk] [get_bd_pins axi_emc_0/s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_gpio_1/s_axi_aclk] [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rst_clk_wiz_0_100M/slowest_sync_clk] [get_bd_pins spi_M/ext_spi_clk] [get_bd_pins spi_M/s_axi_aclk]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins clk_wiz_0/reset] [get_bd_pins rst_clk_wiz_0_100M/ext_reset_in]
  connect_bd_net -net rst_clk_wiz_0_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_clk_wiz_0_100M/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_0_100M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins rst_clk_wiz_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_clk_wiz_0_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins rst_clk_wiz_0_100M/mb_reset]
  connect_bd_net -net rst_clk_wiz_0_100M_peripheral_aresetn [get_bd_pins SPI_S/s_axi_aresetn] [get_bd_pins adc_gpio/s_axi_aresetn] [get_bd_pins adc_io_0/RESET] [get_bd_pins axi_emc_0/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_gpio_1/gpio2_io_i] [get_bd_pins axi_gpio_1/s_axi_aresetn] [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins rst_clk_wiz_0_100M/peripheral_aresetn] [get_bd_pins spi_M/s_axi_aresetn]
  connect_bd_net -net spi_M_sck_o [get_bd_ports SCLK_M] [get_bd_pins spi_M/sck_o]
  connect_bd_net -net spi_M_ss_o [get_bd_ports CS_M] [get_bd_pins spi_M/ss_o]
  connect_bd_net -net sys_clock_1 [get_bd_ports sys_clock] [get_bd_pins clk_wiz_0/clk_in1]

  # Create address segments
  create_bd_addr_seg -range 0x02000000 -offset 0x60000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_emc_0/S_AXI_MEM/MEM0] SEG_axi_emc_0_MEM0
  create_bd_addr_seg -range 0x02000000 -offset 0x60000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs axi_emc_0/S_AXI_MEM/MEM0] SEG_axi_emc_0_MEM0
  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40010000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_gpio_1/S_AXI/Reg] SEG_axi_gpio_1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40020000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs adc_gpio/S_AXI/Reg] SEG_axi_gpio_2_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs SPI_S/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00002000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00002000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs spi_M/AXI_LITE/Reg] SEG_spi_M_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.6.5b  2016-09-06 bk=1.3687 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port CLK_out -pg 1 -y 1480 -defaultsOSRD
preplace port MOSI_M -pg 1 -y 540 -defaultsOSRD
preplace port SCLK_S -pg 1 -y 250 -defaultsOSRD -right
preplace port DRDY_N -pg 1 -y 1080 -defaultsOSRD
preplace port MISO_S -pg 1 -y 230 -defaultsOSRD
preplace port sys_clock -pg 1 -y 1400 -defaultsOSRD
preplace port usb_uart -pg 1 -y 710 -defaultsOSRD
preplace port START -pg 1 -y 840 -defaultsOSRD
preplace port push_buttons_1bit -pg 1 -y 1110 -defaultsOSRD
preplace port MOSI_S -pg 1 -y 210 -defaultsOSRD -right
preplace port LED -pg 1 -y 1220 -defaultsOSRD
preplace port rgb_led -pg 1 -y 1130 -defaultsOSRD
preplace port SCLK_M -pg 1 -y 580 -defaultsOSRD
preplace port R_N -pg 1 -y 820 -defaultsOSRD
preplace port cellular_ram -pg 1 -y 1400 -defaultsOSRD
preplace port MISO_M -pg 1 -y 560 -defaultsOSRD -right
preplace port reset -pg 1 -y 1320 -defaultsOSRD
preplace portBus CS_S -pg 1 -y 270 -defaultsOSRD -right
preplace portBus CS_M -pg 1 -y 600 -defaultsOSRD
preplace inst rst_clk_wiz_0_100M -pg 1 -lvl 2 -y 1340 -defaultsOSRD
preplace inst axi_emc_0 -pg 1 -lvl 6 -y 1400 -defaultsOSRD
preplace inst microblaze_0_axi_periph -pg 1 -lvl 5 -y 920 -defaultsOSRD
preplace inst SPI_S -pg 1 -lvl 6 -y 240 -defaultsOSRD
preplace inst axi_gpio_0 -pg 1 -lvl 6 -y 1120 -defaultsOSRD
preplace inst axi_gpio_1 -pg 1 -lvl 6 -y 1240 -defaultsOSRD
preplace inst adc_io_0 -pg 1 -lvl 6 -y 840 -defaultsOSRD
preplace inst mdm_1 -pg 1 -lvl 3 -y 1180 -defaultsOSRD
preplace inst spi_M -pg 1 -lvl 6 -y 570 -defaultsOSRD
preplace inst axi_uartlite_0 -pg 1 -lvl 6 -y 720 -defaultsOSRD
preplace inst microblaze_0 -pg 1 -lvl 4 -y 1180 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 1 -y 1390 -defaultsOSRD
preplace inst axi_mem_intercon -pg 1 -lvl 5 -y 1290 -defaultsOSRD
preplace inst microblaze_0_local_memory -pg 1 -lvl 5 -y 1540 -defaultsOSRD
preplace inst adc_gpio -pg 1 -lvl 6 -y 990 -defaultsOSRD
preplace netloc adc_io_0_START 1 6 1 NJ
preplace netloc io1_i_1 1 6 1 NJ
preplace netloc MOSI_1 1 6 1 NJ
preplace netloc microblaze_0_axi_periph_M04_AXI 1 5 1 1530
preplace netloc rst_clk_wiz_0_100M_bus_struct_reset 1 2 3 NJ 1320 NJ 1320 1170
preplace netloc clk_wiz_0_locked 1 1 1 190
preplace netloc adc_io_0_R_N 1 6 1 NJ
preplace netloc microblaze_0_Clk 1 1 5 180 400 NJ 400 720 400 1220 400 1550
preplace netloc microblaze_0_axi_periph_M03_AXI 1 5 1 1500
preplace netloc microblaze_0_axi_periph_M00_AXI 1 5 1 1520
preplace netloc microblaze_0_M_AXI_DP 1 4 1 1200
preplace netloc axi_mem_intercon_M00_AXI 1 5 1 1510
preplace netloc microblaze_0_M_AXI_DC 1 4 1 N
preplace netloc microblaze_0_ilmb_1 1 4 1 1190
preplace netloc spi_M_sck_o 1 6 1 NJ
preplace netloc axi_quad_spi_1_io0_o 1 6 1 NJ
preplace netloc sys_clock_1 1 0 1 NJ
preplace netloc microblaze_0_axi_periph_M05_AXI 1 5 1 N
preplace netloc CS_1 1 6 1 NJ
preplace netloc axi_emc_0_EMC_INTF 1 6 1 NJ
preplace netloc SCLK_1 1 6 1 NJ
preplace netloc axi_gpio_0_GPIO2 1 6 1 NJ
preplace netloc microblaze_0_axi_periph_M01_AXI 1 5 1 1570
preplace netloc microblaze_0_M_AXI_IC 1 4 1 N
preplace netloc axi_gpio_2_gpio2_io_o 1 5 2 1580 910 1840
preplace netloc axi_quad_spi_0_io1_o 1 6 1 NJ
preplace netloc rst_clk_wiz_0_100M_mb_reset 1 2 2 NJ 1300 710
preplace netloc axi_gpio_0_GPIO 1 6 1 NJ
preplace netloc axi_uartlite_0_UART 1 6 1 NJ
preplace netloc clk_wiz_0_clk_out2 1 1 6 180J 1450 NJ 1450 NJ 1450 NJ 1450 1540J 1480 NJ
preplace netloc microblaze_0_axi_periph_M02_AXI 1 5 1 1540
preplace netloc microblaze_0_dlmb_1 1 4 1 1210
preplace netloc adc_io_0_GPIO_DRDY 1 6 1 1850
preplace netloc DRDY_N_1 1 0 6 NJ 1080 NJ 1080 NJ 1080 NJ 1080 1230J 1140 1510J
preplace netloc spi_M_ss_o 1 6 1 NJ
preplace netloc axi_gpio_1_GPIO 1 6 1 NJ
preplace netloc microblaze_0_debug 1 3 1 N
preplace netloc rst_clk_wiz_0_100M_interconnect_aresetn 1 2 3 NJ 1360 NJ 1360 1180
preplace netloc rst_clk_wiz_0_100M_peripheral_aresetn 1 2 5 NJ 1380 NJ 1380 1240 1440 1560 1310 1840
preplace netloc reset_1 1 0 2 20 1320 NJ
preplace netloc mdm_1_debug_sys_rst 1 1 3 190 1110 NJ 1110 710
levelinfo -pg 1 0 100 350 610 950 1370 1710 1870 -top 0 -bot 1620
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


