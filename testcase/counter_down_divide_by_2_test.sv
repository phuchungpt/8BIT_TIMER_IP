class counter_down_divide_by_2_test extends base_test;
  
  bit[7:0] data;
  bit[7:0] my_queue[$];
  int total_cycle = 0;
  int data_max, data_min;
  
  function new(); 
    super.new();
  end function
    
  virtual task run_scenario(); 
    packet pkt = new(); 
    wait(dut_vif.presetn == 1);
    
    // Assert overflow_en 
    write(8'h03, 8'h02);
    
    read (8'h03, 8'h02, pkt.data);
    
    // Write random init data to TDR data = $urandom;
    write(8'h02, data);
    
    // Load data into counter
    write(8'h00, 8'h04);
    
    // Set count down
    write(8'h00, 8'h0A);
    write(8'h00, 8'h0B);
    
    while(dut_vif.interrupt == 0) begin
      @(posedge dut_vif.ker_clk);
      total_cycle++;
    end
    
    $display("%0t: [counter_down_divide_by_2_test] Interrupt is asserted after %0d clock cyclces", $time, total_cycle);
    data_min = (int' (data) - 20)*2;
    data_max = (int' (data) + 20)*2;
    
    if(total_cycle >= data_min && total_cycle <= data_max) begin
      $display("%0t: [counter_down_divide_by_2_test] PASS: %0 <= exp_cycle <= %0d, act_cycle = %0d", $time, data_min, data_max, total_cycle);
    end
    else begin
      $display("%0t: [counter_down_divide_by_2_test] FAIL: %0d <= exp_cycle <= %0d, act_cycle = %0d", $time, data_min, data_max, total_cycle ); err_cnt++;
    end
    
    total_cycle = 0;
    
    // Write 1 to clear TSR
    write(8'h01, 8'h02);
    
    // Read back
    read (8'h01, 8'h00, pkt.data);
    
    // Write random data to TDR
    data = $urandom;
    write(8'h02, data);
    
    // Stop counter and load data to TDR
    write(8'h00, 8'h00);
    write (8'h00, 8'h04);
    
    // Set count dowm write(8'h00, 8'h0A);
    write(8'h00, 8'h0B);
    
    while(dut_vif.interrupt == 0) begin
      @(posedge dut_vif.ker_clk); total_cycle++;
    end
    
    $display("%0t: [counter_down_divide_by_2_test] Interrupt is asserted after %0d clock cyclces", $time, total_cycle);

    data_min = (int' (data) - 20)*2;
    data_max = (int' (data) + 20)*2;
    
    if(total_cycle >= data_min && total_cycle <= data_max) begin
      $display("%0t: [counter_down_divide_by_2_test] PASS: %0 <= exp_cycle <= %0d, act_cycle = %0d", $time, data_min, data_max, total_cycle);
    end else begin
      $display("%0t: [counter_down_divide_by_2_test] FAIL: %0 <= exp_cycle <= %0d, act_cycle = %0d", $time, data_min, data_max, total_cycle );
      err_cnt++;
    end 
  endtask
endclass
