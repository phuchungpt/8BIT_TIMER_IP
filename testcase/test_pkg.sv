package test_pkg;
  
  import timer_pkg::*;
  
  `include "base_test.sv"
  `include "default_value_register_test.sv" 
  `include "read_write_value_test.sv"
  `include "timer_status_count_up_test.sv" 
  `include "timer status count down test.sv" 
  `include "reset_value_register_test.sv"
  `include "reset_timer_status_count_up_test.sv"
  `include "reset_timer_status_count_down_test.sv"
  `include "write_one_read_all_test.sv" 
  `include "timer_status_read_all_test.sv" 
  `include "clock_no_divide_test.sv" 
  `include "clock_divide_by_2_test.sv" 
  `include "clock_divide_by_4_test.sv" 
  `include "clock_divide_by_8_test.sv" 
  `include "counter_up_interrupt_test.sv" 
  `include "counter_up_no_interrupt_test.sv" 
  `include "counter_down_interrupt_test.sv" 
  `include "counter_down_no_interrupt_test.sv" 
  `include "counter_up_no_divide_test.sv" 
  `include "counter_up_divide_by_2_test.sv" 
  `include "counter_up_divide_by_4_test.sv" 
  `include "counter_up_divide_by_8_test.sv" 
  `include "counter_down_no_divide_test.sv" 
  `include "counter_down_divide_by_2_test.sv" 
  `include "counter_down_divide_by_4_test.sv" 
  `include "counter_down_divide_by_8_test.sv"
  
endpackage
