class counter_down_interrupt_test extends base_test;
  
  function new(); 
    super.new();
  end function
    
  virtual task run_scenario();
    packet pkt = new();
    wait(dut_vif.presetn == 1);
    
    // Assert underflow_en 
    write(8'h03, 8'h02);
    
    // Read back
    read (8'h03, 8'h02, pkt.data);
    
    // Set count up
    write(8'h00, 8'h02);
    write(8'h00, 8'h03);
    
    repeat (260) begin
      @(posedge dut_vif.ker_clk);
    end
    
    // Read TSR
    read (8'h01, 8'h02, pkt.data);
    if(dut_vif.interrupt == 1) begin
      $display("%0t: [counter_up_interrupt_test] Interrupt is triggered !", $time);
    end
    else begin
      $display("%0t: [counter_up_interrupt_test] Interrupt is not triggered however underflow_en is asserted!", $time); 
      err_cnt++;
    end 
  endtask
endclass
