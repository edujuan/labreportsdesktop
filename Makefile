.PHONY: help

# Script description and usage through `make` or `make help` commands
help:
	@echo "Let's make something good"
	@flutter --version

-include tool/makefile/pub.mk tool/makefile/test.mk tool/makefile/setup.mk