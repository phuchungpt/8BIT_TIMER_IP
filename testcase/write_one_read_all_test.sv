class write_one_read_all_test extends base_test;
  bit [7:0] rand_data;
  bit [7:0] exp_data;
  bit [7:0] datal;
  bit [7:0] data2;
  
// Mask
  bit [7:0] mask_rego = 8'h1F;
  bit [7:0] mask_reg2 = 8'hFF;
  bit [7:0] mask_reg3 = 8'h03;
  
  function new(); 
    super.new(); 
  endfunction
  
  virtual task run_scenario(); 
    packet pkt = new(); 
    bit error = 0;
    wait(dut_vif.presetn == 1);
    
    // TCR register
    rand_data = $urandom;
    write(8'h00, rand_data);
    exp_data = rand_data & mask_reg0; 
    datal = exp_data;
    
    read (8'h00, exp_data, pkt.data); 
    read (8'h02, 8'h00, pkt.data); 
    read (8'h02, 8'h00, pkt.data);
    
    // TDR register
    rand_data = $urandom;
    write(8'h02, rand_data);
    exp_data = rand_data & mask_reg2;
    data2 = exp_data;
    
    read (8'h00, datal, pkt.data); 
    read (8'h02, exp_data, pkt.data); 
    read (8'h03, 8'h00, pkt.data);
    
    // TIE register
    rand_data = $urandom;
    write(8'h03, rand data);
    exp_data = rand_data & mask_reg3;

    read (8'h00, datal, pkt.data); 
    read (8'h02, data2, pkt.data); 
    read (8'h03, exp_data, pkt.data);
  endtask
endclass
