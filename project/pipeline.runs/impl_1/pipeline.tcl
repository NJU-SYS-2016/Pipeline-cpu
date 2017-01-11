proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir /home/tyh/Documents/pipeline/pipeline.cache/wt [current_project]
  set_property parent.project_path /home/tyh/Documents/pipeline/pipeline.xpr [current_project]
  set_property ip_repo_paths /home/tyh/Documents/pipeline/pipeline.cache/ip [current_project]
  set_property ip_output_repo /home/tyh/Documents/pipeline/pipeline.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet /home/tyh/Documents/pipeline/pipeline.runs/synth_1/pipeline.dcp
  add_files -quiet /home/tyh/Documents/pipeline/pipeline.srcs/sources_1/ip/mult_gen_0/mult_gen_0.dcp
  set_property netlist_only true [get_files /home/tyh/Documents/pipeline/pipeline.srcs/sources_1/ip/mult_gen_0/mult_gen_0.dcp]
  add_files -quiet /home/tyh/Documents/pipeline/pipeline.srcs/sources_1/ip/div_gen_0/div_gen_0.dcp
  set_property netlist_only true [get_files /home/tyh/Documents/pipeline/pipeline.srcs/sources_1/ip/div_gen_0/div_gen_0.dcp]
  add_files -quiet {{/home/tyh/Desktop/project /project.srcs/font_mem/ip/font_mem/font_mem.dcp}}
  set_property netlist_only true [get_files {{/home/tyh/Desktop/project /project.srcs/font_mem/ip/font_mem/font_mem.dcp}}]
  add_files -quiet {{/home/tyh/Desktop/project /project.srcs/loader_mem/ip/loader_mem/loader_mem.dcp}}
  set_property netlist_only true [get_files {{/home/tyh/Desktop/project /project.srcs/loader_mem/ip/loader_mem/loader_mem.dcp}}]
  add_files -quiet {{/home/tyh/Desktop/project /project.srcs/mig_7series_0/ip/mig_7series_0/mig_7series_0.dcp}}
  set_property netlist_only true [get_files {{/home/tyh/Desktop/project /project.srcs/mig_7series_0/ip/mig_7series_0/mig_7series_0.dcp}}]
  add_files -quiet {{/home/tyh/Desktop/project /project.srcs/ddr_clock_gen/ip/ddr_clock_gen/ddr_clock_gen.dcp}}
  set_property netlist_only true [get_files {{/home/tyh/Desktop/project /project.srcs/ddr_clock_gen/ip/ddr_clock_gen/ddr_clock_gen.dcp}}]
  add_files -quiet {{/home/tyh/Desktop/project /project.srcs/sources_1/ip/text_mem/text_mem.dcp}}
  set_property netlist_only true [get_files {{/home/tyh/Desktop/project /project.srcs/sources_1/ip/text_mem/text_mem.dcp}}]
  read_xdc -mode out_of_context -ref mult_gen_0 -cells U0 /home/tyh/Documents/pipeline/pipeline.srcs/sources_1/ip/mult_gen_0/mult_gen_0_ooc.xdc
  set_property processing_order EARLY [get_files /home/tyh/Documents/pipeline/pipeline.srcs/sources_1/ip/mult_gen_0/mult_gen_0_ooc.xdc]
  read_xdc -mode out_of_context -ref div_gen_0 -cells U0 /home/tyh/Documents/pipeline/pipeline.srcs/sources_1/ip/div_gen_0/div_gen_0_ooc.xdc
  set_property processing_order EARLY [get_files /home/tyh/Documents/pipeline/pipeline.srcs/sources_1/ip/div_gen_0/div_gen_0_ooc.xdc]
  read_xdc -mode out_of_context -ref font_mem -cells U0 {{/home/tyh/Desktop/project /project.srcs/font_mem/ip/font_mem/font_mem_ooc.xdc}}
  set_property processing_order EARLY [get_files {{/home/tyh/Desktop/project /project.srcs/font_mem/ip/font_mem/font_mem_ooc.xdc}}]
  read_xdc -mode out_of_context -ref loader_mem -cells U0 {{/home/tyh/Desktop/project /project.srcs/loader_mem/ip/loader_mem/loader_mem_ooc.xdc}}
  set_property processing_order EARLY [get_files {{/home/tyh/Desktop/project /project.srcs/loader_mem/ip/loader_mem/loader_mem_ooc.xdc}}]
  read_xdc -mode out_of_context -ref mig_7series_0 {{/home/tyh/Desktop/project /project.srcs/mig_7series_0/ip/mig_7series_0/mig_7series_0/user_design/constraints/mig_7series_0_ooc.xdc}}
  set_property processing_order EARLY [get_files {{/home/tyh/Desktop/project /project.srcs/mig_7series_0/ip/mig_7series_0/mig_7series_0/user_design/constraints/mig_7series_0_ooc.xdc}}]
  read_xdc -ref mig_7series_0 {{/home/tyh/Desktop/project /project.srcs/mig_7series_0/ip/mig_7series_0/mig_7series_0/user_design/constraints/mig_7series_0.xdc}}
  set_property processing_order EARLY [get_files {{/home/tyh/Desktop/project /project.srcs/mig_7series_0/ip/mig_7series_0/mig_7series_0/user_design/constraints/mig_7series_0.xdc}}]
  read_xdc -mode out_of_context -ref ddr_clock_gen -cells inst {{/home/tyh/Desktop/project /project.srcs/ddr_clock_gen/ip/ddr_clock_gen/ddr_clock_gen_ooc.xdc}}
  set_property processing_order EARLY [get_files {{/home/tyh/Desktop/project /project.srcs/ddr_clock_gen/ip/ddr_clock_gen/ddr_clock_gen_ooc.xdc}}]
  read_xdc -prop_thru_buffers -ref ddr_clock_gen -cells inst {{/home/tyh/Desktop/project /project.srcs/ddr_clock_gen/ip/ddr_clock_gen/ddr_clock_gen_board.xdc}}
  set_property processing_order EARLY [get_files {{/home/tyh/Desktop/project /project.srcs/ddr_clock_gen/ip/ddr_clock_gen/ddr_clock_gen_board.xdc}}]
  read_xdc -ref ddr_clock_gen -cells inst {{/home/tyh/Desktop/project /project.srcs/ddr_clock_gen/ip/ddr_clock_gen/ddr_clock_gen.xdc}}
  set_property processing_order EARLY [get_files {{/home/tyh/Desktop/project /project.srcs/ddr_clock_gen/ip/ddr_clock_gen/ddr_clock_gen.xdc}}]
  read_xdc -mode out_of_context -ref text_mem -cells U0 {{/home/tyh/Desktop/project /project.srcs/sources_1/ip/text_mem/text_mem_ooc.xdc}}
  set_property processing_order EARLY [get_files {{/home/tyh/Desktop/project /project.srcs/sources_1/ip/text_mem/text_mem_ooc.xdc}}]
  read_xdc {{/home/tyh/Desktop/project /project.srcs/constrs_1/imports/constrain/top.xdc}}
  link_design -top pipeline -part xc7a100tcsg324-1
  write_hwdef -file pipeline.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force pipeline_opt.dcp
  report_drc -file pipeline_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force pipeline_placed.dcp
  report_io -file pipeline_io_placed.rpt
  report_utilization -file pipeline_utilization_placed.rpt -pb pipeline_utilization_placed.pb
  report_control_sets -verbose -file pipeline_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force pipeline_routed.dcp
  report_drc -file pipeline_drc_routed.rpt -pb pipeline_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file pipeline_timing_summary_routed.rpt -rpx pipeline_timing_summary_routed.rpx
  report_power -file pipeline_power_routed.rpt -pb pipeline_power_summary_routed.pb -rpx pipeline_power_routed.rpx
  report_route_status -file pipeline_route_status.rpt -pb pipeline_route_status.pb
  report_clock_utilization -file pipeline_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force pipeline.mmi }
  write_bitstream -force pipeline.bit 
  catch { write_sysdef -hwdef pipeline.hwdef -bitfile pipeline.bit -meminfo pipeline.mmi -file pipeline.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

