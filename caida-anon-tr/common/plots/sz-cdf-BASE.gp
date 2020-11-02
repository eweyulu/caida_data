load DEF_PLOT

set output OUT_FILE

set xlabel "Size (in bytes)"
set ylabel "CDF"

X_MIN=1
X_MAX=1e6
set xrange [X_MIN:X_MAX]
set logscale x
set format x "%T"
set xtics add ("1" 1, "10" 10, "100" 100, "1K" 1e3, "10K" 1e4, "100K" 1e5, "1M" 1e6)
set mxtics 10

set yrange [0:1]
set ytics 0,0.2
set mytics 2

plot TCP_FILE u 1:2 t 'TCP' w l ls 1, \
     UDP_FILE u 1:2 t 'UDP' w l ls 2
