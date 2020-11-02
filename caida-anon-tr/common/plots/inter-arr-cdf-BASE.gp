load DEF_PLOT

set output OUT_FILE

set xlabel "Inter-arrival time (in ms)"
set ylabel "CDF"

X_MIN=0.01
X_MAX=1000
set logscale x
set xrange [X_MIN:X_MAX]
set mxtics 10

set yrange [0:1]
set ytics 0,0.2
set mytics 2

# Substitute a negligible value in place of zeros.
fix_zeros(f)=sprintf("<cat %s | awk '$1==0{$1=0.001} {print $0}'", f)

plot TCP_FILE u 1:2 t 'TCP' w l ls 1, \
     UDP_FILE u 1:2 t 'UDP' w l ls 2
