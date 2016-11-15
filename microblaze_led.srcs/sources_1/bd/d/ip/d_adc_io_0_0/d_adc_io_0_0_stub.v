// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue Nov 15 20:06:41 2016
// Host        : Baldr running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               d:/Nora/cmod_a7_projects/microblaze_led/microblaze_led.srcs/sources_1/bd/d/ip/d_adc_io_0_0/d_adc_io_0_0_stub.v
// Design      : d_adc_io_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a15tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "adc_io,Vivado 2016.3" *)
module d_adc_io_0_0(R_N, DRDY_N, START, GPIO_DRDY, RESET, GPIO_OUT)
/* synthesis syn_black_box black_box_pad_pin="R_N,DRDY_N,START,GPIO_DRDY,RESET,GPIO_OUT[0:0]" */;
  output R_N;
  input DRDY_N;
  output START;
  output GPIO_DRDY;
  input RESET;
  input [0:0]GPIO_OUT;
endmodule
