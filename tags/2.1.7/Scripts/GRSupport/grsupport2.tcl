#* 
#* ------------------------------------------------------------------
#* grsupport2.tcl - Graphics Support Version 2
#* Created by Robert Heller on Tue Jan 23 16:51:22 2007
#* ------------------------------------------------------------------
#* Modification History: $Log$
#* Modification History: Revision 1.1  2007/02/01 20:00:54  heller
#* Modification History: Lock down for Release 2.1.7
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

package require snit
package require Tk

namespace eval GRSupport {
  variable PI2 [expr {acos(0.0)}]
  variable PI  [expr {$PI2 * 2.0}]

  proc DegreesToRadians {degrees} {
    variable PI
    return [expr {(double($degrees) / 180.0) * $PI}]
  }
}

snit::macro GRSupport::VerifyDoubleMethod {} {
  method _VerifyDouble {option value} {
    if {[string is double -strict "$value"]} {
      return $value
    } else {
      error "Expected a double for $option, but got $value!"
    }
  }
}

snit::macro GRSupport::VerifyBooleanMethod {} {
  method _VerifyBoolean {option value} {
    if {[string is boolean -strict "$value"]} {
      return $value
    } else {
      error "Expected a boolean for $option, but got $value!"
    }
  }
}

snit::macro GRSupport::VerifyIntegerMethod {} {
  method _VerifyInteger {option value} {
    if {[string is integer -strict "$value"]} {
      return $value
    } else {
      error "Expected a integer for $option, but got $value!"
    }
  }
}

snit::macro GRSupport::VerifyOrientationHVMethod {} {
  method _VerifyOrientationHV {option value} {
    if {[lsearch -exact {horizontal vertical} "$value"] < 0} {
      error "Expected an orientation (horizontal or vertical) for $option, but got $value!"
    } else {
      return $value
    }
  }
}

snit::macro GRSupport::VerifyColorMethod {} {
  method _VerifyColor {option value} {
    if {[catch {winfo rgb . "$value"}]} {
      error "Expected a color for $option, got $value!"
    } else {
      return "$value"
    }
  }
}

package provide grsupport 2.0
