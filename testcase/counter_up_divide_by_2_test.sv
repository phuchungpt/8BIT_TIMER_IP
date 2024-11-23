class counter_up_divide_by_2_test extends base_test;
  bit[7:0] data;
  int total_cycle = 0;
  int data_max, data_min;
  
  function new(); 
    super.new();
  end function
    
  virtual task run_scenario();
    packet pkt = new(); 
    wait(dut_vif.presetn == 1);

    // Assert overflow_en 
    write(8'h03, 8'h01);
    
    //Write random init data to TDR
    data = $urandom;
    write(8'h02, data);
    
    // Load data into counter 
    write(8'h00, 8'h04);
    
    // Set count up
    write(8'h00, 8'h08);
    write(8'h00, 8'h09);
    
    while(dut_vif.interrupt == 0) begin
      @(posedge dut_vif.ker_clk);
      total_cycle++;
    end
    
    $display("%0t: [counter_up_divide_by_2_test] Interrupt is asserted after %0d clock cyclces", $time, total_cycle);
    data_min = (240 - (int'(data)))*2;
    data_max = (260 - (int' (data)))*2;
    
    if(total_cycle >= data_min && total_cycle <= data_max) begin
      $display("%0t: [counter_up_divide_by_2_test] PASS: %0d <= exp_cycle <= %0d, act_cycle = %0d", $time, data_min, data_max, total_cycle); 
    end 
    else begin
      $display("%0t: [counter_up_divide_by_2_test] FAIL: %0d <= exp_cycle <= %0d, act_cycle = %0d", $time, data_min, data_max, total_cycle ); 
      err_cnt++;
    end
  endtask
endclass
    
