.DEFAULT_GOAL := help

MAKESTER__REPO_NAME := loum
MAKESTER__PROJECT_NAME := sbt

SBT_VERSION := 1.5.3
ALPINE_DOCKER_VERSION := 20210212

# Tagging convention used: <sbt-version>-<image-release-number>
MAKESTER__VERSION = $(ALPINE_DOCKER_VERSION)-$(SBT_VERSION)
MAKESTER__RELEASE_NUMBER = 1

include makester/makefiles/makester.mk
include makester/makefiles/docker.mk

OPENJDK_VERSION := 8
OPENJDK_LONG_VERSION := $(OPENJDK_VERSION).292.10-r0
MAKESTER__BUILD_COMMAND = $(DOCKER) build\
 --no-cache\
 --build-arg ALPINE_DOCKER_VERSION=$(ALPINE_DOCKER_VERSION)\
 --build-arg OPENJDK_LONG_VERSION=$(OPENJDK_LONG_VERSION)\
 --build-arg SBT_VERSION=$(SBT_VERSION)\
 -t $(MAKESTER__IMAGE_TAG_ALIAS) .

MAKESTER__RUN_COMMAND := $(DOCKER) run --rm -ti\
 $(MAKESTER__SERVICE_NAME):$(HASH)

sbt: HOST_IVY2_WORKING_DIR := $(HOME)/.ivy2
sbt:
	@mkdir -pv $(HOST_IVY2_WORKING_DIR)
	@$(DOCKER) run --rm -ti\
 -v $(HOST_IVY2_WORKING_DIR):/home/sbt/.ivy2\
 -v sbtvol:/home/sbt/.sbt\
 -v cachevol:/home/sbt/.cache\
 --mount type=bind,source=$(PWD),target=/app\
 -e COURSIER_CACHE=/home/sbt/.cache/coursier\
 $(MAKESTER__SERVICE_NAME):$(HASH)\
 $(CMD) || true

sbt-help: CMD = help
sbt-version: CMD = about
sbt-console: CMD = console
sbt-help sbt-version sbt-console: sbt

docker-login:
	-@$(DOCKER) login $(MAKESTER__REPO_NAME)

help: makester-help docker-help
	@echo "(Makefile)\n\
  sbt                  Run sbt REPL with host cached files\n\
  sbt CMD=<cmd>        Run sbt subcommand as per \"CMD\"\n\
  sbt-help             Display the sbt help messge\n\
  sbt-version          Display basic information about sbt and the build\n\
  sbt-console          Starts the Scala interpreter with the project classes on the classpath\n\
  docker-login         Log into Docker container registry "$(MAKESTER__REPO_NAME)"\n"

.PHONY: help
