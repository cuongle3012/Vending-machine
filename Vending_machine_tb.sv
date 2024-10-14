
`define clk_p 10

module Vending_machine_tb ();

  logic clk;
  logic nickle;
  logic dime;
  logic quarter;
  logic soda;
  logic [2:0] change;

  // Instantiate the vending machine
  Vending_machine M0 (
      .nickle(nickle),
      .dime(dime),
      .quarter(quarter),
      .clk(clk),
      .soda(soda),
      .change(change)
  );

  // Clock generation
  always #(`clk_p / 2) clk = ~clk;

  initial begin
    // Initialize inputs
    nickle = 0;
    dime = 0;
    quarter = 0;
    clk <= 0;

    // Test Case 1: Insert 1 dime, 1 nickle and 1 quarter
    #5;
    dime = 1'b1;  // Insert dime (10 cents)
    #(`clk_p);
    dime   = 1'b0;

    nickle = 1'b1;  // Insert nickle (5 cents)
    #(`clk_p);
    nickle  = 1'b0;

    quarter = 1'b1;  // Insert quarter (25 cents)
    #(`clk_p);
    quarter = 1'b0;

    #(`clk_p);
    if (soda == 1 && change == 3'b100) $display("Test Case 1 Passed");
    else $display("Test Case 1 Failed");

    // Test Case 2: Insert 1 nickle and 1 quarter

    nickle = 1'b1;  // Insert nickle (5 cents)
    #(`clk_p);
    nickle  = 1'b0;

    quarter = 1'b1;  // Insert quarter (25 cents)
    #(`clk_p);
    quarter = 1'b0;

    #(`clk_p);
    if (soda == 1 && change == 3'b010) $display("Test Case 2 Passed");
    else $display("Test Case 2 Failed");

    // Test Case 3: Insert 1 dime and 1 quarter
    dime = 1'b1;  // Insert dime (10 cents)
    #(`clk_p)
    dime = 1'b0;

    quarter = 1'b1;  // Insert quarter (25 cents)
    #(`clk_p);
    quarter = 1'b0;

    #(`clk_p);
    if (soda == 1 && change == 3'b011) $display("Test Case 3 Passed");
    else $display("Test Case 3 Failed");

    // Test Case 4: Insert 2 dime
    dime = 1'b1;  // Insert dime (10 cents)
    #(`clk_p);
    dime = 1'b0;

    dime = 1'b1;  // Insert dime (10 cents)
    #(`clk_p);
    dime = 1'b0;

    #(`clk_p);
    if (soda == 1 && change == 3'b000) $display("Test Case 4 Passed");
    else $display("Test Case 4 Failed");

    // Finish simulation
    $finish;
  end
endmodule
