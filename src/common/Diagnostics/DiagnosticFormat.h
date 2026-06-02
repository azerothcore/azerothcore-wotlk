/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef ACORE_DIAGNOSTIC_FORMAT_H
#define ACORE_DIAGNOSTIC_FORMAT_H

#include "Define.h"
#include "cbor.h"

// RFC 8949 encodes tags 0..23 as a single byte. Tags 6..15 are currently
// unassigned by IANA, and this stream is private to this process, so we use
// the low unassigned range for compact diagnostic record markers.
enum class DiagnosticTag : CborTag
{
    Open          = 6,
    Arg           = 7,
    Close         = 8,
    StringLiteral = 9
};

using DiagnosticSectionFooter = uint64;

#endif // ACORE_DIAGNOSTIC_FORMAT_H
