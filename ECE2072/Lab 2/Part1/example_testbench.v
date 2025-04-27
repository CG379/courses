`timescale 1ns / 1ps
module example_testbench;
	reg [5:0] inputs;
    wire out1, out2, out3;
  
    comparison_module test1 (inputs[5:3], inputs[2:0], out1, out2, out3);
   
    initial begin
        inputs = 4'd0;
    end

    always begin
        #10
        inputs = inputs + 1;
    end

    integer count, errors;
    initial begin
        count = 0;
        errors = 0;
    end
    always begin
        #9
        if (count == 64) begin
            $display("Done with test.");
            $display("There were %0d errors.", errors);
            $stop;
        end
        if ((out1 != (inputs[5:3] == inputs[2:0])) || out2 != (inputs[5:3] > inputs[2:0]) || out3 != (inputs[5:3] < inputs[2:0])) begin
            $display("Error for input (%b, %b) at time %0d.", inputs[3:2], inputs[1:0], $time);
            errors = errors + 1;
        end
        #1
        count = count + 1;
    end
endmodule
