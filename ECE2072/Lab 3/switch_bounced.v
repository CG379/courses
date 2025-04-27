module switch_bounced (SW, LEDR);
    input [0:0] SW;
    output [8:0] LEDR;
    
    reg [8:0] state;
    
    always @(posedge SW[0]) begin
   	 state = state + 1;
    end
    
    assign LEDR = state;
    
endmodule
