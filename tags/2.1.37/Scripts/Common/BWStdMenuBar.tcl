#* 
#* ------------------------------------------------------------------
#* BWStdMenuBar.tcl - BWidget version of StdMenuBar
#* Created by Robert Heller on Sun Feb  5 14:36:04 2006
#* ------------------------------------------------------------------
#* Modification History: $Log$
#* Modification History: Revision 1.2  2007/04/19 17:23:23  heller
#* Modification History: April 19 Lock Down
#* Modification History:
#* Modification History: Revision 1.1  2006/02/06 00:20:44  heller
#* Modification History: Start converting to BWidget from Tix
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

#@Chapter:BWStdMenuBar.tcl -- Create standard menubars
#@Label:BWStdMenuBar.tcl
#$Id$
# This file contains code to create a standard Motif style menubar.
# A standard menubar contains ``File'', ``Edit'', ``View'', ``Options'',
# and ``Help'' pulldown menus.  The ``File'', ``Edit'', and ``Help'' menus
# have standard menu items.
#
# The menubars and menus generated by the procedures in this file fill the
# standards set forth in the Motif Style Guide.

package require BWidget
package require gettext

namespace eval StdMenuBar {
# StdMenuBar BWidget class.
# [index] StdMenuBar!namespace

  Widget::define StdMenuBar BWStdMenuBar.tcl -classonly

  variable _menu
  # The name of the menu widget (not actually used).
  set _menu  .menu

  variable _std_file_menu
  # The standard basic File menu.
  set _std_file_menu [list \
    [_m "Menu|&File"] {file} {file} 0 [list \
        [list command [_m "Menu|File|&New"]     {file:new} ""     {Ctrl n}]\
        [list command [_m "Menu|File|&Open..."] {file:open} "" {Ctrl o}]\
        [list command [_m "Menu|File|&Save"]    {file:save} "" {Ctrl s}]\
	[list command [_m "Menu|File|Save &As..."] {file:save} "" {Ctrl a}]\
        [list command [_m "Menu|File|&Close"] {file:close} [_ "Close the application"] {}]\
        [list command [_m "Menu|File|E&xit"] {file:exit} [_ "Exit the application"] {}]\
    ] \
  ]

  variable _std_edit_menu
  # The standard basic Edit menu.
  set _std_edit_menu [list \
    [_m "Menu|&Edit"] {edit} {edit} 0 [list \
	[list command [_m "Menu|Edit|&Undo"] {edit:undo} [_ "Undo last change"] {Ctrl z}]\
	[list command [_m "Menu|Edit|Cu&t"] {edit:cut edit:havesel} [_ "Cut selection to the paste buffer"] {Ctrl x} -command StdMenuBar::EditCut]\
	[list command [_m "Menu|Edit|&Copy"] {edit:copy edit:havesel} [_ "Copy selection to the paste buffer"] {Ctrl c} -command StdMenuBar::EditCopy]\
	[list command [_m "Menu|Edit|C&lear"] {edit:clear edit:havesel} [_ "Clear selection"] {} -command StdMenuBar::EditClear]\
	[list command [_m "Menu|Edit|&Delete"] {edit:delete edit:havesel} [_ "Delete selection"] {Ctrl d}]\
	{separator}\
	[list command [_m "Menu|Edit|Select All"] {edit:selectall} [_ "Select everything"] {}]\
	[list command [_m "Menu|Edit|De-select All"] {edit:deselectall edit:havesel} [_ "Select nothing"] {}]\
    ]\
  ]

  variable _std_view_menu
  # The standard basic View menu.
  set _std_view_menu [list \
    [_m "Menu|&View"] {view} {view} 0 [list \
    ]\
  ]

  variable _std_options_menu
  # The standard basic Options menu.
  set _std_options_menu [list \
    [_m "Menu|&Options"] {options} {options} 0 [list \
    ]\
  ]

  variable _std_help_menu
  # The standard basic Help menu.
  set _std_help_menu [list \
    [_m "Menu|&Help"] {help} {help} 0 [list \
	[list command [_m "Menu|Help|On &Help..."] {help:help} [_ "Help on help"] {}]\
	[list command [_m "Menu|Help|On &Keys..."] {help:keys} [_ "Help on keyboard accelerators"] {}]\
	[list command [_m "Menu|Help|&Index..."] {help:index} [_ "Help index"] {}]\
	[list command [_m "Menu|Help|&Tutorial..."] {help:tutorial} [_ "Tutorial"] {}]\
	[list command [_m "Menu|Help|On &Version"] {help:version} [_ "Version"] {}]\
	[list command [_m "Menu|Help|Warranty"] {help:warranty} [_ "Warranty"] {}]\
	[list command [_m "Menu|Help|Copying"] {help:copying} [_ "Copying"] {}]\
    ]\
  ]


}

proc StdMenuBar::use {} {
# Dummy function.
}


proc StdMenuBar::MakeMenu {args} {
# Make a complete Standard Menu for the BW MainWindow widget.
# <in> args -- Menu overwrite options.  This is an alternating list of options
#	       and values. Each option is either one of the standard menu
#	       items (-file, -edit, -view, -options, or -help), in which
#	       case the value replaces the standard menu, or it is another 
#	       option, which introduces a new menu item to be added after the
#	       options menu item, after any other new menu item.  The value
#	       for these options is for a single menu item, as described in
#	       the documentation for the -menu option for the BWidget
#	       MainFrame: {menuname tags menuId tearoff menuentries...}.
# [index] StdMenuBar::MakeMenu!procedure

  variable _std_file_menu
  variable _std_edit_menu
  variable _std_view_menu
  variable _std_options_menu
  variable _std_help_menu
  set menu [list -file $_std_file_menu \
  		 -edit $_std_edit_menu \
		 -view $_std_view_menu \
		 -options $_std_options_menu \
		 -help $_std_help_menu \
		]
#  puts stderr "*** StdMenuBar::MakeMenu: menu = $menu"
  foreach {option value} $args {
    set index [lsearch -exact $menu $option]
#    puts stderr "*** StdMenuBar::MakeMenu: index = $index"
#    puts stderr "*** StdMenuBar::MakeMenu: option = $option"
#    puts stderr "*** StdMenuBar::MakeMenu: value = $value"
    if {$index < 0} {
      set hindex [lsearch -exact $menu -help]
      if {$hindex < 0} {
	lappend menu $option $value
      } else {
	set menu [lreplace $menu $hindex $hindex $option $value -help]
      }
    } else {
      set menu [lreplace $menu [expr $index + 1] [expr $index + 1] $value]
    }
  }
#  puts stderr "*** StdMenuBar::MakeMenu: menu = $menu"
  set result {}
  foreach {option value} $menu {
    eval [concat lappend result $value]
  }
#  puts stderr "*** StdMenuBar::MakeMenu: result = $result"
  return $result
}

proc StdMenuBar::EditCut {} {
# Handle the Cut item on the Edit menu.
# [index] StdMenuBar::EditCut!procedure

  set f "[::focus]"
  if {[string equal "$f" {}]} {return}
  catch "event generate $f <<Cut>>"
}
    
proc StdMenuBar::EditCopy {} {
# Handle the Copy item on the Edit menu.
# [index] StdMenuBar::EditCopy!procedure

  set f "[::focus]"
  if {[string equal "$f" {}]} {return}
  catch "event generate $f <<Copy>>"
}

proc StdMenuBar::EditPaste {} {
# Handle the Paste item on the Edit menu.
# [index] StdMenuBar::EditPaste!procedure

  set f "[::focus]"
  if {[string equal "$f" {}]} {return}
  catch "event generate $f <<Paste>>"
}

proc StdMenuBar::EditClear {} {
# Handle the Clear item on the Edit menu.
# [index] StdMenuBar::EditClear!procedure

  set f "[::focus]"
  if {[string equal "$f" {}]} {return}
  catch "event generate $f <<Clear>>"
}




package provide BWStdMenuBar 1.0
  




