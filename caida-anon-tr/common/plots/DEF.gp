set terminal pdfcairo enhanced font "Clear Sans, 22" linewidth 2 rounded dashed

set key bottom right
set key samplen 4 spacing 1

set style line 80 lc rgb "#202020" lt 1 lw 1
# Border: 3 (X & Y axes)
set border 3 back ls 80

set style line 81 lc rgb "#808080" lt 1 lw 0.50 dt 3
set style line 82 lc rgb "#999999" lt 1 lw 0.25 dt 3
set grid ytics mytics xtics mxtics back ls 81, ls 82

# Based on colorbrewer2.org's Set1 palette.
set style line  1  lt 1 lc rgb "#e41a1c" lw 2.0 dt 1
set style line 10  lt 1 lc rgb "#e41a1c" lw 0.9 dt 1
set style line 11  lt 1 lc rgb "#e41a1c" lw 1.5 dt 3
set style line 12  lt 1 lc rgb "#e41a1c" lw 1.5 dt 2
set style line  2  lt 1 lc rgb "#377eb8" lw 2.0 dt 1
set style line 20  lt 1 lc rgb "#377eb8" lw 0.9 dt 1
set style line 21  lt 1 lc rgb "#377eb8" lw 1.5 dt 3
set style line 22  lt 1 lc rgb "#377eb8" lw 1.5 dt 2
set style line 30  lt 1 lc rgb "#4daf4a" lw 1.0 dt 1
set style line 31  lt 1 lc rgb "#4daf4a" lw 1.0 dt 3
set style line 32  lt 1 lc rgb "#4daf4a" lw 1.0 dt 2
set style line 40  lt 1 lc rgb "#984ea3" lw 1.0 dt 1
set style line 41  lt 1 lc rgb "#984ea3" lw 1.0 dt 3
set style line 42  lt 1 lc rgb "#984ea3" lw 1.0 dt 2
set style line 50  lt 1 lc rgb "#ff7f00" lw 1.0 dt 1
set style line 51  lt 1 lc rgb "#ff7f00" lw 1.0 dt 3
set style line  6  lt 1 lc rgb "#a65628" lw 1.0
set style line  9  lt 1 lc rgb "#202020" lw 1.0


set style line 91 lc rgb "#808080" lw 0.9 dt 1
set style line 92 lc rgb "#999999" lw 1.5 dt 3

set tics in
set xtics border in scale 1,0.5 nomirror norotate autojustify
set ytics border in scale 1,0.5 nomirror norotate autojustify

set xlabel offset 0,0.4
set ylabel offset 0.4,0
