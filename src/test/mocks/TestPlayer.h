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

#ifndef AZEROTHCORE_TEST_PLAYER_H
#define AZEROTHCORE_TEST_PLAYER_H

#include "Player.h"

class TestPlayer : public Player
{
public:
    using Player::Player;

    void UpdateObjectVisibility(bool /*forced*/ = true, bool /*fromUpdate*/ = false) override { }

    void AddToWorld() override { Object::AddToWorld(); }
    void RemoveFromWorld() override { Object::RemoveFromWorld(); }

    void SaveToDB(bool /*create*/, bool /*logout*/) { }
    void SaveToDB(CharacterDatabaseTransaction /*trans*/, bool /*create*/, bool /*logout*/) { }

    void ForceInitValues(ObjectGuid::LowType guidLow = 1)
    {
        Object::_Create(guidLow, uint32(0), HighGuid::Player);
    }
};

#endif //AZEROTHCORE_TEST_PLAYER_H
