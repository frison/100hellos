# The purpose of this Makefile is to be included by the Makefiles in the language directories.
# It provides a common set of targets and variables for those Makefiles to use.

DIR_NAME :=$(shell realpath --relative-base=${CURDIR}/.. ${CURDIR})
ABSOLUTE_PARENT_DIR := $(shell realpath ${CURDIR}/..)
PARENT_DIR := $(shell realpath --relative-base=${ABSOLUTE_PARENT_DIR}/.. ${ABSOLUTE_PARENT_DIR})
TAG_PATH_ROOT := 100hellos
PUBLISHED_CONTAINERS = $(shell find ${ABSOLUTE_PARENT_DIR} -maxdepth 2 -type f -name "Dockerfile" -exec dirname "{}" \; | sort | grep -v '[0-9]\{3\}-.*')
PUBLISHED_SUBDIRS = $(notdir ${PUBLISHED_CONTAINERS})

PROJECT_RELATIVE_DIR :=$(shell realpath --relative-base=${COMPOSITE_DOCKERFILE_DIR} ${CURDIR})
ESCAPED_PROJECT_RELATIVE_DIR := $(shell echo ${PROJECT_RELATIVE_DIR} | sed 's/\//\\\//g')


# Phony targets are targets that don't reference files; they are just commands -- some just happened to be named after
# subdirectories.
.PHONY: build clean composite-dockerfile ${DIR_NAME} ${PARENT_DIR} $(PUBLISHED_SUBDIRS) base

# This only matters for building and running the containers on ARM64 machines,
# that causes all sorts of problems with the nasm-x86_64 container.
DOCKER_BUILD_ARGS :=
ifdef IS_X86
	DOCKER_BUILD_ARGS := ${DOCKER_BUILD_ARGS} --platform=linux/amd64
endif

DOCKER_RUN_ARGS := --rm
ifdef IS_MOUNT
	DOCKER_RUN_ARGS := ${DOCKER_RUN_ARGS} -v "${CURDIR}/files":/hello-world
endif

DOCKER_BUILD = @${CURDIR}/../.utils/build_image.sh ${DIR_NAME}
DOCKER_RUN = @docker run ${DOCKER_RUN_ARGS} ${TAG_PATH_ROOT}/${DIR_NAME}:local
DOCKER_RUN_INTERACTIVE = @docker run ${DOCKER_RUN_ARGS} -it --entrypoint="" ${TAG_PATH_ROOT}/${DIR_NAME}:local zsh
DOCKER_CLEAN = @docker rmi --force ${TAG_PATH_ROOT}/${DIR_NAME}:local || true

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
	$(DOCKER_CLEAN)

# Transforms `FROM ([^/]*)` to `FROM (.*) AS $IMAGE_TO_BUILD`
#   These are images that do not have a "/" in them, because they're not the target
#   image we want to build or any local image.
# Transforms 100hellos/... to o100hellos_... (multistage build names can't start with numbers).
# Transforms `FROM [:image directory:]/[:tag directory:]:local (.*)` to `FROM [:image directory:]_[:tag directory:] (.*)`
# Transforms `COPY ./(.*) (.*)` to `COPY ./${ESCAPED_PROJECT_RELATIVE_DIR}/(.*) (.*)`
# Transforms `COPY --chown=(..) ./(.*) (.*)` to `COPY ./${ESCAPED_PROJECT_RELATIVE_DIR}/(.*) (.*)`
composite-dockerfile:
	@echo \
		"\n##########################################################" \
		"\n# This file is generated by the Makefile. Do not edit it." \
		"\n##########################################################\n" \
		>> $${COMPOSITE_DOCKERFILE_DIR}/$${COMPOSITE_DOCKERFILE}
	@echo \
		"\n# Generated by Makefile for ${TAG_PATH_ROOT}/${DIR_NAME}\n" \
		>> $${COMPOSITE_DOCKERFILE_DIR}/$${COMPOSITE_DOCKERFILE}
	@cat Dockerfile |\
		sed "s/FROM \([^ ]*\)$$/FROM \1 AS o${TAG_PATH_ROOT}_${DIR_NAME}/" |\
		sed "s/FROM \(.*\)\/\(.*\):local \(.*\)$$/FROM o\1_\2 \3/"\ |\
		sed "s/COPY\(.*\)\.\/\(.*\) \(.*\)$$/COPY \1\.\/${ESCAPED_PROJECT_RELATIVE_DIR}\/\2 \3/" \
		>> $${COMPOSITE_DOCKERFILE_DIR}/$${COMPOSITE_DOCKERFILE}
