# Makefile for the newfile command-line utility

.DEFAULT_GOAL := help

ROOT_UID := $(shell id -u)
ifeq ($(ROOT_UID),0)
  PREFIX ?= /usr/local
else
  PREFIX ?= $(HOME)/.local
endif

BINDIR ?= $(PREFIX)/bin
PROGRAM := newfile
SOURCE := ./newfile
TARGET := $(BINDIR)/$(PROGRAM)

.PHONY: help install uninstall check

help:
	@printf '%s\n' \
	  'newfile - available make targets' \
	  '' \
	  '  make install    Install newfile (and configure PATH if needed)' \
	  '  make uninstall  Remove the installed command' \
	  '  make check      Check shell syntax' \
	  '  make help       Show this help'

install: check
	@PREFIX="$(PREFIX)" BINDIR="$(BINDIR)" sh ./install.sh

uninstall:
	@rm -f "$(TARGET)"
	@echo "Removed $(TARGET)"

check:
	@command -v sh >/dev/null 2>&1 || { echo 'Error: POSIX sh is required.' >&2; exit 1; }
	@sh -n "$(SOURCE)"
	@echo 'Shell syntax check passed.'