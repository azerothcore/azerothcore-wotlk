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

#ifndef __VOICECHAT_INTERNALHANDLER_H__
#define __VOICECHAT_INTERNALHANDLER_H__

#include "Errors.h"
#include "VoiceChatSharedDefines.h"
#include <array>
#include <memory>

class VoiceChatMgr;

template<typename Server>
class VoiceChatInternalOpcodeHandler
{
public:
    VoiceChatInternalOpcodeHandler(char const* name, void (Server::* handler)(VoiceChatServerPacket const& packet))
        : _name(name), _handler(handler) { }
    virtual ~VoiceChatInternalOpcodeHandler() = default;

    char const* _name;
    void (Server::* _handler)(VoiceChatServerPacket const& packet);
};

template<typename Server>
class VoiceChatInternalOpcodeTable
{
public:
    void Init();

    VoiceChatInternalOpcodeHandler<Server> const* operator[](VoiceChatServerOpcodes const index) const
    {
        return _opcodeTable[static_cast<uint8>(index)].get();
    }

private:
    void SetInternalServerOpcodeHandler(VoiceChatServerOpcodes const opcode, char const* name, void (Server::* handler)(VoiceChatServerPacket const& packet))
    {
        // Not a valid opcode
        if (opcode == VoiceChatServerOpcodes::NULL_OPCODE || opcode == VoiceChatServerOpcodes::NUM_OPCODES)
            ASSERT(false);

        // Tried to overwrite an existing opcode
        if (_opcodeTable[static_cast<uint8>(opcode)].get() != nullptr)
            ASSERT(false);

        _opcodeTable[static_cast<uint8>(opcode)] = std::make_unique<VoiceChatInternalOpcodeHandler<Server>>(name, handler);
    }

    std::array<std::unique_ptr<VoiceChatInternalOpcodeHandler<Server>>, static_cast<uint8>(VoiceChatServerOpcodes::NUM_OPCODES)> _opcodeTable;
};

extern VoiceChatInternalOpcodeTable<VoiceChatMgr> internalVoiceChatOpcodeTable;

#endif
