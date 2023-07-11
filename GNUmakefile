SHELL := /bin/bash

PWD 									?= pwd_unknown

THIS_FILE								:= $(lastword $(MAKEFILE_LIST))
export THIS_FILE
TIME									:= $(shell date +%s)
export TIME

OS                                      :=$(shell uname -s)
export OS
ARCH                                    :=$(shell uname -m)
export ARCH
ifeq ($(ARCH),x86_64)
TRIPLET                                 :=x86_64-linux-gnu
export TRIPLET
endif
ifeq ($(ARCH),arm64)
TRIPLET                                 :=aarch64-linux-gnu
export TRIPLET
endif
#available services:
#	bitcoind
#	lnd
#	tor
#	thunderhub
#	rtl
#	notebook
#	dashboard
#	lndg
#	docs
ifeq ($(services),)
services                                :=bitcoind,lnd,cln,rtl,thunderhub,docs
else
services                                :=$(services)
endif
export services
ifeq ($(user),)
HOST_USER								:= root
HOST_UID								:= $(strip $(if $(uid),$(uid),0))
else
HOST_USER								:=  $(strip $(if $(user),$(user),nodummy))
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
ifeq ($(reset),true)
RESET:=true
else
RESET:=false
endif
export RESET

PYTHON                                  := $(shell which python)
export PYTHON
PYTHON2                                 := $(shell which python2)
export PYTHON2
PYTHON3                                 := $(shell which python3)
export PYTHON3

PIP                                     := $(shell which pip)
export PIP
PIP2                                    := $(shell which pip2)
export PIP2
PIP3                                    := $(shell which pip3)
export PIP3

PYTHON_VENV                             := $(shell python -c "import sys; sys.stdout.write('1') if hasattr(sys, 'base_prefix') else sys.stdout.write('0')")
PYTHON3_VENV                            := $(shell python3 -c "import sys; sys.stdout.write('1') if hasattr(sys, 'real_prefix') else sys.stdout.write('0')")

python_version_full := $(wordlist 2,4,$(subst ., ,$(shell python3 --version 2>&1)))
python_version_major := $(word 1,${python_version_full})
python_version_minor := $(word 2,${python_version_full})
python_version_patch := $(word 3,${python_version_full})

my_cmd.python.3 := $(PYTHON3) some_script.py3
my_cmd := ${my_cmd.python.${python_version_major}}

PYTHON_VERSION                         := ${python_version_major}.${python_version_minor}.${python_version_patch}
PYTHON_VERSION_MAJOR                   := ${python_version_major}
PYTHON_VERSION_MINOR                   := ${python_version_minor}

export python_version_major
export python_version_minor
export python_version_patch
export PYTHON_VERSION

#PROJECT_NAME defaults to name of the current directory.
ifeq ($(project),)
PROJECT_NAME							:= $(notdir $(PWD))
else
PROJECT_NAME							:= $(project)
endif
export PROJECT_NAME

ifeq ($(tag),)
TAG                                     :=$(shell git tag --sort=committerdate | grep -E '^v[0-9]' | tail -1)
#TAG                                     :=$(shell git describe --tags `git rev-list --tags --max-count=1`)
else
TAG                                     :=v$(tag)
endif
export TAG

#GIT CONFIG
GIT_USER_NAME							:= $(shell git config user.name)
export GIT_USER_NAME
GIT_USER_NAME                           := $(shell echo $(GIT_USER_NAME) | tr '[:upper:]' '[:lower:]' | sed 's/@//')
export GIT_USER_NAME
GIT_USER_EMAIL							:= $(shell git config user.email)
export GIT_USER_EMAIL
GIT_SERVER								:= https://github.com
export GIT_SERVER

GIT_REPO_NAME							:= $(PROJECT_NAME)
export GIT_REPO_NAME

#Usage
#note on ~/GH_TOKEN.txt file below for package publishing
#profile=plebnet-playground make report
#profile=plebnet-playground make package-all
#test:
#profile=PLEBNET-PLAYGROUND make report
ifeq ($(profile), PLEBNET-PLAYGROUND)
#github push needs to be all lower case
profile                                 := $(shell echo $(profile) | tr '[:upper:]' '[:lower:]' | sed 's/@//')
export profile
endif
ifeq ($(profile),plebnet-playground)
#we point to the PLEBNET-PLAYGROUND organization on github.com
GIT_PROFILE                             := $(profile)
#ssh access url
GIT_REPO_ORIGIN                         := git@github.com/$(GIT_PROFILE)/$(PROJECT_NAME).git
else
#GIT_PROFILE equals GIT_USER_NAME detected by the make file above
GIT_PROFILE                             := $(GIT_USER_NAME)
endif
export GIT_PROFILE
export GIT_REPO_ORIGIN

GIT_BRANCH								:= $(shell git rev-parse --abbrev-ref HEAD)
export GIT_BRANCH
GIT_HASH								:= $(shell git rev-parse --short HEAD)
export GIT_HASH
GIT_PREVIOUS_HASH						:= $(shell git rev-parse --short HEAD^1)
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
#Force parallel build when --no-cache to speed up build
PARALLEL                                := --parallel
else
NOCACHE						    		:=
PARALLEL                                :=
endif
ifeq ($(parallel),true)
PARALLEL                                := --parallel
endif
ifeq ($(para),true)
PARALLEL                                := --parallel
endif
export NOCACHE
export PARALLEL

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
.PHONY: - all
-:
	#NOTE: 2 hashes are detected as 1st column output with color
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?##/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	#$(MAKE) run

version:
#get the most recent
	#@TAG=$(shell git tag --sort=committerdate | grep -E '^v[0-9]' | tail -1)
	#@TAG=$(shell git describe --tags `git rev-list --tags --max-count=1`)
	#@export TAG
	@echo $(TAG)

.PHONY: help
help:## 	print verbose help
	@echo 'make [COMMAND] [EXTRA_ARGUMENTS]	'
	@echo ''
	#@echo ''
	@echo 'make '
	@echo '	 make all                        install and run playground and cluster'
	@echo '	 make help                       print help'
	@echo '	 make report                     print environment variables'
	@echo '	 make initialize                 install dependencies - ubuntu/macOS'
	@echo '	 make init                       initialize basic dependencies'
	@echo '	 make build'
	@echo '	 make build para=true            parallelized build'
	@echo '	 make install'
	@echo '	 make run'
	@echo '	                                 basic=true - services=bitcoind,lnd,docs,tor'
	@echo '	                                 cluster=[true || remove]'
	@echo '	                                 relay=[true || remove]'
	@echo '	                                 services=bitcoind,lnd,lndg,rtl,thunderhub,docs,tor,dashboard,notebook'
	@echo '	                                 nocache=true'
	@echo '	                                 verbose=true'
	@echo ''
	@echo '	[NOSTR SERVICES]:	'
	@echo '	 make nostr-rs-relay              build & run a nostr relay'
	@echo '	 make nostr-rs-relay-build'
	@echo '	 make nostr-rs-relay-run'
	@echo ''
	@echo '	[DEV ENVIRONMENT]:	'
	@echo '	 make install-cluster'
	@echo ''
#	@echo '	 make shell            compiling environment on host machine'
	@echo '	 make signin profile=gh-user     ~/GH_TOKEN.txt required from github.com'
#	@echo '	 make header package-header'
	@echo '	 make build'
#	@echo '	 make build package-statoshi'
	@echo ''
	@echo '	 make package-all'
	@echo '	 profile=plebnet-playground make report'
	@echo '	 profile=plebnet-playground make package-all'
	@echo '	 profile=plebnet-playground make package-lnd'
	@echo '	 profile=plebnet-playground make package-tor'
	@echo '	 profile=plebnet-playground make package-docs'
	@echo '	 profile=plebnet-playground make package-bitcoind'
	@echo ''
	@echo '	 make install-python38-sh'
	@echo '	 make install-python39-sh'
	@echo ''
#	@echo '	[EXTRA_ARGUMENTS]:	set build variables	'
#	@echo ''
#	@echo '	nocache=true'
#	@echo '	            	add --no-cache to docker command and apk add $(NOCACHE)'
#	@echo '	port=integer'
#	@echo '	            	set PUBLIC_PORT default 80'
#	@echo ''
#	@echo '	nodeport=integer'
#	@echo '	            	set NODE_PORT default 8333'
#	@echo ''
#	@echo '	            	TODO'
#	@echo ''
#	@echo '	[DOCKER COMMANDS]:	push a command to the container	'
#	@echo ''
#	@echo '	cmd=command 	'
#	@echo '	cmd="command"	'
#	@echo '	             	send CMD_ARGUMENTS to the [TARGET]'
	@echo ''
	@echo '	[EXAMPLES]:'
	@echo ''
	@echo '	make run nocache=true verbose=true'
	@echo ''
	@echo '	make init && play help'
	@echo ''
	@sed -n 's/^# //p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/# /'
	@sed -n 's/^## //p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/## /'
	@sed -n 's/^### //p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/### /'

.PHONY: report
report:## 	print environment arguments
	@echo ''
	@echo '	[ARGUMENTS]	'
	@echo '      args:'
	@echo '        - PROJECT_NAME=${PROJECT_NAME}'
	@echo '        - TAG=${TAG}'
	@echo '        - HOME=${HOME}'
	@echo '        - PWD=${PWD}'
	@echo '        - PYTHON=${PYTHON}'
	# @echo '        - PYTHON2=${PYTHON2}'
	@echo '        - PYTHON3=${PYTHON3}'
	@echo '        - PYTHON_VERSION=${PYTHON_VERSION}'
	@echo '        - PYTHON_VERSION_MAJOR=${PYTHON_VERSION_MAJOR}'
	@echo '        - PYTHON_VERSION_MINOR=${PYTHON_VERSION_MINOR}'
	@echo '        - PIP=${PIP}'
	# @echo '        - PIP2=${PIP2}'
	@echo '        - PIP3=${PIP3}'
	@echo '        - PYTHON_VENV=${PYTHON_VENV}'
#	@echo '        - PYTHON3_VENV=${PYTHON3_VENV}'
	# @echo '        - UMBREL=${UMBREL}'
	# @echo '        - THIS_FILE=${THIS_FILE}'
	@echo '        - TIME=${TIME}'
	@echo '        - PACKAGE_PREFIX=${PACKAGE_PREFIX}'
	@echo '        - ARCH=${ARCH}'
	@echo '        - TRIPLET=${TRIPLET}'
	@echo '        - services=${services}'
	@echo '        - HOST_USER=${HOST_USER}'
	@echo '        - HOST_UID=${HOST_UID}'
	@echo '        - PUBLIC_PORT=${PUBLIC_PORT}'
	@echo '        - NODE_PORT=${NODE_PORT}'
	# @echo '        - SERVICE_TARGET=${SERVICE_TARGET}'
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
	@echo '        - NOCACHE=${NOCACHE}'
	# @echo '        - VERBOSE=${VERBOSE}'
	# @echo '        - PASSWORD=${PASSWORD}'
	# @echo '        - CMD_ARGUMENTS=${CMD_ARGUMENTS}'

#######################

ORIGIN_DIR:=$(PWD)
MACOS_TARGET_DIR:=/var/root/$(PROJECT_NAME)
LINUX_TARGET_DIR:=/root/$(PROJECT_NAME)
export ORIGIN_DIR
export TARGET_DIR

.ONESHELL:
all:venv prune-cluster## 	all
	@./up-generic.sh 

.PHONY: venv
venv:## 	create python3 virtualenv .venv
	test -d .venv || $(PYTHON3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; pip install -q -r requirements.txt; \
	   python3 -m pip install -q omegaconf \
	   pip install -q --upgrade pip; \
	);
	@echo "To activate (venv)"
	@echo "try:"
	@echo ". .venv/bin/activate"
	@echo "or:"
	@echo "make test-venv"
##:	test-venv            source .venv/bin/activate; pip install -r requirements.txt;
test-venv:## 	test virutalenv .venv
	# insert test commands here
	test -d .venv || $(PYTHON3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; pip install -q -r requirements.txt; \
	   python3 -m pip install -q omegaconf \
	   pip install -q --upgrade pip; \
	);
.PHONY: init setup
.SILENT:
setup: init venv## 	basic setup
init:submodules venv docker-pull

ifneq ($(shell id -u),0)
	@echo
	@echo $(shell id -u -n) 'not root'
	@echo
endif

	git config --global --add safe.directory $(PWD)
	@mkdir -p volumes
	@mkdir -p cluster/volumes
	@chown -R $(shell id -u) *                 || echo

	@install -v -m=o+rwx $(PWD)/scripts/*  /usr/local/bin
	@install -v -m=o+rwx $(PWD)/bitcoin-signet/*notify  /usr/local/bin
	@install -v -m=o+rwx $(PWD)/getcoins.py  /usr/local/bin/play-getcoins

	#$(PYTHON3) -m pip install -q --upgrade pip 2>/dev/null
	$(PYTHON3) -m pip install -q omegaconf 2>/dev/null
	$(PYTHON3) -m pip install -q -r requirements.txt 2>/dev/null
	# pushd docs 2>/dev/null && $(PYTHON3) -m pip install -q -r requirements.txt && popd  2>/dev/null
	$(PYTHON3) plebnet_generate.py TRIPLET=$(TRIPLET) services=$(SERVICES)

	#pushd scripts 2>/dev/null; for string in *; do sudo chmod -R o+rwx /usr/local/bin/$$string; done; popd  2>/dev/null || echo

#######################
.ONESHELL:
docker-start:
## docker-start
	@touch requirements.txt && $(PYTHON3) -m pip install -q -r requirements.txt
	@test -d .venv || $(PYTHON3) -m virtualenv .venv
	@( \
	   source .venv/bin/activate; $(PYTHON3) -m pip install -q -r requirements.txt; \
	   $(PYTHON3) -m pip install -q --upgrade pip; \
	);
	( \
	    while ! docker system info > /dev/null 2>&1; do\
	    echo 'Waiting for docker to start...';\
	    if [[ '$(OS)' == 'Linux' ]]; then\
	    type -P apt && apt install docker*;\
	    type -P systemctl && systemctl restart docker.service || type -P service && service docker.service restart || type -P apk &&  apk add openrc docker && rc-service docker restart || echo "try installing docker manually...";\
	    fi;\
	    if [[ '$(OS)' == 'Darwin' ]]; then\
	     open --background -a /Applications/Docker.app/Contents/MacOS/Docker;\
	    fi;\
	sleep 1;\
	done\
	)

.ONESHELL:
cluster:venv## 	create playground-cluster

ifeq ($(cluster),remove)
	$(MAKE) prune-cluster
else
	test -d .venv || $(PYTHON3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; pip install -q -r requirements.txt; \
	   $(PYTHON#) -m pip install -q omegaconf; \
	   pushd cluster && ./up-generic.sh bitcoind=5 lnd=0 && popd; \
	);
endif
	@docker ps | grep cluster || echo
#######################
.PHONY: run
run:## 	docker-compose up -d
	$(DOCKER_COMPOSE) $(VERBOSE) $(NOCACHE) up -d
#######################
.PHONY: build
build: init
	docker pull  shahanafarooqui/rtl:0.11.0
	$(DOCKER_COMPOSE) $(VERBOSE) build --pull $(PARALLEL) --no-rm $(NOCACHE)
submodules:## 	git submodule update --init --recursive
	@git submodule update --init --recursive
prune-cluster:## 	remove plebnet-playground-cluster network
	$(DOCKER_COMPOSE) -p plebnet-playground-cluster down --remove-orphans 2>/dev/null || echo
	docker network rm plebnet-playground-cluster*                         2>/dev/null || echo
