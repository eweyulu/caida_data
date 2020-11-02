MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(patsubst %/,%,$(dir $(MKFILE_PATH)))

# Default settings for gnuplot.
DEF_PLOT := $(MKFILE_DIR)/DEF.gp
