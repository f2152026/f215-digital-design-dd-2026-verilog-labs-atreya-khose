module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] exp_result;
  integer    ia, ib;
  integer    errors, total;

  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  task check;
    begin
      exp_result = t_op ? (t_a - t_b) : (t_a + t_b);
      total = total + 1;
      if (t_result !== exp_result) begin
        errors = errors + 1;
        if (errors <= 10)
          $display("FAIL at time %0t: op=%b a=%0d b=%0d  got %0d  expected %0d",
                   $time, t_op, t_a, t_b, t_result, exp_result);
      end
    end
  endtask

  initial begin
    errors = 0;
    total  = 0;
    t_a = 0; t_b = 0; t_op = 0;
    #5;

    for (ia = 0; ia < 16; ia = ia + 1) begin
      for (ib = 0; ib < 16; ib = ib + 1) begin
        t_a = ia;
        t_b = ib;
        #5;
        check;

        t_op = ~t_op;
        #5;
        check;
      end
    end

    $write("SUMMARY: %0d of %0d checks passed", total - errors, total);
    if (errors == 0) $write(" -- ALL PASSED");
    $write("\n");

    $finish;
  end

endmodule