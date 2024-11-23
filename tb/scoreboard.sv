class scoreboard;
mailbox #(packet) m2s_mb;
mailbox #(packet) s2s_mb; int err_cnt;
  
bit en_fc = 1;
  
'include "coverage.sv"
  
function new(mailbox #(packet) m2s_mb, mailbox #(packet) s2s_mb);
    this.m2s_mb = m2s_mb;
    this.s2s_mb = s2s_mb;
    this.err_cnt = 0    ;
    timer_pkt = new()   ;
    APB_GROUP = new()
end function
  
task run();
  packet pkt_s2s;
  packet pkt_m2s;
  while(1) begin
    s2s_mb.get(pkt_s2s);
    if(pkt_s2s.transfer == packet::WRITE) begin
      $display("%0t: [scoreboard] Get packet from stimulus: %s, addr = %h, data = %h", $time, pkt_s2s.transfer.name(), pkt_s2s.addr, pkt_s2s.data); 
    else begin
      $display("%0t: [scoreboard] Get packet from stimulus: %s, addr = %h, data = %h", $time, pkt_s2s.transfer.name(), pkt_s2s.addr, pkt_s2s.exp_data);
    end

    m2s_mb.get(pkt_m2s);
    $display("%0t: [scoreboard] Get packet from monitor: %s, addr = %h, data = %h", $time, pkt_m2s.transfer.name(), pkt_m2s.addr, pkt_m2s.data);
    if(en_fc) sample_timer_fc(pkt_m2s);
      
    if (pkt_s2s.transfer == packet::WRITE) begin 
      compare(pkt_s2s.data, pkt_m2s.data, err_cnt);
    end
    else begin
      compare(pkt_s2s.exp_data, pkt_m2s.data, err_cnt);
    end
  end
endtask
