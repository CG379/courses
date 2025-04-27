module light_verilog (x1, x2, f);

       // Define inputs and outputs
       input x1, x2;
       output  f;

       // Implement the circuit
       assign f = (x1 & ~x2) | (~x1 & x2); 

endmodule
