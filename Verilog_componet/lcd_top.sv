`default_nettype none `timescale 1ns / 1ps

module lcd_top (
    input wire clk_50M,     //50MHz 时钟输入

    input wire reset_btn,  //BTN6手动复位按钮??关，带消抖电路，按下时为1
    input wire [3:0] A_shi,
    input wire [3:0] A_ge,
    input wire [3:0] B_shi,
    input wire [3:0] B_ge,
    input wire [55:0] OP_display,
    input wire [7:0] operand_shi,
    input wire [7:0] operand_ge,

    //图像输出信号
    output wire [2:0] video_red,    //红色像素??3??
    output wire [2:0] video_green,  //绿色像素??3??
    output wire [1:0] video_blue,   //蓝色像素??2??
    output wire       video_hsync,  //行同步（水平同步）信??
    output wire       video_vsync,  //场同步（垂直同步）信??
    output wire       video_clk,    //像素时钟输出
    output wire       video_de      //行数据有效信号，用于区分消隐??
);
  // generate pixel clock
  logic clk_pix;
  logic clk_pix_locked;

  clock_divider clock_div_inst (
      .clk(clk_50M),
      .rst(reset_btn),
      .clk_div(clk_pix)
  );
    wire [15:0] line_2_ascii;
  dvi_module dvi_inst (
      .clk(clk_pix),
      .clk_locked(reset_btn),
      .video_red(video_red),
      .video_green(video_green),
      .video_blue(video_blue),
      .video_hsync(video_hsync),
      .video_vsync(video_vsync),
      .video_clk(video_clk),
      .video_de(video_de),
      .line_0_ascii(line_0),
      .line_1_ascii(line_1),
    //  .line_2_number( )
      .line_2_number(number)
    //  .line_2_ascii_to_top(line_2_ascii)
  );



  wire [79:0] line_0; // 为了方便赋???，??个ascii占用8bit
  wire [79:0] line_1; // 56-bit line buffer, 7 bit per ascii character


assign line_0 = {OP_display,8'h20,operand_shi,operand_ge};
assign line_1 = {8'h3b,8'h3a,A_shi+8'h30,A_ge+8'h30,8'h20,8'h3c,8'h3a,B_shi+8'h30,B_ge+8'h30,8'h20};


localparam CNT_1S = 27'd50_000_000;
reg [26:0] cnt;
wire cnt_eq_1s;
assign cnt_eq_1s = cnt==(CNT_1S-1);
always @(posedge clk_50M)
begin
    if (reset_btn)
    begin
        cnt <= 27'd0;
    end
    else if (cnt_eq_1s)
    begin
        cnt <= 27'd0;
    end
    else
    begin
        cnt <= cnt + 1'b1;
    end
end

reg [7:0] ascii;
always @(posedge clk_50M)
begin
    if (reset_btn)
    begin
        ascii <= 8'd0;
    end
    else if (cnt_eq_1s)
    begin
        if (ascii == 8'd9)
        begin
            ascii <= 8'd0;
        end
        else
        begin
            ascii <= ascii + 1'b1;
        end
    end
end

reg [4:0] number;
always @(posedge clk_50M)
begin
    if (reset_btn)
    begin
        number <= 5'h0;
    end
    else if (cnt_eq_1s)
    begin
        number <= number + 5'b1;
    end
end

endmodule

module ascii_rom_async (
    input  wire  [10:0] addr,
    output reg   [7:0] data
);

always @(*) begin
    case (addr)
        // code x30 (0)
			11'h300: data = 8'b00000000;	//
			11'h301: data = 8'b00000000;	//
			11'h302: data = 8'b00111000;	//  ***  
			11'h303: data = 8'b01101100;	// ** **
			11'h304: data = 8'b11000110;	//**   **
			11'h305: data = 8'b11000110;	//**   **
			11'h306: data = 8'b11000110;	//**   **
			11'h307: data = 8'b11000110;	//**   **
			11'h308: data = 8'b11000110;	//**   **
			11'h309: data = 8'b11000110;	//**   **
			11'h30a: data = 8'b01101100;	// ** **
			11'h30b: data = 8'b00111000;	//  ***
			11'h30c: data = 8'b00000000;	//
			11'h30d: data = 8'b00000000;	//
			11'h30e: data = 8'b00000000;	//
			11'h30f: data = 8'b00000000;	//
			// code x31 (1)
			11'h310: data = 8'b00000000;	//
			11'h311: data = 8'b00000000;	//
			11'h312: data = 8'b00011000;	//   **  
			11'h313: data = 8'b00111000;	//  ***
			11'h314: data = 8'b01111000;	// ****
			11'h315: data = 8'b00011000;	//   **
			11'h316: data = 8'b00011000;	//   **
			11'h317: data = 8'b00011000;	//   **
			11'h318: data = 8'b00011000;	//   **
			11'h319: data = 8'b00011000;	//   **
			11'h31a: data = 8'b01111110;	// ******
			11'h31b: data = 8'b01111110;	// ******
			11'h31c: data = 8'b00000000;	//
			11'h31d: data = 8'b00000000;	//
			11'h31e: data = 8'b00000000;	//
			11'h31f: data = 8'b00000000;	//
			// code x32 (2)
			11'h320: data = 8'b00000000;	//
			11'h321: data = 8'b00000000;	//
			11'h322: data = 8'b11111110;	//*******  
			11'h323: data = 8'b11111110;	//*******
			11'h324: data = 8'b00000110;	//     **
			11'h325: data = 8'b00000110;	//     **
			11'h326: data = 8'b11111110;	//*******
			11'h327: data = 8'b11111110;	//*******
			11'h328: data = 8'b11000000;	//**
			11'h329: data = 8'b11000000;	//**
			11'h32a: data = 8'b11111110;	//*******
			11'h32b: data = 8'b11111110;	//*******
			11'h32c: data = 8'b00000000;	//
			11'h32d: data = 8'b00000000;	//
			11'h32e: data = 8'b00000000;	//
			11'h32f: data = 8'b00000000;	//
			// code x33 (3)
			11'h330: data = 8'b00000000;	//
			11'h331: data = 8'b00000000;	//
			11'h332: data = 8'b11111110;	//*******  
			11'h333: data = 8'b11111110;	//*******
			11'h334: data = 8'b00000110;	//     **
			11'h335: data = 8'b00000110;	//     **
			11'h336: data = 8'b00111110;	//  *****
			11'h337: data = 8'b00111110;	//  *****
			11'h338: data = 8'b00000110;	//     **
			11'h339: data = 8'b00000110;	//     **
			11'h33a: data = 8'b11111110;	//*******
			11'h33b: data = 8'b11111110;	//*******
			11'h33c: data = 8'b00000000;	//
			11'h33d: data = 8'b00000000;	//
			11'h33e: data = 8'b00000000;	//
			11'h33f: data = 8'b00000000;	//
			// code x34 (4)
			11'h340: data = 8'b00000000;	//
			11'h341: data = 8'b00000000;	//
			11'h342: data = 8'b11000110;	//**   **  
			11'h343: data = 8'b11000110;	//**   **
			11'h344: data = 8'b11000110;	//**   **
			11'h345: data = 8'b11000110;	//**   **
			11'h346: data = 8'b11111110;	//*******
			11'h347: data = 8'b11111110;	//*******
			11'h348: data = 8'b00000110;	//     **
			11'h349: data = 8'b00000110;	//     **
			11'h34a: data = 8'b00000110;	//     **
			11'h34b: data = 8'b00000110;	//     **
			11'h34c: data = 8'b00000000;	//
			11'h34d: data = 8'b00000000;	//
			11'h34e: data = 8'b00000000;	//
			11'h34f: data = 8'b00000000;	//
			// code x35 (5)
			11'h350: data = 8'b00000000;	//
			11'h351: data = 8'b00000000;	//
			11'h352: data = 8'b11111110;	//*******  
			11'h353: data = 8'b11111110;	//*******
			11'h354: data = 8'b11000000;	//**
			11'h355: data = 8'b11000000;	//**
			11'h356: data = 8'b11111110;	//*******
			11'h357: data = 8'b11111110;	//*******
			11'h358: data = 8'b00000110;	//     **
			11'h359: data = 8'b00000110;	//     **
			11'h35a: data = 8'b11111110;	//*******
			11'h35b: data = 8'b11111110;	//*******
			11'h35c: data = 8'b00000000;	//
			11'h35d: data = 8'b00000000;	//
			11'h35e: data = 8'b00000000;	//
			11'h35f: data = 8'b00000000;	//
			// code x36 (6)
			11'h360: data = 8'b00000000;	//
			11'h361: data = 8'b00000000;	//
			11'h362: data = 8'b11111110;	//*******  
			11'h363: data = 8'b11111110;	//*******
			11'h364: data = 8'b11000000;	//**
			11'h365: data = 8'b11000000;	//**
			11'h366: data = 8'b11111110;	//*******
			11'h367: data = 8'b11111110;	//*******
			11'h368: data = 8'b11000110;	//**   **
			11'h369: data = 8'b11000110;	//**   **
			11'h36a: data = 8'b11111110;	//*******
			11'h36b: data = 8'b11111110;	//*******
			11'h36c: data = 8'b00000000;	//
			11'h36d: data = 8'b00000000;	//
			11'h36e: data = 8'b00000000;	//
			11'h36f: data = 8'b00000000;	//
			// code x37 (7)
			11'h370: data = 8'b00000000;	//
			11'h371: data = 8'b00000000;	//
			11'h372: data = 8'b11111110;	//*******  
			11'h373: data = 8'b11111110;	//*******
			11'h374: data = 8'b00000110;	//     **
			11'h375: data = 8'b00000110;	//     **
			11'h376: data = 8'b00000110;	//     **
			11'h377: data = 8'b00000110;	//     **
			11'h378: data = 8'b00000110;	//     **
			11'h379: data = 8'b00000110;	//     **
			11'h37a: data = 8'b00000110;	//     **
			11'h37b: data = 8'b00000110;	//     **
			11'h37c: data = 8'b00000000;	//
			11'h37d: data = 8'b00000000;	//
			11'h37e: data = 8'b00000000;	//
			11'h37f: data = 8'b00000000;	//
			// code x38 (8)
			11'h380: data = 8'b00000000;	//
			11'h381: data = 8'b00000000;	//
			11'h382: data = 8'b11111110;	//*******  
			11'h383: data = 8'b11111110;	//*******
			11'h384: data = 8'b11000110;	//**   **
			11'h385: data = 8'b11000110;	//**   **
			11'h386: data = 8'b11111110;	//*******
			11'h387: data = 8'b11111110;	//*******
			11'h388: data = 8'b11000110;	//**   **
			11'h389: data = 8'b11000110;	//**   **
			11'h38a: data = 8'b11111110;	//*******
			11'h38b: data = 8'b11111110;	//*******
			11'h38c: data = 8'b00000000;	//
			11'h38d: data = 8'b00000000;	//
			11'h38e: data = 8'b00000000;	//
			11'h38f: data = 8'b00000000;	//
			// code x39 (9)
			11'h390: data = 8'b00000000;	//
			11'h391: data = 8'b00000000;	//
			11'h392: data = 8'b11111110;	//*******  
			11'h393: data = 8'b11111110;	//*******
			11'h394: data = 8'b11000110;	//**   **
			11'h395: data = 8'b11000110;	//**   **
			11'h396: data = 8'b11111110;	//*******
			11'h397: data = 8'b11111110;	//*******
			11'h398: data = 8'b00000110;	//     **
			11'h399: data = 8'b00000110;	//     **
			11'h39a: data = 8'b11111110;	//*******
			11'h39b: data = 8'b11111110;	//*******
			11'h39c: data = 8'b00000000;	//
			11'h39d: data = 8'b00000000;	//
			11'h39e: data = 8'b00000000;	//
			11'h39f: data = 8'b00000000;	//
			// code x3a (:)
			11'h3a0: data = 8'b00000000;	//
			11'h3a1: data = 8'b00000000;	//
			11'h3a2: data = 8'b00000000;	//
			11'h3a3: data = 8'b00000000;	//
			11'h3a4: data = 8'b00011000;	//   **
			11'h3a5: data = 8'b00011000;	//   **
			11'h3a6: data = 8'b00000000;	//
			11'h3a7: data = 8'b00000000;	//
			11'h3a8: data = 8'b00011000;	//   **
			11'h3a9: data = 8'b00011000;	//   **
			11'h3aa: data = 8'b00000000;	//   
			11'h3ab: data = 8'b00000000;	//   
			11'h3ac: data = 8'b00000000;	//
			11'h3ad: data = 8'b00000000;	//
			11'h3ae: data = 8'b00000000;	//
			11'h3af: data = 8'b00000000;	//
			// code x3b (A)
            11'h3b0: data = 8'b00000000;	// 空行
            11'h3b1: data = 8'b00000000;	// 空行
            11'h3b2: data = 8'b00011000;	//    **
            11'h3b3: data = 8'b00111100;	//   ****
            11'h3b4: data = 8'b01100110;	//  **  **
            11'h3b5: data = 8'b01000110;	//  *   **
            11'h3b6: data = 8'b01000110;	//  *   **
            11'h3b7: data = 8'b11111110;	// *******
            11'h3b8: data = 8'b11111110;	// *******
            11'h3b9: data = 8'b11000110;	// **   **
            11'h3ba: data = 8'b11000110;	// **   **
            11'h3bb: data = 8'b11000110;	// **   **
            11'h3bc: data = 8'b00000000;	// 空行
            11'h3bd: data = 8'b00000000;	// 空行
            11'h3be: data = 8'b00000000;	// 空行
            11'h3bf: data = 8'b00000000;	// 空行
            
            // code x3c (B)
            11'h3c0: data = 8'b00000000;	// 空行
            11'h3c1: data = 8'b00000000;	// 空行
            11'h3c2: data = 8'b11111000;	// ***** 
            11'h3c3: data = 8'b11001100;	// **  **
            11'h3c4: data = 8'b11000110;	// **   **
            11'h3c5: data = 8'b11000110;	// **   **
            11'h3c6: data = 8'b11111100;	// ******
            11'h3c7: data = 8'b11111100;	// ******
            11'h3c8: data = 8'b11000110;	// **   **
            11'h3c9: data = 8'b11000110;	// **   **
            11'h3ca: data = 8'b11001100;	// **  **
            11'h3cb: data = 8'b11111000;	// ***** 
            11'h3cc: data = 8'b00000000;	// 空行
            11'h3cd: data = 8'b00000000;	// 空行
            11'h3ce: data = 8'b00000000;	// 空行
            11'h3cf: data = 8'b00000000;	// 空行
			// code x3d (C)
            11'h3d0: data = 8'b00000000;   //
            11'h3d1: data = 8'b00000000;   //
            11'h3d2: data = 8'b00111100;   //   ****
            11'h3d3: data = 8'b01100110;   //  **  **
            11'h3d4: data = 8'b11000010;   // **    *
            11'h3d5: data = 8'b11000000;   // **     
            11'h3d6: data = 8'b11000000;   // **     
            11'h3d7: data = 8'b11000000;   // **     
            11'h3d8: data = 8'b11000010;   // **    *
            11'h3d9: data = 8'b01100110;   //  **  **
            11'h3da: data = 8'b00111100;   //   ****
            11'h3db: data = 8'b00000000;   //
            11'h3dc: data = 8'b00000000;   //
            11'h3dd: data = 8'b00000000;   //
            11'h3de: data = 8'b00000000;   //
            11'h3df: data = 8'b00000000;   //
            // code x3e (P)
            11'h3e0: data = 8'b00000000;   //
            11'h3e1: data = 8'b00000000;   //
            11'h3e2: data = 8'b11111100;   //  ******
            11'h3e3: data = 8'b11000110;   //  **   **
            11'h3e4: data = 8'b11000110;   //  **   **
            11'h3e5: data = 8'b11000110;   //  **   **
            11'h3e6: data = 8'b11111100;   //  ******
            11'h3e7: data = 8'b11000000;   //  **     
            11'h3e8: data = 8'b11000000;   //  **     
            11'h3e9: data = 8'b11000000;   //  **     
            11'h3ea: data = 8'b11000000;   //  **     
            11'h3eb: data = 8'b00000000;   //
            11'h3ec: data = 8'b00000000;   //
            11'h3ed: data = 8'b00000000;   //
            11'h3ee: data = 8'b00000000;   //
            11'h3ef: data = 8'b00000000;   //
            // code x3f (D)
            11'h3f0: data = 8'b00000000;   //
            11'h3f1: data = 8'b00000000;   //
            11'h3f2: data = 8'b11111100;   //  ******
            11'h3f3: data = 8'b11000110;   //  **   **
            11'h3f4: data = 8'b11000010;   //  **    *
            11'h3f5: data = 8'b11000010;   //  **    *
            11'h3f6: data = 8'b11000010;   //  **    *
            11'h3f7: data = 8'b11000110;   //  **   **
            11'h3f8: data = 8'b11111100;   //  ******
            11'h3f9: data = 8'b00000000;   //
            11'h3fa: data = 8'b00000000;   //
            11'h3fb: data = 8'b00000000;   //
            11'h3fc: data = 8'b00000000;   //
            11'h3fd: data = 8'b00000000;   //
            11'h3fe: data = 8'b00000000;   //
            11'h3ff: data = 8'b00000000;   //
            
            // code x40 (L)
            11'h400: data = 8'b00000000;   //
            11'h401: data = 8'b00000000;   //
            11'h402: data = 8'b11000000;   //  **
            11'h403: data = 8'b11000000;   //  **
            11'h404: data = 8'b11000000;   //  **
            11'h405: data = 8'b11000000;   //  **
            11'h406: data = 8'b11000000;   //  **
            11'h407: data = 8'b11000000;   //  **
            11'h408: data = 8'b11000000;   //  *******
            11'h409: data = 8'b11111110;   //
            11'h40a: data = 8'b11111110;   //
            11'h40b: data = 8'b00000000;   //
            11'h40c: data = 8'b00000000;   //
            11'h40d: data = 8'b00000000;   //
            11'h40e: data = 8'b00000000;   //
            11'h40f: data = 8'b00000000;   //
            
            // code x41 (S)
            11'h410: data = 8'b00000000;   //
            11'h411: data = 8'b00000000;   //
            11'h412: data = 8'b00111100;   //   ****
            11'h413: data = 8'b01100110;   //  **  **
            11'h414: data = 8'b11000010;   // **    *
            11'h415: data = 8'b01100000;   //  **    
            11'h416: data = 8'b00111100;   //   ****
            11'h417: data = 8'b00000110;   //      **
            11'h418: data = 8'b11000110;   // **   **
            11'h419: data = 8'b01111100;   //  *****
            11'h41a: data = 8'b00000000;   //
            11'h41b: data = 8'b00000000;   //
            11'h41c: data = 8'b00000000;   //
            11'h41d: data = 8'b00000000;   //
            11'h41e: data = 8'b00000000;   //
            11'h41f: data = 8'b00000000;   //
            
            // code x42 (T)
            11'h420: data = 8'b00000000;   //
            11'h421: data = 8'b00000000;   //
            11'h422: data = 8'b11111110;   //  *******
            11'h423: data = 8'b00011000;   //    **
            11'h424: data = 8'b00011000;   //    **
            11'h425: data = 8'b00011000;   //    **
            11'h426: data = 8'b00011000;   //    **
            11'h427: data = 8'b00011000;   //    **
            11'h428: data = 8'b00011000;   //    **
            11'h429: data = 8'b00011000;   //
            11'h42a: data = 8'b00000000;   //
            11'h42b: data = 8'b00000000;   //
            11'h42c: data = 8'b00000000;   //
            11'h42d: data = 8'b00000000;   //
            11'h42e: data = 8'b00000000;   //
            11'h42f: data = 8'b00000000;   //
            
            // code x43 (U)
            11'h430: data = 8'b00000000;   //
            11'h431: data = 8'b00000000;   //
            11'h432: data = 8'b11000110;   // **   **
            11'h433: data = 8'b11000110;   // **   **
            11'h434: data = 8'b11000110;   // **   **
            11'h435: data = 8'b11000110;   // **   **
            11'h436: data = 8'b11000110;   // **   **
            11'h437: data = 8'b11000110;   // **   **
            11'h438: data = 8'b01111110;   //  ******
            11'h439: data = 8'b00111100;   //   ****
            11'h43a: data = 8'b00000000;   //
            11'h43b: data = 8'b00000000;   //
            11'h43c: data = 8'b00000000;   //
            11'h43d: data = 8'b00000000;   //
            11'h43e: data = 8'b00000000;   //
            11'h43f: data = 8'b00000000;   //
            
            // code x44 (M)
            11'h440: data = 8'b00000000;   //
            11'h441: data = 8'b00000000;   //
            11'h442: data = 8'b11000010;   // **    **
            11'h443: data = 8'b11100110;   // ***  ***
            11'h444: data = 8'b11101110;   // ********
            11'h445: data = 8'b11111110;   // ********
            11'h446: data = 8'b11011010;   // ********
            11'h447: data = 8'b11010010;   // ** ** **
            11'h448: data = 8'b11000010;   // **    **
            11'h449: data = 8'b11000010;   // **    **
            11'h44a: data = 8'b00000000;   //
            11'h44b: data = 8'b00000000;   //
            11'h44c: data = 8'b00000000;   //
            11'h44d: data = 8'b00000000;   //
            11'h44e: data = 8'b00000000;   //
            11'h44f: data = 8'b00000000;   //
            
            // code x45 (I)
            11'h450: data = 8'b00000000;   //
            11'h451: data = 8'b00000000;   //
            11'h452: data = 8'b00111100;   //   ****
            11'h453: data = 8'b00011000;   //    **
            11'h454: data = 8'b00011000;   //    **
            11'h455: data = 8'b00011000;   //    **
            11'h456: data = 8'b00011000;   //    **
            11'h457: data = 8'b00011000;   //    **
            11'h458: data = 8'b00111100;   //   ****
            11'h459: data = 8'b00000000;   //
            11'h45a: data = 8'b00000000;   //
            11'h45b: data = 8'b00000000;   //
            11'h45c: data = 8'b00000000;   //
            11'h45d: data = 8'b00000000;   //
            11'h45e: data = 8'b00000000;   //
            11'h45f: data = 8'b00000000;   //
            
            // code x46 (V)
            11'h460: data = 8'b00000000;   //
            11'h461: data = 8'b00000000;   //
            11'h462: data = 8'b11000011;   // **    **
            11'h463: data = 8'b11000011;   // **    **
            11'h464: data = 8'b11000011;   // **    **
            11'h465: data = 8'b01100110;   //  **  **
            11'h466: data = 8'b01100110;   //  **  **
            11'h467: data = 8'b00111100;   //   ****
            11'h468: data = 8'b00111100;   //   ****
            11'h469: data = 8'b00011000;   //    **
            11'h46a: data = 8'b00000000;   //
            11'h46b: data = 8'b00000000;   //
            11'h46c: data = 8'b00000000;   //
            11'h46d: data = 8'b00000000;   //
            11'h46e: data = 8'b00000000;   //
            11'h46f: data = 8'b00000000;   //
            
            // code x47 (H)
            11'h470: data = 8'b00000000;   //
            11'h471: data = 8'b00000000;   //
            11'h472: data = 8'b11000110;   // **   **
            11'h473: data = 8'b11000110;   // **   **
            11'h474: data = 8'b11000110;   // **   **
            11'h475: data = 8'b11111110;   // *******
            11'h476: data = 8'b11111110;   // *******
            11'h477: data = 8'b11000110;   // **   **
            11'h478: data = 8'b11000110;   // **   **
            11'h479: data = 8'b11000110;   // **   **
            11'h47a: data = 8'b00000000;   //
            11'h47b: data = 8'b00000000;   //
            11'h47c: data = 8'b00000000;   //
            11'h47d: data = 8'b00000000;   //
            11'h47e: data = 8'b00000000;   //
            11'h47f: data = 8'b00000000;   //
            
            // code x48 (R)
            11'h480: data = 8'b00000000;   //
            11'h481: data = 8'b00000000;   //
            11'h482: data = 8'b11111100;   //  ******
            11'h483: data = 8'b11000110;   //  **   **
            11'h484: data = 8'b11000110;   //  **   **
            11'h485: data = 8'b11111100;   //  ******
            11'h486: data = 8'b11111100;   //  ******
            11'h487: data = 8'b11011000;   //  ** **
            11'h488: data = 8'b11001100;   //  **  **
            11'h489: data = 8'b11000110;   //  **   **
            11'h48a: data = 8'b00000000;   //
            11'h48b: data = 8'b00000000;   //
            11'h48c: data = 8'b00000000;   //
            11'h48d: data = 8'b00000000;   //
            11'h48e: data = 8'b00000000;   //
            11'h48f: data = 8'b00000000;   //
            
            // code x49 (J)
            11'h490: data = 8'b00000000;   //
            11'h491: data = 8'b00000000;   //
            11'h492: data = 8'b00011110;   //    ****
            11'h493: data = 8'b00001100;   //     **
            11'h494: data = 8'b00001100;   //     **
            11'h495: data = 8'b00001100;   //     **
            11'h496: data = 8'b11001100;   // **  **
            11'h497: data = 8'b11001100;   // **  **
            11'h498: data = 8'b01111000;   //  ****
            11'h499: data = 8'b00000000;   //
            11'h49a: data = 8'b00000000;   //
            11'h49b: data = 8'b00000000;   //
            11'h49c: data = 8'b00000000;   //
            11'h49d: data = 8'b00000000;   //
            11'h49e: data = 8'b00000000;   //
            11'h49f: data = 8'b00000000;   //    
            default: data = 8'b00000000;
endcase
end
endmodule

module bin2bcd(
    input wire [4:0] bin,
    output wire [7:0] bcd
);

integer i;

reg [3:0] ones;
reg [3:0] tens;

always @(bin) begin
    ones = 4'b0;
    tens = 4'b0;

    for (i = 4; i >=0; i = i - 1) begin
        if (ones >= 5) begin
            ones = ones + 3;
        end
        if (tens >= 5) begin
            tens = tens + 3;
        end
        tens = {tens[2:0], ones[3]};
        ones = {ones[2:0], bin[i]};
    end
end
assign bcd = {tens, ones};

endmodule

module clock_divider(
    input wire clk,
    input wire rst,
    output reg clk_div
);
always @(posedge clk) begin
    if (rst) begin
        clk_div <= 1'b0;
    end else begin
        clk_div <= ~clk_div;
    end
end
    
endmodule

module dvi_module (
    input   wire          clk,
    input     wire        clk_locked,
    //图像输出信号
    output wire [2:0] video_red,    //红色像素??3??
    output wire [2:0] video_green,  //绿色像素??3??
    output wire [1:0] video_blue,   //蓝色像素??2??
    output wire       video_hsync,  //行同步（水平同步）信??
    output wire       video_vsync,  //场同步（垂直同步）信??
    output wire       video_clk,    //像素时钟输出
    output wire       video_de,     //行数据有效信号，用于区分消隐??

    input wire [79:0] line_0_ascii,  //每个ascii码占8??
    input wire [79:0] line_1_ascii,
    input wire [ 4:0] line_2_number,
    output wire [15:0] line_2_ascii_to_top

);

  assign line_2_ascii_to_top = line_2_ascii[15:0];
  wire [ 7:0] line_2_bcd;
  wire [79:0] line_2_ascii;
  bin2bcd bcd_inst (
      .bin(line_2_number),
      .bcd(line_2_bcd)
  );

  assign line_2_ascii[7:0]  = line_2_bcd[3:0] + 8'h30;
  assign line_2_ascii[15:8]  = line_2_bcd[7:4] + 8'h30;
  assign line_2_ascii[79:16] = 64'h0;

  // display sync signals and coordinaties
  localparam CORDW = 10;  // screen coordinate width in bits
  logic [CORDW-1:0] sx, sy;
  logic hsync, vsync, de;
  simple_480p display_inst (
      .clk_pix(clk),
      .rst_pix(clk_locked),  // wait for clock lock
      .sx,
      .sy,
      .hsync,
      .vsync,
      .de
  );

  wire [3:0] column_from_left;
  wire [3:0] line_from_top;
  localparam MAX_COLUMN = 10;
  localparam MAX_LINE = 3;
  assign column_from_left = sx[9:6]; // 64 bit per column, 640 / 64 = 10 columns (MAX column) 4'b1010
  assign line_from_top = sy[9:7];  // 480 / 128 = 3 lines (MAX line) 4'b0011

  wire [7:0] ascii;
  // wire []
  wire [6:0] column_location;
  assign column_location = column_from_left << 3;
  assign ascii = (line_from_top == 0) ? line_0_ascii[79-column_location -: 8] :
               (line_from_top == 1) ? line_1_ascii[79-column_location -: 8] :
               (line_from_top == 2) ? line_2_ascii[79-column_location -: 8] :
              8'b0;

  wire [7:0] ascii_rom_line;

  wire [2:0] ascii_column;
  wire [3:0] ascii_line;
  assign ascii_column = sx[5:3]; // 放大8倍，默认状???下??1倍状态下），??个字符横向占8个像??
  assign ascii_line = sy[6:3]; // 放大8倍，默认状???下??1倍状态下），??个字符纵向占16个像??

  ascii_rom_async ascii_rom_inst (
      .addr({ascii[6:0], ascii_line}),
      .data(ascii_rom_line)
  );

  wire draw_ascii;
  assign draw_ascii = ascii_rom_line[7-ascii_column];

  // paint colour: yellow lines, blue background
  logic [3:0] paint_r, paint_g, paint_b;
  always_comb begin
    paint_r = (draw_ascii) ? 4'hF : 4'h1;
    paint_g = (draw_ascii) ? 4'hC : 4'h3;
    paint_b = (draw_ascii) ? 4'h0 : 4'h7;
  end

  // display colour: paint colour but black in blanking interval
  logic [3:0] display_r, display_g, display_b;
  always_comb begin
    display_r = (de) ? paint_r : 4'h0;
    display_g = (de) ? paint_g : 4'h0;
    display_b = (de) ? paint_b : 4'h0;
  end

  reg vga_hsync, vga_vsync;
  reg [3:0] vga_r, vga_g, vga_b;
  // VGA Pmod output
  always_ff @(posedge clk) begin
    vga_hsync <= hsync;
    vga_vsync <= vsync;
    vga_r <= display_r;
    vga_g <= display_g;
    vga_b <= display_b;
  end

  assign video_clk   = clk;
  assign video_hsync = hsync;
  assign video_vsync = vsync;
  assign video_red   = display_r[3:1];
  assign video_green = display_g[3:1];
  assign video_blue  = display_b[3:2];
  assign video_de    = de;

endmodule


module simple_480p (
    input  wire logic clk_pix,  // pixel clock
    input  wire logic rst_pix,  // reset in pixel clock domain   
    output      logic [9:0] sx, // horizontal screen position
    output      logic [9:0] sy, // vertical screen position
    output      logic hsync,    // horizontal sync
    output      logic vsync,    // vertical sync
    output      logic de        // data enable (low in blanking interval)
);
    // horizontal timings
    parameter HA_END = 639;          // end of active pixels
    parameter HS_STA = HA_END + 16; // sync starts after front porch 655
    parameter HS_END = HS_STA + 96; // SYNC ENDS 
    parameter LINE   = 799;         // last pixel on line (after back porch)

    // vertical timings
    parameter VA_END = 479;         // end of active pixels
    parameter VS_STA = VA_END + 10; // sync starts after front porch
    parameter VS_END = VS_STA + 2;  // sync ends
    parameter SCREEN = 524;         // last line on screen (after back porch)

    always_comb begin
        hsync = ~(sx >= HS_STA && sx < HS_END); // invert: negative polarity
        vsync = ~(sy >= VS_STA && sy < VS_END); // invert: negative polarity
        de = (sx <= HA_END && sy <= VA_END);
    end

    // CALCULATE HORIZONTAL AND VERTICAL SCREEN POSTITION
    always_ff @(posedge clk_pix) begin
        if (sx == LINE) begin // last pixel on line ?
            sx <= 0;
            sy <= (sy == SCREEN) ? 0 : sy + 1; // last line on screen ?
        end else begin
            sx <= sx + 1;
        end

        if (rst_pix) begin
            sx <= 0;
            sy <= 0;
        end
    end

endmodule