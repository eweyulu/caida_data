# Import BASE Makefile.
include ../../common/proc/BASE.Makefile

# Go one-level up to find the name of the directory which corresponds to the
# trace file.
#
# Example:
# /path/to/project/directory/... ... .../2019-0117-1300-A/proc
# We are interested in extracting "2019-0117-1300-A".
#
CUR_DIR := $(notdir $(patsubst %/,%,$(dir $(abspath $(shell pwd)))))
# Path to directory containing actual trace file.
TR_DIR := $(DS_BASE_DIR)/$(CUR_DIR)/tr
# Trace file used for the analyses.
SRC = $(TR_DIR)/equinix-nyc.dirB.20190117-130000.UTC.anon.pcap

ALL := conn.log           \
	format.txt            \
	inter-arr-tcp.txt     \
	inter-arr-udp.txt     \
	inter-arr-tcp-cdf.txt \
	inter-arr-udp-cdf.txt \
	sz-tcp.txt            \
	sz-udp.txt            \
	sz-tcp-cdf.txt        \
	sz-udp-cdf.txt        \
	num-zero-tcp.txt      \
	num-zero-udp.txt      \
	num-flows.txt         \
	num-tcp-flows.txt     \
	num-udp-flows.txt


.PHONY: all mostlyclean clean

all: $(ALL)

mostlyclean:
	@rm -f $(ALL)

clean: mostlyclean
	@rm -f *.log
