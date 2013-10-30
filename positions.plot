set term postscript eps size 5,3
set xrange [1:570]
set yrange [0:20]
set style data histogram
set style histogram cluster gap 1
set boxwidth 0.9
set style fill solid 0.5 border -1
set xlabel "Bit Position"
set ylabel "Percent Missing"
set style line 1 lw 2 
plot datafile  using ($1-10):2 with lines ls 1 lc rgb "#3030ff" notitle, \
	datafile using ($1-10):2 with points pt 2 lc rgb "#ff3030" notitle

