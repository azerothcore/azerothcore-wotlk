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

#include "LogMessage.h"
#include "StringFormat.h"
#include "Timer.h"

LogMessage::LogMessage(LogLevel _level, std::string const& _type, std::string&& _text)
    : level(_level), type(_type), text(std::forward<std::string>(_text)), mtime(time(nullptr))
{
}

LogMessage::LogMessage(LogLevel _level, std::string const& _type, std::string&& _text, std::string&& _param1)
    : level(_level), type(_type), text(std::forward<std::string>(_text)), param1(std::forward<std::string>(_param1)), mtime(time(nullptr))
{
}

std::string LogMessage::getTimeStr(time_t time)
{
    return Acore::Time::TimeToTimestampStr(Seconds(time), "%Y-%m-%d %X");
}

std::string LogMessage::getTimeStr() const
{
    return getTimeStr(mtime);
}
