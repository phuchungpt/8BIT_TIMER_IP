class base_test;
  environment env;
  
  virtual dut_if dut_vif; 
  int err_cnt;

  function new(); 
    err_cnt = 0; 
  end function
    
  function void build();
    env = new(dut_vif); env.build();
  end function
    
  task write(bit[7:0] addr, bit[7:0] data);
    packet pkt = new();
    pkt.addr = addr;
    pkt.data = data;
    pkt.transfer = packet::WRITE;
    env.stim.send_pkt(pkt);
    @(env.drv.xfer_done);
  endtask
    
  task read(bit[7:0] addr, bit[7:0] exp_data, ref bit[7:0] data);
    packet pkt = new();
    pkt.addr = addr;
    pkt.transfer = packet::READ;
    pkt.exp_data = exp_data;
    env.stim.send_pkt(pkt);
    @(env.drv.xfer_done);
    data = pkt.data;
  endtask
    
  virtual task run_scenario(); 
  endtask
  
  task run_test();
    build();
    fork
      env.run();
      run_scenario();
    join_any
    #lus;
    env.sb.report(err_cnt);
    $display("%0t: [base test] End simulation", $time);
    $finish;
  endtask
endclass


    
