class clock_no_divide_test extends base_test;
  int total_cycle = 0;
  
  function new();
    super.new(); 
  endfunction

  virtual task run_scenario(); 
    packet pkt = new(); 
    wait(dut_vif.presetn == 1);
    // Count up
    
    // Assert overflow_en 
    write(8'h03, 8'h01);
    
    // Set counter up
    write(8'h00, 8'h01);

    while(dut_vif.interrupt == 0) begin
      @(posedge dut_vif.ker_clk);
      total_cycle++;
    end
    
    $display("%0t: [clock_no_divide_test] Interrupt is asserted after %0d clock cyclces", $time, total_cycle); 
    
    if(total_cycle >= 260 && total_cycle <= 270) begin
      $display("%0t: [clock_no_divide_test] PASS: 260 <= exp_cycle <= 270, act_cycle = %0d", $time, total_cycle);
    end
    else begin
      $display("%0t: [clock_no_divide_test] FAIL: 260 <= exp_cycle <= 270, act_cycle = %0d", $time, total_cycle);
      err_cnt++;
    end
    
    // Count down
    total_cycle = 0;
    
    // Read to make sure overflow signal asserted
    read (8'h01, 8'h01, pkt.data);
    
    // Write 1 to clear TSR
    write(8'h01, 8'h01);
    
    // Read back
    read (8'h01, 8'h00, pkt.data);
    
    if(dut_vif.interrupt != 0) begin
      $display("%0t: [clock_no_divide_test] Interrupt is not negated, exp = 0, act = %b", $time, dut_vif.interrupt);
      err_cnt++;
    end
    else begin
      $display("%0t: [clock_no_divide_test] Interrupt is negated, exp = 0, act = %b", $time, dut_vif.interrupt);
    end
    
    // Assert underflow_en 
    write(8'h03, 8'h02);
    
    // Set count down
    write(8'h00, 8'h02);
    write(8'h00, 8'h03);
    
    while(dut_vif.interrupt == 0) begin
      @(posedge dut_vif.ker_clk);
      total_cycle++;
    end
    
    $display("%0t: [clock_no_divide_test] Interrupt is asserted after 0d clock cyclces", $time, total_cycle);
    
    if(total_cycle >= 60 && total_cycle <= 70) begin
      $display("%0t: [clock_no_divide_test] PASS: 60 <= exp_cycle <= 70, act_cycle = %0d", $time, total_cycle);
    end
    else begin
      $display("%0t: [clock_no_divide_test] FAIL: 60 <= exp_cycle <= 70, act_cycle = %0d", $time, total_cycle); 
      err_cnt++;
    end
  endtask
endclass
