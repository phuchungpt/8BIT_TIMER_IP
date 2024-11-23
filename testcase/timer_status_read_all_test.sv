class timer_status_read_all_test extends base_test;
  
  function new(); 
    super.new();
  endfunction
  
  virtual task run_scenario();
    bit error = 0; 
    packet pkt = new(); 
    wait(dut_vif.presetn == 1);
    
    // count up
    // set timer count up 
    write(8'h00, 8'h01);
    
    // wait overflow data 
    repeat (261) begin
      @(posedge dut_vif.ker_clk);
    end
    
    // read all reg
    read (8'h00, 8'h01, pkt.data); 
    read (8'h01, 8'h01, pkt.data); 
    read (8'h02, 8'h00, pkt.data); 
    read (8'h02, 8'h00, pkt.data);
    
    // Count down
    // Set timer count down
    write(8'h00, 8'h00);
    write(8'h00, 8'h02);
    write(8'h00, 8'h03);
    
    // wait overflow data
    repeat (261) begin
      @(posedge dut_vif.ker_clk);
    end
    
    // read all reg 
    read (8'h00, 8'h03, pkt.data); 
    read (8'h01, 8'h03, pkt.data); 
    read (8'h02, 8'h00, pkt.data); 
    read (8'h03, 8'h00, pkt.data);
  endtask 
endclass
