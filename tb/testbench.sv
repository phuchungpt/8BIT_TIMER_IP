`timescale 1ns/1ps
module testbench;
  
import timer_pkg::*; 
import test_pkg::*;
  
dut_if d_if();
  
timer_top u_dut(
  .ker_clk(d_if.ker_clk),
  .pclk(d_if.pclk),
  .presetn(d_if.presetn), 
  .psel(d_if.psel),
  .penable(d_if.penable),
  .pwrite(d_if.pwrite),
  .paddr(d_if.paddr),
  .pwdata(d_if.pwdata),
  .prdata(d_if.prdata),
  .pready(d_if.pready),
  .interrupt(d_if.interrupt));
  
initial begin
  d_if.presetn = 0; 
  #100ns d_if.presetn = 1;
end
  
// 50 MHz 
initial begin
  d_if.pclk = 0;
  forever begin 
    #10ns;
    d_if.pclk = -d_if.pclk;
  end
end
  
// 200 MHz
initial begin
  d_if.ker_clk = 1;
  forever begin
    #2.5ns;
    d_if.ker_clk = ~d_if.ker_clk;
  end
end


initial begin
  d_if.psel = 0;
  d_if.pwrite = 0;
  d_if.paddr = 0;
  d_if.pwdata = 0;
  d_if.penable = 0;
end
  
initial begin
  #2ms;
  $display("[testbench] Time out.... Seems your tb is hang!");
  $finish;
end
  
base_test                           base = new();
default_value_register_test         test_01 = new();     
read_write_value_test               test_02 = new();
timer_status_count_up_test          test_03 = new();
timer_status_count_down_test        test_03 = new();
reset_value_register_test           test_03 = new();
reset_timer_status_count_up_test    test_03 = new();
write_one_read_all_test             test_03 = new();
reset_timer_status_count_down_test  test_03 = new();
timer_status_read_all_test          test_03 = new();
clock_no_divide_test                test_03 = new();
clock_divide_by_2_test              test_03 = new();
clock_divide_by_4_test              test_03 = new();
clock_divide_by_8_test              test_03 = new();
counter_up_interrupt_test           test_03 = new();
counter_up_no_interrupt_test        test_03 = new();
counter_down_interrupt_test         test_03 = new();
counter_down_no_interrupt_test      test_03 = new();
counter_up_no_divide_test           test_03 = new();
counter_up_divide_by_2_test         test_03 = new();
counter_up_divide_by_4_test         test_03 = new();
counter_up_divide_by_8_test         test_03 = new();
counter_down_no_divide_test         test_03 = new();
counter_down_divide_by_2_test       test_03 = new();
counter_down_divide_by_4_test       test_03 = new();
counter_down_divide_by_8_test       test_25 = new();
  
initial begin
if($test$plusargs("default_value_register_test")) begin
  $display("%0t: [testbench] Run default_value_register_test", $time); 
  base = test_01;
end
else if($test$plusargs("read_write_value_test")) begin
  $display("%0t: [testbench] Run read_write_value_test", $time);
  base = test_02;
end
else if($test$plusargs("timer_status_count_up_test")) begin 
  $display("%0t: [testbench] Run timer_status_count_up_test", $time); 
  base = test_03;
end
else if($test$plusargs("timer_status_count_down_test")) begin 
  $display("%0t: [testbench] Run timer_status_count_down_test", $time); 
  base = test_04;
end
else if($test$plusargs("reset_value_register_test")) begin 
  $display("%0t: [testbench] Run reset_value_register_test", $time); 
  base=test_05;
end
else if($test$plusargs("reset_timer_status_count_up_test")) begin
  $display("%0t: [testbench] Run reset_timer_status_count_up_test", $time); 
  base = test_06;
end
else if($test$plusargs("reset_timer_status_count_down_test")) begin 
  $display("%0t: [testbench] Run reset_timer_status_count_down_test", $time); 
  base=test_07;
end
else if($test$plusargs("write_one_read_all_test")) begin
  $display("%0t: [testbench] Run write_one_read_all_test", $time);
  base = test_08;
end
else if($test$plusargs("timer_status_read_all_test")) begin 
  $display("%0t: [testbench] Run timer_status_read_all_test", $time); 
  base test_09;
end
else if($test$plusargs("clock_no_divide_test")) begin
  $display("%0t: [testbench] Run clock_no_divide_test", $time);
  base = test_10;
end
else if($test$plusargs("clock_divide_by_2_test")) begin
  $display("%0t: [testbench] Run clock_divide_by_2_test", $time); 
  base = test_11;
end
else if($test$plusargs("clock_divide_by_4_test")) begin
  $display("%0t: [testbench] Run clock_divide_by_4_test", $time); 
  base = test_12;
end
else if($test$plusargs("clock_divide_by_8_test")) begin
  $display("%0t: [testbench] Run clock_divide_by_8_test", $time); 
  base = test_13;
end
else if($test$plusargs("counter_up_interrupt_test")) begin
  $display("%0t: [testbench] Run counter_up_interrupt_test", $time); 
  base = test_14;
end
else if($test$plusargs("counter_up_no_interrupt_test")) begin
  $display("%0t: [testbench] Run counter_up_no_interrupt_test", $time); 
  base = test_15;
end
else if($test$plusargs("counter_down_interrupt_test")) begin
  $display("%0t: [testbench] Run counter_down_interrupt_test", $time); 
  base = test_16;
end
else if($test$plusargs("counter_down_no_interrupt_test")) begin
  $display("%0t: [testbench] Run counter_down_no_interrupt_test", $time)
  base = test_17;
end
else if($test$plusargs("counter_up_no_divide_test")) begin
  $display("%0t: [testbench] Run counter_up_no_divide_test", $time);
  base = test_18;
end
else if($test$plusargs("counter_up_divide_by_2_test")) begin
  $display("%0t: [testbench] Run counter up divide by 2 test", $time);
  base = test_19;
end
else if($test$plusargs("counter_up_divide_by_4_test")) begin
  $display("%0t: [testbench] Run counter_up_divide_by_4_test", $time);
  base = test_20;
end
else if($test$plusargs("counter_up_divide_by_8_test")) begin
  $display("%0t: [testbench] Run counter_up_divide_by_8_test", $time);
  base = test_21;
end
else if($test$plusargs("counter_down_no_divide_test")) begin 
  $display("%0t: [testbench] Run counter_down_no_divide_test", $time); 
  base = test_22;
end
else if($test$plusargs("counter_down_divide_by_2_test")) begin 
  $display("%0t: [testbench] Run counter_down_divide_by_2_test", $time); 
  base = test_23;
end
else if($test$plusargs("counter_down_divide_by_4_test")) begin
  $display("%0t: [testbench] Run counter_down_divide_by_4_test", $time); 
  base = test_24;
end
else if($test$plusargs("counter_down_divide_by_8_test")) begin
  $display("%0t: [testbench] Run counter_down_divide_by_8_test", $time); 
  base = test_25;
end
base.dut_vif = d_if;
base.run_test();
end
endmodule



  
