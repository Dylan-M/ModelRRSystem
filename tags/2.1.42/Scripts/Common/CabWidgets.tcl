#* 
#* ------------------------------------------------------------------
#* CabWidgets.tcl - Cab Widgets (loco speed, direction, loco address, DCC programming, etc.)
#* Created by Robert Heller on Fri Mar 23 12:51:49 2012
#* ------------------------------------------------------------------
#* Modification History: $Log$
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

package require BWidget
package require snit
package require gettext

## @addtogroup TclCommon
# @{

namespace eval CabWidgets {
##
# @brief Cab Widget code
#
# Contains various widgets related to DCC (or CD) Cab panels, including
# locomotive speed, direction, locomotive address, and DCC Programming 
# features.
#
# @author Robert Heller \<heller\@deepsoft.com\>
#
# @section CabWidgets_package Package provided
#
# CabWidgets 1.0
#

  snit::widget LocomotiveSpeed {
  ## @brief Locomotive Speed widget.
  #
  # This widget implements Locomotive Speed control / display.  There are buttons
  # for increasing or decreasing speed either by units of 1 or by units of 10.
  # Plus there is a bar showing the current relative speed.
  #
  # @param path Pathname of the widget.
  # @param ... Options:
  # @arg -command Script to call when the speed is changed.  The new speed is
  #      appended.
  # @par
  # @author Robert Heller \<heller\@deepsoft.com\>
  #
  
    widgetclass LocomotiveSpeed
    hulltype frame
    component leftbuttons
      ## @privatesection Left buttons component (small incrments).
    component   up1
      ## Up by one button.
    component   down1
      ## Down by one button.
    component rightbuttons
      ## Right buttons component (larger incrments).
    component   up10
      ## Up by ten button.
    component   down10
      ## Down by one button.
    component bar
      ## Current speed bar.
    component stop
      ## Stop button.
  
    typevariable _up {
#define up_width 32
#define up_height 32
    static unsigned char up_bits[] = {
       0x00, 0x80, 0x00, 0x00, 0x00, 0xc0, 0x01, 0x00, 0x00, 0xc0, 0x01, 0x00,
       0x00, 0xe0, 0x03, 0x00, 0x00, 0xe0, 0x03, 0x00, 0x00, 0xf0, 0x07, 0x00,
       0x00, 0xf0, 0x0f, 0x00, 0x00, 0xf8, 0x0f, 0x00, 0x00, 0xfc, 0x1f, 0x00,
       0x00, 0xfc, 0x3f, 0x00, 0x00, 0xfe, 0x3f, 0x00, 0x00, 0xfe, 0x7f, 0x00,
       0x00, 0xff, 0x7f, 0x00, 0x80, 0xff, 0xff, 0x00, 0x80, 0xff, 0xff, 0x01,
       0xc0, 0xff, 0xff, 0x01, 0xc0, 0xff, 0xff, 0x03, 0xe0, 0xff, 0xff, 0x03,
       0xe0, 0xff, 0xff, 0x07, 0xf0, 0xff, 0xff, 0x0f, 0xf8, 0xff, 0xff, 0x0f,
       0xf8, 0xff, 0xff, 0x1f, 0xfc, 0xff, 0xff, 0x3f, 0xfc, 0xff, 0xff, 0x3f,
       0xfe, 0xff, 0xff, 0x7f, 0xfe, 0xff, 0xff, 0x7f, 0xff, 0xff, 0xff, 0xff,
       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    }
      ## Bitmap for up button.
    typevariable _down {
#define down_width 32
#define down_height 32
  static unsigned char down_bits[] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
     0xfe, 0xff, 0xff, 0x7f, 0xfe, 0xff, 0xff, 0x7f, 0xfc, 0xff, 0xff, 0x3f,
     0xfc, 0xff, 0xff, 0x3f, 0xf8, 0xff, 0xff, 0x1f, 0xf0, 0xff, 0xff, 0x1f,
     0xf0, 0xff, 0xff, 0x0f, 0xe0, 0xff, 0xff, 0x07, 0xc0, 0xff, 0xff, 0x07,
     0xc0, 0xff, 0xff, 0x03, 0x80, 0xff, 0xff, 0x03, 0x80, 0xff, 0xff, 0x01,
     0x00, 0xff, 0xff, 0x01, 0x00, 0xfe, 0xff, 0x00, 0x00, 0xfe, 0x7f, 0x00,
     0x00, 0xfc, 0x7f, 0x00, 0x00, 0xfc, 0x3f, 0x00, 0x00, 0xf8, 0x3f, 0x00,
     0x00, 0xf0, 0x1f, 0x00, 0x00, 0xf0, 0x0f, 0x00, 0x00, 0xe0, 0x0f, 0x00,
     0x00, 0xc0, 0x07, 0x00, 0x00, 0xc0, 0x07, 0x00, 0x00, 0x80, 0x03, 0x00,
     0x00, 0x80, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00};
    }
      ## Bitmap for down button.
    typevariable _up10 {
#define up10_width 32
#define up10_height 32
  static unsigned char up10_bits[] = {
     0x00, 0x80, 0x00, 0x00, 0x00, 0xc0, 0x01, 0x00, 0x00, 0xe0, 0x07, 0x00,
     0x00, 0xf8, 0x0f, 0x00, 0x00, 0xfc, 0x1f, 0x00, 0x00, 0xfe, 0x3f, 0x00,
     0x00, 0xff, 0x7f, 0x00, 0x80, 0xff, 0xff, 0x01, 0xc0, 0xff, 0xff, 0x03,
     0xe0, 0xff, 0xff, 0x07, 0xf8, 0xff, 0xff, 0x0f, 0xfc, 0xff, 0xff, 0x3f,
     0xfe, 0xff, 0xff, 0x7f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00,
     0x00, 0xc0, 0x01, 0x00, 0x00, 0xe0, 0x07, 0x00, 0x00, 0xf8, 0x0f, 0x00,
     0x00, 0xfc, 0x1f, 0x00, 0x00, 0xfe, 0x3f, 0x00, 0x00, 0xff, 0x7f, 0x00,
     0x80, 0xff, 0xff, 0x01, 0xc0, 0xff, 0xff, 0x03, 0xe0, 0xff, 0xff, 0x07,
     0xf8, 0xff, 0xff, 0x0f, 0xfc, 0xff, 0xff, 0x3f, 0xfe, 0xff, 0xff, 0x7f,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    }
      ## Bitmap for fast up button.
    typevariable _down10 {
#define down10_width 32
#define down10_height 32
  static unsigned char down10_bits[] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfe, 0xff, 0xff, 0x7f,
     0xfc, 0xff, 0xff, 0x3f, 0xf0, 0xff, 0xff, 0x1f, 0xe0, 0xff, 0xff, 0x07,
     0xc0, 0xff, 0xff, 0x03, 0x80, 0xff, 0xff, 0x01, 0x00, 0xfe, 0xff, 0x00,
     0x00, 0xfc, 0x7f, 0x00, 0x00, 0xf8, 0x3f, 0x00, 0x00, 0xf0, 0x1f, 0x00,
     0x00, 0xe0, 0x07, 0x00, 0x00, 0x80, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00,
     0x00, 0x00, 0x00, 0x00, 0xfe, 0xff, 0xff, 0x7f, 0xfc, 0xff, 0xff, 0x3f,
     0xf0, 0xff, 0xff, 0x1f, 0xe0, 0xff, 0xff, 0x07, 0xc0, 0xff, 0xff, 0x03,
     0x80, 0xff, 0xff, 0x01, 0x00, 0xfe, 0xff, 0x00, 0x00, 0xfc, 0x7f, 0x00,
     0x00, 0xf8, 0x3f, 0x00, 0x00, 0xf0, 0x1f, 0x00, 0x00, 0xe0, 0x07, 0x00,
     0x00, 0x80, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00};
    }
      ## Bitmap for fast down button.
    typevariable _stop {
#define stop_width 32
#define stop_height 32
  static unsigned char stop_bits[] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0xf8, 0x0f, 0x00, 0x00, 0xfe, 0x3f, 0x00,
     0x80, 0xff, 0xff, 0x00, 0xc0, 0xff, 0xff, 0x01, 0xf0, 0xff, 0xff, 0x07,
     0xf0, 0xff, 0xff, 0x07, 0xf8, 0xff, 0xff, 0x0f, 0xfc, 0xff, 0xff, 0x1f,
     0xfc, 0xff, 0xff, 0x1f, 0xfe, 0xff, 0xff, 0x3f, 0xfe, 0xff, 0xff, 0x3f,
     0xff, 0xff, 0xff, 0x7f, 0xff, 0xff, 0xff, 0x7f, 0xff, 0xff, 0xff, 0x7f,
     0xff, 0xff, 0xff, 0x7f, 0xff, 0xff, 0xff, 0x7f, 0xff, 0xff, 0xff, 0x7f,
     0xff, 0xff, 0xff, 0x7f, 0xff, 0xff, 0xff, 0x7f, 0xff, 0xff, 0xff, 0x7f,
     0xfe, 0xff, 0xff, 0x3f, 0xfe, 0xff, 0xff, 0x3f, 0xfc, 0xff, 0xff, 0x1f,
     0xfc, 0xff, 0xff, 0x1f, 0xf8, 0xff, 0xff, 0x0f, 0xf0, 0xff, 0xff, 0x07,
     0xf0, 0xff, 0xff, 0x07, 0xc0, 0xff, 0xff, 0x01, 0x80, 0xff, 0xff, 0x00,
     0x00, 0xfe, 0x3f, 0x00, 0x00, 0xf8, 0x0f, 0x00};
    }
      ## Bitmap for fast down button.
    variable _speed 0
    ## The current speed.
    method speed {} {
    ## @publicsection Method to return the current speed.
    #
      return $_speed
    }
  
    method setspeed {speed} {
    ## Method to set the sensed speed.
    #
      set _speed $speed
    }
  
    option -command -default {}
  
    constructor {args} {
    ## Build and install all component widgets and process configuration.
    # @param ... Argument list (option value pairs).  Gets passed to the
    #      implicitly defined configurelist method.
  
      install leftbuttons using ButtonBox $win.leftbuttons \
  		-orient vertical -spacing 25
      pack $leftbuttons -side left -fill y -expand yes
      set up1 [$leftbuttons add -name up -image [image create bitmap -data $_up] \
  			-command [mymethod _up1]]
      set down1 [$leftbuttons add -name down \
  				-image [image create bitmap -data $_down] \
  				-command [mymethod _down1]]
      install rightbuttons using ButtonBox $win.rightbuttons \
  		-orient vertical -spacing 25
      pack $rightbuttons -side right -fill y -expand yes
      set up10 [$rightbuttons add -name up \
  			-image [image create bitmap -data $_up10] \
  			-command [mymethod _up10]]
      set down10 [$rightbuttons add -name down \
  				-image [image create bitmap -data $_down10] \
  				-command [mymethod _down10]]    
      pack [frame $win.middle -borderwidth 0] -fill y -expand yes
      install bar using scale $win.middle.bar \
  		-from 128 -to 0 -length 200 \
  		-variable [myvar _speed] -orient vertical \
  		-label [_m "Label|Speed"] -command [mymethod _setspeed] \
  		-showvalue 1
      pack $bar -fill y -expand yes
      install stop using Button $win.middle.stop \
  		-image [image create bitmap -data $_stop -foreground red -background {}] \
  		-command [mymethod _stop]
      pack $stop -side bottom
      $self configurelist $args
    }
    method _setspeed {newspeed} {
      ## @private Set the speed, bound to the bar -command option.
      set _speed [expr {int($newspeed)}]
      $self invoke
    }
    method invoke {} {
    ## Method to invoke the widget.  This calls the script (if any) defined by
    # the -command option.
  
      if {$options(-command) ne ""} {
        set cmd [concat $options(-command) $_speed]
        uplevel #0 $cmd
      }
    }
    method _stop {} {
      ## @privatesection Stop method, bound to the stop button.
      set _speed 0
      $self invoke
    }
    method _up1 {} {
      ## Up by one method, bound to the slow up button.
      incr _speed 1
      if {$_speed > 128} {set _speed 128}
      $self invoke
    }
    method _up10 {} {
      ## Up by 10 method, bound to the fast up button.
      incr _speed 10
      if {$_speed > 128} {set _speed 128}
      $self invoke
    }
    method _down1 {} {
      ## Down by one method, bound to the slow down button.
      incr _speed -1
      if {$_speed < 0} {set _speed 0}
      $self invoke
    }
    method _down10 {} {
      ## Down by one method, bound to the fast down button.
      incr _speed -10
      if {$_speed < 0} {set _speed 0}
      $self invoke
    }
  }
  
  snit::widget LocomotiveDirection {
  ## @brief Locomotive Direction widget.
  #
  # This widget implements Locomotive Direction control / display.  There are 
  # buttons for selecting the direction and the current direction is displayed.
  #
  # @param path Pathname of the widget.
  # @param ... Options:
  # @arg -command Script to call when the direction is changed.  The new 
  # direction is appended.
  # @par
  # @author Robert Heller \<heller\@deepsoft.com\>
  #
  
    widgetclass LocomotiveDirection
    hulltype frame
    component reverse
      ## @privatesection Reverse button component.
    component currentDirection
      ## Current direction label component.
    component forward
      ## Forward button component.
  
    typevariable _left {
#define left_width 32
#define left_height 32
  static unsigned char left_bits[] = {
     0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0xc0, 0x07,
     0x00, 0x00, 0xe0, 0x07, 0x00, 0x00, 0xf8, 0x07, 0x00, 0x00, 0xfc, 0x07,
     0x00, 0x00, 0xff, 0x07, 0x00, 0xc0, 0xff, 0x07, 0x00, 0xe0, 0xff, 0x07,
     0x00, 0xf8, 0xff, 0x07, 0x00, 0xfe, 0xff, 0x07, 0x00, 0xff, 0xff, 0x07,
     0xc0, 0xff, 0xff, 0x07, 0xe0, 0xff, 0xff, 0x07, 0xf8, 0xff, 0xff, 0x07,
     0xfe, 0xff, 0xff, 0x07, 0xff, 0xff, 0xff, 0x07, 0xfe, 0xff, 0xff, 0x07,
     0xf8, 0xff, 0xff, 0x07, 0xe0, 0xff, 0xff, 0x07, 0x80, 0xff, 0xff, 0x07,
     0x00, 0xff, 0xff, 0x07, 0x00, 0xfc, 0xff, 0x07, 0x00, 0xf0, 0xff, 0x07,
     0x00, 0xe0, 0xff, 0x07, 0x00, 0x80, 0xff, 0x07, 0x00, 0x00, 0xfe, 0x07,
     0x00, 0x00, 0xf8, 0x07, 0x00, 0x00, 0xf0, 0x07, 0x00, 0x00, 0xc0, 0x07,
     0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x04};
    }
      ## Left bitmap (reverse button).
    typevariable _right {
#define right_width 32
#define right_height 32
  static unsigned char right_bits[] = {
     0x20, 0x00, 0x00, 0x00, 0xe0, 0x00, 0x00, 0x00, 0xe0, 0x03, 0x00, 0x00,
     0xe0, 0x07, 0x00, 0x00, 0xe0, 0x1f, 0x00, 0x00, 0xe0, 0x3f, 0x00, 0x00,
     0xe0, 0xff, 0x00, 0x00, 0xe0, 0xff, 0x03, 0x00, 0xe0, 0xff, 0x07, 0x00,
     0xe0, 0xff, 0x1f, 0x00, 0xe0, 0xff, 0x7f, 0x00, 0xe0, 0xff, 0xff, 0x00,
     0xe0, 0xff, 0xff, 0x03, 0xe0, 0xff, 0xff, 0x07, 0xe0, 0xff, 0xff, 0x1f,
     0xe0, 0xff, 0xff, 0x7f, 0xe0, 0xff, 0xff, 0xff, 0xe0, 0xff, 0xff, 0x7f,
     0xe0, 0xff, 0xff, 0x1f, 0xe0, 0xff, 0xff, 0x07, 0xe0, 0xff, 0xff, 0x01,
     0xe0, 0xff, 0xff, 0x00, 0xe0, 0xff, 0x3f, 0x00, 0xe0, 0xff, 0x0f, 0x00,
     0xe0, 0xff, 0x07, 0x00, 0xe0, 0xff, 0x01, 0x00, 0xe0, 0x7f, 0x00, 0x00,
     0xe0, 0x1f, 0x00, 0x00, 0xe0, 0x0f, 0x00, 0x00, 0xe0, 0x03, 0x00, 0x00,
     0xe0, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00};
    }
      ## Right bitmap (forward button).
    variable _direction Forward
    ## The current direction
    method direction {} {
      ## @publicsection Return the current direction.
      return $_direction
    }
  
    option -command -default {}
  
    constructor {args} {
    ## Build and install all component widgets and process configuration.
    # @param ... Argument list (option value pairs).  Gets passed to the
    #      implicitly defined configurelist method.
  
      install reverse using Button $win.reverse \
  		-image [image create bitmap -data $_left -background {}] \
  		-command [mymethod _setdirection [_ "Reverse"]]
      pack $reverse -side left
      install currentDirection using Label $win.currentDirection \
  		-textvariable [myvar _direction] \
      		-font {Courier -30 bold roman}
      pack $currentDirection -side left
      install forward using Button $win.forward \
  		-image [image create bitmap -data $_right -background {}] \
  		-command [mymethod _setdirection [_ "Forward"]]
      pack $forward -side right
      $self configurelist $args
      set _direction [_ "Forward"]
    }
    method invoke {} {
    ## Method to invoke the widget.  This calls the script (if any) defined by
    # the -command option.
  
      if {$options(-command) ne ""} {
        set cmd [concat $options(-command) $_direction]
        uplevel #0 $cmd
      }
    }
    method _setdirection {dir} {
      ## @private Set the current direction. Bound to direction buttons.
      # @param dir Localized string containing the direction.
      set _direction $dir
      $self invoke
    }
    method direction_sense {dir} {
    ## Method to set the sensed direction.
    # @param dir The localized direction to set.
      if {[lsearch [list [_ "Forward"] [_ "Reverse"]] $dir] < 0} {return}
      set _direction $dir
    }
        
  }
  
  snit::integer ::CabWidgets::LocomotiveAddress -min 1 -max 9999
  ## Locomotive addresses
  
  snit::widget SelectLocomotive {
  ## @brief Select or enter a Locomotive address
  #
  # This widget implements a Locomotive address selection widget. A Locomotive is 
  # selected from a drop down or a new address is entered. When a new address is
  # entered, it is saved in the drop down list.  The maximum number of saved
  # addresses is configurable.
  #
  # @param path Pathname of the widget.
  # @param ... Options:
  # @arg -command Script to call when the address is changed.  The new address
  # is appended.
  # @arg -maxsaved The maximum number of addresses to save. Default 6.
  # @arg -label The label to use.
  # @arg -labelwidth The width of the label.
  # @arg -defaultlist The list of default loco addresses.  Readonly. Default {3}.
  # @par
  # @author Robert Heller \<heller\@deepsoft.com\>
  #
  
    widgetclass SelectLocomotive
    hulltype frame
    component lf
      ## @privatesection LabelFrame component.
    component   locoList
      ## Locolist Combobox component.
  
    delegate option -label to lf as -text
    delegate option -labelwidth to lf as -width
    option -command -default {}
    option -defaultlist -default {3} -readonly yes \
  	 -type {snit::listtype -type ::CabWidgets::LocomotiveAddress}
    option -maxsaved -default 6 -type {snit::integer -min 0 -max 100} \
  		   -configuremethod _trimList
    method _trimList {option value} {
      ## Configure method for -maxsaved.  Trim the list if needed.
      # @param option The option name.
      # @param value The new value.
      set options($option) $value
      set savedLocos [$locoList cget -values]
      set l [llength $savedLocos]
      if {$l > $value} {
        set s [expr {$l - $value}]
        $locoList configure -values [lrange $savedLocos $s end]
        $locoList setvalue last
      }
    }
  
    constructor {args} {
      ## @publicsection Constructor.
      # @param path Widget path.
      # @param ... Options.
      install lf using LabelFrame $win.lf
      pack $lf -fill x -expand yes
      install locoList using ComboBox [$lf getframe].locoList -editable yes \
  				-command [mymethod _addnewloco] \
  				-modifycmd [mymethod invoke]
      pack  $locoList -side left -fill x
      $self configurelist $args
      $locoList configure -values $options(-defaultlist)
      $locoList setvalue last
    }
    
    method _addnewloco {} {
      ## @private Add new loco. Bound to the locoList ComboBox entry.
      set newloco [$locoList cget -text]
      if {[catch {::CabWidgets::LocomotiveAddress validate $newloco}]} {
        tk_messageBox -type ok -icon error -message [_ "Not a valid address: %s" $newloco]
        return
      }
      puts stderr "*** $self _addnewloco: newloco = $newloco"
      set savedLocos [$locoList cget -values]
      puts stderr "*** $self _addnewloco: savedLocos (initial) $savedLocos"
      set indx [lsearch -exact $savedLocos $newloco]
      puts stderr "*** $self _addnewloco: indx = $indx"
      if {$indx >= 0} {
        $locoList setvalue @$indx
      } else {
        lappend savedLocos $newloco
        puts stderr "*** $self _addnewloco: savedLocos (updated) $savedLocos"
        set l [llength $savedLocos]
        if {$l > $options(-maxsaved)} {
          set s [expr {$l - $options(-maxsaved)}]
          set savedLocos [lrange $savedLocos $s end]
        }
        $locoList configure -values $savedLocos
        $locoList setvalue last
      }
      $self invoke
    }
    method currentLocomotive  {} {
    ## Method to return the current locomotive address
    #
      return [$locoList cget -text]
    }
    method invoke {} {
    ## Method to invoke the widget.  This calls the script (if any) defined by
    # the -command option.
  
      if {$options(-command) ne ""} {
	set cmd [concat $options(-command) [$self currentLocomotive]]
	uplevel #0 $cmd
      }
    
    }
  }
}
  
## @}
  
package provide CabWidgets 1.0
  
