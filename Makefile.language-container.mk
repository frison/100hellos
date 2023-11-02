# The purpose of this Makefile is to be included by the Makefiles in the language directories.
# It provides a common set of targets and variables for those Makefiles to use.

DIR_NAME :=$(shell realpath --relative-base=${CURDIR}/.. ${CURDIR})
ABSOLUTE_PARENT_DIR := $(shell realpath ${CURDIR}/..)
PARENT_DIR := $(shell realpath --relative-base=${ABSOLUTE_PARENT_DIR}/.. ${ABSOLUTE_PARENT_DIR})
TAG_PATH_ROOT := 100hellos
PUBLISHED_CONTAINERS = $(shell find ${ABSOLUTE_PARENT_DIR} -maxdepth 2 -type f -name "Dockerfile" -exec dirname "{}" \; | sort | grep -v '[0-9]\{3\}-.*')
PUBLISHED_SUBDIRS = $(notdir ${PUBLISHED_CONTAINERS})

# Phony targets are targets that don't reference files; they are just commands -- some just happened to be named after
# subdirectories.
.PHONY: build clean upstream ${DIR_NAME} ${PARENT_DIR} $(PUBLISHED_SUBDIRS) leaf-target base

DOCKER_BUILD_ARGS :=
ifdef IS_X86
	DOCKER_BUILD_ARGS := ${DOCKER_BUILD_ARGS} --platform=linux/amd64
endif

DOCKER_BUILD = docker build $(DOCKER_BUILD_ARGS) . --tag ${TAG_PATH_ROOT}/${DIR_NAME}:local
DOCKER_RUN = @docker run --rm ${TAG_PATH_ROOT}/${DIR_NAME}:local
DOCKER_RUN_INTERACTIVE = @docker run --rm -it --entrypoint="" ${TAG_PATH_ROOT}/${DIR_NAME}:local zsh

# Long story short, this allows:
# make [lang] RUN=1 and
# make [lang] INTERACTIVE=1
#
# To work on both the language containers, and the base containers in
# the way you would expect.
build: build-image
ifneq ($(and $(IS_BASE_TARGET),$(IS_BASE_MAKE),$(IS_INTERACTIVE)),)
	$(DOCKER_RUN_INTERACTIVE)
endif
ifneq ($(and $(IS_BASE_TARGET),$(IS_BASE_MAKE),$(IS_RUN)),)
	$(DOCKER_RUN)
endif
ifneq ($(and $(IS_LANG_TARGET),$(IS_LANG_MAKE),$(IS_INTERACTIVE)),)
	$(DOCKER_RUN_INTERACTIVE)
endif
ifneq ($(and $(IS_LANG_TARGET),$(IS_LANG_MAKE),$(IS_RUN)),)
	$(DOCKER_RUN)
endif

build-image:
	$(DOCKER_BUILD)

test: build-image
	@docker run --rm ${TAG_PATH_ROOT}/${DIR_NAME}:local


${DIR_NAME}: build
${PARENT_DIR}: build
$(PUBLISHED_SUBDIRS): build
base: build

clean:
	@docker rmi --force ${TAG_PATH_ROOT}/$${DIR_NAME}:local || true
