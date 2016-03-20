`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:10:50 08/13/2015 
// Design Name: 
// Module Name:    serdes 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module serdes(
		input clk_in,
		input [7:0]data_in,
		input en,
		input rst,
		output ser_data,
		output ser_clk //8*clk_in
    );

	
	   wire OQ;    // 1-bit data path output
      wire SHIFTOUT1; // 1-bit data expansion output
      wire SHIFTOUT2; // 1-bit data expansion output
      wire TQ;    // 1-bit 3-state control output
      wire CLK;       // 1-bit clock input
      wire CLKDIV; // 1-bit divided clock input
      wire OCE;  // 1-bit clock enable input
      wire SHIFTIN1; // 1-bit data expansion input
      wire SHIFTIN2; // 1-bit data expansion input
      wire SR;    // 1-bit set/reset input
      wire T1;    // 1-bit parallel 3-state input
      wire T2;    // 1-bit parallel 3-state input
      wire T3;    // 1-bit parallel 3-state input
      wire T4;    // 1-bit parallel 3-state input
      wire TCE;   // 1-bit 3-state signal clock enable input

   // Master SerDes
	OSERDES #(
      .DATA_RATE_OQ("SDR"), // Specify data rate to "DDR" or "SDR" 
      .DATA_RATE_TQ("SDR"), // Specify data rate to "DDR", "SDR", or "BUF" 
      .DATA_WIDTH(8), // Specify data width - for DDR: 4,6,8, or 10
                      //     for SDR or BUF: 2,3,4,5,6,7, or 8
      .INIT_OQ(1'b0), // INIT for OQ register - 1'b1 or 1'b0
      .INIT_TQ(1'b0), // INIT for OQ register - 1'b1 or 1'b0
      .SERDES_MODE("MASTER"), // Set SERDES mode to "MASTER" or "SLAVE" 
      .SRVAL_OQ(1'b0), // Define OQ output value upon SR assertion - 1'b1 or 1'b0
      .SRVAL_TQ(1'b0), // Define TQ output value upon SR assertion - 1'b1 or 1'b0
      .TRISTATE_WIDTH(1)  // Specify parallel to serial converter width
                          //    When DATA_RATE_TQ = DDR: 2 or 4
                          //    When DATA_RATE_TQ = SDR or BUF: 1
   ) OSERDES_inst_Master (
      .OQ(ser_data),    // 1-bit data path output
      .SHIFTOUT1(), // 1-bit data expansion output
      .SHIFTOUT2(), // 1-bit data expansion output
      .TQ(),    // 1-bit 3-state control output
      .CLK(CLK),       // 1-bit clock input
      .CLKDIV(CLKDIV), // 1-bit divided clock input
      .D1(data_in[0]),    // 1-bit parallel data input
      .D2(data_in[1]),    // 1-bit parallel data input
      .D3(data_in[2]),    // 1-bit parallel data input
      .D4(data_in[3]),    // 1-bit parallel data input
      .D5(data_in[4]),    // 1-bit parallel data input
      .D6(data_in[5]),    // 1-bit parallel data input
      .OCE(en),  // 1-bit clock enable input
      .REV(1'b0), // Must be tied to logic zero
      .SHIFTIN1(SHIFTOUT1), // 1-bit data expansion input
      .SHIFTIN2(1'b0),//SHIFTOUT2), // 1-bit data expansion input
      .SR(rst),    // 1-bit set/reset input
      .T1(1'b0),    // 1-bit parallel 3-state input
      .T2(1'b0),    // 1-bit parallel 3-state input
      .T3(1'b0),    // 1-bit parallel 3-state input
      .T4(1'b0),    // 1-bit parallel 3-state input
      .TCE(1'b0)   // 1-bit 3-state signal clock enable input
   );

	// Slave SerDes
	OSERDES #(
      .DATA_RATE_OQ("SDR"), // Specify data rate to "DDR" or "SDR" 
      .DATA_RATE_TQ("SDR"), // Specify data rate to "DDR", "SDR", or "BUF" 
      .DATA_WIDTH(6), // Specify data width - for DDR: 4,6,8, or 10
                      //     for SDR or BUF: 2,3,4,5,6,7, or 8
      .INIT_OQ(1'b0), // INIT for OQ register - 1'b1 or 1'b0
      .INIT_TQ(1'b0), // INIT for OQ register - 1'b1 or 1'b0
      .SERDES_MODE("SLAVE"), // Set SERDES mode to "MASTER" or "SLAVE" 
      .SRVAL_OQ(1'b0), // Define OQ output value upon SR assertion - 1'b1 or 1'b0
      .SRVAL_TQ(1'b0), // Define TQ output value upon SR assertion - 1'b1 or 1'b0
      .TRISTATE_WIDTH(1)  // Specify parallel to serial converter width
                          //    When DATA_RATE_TQ = DDR: 2 or 4
                          //    When DATA_RATE_TQ = SDR or BUF: 1
   ) OSERDES_inst_Slave (
      .OQ(),    // 1-bit data path output
      .SHIFTOUT1(SHIFTOUT1), // 1-bit data expansion output
      .SHIFTOUT2(SHIFTOUT2), // 1-bit data expansion output
      .TQ(),    // 1-bit 3-state control output
      .CLK(CLK),       // 1-bit clock input
      .CLKDIV(CLKDIV), // 1-bit divided clock input
      .D1(1'b0),    // 1-bit parallel data input
      .D2(1'b0),    // 1-bit parallel data input
      .D3(data_in[6]),    // 1-bit parallel data input
      .D4(data_in[7]),    // 1-bit parallel data input
      .D5(1'b0),    // 1-bit parallel data input
      .D6(1'b0),    // 1-bit parallel data input
      .OCE(en),  // 1-bit clock enable input
      .REV(1'b0), // Must be tied to logic zero
      .SHIFTIN1(1'b0), // 1-bit data expansion input
      .SHIFTIN2(1'b0), // 1-bit data expansion input
      .SR(rst),    // 1-bit set/reset input
      .T1(1'b0),    // 1-bit parallel 3-state input
      .T2(1'b0),    // 1-bit parallel 3-state input
      .T3(1'b0),    // 1-bit parallel 3-state input
      .T4(1'b0),    // 1-bit parallel 3-state input
      .TCE(1'b0)   // 1-bit 3-state signal clock enable input
   );

	// ClkDiv 
	 wire pll_fb;
	 wire pll_lock;
	 wire pll_rst;
	 wire pll_clk_in;
	 wire CLK0;
	 DCM_BASE #(
      .CLKDV_DIVIDE(2.0), // Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5
                          //   7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
      .CLKFX_DIVIDE(1), // Can be any integer from 1 to 32
      .CLKFX_MULTIPLY(8), // Can be any integer from 2 to 32
      .CLKIN_DIVIDE_BY_2("FALSE"), // TRUE/FALSE to enable CLKIN divide by two feature
      .CLKIN_PERIOD(13.3333), // Specify period of input clock in ns from 1.25 to 1000.00
      .CLKOUT_PHASE_SHIFT("NONE"), // Specify phase shift mode of NONE or FIXED
      .CLK_FEEDBACK("1X"), // Specify clock feedback of NONE or 1X
      .DCM_PERFORMANCE_MODE("MAX_SPEED"), // Can be MAX_SPEED or MAX_RANGE
      .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or
                                            //   an integer from 0 to 15
      .DFS_FREQUENCY_MODE("LOW"), // LOW or HIGH frequency mode for frequency synthesis
      .DLL_FREQUENCY_MODE("LOW"), // LOW, HIGH, or HIGH_SER frequency mode for DLL
      .DUTY_CYCLE_CORRECTION("TRUE"), // Duty cycle correction, TRUE or FALSE
      .FACTORY_JF(16'hf0f0), // FACTORY JF value suggested to be set to 16'hf0f0
      .PHASE_SHIFT(0), // Amount of fixed phase shift from -255 to 1023
      .STARTUP_WAIT("FALSE") // Delay configuration DONE until DCM LOCK, TRUE/FALSE
   ) DCM_BASE_inst (
      .CLK0(CLK0),//CLKDIV),         // 0 degree DCM CLK output
      .CLK180(),     // 180 degree DCM CLK output
      .CLK270(),     // 270 degree DCM CLK output
      .CLK2X(),       // 2X DCM CLK output
      .CLK2X180(), // 2X, 180 degree DCM CLK out
      .CLK90(),       // 90 degree DCM CLK output
      .CLKDV(),       // Divided DCM CLK out (CLKDV_DIVIDE)
      .CLKFX(CLK),       // DCM CLK synthesis out (M/D)
      .CLKFX180(), // 180 degree CLK synthesis out
      .LOCKED(pll_lock),     // DCM LOCK status output
      .CLKFB(pll_fb),       // DCM clock feedback
      .CLKIN(pll_clk_in),       // Clock input (from IBUFG, BUFG or DCM)
      .RST(~en)            // DCM asynchronous reset input
   );
	
	BUFG BUFG_inst1 (
      .O(pll_clk_in),     // Clock buffer output
      .I(clk_in)      // Clock buffer input
   );	 

	 BUFG BUFG_inst2 (
      .O(pll_fb),     // Clock buffer output
      .I(CLK0)      // Clock buffer input
   );
	
	BUFIO BUFIO_inst (
      .O(ser_clk),     // Clock buffer output
      .I(CLK)      // Clock buffer input
   );
	
	BUFR #(
      .BUFR_DIVIDE("1"), // "BYPASS", "1", "2", "3", "4", "5", "6", "7", "8" 
      .SIM_DEVICE("VIRTEX5")  // Specify target device, "VIRTEX4", "VIRTEX5", "VIRTEX6" 
   ) BUFR_inst (
      .O(CLKDIV),     // Clock buffer output
      .CE(1),   // Clock enable input
      .CLR(0), // Clock buffer reset input
      .I(CLK)      // Clock buffer input
   );
//	assign ser_clk = CLK;

endmodule
