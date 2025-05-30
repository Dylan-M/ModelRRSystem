#* 
#* ------------------------------------------------------------------
#* Makefile.am - Automake file
#* Created by Robert Heller on Mon Dec 19 16:35:07 2005
#* ------------------------------------------------------------------
#* Modification History: $Log$
#* Modification History: Revision 1.14  2007/10/22 17:17:27  heller
#* Modification History: 10222007
#* Modification History:
#* Modification History: Revision 1.13  2007/04/19 17:23:22  heller
#* Modification History: April 19 Lock Down
#* Modification History:
#* Modification History: Revision 1.12  2007/02/21 20:19:29  heller
#* Modification History: SWIG Hackery
#* Modification History:
#* Modification History: Revision 1.11  2007/02/02 03:30:21  heller
#* Modification History: Lock down for 2.1.7
#* Modification History:
#* Modification History: Revision 1.10  2007/02/02 03:27:16  heller
#* Modification History: Lock down for 2.1.7
#* Modification History:
#* Modification History: Revision 1.9  2007/02/02 03:21:12  heller
#* Modification History: Lock down for 2.1.7
#* Modification History:
#* Modification History: Revision 1.7  2007/02/02 02:37:16  heller
#* Modification History: Lock down for 2.1.7
#* Modification History:
#* Modification History: Revision 1.6  2007/02/02 01:51:01  heller
#* Modification History: Lock down for 2.1.7
#* Modification History:
#* Modification History: Revision 1.5  2007/02/01 20:00:52  heller
#* Modification History: Lock down for Release 2.1.7
#* Modification History:
#* Modification History: Revision 1.4  2007/01/08 19:05:54  heller
#* Modification History: Jan 8, 2007 Lockdown
#* Modification History:
#* Modification History: Revision 1.3  2006/05/22 19:38:06  heller
#* Modification History: Release 2.1.4 Final
#* Modification History:
#* Modification History: Revision 1.2  2006/05/16 19:27:45  heller
#* Modification History: May162006 Lockdown
#* Modification History:
#* Modification History: Revision 1.1  2006/01/03 15:30:21  heller
#* Modification History: Lockdown
#* Modification History:
#* Modification History: Revision 1.1  2002/07/28 14:03:50  heller
#* Modification History: Add it copyright notice headers
#* Modification History:
#* ------------------------------------------------------------------
#* Contents:
#* ------------------------------------------------------------------
#*  
#*     Model RR System, Version 2
#*     Copyright (C) 1994,1995,2002-2005  Robert Heller D/B/A Deepwoods Software
#* 			51 Locke Hill Road
#* 			Wendell, MA 01379-9728
#* 
#*     This program is free software; you can redistribute it and/or modify
#*     it under the terms of the GNU General Public License as published by
#*     the Free Software Foundation; either version 2 of the License, or
#*     (at your option) any later version.
#* 
#*     This program is distributed in the hope that it will be useful,
#*     but WITHOUT ANY WARRANTY; without even the implied warranty of
#*     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#*     GNU General Public License for more details.
#* 
#*     You should have received a copy of the GNU General Public License
#*     along with this program; if not, write to the Free Software
#*     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#* 
#*  
#* 

AUTOMAKE_OPTIONS = subdir-objects

pkgincludedir = $(includedir)/$(PACKAGE)/TTSupport

pkginclude_HEADERS = Common.h TimeTableSystem.h PathName.h Station.h Cab.h \
	Train.h
lib_LTLIBRARIES = libttclasses.la
AM_CPPFLAGS = -I$(top_builddir) -I. -I$(TCL_INC_DIR)
nodist_libttclasses_la_SOURCES  = TTClasses_wrap.cc ../gettext.c
libttclasses_la_SOURCES = TimeTableSystem.cc PathName.cc Station.cc Train.cc \
		Cab.cc CreateLaTeXTimetable.cc $(pkginclude_HEADERS) ../gettext.h
libttclasses_la_XGETTEXTFILES = $(libttclasses_la_SOURCES)
libttclasses_la_CXXFLAGS = -DUSE_TCL_STUBS $(AM_CPPFLAGS) -Wall $(KIT_EXTRA_CFLAGS)
if CROSSCOMPILING
libttclasses_la_LDFLAGS = -no-undefined -g -avoid-version $(TCL_STUB_LIB_SPEC) 
else
libttclasses_la_LDFLAGS = -g -version-info 0:0:0 $(TCL_STUB_LIB_SPEC)
endif
libttclasses_la_LIBADD = $(INTLLIBS) $(TCL_STUB_LIB_SPEC)
noinst_SCRIPTS = pkgIndex.tcl
noinst_DATA = TTClasses.potlist
BUILT_SOURCES = TTClasses_wrap.cc TTSupportGroup.h
EXTRA_DIST = TTSupportGroup.h.in TTClasses.i TimeTableSystemTcl.h
CLEANFILES = pkgIndex.tcl $(BUILT_SOURCES) TTClasses.potlist
SWIG_FLAGS =  -tcl8 $(AM_CPPFLAGS)

TTClasses_wrap.cc : TTClasses.i $(pkginclude_HEADERS) TimeTableSystemTcl.h \
		$(top_builddir)/config.status
	$(SWIG_CXX) $(SWIG_FLAGS) -o TTClasses_wrap.cc $(srcdir)/TTClasses.i

pkgIndex.tcl: libttclasses.la $(top_builddir)/config.status
	echo 'package ifneeded Ttclasses $(TTCLASSES_VERSIONLIB) [list load [file join $$dir libttclasses[info sharedlibextension]]]' > pkgIndex.tcl

TTClasses.potlist: $(libttclasses_la_XGETTEXTFILES)
	echo $(addprefix $(subdir)/,$(libttclasses_la_XGETTEXTFILES)) |\
	tr ' ' '\n' > TTClasses.potlist

install-exec-hook: libttclasses.la pkgIndex.tcl
	$(INSTALL) -d $(DESTDIR)$(pkglibdir)
if CROSSCOMPILING
	cp    $(DESTDIR)$(bindir)/libttclasses$(SHLIB_SUFFIX) $(DESTDIR)$(pkglibdir)/libttclasses$(SHLIB_SUFFIX)
else
	ln -fs $(libdir)/libttclasses$(SHLIB_SUFFIX) $(DESTDIR)$(pkglibdir)/libttclasses$(SHLIB_SUFFIX)
endif
	touch $(DESTDIR)$(pkglibdir)/pkgIndex.tcl
	cat   pkgIndex.tcl >>$(DESTDIR)$(pkglibdir)/pkgIndex.tcl
	$(INSTALL_DATA) pkgIndex.tcl $(DESTDIR)$(pkglibdir)/pkgIndex_ttclasses.tcl

TTSupportGroup.h: TTSupportGroup.h.in $(top_builddir)/config.status
	sed -e 's|=TTCLASSES_VERSIONLIB=|@TTCLASSES_VERSIONLIB@|g' \
	< $(srcdir)/TTSupportGroup.h.in > ./TTSupportGroup.h
