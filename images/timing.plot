set term postscript eps size 7,3
set yrange [0:500]
set xrange [4400:4450]
#set xtics 10
set xlabel "Time Slot Number"
set ylabel "Probe Time (cycles)"
set style line 1 lt 3 lw 1 lc "black"
set label "Threshold" center at 10,128
#set obj rect from 14.5,40 to 30.5,90  fs empty border rgb  "black"
plot \
  datafile using 1:2 title "Cache line B" with points pt 7 ps 0.8 lc rgb "#0000ff",\
  datafile using 1:3 title "Cache line D" with points pt 6 ps 0.8 lc rgb "#000000" ,\
  datafile using 1:4 title "Start Double" with points pt 2  lc rgb "#e07000", \
  datafile using 1:5 title "End Double" with points pt 1 lc rgb "#00c000", \
  120 notitle ls 1
