# TCL File Generated by Component Editor 18.1
# Wed Apr 06 18:27:52 PDT 2022
# DO NOT MODIFY


# 
# image_reader "image_reader" v1.0
#  2022.04.06.18:27:52
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module image_reader
# 
set_module_property DESCRIPTION ""
set_module_property NAME image_reader
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME image_reader
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL image_reader
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file image_reader.sv SYSTEM_VERILOG PATH image_reader.sv TOP_LEVEL_FILE
add_fileset_file slow2fast_sync.sv SYSTEM_VERILOG PATH slow2fast_sync.sv
add_fileset_file dct_quantization.sv SYSTEM_VERILOG PATH dct_quantization.sv


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point indata
# 
add_interface indata conduit end
set_interface_property indata associatedClock clock
set_interface_property indata associatedReset reset
set_interface_property indata ENABLED true
set_interface_property indata EXPORT_OF ""
set_interface_property indata PORT_NAME_MAP ""
set_interface_property indata CMSIS_SVD_VARIABLES ""
set_interface_property indata SVD_ADDRESS_GROUP ""

add_interface_port indata INDATA_export indata_export Input 31


# 
# connection point avalon_slave_0_1
# 
add_interface avalon_slave_0_1 avalon end
set_interface_property avalon_slave_0_1 addressUnits WORDS
set_interface_property avalon_slave_0_1 associatedClock clock
set_interface_property avalon_slave_0_1 associatedReset reset
set_interface_property avalon_slave_0_1 bitsPerSymbol 8
set_interface_property avalon_slave_0_1 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0_1 burstcountUnits WORDS
set_interface_property avalon_slave_0_1 explicitAddressSpan 0
set_interface_property avalon_slave_0_1 holdTime 0
set_interface_property avalon_slave_0_1 linewrapBursts false
set_interface_property avalon_slave_0_1 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0_1 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0_1 readLatency 0
set_interface_property avalon_slave_0_1 readWaitTime 1
set_interface_property avalon_slave_0_1 setupTime 0
set_interface_property avalon_slave_0_1 timingUnits Cycles
set_interface_property avalon_slave_0_1 writeWaitTime 0
set_interface_property avalon_slave_0_1 ENABLED true
set_interface_property avalon_slave_0_1 EXPORT_OF ""
set_interface_property avalon_slave_0_1 PORT_NAME_MAP ""
set_interface_property avalon_slave_0_1 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0_1 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0_1 addr address Input 2
add_interface_port avalon_slave_0_1 rd_en read Input 1
add_interface_port avalon_slave_0_1 wr_en write Input 1
add_interface_port avalon_slave_0_1 readdata readdata Output 32
add_interface_port avalon_slave_0_1 writedata writedata Input 32
set_interface_assignment avalon_slave_0_1 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0_1 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0_1 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0_1 embeddedsw.configuration.isPrintableDevice 0

