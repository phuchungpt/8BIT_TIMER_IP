class reset_value_register_test extends base_test;
  bit[7:0] data;
  bit[7:0] my_queue[$];
  
  function new(); 
    super.new();
  end function
    
  virtual task run_scenario();
    bit error = 0; 
    packet pkt = new(); 
    wait(dut_vif.presetn == 1);
    
    // init value
    read (8'h00, 8'h00, pkt.data); 
    read (8'h02, 8'h00, pkt.data);
    read (8'h03, 8'h00, pkt.data);
    
    // Write random value to each register 
    data = $urandom;
    my_queue.push_back(data);
    write(8'h00, data); // TCR register
    
    data = $urandom; 
    my_queue.push_back(data);
    write(8'h02, data); // TDR register
    
    data = $urandom; 
    my_queue.push_back(data);
    write(8'h03, data); // TIE register
    
    // Read to make sure all registers are updated
    data = my_queue.pop_front();
    read (8'h00, {3'b0, data[4:0]}, pkt.data); // TCR register
    data = my_queue.pop_front();
    read (8'h02, data, pkt.data); // TDR register
    data = my_queue.pop_front();
    read (8'h03, 6'b0, data[1:0]], pkt.data); // TIE reigster
    
    dut_vif.presetn = 0;
    $display("%0t: [Reset_value_register_test] Assert reset signal !", $time);
    
    read (8'h00, 8'h00, pkt.data);
    read (8'h02, 8'h00, pkt.data);
    read (8'h03, 8'h00, pkt.data); 
  endtask
endclass
