#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Tue May 9 10:33:58 2017
#  Last Modified : <170720.1358>
#
#  Description	
#
#  Notes
#
#  History
#	
#*****************************************************************************
#
#    Copyright (C) 2017  Robert Heller D/B/A Deepwoods Software
#			51 Locke Hill Road
#			Wendell, MA 01379-9728
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# 
#
#*****************************************************************************


## @page OpenLCB_PiMCP23017 OpenLCB PiMCP23017 node
# @brief OpenLCB PiMCP23017 node
#
# @section PiMCP23017SYNOPSIS SYNOPSIS
#
# OpenLCB_PiMCP23017 [-configure] [-sampleconfiguration] [-debug] [-configuration confgile]
#
# @section PiMCP23017DESCRIPTION DESCRIPTION
#
# This program is a daemon that implements an OpenLCB node for the GPIO pins
# provided by a MCP23017 I2C port expander on a Raspberry Pi.
#
# @section PiMCP23017PARAMETERS PARAMETERS
#
# None
#
# @section PiMCP23017OPTIONS OPTIONS
#
# @arg -log  logfilename The name of the logfile.  Defaults to 
# OpenLCB_PiMCP23017.log
# @arg -configure Enter an interactive GUI configuration tool.  This tool
# creates or edits an XML configuration file.
# @arg -sampleconfiguration Creates a @b sample configuration file that can 
# then be hand edited (with a handy text editor like emacs or vim).
# @arg -configuration confgile Sets the name of the configuration (XML) file. 
# The default is pimcp23017conf.xml.
# @arg -debug Turns on debug logging.
# @par
#
# @section PiMCP23017CONFIGURATION CONFIGURATION
#
# The configuration file for this program is an XML formatted file. Please 
# refer to the @ref openlcbdaemons "OpenLCB Daemons (Hubs and Virtual nodes)" chapter of the User 
# Manual for the details on the schema for this XML formatted file.  Also
# note that this program contains a built-in editor for its own configuration 
# file. 
#
#
# @section PiMCP23017AUTHOR AUTHOR
# Robert Heller \<heller\@deepsoft.com\>
#

set argv0 [file join  [file dirname [info nameofexecutable]] OpenLCB_PiMCP23017]

package require Tclwiringpi;#  require the Tclwiringpi package
package require snit;#     require the SNIT OO framework
package require LCC;#      require the OpenLCB code
package require ParseXML;# require the XML parsing code (for the conf file)
package require gettext;#  require the localized message handler
package require log;#      require the logging package.

set msgfiles [::msgcat::mcload [file join [file dirname [file dirname [file dirname \
							[info script]]]] Messages]]

snit::enum PinModes -values {in out high low}

snit::type GPIOPinNo {
    pragma  -hastypeinfo false -hastypedestroy false -hasinstances false
    typemethod validate {pinno} {
        if {$pinno < 0 || $pinno > 15} {
            error [_ "Not a GPIO pin number: %s" $pinno]
        } else {
            return $pinno
        }
    }
    typemethod AllPins {} {
        return [list 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]
    }
    typemethod gpioPinNo {pinno} {
        $type validate $pinno
        return [expr {64 + $pinno}]
    }
    typemethod mcp23017PinNo {gpiopinno} {
        set pin [expr {$gpiopinno - 64}]
        $type validate $pin
        return $pin
    }
}
        
snit::integer MCP23017Addr -min 0 -max 7

snit::type OpenLCB_PiMCP23017 {
    #** This class implements a OpenLCB interface to the GPIO pins of a
    # MCP23017 I2C port expander on a Raspberry Pi.
    #
    # Each instance manages one pin.  The typemethods implement the overall
    # OpenLCB node.
    #
    # Instance options:
    # @arg -pinnumber The pin number
    # @arg -pinmode   The pin's mode
    # @arg -pinin0    Event ID to send when the pin's input value goes to 0.
    # @arg -pinin1    Event ID to send when the pin's input value goes to 1.
    # @arg -pinout0   Event ID to trigger setting the pin's output to 0.
    # @arg -pinout1   Event ID to trigger setting the pin's output to 1.
    # @arg -description Description of the pin.
    # @par
    #
    # @section AUTHOR
    # Robert Heller \<heller\@deepsoft.com\>
    #
    
    typecomponent transport; #        Transport layer
    typecomponent configuration;#     Parsed  XML configuration
    typevariable  pinlist {};#        Pin list
    typevariable  consumers {};#      Pins that consume events (outputs)
    typevariable  eventsconsumed {};# Events consumed.
    typevariable  producers {};#      Pins that produce events (inputs)
    typevariable  eventsproduced {};# Events produced.
    typevariable  defaultpollinterval 500;# Default poll interval
    typevariable  pollinterval 500;#  Poll interval
    typevariable  baseI2Caddress 0x20;# Base I2C address.
    typevariable  defaultI2CAddr 7;#  Default I2C address offset
    typevariable  I2CAddr 7;#         I2C address offset
    
    
    typecomponent editContextMenu
    
    typeconstructor {
        #** @brief Global static initialization.
        #
        # Process command line.  Runs the GUI configuration tool or connects to
        # the OpenLCB network and manages GPIO pins, consuming or producing
        # events.
        
        global argv
        global argc
        global argv0
        
        set debugnotvis 1
        set debugIdx [lsearch -exact $argv -debug]
        if {$debugIdx >= 0} {
            set debugnotvis 0
            set argv [lreplace $argv $debugIdx $debugIdx]
        }
        set configureator no
        set configureIdx [lsearch -exact $argv -configure]
        if {$configureIdx >= 0} {
            set configureator yes
            set argv [lreplace $argv $configureIdx $configureIdx]
        }
        set sampleconfiguration no
        set sampleconfigureIdx [lsearch -exact $argv -sampleconfiguration]
        if {$sampleconfigureIdx >= 0} {
            set sampleconfiguration yes
            set argv [lreplace $argv $sampleconfigureIdx $sampleconfigureIdx]
        }
        set conffile [from argv -configuration "pimcp23017conf.xml"]
        #puts stderr "*** $type typeconstructor: configureator = $configureator, debugnotvis = $debugnotvis, conffile = $conffile"
        if {$configureator} {
            $type ConfiguratorGUI $conffile
            return
        }
        if {$sampleconfiguration} {
            $type SampleConfiguration $conffile
            return
        }
       
        set deflogfilename [format {%s.log} [file tail $argv0]]
        set logfilename [from argv -log $deflogfilename]
        if {[file extension $logfilename] ne ".log"} {append logfilename ".log"}
        close stdin
        close stdout
        close stderr
        set null /dev/null
        if {$::tcl_platform(platform) eq "windows"} {
            set null nul
        }
        open $null r
        open $null w
        set logchan [open $logfilename w]
        fconfigure $logchan  -buffering none
        
        ::log::lvChannelForall $logchan
        ::log::lvSuppress info 0
        ::log::lvSuppress notice 0
        ::log::lvSuppress debug $debugnotvis
        ::log::lvCmdForall [mytypemethod LogPuts]
        
        ::log::logMsg [_ "%s starting" $type]
        
        ::log::log debug "*** $type typeconstructor: argv = $argv"
        
        if {[catch {open $conffile r} conffp]} {
            ::log::logError [_ "Could not open %s because: %s" $conffile $conffp]
            exit 99
        }
        set confXML [read $conffp]
        close $conffp
        if {[catch {ParseXML create %AUTO% $confXML} configuration]} {
            ::log::logError [_ "Could not parse configuration file %s: %s" $conffile $configuration]
            exit 98
        }
        set transcons [$configuration getElementsByTagName "transport"]
        set constructor [$transcons getElementsByTagName "constructor"]
        if {$constructor eq {}} {
            ::log::logError [_ "Transport constructor missing!"]
            exit 97
        }
        set options [$transcons getElementsByTagName "options"]
        set transportOpts {}
        if {$options ne {}} {
            set transportOpts [$options data]
        } else {
            ::log::log debug "*** $type typeconstructor: no options."
        }
        
        set transportConstructors [info commands ::lcc::[$constructor data]]
        if {[llength $transportConstructors] > 0} {
            set transportConstructor [lindex $transportConstructors 0]
        }
        if {$transportConstructor eq {}} {
            ::log::logError [_ "No valid transport constructor found!"]
            exit 96
        }
        set nodename ""
        set nodedescriptor ""
        set ident [$configuration getElementsByTagName "identification"]
        if {[llength $ident] > 0} {
             set ident [lindex $ident 0]
             set nodenameele [$ident getElementsByTagName "name"]
             if {[llength $nodenameele] > 0} {
                 set nodename [[lindex $nodenameele 0] data]
             }
             set nodedescriptorele [$ident getElementsByTagName "description"]
             if {[llength $nodedescriptorele] > 0} {
                 set nodedescriptor [[lindex $nodedescriptorele 0] data]
             }
        }
        if {[catch {eval [list lcc::OpenLCBNode %AUTO% \
                          -transport $transportConstructor \
                          -eventhandler [mytypemethod _eventHandler] \
                          -generalmessagehandler [mytypemethod _messageHandler] \
                          -softwaremodel "OpenLCB PiMCP23017" \
                          -softwareversion "1.0" \
                          -nodename $nodename \
                          -nodedescription $nodedescriptor \
                          -additionalprotocols {EventExchange} \
                          ] \
                          $transportOpts} transport]} {
            ::log::logError [_ "Could not open OpenLCBNode: %s" $transport]
            exit 95
        }
        $transport SendVerifyNodeID
        set pollele [$configuration getElementsByTagName "pollinterval"]
        if {[llength $pollele] > 0} {
            set pollele [lindex $pollele 0]
            set pollinterval [$pollele data]
        }
        
        set i2caddrele [$configuration getElementsByTagName "i2caddress"]
        if {[llength $i2caddrele] > 0} {
            set i2caddrele [lindex $i2caddrele 0]
            set I2CAddr [expr {[$i2caddrele data] & 0x07}]
        }
        # Connect to the MCP23017, with GPIO pins 64 through 79 (0 through 15
        # on the MCP23017).
        mcp23017Setup 64 [expr {$baseI2Caddress | $I2CAddr}]
        
        foreach pin [$configuration getElementsByTagName "pin"] {
            set pincommand [list $type create %AUTO%]
            set consume no
            set produce no
            set pinno [$pin getElementsByTagName "number"]
            if {[llength $pinno] != 1} {
                ::log::logError [_ "Missing or multiple pin numbers"]
                exit 94
            }
            set thepin [$pinno data]
            GPIOPinNo validate $thepin
            lappend pincommand -pinnumber $thepin
            set description [$pin getElementsByTagName "description"]
            if {[llength $description] > 0} {
                lappend pincommand -description [[lindex $description 0] data]
            }
            set pinmode [$pin getElementsByTagName "mode"]
            if {[llength $pinmode] != 1} {
                ::log::logError [_ "Missing or multiple pin modes"]
                exit 93
            }
            set themode [string tolower [$pinmode data]]
            PinModes validate $themode
            lappend pincommand -pinmode $themode
            switch $themode {
                in {
                    foreach k {pinin0 pinin1} {
                        set tag [$pin getElementsByTagName $k]
                        if {[llength $tag] == 0} {continue}
                        set tag [lindex $tag 0]
                        set produce yes
                        set ev [lcc::EventID create %AUTO% -eventidstring [$tag data]]
                        lappend pincommand -$k $ev
                        lappend eventsproduced $ev
                    }
                }
                out -
                high -
                low {
                    foreach k {pinout0 pinout1} {
                        set tag [$pin getElementsByTagName $k]
                        if {[llength $tag] == 0} {continue}
                        set tag [lindex $tag 0]
                        set consume yes
                        set ev [lcc::EventID create %AUTO% -eventidstring [$tag data]]
                        lappend pincommand -$k $ev
                        lappend eventsconsumed $ev
                    }
                    
                }
            }
            set pin [eval $pincommand]
            if {$consume} {lappend consumers $pin}
            if {$produce} {lappend producers $pin}
            if {!$consume && !$produce} {
                ::log::log warning [_ "Useless pin (%d) (neither consumes or produces events)" $thepin]
            } else {
                lappend pinlist $pin
            }
        }
        if {[llength $pinlist] == 0} {
            ::log::logError [_ "No enabled pins specified!"]
            exit 93
        }
        foreach p $producers {$p initpinval}
        foreach ev $eventsconsumed {
            $transport ConsumerIdentified $ev unknown
        }
        foreach ev $eventsproduced {
            $transport ProducerIdentified $ev unknown
        }
        
        after $pollinterval [mytypemethod _poll]
    }
    typemethod LogPuts {level message} {
        #** Log output function.
        #
        # @param level Level of log message.
        # @param message The message text.
        
        puts [::log::lv2channel $level] "[clock format [clock seconds] -format {%b %d %T}] \[[pid]\] $level $message"
    }
    typemethod _poll {} {
        #** Polling function.  Polls all of the sensors.
        
        foreach p $producers {
            $p Poll
        }
        after $pollinterval [mytypemethod _poll]
    }
    typemethod sendEvent {event} {
        #** Send an event, after first checking for local consumtion.
        #
        # @param event The event to process
        
        foreach c $consumers {
            $c consumeEvent $event
        }
        $transport ProduceEvent $event
    }
    
    typemethod _eventHandler {command eventid {validity {}}} {
        #* Event Exchange handler.  Handle Event Exchange messages.
        #
        # @param command The type of event operation.
        # @param eventid The eventid.
        # @param validity The validity of the event.
        
        switch $command {
            consumerrangeidentified {
            }
            consumeridentified {
            }
            producerrangeidentified {
            }
            produceridentified {
                if {$validity eq "valid"} {
                    foreach c $consumers {
                        ::log::log debug "*** $type _eventHandler: pin is [$c cget -pinnumber]"
                        ::log::log debug "*** $type _eventHandler: event is [$eventid cget -eventidstring]"
                        $c consumeEvent $eventid
                    }
                }
            }
            learnevents {
            }
            identifyconsumer {
                foreach ev $eventsconsumed {
                    if {[$eventid match $ev]} {
                        $transport ConsumerIdentified $ev unknown
                    }
                }
            }
            identifyproducer {
                foreach p $producers {
                    foreach evpair [$p readsensor $eventid] {
                        foreach {ev state} $evpair {break}
                        $transport ProducerIdentified $ev $state
                    }
                }
            }
            identifyevents {
                foreach ev $eventsconsumed {
                    $transport ConsumerIdentified $ev unknown
                }
                foreach p $producers {
                    foreach evpair [$p readsensor *] {
                        foreach {ev state} $evpair {break}
                        ::log::log debug "*** $type _eventHandler identifyevents: ev is [$ev cget -eventidstring], state = $state"
                        $transport ProducerIdentified $ev $state
                    }
                }
            }
            report {
                foreach c $consumers {
                    ::log::log debug "*** $type _eventHandler: pin is [$c cget -pinnumber]"
                    ::log::log debug "*** $type _eventHandler: event is [$eventid cget -eventidstring]"
                    $c consumeEvent $eventid
                    
                }
            }
        }
    }
    typemethod _messageHandler {message} {
        #** General message handler.
        #
        # @param message The OpenLCB message
        
        switch [format {0x%04X} [$message cget -mti]] {
            0x0490 -
            0x0488 {
                #* Verify Node ID
                $transport SendMyNodeVerifcation
            }
            0x0828 {
                #* Protocol Support Inquiry
                $transport SendMySupportedProtocols [$message cget -sourcenid]
            }
            0x0DE8 {
                #* Simple Node Information Request
                $transport SendMySimpleNodeInfo [$message cget -sourcenid]
            }
            default {
            }
        }
    }
    
    
    #*** Configuration GUI
    
    typecomponent main;# Main Frame.
    typecomponent scroll;# Scrolled Window.
    typecomponent editframe;# Scrollable Frame
    typevariable    transconstructorname {};# transport constructor
    typevariable    transopts {};# transport options
    typevariable    id_name {};# node name
    typevariable    id_description {};# node description
    typevariable    pollinginterval 500;# polling interval.
    typevariable    mcp23017address 7;# The address of the MCP23017
    typecomponent   pins;# Pin list
    typevariable    pincount 0;# pin count
    
    typevariable status {};# Status line
    typevariable conffilename {};# Configuration File Name
    
    #** Menu.
    typevariable _menu {
        "[_m {Menu|&File}]" {file:menu} {file} 0 {
            {command "[_m {Menu|File|&Save}]" {file:save} "[_ {Save}]" {Ctrl s} -command "[mytypemethod _save]"}
            {command "[_m {Menu|File|Save and Exit}]" {file:saveexit} "[_ {Save and exit}]" {} -command "[mytypemethod _saveexit]"}
            {command "[_m {Menu|File|&Exit}]" {file:exit} "[_ {Exit}]" {Ctrl q} -command "[mytypemethod _exit]"}
        } "[_m {Menu|&Edit}]" {edit} {edit} 0 {
            {command "[_m {Menu|Edit|Cu&t}]" {edit:cut edit:havesel} "[_ {Cut selection to the paste buffer}]" {Ctrl x} -command {StdMenuBar EditCut} -state disabled}
            {command "[_m {Menu|Edit|&Copy}]" {edit:copy edit:havesel} "[_ {Copy selection to the paste buffer}]" {Ctrl c} -command {StdMenuBar EditCopy} -state disabled}
            {command "[_m {Menu|Edit|&Paste}]" {edit:paste} "[_ {Paste selection from the paste buffer}]" {Ctrl c} -command {StdMenuBar EditPaste}}
            {command "[_m {Menu|Edit|C&lear}]" {edit:clear edit:havesel} "[_ {Clear selection}]" {} -command {StdMenuBar EditClear} -state disabled}
            {command "[_m {Menu|Edit|&Delete}]" {edit:delete edit:havesel} "[_ {Delete selection}]" {Ctrl d}  -command {StdMenuBar EditClear} -state disabled}
            {separator}
            {command "[_m {Menu|Edit|Select All}]" {edit:selectall} "[_ {Select everything}]" {} -command {StdMenuBar EditSelectAll}}
            {command "[_m {Menu|Edit|De-select All}]" {edit:deselectall edit:havesel} "[_ {Select nothing}]" {} -command {StdMenuBar EditSelectNone} -state disabled}
        } "[_m {Menu|&Help}]" {help} {help} 0 {
            {command "[_m {Menu|Help|On &Help...}]" {help:help} "[_ {Help on help}]" {} -command {HTMLHelp help Help}}
            {command "[_m {Menu|Help|On &Version}]" {help:help} "[_ {Version}]" {} -command {HTMLHelp help Version}}
            {command "[_m {Menu|Help|Warranty}]" {help:help} "[_ {Warranty}]" {} -command {HTMLHelp help Warranty}}
            {command "[_m {Menu|Help|Copying}]" {help:help} "[_ {Copying}]" {} -command {HTMLHelp help Copying}}
            {command "[_m {Menu|Help|EventExchange node for Raspberry Pi GPIO pins}]" {help:help} {} {} -command {HTMLHelp help "EventExchange node for Raspberry Pi GPIO pins"}}
        }
    }
    
    typemethod edit_checksel {} {
        if {[catch {selection get}]} {
            $main setmenustate edit:havesel disabled
        } else {
            $main setmenustate edit:havesel normal
        }
    }
    # Default (empty) XML Configuration.
    typevariable default_confXML {<?xml version='1.0'?><OpenLCB_PiMCP23017/>}
    typemethod SampleConfiguration {conffile} {
        #** Generate a Sample Configuration
        #
        # @param conffile Name of the configuration file.
        #
        
        set conffilename $conffile
        set confXML $default_confXML
        if {[file exists $conffilename]} {
            puts -nonewline stdout [_ {Configuration file (%s) already exists. Replace it [yN]? } $conffilename]
            flush stdout
            set answer [string toupper [string index [gets stdin] 0]]
            if {$answer ne "Y"} {exit 1}
        }
        set configuration [ParseXML create %AUTO% $confXML]
        set cdis [$configuration getElementsByTagName OpenLCB_PiMCP23017 -depth 1]
        set cdi [lindex $cdis 0]
        set transcons [SimpleDOMElement %AUTO% -tag "transport"]
        $cdi addchild $transcons
        set constructor [SimpleDOMElement %AUTO% -tag "constructor"]
        $transcons addchild $constructor
        $constructor setdata "CANGridConnectOverTcp"
        set transportopts [SimpleDOMElement %AUTO% -tag "options"]
        $transcons addchild $transportopts
        $transportopts setdata {-port 12021 -nid 05:01:01:01:22:00 -host localhost}
        set ident [SimpleDOMElement %AUTO% -tag "identification"]
        $cdi addchild $ident
        set nameele [SimpleDOMElement %AUTO% -tag "name"]
        $ident addchild $nameele
        $nameele setdata "Sample Name"
        set descrele [SimpleDOMElement %AUTO% -tag "description"]
        $ident addchild $descrele
        $descrele setdata "Sample Description"
        set eid 0
        set pollele [SimpleDOMElement %AUTO% -tag "pollinterval"]
        $cdi addchild $pollele
        $pollele setdata 500
        set i2caddrele [SimpleDOMElement %AUTO% -tag "i2caddress"]
        $cdi addchild $i2caddrele
        $pollele setdata 7
        set pin [SimpleDOMElement %AUTO% -tag "pin"]
        $cdi addchild $pin
        set descrele [SimpleDOMElement %AUTO% -tag "description"]
        $pin addchild $descrele
        $descrele setdata "Sample Input Pin"
        set pinno [SimpleDOMElement %AUTO% -tag "number"]
        $pin addchild $pinno
        $pinno setdata 0
        set pinmode [SimpleDOMElement %AUTO% -tag "mode"]
        $pin addchild $pinmode
        $pinmode setdata in
        foreach eventtag {pinin0 pinin1} {
            set tagele [SimpleDOMElement %AUTO% -tag $eventtag]
            $pin addchild $tagele
            $tagele setdata [format {05.01.01.01.22.00.00.%02x} $eid]
            incr eid
        }
        set pin [SimpleDOMElement %AUTO% -tag "pin"]
        $cdi addchild $pin
        set descrele [SimpleDOMElement %AUTO% -tag "description"]
        $pin addchild $descrele
        $descrele setdata "Sample Output Pin"
        set pinno [SimpleDOMElement %AUTO% -tag "number"]
        $pin addchild $pinno
        $pinno setdata 1
        set pinmode [SimpleDOMElement %AUTO% -tag "mode"]
        $pin addchild $pinmode
        $pinmode setdata out
        foreach eventtag {pinout0 pinout1} {
            set tagele [SimpleDOMElement %AUTO% -tag $eventtag]
            $pin addchild $tagele
            $tagele setdata [format {05.01.01.01.22.00.00.%02x} $eid]
            incr eid
        }
        if {![catch {open $conffilename w} conffp]} {
            puts $conffp {<?xml version='1.0'?>}
            $configuration displayTree $conffp
        }
        ::exit
    }
    typemethod ConfiguratorGUI {conffile} {

        #** Configuration GUI
        # 
        # Create the Configuration tool GUI.
        #
        # @param conffile Name of the configuration file.
        
        package require Tk
        package require tile
        package require ParseXML
        package require LabelFrames
        package require ScrollableFrame
        package require ScrollWindow
        package require MainFrame
        package require snitStdMenuBar
        package require ButtonBox
        package require ScrollTabNotebook
        package require HTMLHelp 2.0
        
        set HelpDir [file join [file dirname [file dirname [file dirname \
                                                            [info script]]]] Help]
        HTMLHelp setDefaults "$HelpDir" "index.html#toc"
        
        set editContextMenu [StdEditContextMenu .editContextMenu]
        $editContextMenu bind Entry
        $editContextMenu bind TEntry
        $editContextMenu bind Text
        $editContextMenu bind ROText
        $editContextMenu bind Spinbox
        
        set conffilename $conffile
        set confXML $default_confXML
        if {![catch {open $conffile r} conffp]} {
            set confXML [read $conffp]
            close $conffp
        }
        if {[catch {ParseXML create %AUTO% $confXML} configuration]} {
            set confXML $default_confXML
            set configuration [ParseXML create %AUTO% $confXML]
        }
        set cdis [$configuration getElementsByTagName OpenLCB_PiMCP23017 -depth 1]
        if {[llength $cdis] != 1} {
            error [_ "There is no OpenLCB_PiMCP23017 container in %s" $confXML]
            exit 90
        }
        set cdi [lindex $cdis 0]
        wm protocol . WM_DELETE_WINDOW [mytypemethod _saveexit]
        wm title    . [_ "OpenLCB_PiMCP23017 Configuration Editor (%s)" $conffile]
        set main [MainFrame .main -menu [subst $_menu] \
                  -textvariable [mytypevar status]]
        pack $main -expand yes -fill both
        [$main getmenu edit] configure -postcommand [mytypemethod edit_checksel]
        set f [$main getframe]
        set scroll [ScrolledWindow $f.scroll -scrollbar vertical \
                    -auto vertical]
        pack $scroll -expand yes -fill both
        set editframe [ScrollableFrame \
                       [$scroll getframe].editframe -constrainedwidth yes]
        $scroll setwidget $editframe
        set frame [$editframe getframe]
        set transconsframe [ttk::labelframe $frame.transportconstuctor \
                            -labelanchor nw -text [_m "Label|Transport"]]
        pack $transconsframe -fill x -expand yes
        set transconstructor [LabelFrame $transconsframe.transconstructor \
                              -text [_m "Label|Constructor"]]
        pack $transconstructor -fill x -expand yes
        set cframe [$transconstructor getframe]
        set transcname [ttk::entry $cframe.transcname \
                        -state readonly \
                        -textvariable [mytypevar transconstructorname]]
        pack $transcname -side left -fill x -expand yes
        set transcnamesel [ttk::button $cframe.transcnamesel \
                           -text [_m "Label|Select"] \
                           -command [mytypemethod _seltransc]]
        pack $transcnamesel -side right
        set transoptsframe [LabelFrame $transconsframe.transoptsframe \
                              -text [_m "Label|Constructor Opts"]]
        pack $transoptsframe -fill x -expand yes
        set oframe [$transoptsframe getframe]
        set transoptsentry [ttk::entry $oframe.transoptsentry \
                        -state readonly \
                        -textvariable [mytypevar transopts]]
        pack $transoptsentry -side left -fill x -expand yes
        set tranoptssel [ttk::button $oframe.tranoptssel \
                         -text [_m "Label|Select"] \
                         -command [mytypemethod _seltransopt]]
        pack $tranoptssel -side right
        
        set transcons [$cdi getElementsByTagName "transport"]
        if {[llength $transcons] == 1} {
            set constructor [$transcons getElementsByTagName "constructor"]
            if {[llength $constructor] == 1} {
                set transconstructorname [$constructor data]
            }
            set coptions [$transcons getElementsByTagName "options"]
            if {[llength $coptions] == 1} {
                set transopts [$coptions data]
            }
        }
        set identificationframe [ttk::labelframe $frame.identificationframe \
                            -labelanchor nw -text [_m "Label|Identification"]]
        pack $identificationframe -fill x -expand yes
        set identificationname [LabelFrame $identificationframe.identificationname \
                                -text [_m "Label|Name"]]
        pack $identificationname -fill x -expand yes
        set nframe [$identificationname getframe]
        set idname [ttk::entry $nframe.idname \
                        -textvariable [mytypevar id_name]]
        pack $idname -side left -fill x -expand yes
        set identificationdescrframe [LabelFrame $identificationframe.identificationdescrframe \
                              -text [_m "Label|Description"]]
        pack $identificationdescrframe -fill x -expand yes
        set dframe [$identificationdescrframe getframe]
        set identificationdescrentry [ttk::entry $dframe.identificationdescrentry \
                        -textvariable [mytypevar id_description]]
        pack $identificationdescrentry -side left -fill x -expand yes
        set ident [$cdi getElementsByTagName "identification"]
        if {[llength $ident] == 1} {
            set nameele [$ident getElementsByTagName "name"]
            if {[llength $nameele] == 1} {
                set id_name [$nameele data]
            }
            set descrele [$ident getElementsByTagName "description"]
            if {[llength $descrele] == 1} {
                set id_description [$descrele data]
            }
        }
        
        set pollintervalLE [LabelSpinBox $frame.pollintervalLE \
                            -label [_m "Label|Poll Interval"] \
                            -textvariable [mytypevar pollinginterval] \
                            -range {100 5000 10}]
        pack $pollintervalLE -fill x -expand yes
        set pollele [$cdi getElementsByTagName "pollinterval"]
        if {[llength $pollele] > 0} {
            set pollele [lindex $pollele 0]
            set pollinginterval [$pollele data]
        }
        set i2caddressLE [LabelSpinBox $frame.i2caddressLE \
                            -label [_m "Label|I2C Address offset"] \
                            -textvariable [mytypevar mcp23017address] \
                            -range {0 7 1}]
        pack $i2caddressLE -fill x -expand yes
        set i2caddrele [$cdi getElementsByTagName "i2caddress"]
        if {[llength $i2caddrele] > 0} {
            set i2caddrele [lindex $i2caddrele 0]
            set mcp23017address [$i2caddrele data]
        }
        set pins [ScrollTabNotebook $frame.pins]
        pack $pins -expand yes -fill both
        foreach pin [$cdi getElementsByTagName "pin"] {
            $type _create_and_populate_pin $pin
        }
        set addpin [ttk::button $frame.addpin \
                    -text [_m "Label|Add another pin"] \
                    -command [mytypemethod _addblankpin]]
        pack $addpin -fill x
    }
    typevariable warnings
    typemethod _saveexit {} {
        #** Save and Exit.  Bound to the Save and Exit file menu item
        # Saves the contents of the GUI as an XML file and then exits.
        
        if {[$type _save]} {
            $type _exit
        }
    }
    typemethod _save {} {
        #** Save.  Bound to the Save file menu item.
        # Saves the contents of the GUI as an XML file.
        
        set warnings 0
        set cdis [$configuration getElementsByTagName OpenLCB_PiMCP23017 -depth 1]
        set cdi [lindex $cdis 0]
        set transcons [$cdi getElementsByTagName "transport"]
        if {[llength $transcons] < 1} {
            set transcons [SimpleDOMElement %AUTO% -tag "transport"]
            $cdi addchild $transcons
        }
        set constructor [$transcons getElementsByTagName "constructor"]
        if {[llength $constructor] < 1} {
            set constructor [SimpleDOMElement %AUTO% -tag "constructor"]
            $transcons addchild $constructor
        }
        $constructor setdata $transconstructorname
        set coptions [$transcons getElementsByTagName "options"]
        if {[llength $coptions] < 1} {
            set coptions [SimpleDOMElement %AUTO% -tag "options"]
            $transcons addchild $coptions
        }
        $coptions setdata $transopts
        
        set ident [$cdi getElementsByTagName "identification"]
        if {[llength $ident] < 1} {
            set ident [SimpleDOMElement %AUTO% -tag "identification"]
            $cdi addchild $ident
        }
        set nameele [$ident getElementsByTagName "name"]
        if {[llength $nameele] < 1} {
            set nameele [SimpleDOMElement %AUTO% -tag "name"]
            $ident addchild $nameele
        }
        $nameele setdata $id_name 
        set descrele [$ident getElementsByTagName "description"]
        if {[llength $descrele] < 1} {
            set descrele [SimpleDOMElement %AUTO% -tag "description"]
            $ident addchild $descrele
        }
        $descrele setdata $id_description
        set pollele [$cdi getElementsByTagName "pollinterval"]
        if {[llength $pollele] < 1} {
            set pollele [SimpleDOMElement %AUTO% -tag "pollinterval"]
            $cdi addchild $pollele
        }
        $pollele setdata $pollinginterval
        set i2caddrele [$configuration getElementsByTagName "i2caddress"]
        if {[llength $i2caddrele] < 1} {
            set i2caddrele [SimpleDOMElement %AUTO% -tag "i2caddress"]
            $cdi addchild $i2caddrele
        }
        $i2caddrele setdata $mcp23017address
        
        foreach pin [$cdi getElementsByTagName "pin"] {
            $type _copy_from_gui_to_XML $pin
        }
        
        if {$warnings > 0} {
            tk_messageBox -type ok -icon info \
                  -message [_ "There were %d warnings.  Please correct and try again." $warnings]
            return no
        }
        if {![catch {open $conffilename w} conffp]} {
            puts $conffp {<?xml version='1.0'?>}
            $configuration displayTree $conffp
        }
        return yes
    }
    typemethod _copy_from_gui_to_XML {pin} {
        #** Copy from the GUI to the Pin XML
        # 
        # @param pin Pin XML element.
        
        set fr [$pin attribute frame]
        set frbase $pins.$fr
        set pinno [$pin getElementsByTagName "number"]
        if {[llength $pinno] < 1} {
            set pinno [SimpleDOMElement %AUTO% -tag "number"]
            $pin addchild $pinno
        }
        $pinno setdata [$frbase.pinno get]
        set pinmode [$pin getElementsByTagName "mode"]
        if {[llength $pinmode] < 1} {
            set pinmode [SimpleDOMElement %AUTO% -tag "mode"]
            $pin addchild $pinmode
        }
        $pinmode setdata [$frbase.pinmode get]
        set description_ [$frbase.description get]
        if {$description_ eq ""} {
            set description [$pin getElementsByTagName "description"]
            if {[llength $description] == 1} {
                $pin removeChild $description
            }
        } else {
            set description [$pin getElementsByTagName "description"]
            if {[llength $description] < 1} {
                set description [SimpleDOMElement %AUTO% -tag "description"]
                $pin addchild $description
            }
            $description setdata $description_
        }
        set pinin0_ [$frbase.pinin0 get]
        if {$pinin0_ ne "" && [catch {lcc::eventidstring validate $pinin0_}]} {
            tk_messageBox -type ok -icon warning \
                  -message [_ "Event ID for Pin in 0 is not a valid event id string: %s!" $pinin0_]
            set pinin0_ ""
            incr warnings
        }
        if {$pinin0_ eq ""} {
            set pinin0 [$pin getElementsByTagName "pinin0"]
            if {[llength $pinin0] == 1} {
                $pin removeChild $pinin0
            }
        } else {
            set pinin0 [$pin getElementsByTagName "pinin0"]
            if {[llength $pinin0] < 1} {
                set pinin0 [SimpleDOMElement %AUTO% -tag "pinin0"]
                $pin addchild $pinin0
            }
            $pinin0 setdata $pinin0_
        }
        
        set pinin1_ [$frbase.pinin1 get]
        if {$pinin1_ ne "" && [catch {lcc::eventidstring validate $pinin1_}]} {
            tk_messageBox -type ok -icon warning \
                  -message [_ "Event ID for Pin in 1 is not a valid event id string: %s!" $pinin1_]
            set pinin1_ ""
            incr warnings
        }
        if {$pinin1_ eq ""} {
            set pinin1 [$pin getElementsByTagName "pinin1"]
            if {[llength $pinin1] == 1} {
                $pin removeChild $pinin1
            }
        } else {
            set pinin1 [$pin getElementsByTagName "pinin1"]
            if {[llength $pinin1] < 1} {
                set pinin1 [SimpleDOMElement %AUTO% -tag "pinin1"]
                $pin addchild $pinin1
            }
            $pinin1 setdata $pinin1_
        }
        
        set pinout0_ [$frbase.pinout0 get]
        if {$pinout0_ ne "" && [catch {lcc::eventidstring validate $pinout0_}]} {
            tk_messageBox -type ok -icon warning \
                  -message [_ "Event ID for Pin out 0 is not a valid event id string: %s!" $pinout0_]
            set pinout0_ ""
            incr warnings
        }
        if {$pinout0_ eq ""} {
            set pinout0 [$pin getElementsByTagName "pinout0"]
            if {[llength $pinout0] == 1} {
                $pin removeChild $pinout0
            }
        } else {
            set pinout0 [$pin getElementsByTagName "pinout0"]
            if {[llength $pinout0] < 1} {
                set pinout0 [SimpleDOMElement %AUTO% -tag "pinout0"]
                $pin addchild $pinout0
            }
            $pinout0 setdata $pinout0_
        }
        
        set pinout1_ [$frbase.pinout1 get]
        if {$pinout1_ ne "" && [catch {lcc::eventidstring validate $pinout1_}]} {
            tk_messageBox -type ok -icon warning \
                  -message [_ "Event ID for Pin out 1 is not a valid event id string: %s!" $pinout1_]
            set pinout1_ ""
            incr warnings
        }
        if {$pinout1_ eq ""} {
            set pinout1 [$pin getElementsByTagName "pinout1"]
            if {[llength $pinout1] == 1} {
                $pin removeChild $pinout1
            }
        } else {
            set pinout1 [$pin getElementsByTagName "pinout1"]
            if {[llength $pinout1] < 1} {
                set pinout1 [SimpleDOMElement %AUTO% -tag "pinout1"]
                $pin addchild $pinout1
            }
            $pinout1 setdata $pinout1_
        }
    }
    typemethod _exit {} {
        #** Exit function.  Bound to the Exit file menu item.
        # Does not save the configuration data!
        
        ::exit
    }
    typemethod _seltransc {} {
        #** Select a transport constructor.
        
        set result [lcc::OpenLCBNode selectTransportConstructor]
        if {$result ne {}} {
            if {$result ne $transconstructorname} {set transopts {}}
            set transconstructorname [namespace tail $result]
        }
    }
    typemethod _seltransopt {} {
        #** Select transport constructor options.
        
        if {$transconstructorname ne ""} {
            set transportConstructors [info commands ::lcc::$transconstructorname]
            ::log::log debug "*** $type typeconstructor: transportConstructors is $transportConstructors"
            if {[llength $transportConstructors] > 0} {
                set transportConstructor [lindex $transportConstructors 0]
            }
            if {$transportConstructor ne {}} {
                set optsdialog [list $transportConstructor \
                                drawOptionsDialog]
                foreach x $transopts {lappend optsdialog $x}
                set transportOpts [eval $optsdialog]
                if {$transportOpts ne {}} {
                    set transopts $transportOpts
                }
            }
        }
    }
    typemethod _create_and_populate_pin {pin} {
        #** Create a tab for a  pin and populate it.
        #
        # @param pin The pin XML element.
        
        incr pincount
        set fr pin$pincount
        set f [$pin attribute frame]
        if {$f eq {}} {
            set attrs [$pin cget -attributes]
            lappend attrs frame $fr
            $pin configure -attributes $attrs
        } else {
            set attrs [$pin cget -attributes]
            set findx [lsearch -exact $attrs frame]
            incr findx
            set attrs [lreplace $attrs $findx $findx $fr]
            $pin configure -attributes $attrs
        }
        set pinframe [ttk::frame \
                      $pins.$fr]
        $pins add $pinframe \
              -text [_ "Pin %d" $pincount] -sticky news
        set pinno_ [LabelComboBox $pinframe.pinno \
                    -label [_m "Label|GPIO Pin Number"] \
                    -values [GPIOPinNo AllPins]]
        $pinno_ set [lindex [GPIOPinNo AllPins] 0]
        pack $pinno_ -fill x -expand yes
        set pinno [$pin getElementsByTagName "number"]
        if {[llength $pinno] == 1} {
            $pinno_ set [$pinno data]
        }
        set pinmode_ [LabelComboBox $pinframe.pinmode \
                      -label [_m "Label|Pin Mode"] \
                      -values [PinModes cget -values]]
        pack $pinmode_ -fill x -expand yes
        $pinmode_ set [lindex [PinModes cget -values] 0]
        set pinmode [$pin getElementsByTagName "mode"]
        if {[llength $pinno] == 1} {
            $pinmode_ set [$pinmode data]
        }
        set description_ [LabelEntry $pinframe.description \
                          -label [_m "Label|Description"]]
        pack $description_ -fill x -expand yes
        set description [$pin getElementsByTagName "description"]
        if {[llength $description] == 1} {
            $description_ configure -text [$description data]
        }
        set pinin0_ [LabelEntry $pinframe.pinin0 \
                       -label [_m "Label|Pin Low In Event"]]
        pack $pinin0_ -fill x -expand yes
        set pinin0 [$pin getElementsByTagName "pinin0"]
        if {[llength $pinin0] == 1} {
            $pinin0_ configure -text [$pinin0 data]
        }
        set pinin1_ [LabelEntry $pinframe.pinin1 \
                        -label [_m "Label|Pin High In Event"]]
        pack $pinin1_ -fill x -expand yes
        set pinin1 [$pin getElementsByTagName "pinin1"]
        if {[llength $pinin1] == 1} {
            $pinin1_ configure -text [$pinin1 data]
        }
        set pinout0_ [LabelEntry $pinframe.pinout0 \
                       -label [_m "Label|Pin Low Out Event"]]
        pack $pinout0_ -fill x -expand yes
        set pinout0 [$pin getElementsByTagName "pinout0"]
        if {[llength $pinout0] == 1} {
            $pinout0_ configure -text [$pinout0 data]
        }
        set pinout1_ [LabelEntry $pinframe.pinout1 \
                        -label [_m "Label|Pin High Out Event"]]
        pack $pinout1_ -fill x -expand yes
        set pinout1 [$pin getElementsByTagName "pinout1"]
        if {[llength $pinout1] == 1} {
            $pinout1_ configure -text [$pinout1 data]
        }
        set delpin [ttk::button $pinframe.deletepin \
                       -text [_m "Label|Delete pin"] \
                       -command [mytypemethod _deletepin $pin]]
        pack $delpin -fill x
    }
    typemethod _addblankpin {} {
        #** Create a new blank pin.
        
        set cdis [$configuration getElementsByTagName OpenLCB_PiMCP23017 -depth 1]
        set cdi [lindex $cdis 0]
        set pin [SimpleDOMElement %AUTO% -tag "pin"]
        $cdi addchild $pin
        $type _create_and_populate_pin $pin
    }
    typemethod _deletePin {pin} {
        #** Delete a pin
        #
        # @param pin The pin's XML element.
        
        set fr [$pin attribute frame]
        set cdis [$configuration getElementsByTagName OpenLCB_PiMCP23017 -depth 1]
        set cdi [lindex $cdis 0]
        $cdi removeChild $pin
        $pins forget $pins.$fr
        destroy $pins.$fr
    }
    
    
    
    #*** Pin instances
    variable oldPin 0;# The saved value of the pin (input mode only)
    option -pinnumber -readonly yes -type GPIOPinNo -default 0
    option -pinmode -readonly yes -type PinModes -default disabled
    option -pinin0 -type lcc::EventID_or_null -readonly yes -default {}
    option -pinin1 -type lcc::EventID_or_null -readonly yes -default {}
    option -pinout0 -type lcc::EventID_or_null -readonly yes -default {}
    option -pinout1 -type lcc::EventID_or_null -readonly yes -default {}
    option -description -readonly yes -default {}
    constructor {args} {
        # Construct an instance for a GPIO pin
        #
        # @param ... Options:
        # @arg -pinnumber The pin number
        # @arg -pinmode   The pin's mode
        # @arg -pinin0    Event ID to send when the pin's input value goes to 0.
        # @arg -pinin1    Event ID to send when the pin's input value goes to 1.
        # @arg -pinout0   Event ID to trigger setting the pin's output to 0.
        # @arg -pinout1   Event ID to trigger setting the pin's output to 1.
        # @arg -description Description of the pin.
        # @par
        
        $self configurelist $args
        set gpiopinno [GPIOPinNo gpioPinNo [$self cget -pinnumber]]
        switch [$self cget -pinmode] {
            in {
                pinMode $gpiopinno $::INPUT
                pullUpDnControl $gpiopinno $::PUD_UP
            }
            out {
                pinMode $gpiopinno $::OUTPUT
            } 
            high {
                pinMode $gpiopinno $::OUTPUT
                digitalWrite $gpiopinno $::HIGH
            }
            low  {
                pinMode $gpiopinno $::OUTPUT
                digitalWrite $gpiopinno $::LOW
            }
        }
    }
    method initpinval {} {
        set oldPin [digitalRead [GPIOPinNo gpioPinNo [$self cget -pinnumber]]]
    }
    method readsensor {event} {
        ::log::log debug "*** $self readsensor $event"
        ::log::log debug "*** $self readsensor: pinmode is [$self cget -pinmode]"
        if {[$self cget -pinmode] ne "in"} {return [list {} unknown]}
        set events [list]
        set state [digitalRead [GPIOPinNo gpioPinNo [$self cget -pinnumber]]]
        ::log::log debug "*** $self readsensor: state is $state"
        set ev0 [$self cget -pinin0]
        ::log::log debug "*** $self readsensor: ev0 is $ev0"
        if {$ev0 ne {}} {
            if {$event eq "*" || [$event match $ev0]} {
                if {$state == 0} {
                    lappend events [list $ev0 valid]
                } else {
                    lappend events [list $ev0 invalid]
                }
            }
        }
        set ev1 [$self cget -pinin1]
        ::log::log debug "*** $self readsensor: ev1 is $ev1"
        if {$ev1 ne {}} {
            if {$event eq "*" || [$event match $ev1]} {
                if {$state == 1} {
                    lappend events [list $ev1 valid]
                } else {
                    lappend events [list $ev1 invalid]
                }
            }
        }
        return $events
    }
    method Poll {} {
        #** Poll the pin
        
        if {[$self cget -pinmode] ne "in"} {return}
        set v [digitalRead [GPIOPinNo gpioPinNo [$self cget -pinnumber]]]
        if {$v != $oldPin} {
            set oldPin $v
            set event [$self cget -pinin$oldPin]
            if {$event ne {}} {
                $type sendEvent $event
            }
        }
    }
    method consumeEvent {event} {
        #** Handle an incoming event.
        #
        # @param event The event to handle.
        
        ::log::log debug "*** $self consumeEvent $event"
        if {[$event match [$self cget -pinout0]]} {
            digitalWrite [GPIOPinNo gpioPinNo [$self cget -pinnumber]] 0
            return true
        } elseif {[$event match [$self cget -pinout1]]} {
            digitalWrite [GPIOPinNo gpioPinNo [$self cget -pinnumber]] 1
            return true
        }
        return false
    }
}

vwait forever

