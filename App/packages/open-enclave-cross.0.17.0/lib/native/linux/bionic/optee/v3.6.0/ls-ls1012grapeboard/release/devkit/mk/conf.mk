sm := ta_arm64
sm-ta_arm64 := y
CFG_ARM64_ta_arm64 := y
ta_arm64-platform-cppflags := -DARM64=1 -D__LP64__=1 -DMBEDTLS_SELF_TEST
ta_arm64-platform-cflags := -O0 -g3 -fpic -mstrict-align
ta_arm64-platform-aflags := -pipe -g
CFG_TA_FLOAT_SUPPORT := y
CFG_SECURE_DATA_PATH := n
CFG_TA_MBEDTLS_SELF_TEST := y
CFG_TA_MBEDTLS := y
CFG_TA_MBEDTLS_MPI := y
CFG_SYSTEM_PTA := y
CFG_TA_DYNLINK := y
CFG_TEE_TA_LOG_LEVEL := 4
CFG_TA_FTRACE_SUPPORT := n
CFG_UNWIND := n
CFG_TA_MBEDTLS := y
CROSS_COMPILE64 ?= $(CROSS_COMPILE)
CROSS_COMPILE_ta_arm64 ?= $(CROSS_COMPILE64)

