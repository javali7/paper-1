FIGS=memory.fig temporal.fig 
PLOTS=missing.plot timing.plot positions.plot

PDFS=${FIGS:.fig=.pdf} ${PLOTS:.plot=.pdf}
EPSS=${FIGS:.fig=.eps} ${PLOTS:.plot=.eps}

BAKS=${FIGS:.fig=.fig.bak}


FIG2DEV=fig2dev

.SUFFIXES: .pdf .fig .eps .plot .dat

default:$(PDFS) $(EPSS) $(EXTRA)

.fig.pdf:
	fig2dev -L pdf -p xx $< $@

.fig.eps:
	fig2dev -L eps $< $@

.plot.eps:
	gnuplot -e 'datafile="${<:.plot=.dat}"' $< > $@

.dat.plot:
	touch $@

.eps.pdf:
	epstopdf $<

clean:
	${RM} *~ ${PDFS} ${EPSS} ${BAKS}
