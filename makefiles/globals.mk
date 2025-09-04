SHELL := /bin/bash
PWD := $(shell pwd)

INFRA := $(PWD)/infra
AGENT := $(PWD)/agent

GATEWAY_IP ?= 127.0.0.10
dir ?= $(INFRA)