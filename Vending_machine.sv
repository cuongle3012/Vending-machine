module Vending_machine (
    input clk,
    input nickle,  // 5
    input dime,  // 10
    input quarter,  // 25
    output logic soda,
    output logic [2:0] change  // change should be 3 bits
);
  typedef enum logic [3:0] {
    S0,
    S1,
    S2,
    S3,
    S4,
    S5,
    S6,
    S7,
    S8
  } state;

  state PS, NS;

  always_ff @(posedge clk) begin
    PS <= NS;
  end

  always_comb begin
    case (PS)
      S0: begin
        if (nickle) NS = S1;
        else if (dime) NS = S2;
        else if (quarter) NS = S5;
        else NS = S0;
      end
      S1: begin
        if (nickle) NS = S2;
        else if (dime) NS = S3;
        else if (quarter) NS = S6;
        else NS = S1;
      end
      S2: begin
        if (nickle) NS = S3;
        else if (dime) NS = S4;  // Correct path for dime
        else if (quarter) NS = S7;
        else NS = S2;
      end
      S3: begin
        if (nickle) NS = S4;
        else if (dime) NS = S5;  // Correct path for dime leading to soda
        else if (quarter) NS = S8;  // Move to S8 for soda with quarter
        else NS = S3;
      end
      S4: begin
        if (nickle) NS = S1;  // Return to S1 for another nickle
        else if (dime) NS = S2;  // Return to S2 for dime
        else if (quarter) NS = S5;  // Move to S5
        else NS = S0;  // Reset if no coins
      end
      S5: begin
        if (nickle) NS = S1;
        else if (dime) NS = S2;
        else if (quarter) NS = S5;
        else NS = S0;
      end
      S6: begin
        if (nickle) NS = S1;
        else if (dime) NS = S2;
        else if (quarter) NS = S5;
        else NS = S0;
      end
      S7: begin
        if (nickle) NS = S1;
        else if (dime) NS = S2;
        else if (quarter) NS = S5;
        else NS = S0;
      end
      S8: begin
        if (nickle) NS = S1;
        else if (dime) NS = S2;
        else if (quarter) NS = S5;
        else NS = S0;
      end
      default: NS = S0;  // Default to reset state
    endcase
  end

  always_comb begin
    case (PS)
      S0, S1, S2, S3: begin
        soda   = 1'b0;
        change = 3'b000;
      end
      S4: begin
        soda   = 1'b1;
        change = 3'b000;
      end
      S5: begin
        soda   = 1'b1;
        change = 3'b001;
      end
      S6: begin
        soda   = 1'b1;
        change = 3'b010;
      end
      S7: begin
        soda   = 1'b1;
        change = 3'b011;
      end
      S8: begin
        soda   = 1'b1;
        change = 3'b100;
      end
      default: begin
        soda   = 1'b0;
        change = 3'b000;
      end
    endcase
  end
endmodule
