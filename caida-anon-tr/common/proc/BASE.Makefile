MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(patsubst %/,%,$(dir $(MKFILE_PATH)))

# Data set base directory.
DS_BASE_DIR := $(MKFILE_DIR)/../../../../static00/caida-anon-tr

# Utilities.
BIN_DIR := $(MKFILE_DIR)/../bin

R := Rscript


# Parse the pcap file.
conn.log: $(SRC)
	@zeek -r $<


# Retrive the headers into a format file.
format.txt: conn.log
	@head $<           | \
		grep '#fields' | \
		tr '\t' '\n'   | \
		tail +2        | \
		awk '{print NR, $$0}' > $@


# Retrieve inter-arrival times of TCP flows.
# (NOTE: Arrival times are calculated with reference to the first flow.)
# Drop connections with no data transfers (i.e., resp_bytes of zero or null).
inter-arr-tcp.txt: conn.log
	@zeek-cut ts proto resp_bytes orig_bytes < $< | \
		awk '(int($$3) > 0) || (int($$4) > 0)'    | \
		awk '$$2 ~ /^tcp$$/ {print $$1}'          | \
		sort -n                                   | \
		awk 'BEGIN{OFMT="%.3f"}  \
			 NR==1{ts=$$1; next} \
			 {print ($$1-ts)*1000.0; ts=$$1}' > $@

# Retrieve inter-arrival times of UDP flows.
# (NOTE: Arrival times are calculated with reference to the first flow.)
# Drop connections with no data transfers (i.e., resp_bytes of zero or null).
inter-arr-udp.txt: conn.log
	@zeek-cut ts proto resp_bytes orig_bytes < $< | \
		awk '(int($$3) > 0) || (int($$4) > 0)'    | \
		awk '$$2 ~ /^udp$$/ {print $$1}'          | \
		sort -n                                   | \
		awk 'BEGIN{OFMT="%.3f"}  \
			 NR==1{ts=$$1; next} \
			 {print ($$1-ts)*1000.0; ts=$$1}' > $@


# Compute the CDF of the inter-arrival times.
inter-arr-%-cdf.txt: inter-arr-%.txt
	@$(R) $(BIN_DIR)/ecdf.R -i $< -o $@


# Retrieve sizes of of TCP flows.
sz-tcp.txt: conn.log
	@zeek-cut proto resp_bytes < $< | \
		awk '($$1 ~ /^tcp$$/) && (int($$2) > 0) {print $$2}' > $@

# Count the number of TCP flows with zero size.
num-zero-tcp.txt: conn.log
	@zeek-cut proto resp_bytes < $<               | \
		awk '($$1 ~ /^tcp$$/) && (int($$2) == 0)' | \
		$(BIN_DIR)/count.awk > $@

# Retrieve sizes of of UDP flows.
sz-udp.txt: conn.log
	@zeek-cut proto resp_bytes < $< | \
		awk '($$1 ~ /^udp$$/) && (int($$2) > 0) {print $$2}' > $@

# Count the number of TCP flows with zero size.
num-zero-udp.txt: conn.log
	@zeek-cut proto resp_bytes < $<               | \
		awk '($$1 ~ /^udp$$/) && (int($$2) == 0)' | \
		$(BIN_DIR)/count.awk > $@


# Compute the CDF of the flow sizes.
sz-%-cdf.txt: sz-%.txt
	@$(R) $(BIN_DIR)/ecdf.R -i $< -o $@


# Calculate the total number of flows in the file.
num-flows.txt: conn.log
	@zeek-cut proto < $< | \
		$(BIN_DIR)/count.awk > $@

# Calculate the total number of TCP flows in the file.
num-tcp-flows.txt: conn.log
	@zeek-cut proto < $< | \
		grep '^tcp$$'    | \
		$(BIN_DIR)/count.awk > $@

# Calculate the total number of UDP flows in the file.
num-udp-flows.txt: conn.log
	@zeek-cut proto < $< | \
		grep '^udp$$'    | \
		$(BIN_DIR)/count.awk > $@
