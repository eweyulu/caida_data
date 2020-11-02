# Import BASE Makefile.
BASE_DIR := ../../common/plots

# Import BASE Makefile.
include $(BASE_DIR)/BASE.Makefile

DATA_DIR := ../proc

ALL := inter-arr-cdf.pdf


.PHONY: all clean

all: $(ALL)

clean:
	@rm -f $(ALL)


# Plot the inter-arrival times of TCP and UDP flows.
inter-arr-cdf.pdf: $(DEF_PLOT)        \
	$(BASE_DIR)/inter-arr-cdf-BASE.gp \
	inter-arr-cdf.gp                  \
	$(DATA_DIR)/inter-arr-tcp-cdf.txt \
	$(DATA_DIR)/inter-arr-udp-cdf.txt
	@gnuplot                           \
		-e "TCP_FILE='$(word 4, $^)'"  \
		-e "UDP_FILE='$(word 5, $^)'"  \
		-e "OUT_FILE='$@'"             \
		-e "DEF_PLOT='$(word 1, $^)'"  \
		-e "BASE_PLOT='$(word 2, $^)'" \
		$(word 3, $^)
