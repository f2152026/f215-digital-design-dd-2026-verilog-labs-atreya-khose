module and_beh_intra #(parameter D = 1) (
  input      a,
  input      b,
  output reg y
);
  always @(*) begin
    y = #D a & b;
  end
endmodule