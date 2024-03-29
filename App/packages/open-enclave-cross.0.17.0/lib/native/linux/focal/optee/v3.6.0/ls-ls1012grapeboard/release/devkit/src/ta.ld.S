#ifdef ARM32
OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)
#define MCOUNT_SYM __gnu_mcount_nc
/*
 * This magic value corresponds to the size requested by
 * libutee/arch/arm/gprof/gprof.c
 */
#define GPROF_BUF_MULT(x) ((x) * 136) / 100
#endif
#ifdef ARM64
OUTPUT_FORMAT("elf64-littleaarch64")
OUTPUT_ARCH(aarch64)
#define MCOUNT_SYM _mcount
#define GPROF_BUF_MULT(x) ((x) * 177) / 100
#endif

#ifndef CFG_FTRACE_BUF_SIZE
#define CFG_FTRACE_BUF_SIZE 2048
#endif

PHDRS {
	exidx 0x70000001;
	exec PT_LOAD FLAGS (5);
	rwdata PT_LOAD FLAGS (6);
	dyn PT_DYNAMIC;
	cxx PT_GNU_EH_FRAME;
}

SECTIONS {
	.ta_head : ALIGN(4096) {*(.ta_head)} :exec
	.text : {
		__text_start = .;
		*(.text .text.*)
		*(.stub)
		*(.glue_7)
		*(.glue_7t)
		*(.gnu.linkonce.t.*)
		/* Workaround for an erratum in ARM's VFP11 coprocessor */
		*(.vfp11_veneer)
		__text_end = .;
	}
	.plt : { *(.plt) }

	.eh_frame : { *(.eh_frame) *(.eh_frame.*) }
	.rodata : {
		*(.gnu.linkonce.r.*)
		*(.rodata .rodata.*)
	}
	/* .ARM.exidx is sorted, so has to go in its own output section.  */
	.ARM.exidx : { *(.ARM.exidx* .gnu.linkonce.armexidx.*) } :exec :exidx
	.ctors : { *(.ctors) } :exec
	.dtors : { *(.dtors) }
	.init_array : {
		PROVIDE_HIDDEN (__init_array_start = .);
		KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*)))
		KEEP (*(.init_array))
		PROVIDE_HIDDEN (__init_array_end = .);
	}
	.fini_array : {
		PROVIDE_HIDDEN (__fini_array_start = .);
		KEEP (*(SORT_BY_INIT_PRIORITY(.fini_array.*)))
		KEEP (*(.fini_array))
		PROVIDE_HIDDEN (__fini_array_end = .);
	}
	.dynsym : { *(.dynsym) }
	.dynstr : { *(.dynstr) }
	.hash : { *(.hash) }

	/* Page align to allow dropping execute bit for RW data */
	.ta_info : ALIGN(4096) {*(.ta_info)} :rwdata
	.got : { *(.got.plt) *(.got) }
	.rel.text : { *(.rel.text) *(.rel.gnu.linkonce.t*) }
	.rela.text : { *(.rela.text) *(.rela.gnu.linkonce.t*) }
	.rel.data : { *(.rel.data) *(.rel.gnu.linkonce.d*) }
	.rela.data : { *(.rela.data) *(.rela.gnu.linkonce.d*) }
	.rel.rodata : { *(.rel.rodata) *(.rel.gnu.linkonce.r*) }
	.rela.rodata : { *(.rela.rodata) *(.rela.gnu.linkonce.r*) }
	.rel.dyn : { *(.rel.dyn) }
	.rel.got : { *(.rel.got) }
	.rela.got : { *(.rela.got) }
	.rel.ctors : { *(.rel.ctors) }
	.rela.ctors : { *(.rela.ctors) }
	.rel.dtors : { *(.rel.dtors) }
	.rela.dtors : { *(.rela.dtors) }
	.rel.init : { *(.rel.init) }
	.rela.init : { *(.rela.init) }
	.rel.fini : { *(.rel.fini) }
	.rela.fini : { *(.rela.fini) }
	.rel.bss : { *(.rel.bss) }
	.rela.bss : { *(.rela.bss) }
	.rel.plt : { *(.rel.plt) }
	.rela.plt : { *(.rela.plt) }
	.eh_frame_hdr : { *(.eh_frame_hdr) *(.eh_frame_entry .eh_frame_entry.*) } :rwdata :cxx
	.gcc_except_table : { *(.gcc_except_table .gcc_except_table.*) } :rwdata
	.gnu_extab : { *(.gnu_extab*) }

	.dynamic : { *(.dynamic) } :rwdata :dyn

	.data : { *(.data .data.* .gnu.linkonce.d.*) } :rwdata
	.bss : {
		*(.bss .bss.* .gnu.linkonce.b.* COMMON)

		/*
		 * TA profiling with gprof
		 * Reserve some space for the profiling buffer, only if the
		 * TA is instrumented (i.e., some files were built with -pg).
		 * This also provides a way to detect at runtime if the TA is
		 * instrumented or not.
		 */
		. = ALIGN(8);
		__gprof_buf_start = .;
		. += DEFINED(MCOUNT_SYM) ?
			GPROF_BUF_MULT(__text_end - __text_start) : 0;
		__gprof_buf_end = .;

		/*
		 * TA tracing using ftrace
		 * Reserve some space for the ftrace buffer, only if the
		 * TA is instrumented (i.e., some files were built with -pg).
		 */
		. = ALIGN(8);
		__ftrace_buf_start = .;
		. += DEFINED(MCOUNT_SYM) ?
			CFG_FTRACE_BUF_SIZE : 0;
		__ftrace_buf_end = .;
	}

	/DISCARD/ : { *(.interp) }
}

