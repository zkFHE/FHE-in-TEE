#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "openenclave::oehostverify" for configuration "Debug"
set_property(TARGET openenclave::oehostverify APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(openenclave::oehostverify PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/openenclave/host/liboehostverify.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oehostverify )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oehostverify "${_IMPORT_PREFIX}/lib/openenclave/host/liboehostverify.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
