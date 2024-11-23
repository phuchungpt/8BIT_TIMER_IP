class read_write_value_test extends base_test;
  function new(); 
    super.new();
  end function
    
  virtual task run_scenario(); 
    packet pkt = new(); 
    wait(dut_vif.presetn == 1);
    write(8'h00, 8'h@A); // TCR register read (8'h00, 8'h0A, pkt.data);
    write(8'h02, 8'hFF); // TDR register read (8'h02, 8'hFF, pkt.data);
    write(8'h03, 8'h02); // TIE reigster read (8'h03, 8'h02, pkt.data);
  endtask
endclass
