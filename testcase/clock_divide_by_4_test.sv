class clock_divide_by_4_test extends base_test;
  int total_cycle = 0;

  function new();
    super.new(); 
  endfunction

  virtual task run_scenario(); 
    packet pkt = new(); 
    wait(dut_vif.presetn == 1);
    
    // Assert overflow_en 
    write(8'h03, 8'h01);
    
    // Set divide by 4 
    write(8'h00, 8'h10);
    
    // Set counter up
    write(8'h00, 8'h11);
    
    while(dut_vif.interrupt == 0) begin
      total_cycle++;
      @(posedge dut_vif.ker_clk);
    end
    
    $display("%0t: [clock_divide_by_4_test] Interrupt is asserted after 0d clock cyclces", $time, total_cycle);
    
    if(total_cycle >= 1020 && total_cycle <= 1030) begin
      $display("%0t: [clock_divide_by_4_test] PASS: 1020 <= exp_cycle <= 1030, act_cycle = %0d", $time, total_cycle);
    end
    else begin
      $display("%0t: [clock_divide_by_4_test] FAIL: 1020 <= exp_cycle <= 1030, act_cycle = %d", $time, total_cycle); 
      err_cnt++;
    end
    
    // Count down
    total_cycle = 0;
    
    // Read TSR
    read (8'h01, 8'h01, pkt.data);
    
    // Write 1 to clear TSR
    write(8'h01, 8'h01);
    
    // Read back to make sure cleared successfulliy
    read (8'h01, 8'h00, pkt.data);
    if(dut_vif.interrupt != 0) begin
      $display("%0t: [clock_divide_by_4_test] Interrupt is not negated, exp = 0, act = %b", $time, dut_vif.interrupt); 
      err_cnt++;
    end
    else begin
      $display("%0t: [clock_divide_by_4_test] Interrupt is negated, exp = 0, act = %b", $time, dut_vif.interrupt);
    end
    
    // Assert underflow_en 
    write(8'h03, 8'h02);
    
    // Set count down 
    write(8'h00, 8'h12);
    write(8'h00, 8'h13);
    
    if(dut_vif.interrupt == 1) begin
      while(dut_vif.interrupt == 0) begin
        @(posedge dut_vif.ker_clk);
        total_cycle++;
      end
    end
    else begin
      $display("%0t: [clock_divide_by_4_test] Interrupt is not negated! Can not estimate total cycle.", $time); err_cnt++;
    end
    
    $display("%0t: [clock_divide_by_4_test] Interrupt is asserted after %0d clock cyclces", $time, total_cycle); 
    
    if(total_cycle >= 60 && total_cycle <= 70) begin
      $display("%0t: [clock_divide_by_4_test] PASS: 60 <= exp_cycle <= 70, act_cycle = %0d", $time, total_cycle); 
    end else begin
      $display("%0t: [clock_divide_by_4_test] FAIL: 60 <= exp_cycle <= 70, act_cycle = %0d", $time, total_cycle); 
      err_cnt++;
    end
  endtask
endclass
