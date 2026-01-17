module vending_machine (
    input  logic clk,
    input  logic rst_n,    // Active low reset
    input  logic nickel,   // 5 cents
    input  logic dime,     // 10 cents
    output logic dispense, // Merchandise out
    output logic change    // 5 cent nickel change
);

    // TODO: Implement the vending machine logic here
    //Let total amount equal 30. If more than 30, give change

    logic [5:0] total, next_total; //6 bit = 63 in case total more than 31 5 bit

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            total <=0;
            dispense <= 0;
            change <= 0;
        end
        else begin
        // After total is completed, set new set
            dispense <= 0;
            change <= 0;

            // Increment when coins inserted
            next_total = total;
            if (nickel)
                next_total = next_total + 5;
            if (dime)
                next_total = next_total + 10;

            if (next_total == 30) begin
                dispense <= 1;
                change   <= 0;
                total    <= 0;   // reset after vending
            end
            else if (next_total > 30) begin
                dispense <= 1;
                change   <= 1;   // give change
                total    <= 0;   // reset after vending
            end
            else begin
                total <= next_total; // accumulate for next cycle
            end
        end
    end
        

endmodule