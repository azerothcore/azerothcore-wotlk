/**
 @file G3DGameUnits.h

 @maintainer Morgan McGuire, http://graphics.cs.williams.edu
 @created 2002-10-05
 @edited  2012-02-19
 */

#ifndef G3D_GAMEUNITS_H
#define G3D_GAMEUNITS_H

#include "G3D/platform.h"

namespace G3D {

/** \deprecated use SimTime */
typedef double GameTime;

/**
 Time, in seconds.
 */
typedef double SimTime;

/**
 Actual wall clock time in seconds (Unix time).
 */
typedef double RealTime;

enum AMPM {AM, PM};

/**
 Converts a 12 hour clock time into the number of seconds since 
 midnight.  Note that 12:00 PM is noon and 12:00 AM is midnight.

 Example: <CODE>toSeconds(10, 00, AM)</CODE>
 */
SimTime toSeconds(int hour, int minute, double seconds, AMPM ap);
SimTime toSeconds(int hour, int minute, AMPM ap);

}

#endif
