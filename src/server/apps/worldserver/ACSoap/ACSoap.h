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

#ifndef _ACSOAP_H
#define _ACSOAP_H

#include "Define.h"
#include <future>
#include <mutex>

void process_message(struct soap* soap_message);
void ACSoapThread(const std::string& host, uint16 port);

class SOAPCommand
{
public:
    SOAPCommand() :
        m_success(false) { }

    ~SOAPCommand() { }

    void appendToPrintBuffer(std::string_view msg)
    {
        m_printBuffer += msg;
    }

    void setCommandSuccess(bool val)
    {
        m_success = val;
        finishedPromise.set_value();
    }

    bool hasCommandSucceeded() const
    {
        return m_success;
    }

    static void print(void* callbackArg, std::string_view msg)
    {
        ((SOAPCommand*)callbackArg)->appendToPrintBuffer(msg);
    }

    static void commandFinished(void* callbackArg, bool success);

    bool m_success;
    std::string m_printBuffer;
    std::promise<void> finishedPromise;
};

#endif
