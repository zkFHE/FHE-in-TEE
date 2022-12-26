# Install script for directory: C:/Users/Christian/source/repos/App/Enclave/seal

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
   "/seal/batchencoder.h;/seal/ciphertext.h;/seal/ckks.h;/seal/modulus.h;/seal/context.h;/seal/decryptor.h;/seal/dynarray.h;/seal/encryptionparams.h;/seal/encryptor.h;/seal/evaluator.h;/seal/galoiskeys.h;/seal/keygenerator.h;/seal/kswitchkeys.h;/seal/memorymanager.h;/seal/plaintext.h;/seal/publickey.h;/seal/randomgen.h;/seal/randomtostd.h;/seal/relinkeys.h;/seal/seal.h;/seal/secretkey.h;/seal/serializable.h;/seal/serialization.h;/seal/valcheck.h;/seal/version.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/seal" TYPE FILE FILES
    "C:/Users/Christian/source/repos/App/Enclave/seal/batchencoder.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/ciphertext.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/ckks.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/modulus.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/context.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/decryptor.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/dynarray.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/encryptionparams.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/encryptor.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/evaluator.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/galoiskeys.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/keygenerator.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/kswitchkeys.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/memorymanager.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/plaintext.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/publickey.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/randomgen.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/randomtostd.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/relinkeys.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/seal.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/secretkey.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/serializable.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/serialization.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/valcheck.h"
    "C:/Users/Christian/source/repos/App/Enclave/seal/version.h"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("C:/Users/Christian/source/repos/App/Enclave/seal/out/build/x64-Debug/util/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "C:/Users/Christian/source/repos/App/Enclave/seal/out/build/x64-Debug/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
