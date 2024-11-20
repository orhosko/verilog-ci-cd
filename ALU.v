`timescale 1ns / 1ps

module ArithmeticLogicUnit (
    A,
    B,
    FunSel,
    ALUOut,
    WF,
    FlagsOut,
    Clock
);

  input wire [15:0] A;
  input wire [15:0] B;
  input wire [4:0] FunSel;
  input wire WF;
  input wire Clock;

  output reg [15:0] ALUOut;
  output reg [3:0] FlagsOut;

  always @(*) begin

    ALUOut = 16'b0;

    case (FunSel)
      5'b00000: ALUOut <= A[7:0];
      5'b00001: ALUOut <= B[7:0];
      5'b00010: ALUOut <= ~A[7:0];
      5'b00011: ALUOut <= ~B[7:0];
      5'b00100: begin

        ALUOut <= A[7:0] + B[7:0];

        if (WF) begin
          if (A[7] == B[7] && ALUOut[7] != A[7]) begin
            FlagsOut[0] <= 1;
          end else begin
            FlagsOut[0] <= 0;
          end


        end

      end
      5'b00101: begin

        ALUOut <= A[7:0] + B[7:0] + FlagsOut[2];

        if (WF) begin
          if (A[7] == B[7] && ALUOut[7] != A[7]) begin
            FlagsOut[0] <= 1;
          end else begin
            FlagsOut[0] <= 0;
          end
        end

      end
      5'b00110: begin
        ALUOut <= A[7:0] - B[7:0];

        if (WF) begin
          if (A[7] != B[7] && ALUOut[7] != A[7]) begin
            FlagsOut[0] <= 1;
          end else begin
            FlagsOut[0] <= 0;
          end


        end

      end
      5'b00111: ALUOut <= A[7:0] & B[7:0];
      5'b01000: ALUOut <= A[7:0] | B[7:0];
      5'b01001: ALUOut <= A[7:0] ^ B[7:0];
      5'b01010: ALUOut <= ~(A[7:0] & B[7:0]);
      5'b01011: begin


        if (WF) begin
          FlagsOut[2] <= A[7];
        end

        ALUOut <= A[7:0] << 1;  // LSL

      end
      5'b01100: begin

        if (WF) begin
          FlagsOut[2] <= A[0];
        end

        ALUOut <= A[7:0] >> 1;  // LSR

      end
      5'b01101: ALUOut <= A[7:0] >>> 1;  // ASR
      5'b01110: begin

        if (WF) begin
          FlagsOut[2] <= A[7];
        end

        ALUOut <= A[7:0] << 1 | A[7];  // CSL

      end
      5'b01111: begin

        if (WF) begin
          FlagsOut[2] <= A[0];
        end

        ALUOut <= A[7:0] >> 1 | A[0];  // CSR

      end

      5'b10000: ALUOut <= A[15:0];
      5'b10001: ALUOut <= B[15:0];
      5'b10010: ALUOut <= ~A[15:0];
      5'b10011: ALUOut <= ~B[15:0];
      5'b10100: begin
        ALUOut <= A[15:0] + B[15:0];

        if (WF) begin
          if (A[15] == B[15] && ALUOut[15] != A[15]) begin
            FlagsOut[0] <= 1;
          end else begin
            FlagsOut[0] <= 0;
          end
        end

      end
      5'b10101: begin

        ALUOut <= A[15:0] + B[15:0] + FlagsOut[2];

        if (WF) begin
          if (A[15] == B[15] && ALUOut[15] != A[15]) begin
            FlagsOut[0] <= 1;
          end else begin
            FlagsOut[0] <= 0;
          end
        end

      end

      5'b10110: begin

        // p - n p -
        // n - p n -
        // p - n n of
        // n - p p of

        ALUOut <= A[15:0] - B[15:0];

        if (WF) begin
          if (A[15] != B[15] && ALUOut[15] != A[15]) begin
            FlagsOut[0] <= 1;
          end else begin
            FlagsOut[0] <= 0;
          end
        end

      end
      5'b10111: ALUOut <= A[15:0] & B[15:0];
      5'b11000: ALUOut <= A[15:0] | B[15:0];
      5'b11001: ALUOut <= A[15:0] ^ B[15:0];
      5'b11010: ALUOut <= ~(A[15:0] & B[15:0]);
      5'b11011: begin

        if (WF) begin
          FlagsOut[2] <= A[15];
        end

        ALUOut <= A[15:0] << 1;  // LSL

      end
      5'b11100: begin

        if (WF) begin
          FlagsOut[2] <= A[0];
        end

        ALUOut <= A[15:0] >> 1;  // LSR

      end
      5'b11101: ALUOut <= A[15:0] >>> 1;  // ASR
      5'b11110: begin

        if (WF) begin
          FlagsOut[2] <= A[15];
        end

        ALUOut <= A[15:0] << 1 | A[15];  // CSL

      end
      5'b11111: begin

        if (WF) begin
          FlagsOut[2] <= A[0];
        end

        ALUOut <= A[15:0] >> 1 | A[0];  // CSR
      end

    endcase

    if (WF) begin
      if (ALUOut == 0) begin
        FlagsOut[3] <= 1;
      end else begin
        FlagsOut[3] <= 0;
      end

      if (ALUOut[15] == 1) begin
        FlagsOut[1] <= 1;
      end else begin
        FlagsOut[1] <= 0;
      end

    end


  end


endmodule
