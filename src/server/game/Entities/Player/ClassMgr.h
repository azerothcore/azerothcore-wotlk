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

#ifndef __ACORE_CLASSMGR_H
#define __ACORE_CLASSMGR_H

#include "DatabaseEnv.h"
#include "ObjectGuid.h"
#include "SharedDefines.h"
#include <map>

class Player;
class WorldPacket;

class ClassMgr
{
private:
    ClassMgr();
    ~ClassMgr();

public:
    static ClassMgr* instance();

    static void LoadClasses();
    static uint8 GetMaxClasses() { return _maxClasses; }
    static void SetMaxClasses(uint8 max) { _maxClasses = max; }
    static uint32 GetPlayableClassMask() { return _playableClassMask; }
private:
    static uint8 _maxClasses; // Max playable class + 1

    static uint32 _playableClassMask;
};

#define sClassMgr ClassMgr::instance()

#endif
