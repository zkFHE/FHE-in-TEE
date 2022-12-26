#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "openenclave::oehost" for configuration "Release"
set_property(TARGET openenclave::oehost APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oehost PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/host/liboehost.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oehost )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oehost "${_IMPORT_PREFIX}/lib/openenclave/host/liboehost.a" )

# Import target "openenclave::oesign" for configuration "Release"
set_property(TARGET openenclave::oesign APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oesign PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/oesign"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oesign )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oesign "${_IMPORT_PREFIX}/bin/oesign" )

# Import target "openenclave::oeutil" for configuration "Release"
set_property(TARGET openenclave::oeutil APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oeutil PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/oeutil"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oeutil )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oeutil "${_IMPORT_PREFIX}/bin/oeutil" )

# Import target "openenclave::oecore" for configuration "Release"
set_property(TARGET openenclave::oecore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oecore PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecore.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oecore )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oecore "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecore.a" )

# Import target "openenclave::oecore-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oecore-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oecore-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecore-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oecore-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oecore-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecore-lvi-cfg.a" )

# Import target "openenclave::oedebugmalloc" for configuration "Release"
set_property(TARGET openenclave::oedebugmalloc APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oedebugmalloc PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboedebugmalloc.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oedebugmalloc )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oedebugmalloc "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboedebugmalloc.a" )

# Import target "openenclave::oedebugmalloc-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oedebugmalloc-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oedebugmalloc-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboedebugmalloc-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oedebugmalloc-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oedebugmalloc-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboedebugmalloc-lvi-cfg.a" )

# Import target "openenclave::oecryptombedtls" for configuration "Release"
set_property(TARGET openenclave::oecryptombedtls APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oecryptombedtls PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecryptombedtls.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oecryptombedtls )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oecryptombedtls "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecryptombedtls.a" )

# Import target "openenclave::oecryptombedtls-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oecryptombedtls-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oecryptombedtls-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecryptombedtls-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oecryptombedtls-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oecryptombedtls-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecryptombedtls-lvi-cfg.a" )

# Import target "openenclave::oecryptoopenssl" for configuration "Release"
set_property(TARGET openenclave::oecryptoopenssl APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oecryptoopenssl PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecryptoopenssl.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oecryptoopenssl )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oecryptoopenssl "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecryptoopenssl.a" )

# Import target "openenclave::oecryptoopenssl-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oecryptoopenssl-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oecryptoopenssl-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecryptoopenssl-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oecryptoopenssl-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oecryptoopenssl-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboecryptoopenssl-lvi-cfg.a" )

# Import target "openenclave::oeseal_gcmaes" for configuration "Release"
set_property(TARGET openenclave::oeseal_gcmaes APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oeseal_gcmaes PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_RELEASE ""
  IMPORTED_OBJECTS_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/objects-Release/oeseal_gcmaes/seal_gcmaes.c.o"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oeseal_gcmaes )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oeseal_gcmaes "${_IMPORT_PREFIX}/lib/openenclave/enclave/objects-Release/oeseal_gcmaes/seal_gcmaes.c.o" )

# Import target "openenclave::oeseal_gcmaes-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oeseal_gcmaes-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oeseal_gcmaes-lvi-cfg PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_RELEASE ""
  IMPORTED_OBJECTS_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/objects-Release/oeseal_gcmaes-lvi-cfg/seal_gcmaes.c.o"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oeseal_gcmaes-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oeseal_gcmaes-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/objects-Release/oeseal_gcmaes-lvi-cfg/seal_gcmaes.c.o" )

# Import target "openenclave::oeenclave" for configuration "Release"
set_property(TARGET openenclave::oeenclave APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oeenclave PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboeenclave.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oeenclave )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oeenclave "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboeenclave.a" )

# Import target "openenclave::oeenclave-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oeenclave-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oeenclave-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboeenclave-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oeenclave-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oeenclave-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboeenclave-lvi-cfg.a" )

# Import target "openenclave::mbedcrypto_static" for configuration "Release"
set_property(TARGET openenclave::mbedcrypto_static APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::mbedcrypto_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedcrypto.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::mbedcrypto_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::mbedcrypto_static "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedcrypto.a" )

# Import target "openenclave::mbedcrypto_static-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::mbedcrypto_static-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::mbedcrypto_static-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedcrypto-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::mbedcrypto_static-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::mbedcrypto_static-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedcrypto-lvi-cfg.a" )

# Import target "openenclave::mbedx509" for configuration "Release"
set_property(TARGET openenclave::mbedx509 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::mbedx509 PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedx509.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::mbedx509 )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::mbedx509 "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedx509.a" )

# Import target "openenclave::mbedx509-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::mbedx509-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::mbedx509-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedx509-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::mbedx509-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::mbedx509-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedx509-lvi-cfg.a" )

# Import target "openenclave::mbedtls" for configuration "Release"
set_property(TARGET openenclave::mbedtls APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::mbedtls PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedtls.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::mbedtls )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::mbedtls "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedtls.a" )

# Import target "openenclave::mbedtls-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::mbedtls-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::mbedtls-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedtls-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::mbedtls-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::mbedtls-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/libmbedtls-lvi-cfg.a" )

# Import target "openenclave::oesnmalloc" for configuration "Release"
set_property(TARGET openenclave::oesnmalloc APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oesnmalloc PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboesnmalloc.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oesnmalloc )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oesnmalloc "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboesnmalloc.a" )

# Import target "openenclave::oesnmalloc-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oesnmalloc-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oesnmalloc-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboesnmalloc-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oesnmalloc-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oesnmalloc-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboesnmalloc-lvi-cfg.a" )

# Import target "openenclave::opensslcrypto" for configuration "Release"
set_property(TARGET openenclave::opensslcrypto APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::opensslcrypto PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/libopensslcrypto.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::opensslcrypto )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::opensslcrypto "${_IMPORT_PREFIX}/lib/openenclave/enclave/libopensslcrypto.a" )

# Import target "openenclave::opensslcrypto-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::opensslcrypto-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::opensslcrypto-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/libopensslcrypto-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::opensslcrypto-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::opensslcrypto-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/libopensslcrypto-lvi-cfg.a" )

# Import target "openenclave::opensslssl" for configuration "Release"
set_property(TARGET openenclave::opensslssl APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::opensslssl PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/libopensslssl.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::opensslssl )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::opensslssl "${_IMPORT_PREFIX}/lib/openenclave/enclave/libopensslssl.a" )

# Import target "openenclave::opensslssl-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::opensslssl-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::opensslssl-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/libopensslssl-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::opensslssl-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::opensslssl-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/libopensslssl-lvi-cfg.a" )

# Import target "openenclave::oelibc" for configuration "Release"
set_property(TARGET openenclave::oelibc APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oelibc PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboelibc.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oelibc )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oelibc "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboelibc.a" )

# Import target "openenclave::oelibc-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oelibc-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oelibc-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboelibc-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oelibc-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oelibc-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboelibc-lvi-cfg.a" )

# Import target "openenclave::oelibcxx" for configuration "Release"
set_property(TARGET openenclave::oelibcxx APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oelibcxx PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C;CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboelibcxx.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oelibcxx )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oelibcxx "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboelibcxx.a" )

# Import target "openenclave::oelibcxx-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oelibcxx-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oelibcxx-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "ASM;C;CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboelibcxx-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oelibcxx-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oelibcxx-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboelibcxx-lvi-cfg.a" )

# Import target "openenclave::oesyscall" for configuration "Release"
set_property(TARGET openenclave::oesyscall APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oesyscall PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboesyscall.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oesyscall )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oesyscall "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboesyscall.a" )

# Import target "openenclave::oesyscall-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oesyscall-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oesyscall-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboesyscall-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oesyscall-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oesyscall-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboesyscall-lvi-cfg.a" )

# Import target "openenclave::oehostfs" for configuration "Release"
set_property(TARGET openenclave::oehostfs APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oehostfs PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostfs.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oehostfs )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oehostfs "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostfs.a" )

# Import target "openenclave::oehostfs-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oehostfs-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oehostfs-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostfs-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oehostfs-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oehostfs-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostfs-lvi-cfg.a" )

# Import target "openenclave::oehostresolver" for configuration "Release"
set_property(TARGET openenclave::oehostresolver APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oehostresolver PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostresolver.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oehostresolver )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oehostresolver "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostresolver.a" )

# Import target "openenclave::oehostresolver-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oehostresolver-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oehostresolver-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostresolver-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oehostresolver-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oehostresolver-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostresolver-lvi-cfg.a" )

# Import target "openenclave::oehostsock" for configuration "Release"
set_property(TARGET openenclave::oehostsock APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oehostsock PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostsock.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oehostsock )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oehostsock "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostsock.a" )

# Import target "openenclave::oehostsock-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oehostsock-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oehostsock-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostsock-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oehostsock-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oehostsock-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostsock-lvi-cfg.a" )

# Import target "openenclave::oehostepoll" for configuration "Release"
set_property(TARGET openenclave::oehostepoll APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oehostepoll PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostepoll.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oehostepoll )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oehostepoll "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostepoll.a" )

# Import target "openenclave::oehostepoll-lvi-cfg" for configuration "Release"
set_property(TARGET openenclave::oehostepoll-lvi-cfg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openenclave::oehostepoll-lvi-cfg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostepoll-lvi-cfg.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openenclave::oehostepoll-lvi-cfg )
list(APPEND _IMPORT_CHECK_FILES_FOR_openenclave::oehostepoll-lvi-cfg "${_IMPORT_PREFIX}/lib/openenclave/enclave/liboehostepoll-lvi-cfg.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
