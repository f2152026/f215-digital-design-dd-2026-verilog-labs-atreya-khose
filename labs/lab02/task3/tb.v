module tb;

  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;

  reg        exp_gt, exp_lt, exp_eq;
  integer    ia, ib;
  integer    errors;
  integer    total;

  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    total  = 0;

    for (ia = 0; ia < 4; ia = ia + 1) begin
      for (ib = 0; ib < 4; ib = ib + 1) begin
        t_a = ia;
        t_b = ib;

        exp_gt = 0; exp_lt = 0; exp_eq = 0;
        if      (ia > ib) exp_gt = 1;
        else if (ia < ib) exp_lt = 1;
        else              exp_eq = 1;

        #5;
        total = total + 1;

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    $write("SUMMARY: %0d of %0d combinations passed", total - errors, total);
    if (errors == 0) $write(" -- ALL PASSED");
    $write("\n");

    $finish;
  end

endmodule