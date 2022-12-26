# Copyright (c) Open Enclave SDK contributors.
# Licensed under the MIT License.


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was openenclave-lvi-mitigation-config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

# OE_LVI_MITIGATION holds the value of LVI_MITIGATION from the configuration of OE SDK.
# OE_LVI_MITIGATION=ControlFlow indicates that the SDK supports LVI mitigation.
set(OE_LVI_MITIGATION "ControlFlow")

# Include the helper function to apply lvi mitigation.
if (OE_LVI_MITIGATION MATCHES ControlFlow)
  if (UNIX)
    set(LVI_MITIGATION_BINDIR "None" CACHE STRING "Path to the LVI mitigation bindir.")
    if (${LVI_MITIGATION_BINDIR} MATCHES None)
      message(FATAL_ERROR "LVI_MITIGATION_BINDIR is not specified.")
    endif()
    include("${CMAKE_CURRENT_LIST_DIR}/configure_lvi_mitigation_build.cmake")
    # Pick up the customized compilation toolchain based on the specified path.
    configure_lvi_mitigation_build(BINDIR ${LVI_MITIGATION_BINDIR} IN_PACKAGE)
  endif()
  include("${CMAKE_CURRENT_LIST_DIR}/apply_lvi_mitigation.cmake")
else()
  message(FATAL_ERROR "This version of the OE SDK was not built with support for LVI mitigation.")
endif()
