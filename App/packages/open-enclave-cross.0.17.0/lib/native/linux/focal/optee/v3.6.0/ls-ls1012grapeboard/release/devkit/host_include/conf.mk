# auto-generated TEE configuration file
# TEE version v0.4.0-1123-gd1634ce8-dev
ARCH=arm
PLATFORM=ls
PLATFORM_FLAVOR=ls1012grapeboard
CFG_16550_UART=y
CFG_AES_GCM_TABLE_BASED=y
CFG_ARM64_core=y
CFG_ARM64_ldelf=y
CFG_ARM64_ta_arm64=y
CFG_ATTESTATION_MEASURE=y
CFG_BOOT_SECONDARY_REQUEST=n
CFG_CC_OPTIMIZE_FOR_SIZE=y
CFG_CORE_BGET_BESTFIT=
CFG_CORE_BIGNUM_MAX_BITS=4096
CFG_CORE_CLUSTER_SHIFT=2
CFG_CORE_DUMP_OOM=n
CFG_CORE_DYN_SHM=y
CFG_CORE_HEAP_SIZE=65536
CFG_CORE_HUK_SUBKEY_COMPAT=y
CFG_CORE_LARGE_PHYS_ADDR=n
CFG_CORE_MBEDTLS_MPI=y
CFG_CORE_NEX_HEAP_SIZE=16384
CFG_CORE_RESERVED_SHM=y
CFG_CORE_RODATA_NOEXEC=n
CFG_CORE_RWDATA_NOEXEC=y
CFG_CORE_SANITIZE_KADDRESS=n
CFG_CORE_SANITIZE_UNDEFINED=n
CFG_CORE_TZSRAM_EMUL_SIZE=458752
CFG_CORE_UNMAP_CORE_AT_EL0=y
CFG_CORE_WORKAROUND_SPECTRE_BP=y
CFG_CORE_WORKAROUND_SPECTRE_BP_SEC=y
CFG_CRYPTO=y
CFG_CRYPTOLIB_DIR=core/lib/libtomcrypt
CFG_CRYPTOLIB_NAME=tomcrypt
CFG_CRYPTOLIB_NAME_tomcrypt=y
CFG_CRYPTO_AES=y
CFG_CRYPTO_AES_GCM_FROM_CRYPTOLIB=n
CFG_CRYPTO_CBC=y
CFG_CRYPTO_CBC_MAC=y
CFG_CRYPTO_CCM=y
CFG_CRYPTO_CMAC=y
CFG_CRYPTO_CONCAT_KDF=y
CFG_CRYPTO_CTR=y
CFG_CRYPTO_CTS=y
CFG_CRYPTO_DES=y
CFG_CRYPTO_DH=y
CFG_CRYPTO_DSA=y
CFG_CRYPTO_ECB=y
CFG_CRYPTO_ECC=y
CFG_CRYPTO_GCM=y
CFG_CRYPTO_HKDF=y
CFG_CRYPTO_HMAC=y
CFG_CRYPTO_MD5=y
CFG_CRYPTO_PBKDF2=y
CFG_CRYPTO_RSA=y
CFG_CRYPTO_RSASSA_NA1=y
CFG_CRYPTO_SHA1=y
CFG_CRYPTO_SHA224=y
CFG_CRYPTO_SHA256=y
CFG_CRYPTO_SHA384=y
CFG_CRYPTO_SHA512=y
CFG_CRYPTO_SHA512_256=y
CFG_CRYPTO_SIZE_OPTIMIZATION=y
CFG_CRYPTO_XTS=y
CFG_CYRES=y
CFG_CYRES_CERT_CHAIN_ADDR=0x81FFD000
CFG_CYRES_KEY_ADDR=0x81FFC000
CFG_DEBUG_INFO=y
CFG_DEVICE_ENUM_PTA=y
CFG_DRAM0_BASE=0x80000000
CFG_DRAM0_SIZE=0x40000000
CFG_DT=n
CFG_DTB_MAX_SIZE=0x10000
CFG_EARLY_TA=n
CFG_EMBED_DTB=n
CFG_ENABLE_SCTLR_RR=n
CFG_ENABLE_SCTLR_Z=n
CFG_EXTERNAL_DTB_OVERLAY=n
CFG_GENERIC_BOOT=y
CFG_GIC=y
CFG_GP_SOCKETS=y
CFG_GRPC=y
CFG_HWSUPP_MEM_PERM_PXN=y
CFG_HWSUPP_MEM_PERM_WXN=y
CFG_HW_UNQ_KEY_REQUEST=y
CFG_KERN_LINKER_ARCH=aarch64
CFG_KERN_LINKER_FORMAT=elf64-littleaarch64
CFG_LIBUTILS_WITH_ISOC=y
CFG_LOCKDEP=n
CFG_LPAE_ADDR_SPACE_SIZE=(1ull << 32)
CFG_LTC_OPTEE_THREAD=y
CFG_MMAP_REGIONS=13
CFG_MSG_LONG_PREFIX_MASK=0x1a
CFG_NUM_THREADS=CFG_TEE_CORE_NB_CORE
CFG_OPTEE_REVISION_MAJOR=3
CFG_OPTEE_REVISION_MINOR=6
CFG_OS_REV_REPORTS_GIT_SHA1=y
CFG_PAGED_USER_TA=n
CFG_PM_STUBS=y
CFG_REE_FS=n
CFG_REE_FS_TA=y
CFG_REE_FS_TA_BUFFERED=y
CFG_RESERVED_VASPACE_SIZE=(1024 * 1024 * 10)
CFG_RPMB_FS=y
CFG_RPMB_FS_DEV_ID=0
CFG_RPMB_RESET_FAT=n
CFG_RPMB_TESTKEY=y
CFG_RPMB_WRITE_KEY=n
CFG_SCTLR_ALIGNMENT_CHECK=y
CFG_SECSTOR_TA=
CFG_SECSTOR_TA_MGMT_PTA=
CFG_SECURE_DATA_PATH=n
CFG_SECURE_TIME_SOURCE_CNTPCT=y
CFG_SHMEM_SIZE=0x00200000
CFG_SHMEM_START=((CFG_DRAM0_BASE + CFG_DRAM0_SIZE) - CFG_SHMEM_SIZE)
CFG_SM_NO_CYCLE_COUNTING=y
CFG_SYSTEM_PTA=y
CFG_TA_ASLR=n
CFG_TA_ASLR_MAX_OFFSET_PAGES=128
CFG_TA_ASLR_MIN_OFFSET_PAGES=0
CFG_TA_BIGNUM_MAX_BITS=2048
CFG_TA_DYNLINK=y
CFG_TA_FLOAT_SUPPORT=y
CFG_TA_FTRACE_SUPPORT=n
CFG_TA_GPROF_SUPPORT=n
CFG_TA_MBEDTLS=y
CFG_TA_MBEDTLS_MPI=y
CFG_TA_MBEDTLS_SELF_TEST=y
CFG_TA_RPC=y
CFG_TEE_API_VERSION=GPD-1.1-dev
CFG_TEE_CORE_DEBUG=y
CFG_TEE_CORE_EMBED_INTERNAL_TESTS=y
CFG_TEE_CORE_LOG_LEVEL=2
CFG_TEE_CORE_MALLOC_DEBUG=n
CFG_TEE_CORE_NB_CORE=1
CFG_TEE_CORE_TA_TRACE=y
CFG_TEE_FW_IMPL_VERSION=FW_IMPL_UNDEF
CFG_TEE_FW_MANUFACTURER=FW_MAN_UNDEF
CFG_TEE_IMPL_DESCR=OPTEE
CFG_TEE_MANUFACTURER=LINARO
CFG_TEE_OS_DRAM0_SIZE=0x4000000
CFG_TEE_TA_LOG_LEVEL=4
CFG_TEE_TA_MALLOC_DEBUG=n
CFG_TZDRAM_SIZE=( CFG_TEE_OS_DRAM0_SIZE - CFG_SHMEM_SIZE)
CFG_TZDRAM_START=((CFG_DRAM0_BASE + CFG_DRAM0_SIZE) - CFG_TEE_OS_DRAM0_SIZE)
CFG_ULIBS_MCOUNT=n
CFG_ULIBS_SHARED=n
CFG_UNWIND=n
CFG_USER_TA_TARGETS=ta_arm64
CFG_VIRTUALIZATION=n
CFG_WITH_ARM_TRUSTED_FW=y
CFG_WITH_LPAE=y
CFG_WITH_PAGER=n
CFG_WITH_SOFTWARE_PRNG=y
CFG_WITH_STACK_CANARIES=y
CFG_WITH_USER_TA=y
CFG_WITH_VFP=y