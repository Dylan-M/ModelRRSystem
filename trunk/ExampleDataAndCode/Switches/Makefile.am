SUBDIRS = 
CODEFILES = SR4_MRD2_Switch.tcl SR4_C4TSR4_Switch.tcl C4TSMINI_Switch.tcl \
		TB_Switch.tcl
FIGURES = switch-SR4-MRD2.png switch-SR4-MRD2-thumb.png \
          switch-SR4-C4TSR4.png switch-SR4-C4TSR4-thumb.png \
          switch-C4TSMINI.png switch-C4TSMINI-thumb.png \
          switch-CTITB.png switch-CTITB-thumb.png
OTHERFILES = switch-SR4-MRD2.xtc switch-SR4-MRD2.pdf \
             switch-SR4-C4TSR4.xtc switch-SR4-C4TSR4.pdf \
             switch-C4TSMINI.xtc switch-C4TSMINI.pdf \
             switch-CTITB.xtc
EXTRA_DIST = $(OTHERFILES) $(CODEFILES) $(FIGURES) Doxyfile.in main.h \
		navbar.html
pkgdatadir = $(datadir)/$(PACKAGE)/ExampleDataAndCode/Switches

noinst_DATA = html/index.html
pkgdata_DATA =  latex/refman.pdf pkgIndex.tcl
CLEANFILES = pkgIndex.tcl *.tag navheader.html 
TCLKIT = $(top_builddir)/BuildData/tclkit${BEXEEXT}

html/index.html latex/refman.pdf : Doxyfile main.h $(CODEFILES) $(FIGURES) \
	$(top_builddir)/Doc/doxygen/tcldoxyfilter.sh
	-rm -rf latex/ html/
	-rm -f header0.html navheader.html
	touch navheader.html
	$(DOXYGEN) -w html header0.html /dev/null doxygen.css  Doxyfile
	rm doxygen.css
	cat header0.html $(srcdir)/navbar.html > navheader.html
	rm header0.html
	-chmod +x $(top_builddir)/Doc/doxygen/tcldoxyfilter.sh
	$(DOXYGEN) Doxyfile
	for p in $(FIGURES); do \
	  if test ! \( -f html/$$p \); then cp $(srcdir)/$$p html/; fi; \
	done
	$(MAKE) -C latex pdf
	

$(top_builddir)/Doc/doxygen/tcldoxyfilter.sh : $(top_builddir)/Doc/doxygen/tcldoxyfilter.sh.in
	$(MAKE) -C $(top_builddir)/Doc/doxygen tcldoxyfilter.sh

clean-local:
	-rm -rf latex/ html/

install-data-hook: $(CODEFILES) $(OTHERFILES) html/index.html
	$(INSTALL) -d $(DESTDIR)$(pkgdatadir)
	for p in $(CODEFILES) $(OTHERFILES); do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  f=`echo $$p | sed -e 's|^.*/||'`; \
	  echo " $(INSTALL_DATA) '$$d$$p' '$(DESTDIR)$(pkgdatadir)/$$f'"; \
	  $(INSTALL_DATA) "$$d$$p" "$(DESTDIR)$(pkgdatadir)/$$f"; \
	done
	$(INSTALL) -d $(DESTDIR)$(pkgdatadir)/html
	for p in html/*; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  f=`echo $$p | sed -e 's|^.*/||'`; \
	  echo " $(INSTALL_DATA) '$$d$$p' '$(DESTDIR)$(pkgdatadir)/$(USERMANHBase)$$f'"; \
	  $(INSTALL_DATA) "$$d$$p" "$(DESTDIR)$(pkgdatadir)/html/$$f"; \
	done
	
uninstall-hook: 
	for p in $(DESTDIR)$(pkgdatadir)/*; do \
	  f=`echo $$p | sed -e 's|^.*/||'`; \
	  echo " rm -rf '$(DESTDIR)$(pkgdatadir)/$$f'"; \
	  rm -rf "$(DESTDIR)$(pkgdatadir)/$$f"; \
	done                                                         

pkgIndex.tcl : $(CODEFILES)
	for f in $(notdir $^) ; do \
	  if test -f "./$$f"; then continue; else ln -s $(srcdir)/$$f ./; fi;\
	done
	echo "pkg_mkIndex . $(notdir $^)" | $(TCLKIT)
