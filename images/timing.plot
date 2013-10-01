set term postscript eps size 7,3
set yrange [0:500]
set xrange [1:50]
set xtics out nomirror
set ytics out nomirror
#set xtics 10
set xlabel "Time Slot Number"
set ylabel "Probe Time (cycles)"
set label "Set Bits" at 24,140 center
set arrow from 23.5,130 to 20.3,74
set arrow from 24.5,130 to 27.7,74
set label "Clear Bits" at 24,190 center
set arrow from 23.5,180 to 13.3,74
set arrow from 24.5,180 to 34.7,74
set label "A Missed Bit" at 42,140 center
set arrow from 42,130 to 42,74

set style line 1 lt 3 lw 1 lc "black"
set label "Threshold" center at 3,128
set style fill solid 1  noborder
#set obj rect from 14.5,40 to 30.5,90  fs empty border rgb  "black"
plot \
  datafile using 1:2 title "Cache line B" with points pt 7 ps 0.8 lc rgb "#0000ff",\
  datafile using 1:3 title "Cache line D" with points pt 6 ps 0.8 lc rgb "#000000" ,\
  datafile using 1:4 title "Start Double" with points pt 2  lc rgb "#e07000", \
  datafile using 1:5 title "End Double" with points pt 1 lc rgb "#00c000", \
  datafile using ($1+0.5):7 title "Add" with boxes lc rgb "#d0d0ff",\
  datafile using ($1+0.5):6 title "Double" with boxes lc rgb "#ffc0c0",\
  120 notitle ls 1
