module and_df #(parameter D = 1) (
  input  a,
  input  b,
  output y
);
  assign #D y = a & b;
endmodule