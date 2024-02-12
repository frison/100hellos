PREFIX ?= /usr/local

.PHONY: install

ARCH := $(shell cat /etc/apk/arch)

ARCH_MAPPING_x86_64 := x64
ARCH_MAPPING_aarch64 := arm64
ARCH_MAPPING_armv7 := arm
ARCH_MAPPING_riscv64 := riscv64
ARCH_MAPPING_x86 := ia32

SDK_ARCH := $(ARCH_MAPPING_$(ARCH))

BASEURL := https://github.com/dart-musl/dart/releases/download/3.2.6/
SDK_URL := $(BASEURL)dartsdk-linux-$(SDK_ARCH)-release.tar.gz

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter
# or compiler in the path.
install:
	@wget -O- $(SDK_URL) | tar -xz
	@sudo mv dart-sdk/ /usr/lib/dart
