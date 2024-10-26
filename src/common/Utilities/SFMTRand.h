/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef SFMTRand_h__
#define SFMTRand_h__

#include "Define.h"
#include <SFMT.h>
#include <new>

/*
 * C++ Wrapper for SFMT
 */
class SFMTRand
{
public:
    SFMTRand();
    uint32 RandomUInt32(); // Output random bits
    void* operator new(std::size_t size, std::nothrow_t const&);
    void operator delete(void* ptr, std::nothrow_t const&);
    void* operator new(std::size_t size);
    void operator delete(void* ptr);
    void* operator new[](std::size_t size, std::nothrow_t const&);
    void operator delete[](void* ptr, std::nothrow_t const&);
    void* operator new[](std::size_t size);
    void operator delete[](void* ptr);
private:
    sfmt_t _state;
};

#endif // SFMTRand_h__
