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

#include "MiscPackets.h"

WorldPackets::Misc::Weather::Weather() : ServerPacket(SMSG_WEATHER, 4 + 4 + 1) { }

WorldPackets::Misc::Weather::Weather(WeatherState weatherID, float intensity /*= 0.0f*/, bool abrupt /*= false*/)
    : ServerPacket(SMSG_WEATHER, 4 + 4 + 1), Abrupt(abrupt), Intensity(intensity), WeatherID(weatherID) { }

WorldPacket const* WorldPackets::Misc::Weather::Write()
{
    _worldPacket << uint32(WeatherID);
    _worldPacket << float(Intensity);
    _worldPacket << uint8(Abrupt);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Misc::LevelUpInfo::Write()
{
    _worldPacket << uint32(Level);
    _worldPacket << uint32(HealthDelta);

    for (uint32 power : PowerDelta)
        _worldPacket << power;

    for (uint32 stat : StatDelta)
        _worldPacket << stat;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Misc::PlayMusic::Write()
{
    _worldPacket << SoundKitID;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Misc::PlayObjectSound::Write()
{
    _worldPacket << SoundKitID;
    _worldPacket << SourceObjectGUID;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Misc::Playsound::Write()
{
    _worldPacket << SoundKitID;

    return &_worldPacket;
}

void WorldPackets::Misc::RandomRollClient::Read()
{
    _worldPacket >> Min;
    _worldPacket >> Max;
}

WorldPacket const* WorldPackets::Misc::RandomRoll::Write()
{
    _worldPacket << uint32(Min);
    _worldPacket << uint32(Max);
    _worldPacket << uint32(Result);
    _worldPacket << Roller;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Misc::StartMirrorTimer::Write()
{
    _worldPacket << uint32(Timer);
    _worldPacket << uint32(Value);
    _worldPacket << uint32(MaxValue);
    _worldPacket << int32(Scale);
    _worldPacket << uint8(Paused);
    _worldPacket << uint32(SpellID);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Misc::PauseMirrorTimer::Write()
{
    _worldPacket << uint32(Timer);
    _worldPacket << uint8(Paused);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Misc::StopMirrorTimer::Write()
{
    _worldPacket << uint32(Timer);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Misc::CrossedInebriationThreshold::Write()
{
    _worldPacket << Guid;
    _worldPacket << uint32(Threshold);
    _worldPacket << uint32(ItemID);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Misc::UITime::Write()
{
    _worldPacket << uint32(Time);

    return &_worldPacket;
}
