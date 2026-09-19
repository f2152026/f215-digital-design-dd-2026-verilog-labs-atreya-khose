// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs

  localparam WIDTH = 8;
  localparam DEPTH = 8;

  reg  [$clog2(DEPTH)-1:0] t_sel;
  wire [WIDTH-1:0]         t_dout;

  reg  [WIDTH-1:0] exp_dout;
  integer i;
  integer errors;

  // TODO: instantiate DUT here
  lut #(.WIDTH(WIDTH), .DEPTH(DEPTH)) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    errors = 0;

    for (i = 0; i < DEPTH; i = i + 1) begin
      t_sel    = i;
      exp_dout = i * i;
      #5;
      if (t_dout !== exp_dout) begin
        $display("FAIL at time %0t: sel=%0d got dout=%0d expected %0d",
                 $time, t_sel, t_dout, exp_dout);
        errors = errors + 1;
      end
    end

    if (errors == 0) $display("ALL %0d ADDRESSES PASSED", DEPTH);
    else             $display("%0d of %0d ADDRESSES FAILED", errors, DEPTH);

    $finish;

  end

  initial
    $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout); // change as required

endmodule
