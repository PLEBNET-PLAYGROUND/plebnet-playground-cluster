SHELL := /bin/bash

PWD 									?= pwd_unknown

THIS_FILE								:= $(lastword $(MAKEFILE_LIST))
export THIS_FILE
TIME									:= $(shell date +%s)
export TIME

ARCH                                    :=$(shell uname -m)
export ARCH
ifeq ($(ARCH),x86_64)
ARCH                                    :=x86_64-linux-gnu
export ARCH
endif
ifeq ($(ARCH),arm64)
ARCH                                    :=aarch64-linux-gnu
export ARCH
endif

ifeq ($(user),)
HOST_USER								:= root
HOST_UID								:= $(strip $(if $(uid),$(uid),0))
else
HOST_USER								:=  $(strip $(if $(USER),$(USER),nodummy))
HOST_UID								:=  $(strip $(if $(shell id -u),$(shell id -u),4000))
endif
export HOST_USER
export HOST_UID

ifeq ($(target),)
SERVICE_TARGET							?= shell
else
SERVICE_TARGET							:= $(target)
endif
export SERVICE_TARGET

ifeq ($(docker),)
DOCKER							        := $(shell which docker)
else
DOCKER   							    := $(docker)
endif
export DOCKER

ifeq ($(compose),)
DOCKER_COMPOSE						    := $(shell which docker-compose)
else
DOCKER_COMPOSE							:= $(compose)
endif
export DOCKER_COMPOSE

PYTHON                                  := $(shell which python)
export PYTHON
PYTHON3                                 := $(shell which python3)
export PYTHON3

PIP                                     := $(shell which pip)
export PIP
PIP3                                    := $(shell which pip3)
export PIP3

# PROJECT_NAME defaults to name of the current directory.
ifeq ($(project),)
PROJECT_NAME							:= $(notdir $(PWD))
else
PROJECT_NAME							:= $(project)
endif
export PROJECT_NAME

#GIT CONFIG
GIT_USER_NAME							:= $(shell git config user.name)
export GIT_USER_NAME
GIT_USER_EMAIL							:= $(shell git config user.email)
export GIT_USER_EMAIL
GIT_SERVER								:= https://github.com
export GIT_SERVER

GIT_REPO_NAME							:= $(PROJECT_NAME)
export GIT_REPO_NAME

ifeq ($(profile),)
ifeq ($(GIT_REPO_ORIGIN),git@github.com:PLEBNET_PLAYGROUND/plebnet-playground-docker.dev.git)
GIT_PROFILE								:= PLEBNET-PLAYGROUND
endif
ifeq ($(GIT_REPO_ORIGIN),https://github.com/PLEBNET_PLAYGROUND/plebnet-playground-docker.dev.git)
GIT_PROFILE								:= PLEBNET-PLAYGROUND
endif
else
GIT_PROFILE								:= $(profile)
endif
export GIT_PROFILE

GIT_BRANCH								:= $(shell git rev-parse --abbrev-ref HEAD)
export GIT_BRANCH
GIT_HASH								:= $(shell git rev-parse --short HEAD)
export GIT_HASH
GIT_PREVIOUS_HASH						:= $(shell git rev-parse --short master@{1})
export GIT_PREVIOUS_HASH
GIT_REPO_ORIGIN							:= $(shell git remote get-url origin)
export GIT_REPO_ORIGIN
GIT_REPO_PATH							:= $(HOME)/$(GIT_REPO_NAME)
export GIT_REPO_PATH

ifneq ($(bitcoin-datadir),)
BITCOIN_DATA_DIR						:= $(bitcoin-datadir)
else
BITCOIN_DATA_DIR						:= $(HOME)/.bitcoin
endif
export BITCOIN_DATA_DIR

ifeq ($(nocache),true)
NOCACHE					     			:= --no-cache
else
NOCACHE						    		:=	
endif
export NOCACHE

ifeq ($(verbose),true)
VERBOSE									:= --verbose
else
VERBOSE									:=	
endif
export VERBOSE

#TODO more umbrel config testing
ifeq ($(port),)
PUBLIC_PORT								:= 80
else
PUBLIC_PORT								:= $(port)
endif
export PUBLIC_PORT

ifeq ($(nodeport),)
NODE_PORT								:= 8333
else
NODE_PORT								:= $(nodeport)
endif
export NODE_PORT

ifneq ($(passwd),)
PASSWORD								:= $(passwd)
else 
PASSWORD								:= changeme
endif
export PASSWORD

ifeq ($(cmd),)
CMD_ARGUMENTS							:= 	
else
CMD_ARGUMENTS							:= $(cmd)
endif
export CMD_ARGUMENTS

#ifeq ($(umbrel),true)
##comply with umbrel conventions
#PWD=/home/umbrel/umbrel/apps/$(PROJECT_NAME)
#UMBREL=true
#else
#pwd ?= pwd_unknown
#UMBREL=false
#endif
#export PWD
#export UMBREL
########################

PACKAGE_PREFIX                          := ghcr.io
export PACKAGE_PREFIX

.PHONY: help
help:
	@echo ''
	@echo '	[USAGE]: make [COMMAND] [EXTRA_ARGUMENTS]	'
	@echo ''
	@echo '		 make init'
	@echo '		 make install'
	@echo '		 make run'

.PHONY: report
report:
	@echo ''
	@echo '	[ARGUMENTS]	'
	@echo '      args:'
	@echo '        - HOME=${HOME}'
	@echo '        - PWD=${PWD}'
	@echo '        - PYTHON=${PYTHON}'
	@echo '        - PYTHON3=${PYTHON3}'
	@echo '        - PIP=${PIP}'
	@echo '        - PIP3=${PIP3}'
	@echo '        - UMBREL=${UMBREL}'
	@echo '        - THIS_FILE=${THIS_FILE}'
	@echo '        - TIME=${TIME}'
	@echo '        - PACKAGE_PREFIX=${PACKAGE_PREFIX}'
	@echo '        - ARCH=${ARCH}'
	@echo '        - HOST_USER=${HOST_USER}'
	@echo '        - HOST_UID=${HOST_UID}'
	@echo '        - PUBLIC_PORT=${PUBLIC_PORT}'
	@echo '        - NODE_PORT=${NODE_PORT}'
	@echo '        - SERVICE_TARGET=${SERVICE_TARGET}'
	@echo '        - PROJECT_NAME=${PROJECT_NAME}'
	@echo '        - DOCKER_BUILD_TYPE=${DOCKER_BUILD_TYPE}'
	@echo '        - DOCKER_COMPOSE=${DOCKER_COMPOSE}'
	@echo '        - GIT_USER_NAME=${GIT_USER_NAME}'
	@echo '        - GIT_USER_EMAIL=${GIT_USER_EMAIL}'
	@echo '        - GIT_SERVER=${GIT_SERVER}'
	@echo '        - GIT_PROFILE=${GIT_PROFILE}'
	@echo '        - GIT_BRANCH=${GIT_BRANCH}'
	@echo '        - GIT_HASH=${GIT_HASH}'
	@echo '        - GIT_PREVIOUS_HASH=${GIT_PREVIOUS_HASH}'
	@echo '        - GIT_REPO_ORIGIN=${GIT_REPO_ORIGIN}'
	@echo '        - GIT_REPO_NAME=${GIT_REPO_NAME}'
	@echo '        - GIT_REPO_PATH=${GIT_REPO_PATH}'
	@echo '        - BITCOIN_CONF=${BITCOIN_CONF}'
	@echo '        - BITCOIN_DATA_DIR=${BITCOIN_DATA_DIR}'
	@echo '        - STATOSHI_DATA_DIR=${STATOSHI_DATA_DIR}'
	@echo '        - NOCACHE=${NOCACHE}'
	@echo '        - VERBOSE=${VERBOSE}'
	@echo '        - PUBLIC_PORT=${PUBLIC_PORT}'
	@echo '        - NODE_PORT=${NODE_PORT}'
	@echo '        - PASSWORD=${PASSWORD}'
	@echo '        - CMD_ARGUMENTS=${CMD_ARGUMENTS}'

#######################
.PHONY: init
init: report
ifneq ($(shell id -u),0)
	@echo 'sudo make init #try if permissions issue'
endif
	@echo 'init'
	mkdir -p volumes/tor_datadir
	mkdir -p volumes/tor_servicesdir
	touch volumes/tor_datadir
	touch volumes/tor_servicesdir
ifneq ($(PIP3),)
	$(PIP3) install -r requirements.txt
else
	$(PIP) install -r requirements.txt
endif
#######################
.PHONY: install
install: init
	bash -c './up-generic.sh $(ARCH)'
#######################
.PHONY: uninstall
uninstall:
	bash -c './uninstall.sh $(ARCH)'
#######################
.PHONY: run
run: init
	$(DOCKER_COMPOSE) $(VERBOSE) $(NOCACHE) up --remove-orphans &
#######################
.PHONY: clean
clean:
	# remove created images
	@bash -c "echo $(PROJECT_NAME)"
	@$(DOCKER_COMPOSE) -p $(PROJECT_NAME) down --remove-orphans --rmi all 2>/dev/null \
	&& echo 'Image(s) for "$(PROJECT_NAME)" removed.' \
	|| echo 'Image(s) for "$(PROJECT_NAME)" already removed.'
#######################
.PHONY: prune
prune:
	@bash -c "echo $(PROJECT_NAME)"
	$(DOCKER_COMPOSE) -p $(PROJECT_NAME) down
	docker system prune -af
#######################
.PHONY: prune-network
prune-network:
	@bash -c "echo $(PROJECT_NAME)"
	$(DOCKER_COMPOSE) -p $(PROJECT_NAME) down
	docker network prune -f
#######################

