class timer_status_count_down_test extends base_test;
  
  function new(); 
    super.new(); 
  endfunction
  
  virtual task run_scenario();
    packet pkt = new();
    wait(dut_vif.presetn == 1);
    
    // Write 1 to make sure only hardware can set 
    write(8'h01, 8'h03);
    read (8'h01, 8'h00, pkt.data);
    
    // Set timer count down 
    write(8'h00, 8'h02); 
    write(8'h00, 8'h03);
    
    // Wait underflow data
    repeat (261) begin
      @(posedge dut_vif.ker_clk);
    end
    
    // Read data from TSR to make sure underflow is asserted 
    read (8'h01, 8'h02, pkt.data);
    
    // Write 0 to make sure no affect
    write(8'h01, 8'h00);
    read (8'h01, 8'h02, pkt.data);
    
    // Write 1 to clear underflow
    write(8'h01, 8'h02);
    
    // Read to make sure clear successfully 
    read (8'h01, 8'h00, pkt.data);
  endtask
endclass
