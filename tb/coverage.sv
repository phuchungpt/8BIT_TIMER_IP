packet timer_pkt;
covergroup APB_GROUP;
apb_transfer: coverpoint timer_pkt.transfer{
  bins apb_write = {packet::WRITE};
  bins apb_read  = {packet::READ} ;
}

apb_address: coverpoint timer_pkt.addr{
  bins TCR_addr = {8'h00};
  bins TSR_addr = {8'h01};
  bins TDR_addr = {8'h02};
  bins TIE_addr = {8'h03};
}
  
apb_timer_config: coverpoint timer_pkt.data{
  bins count_up_no_divide     = {8'h01};
  bins count_up_divide_by_2   = {8'h09};
  bins count_up_divide_by_4   = {8'h11};
  bins count_up_divide_by_8   = {8'h19};
  bins count down no divide   = {8'h03}; 
  bins count_down_divide_by_2 = {8'h0B}; 
  bins count_down_divide_by_4 = {8'h13}; 
  bins count_down_divide_by_8 = {8'h1B}; 
  bins load_data              = {8'h04};
}

apb_timer_status: coverpoint timer_pkt.data{ 
  bins underflow = {8'h02};
  bins overflow = {8'h01};
}
  
apb_timer_data: coverpoint timer_pkt.data{
  bins data = {[8'h01:8'hFF]};
}

apb_interrupt_en: coverpoint timer_pkt.data{
  bins overflow_en = {8'h01};
  bins underflow_en = {8'h02};
}

apb_transaction: cross apb_transfer, apb_address;
  
counter_up_no_divide_feature : cross apb_transfer, apb_address, apb_timer_config
{
  ignore_bins counter_up_no_divide = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h00} || !binsof (apb_timer_config) intersect {8'h01};
}
  
counter_up_divide_by_2_feature: cross apb_transfer, apb_address, apb_timer_config 
{
  ignore_bins counter_up_divide_by_2 = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h00} || !binsof (apb_timer_config) intersect {8'h09};
{
  
counter_up_divide_by_4_feature : cross apb_transfer, apb_address, apb_timer_config
{
  ignore_bins counter_up_divide_by_4 = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h00} || !binsof (apb_timer_config) intersect {8'h11};
}
  
counter_up_divide_by_8_feature: cross apb_transfer, apb_address, apb_timer_config
{
  ignore_bins counter_up_divide_by_8 = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h00} || !binsof (apb_timer_config) intersect {8'h19};
}

counter_down_no_divide_feature: cross apb_transfer, apb_address, apb_timer_config
{
  ignore_bins counter_down_no_divide = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h00} || !binsof (apb_timer_config) intersect {8'h03};
}

counter_down_divide_by_2_feature: cross apb_transfer, apb_address, apb_timer_config
{
  ignore_bins counter_down_divide_by_2 = !binsof(apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h00} || !binsof (apb_timer_config) intersect {8'h0B};
}

counter_down_divide_by_4_feature: cross apb_transfer, apb_address, apb_timer_config
{
  ignore_bins counter_down_divide_by_4 = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof(apb_address) intersect {8'h00} || !binsof(apb_timer_config) intersect {8'h13};
}

counter_down_divide_by_8_feature : cross apb_transfer, apb_address, apb_timer_config
{
  ignore_bins counter_down_divide_by_8 = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof(apb_address) intersect {8'h00} || !binsof(apb_timer_config) intersect {8'h1B};
}

counter_load_data_feature: cross apb_transfer, apb_address, apb_timer_config
{
  ignore_bins counter_load_data = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h00} || !binsof(apb_timer_config) intersect {8'h04};
}
  
clear_overflow_feature: cross apb_transfer, apb_address, apb_timer_status
{
  ignore_bins clear_overflow = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h01} || !binsof (apb_timer_status) intersect {8'h01};
}

clear_underflow_feature: cross apb_transfer, apb_address, apb_timer_status
{ 
  ignore_bins clear_underflow = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h01} || !binsof(apb_timer_status) intersect {8'h02};
}
  
set_timer_data_feature: cross apb_transfer, apb_address, apb_timer_data
{
  ignore_bins set_timer_data = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof(apb_address) intersect {8'h02} || !binsof (apb_timer_data) intersect {[8'h01:8'hFF]};
}
  
set_overflow_en_feature: cross apb_transfer, apb_address, apb_interrupt_en
{
  ignore_bins set_overflow_en = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h03} || !binsof (apb_interrupt_en) intersect {8'h01};
}

set_underflow_en_feature: cross apb_transfer, apb_address, apb_interrupt_en
ignore_bins set_underflow_en = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h03} || !binsof (apb_interrupt_en) intersect {8'h02};
{
  ignore_bins set_underflow_en = !binsof (apb_transfer) intersect {packet::WRITE} || !binsof (apb_address) intersect {8'h03} || !binsof (apb_interrupt_en) intersect {8'h02};
}
  
endgroup
