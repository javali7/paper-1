PROJ=JCEN
SRCS=JCEN.tex
FIGS=memory.fig temporal.fig 
PLOTS=missing.plot timing.plot positions.plot

#SUBDIRS=images


PDF=$(PROJ).pdf
PS=$(PROJ).ps
DVI=$(PROJ).dvi
BIB=$(PROJ).bbl


PDFS=${FIGS:.fig=.pdf} ${PLOTS:.plot=.pdf}
EPSS=${FIGS:.fig=.eps} ${PLOTS:.plot=.eps}

BAKS=${FIGS:.fig=.fig.bak}


FIG2DEV=fig2dev

PDFLATEX=TEXINPUTS=${TEXINPUTS} pdflatex $(LATEXEXTRAARGS) $(LATEXARG)
LATEX=TEXINPUTS=${TEXINPUTS} latex $(LATEXEXTRAARGS) $(LATEXARG)
BIBTEX_MINCROSSREFS=1000
BIBTEX=BIBINPUTS=${TEXINPUTS} BSTINPUTS=${TEXINPUTS} bibtex -min-crossrefs=${BIBTEX_MINCROSSREFS}


LATEXARG='\input'


RERUN = "(Package natbib Warning|There were undefined references|Rerun to get (cross-references|the bars) right)"
RUNBIB = "No file.*\.bbl|Citation.*undefined"


COPY = if test -r $*.toc; then cp $*.toc $*.toc.bak; fi
RM = /bin/rm -f


.SUFFIXES: .pdf .tex .dvi .aux .bbl .ps  .fig .eps .plot .dat

default:: pdf

pdf::subdirs ${PDF}

dvi::subdirs ${DVI}

ps: dvi ${PS} ${EPSS}

${PS}: ${EPSS}

${PDF}: ${SRCS}

${PDF}: ${PDFS}

.tex.pdf:
	${COPY}; ${PDFLATEX} $<
	egrep -c $(RUNBIB) $*.log && (${BIBTEX} ${<:.tex=} ; ${COPY}; ${PDFLATEX} $<);true
	egrep $(RERUN) $*.log && (${COPY}; ${PDFLATEX} $<); true
	egrep $(RERUN) $*.log && (${COPY}; ${PDFLATEX} $<); true
	test -r $*.toc.bak && ( cmp -s $*.toc $*.toc.bak || ${PDFLATEX} $< ); true
	${RM} $*.toc.bak
	egrep -i "(Reference|Citation).*undefined" $*.log ; true


.tex.dvi:
	${COPY}; ${LATEX} $<
	egrep -c $(RUNBIB) $*.log && (${BIBTEX} ${<:.tex=} ; ${COPY}; ${LATEX} $<);true
	egrep $(RERUN) $*.log && (${COPY}; ${LATEX} $<); true
	egrep $(RERUN) $*.log && (${COPY}; ${LATEX} $<); true
	test -r $*.toc.bak && ( cmp -s $*.toc $*.toc.bak || ${LATEX} $< ); true
	${RM} $*.toc.bak
	egrep -i "(Reference|Citation).*undefined" $*.log ; true

.dvi.ps:
	dvips -P pdf -t letter -o $*.ps $<

${PDF}: ${BIBFILE}

${DVI}: ${BIBFILE}

clean:: subclean localclean

new::localclean

localclean:
	${RM} *~ ${SRCS:.tex=.lof} ${SRCS:.tex=.lot} ${SRCS:.tex=.loa} ${SRCS:.tex=.lod} ${SRCS:.tex=.toc} ${SRCS:.tex=.log} ${SRCS:.tex=.aux} ${SRCS:.tex=.dvi} ${SRCS:.tex=.pdf} ${SRCS:.tex=.blg} ${SRCS:.tex=.bbl} ${SRCS:.tex=.ps} texput.log ${PDFS} ${EPSS} ${BAKS}

subclean:
	if [ "$(SUBDIRS)" != "" ]; then  for f in $(SUBDIRS); do  $(MAKE) -C $$f clean; done; fi

subdirs:
	if [ "$(SUBDIRS)" != "" ]; then  for f in $(SUBDIRS); do  $(MAKE) -C $$f ; done; fi

count:
	@files=""; for ext in tex bbl; do if [ -f ${PROJ}.$$ext ]; then files="$$files ${PROJ}.$$ext"; fi; done; echo Files: $$files; echo -n "Word count: ";untex -a -uascii -i -e $$files | tr -C 'a-zA-Z' ' ' | sed 's/ [a-zA-Z]/ /g'| wc -w

wc: count




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

