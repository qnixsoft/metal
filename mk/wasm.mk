ARCH=wasm32
TARGET=${ARCH}-unknown-unknown

METAL_V ?= 0.0.4-alpha

INSTALL ?= install
srcdir?=.

DESTDIR ?= /
PREFIX ?= ${DESTDIR}usr/local

INSTALL_MKDIR ?= ${METAL_PATH}/mk
INSTALL_BINDIR ?= ${METAL_PATH}/bin
INSTALL_LIBDIR ?= ${METAL_PATH}/lib
INSTALL_INCDIR ?= ${METAL_PATH}/include

LLVM_ROOT:=/usr/local
CC:=${LLVM_ROOT}/bin/clang
CFLAGS += --sysroot ${METAL_PATH} --target=${TARGET}
LD_CFLAGS += -fuse-ld=${LD} -Wl,--allow-undefined-file=${METAL_PATH}/lib/wasm.syms,--export-dynamic

LD:=${LLVM_ROOT}/bin/wasm-ld
LINK.c := ${CC} ${CFLAGS} ${LD_CFLAGS} -resource-dir=${METAL_PATH}

AR=llvm-ar
RANLIB=llvm-ranlib
prefix=
exec_prefix=${prefix}
CROSS-COMPILE=llvm-
metal-flags-y := --enable-reference-types
wasm2js-flags-y := -Oz ${metal-flags-y} --enable-mutable-globals
WASM2JS = wasm2js ${wasm2js-flags-y}

.SUFFIXES: .wasm .js
.wasm.js:
	${WASM2JS} $< > $@

# deprecated:
# .SUFFIXES: .wasm .wat .wasm2 .js
# .wasm.wat:
# 	${WASM2WAT} $< > $@
# .wat.wasm2:
# 	${WAT2WASM} $< > $@
# .wasm2.js:
# 	${WASM2JS} $< > $@
