/*
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 * 
 *
 * This file is a generated sample test application.
 *
 * This application is intended to test and/or illustrate some 
 * functionality of your system.  The contents of this file may
 * vary depending on the IP in your system and may use existing
 * IP driver functions.  These drivers will be generated in your
 * SDK application project when you run the "Generate Libraries" menu item.
 *
 */

#include <stdio.h>
#include "xparameters.h"
#include "xil_cache.h"
#include "xgpio.h"
#include "gpio_header.h"
#include "xspi.h"
#include "spi_header.h"

#define BLUE 0xFE
#define RED 0xFB
#define GREEN 0xFD
#define OFF 0xFF
#define WHITE 0xF0
#define PINK  0xFA

XGpio LED_BLUE;
XGpio RGB;


void initLED_BLUE(){
	XGpio_Config GPIO_1_conf;
	GPIO_1_conf.BaseAddress = XPAR_AXI_GPIO_1_BASEADDR;
	GPIO_1_conf.DeviceId = XPAR_AXI_GPIO_1_DEVICE_ID;
	GPIO_1_conf.InterruptPresent = XPAR_GPIO_1_INTERRUPT_PRESENT;
	GPIO_1_conf.IsDual = XPAR_GPIO_1_IS_DUAL;
	XGpio_CfgInitialize(&LED_BLUE, &GPIO_1_conf, GPIO_1_conf.BaseAddress);
	XGpio_SetDataDirection(&LED_BLUE, 1, 0);
	XGpio_SetDataDirection(&LED_BLUE, 2, 1);
}
void initRGB(){
	XGpio_Config GPIO_0_conf;
	GPIO_0_conf.BaseAddress = XPAR_AXI_GPIO_0_BASEADDR;
	GPIO_0_conf.DeviceId = XPAR_AXI_GPIO_0_DEVICE_ID;
	GPIO_0_conf.InterruptPresent = XPAR_GPIO_0_INTERRUPT_PRESENT;
	GPIO_0_conf.IsDual = XPAR_GPIO_0_IS_DUAL;
	//Initialize the XGpio instance
	XGpio_CfgInitialize(&RGB, &GPIO_0_conf, GPIO_0_conf.BaseAddress);
	XGpio_SetDataDirection(&RGB, 2, 0);
}
void WriteRGB (u32 color){
	 XGpio_DiscreteWrite(&RGB, 2, color);
}
void WriteLED (u32 color){
	 XGpio_DiscreteWrite(&LED_BLUE, 1, color);
}
int main()
{
	initLED_BLUE();
	initRGB();
	Xil_ICacheEnable();
	Xil_DCacheEnable();
	print("---Entering main---\n\r");

  while(1){
	if (XGpio_DiscreteRead(&LED_BLUE, 2) == 0x1) {
		  WriteLED(OFF);
	  }
	  else{
		  WriteLED(WHITE);
	}
	  if (XGpio_DiscreteRead(&RGB, 1) == 0x1) {
		  WriteRGB(RED);
		  //WriteLED(OFF);
		 // printf("LED_BLUE ON\r\n");
	  }
	  else {
		 WriteRGB(OFF);
		 //WriteLED(WHITE);
		 //print("LED_BLUE OFF\r\n");

	  }
  }
   print("---Exiting main---\n\r");
   Xil_DCacheDisable();
   Xil_ICacheDisable();
   return 0;
}
