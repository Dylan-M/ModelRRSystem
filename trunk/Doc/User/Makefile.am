#* 
#* ------------------------------------------------------------------
#* Makefile.am - User Doc Makefile
#* Created by Robert Heller on Fri Nov  4 13:43:37 2005
#* ------------------------------------------------------------------
#* Modification History: $Log$
#* Modification History: Revision 1.7  2007/05/06 15:15:26  heller
#* Modification History: Lock down  for 2.1.8 release candidate 1
#* Modification History:
#* Modification History: Revision 1.6  2007/05/06 14:23:39  heller
#* Modification History: Lock down  for 2.1.8 release candidate 1
#* Modification History:
#* Modification History: Revision 1.5  2007/05/06 12:49:40  heller
#* Modification History: Lock down  for 2.1.8 release candidate 1
#* Modification History:
#* Modification History: Revision 1.4  2007/02/01 20:58:49  heller
#* Modification History: Lock down for Release 2.1.7
#* Modification History:
#* Modification History: Revision 1.3  2007/01/08 19:05:55  heller
#* Modification History: Jan 8, 2007 Lockdown
#* Modification History:
#* Modification History: Revision 1.2  2006/01/03 15:30:21  heller
#* Modification History: Lockdown
#* Modification History:
#* Modification History: Revision 1.1  2005/11/04 19:06:35  heller
#* Modification History: Nov 4, 2005 Lockdown
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

SUFFIXES	= .tcl .sty

USERMAN_AZATRAX_PROG_PART = AzatraxProgReference.h
AZATRAX_PROG_HS = AzatraxProg.h AzatraxProgReference.h
AZATRAX_PROG = AzatraxProg
AZATRAX_PROGHBase = AzatraxProg
AZATRAX_PROG_HTML = $(AZATRAX_PROGHBase)/index.html
USERMAN_AZATRAX_PROG_FIGS = Azatrax_MRDTestGUI.png Azatrax_MRDSensorLoop.png \
                            Azatrax_SR4TestGUI.png \
                            Azatrax_SR4TestGUISmall.png \
                            Azatrax_SL2TestGUI.png \
                            Azatrax_SL2TestGUISmall.png \
                            Azatrax_AzatraxDeviceMapGUI.png \
                            Azatrax_AzatraxDeviceMapGUISmall.png
                            
DOXYFILES = Doxyfile.$(AZATRAX_PROG).in

USERMAN_UNIVERSALTEST_PART = UniversalTestReference.h
UNIVERSALTEST_HS = UniversalTest.h UniversalTestReference.h
UNIVERSALTEST = UniversalTest
UNIVERSALTESTHBase = UniversalTest
UNIVERSALTEST_HTML = $(UNIVERSALTESTHBase)/index.html
USERMAN_UNIVERSALTEST_FIGS = UTMain.png UTNewCard.png UTOutputTest.png \
		UTWrapAround.png UTOutputTestSmall.png
DOXYFILES += Doxyfile.$(UNIVERSALTEST).in

USERMAN_OPENLCB_PART = OpenLCBReference.h OpenLCBDaemons.h \
		OfflineLCCNodeEditor.h LayoutControlDatabase.h
OPENLCB_HS = OpenLCB.h OpenLCBReference.h OpenLCBDaemons.h \
		OfflineLCCNodeEditor.h LayoutControlDatabase.h
OPENLCB = OpenLCB
OPENLCBHBase = OpenLCB
OPENLCB_HTML = $(OPENLCBHBase)/index.html
USERMAN_OPENLCB_FIGS = OpenLCB_CANGCUSB_Options.png OpenLCB_CDITool.png \
        OpenLCB_MainWindow.png OpenLCB_MainWindow_OpenTrees.png \
        OpenLCB_MemoryConfigOpts.png OpenLCB_ReadWriteConfigMemory.png \
        OpenLCB_SelectTransport.png OpenLCB_ReadWriteConfigMemory_Small.png \
        OpenLCB_CDITool_Small.png  OpenLCB_SendEvent.png \
        OpenLCB_EventReceived.png

DOXYFILES += Doxyfile.$(OPENLCB).in

USERMAN_CMRISLAVE_PART = 
CMRISLAVE_HS = #CMRI_Slave.h
CMRISLAVE = CMRI_Slave
CMRISLAVEHBase = CMRI_Slave
CMRISLAVE_HTML = $(CMRISLAVEHBase)/index.html
USERMAN_CMRISLAVE_FIGS = 

DOXYFILES += Doxyfile.$(CMRISLAVE).in

USERMAN_XPRESSNETTHROTTLE_PART = XPressNetThrottleReference.h
XPRESSNETTHROTTLE_HS = XPressNetThrottle.h  XPressNetThrottleReference.h
XPRESSNETTHROTTLE = XPressNetThrottle
XPRESSNETTHROTTLEHBase = XPressNetThrottle
XPRESSNETTHROTTLE_HTML = $(XPRESSNETTHROTTLEHBase)/index.html
USERMAN_XPRESSNETTHROTTLE_FIGS = XPressNetThrottle_maingui.png \
                                 XPressNetThrottle_mainguiSmall.png \
                                 XPressNetThrottle_openport.png \
                                 XPressNetThrottle_progmode.png \
                                 XPressNetThrottle_progmodeSmall.png
DOXYFILES += Doxyfile.$(XPRESSNETTHROTTLE).in

USERMAN_GENERICTHROTTLE_PART = GenericThrottleReference.h
GENERICTHROTTLE_HS = GenericThrottle.h  GenericThrottleReference.h
GENERICTHROTTLE = GenericThrottle
GENERICTHROTTLEHBase = GenericThrottle
GENERICTHROTTLE_HTML = $(GENERICTHROTTLEHBase)/index.html
USERMAN_GENERICTHROTTLE_FIGS = GenericThrottle_maingui.png \
                               GenericThrottle_mainguiSmall.png \
                               GenericThrottle_progmode.png \
                               GenericThrottle_progmodeSmall.png
DOXYFILES += Doxyfile.$(GENERICTHROTTLE).in

USERMAN_TIMETABLE_PART =  TTTutorial.h TTReference.h
TIMETABLE_HS = TimeTable.h TTTutorial.h TTReference.h
TIMETABLE = TimeTable
TIMETABLEHBase = TimeTable
TIMETABLE_HTML = $(TIMETABLEHBase)/index.html
USERMAN_TIMETABLE_FIGS = TTaddtrain.png TTprintTool.png TTNewTool.png \
	TTMainGUIBlank.png TTMainGUIToolBar.png TTMainGUIButtonMenu.png \
	TTCreateNewTT.png TTCreateAllStations.png TTCreateAllCabs.png \
	TTChart3station.png TTOpenTool.png TTSaveTool.png \
	TTCreateNewTrain1.png  TTCreateNewTrain2.png  TTCreateNewTrain3.png \
	TTdeletetrain.png TTsetdupstation.png TTcleardupstation.png \
	TTaddstorage.png TTaddcab.png TTcreatenote.png TTeditnote_.png \
	TTEditNote.png TTAddNote.png TTaddnotetotrainatstation.png \
	TTaddnotetotrain.png TTremovenotefromtrainatstation.png \
	TTremovenotefromtrain.png TTPrintTimetableDialog.png \
	TTPrintConfigurationDialog1.png TTPrintConfigurationDialog2.png \
	TTPrintConfigurationDialog3.png TTCloseTool.png TTSelectOneTrain.png \
	TTMainGUIBlankSmall.png TTMainGUIToolBarSmall.png \
	TTChart3stationSmall.png TTCreateNewTrain2Small.png \
	TTEditNoteSmall.png TTPrintTimetableDialogSmall.png \
	TTPrintConfigurationDialog1Small.png \
	TTPrintConfigurationDialog2Small.png \
	TTPrintConfigurationDialog3Small.png
DOXYFILES += Doxyfile.$(TIMETABLE).in

USERMAN_FCF_PART = FCFTutorial.h FCFReference.h
FCF_HS = FCF.h FCFTutorial.h FCFReference.h
FCF = FCF
FCFHBase = FCF
FCF_HTML = $(FCFHBase)/index.html
USERMAN_FCF_FIGS = FCFMain.png FCFMainButtonMenu.png FCFMainIndicators.png \
	FCFMainToolbar.png FCFLoadTool.png FCFLoadCarsTool.png \
	FCFSaveCarsTool.png FCFManageTrainsTool.png FCFViewCarTool.png \
	FCFViewCarInd.png FCFEditCarInd.png   FCFEditCarTool.png \
	FCFAddCarTool.png FCFDeleteCarTool.png FCFShowUACarsTool.png \
	FCFRunCarATool.png FCFRunAllTrTool.png FCFRunBTrTool.png \
	FCFRunTrInd.png  FCFPrinterInd.png FCFRun1TrTool.png \
	FCFOpenPrinterTool.png FCFClosePrinterTool.png FCFPrintYardTool.png \
	FCFShowCarsTool.png FCFReportsTool.png FCFResetStatsTool.png \
	FCFCloseTool.png FCFManageTrainsMenu.png FCFControlYardLDialog.png  \
	FCFManage1TrainDialog.png FCFViewCarSlideout.png \
	FCFEditCarSlideout.png FCFTrainStatusSlideout.png  \
	FCFOpenPrinterDialog.png FCFShowCarsMenu.png FCFSelectATrainDialog.png \
	FCFSelectACarDialog.png FCFReportsMenu.png FCFMainSmall.png \
	FCFMainToolbarSmall.png
DOXYFILES += Doxyfile.$(FCF).in

USERMAN_EI_PART = EITutorial.h EIReference.h
EI_HS = EI.h EITutorial.h EIReference.h
EI = EI
EIHBase = EI
EI_HTML = $(EIHBase)/index.html
USERMAN_EI_FIGS = 
DOXYFILES += Doxyfile.$(EI).in

USERMAN_LINUXGPIO_PART = LinuxGpioTutorial.h LinuxGpioReference.h 
LINUXGPIO_HS = LinuxGpio.h LinuxGpioTutorial.h LinuxGpioReference.h
LINUXGPIO = LinuxGpio
LINUXGPIOHBase = LinuxGpio
LINUXGPIO_HTML = $(LINUXGPIOHBase)/index.html
USERMAN_LINUXGPIO_FIGS = 
DOXYFILES += Doxyfile.$(LINUXGPIO).in

USERMAN_CALC_PART = ResistorManual.h LocoPullManual.h
CALC_HS = Calc.h ResistorManual.h LocoPullManual.h
CALC = Calc
CALCHBase = Calc
CALC_HTML = $(CALCHBase)/index.html
USERMAN_CALC_FIGS = RestMain.png RestMainSmall.png LocoPullMain.png
DOXYFILES += Doxyfile.$(CALC).in

USERMAN_CAMERA_PART = CameraManual.h
CAMERA_HS = Camera.h CameraManual.h
CAMERA = Camera
CAMERAHBase = Camera
CAMERA_HTML = $(CAMERAHBase)/index.html
USERMAN_CAMERA_FIGS = CameraAnyDist.png CameraAnyDistSmall.png
DOXYFILES += Doxyfile.$(CAMERA).in

USERMAN_DISPATCHER_PART = DispatcherTutorial.h \
	DispatcherReference.h DispatcherExamples.h
DISPATCHER_HS = Dispatcher.h DispatcherTutorial.h \
	DispatcherReference.h DispatcherExamples.h
DISPATCHER = Dispatcher
DISPATCHERHBase = Dispatcher
DISPATCHER_HTML = $(DISPATCHERHBase)/index.html
USERMAN_DISPATCHER_FIGS = DISPNewCTCPanel.png DISPNewCTCPanelSmall.png \
	DISPEmptyCTCPanel.png DISPEditPanelOptionsSmall.png \
	DISPMainGUI.png DISPEditPanelOptions.png DISPExample1.png \
	DISPExample2.png DISPExample3.png DISPExample4.png \
	DISPAddEditCMR_INode.png DISPAddEditMRDNode.png \
	DISPSelectCMRINodeDialog.png \
	DISPSelectMRDNodeDialog.png DISPSimpleTutNewCTC.png \
	DISPSimpleTutBlankCTC.png DISPSimpleTutSw1.png \
	DISPSimpleTutSw1CrossHairs.png DISPSimpleTutPanel1.png \
	DISPSimpleTutSWPlate1.png DISPSimpleTutPanel2.png \
	DISPSimpleTutCB1.png DISPSimpleTutPanel3.png DISPSimpleTutPanel4.png \
	DISPAddEditPanelObject.png DISPEditUserCode.png \
	DISPFindNodeDialog.png DISPSelectPanelObject.png DISPPrintDialog.png \
	DISPSelectCTCPanel.png DISPSimpleTutBlankCTCSmall.png \
	DISPSimpleTutSw1Small.png DISPSimpleTutSw1CrossHairsSmall.png \
	DISPSimpleTutPanel1Small.png DISPSimpleTutSWPlate1Small.png \
	DISPSimpleTutPanel2Small.png DISPSimpleTutCB1Small.png \
	DISPSimpleTutPanel3Small.png DISPSimpleTutPanel4Small.png \
	DISPMainGUISmall.png DISPEmptyCTCPanelSmall.png \
	DISPAddEditPanelObjectSmall.png DISPEditUserCodeSmall.png \
	DISPExample1Small.png DISPExample2Small.png DISPExample3Small.png \
	DISPExample4Small.png Dispatcher_PassingSidingXtrkCAD.png \
	Dispatcher_PassingSidingXtrkCADSmall.png \
	Dispatcher_PassingSidingLCEManager.png \
	Dispatcher_PassingSidingLCEManagerSmall.png \
	Dispatcher_PassingSidingGraph.png \
	Dispatcher_PassingSidingGraphSmall.png \
	Dispatcher_PassingSidingNewCTCPanelDialog.png \
	Dispatcher_PassingSidingNewCTCPanelDialogSmall.png \
	Dispatcher_PassingSidingNewCTCPanelDialogUpd.png \
	Dispatcher_PassingSidingNewCTCPanelDialogUpdSmall.png \
	Dispatcher_PassingSidingCTCPanelEmpty.png \
	Dispatcher_PassingSidingCTCPanelEmptySmall.png \
	Dispatcher_PassingSidingContextMenu.png \
	Dispatcher_PassingSidingSegment1Initial.png \
	Dispatcher_PassingSidingSegment1InitialSmall.png \
	Dispatcher_PassingSidingSegment1Updated.png \
	Dispatcher_PassingSidingSegment1UpdatedSmall.png \
	Dispatcher_PassingSidingSegment3Initial.png \
	Dispatcher_PassingSidingSegment3InitialSmall.png \
	Dispatcher_PassingSidingSegment3Updated.png \
	Dispatcher_PassingSidingSegment3UpdatedSmall.png \
	Dispatcher_PassingSidingSwitchPlate.png \
	Dispatcher_PassingSidingSwitchPlateSmall.png \
	Dispatcher_PassingSidingCTCPanel.png \
	Dispatcher_PassingSidingCTCPanelSmall.png \
	Dispatcher_PassingSidingCP1EInitial.png \
	Dispatcher_PassingSidingCP1EInitialSmall.png \
	Dispatcher_PassingSidingCP1EUpdated.png \
	Dispatcher_PassingSidingCP1EUpdatedSmall.png \
	Dispatcher_PassingSidingCTCPanelWSignal.png \
	Dispatcher_PassingSidingCTCPanelWSignalSmall.png \
	Dispatcher_PassingSidingCTCPanelCompleteBeforeSigPlates.png \
	Dispatcher_PassingSidingCTCPanelCompleteBeforeSigPlatesSmall.png \
	Dispatcher_PassingSidingCTCPanelComplete.png \
	Dispatcher_PassingSidingCTCPanelCompleteSmall.png
USERMAN_DISPATCHER_DEPS = $(srcdir)/../../Scripts/Dispatcher/example*.tcl \
			  $(srcdir)/../../Scripts/Dispatcher/example*.iow
DOXYFILES += Doxyfile.$(DISPATCHER).in


USERMAN_MAINPROGRAM_PART = #
MAINPROGRAM_HS = MainProgram.h 
MAINPROGRAM = MainProgram
MAINPROGRAMHBase = MainProgram
MAINPROGRAM_HTML = $(MAINPROGRAMHBase)/index.html
USERMAN_MAINPROGRAM_FIGS =
DOXYFILES += Doxyfile.$(MAINPROGRAM).in


USERMAN_HS = Preface.h Introduction.h \
	$(USERMAN_UNIVERSALTEST_PART) $(USERMAN_OPENLCB_PART) \
	$(USERMAN_XPRESSNETTHROTTLE_PART) $(USERMAN_GENERICTHROTTLE_PART) \
	$(USERMAN_TIMETABLE_PART) $(USERMAN_FCF_PART) $(USERMAN_CALC_PART) \
	$(USERMAN_CAMERA_PART) $(USERMAN_DISPATCHER_PART) \
	$(USERMAN_MAINPROGRAM_PART) $(USERMAN_AZATRAX_PROG_PART) \
	$(USERMAN_EI_PART) $(USERMAN_LINUXGPIO_PART) \
	Help.h
USERMAN_FIGS = $(USERMAN_TIMETABLE_FIGS) $(USERMAN_FCF_FIGS) \
	$(USERMAN_CALC_FIGS) $(USERMAN_CAMERA_FIGS) $(USERMAN_DISPATCHER_FIGS) \
	$(USERMAN_MAINPROGRAM_FIGS) $(USERMAN_DISPATCHER_DEPS) \
	$(USERMAN_AZATRAX_PROG_FIGS) $(USERMAN_UNIVERSALTEST_FIGS) \
	$(USERMAN_XPRESSNETTHROTTLE_FIGS) $(USERMAN_GENERICTHROTTLE_FIGS) \
	$(USERMAN_OPENLCB_FIGS) $(USERMAN_EI_FIGS) $(USERMAN_LINUXGPIO_FIGS)
USERMAN = UserManual
USERMAN_PDF = $(USERMAN).pdf
USERMANHBase = UserManual
USERMAN_HTML = $(USERMANHBase)/index.html
DOXYFILES += Doxyfile.$(USERMAN).in

BIBLIO = ../MRR.bib

EXTRA_DIST = $(USERMAN_HS) $(USERMAN_FIGS) $(TIMETABLE_HS) $(FCF_HS) \
	     $(CALC_HS) $(CAMERA_HS) $(DISPATCHER_HS) COPYING.h \
	     $(UNIVERSALTEST_HS) $(MAINPROGRAM_HS) $(AZATRAX_PROG_HS) \
	     $(XPRESSNETTHROTTLE_HS) $(GENERICTHROTTLE_HS) footer.tex \
	     $(OPENLCB_HS) $(DOXYFILES) $(EI_HS) $(LINUXGPIO_HS) \
	     Makefile.UserManual.in

pkgdatadir = $(datadir)/$(PACKAGE)/Doc

pkgdata_DATA = $(USERMAN_PDF) Help.h
noinst_DATA  = $(USERMAN_HTML) $(TIMETABLE_HTML) $(FCF_HTML) $(CALC_HTML) \
	       $(CAMERA_HTML) $(DISPATCHER_HTML) $(UNIVERSALTEST_HTML) \
	       $(AZATRAX_PROG_HTML) $(MAINPROGRAM_HTML) \
	       $(XPRESSNETTHROTTLE_HTML) $(GENERICTHROTTLE_HTML) \
	       $(OPENLCB_HTML) $(CMRISLAVE_HTML)


CLEANFILES = *_Version.h $(USERMAN_PDF) 


$(USERMAN)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version' >$(USERMAN)_Version.h
	echo "  * TT Support Library version is $(TTCLASSES_VERSIONLIB)." >>$(USERMAN)_Version.h
	echo "  * FCF Support Library version is $(FCFCLASSES_VERSIONLIB)." >>$(USERMAN)_Version.h
	echo "  * CMri Library version is $(CMRI_VERSIONLIB)." >>$(USERMAN)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(USERMAN)_Version.h
	echo "  * Azatrax Library version is $(AZATRAX_VERSIONLIB)." >>$(USERMAN)_Version.h
	echo "  */" >>$(USERMAN)_Version.h




$(USERMAN_HTML) $(USERMAN_PDF) : $(USERMAN_HS) $(USERMAN_FIGS) $(BIBLIO) \
	footer.tex $(USERMAN)_Version.h COPYING.h Doxyfile.$(USERMAN) \
	../../C++/RailDriver/raildriverd.src \
	../../Scripts/Satellite/SatelliteDaemon.src \
	../../Scripts/LCC/OpenLCBTcpHub.tcl \
	../../Scripts/LCC/OpenLCB_MRD2.tcl \
	../../Scripts/LCC/OpenLCBGCTcpHub.tcl \
	../../Scripts/LCC/Router.tcl \
	../../Scripts/LCC/OpenLCB_PiGPIO.tcl \
	../../Scripts/LCC/OpenLCB_PiMCP23008.tcl \
	../../Scripts/LCC/OpenLCB_PiMCP23017.tcl \
	../../Scripts/LCC/OpenLCB_PiMCP23017_signal.tcl \
	../../Scripts/LCC/OpenLCB_QuadSignal.tcl \
	../../Scripts/LCC/OpenLCB_PiSPIMax7221.tcl \
	../../Scripts/LCC/OpenLCB_Logic.tcl \
	../../Scripts/LCC/OpenLCB_TrackCircuits.tcl \
	../../Scripts/LCC/OpenLCB_Acela.tcl \
	../../Scripts/LCC/OpenLCB_CMRI.tcl \
	../../Scripts/LCC/JMRITable2LayoutDB.tcl \
	../../Scripts/LCC/LayoutDB2JMRITable.tcl \
	../../Scripts/LCC/OfflineLCCNodeEditor.tcl \
	../doxygen/tcldoxyfilter.sh
	-rm -rf $(USERMANHBase)/
	-rm -rf latex
	-chmod +x ../doxygen/tcldoxyfilter.sh
	$(DOXYGEN) Doxyfile.UserManual
	for p in $(USERMAN_FIGS); do \
	   if test ! \( -f $(USERMANHBase)/$$p \); then cp $(srcdir)/$$p $(USERMANHBase)/; fi; \
	done
	-rm -f $(USERMANHBase)/pages.html
	cp $(srcdir)/$(BIBLIO) latex/
	cp Makefile.UserManual latex/Makefile
	make -C latex pdf
	mv latex/refman.pdf ./$(USERMAN_PDF)


$(AZATRAX_PROG)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version' >$(AZATRAX_PROG)_Version.h
	echo "  * Azatrax Library version is $(AZATRAX_VERSIONLIB)." >>$(AZATRAX_PROG)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(AZATRAX_PROG)_Version.h
	echo "  */" >>$(AZATRAX_PROG)_Version.h

$(AZATRAX_PROG_HTML) : COPYING.h Help.h $(AZATRAX_PROG_HS) \
	$(USERMAN_AZATRAX_PROG_FIGS) $(AZATRAX_PROG)_Version.h \
	Doxyfile.$(AZATRAX_PROG)
	-rm -rf $(AZATRAX_PROGHBase)/
	$(DOXYGEN) Doxyfile.$(AZATRAX_PROG)
	for p in $(USERMAN_AZATRAX_PROG_FIGS); do \
	   if test ! \( -f $(AZATRAX_PROGHBase)/$$p \); then cp $(srcdir)/$$p $(AZATRAX_PROGHBase)/; fi; \
	done
	-rm -f $(AZATRAX_PROGHBase)/pages.html

$(UNIVERSALTEST)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(UNIVERSALTEST)_Version.h
	echo "  * CMri Library version is $(CMRI_VERSIONLIB)." >>$(UNIVERSALTEST)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(UNIVERSALTEST)_Version.h
	echo "  */" >>$(UNIVERSALTEST)_Version.h

$(UNIVERSALTEST_HTML) : COPYING.h Help.h $(UNIVERSALTEST_HS) \
		$(USERMAN_UNIVERSALTEST_FIGS) $(UNIVERSALTEST)_Version.h \
		Doxyfile.$(UNIVERSALTEST)
	-rm -rf $(UNIVERSALTESTHBase)/
	$(DOXYGEN) Doxyfile.$(UNIVERSALTEST)
	for p in $(USERMAN_UNIVERSALTEST_FIGS); do \
	   if test ! \( -f $(UNIVERSALTESTHBase)/$$p \); then cp $(srcdir)/$$p $(UNIVERSALTESTHBase)/; fi; \
	done
	-rm -f $(UNIVERSALTESTHBase)/pages.html

$(OPENLCB)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(OPENLCB)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(OPENLCB)_Version.h
	echo "  */" >>$(OPENLCB)_Version.h

$(OPENLCB_HTML) : COPYING.h Help.h $(OPENLCB_HS) \
		$(USERMAN_OPENLCB_FIGS) $(OPENLCB)_Version.h \
		Doxyfile.$(OPENLCB)
	-rm -rf $(OPENLCBHBase)/
	$(DOXYGEN) Doxyfile.$(OPENLCB)
	for p in $(USERMAN_OPENLCB_FIGS); do \
	   if test ! \( -f $(OPENLCBHBase)/$$p \); then cp $(srcdir)/$$p $(OPENLCBHBase)/; fi; \
	done
	-rm -f $(OPENLCBHBase)/pages.html

$(CMRISLAVE)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(CMRISLAVE)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(CMRISLAVE)_Version.h
	echo "  */" >>$(CMRISLAVE)_Version.h

$(CMRISLAVE_HTML) : COPYING.h Help.h $(CMRISLAVE_HS) \
		$(USERMAN_CMRISLAVE_FIGS) $(CMRISLAVE)_Version.h \
		Doxyfile.$(CMRISLAVE)
	-rm -rf $(CMRISLAVEHBase)/
	$(DOXYGEN) Doxyfile.$(CMRISLAVE)
	for p in $(USERMAN_CMRISLAVE_FIGS); do \
	   if test ! \( -f $(CMRISLAVEHBase)/$$p \); then cp $(srcdir)/$$p $(CMRISLAVEHBase)/; fi; \
	done
	-rm -f $(CMRISLAVEHBase)/pages.html

$(XPRESSNETTHROTTLE)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(XPRESSNETTHROTTLE)_Version.h
	echo "  * XPressNet Library version is $(XPRESSNET_VERSIONLIB)." >>$(XPRESSNETTHROTTLE)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(XPRESSNETTHROTTLE)_Version.h
	echo "  */"  >>$(XPRESSNETTHROTTLE)_Version.h

$(XPRESSNETTHROTTLE_HTML) :  COPYING.h $(XPRESSNETTHROTTLE_HS) \
		    $(USERMAN_XPRESSNETTHROTTLE_FIGS) \
		    $(XPRESSNETTHROTTLE)_Version.h Help.h \
		    Doxyfile.$(XPRESSNETTHROTTLE)
	-rm -rf $(XPRESSNETTHROTTLEHBase)/
	$(DOXYGEN) Doxyfile.$(XPRESSNETTHROTTLE)
	for p in $(USERMAN_XPRESSNETTHROTTLE_FIGS); do \
	   if test ! \( -f $(XPRESSNETTHROTTLEHBase)/$$p \); then cp $(srcdir)/$$p $(XPRESSNETTHROTTLEHBase)/; fi; \
	done
	-rm -f $(XPRESSNETTHROTTLEHBase)/pages.html

$(GENERICTHROTTLE)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(GENERICTHROTTLE)_Version.h
	echo "  * XPressNet Library version is $(XPRESSNET_VERSIONLIB)." >>$(GENERICTHROTTLE)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(GENERICTHROTTLE)_Version.h
	echo "  */" >>$(GENERICTHROTTLE)_Version.h

$(GENERICTHROTTLE_HTML) : COPYING.h $(GENERICTHROTTLE_HS) \
		    $(USERMAN_GENERICTHROTTLE_FIGS) \
		    $(GENERICTHROTTLE)_Version.h Help.h \
		    Doxyfile.$(GENERICTHROTTLE)
	-rm -rf $(GENERICTHROTTLEHBase)/
	$(DOXYGEN) Doxyfile.$(GENERICTHROTTLE)
	for p in $(USERMAN_GENERICTHROTTLE_FIGS); do \
	   if test ! \( -f $(GENERICTHROTTLEHBase)/$$p \); then cp $(srcdir)/$$p $(GENERICTHROTTLEHBase)/; fi; \
	done
	-rm -f $(GENERICTHROTTLEHBase)/pages.html

$(TIMETABLE)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(TIMETABLE)_Version.h
	echo "  * TT Support Library version is $(TTCLASSES_VERSIONLIB)." >>$(TIMETABLE)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(TIMETABLE)_Version.h
	echo "  */" >>$(TIMETABLE)_Version.h


$(TIMETABLE_HTML) : COPYING.h $(TIMETABLE_HS) $(TIMETABLE)_Version.h \
		    $(USERMAN_TIMETABLE_FIGS) Help.h \
		    Doxyfile.$(TIMETABLE)
	-rm -rf $(TIMETABLEHBase)/
	$(DOXYGEN) Doxyfile.$(TIMETABLE)
	for p in $(USERMAN_TIMETABLE_FIGS); do \
	   if test ! \( -f $(TIMETABLEHBase)/$$p \); then cp $(srcdir)/$$p $(TIMETABLEHBase)/; fi; \
	done
	-rm -f $(TIMETABLEHBase)/pages.html

$(FCF)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(FCF)_Version.h
	echo "  * FCF Support Library version is $(FCFCLASSES_VERSIONLIB)." >>$(FCF)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(FCF)_Version.h
	echo "  */" >>$(FCF)_Version.h

$(FCF_HTML) : COPYING.h $(FCF_HS) $(USERMAN_FCF_FIGS) \
		    $(FCF)_Version.h Help.h \
		    Doxyfile.$(FCF)
	-rm -rf $(FCFHBase)/
	$(DOXYGEN) Doxyfile.$(FCF)
	for p in $(USERMAN_FCF_FIGS); do \
	   if test ! \( -f $(FCFHBase)/$$p \); then cp $(srcdir)/$$p $(FCFHBase)/; fi; \
	done
	-rm -f $(FCFHBase)/pages.html

$(EI)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(EI)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(EI)_Version.h
	echo "  */" >>$(EI)_Version.h

$(EI_HTML) : COPYING.h $(EI_HS) $(USERMAN_EI_FIGS) \
		    $(EI)_Version.h Help.h \
		    Doxyfile.$(EI)
	-rm -rf $(EIHBase)/
	$(DOXYGEN) Doxyfile.$(EI)
	for p in $(USERMAN_EI_FIGS); do \
	   if test ! \( -f $(EIHBase)/$$p \); then cp $(srcdir)/$$p $(EIHBase)/; fi; \
	done
	-rm -f $(EIHBase)/pages.html

$(LINUXGPIO)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(LINUXGPIO)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(LINUXGPIO)_Version.h
	echo "  */" >>$(LINUXGPIO)_Version.h

$(LINUXGPIO_HTML) : COPYING.h $(LINUXGPIO_HS) $(USERMAN_LINUXGPIO_FIGS) \
		    $(LINUXGPIO)_Version.h Help.h \
		    Doxyfile.$(LINUXGPIO)
	-rm -rf $(LINUXGPIOHBase)/
	$(DOXYGEN) Doxyfile.$(LINUXGPIO)
	for p in $(USERMAN_LINUXGPIO_FIGS); do \
	   if test ! \( -f $(LINUXGPIOHBase)/$$p \); then cp $(srcdir)/$$p $(LINUXGPIOHBase)/; fi; \
	done
	-rm -f $(LINUXGPIOHBase)/pages.html

$(CALC)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(CALC)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(CALC)_Version.h
	echo "  */" >>$(CALC)_Version.h


$(CALC_HTML) : COPYING.h $(CALC_HS) $(USERMAN_CALC_FIGS) \
		$(CALC)_Version.h Help.h \
		Doxyfile.$(CALC)
	-rm -rf $(CALCHBase)/
	$(DOXYGEN) Doxyfile.$(CALC)
	for p in $(USERMAN_CALC_FIGS); do \
	   if test ! \( -f $(CALCHBase)/$$p \); then cp $(srcdir)/$$p $(CALCHBase)/; fi; \
	done
	-rm -f $(CALCHBase)/pages.html

$(CAMERA)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(CAMERA)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(CAMERA)_Version.h
	echo "  */" >>$(CAMERA)_Version.h

$(CAMERA_HTML) : COPYING.h $(CAMERA_HS) $(CAMERA)_Version.h \
		$(USERMAN_CAMERA_FIGS) Help.h \
		Doxyfile.$(CAMERA)
	-rm -rf $(CAMERAHBase)/
	$(DOXYGEN) Doxyfile.$(CAMERA)
	for p in $(USERMAN_CAMERA_FIGS); do \
	   if test ! \( -f $(CAMERAHBase)/$$p \); then cp $(srcdir)/$$p $(CAMERAHBase)/; fi; \
	done
	-rm -f $(CAMERAHBase)/pages.html

$(DISPATCHER)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(DISPATCHER)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(DISPATCHER)_Version.h
	echo "  */" >>$(DISPATCHER)_Version.h

$(DISPATCHER_HTML) : COPYING.h $(DISPATCHER_HS) $(DISPATCHER)_Version.h \
			$(USERMAN_DISPATCHER_FIGS) \
			$(USERMAN_DISPATCHER_DEPS) Help.h \
			Doxyfile.$(DISPATCHER)
	-rm -rf $(DISPATCHERHBase)/
	$(DOXYGEN) Doxyfile.$(DISPATCHER)
	for p in $(USERMAN_DISPATCHER_FIGS); do \
	   if test ! \( -f $(DISPATCHERHBase)/$$p \); then cp $(srcdir)/$$p $(DISPATCHERHBase)/; fi; \
	done
	-rm -f $(DISPATCHERHBase)/pages.html

$(MAINPROGRAM)_Version.h : $(top_builddir)/config.status
	echo '/** @page Version Version'               >$(MAINPROGRAM)_Version.h
	echo "  * System patch level is $(MRR_PATCH_LEVEL)." >>$(MAINPROGRAM)_Version.h
	echo "  */" >>$(MAINPROGRAM)_Version.h

$(MAINPROGRAM_HTML) : COPYING.h $(MAINPROGRAM_HS) $(MAINPROGRAM)_Version.h \
			$(USERMAN_MAINPROGRAM_FIGS) Help.h \
			Doxyfile.$(MAINPROGRAM)
	-rm -rf $(MAINPROGRAMHBase)/
	$(DOXYGEN) Doxyfile.$(MAINPROGRAM)
	for p in $(USERMAN_MAINPROGRAM_FIGS); do \
	   if test ! \( -f $(MAINPROGRAMHBase)/$$p \); then cp $(srcdir)/$$p $(MAINPROGRAMHBase)/; fi; \
	done
	-rm -f $(MAINPROGRAMHBase)/pages.html

install-data-hook: $(USERMAN_HTML)
	$(INSTALL) -d $(DESTDIR)$(pkgdatadir)/$(USERMANHBase)
	for p in $(USERMANHBase)/*; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  f=`echo $$p | sed -e 's|^.*/||'`; \
	  echo " $(INSTALL_DATA) '$$d$$p' '$(DESTDIR)$(pkgdatadir)/$(USERMANHBase)$$f'"; \
	  $(INSTALL_DATA) "$$d$$p" "$(DESTDIR)$(pkgdatadir)/$(USERMANHBase)/$$f"; \
	done

uninstall-hook: 
	for p in $(DESTDIR)$(pkgdatadir)/$(USERMANHBase)/*; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  f=`echo $$p | sed -e 's|^.*/||'`; \
	  echo " rm -f '$(DESTDIR)$(pkgdatadir)/$(USERMANHBase)$$f'"; \
	  rm -f "$(DESTDIR)$(pkgdatadir)/$(USERMANHBase)/$$f"; \
	done


../doxygen/tcldoxyfilter.sh: ../doxygen/tcldoxyfilter.sh.in
	make -C ../doxygen tcldoxyfilter.sh

clean-local:
	-rm -rf $(AZATRAX_PROGHBase) $(UNIVERSALTESTHBase) \
		$(XPRESSNETTHROTTLEHBase) $(GENERICTHROTTLEHBase) \
		$(TIMETABLEHBase) $(FCFHBase) $(CALCHBase) \
		$(CAMERAHBase) $(DISPATCHERHBase) $(MAINPROGRAMHBase) \
		$(USERMANHBase) $(OPENLCBHBase) $(CMRISLAVEHBase) \
		$(EIHBase) $(LINUXGPIOHBase) latex
