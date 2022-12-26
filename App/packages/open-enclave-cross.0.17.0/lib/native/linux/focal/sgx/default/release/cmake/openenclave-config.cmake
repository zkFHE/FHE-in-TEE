# Copyright (c) Open Enclave SDK contributors.
# Licensed under the MIT License.


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was openenclave-config.cmake.in                            ########

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

# Reference data.
set(OE_BRANCH "")
set(OE_COMMIT "")
set(OE_BUILD_NUMBER "0")

set_and_check(OE_LIBDIR "${PACKAGE_PREFIX_DIR}/lib")
set_and_check(OE_BINDIR "${PACKAGE_PREFIX_DIR}/bin")
set_and_check(OE_DATADIR "${PACKAGE_PREFIX_DIR}/share")
set_and_check(OE_INCLUDEDIR "${PACKAGE_PREFIX_DIR}/include")
set(OE_SCRIPTSDIR "${PACKAGE_PREFIX_DIR}/bin/scripts")
set(OE_SGX "1")
# Explicitly disable the use of RPATH
set(CMAKE_SKIP_RPATH TRUE)

if (WIN32)
  set(USE_CLANGW ON)

  # NOTE: On Windows we have found that we must use Git Bash, not the
  # Bash from the Windows Subsystem for Linux. Hence this is
  # explicitly searching only for Git Bash. See #1302 for more.
  find_program(GIT git)
  get_filename_component(GIT_DIR ${GIT} DIRECTORY)
  find_program(OE_BASH bash
    PATHS "C:/Program Files/Git/bin" "${GIT_DIR}/../bin"
    NO_DEFAULT_PATH) # Do not find WSL bash.

  if (NOT OE_BASH)
    message(FATAL_ERROR "-- Git Bash not found!")
  endif ()
  if (NOT NUGET_PACKAGE_PATH)
    message(FATAL_ERROR "NUGET_PACKAGE_PATH not defined. Please define NUGET_PACKAGE_PATH as the path to the installed Intel and DCAP Client nuget packages.")
  endif()
else ()
  find_program(OE_BASH bash)
  if (NOT OE_BASH)
    message(FATAL_ERROR "-- Bash not found!")
  endif ()
endif ()


# Dependencies.
include(CMakeFindDependencyMacro)
find_dependency(Threads)
if (UNIX)
  if (NOT TARGET openenclave::crypto)
    find_library(CRYPTO_LIB NAMES crypto)
    if (NOT CRYPTO_LIB)
      message(FATAL_ERROR "-- Looking for crypto library - not found")
    else ()
      message("-- Looking for crypto library - found")
      add_library(openenclave::crypto SHARED IMPORTED)
      set_target_properties(openenclave::crypto PROPERTIES IMPORTED_LOCATION ${CRYPTO_LIB})
    endif ()
  endif ()
  
  if (NOT TARGET openenclave::dl)
    find_library(DL_LIB NAMES dl)
    if(NOT DL_LIB)
      message(FATAL_ERROR "-- Looking for dl library - not found")
    else ()
      message("-- Looking for dl library - found")
      add_library(openenclave::dl SHARED IMPORTED)
      set_target_properties(openenclave::dl PROPERTIES IMPORTED_LOCATION ${DL_LIB})
    endif ()
  endif ()
elseif (WIN32)
  if (NOT NUGET_PACKAGE_PATH)
    message(FATAL_ERROR "NUGET_PACKAGE_PATH not defined. Please define NUGET_PACKAGE_PATH as the path to the Intel and DCAP Client nuget packages.")
  endif()
endif ()

# Include the automatically exported targets.
if (COMPONENT MATCHES "OEHOSTVERIFY")
  include("${CMAKE_CURRENT_LIST_DIR}/openenclave-hostverify-targets.cmake")
else ()
  include("${CMAKE_CURRENT_LIST_DIR}/openenclave-targets.cmake")
endif ()
if (WIN32)
  include("${CMAKE_CURRENT_LIST_DIR}/add_dcap_client_target.cmake")
  include("${CMAKE_CURRENT_LIST_DIR}/copy_oedebugrt_target.cmake")
  include("${CMAKE_CURRENT_LIST_DIR}/maybe_build_using_clangw.cmake")
endif ()

if (OE_SGX)
  if (NOT TARGET openenclave::sgx_dcap_ql)
    if (UNIX)
      find_library(SGX_DCAP_QL_LIB NAMES sgx_dcap_ql HINTS "/usr")
    elseif (WIN32)
      find_library(SGX_DCAP_QL_LIB NAMES sgx_dcap_ql
                 HINTS ${NUGET_PACKAGE_PATH}/DCAP_Components/build/lib/native/Libraries)
    endif ()
    if (NOT SGX_DCAP_QL_LIB)
      message(WARNING "-- Looking for sgx_dcap_ql library - not found. Attestations based on quotes would not function without the quote provider.")
    else ()
      message(VERBOSE "-- Looking for sgx_dcap_ql library - found")
      add_library(openenclave::sgx_dcap_ql SHARED IMPORTED)
      if (UNIX)
        set_target_properties(openenclave::sgx_dcap_ql PROPERTIES IMPORTED_LOCATION ${SGX_DCAP_QL_LIB})
      elseif (WIN32)
        set_target_properties(openenclave::sgx_dcap_ql PROPERTIES
                              IMPORTED_LOCATION $ENV{WINDIR}/System32
                              IMPORTED_IMPLIB ${SGX_DCAP_QL_LIB})
      endif ()
    endif ()
  endif ()
endif ()

# This target is an external project, so we have to manually
# "export" it here for users of the package.
if(NOT TARGET openenclave::oeedger8r)
  add_executable(openenclave::oeedger8r IMPORTED)
  set_target_properties(openenclave::oeedger8r PROPERTIES IMPORTED_LOCATION ${OE_BINDIR}/oeedger8r)
endif ()

# Similarly, this is a shell script.
if(NOT TARGET openenclave::oegdb)
  add_executable(openenclave::oegdb IMPORTED)
  set_target_properties(openenclave::oegdb PROPERTIES IMPORTED_LOCATION ${OE_BINDIR}/oegdb)
endif ()

# Apply Spectre mitigations if available.
set(OE_SPECTRE_MITIGATION_FLAGS "-mllvm;-x86-speculative-load-hardening")

# Check for compiler flags support.
if (CMAKE_C_COMPILER)
  include(CheckCCompilerFlag)
  check_c_compiler_flag("${OE_SPECTRE_MITIGATION_FLAGS}" OE_SPECTRE_MITIGATION_C_FLAGS_SUPPORTED)
endif ()

if (CMAKE_CXX_COMPILER)
  include(CheckCXXCompilerFlag)
  check_cxx_compiler_flag("${OE_SPECTRE_MITIGATION_FLAGS}" OE_SPECTRE_MITIGATION_CXX_FLAGS_SUPPORTED)
endif ()

if (TARGET openenclave::oecore AND (OE_SPECTRE_MITIGATION_C_FLAGS_SUPPORTED OR OE_SPECTRE_MITIGATION_CXX_FLAGS_SUPPORTED))
  target_compile_options(openenclave::oecore INTERFACE ${OE_SPECTRE_MITIGATION_FLAGS})
endif ()
