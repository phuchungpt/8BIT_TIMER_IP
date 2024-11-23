class driver;
  mailbox #(packet) s2d_mb; virtual dut if dut_vif;
  event xfer_done;
  
  function new(virtual dut_if dut_vif, mailbox #(packet) s2d_mb);
    this.dut_vif = dut vif; this.s2d_mb = s2d_mb ;
  endfunction
  
  task run();
    packet pkt;
    while (1) begin
      s2d_mb.get(pkt);
      $display("%0t: [driver] Get packet from stimulus", $time);
      @(posedge dut_vif.pclk);
      dut_vif.psel = 1;
      dut_vif.pwrite = pkt.transfer; 
      dut_vif.paddr  = pkt.addr;
      dut_vif.pwdata = pkt.data;
      @(posedge dut_vif.pclk);
      dut_vif.penable = 1; 
      wait(dut_vif.pready);
      @(posedge dut_vif.pclk); 
      dut_vif.penable = 0; 
      dut_vif.psel 0;
      -> xfer_done;
    end
  endtask
endclass
