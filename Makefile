##
# Usage:
# `make [lang]` -- Build an image named `100hellos/[lang]:local` from the `[lang]` directory.
#                  This image has everything you need to build and run hello-world programs in that language.
#
# Parameters:
#   - `RUN=1` (or `R=1`)         -- Will build the image, and then (maybe build) and run the code.
#   - `INTERACTIVE=1` (or `I=1`) -- Try it, poke around!
# Note: It is assumed there are no dependencies between the non-base containers.

DIR_NAME := $(notdir ${CURDIR})
BASE_CONTAINERS = $(shell find ${CURDIR} -maxdepth 2 -type f -name "Dockerfile" -exec dirname "{}" \; | sort | grep '.*[0-9]\{3\}-.*')
LANG_CONTAINERS = $(shell find ${CURDIR} -maxdepth 2 -type f -name "Dockerfile" -exec dirname "{}" \; | sort | grep -v '[0-9]\{3\}-.*')
IMAGE_PREFIX = ${DIR_NAME}
BASE_SUBDIRS = $(notdir ${BASE_CONTAINERS})
LANG_SUBDIRS = $(notdir ${LANG_CONTAINERS})
NEW_FOLDER := template\ -\ $(shell date +%Y-%m-%d)
NEW_COMMAND = @cp -r template $(NEW_FOLDER)
ADDITIONAL_OPTIONS :=

ifeq ($(filter $(LANG_SUBDIRS), $(MAKECMDGOALS)),)
	ADDITIONAL_OPTIONS := IS_BASE_TARGET=1
endif

ifeq ($(filter $(BASE_SUBDIRS), $(MAKECMDGOALS)),)
	ADDITIONAL_OPTIONS := IS_LANG_TARGET=1
endif

ifdef INTERACTIVE
	ADDITIONAL_OPTIONS := ${ADDITIONAL_OPTIONS} IS_INTERACTIVE=1
else ifdef I
	ADDITIONAL_OPTIONS := ${ADDITIONAL_OPTIONS} IS_INTERACTIVE=1
endif

ifdef RUN
	ADDITIONAL_OPTIONS := ${ADDITIONAL_OPTIONS} IS_RUN=1
else ifdef R
	ADDITIONAL_OPTIONS := ${ADDITIONAL_OPTIONS} IS_RUN=1
endif

# Host folder mounting introduces all sorts of permission issues if you're not careful
# so be prepared to chown/chmod the files in the host folder.
ifdef MOUNT
	ADDITIONAL_OPTIONS := ${ADDITIONAL_OPTIONS} IS_MOUNT=1
else ifdef M
	ADDITIONAL_OPTIONS := ${ADDITIONAL_OPTIONS} IS_MOUNT=1
endif

ifeq ($(filter $(LANG_SUBDIRS), $(MAKECMDGOALS)),)
	ADDITIONAL_OPTIONS := ${ADDITIONAL_OPTIONS} IS_BASE_TARGET=1
endif

ifneq (,$(findstring x86_64,$(MAKECMDGOALS)))
	ADDITIONAL_OPTIONS := ${ADDITIONAL_OPTIONS} IS_X86=1
endif

ifdef LANG
	NEW_FOLDER = ${LANG}
endif

# Phony targets are targets that don't reference files; they are just commands -- some just happened to be named after
# subdirectories.
.PHONY: build clean base new clean-composite-dockerfile composite-dockerfile $(BASE_SUBDIRS) $(LANG_SUBDIRS)

$(DIR_NAME): build
build: $(BASE_SUBDIRS) $(LANG_SUBDIRS)

# Clean in reverse-order to minimize forced image deletions because of dependent images.
clean: $(LANG_SUBDIRS) $(BASE_SUBDIRS)

base: $(BASE_SUBDIRS)

$(BASE_SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS} -f ${CURDIR}/Makefile.language-container.mk $(ADDITIONAL_OPTIONS) \
		IS_BASE_MAKE=1 \
		COMPOSITE_DOCKERFILE_DIR=${CURDIR} \
		COMPOSITE_DOCKERFILE=Dockerfile.composite


$(LANG_SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS} -f ${CURDIR}/Makefile.language-container.mk $(ADDITIONAL_OPTIONS) \
		IS_LANG_MAKE=1 \
		COMPOSITE_DOCKERFILE_DIR=${CURDIR} \
		COMPOSITE_DOCKERFILE=Dockerfile.composite

test: $(LANG_SUBDIRS)

new:
	$(NEW_COMMAND)

clean-composite-dockerfile:
	rm -f Dockerfile.composite

# This generates a Dockerfile that has every language and base container  in it (for all languages) in
# a way for the multi-stage build to optimally build the images.
composite-dockerfile: clean-composite-dockerfile $(LANG_SUBDIRS)
