// -*- C++ -*-

//=============================================================================
/**
 *  @file    pre.h
 *
 *  @author Christopher Kohlhoff <chris@kohlhoff.com>
 *
 *  This file saves the original alignment rules and changes the alignment
 *  boundary to ACE's default.
 */
//=============================================================================

// No header guard
#if defined (_MSC_VER)
# pragma warning (disable:4103)
# pragma pack (push, 8)
#elif defined (__BORLANDC__)
# pragma option push -a8 -b -Ve- -Vx- -w-rvl -w-rch -w-ccc -w-obs -w-aus -w-pia -w-inl -w-sig
# if (__BORLANDC__ >= 0x660) && (__BORLANDC__ <= 0x680)
// False warning: Function defined with different linkage, reported to
// Embarcadero as QC 117740
#  pragma option push -w-8127
# endif
# pragma nopushoptwarn
# pragma nopackwarning
#endif
