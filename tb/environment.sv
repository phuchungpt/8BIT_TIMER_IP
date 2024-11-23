class environment;  

  stimulus   stim; 
  driver     drv ;
  monitor    mon ;
  scoreboard sb  ;

  mailbox #(packet) s2d_mb; 
  mailbox #(packet) m2s_mb; 
  mailbox #(packet) s2s_mb;

  virtual dut if dut_vif;

  function new(virtual dut if dut_vif);
    this.dut_vif = dut_vif;
  endfunction

  function void build();
    $display("%0t: [environment] build", $time);
    s2d_mb = new();
    m2s_mb = new();
    s2s_mb = new();
    stim = new(s2d_mb, s2s_mb); 
    drv = new(dut_vif, s2d_mb); 
    mon = new(dut_vif, m2s mb); 
    sb = new(m2s_mb, s2s_mb);
  endfunction

  task run();
    fork
      stim.run();
      drv.run();
      mon.run();
      sb.run();
    join
  endtask
endclass
