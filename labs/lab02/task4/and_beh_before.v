module and_beh_before #(parameter D = 1) (
  input      a,
  input      b,
  output reg y
);
  always @(*) begin
    #D y = a & b;
  end
endmodule