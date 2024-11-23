class clock_divide_by_2_test extends base_test;
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
    
// Set divide by 2 
    write(8'h00, 8'h08);
    
// Set counter up
  write(8'h00, 8'h09);
    
  while(dut_vif.interrupt == 0) begin
    @(posedge dut_vif.ker_clk);
    total_cycle++;
  end
    
  $display("%0t: [clock_divide_by_2_test] Interrupt is asserted after %0d clock cyclces", $time, total_cycle);
    
  if(total_cycle >= 510 && total_cycle <= 520) begin
    $display("%0t: [clock_divide_by_2_test] PASS: 510 <= exp_cycle <= 520, act_cycle = %0d", $time, total_cycle);
  end else begin
    $display("%0t: [clock_divide_by_2_test] FAIL: 510 <= exp_cycle <= 520, act_cycle = %0d", $time, total_cycle); err_cnt++;
  end
    
  // Count down
  total_cycle = 0;
  read (8'h01, 8'h01, pkt.data);
    
  // Write 1 to clear TSR
  write(8'h01, 8'h01);

  // read back  
  read(8'h01, 8'h00,pkt.data); 
  
  if(dut_vif.interrupt != 0) begin
    $display("%0t: [clock_divide_by_2_test] Interrupt is not negated, exp = 0, act = %b", $time, dut_vif.interrupt);
    err_cnt++;
  end
  else begin
    $display("%0t: [clock_divide_by_2_test] Interrupt is negated, exp = 0, act = %b", $time, dut_vif.interrupt);
  end
    
  // Assert underflow_en write(8'h03, 8'h02);
  // Set count down
  write(8'h00, 8'h0A);
  write(8'h00, 8'h0B);
    
  while(dut_vif.interrupt == 0) begin
    total_cycle++;
    @(posedge dut_vif.ker_clk);
  end
    
  $display("%0t: [clock_divide_by_2_test] Interrupt is asserted after %0d clock cyclces", $time, total_cycle); 
    
  if(total_cycle >= 60 && total_cycle <= 70) begin
    $display("%0t: [clock_divide_by_2_test] PASS: 60 <= exp_cycle <= 70, act_cycle = %0d", $time, total_cycle);
  end
  else begin
    $display("%0t: [clock_divide_by_2_test] FAIL: 70 <= exp_cycle <= 70, act_cycle = %0d", $time, total_cycle);
    err_cnt++;
  end
endtask
endclass 
