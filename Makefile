include .nvim/Makefile.nvim.mk


.PHONY: clean

all: clean install

clean::
	$(info '************************** CLEAN **************************')
	$(info)

install::
	$(info '************************** INSTALL **************************')
