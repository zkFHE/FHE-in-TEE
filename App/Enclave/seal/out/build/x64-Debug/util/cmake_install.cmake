# Install script for directory: C:/Users/Christian/source/repos/App/Enclave/seal/util

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Users/Christian/source/repos/App/Enclave/seal/out/install/x64-Debug")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/seal/util/blake2.h;/seal/util/blake2-impl.h;/seal/util/clang.h;/seal/util/clipnormal.h;/seal/util/common.h;/seal/util/croots.h;/seal/util/defines.h;/seal/util/dwthandler.h;/seal/util/fips202.h;/seal/util/galois.h;/seal/util/gcc.h;/seal/util/globals.h;/seal/util/hash.h;/seal/util/hestdparms.h;/seal/util/iterator.h;/seal/util/locks.h;/seal/util/mempool.h;/seal/util/msvc.h;/seal/util/numth.h;/seal/util/pointer.h;/seal/util/polyarithsmallmod.h;/seal/util/polycore.h;/seal/util/rlwe.h;/seal/util/rns.h;/seal/util/scalingvariant.h;/seal/util/ntt.h;/seal/util/streambuf.h;/seal/util/uintarith.h;/seal/util/uintarithmod.h;/seal/util/uintarithsmallmod.h;/seal/util/uintcore.h;/seal/util/ztools.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/seal/util" TYPE FILE FILES
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/blake2.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/blake2-impl.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/clang.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/clipnormal.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/common.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/croots.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/defines.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/dwthandler.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/fips202.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/galois.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/gcc.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/globals.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/hash.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/hestdparms.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/iterator.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/locks.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/mempool.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/msvc.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/numth.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/pointer.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/polyarithsmallmod.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/polycore.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/rlwe.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/rns.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/scalingvariant.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/ntt.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/streambuf.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/uintarith.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/uintarithmod.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/uintarithsmallmod.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/uintcore.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/util/ztools.h"
    )
endif()

