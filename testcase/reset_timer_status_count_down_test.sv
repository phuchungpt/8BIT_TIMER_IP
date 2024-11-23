class reset_timer_status_count_down_test extends base_test;
  function new(); 
    super.new(); 
  endfunction
  
  virtual task run_scenario();
    bit error = 0; 
    packet pkt = new(); 
    wait(dut_vif.presetn == 1);
         
    // TSR init value
    read (8'h01, 8'h00, pkt.data);

    // Set timer count up 
    write(8'h00, 8'h02); 
    write(8'h00, 8'h03);
    
    // Wait overflow data
    repeat (261) begin
      @(posedge dut_vif.ker_clk);
    end
        
    // Read TSR to make sure overflow asserted
    read (8'h01, 8'h02, pkt.data);
      
    // Assert reset signal and read back
    dut_vif.presetn = 0;
    
    $display("%0t: [Reset_value_register_test] Assert reset signal !", $time);
    read (8'h01, 8'h00, pkt.data);
  endtask
endclass
