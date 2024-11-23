class stimulus;
  mailbox #(packet) s2d_mb;
  mailbox #(packet) s2s_mb;
  packet pkt_q[$];
  
  function new(mailbox #(packet) s2d_mb, mailbox #(packet) s2s_mb);
    this.s2d_mb = s2d_mb;
    this.s2s_mb = s2s_mb;
  endfunction
  
  task send_pkt(packet pkt); 
    pkt_q.push_back(pkt);  
  endtask
  
  task run();
    packet pkt_s2d;
    packet pkt_s2s;
    while(1) begin
      wait(pkt_q.size>0);
      pkt_s2d = pkt_q.pop_front();
      pkt_s2s = pkt_s2d;
      s2d_mb.put(pkt_s2d);
      $display("%0t: [stimulus] Sent packet to driver", $time);
      s2s_mb.put(pkt_s2s);
      $display("%0t: [stimulus] Sent packet to scoreboard", $time);
    end
  endtask
endclass
