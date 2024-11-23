class default_value_register_test extends base_test;
  function new(); 
    super.new();
  end function
    
  virtual task run_scenario(); 
    packet pkt = new(); 
    wait(dut_vif.presetn == 1);
    
    read (8'h00, 8'h00, pkt.data); // TCR register
    
    read (8'h01, 8'h00, pkt.data); // TSR register
    
    read (8'h02, 8'h00, pkt.data); // TDR register 
    
    read (8'h03, 8'h00, pkt.data); // TIE register
  endtask
endclass
