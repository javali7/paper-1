set term postscript eps size 5,3
set xrange [9:35]
set style data histogram
set style histogram cluster gap 1
set boxwidth 0.9
set style fill solid 0.5 border -1
set xlabel "Missing Bits"
set ylabel "Samples"
plot 'missing.dat' using 2:1:(1) with boxes lc rgb "#3030ff"  notitle

