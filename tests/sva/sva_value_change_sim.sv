module top (
	input clk
);

reg [7:0] counter = 0;

reg a = 0;
reg b = 1;
reg c;

wire a_fell; assign a_fell = $fell(a, @(posedge clk));
wire a_rose; assign a_rose = $rose(a, @(posedge clk));
wire a_stable; assign a_stable = $stable(a, @(posedge clk));

wire b_fell; assign b_fell = $fell(b, @(posedge clk));
wire b_rose; assign b_rose = $rose(b, @(posedge clk));
wire b_stable; assign b_stable = $stable(b, @(posedge clk));

wire c_fell; assign c_fell = $fell(c, @(posedge clk));
wire c_rose; assign c_rose = $rose(c, @(posedge clk));
wire c_stable; assign c_stable = $stable(c, @(posedge clk));

always @(posedge clk) begin
	counter <= counter + 1;

	case (counter)
		0: begin
            assert property ( $fell(a) && !$rose(a) && !$stable(a));
            assert property (!$fell(b) &&  $rose(b) && !$stable(b));
            assert property (!$fell(c) && !$rose(c) &&  $stable(c));
            a <= 1; b <= 1; c <= 1;
        end
		1: begin a <= 0; b <= 1; c <= 'x; end
		2: begin
            assert property ( $fell(a) && !$rose(a) && !$stable(a));
            assert property (!$fell(b) && !$rose(b) &&  $stable(b));
            assert property (!$fell(c) && !$rose(c) && !$stable(c));
            a <= 0; b <= 0; c <= 0;
        end
		3: begin a <= 0; b <= 1; c <= 'x; end
		4: begin
            assert property (!$fell(a) && !$rose(a) &&  $stable(a));
            assert property (!$fell(b) &&  $rose(b) && !$stable(b));
            assert property (!$fell(c) && !$rose(c) && !$stable(c));
            a <= 'x; b <= 'x; c <= 'x;
        end
		5: begin a <= 0; b <= 1; c <= 'x; counter <= 0; end
	endcase;
end

endmodule
