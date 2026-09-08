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

#include "Opcodes.h"
#include "Log.h"
#include "Packets/AllPackets.h"
#include "WorldSession.h"
#include <iomanip>
#include <sstream>

template<class PacketClass, void(WorldSession::* HandlerFunction)(PacketClass&)>
class PacketHandler : public ClientOpcodeHandler
{
public:
    PacketHandler(char const* name, SessionStatus status, PacketProcessing processing) : ClientOpcodeHandler(name, status, processing) { }

    void Call(WorldSession* session, WorldPacket& packet) const override
    {
        PacketClass nicePacket(std::move(packet));
        nicePacket.Read();
        (session->*HandlerFunction)(nicePacket);
    }
};

template<void(WorldSession::* HandlerFunction)(WorldPacket&)>
class PacketHandler<WorldPacket, HandlerFunction> : public ClientOpcodeHandler
{
public:
    PacketHandler(char const* name, SessionStatus status, PacketProcessing processing) : ClientOpcodeHandler(name, status, processing) { }

    void Call(WorldSession* session, WorldPacket& packet) const override
    {
        (session->*HandlerFunction)(packet);
    }
};

OpcodeTable opcodeTable;

template<typename T>
struct get_packet_class
{
};

template<typename PacketClass>
struct get_packet_class<void(WorldSession::*)(PacketClass&)>
{
    using type = PacketClass;
};

OpcodeTable::OpcodeTable()
{
    memset(_internalTableClient, 0, sizeof(_internalTableClient));
    memset(_internalTableServer, 0, sizeof(_internalTableServer));
    memset(_internalTableClientNames, 0, sizeof(_internalTableClientNames));
    memset(_internalTableServerNames, 0, sizeof(_internalTableServerNames));
}

OpcodeTable::~OpcodeTable()
{
    for (uint16 i = 0; i < NUM_OPCODE_HANDLERS; ++i)
    {
        delete _internalTableClient[i];
        delete _internalTableServer[i];
    }
}

template<typename Handler, Handler HandlerFunction>
void OpcodeTable::ValidateAndSetClientOpcode(OpcodeClient opcode, char const* name, SessionStatus status, PacketProcessing processing)
{
    if (uint32(opcode) == NULL_OPCODE)
    {
        LOG_ERROR("network", "Opcode {} does not have a value", name);
        return;
    }

    if (uint32(opcode) >= NUM_OPCODE_HANDLERS)
    {
        LOG_ERROR("network", "Tried to set handler for an invalid opcode {}", uint32(opcode));
        return;
    }

    if (_internalTableClient[opcode] != nullptr)
    {
        LOG_ERROR("network", "Tried to override client handler of {} with {} (opcode {})", _internalTableClient[opcode]->Name, name, uint32(opcode));
        return;
    }

    _internalTableClient[opcode] = new PacketHandler<typename get_packet_class<Handler>::type, HandlerFunction>(name, status, processing);
    _internalTableClientNames[opcode] = name;
}

void OpcodeTable::ValidateAndSetServerOpcode(OpcodeServer opcode, char const* name, SessionStatus status)
{
    if (uint32(opcode) == NULL_OPCODE)
    {
        LOG_ERROR("network", "Opcode {} does not have a value", name);
        return;
    }

    if (uint32(opcode) >= NUM_OPCODE_HANDLERS)
    {
        LOG_ERROR("network", "Tried to set handler for an invalid opcode {}", uint32(opcode));
        return;
    }

    if (_internalTableServer[opcode] != nullptr)
    {
        LOG_ERROR("network", "Tried to override server handler of {} with {} (opcode {})", _internalTableServer[opcode]->Name, name, uint32(opcode));
        return;
    }

    _internalTableServer[opcode] = new ServerOpcodeHandler(name, status);
    _internalTableServerNames[opcode] = name;
}

void OpcodeTable::SetBidirectionalOpcodeNames(char const* name, OpcodeClient clientOpcode, OpcodeServer serverOpcode)
{
    if (!_internalTableClientNames[clientOpcode])
        _internalTableClientNames[clientOpcode] = name;
    if (!_internalTableServerNames[serverOpcode])
        _internalTableServerNames[serverOpcode] = name;
}

OpcodeHandler const* OpcodeTable::GetIncomingOpcode(uint16 opcode) const
{
    if (opcode >= NUM_OPCODE_HANDLERS)
        return nullptr;
    if (_internalTableClient[opcode])
        return _internalTableClient[opcode];
    return _internalTableServer[opcode];
}

/// Correspondence between opcodes and their names
void OpcodeTable::Initialize()
{
#define DEFINE_HANDLER(opcode, status, processing, handler) \
    ValidateAndSetClientOpcode<decltype(handler), handler>(opcode, #opcode, status, processing)

#define DEFINE_SERVER_OPCODE_HANDLER(opcode, status) \
    static_assert(status == STATUS_NEVER || status == STATUS_UNHANDLED, "Invalid status for server opcode"); \
    ValidateAndSetServerOpcode(opcode, #opcode, status)

#define DEFINE_BIDIRECTIONAL_OPCODE(opcode, clientOpcode, serverOpcode) \
    static_assert(uint16(clientOpcode) == uint16(serverOpcode), "Bidirectional opcode values must match"); \
    SetBidirectionalOpcodeNames(#opcode, clientOpcode, serverOpcode)

    /*0x0001*/ DEFINE_HANDLER(CMSG_BOOTME,                                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0002*/ DEFINE_HANDLER(CMSG_DBLOOKUP,                                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0003*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DBLOOKUP,                                           STATUS_NEVER);
    /*0x0004*/ DEFINE_HANDLER(CMSG_QUERY_OBJECT_POSITION,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0005*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUERY_OBJECT_POSITION,                              STATUS_NEVER);
    /*0x0006*/ DEFINE_HANDLER(CMSG_QUERY_OBJECT_ROTATION,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0007*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUERY_OBJECT_ROTATION,                              STATUS_NEVER);
    /*0x24B2*/ DEFINE_HANDLER(CMSG_WORLD_TELEPORT,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleWorldTeleportOpcode                );
    /*0x4206*/ DEFINE_HANDLER(CMSG_TELEPORT_TO_UNIT,                                                 STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x000A*/ DEFINE_HANDLER(CMSG_ZONE_MAP,                                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x000B*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ZONE_MAP,                                           STATUS_NEVER);
    /*0x000C*/ DEFINE_HANDLER(CMSG_DEBUG_CHANGECELLZONE,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x000D*/ DEFINE_HANDLER(CMSG_MOVE_CHARACTER_CHEAT,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x000E*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_CHARACTER_CHEAT,                               STATUS_NEVER);
    /*0x000F*/ DEFINE_HANDLER(CMSG_RECHARGE,                                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0010*/ DEFINE_HANDLER(CMSG_LEARN_SPELL,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0011*/ DEFINE_HANDLER(CMSG_CREATEMONSTER,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0012*/ DEFINE_HANDLER(CMSG_DESTROYMONSTER,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0013*/ DEFINE_HANDLER(CMSG_CREATEITEM,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0014*/ DEFINE_HANDLER(CMSG_CREATEGAMEOBJECT,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0000*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHECK_FOR_BOTS,                                     STATUS_NEVER);
    /*0x0016*/ DEFINE_HANDLER(CMSG_MAKEMONSTERATTACKGUID,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0000*/ DEFINE_HANDLER(CMSG_BOT_DETECTED2,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0018*/ DEFINE_HANDLER(CMSG_FORCEACTION,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0019*/ DEFINE_HANDLER(CMSG_FORCEACTIONONOTHER,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x001A*/ DEFINE_HANDLER(CMSG_FORCEACTIONSHOW,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6126*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCEACTIONSHOW,                                    STATUS_NEVER);
    /*0x001C*/ DEFINE_HANDLER(CMSG_PETGODMODE,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2E36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PETGODMODE,                                         STATUS_NEVER);
    /*0x4934*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_REFER_A_FRIEND_EXPIRED,                             STATUS_NEVER);
    /*0x001F*/ DEFINE_HANDLER(CMSG_WEATHER_SPEED_CHEAT,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0020*/ DEFINE_HANDLER(CMSG_UNDRESSPLAYER,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0021*/ DEFINE_HANDLER(CMSG_BEASTMASTER,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0022*/ DEFINE_HANDLER(CMSG_GODMODE,                                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0405*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GODMODE,                                            STATUS_NEVER);
    /*0x0027*/ DEFINE_HANDLER(CMSG_SET_WORLDSTATE,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0028*/ DEFINE_HANDLER(CMSG_COOLDOWN_CHEAT,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0029*/ DEFINE_HANDLER(CMSG_USE_SKILL_CHEAT,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x002A*/ DEFINE_HANDLER(CMSG_FLAG_QUEST,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x002B*/ DEFINE_HANDLER(CMSG_FLAG_QUEST_FINISH,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x002C*/ DEFINE_HANDLER(CMSG_CLEAR_QUEST,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x002D*/ DEFINE_HANDLER(CMSG_SEND_EVENT,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x002E*/ DEFINE_HANDLER(CMSG_DEBUG_AISTATE,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x002F*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DEBUG_AISTATE,                                      STATUS_NEVER);
    /*0x0030*/ DEFINE_HANDLER(CMSG_DISABLE_PVP_CHEAT,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0031*/ DEFINE_HANDLER(CMSG_ADVANCE_SPAWN_TIME,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4825*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DESTRUCTIBLE_BUILDING_DAMAGE,                       STATUS_NEVER);
    /*0x0033*/ DEFINE_HANDLER(CMSG_AUTH_SRP6_BEGIN,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0035*/ DEFINE_HANDLER(CMSG_AUTH_SRP6_RECODE,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4A36*/ DEFINE_HANDLER(CMSG_CHAR_CREATE,                                                      STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleCharCreateOpcode                   );
    /*0x0502*/ DEFINE_HANDLER(CMSG_CHAR_ENUM,                                                        STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleCharEnumOpcode                     );
    /*0x6425*/ DEFINE_HANDLER(CMSG_CHAR_DELETE,                                                      STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleCharDeleteOpcode                   );
    /*0x0039*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUTH_SRP6_RESPONSE,                                 STATUS_NEVER);
    /*0x2D05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAR_CREATE,                                        STATUS_NEVER);
    /*0x10B0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAR_ENUM,                                          STATUS_NEVER);
    /*0x003C*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAR_DELETE,                                        STATUS_NEVER);
    /*0x05B1*/ DEFINE_HANDLER(CMSG_PLAYER_LOGIN,                                                     STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandlePlayerLoginOpcode                  );
    /*0x79B1*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_NEW_WORLD,                                          STATUS_NEVER);
    /*0x18A6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TRANSFER_PENDING,                                   STATUS_NEVER);
    /*0x0537*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TRANSFER_ABORTED,                                   STATUS_NEVER);
    /*0x4417*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHARACTER_LOGIN_FAILED,                             STATUS_NEVER);
    /*0x4D15*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOGIN_SET_TIME_SPEED,                               STATUS_NEVER);
    /*0x4127*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GAMETIME_UPDATE,                                    STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_GAMETIME_SET,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0014*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GAMETIME_SET,                                       STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_GAMESPEED_SET,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4E34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GAMESPEED_SET,                                      STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_SERVERTIME,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6327*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SERVERTIME,                                         STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_PLAYER_LOGOUT,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandlePlayerLogoutOpcode                 );
    /*0x0A25*/ DEFINE_HANDLER(CMSG_LOGOUT_REQUEST,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLogoutRequestOpcode                );
    /*0x0524*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOGOUT_RESPONSE,                                    STATUS_NEVER);
    /*0x2137*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOGOUT_COMPLETE,                                    STATUS_NEVER);
    /*0x2324*/ DEFINE_HANDLER(CMSG_LOGOUT_CANCEL,                                                    STATUS_LOGGEDIN_OR_RECENTLY_LOGGOUT,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLogoutCancelOpcode);
    /*0x6514*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOGOUT_CANCEL_ACK,                                  STATUS_NEVER);
    /*0x2224*/ DEFINE_HANDLER(CMSG_NAME_QUERY,                                                       STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleNameQueryOpcode                    );
    /*0x6E04*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_NAME_QUERY_RESPONSE,                               STATUS_NEVER);
    /*0x6F24*/ DEFINE_HANDLER(CMSG_PET_NAME_QUERY,                                                   STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandlePetNameQuery                       );
    /*0x4C37*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_NAME_QUERY_RESPONSE,                            STATUS_NEVER);
    /*0x4426*/ DEFINE_HANDLER(CMSG_GUILD_QUERY,                                                      STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildQueryOpcode                   );
    /*0x0055*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GUILD_QUERY_RESPONSE,                               STATUS_NEVER);
    /*0x0056*/ DEFINE_HANDLER(CMSG_ITEM_QUERY_SINGLE,                                                STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleItemQuerySingleOpcode              );
    /*0x0057*/ DEFINE_HANDLER(CMSG_ITEM_QUERY_MULTIPLE,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0058*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ITEM_QUERY_SINGLE_RESPONSE,                         STATUS_NEVER);
    /*0x0059*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ITEM_QUERY_MULTIPLE_RESPONSE,                       STATUS_NEVER);
    /*0x6614*/ DEFINE_HANDLER(CMSG_PAGE_TEXT_QUERY,                                                  STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandlePageTextQueryOpcode                );
    /*0x2B14*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PAGE_TEXT_QUERY_RESPONSE,                           STATUS_NEVER);
    /*0x005C*/ DEFINE_HANDLER(CMSG_QUEST_QUERY,                                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestQueryOpcode                   );
    /*0x6936*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUEST_QUERY_RESPONSE,                               STATUS_NEVER);
    /*0x4017*/ DEFINE_HANDLER(CMSG_GAMEOBJECT_QUERY,                                                 STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleGameObjectQueryOpcode              );
    /*0x0915*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GAMEOBJECT_QUERY_RESPONSE,                          STATUS_NEVER);
    /*0x2706*/ DEFINE_HANDLER(CMSG_CREATURE_QUERY,                                                   STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleCreatureQueryOpcode                );
    /*0x6024*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CREATURE_QUERY_RESPONSE,                            STATUS_NEVER);
    /*0x6C15*/ DEFINE_HANDLER(CMSG_WHO,                                                              STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleWhoOpcode                          );
    /*0x6907*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_WHO,                                                STATUS_NEVER);
    /*0x6B05*/ DEFINE_HANDLER(CMSG_WHOIS,                                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleWhoisOpcode                        );
    /*0x6917*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_WHOIS,                                              STATUS_NEVER);
    /*0x4534*/ DEFINE_HANDLER(CMSG_CONTACT_LIST,                                                     STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleContactListOpcode                  );
    /*0x6017*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CONTACT_LIST,                                       STATUS_NEVER);
    /*0x0717*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FRIEND_STATUS,                                      STATUS_NEVER);
    /*0x6527*/ DEFINE_HANDLER(CMSG_ADD_FRIEND,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAddFriendOpcode                    );
    /*0x6A15*/ DEFINE_HANDLER(CMSG_DEL_FRIEND,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleDelFriendOpcode                    );
    /*0x6135*/ DEFINE_HANDLER(CMSG_SET_CONTACT_NOTES,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetContactNotesOpcode              );
    /*0x4726*/ DEFINE_HANDLER(CMSG_ADD_IGNORE,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAddIgnoreOpcode                    );
    /*0x6D26*/ DEFINE_HANDLER(CMSG_DEL_IGNORE,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleDelIgnoreOpcode                    );
    /*0x006E*/ DEFINE_HANDLER(CMSG_GROUP_INVITE,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupInviteOpcode                  );
    /*0x006F*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GROUP_INVITE,                                       STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_GROUP_CANCEL,                                                     STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4D25*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GROUP_CANCEL,                                       STATUS_NEVER);
    /*0x0072*/ DEFINE_HANDLER(CMSG_GROUP_ACCEPT,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupAcceptOpcode                  );
    /*0x0073*/ DEFINE_HANDLER(CMSG_GROUP_DECLINE,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupDeclineOpcode                 );
    /*0x6835*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GROUP_DECLINE,                                      STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_GROUP_UNINVITE,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupUninviteOpcode                );
    /*0x2E07*/ DEFINE_HANDLER(CMSG_GROUP_UNINVITE_GUID,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupUninviteGuidOpcode            );
    /*0x0A07*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GROUP_UNINVITE,                                     STATUS_NEVER);
    /*0x4C17*/ DEFINE_HANDLER(CMSG_GROUP_SET_LEADER,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupSetLeaderOpcode               );
    /*0x0526*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GROUP_SET_LEADER,                                   STATUS_NEVER);
    /*0x2F24*/ DEFINE_HANDLER(CMSG_LOOT_METHOD,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLootMethodOpcode                   );
    /*0x2804*/ DEFINE_HANDLER(CMSG_GROUP_DISBAND,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupDisbandOpcode                 );
    /*0x2207*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GROUP_DESTROYED,                                    STATUS_NEVER);
    /*0x007D*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GROUP_LIST,                                         STATUS_NEVER);
    /*0x007E*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PARTY_MEMBER_STATS,                                 STATUS_NEVER);
    /*0x6E07*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PARTY_COMMAND_RESULT,                               STATUS_NEVER);
    /*0x080*/ DEFINE_HANDLER(UMSG_UPDATE_GROUP_MEMBERS,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0081*/ DEFINE_HANDLER(CMSG_GUILD_CREATE,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildCreateOpcode                  );
    /*0x24B0*/ DEFINE_HANDLER(CMSG_GUILD_INVITE,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildInviteOpcode                  );
    /*0x14A2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GUILD_INVITE,                                       STATUS_NEVER);
    /*0x2531*/ DEFINE_HANDLER(CMSG_GUILD_ACCEPT,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildAcceptOpcode                  );
    /*0x3231*/ DEFINE_HANDLER(CMSG_GUILD_DECLINE,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildDeclineOpcode                 );
    /*0x2C07*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GUILD_DECLINE,                                      STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_GUILD_INFO,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildInfoOpcode                    );
    /*0x0088*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GUILD_INFO,                                         STATUS_NEVER);
    /*0x0089*/ DEFINE_HANDLER(CMSG_GUILD_ROSTER,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildRosterOpcode                  );
    /*0x3DA3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GUILD_ROSTER,                                       STATUS_NEVER);
    /*0x1030*/ DEFINE_HANDLER(CMSG_GUILD_PROMOTE,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildPromoteOpcode                 );
    /*0x1020*/ DEFINE_HANDLER(CMSG_GUILD_DEMOTE,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildDemoteOpcode                  );
    /*0x1021*/ DEFINE_HANDLER(CMSG_GUILD_LEAVE,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildLeaveOpcode                   );
    /*0x1231*/ DEFINE_HANDLER(CMSG_GUILD_REMOVE,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildRemoveOpcode                  );
    /*0x3226*/ DEFINE_HANDLER(CMSG_GUILD_DISBAND,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildDisbandOpcode                 );
    /*0x0090*/ DEFINE_HANDLER(CMSG_GUILD_LEADER,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildLeaderOpcode                  );
    /*0x1035*/ DEFINE_HANDLER(CMSG_GUILD_MOTD,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildMOTDOpcode                    );
    /*0x0705*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GUILD_EVENT,                                        STATUS_NEVER);
    /*0x7DB3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GUILD_COMMAND_RESULT,                               STATUS_NEVER);
    /*0x094*/ DEFINE_HANDLER(UMSG_UPDATE_GUILD,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0095*/ DEFINE_HANDLER(CMSG_MESSAGECHAT,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMessagechatOpcode                  );
    /*0x2026*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MESSAGECHAT,                                        STATUS_NEVER);
    /*0x0156*/ DEFINE_HANDLER(CMSG_JOIN_CHANNEL,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleJoinChannel                        );
    /*0x2D56*/ DEFINE_HANDLER(CMSG_LEAVE_CHANNEL,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLeaveChannel                       );
    /*0x0825*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHANNEL_NOTIFY,                                     STATUS_NEVER);
    /*0x009A*/ DEFINE_HANDLER(CMSG_CHANNEL_LIST,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelList                        );
    /*0x2214*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHANNEL_LIST,                                       STATUS_NEVER);
    /*0x009C*/ DEFINE_HANDLER(CMSG_CHANNEL_PASSWORD,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelPassword                    );
    /*0x009D*/ DEFINE_HANDLER(CMSG_CHANNEL_SET_OWNER,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelSetOwner                    );
    /*0x009E*/ DEFINE_HANDLER(CMSG_CHANNEL_OWNER,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelOwner                       );
    /*0x009F*/ DEFINE_HANDLER(CMSG_CHANNEL_MODERATOR,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelModerator                   );
    /*0x00A0*/ DEFINE_HANDLER(CMSG_CHANNEL_UNMODERATOR,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelUnmoderator                 );
    /*0x00A1*/ DEFINE_HANDLER(CMSG_CHANNEL_MUTE,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelMute                        );
    /*0x00A2*/ DEFINE_HANDLER(CMSG_CHANNEL_UNMUTE,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelUnmute                      );
    /*0x00A3*/ DEFINE_HANDLER(CMSG_CHANNEL_INVITE,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelInvite                      );
    /*0x00A4*/ DEFINE_HANDLER(CMSG_CHANNEL_KICK,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelKick                        );
    /*0x00A5*/ DEFINE_HANDLER(CMSG_CHANNEL_BAN,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelBan                         );
    /*0x00A6*/ DEFINE_HANDLER(CMSG_CHANNEL_UNBAN,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelUnban                       );
    /*0x00A7*/ DEFINE_HANDLER(CMSG_CHANNEL_ANNOUNCEMENTS,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelAnnouncements               );
    /*0x00A8*/ DEFINE_HANDLER(CMSG_CHANNEL_MODERATE,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChannelModerateOpcode              );
    /*0x4715*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_UPDATE_OBJECT,                                      STATUS_NEVER);
    /*0x4724*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DESTROY_OBJECT,                                     STATUS_NEVER);
    /*0x2C06*/ DEFINE_HANDLER(CMSG_USE_ITEM,                                                         STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleUseItemOpcode                      );
    /*0x6A34*/ DEFINE_HANDLER(CMSG_OPEN_ITEM,                                                        STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleOpenItemOpcode                     );
    /*0x2F16*/ DEFINE_HANDLER(CMSG_READ_ITEM,                                                        STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleReadItem                           );
    /*0x2605*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_READ_ITEM_OK,                                       STATUS_NEVER);
    /*0x0F16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_READ_ITEM_FAILED,                                   STATUS_NEVER);
    /*0x4D14*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ITEM_COOLDOWN,                                      STATUS_NEVER);
    /*0x4E17*/ DEFINE_HANDLER(CMSG_GAMEOBJ_USE,                                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleGameObjectUseOpcode                );
    /*0x00B2*/ DEFINE_HANDLER(CMSG_DESTROY_ITEMS,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4936*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GAMEOBJECT_CUSTOM_ANIM,                             STATUS_NEVER);
    /*0x0937*/ DEFINE_HANDLER(CMSG_AREATRIGGER,                                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleAreaTriggerOpcode                  );
    /*0x7814*/ DEFINE_HANDLER(MSG_MOVE_START_FORWARD,                                                STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_FORWARD, MSG_MOVE_START_FORWARD, MSG_MOVE_START_FORWARD_SERVER);
    /*0x330A*/ DEFINE_HANDLER(MSG_MOVE_START_BACKWARD,                                               STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_BACKWARD, MSG_MOVE_START_BACKWARD, MSG_MOVE_START_BACKWARD_SERVER);
    /*0x320A*/ DEFINE_HANDLER(MSG_MOVE_STOP,                                                         STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_STOP, MSG_MOVE_STOP, MSG_MOVE_STOP_SERVER);
    /*0x3A16*/ DEFINE_HANDLER(MSG_MOVE_START_STRAFE_LEFT,                                            STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_STRAFE_LEFT, MSG_MOVE_START_STRAFE_LEFT, MSG_MOVE_START_STRAFE_LEFT_SERVER);
    /*0x3A02*/ DEFINE_HANDLER(MSG_MOVE_START_STRAFE_RIGHT,                                           STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_STRAFE_RIGHT, MSG_MOVE_START_STRAFE_RIGHT, MSG_MOVE_START_STRAFE_RIGHT_SERVER);
    /*0x3002*/ DEFINE_HANDLER(MSG_MOVE_STOP_STRAFE,                                                  STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_STOP_STRAFE, MSG_MOVE_STOP_STRAFE, MSG_MOVE_STOP_STRAFE_SERVER);
    /*0x7A06*/ DEFINE_HANDLER(MSG_MOVE_JUMP,                                                         STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_JUMP, MSG_MOVE_JUMP, MSG_MOVE_JUMP_SERVER);
    /*0x700C*/ DEFINE_HANDLER(MSG_MOVE_START_TURN_LEFT,                                              STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_TURN_LEFT, MSG_MOVE_START_TURN_LEFT, MSG_MOVE_START_TURN_LEFT_SERVER);
    /*0x7000*/ DEFINE_HANDLER(MSG_MOVE_START_TURN_RIGHT,                                             STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_TURN_RIGHT, MSG_MOVE_START_TURN_RIGHT, MSG_MOVE_START_TURN_RIGHT_SERVER);
    /*0x331E*/ DEFINE_HANDLER(MSG_MOVE_STOP_TURN,                                                    STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_STOP_TURN, MSG_MOVE_STOP_TURN, MSG_MOVE_STOP_TURN_SERVER);
    /*0x3304*/ DEFINE_HANDLER(MSG_MOVE_START_PITCH_UP,                                               STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_PITCH_UP, MSG_MOVE_START_PITCH_UP, MSG_MOVE_START_PITCH_UP_SERVER);
    /*0x3908*/ DEFINE_HANDLER(MSG_MOVE_START_PITCH_DOWN,                                             STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_PITCH_DOWN, MSG_MOVE_START_PITCH_DOWN, MSG_MOVE_START_PITCH_DOWN_SERVER);
    /*0x7216*/ DEFINE_HANDLER(MSG_MOVE_STOP_PITCH,                                                   STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_STOP_PITCH, MSG_MOVE_STOP_PITCH, MSG_MOVE_STOP_PITCH_SERVER);
    /*0x791A*/ DEFINE_HANDLER(MSG_MOVE_SET_RUN_MODE,                                                 STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_RUN_MODE, MSG_MOVE_SET_RUN_MODE, MSG_MOVE_SET_RUN_MODE_SERVER);
    /*0x7002*/ DEFINE_HANDLER(MSG_MOVE_SET_WALK_MODE,                                                STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_WALK_MODE, MSG_MOVE_SET_WALK_MODE, MSG_MOVE_SET_WALK_MODE_SERVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_MOVE_TOGGLE_LOGGING,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_TOGGLE_LOGGING, MSG_MOVE_TOGGLE_LOGGING, MSG_MOVE_TOGGLE_LOGGING_SERVER);
    /*0x55A0*/ DEFINE_HANDLER(MSG_MOVE_TELEPORT,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_TELEPORT, MSG_MOVE_TELEPORT, MSG_MOVE_TELEPORT_SERVER);
    /*0x3A10*/ DEFINE_HANDLER(MSG_MOVE_TELEPORT_CHEAT,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_TELEPORT_CHEAT, MSG_MOVE_TELEPORT_CHEAT, MSG_MOVE_TELEPORT_CHEAT_SERVER);
    /*0x390C*/ DEFINE_HANDLER(MSG_MOVE_TELEPORT_ACK,                                                 STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveTeleportAck                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_TELEPORT_ACK, MSG_MOVE_TELEPORT_ACK, MSG_MOVE_TELEPORT_ACK_SERVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_MOVE_TOGGLE_FALL_LOGGING,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_TOGGLE_FALL_LOGGING, MSG_MOVE_TOGGLE_FALL_LOGGING, MSG_MOVE_TOGGLE_FALL_LOGGING_SERVER);
    /*0x380A*/ DEFINE_HANDLER(MSG_MOVE_FALL_LAND,                                                    STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_FALL_LAND, MSG_MOVE_FALL_LAND, MSG_MOVE_FALL_LAND_SERVER);
    /*0x3206*/ DEFINE_HANDLER(MSG_MOVE_START_SWIM,                                                   STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_SWIM, MSG_MOVE_START_SWIM, MSG_MOVE_START_SWIM_SERVER);
    /*0x3802*/ DEFINE_HANDLER(MSG_MOVE_STOP_SWIM,                                                    STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_STOP_SWIM, MSG_MOVE_STOP_SWIM, MSG_MOVE_STOP_SWIM_SERVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_MOVE_SET_RUN_SPEED_CHEAT,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_RUN_SPEED_CHEAT, MSG_MOVE_SET_RUN_SPEED_CHEAT, MSG_MOVE_SET_RUN_SPEED_CHEAT_SERVER);
    /*0x00CD*/ DEFINE_HANDLER(MSG_MOVE_SET_RUN_SPEED,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_RUN_SPEED, MSG_MOVE_SET_RUN_SPEED, MSG_MOVE_SET_RUN_SPEED_SERVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_MOVE_SET_RUN_BACK_SPEED_CHEAT,                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_RUN_BACK_SPEED_CHEAT, MSG_MOVE_SET_RUN_BACK_SPEED_CHEAT, MSG_MOVE_SET_RUN_BACK_SPEED_CHEAT_SERVER);
    /*0x00CF*/ DEFINE_HANDLER(MSG_MOVE_SET_RUN_BACK_SPEED,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_RUN_BACK_SPEED, MSG_MOVE_SET_RUN_BACK_SPEED, MSG_MOVE_SET_RUN_BACK_SPEED_SERVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_MOVE_SET_WALK_SPEED_CHEAT,                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_WALK_SPEED_CHEAT, MSG_MOVE_SET_WALK_SPEED_CHEAT, MSG_MOVE_SET_WALK_SPEED_CHEAT_SERVER);
    /*0x00D1*/ DEFINE_HANDLER(MSG_MOVE_SET_WALK_SPEED,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_WALK_SPEED, MSG_MOVE_SET_WALK_SPEED, MSG_MOVE_SET_WALK_SPEED_SERVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_MOVE_SET_SWIM_SPEED_CHEAT,                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_SWIM_SPEED_CHEAT, MSG_MOVE_SET_SWIM_SPEED_CHEAT, MSG_MOVE_SET_SWIM_SPEED_CHEAT_SERVER);
    /*0x00D3*/ DEFINE_HANDLER(MSG_MOVE_SET_SWIM_SPEED,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_SWIM_SPEED, MSG_MOVE_SET_SWIM_SPEED, MSG_MOVE_SET_SWIM_SPEED_SERVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_MOVE_SET_SWIM_BACK_SPEED_CHEAT,                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_SWIM_BACK_SPEED_CHEAT, MSG_MOVE_SET_SWIM_BACK_SPEED_CHEAT, MSG_MOVE_SET_SWIM_BACK_SPEED_CHEAT_SERVER);
    /*0x00D5*/ DEFINE_HANDLER(MSG_MOVE_SET_SWIM_BACK_SPEED,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_SWIM_BACK_SPEED, MSG_MOVE_SET_SWIM_BACK_SPEED, MSG_MOVE_SET_SWIM_BACK_SPEED_SERVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_MOVE_SET_ALL_SPEED_CHEAT,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_ALL_SPEED_CHEAT, MSG_MOVE_SET_ALL_SPEED_CHEAT, MSG_MOVE_SET_ALL_SPEED_CHEAT_SERVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_MOVE_SET_TURN_RATE_CHEAT,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_TURN_RATE_CHEAT, MSG_MOVE_SET_TURN_RATE_CHEAT, MSG_MOVE_SET_TURN_RATE_CHEAT_SERVER);
    /*0x00D8*/ DEFINE_HANDLER(MSG_MOVE_SET_TURN_RATE,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_TURN_RATE, MSG_MOVE_SET_TURN_RATE, MSG_MOVE_SET_TURN_RATE_SERVER);
    /*0x7B04*/ DEFINE_HANDLER(MSG_MOVE_TOGGLE_COLLISION_CHEAT,                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_TOGGLE_COLLISION_CHEAT, MSG_MOVE_TOGGLE_COLLISION_CHEAT, MSG_MOVE_TOGGLE_COLLISION_CHEAT_SERVER);
    /*0x7914*/ DEFINE_HANDLER(MSG_MOVE_SET_FACING,                                                   STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_FACING, MSG_MOVE_SET_FACING, MSG_MOVE_SET_FACING_SERVER);
    /*0x7312*/ DEFINE_HANDLER(MSG_MOVE_SET_PITCH,                                                    STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_PITCH, MSG_MOVE_SET_PITCH, MSG_MOVE_SET_PITCH_SERVER);
    /*0x2411*/ DEFINE_HANDLER(MSG_MOVE_WORLDPORT_ACK,                                                STATUS_TRANSFER,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMoveWorldportAckOpcode             );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_WORLDPORT_ACK, MSG_MOVE_WORLDPORT_ACK, MSG_MOVE_WORLDPORT_ACK_SERVER);
    /*0x6E17*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MONSTER_MOVE,                                       STATUS_NEVER);
    /*0x75B1*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_WATER_WALK,                                    STATUS_NEVER);
    /*0x34B7*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_LAND_WALK,                                     STATUS_NEVER);
    /*0x00E0*/ DEFINE_HANDLER(CMSG_MOVE_CHARM_PORT_CHEAT,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x00E1*/ DEFINE_HANDLER(CMSG_MOVE_SET_RAW_POSITION,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x00E2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_RUN_SPEED_CHANGE,                             STATUS_NEVER);
    /*0x00E3*/ DEFINE_HANDLER(CMSG_FORCE_RUN_SPEED_CHANGE_ACK,                                       STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleForceSpeedChangeAck                );
    /*0x00E4*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_RUN_BACK_SPEED_CHANGE,                        STATUS_NEVER);
    /*0x00E5*/ DEFINE_HANDLER(CMSG_FORCE_RUN_BACK_SPEED_CHANGE_ACK,                                  STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleForceSpeedChangeAck                );
    /*0x00E6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_SWIM_SPEED_CHANGE,                            STATUS_NEVER);
    /*0x00E7*/ DEFINE_HANDLER(CMSG_FORCE_SWIM_SPEED_CHANGE_ACK,                                      STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleForceSpeedChangeAck                );
    /*0x00E8*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_MOVE_ROOT,                                    STATUS_NEVER);
    /*0x701E*/ DEFINE_HANDLER(CMSG_FORCE_MOVE_ROOT_ACK,                                              STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveRootAck                        );
    /*0x00EA*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_MOVE_UNROOT,                                  STATUS_NEVER);
    /*0x7808*/ DEFINE_HANDLER(CMSG_FORCE_MOVE_UNROOT_ACK,                                            STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveRootAck                        );
    /*0x00EC*/ DEFINE_HANDLER(MSG_MOVE_ROOT,                                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_ROOT, MSG_MOVE_ROOT, MSG_MOVE_ROOT_SERVER);
    /*0x00ED*/ DEFINE_HANDLER(MSG_MOVE_UNROOT,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_UNROOT, MSG_MOVE_UNROOT, MSG_MOVE_UNROOT_SERVER);
    /*0x3914*/ DEFINE_HANDLER(MSG_MOVE_HEARTBEAT,                                                    STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_HEARTBEAT, MSG_MOVE_HEARTBEAT, MSG_MOVE_HEARTBEAT_SERVER);
    /*0x5CB4*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_KNOCK_BACK,                                    STATUS_NEVER);
    /*0x721C*/ DEFINE_HANDLER(CMSG_MOVE_KNOCK_BACK_ACK,                                              STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveKnockBackAck                   );
    /*0x00F1*/ DEFINE_HANDLER(MSG_MOVE_KNOCK_BACK,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_KNOCK_BACK, MSG_MOVE_KNOCK_BACK, MSG_MOVE_KNOCK_BACK_SERVER);
    /*0x79B0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_FEATHER_FALL,                                  STATUS_NEVER);
    /*0x51B6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_NORMAL_FALL,                                   STATUS_NEVER);
    /*0x5CB3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_SET_HOVER,                                     STATUS_NEVER);
    /*0x51B3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_UNSET_HOVER,                                   STATUS_NEVER);
    /*0x3318*/ DEFINE_HANDLER(CMSG_MOVE_HOVER_ACK,                                                   STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveFlagChangeOpcode               );
    /*0x00F7*/ DEFINE_SERVER_OPCODE_HANDLER(MSG_MOVE_HOVER,                                          STATUS_NEVER);
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_HOVER, MSG_MOVE_HOVER_CLIENT, MSG_MOVE_HOVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_TRIGGER_CINEMATIC_CHEAT,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0A16*/ DEFINE_HANDLER(CMSG_OPENING_CINEMATIC,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6C27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TRIGGER_CINEMATIC,                                  STATUS_NEVER);
    /*0x2014*/ DEFINE_HANDLER(CMSG_NEXT_CINEMATIC_CAMERA,                                            STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleNextCinematicCamera                );
    /*0x2116*/ DEFINE_HANDLER(CMSG_COMPLETE_CINEMATIC,                                               STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleCompleteCinematic                  );
    /*0x0B35*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TUTORIAL_FLAGS,                                     STATUS_NEVER);
    /*0x6C26*/ DEFINE_HANDLER(CMSG_TUTORIAL_FLAG,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleTutorialFlag                       );
    /*0x6515*/ DEFINE_HANDLER(CMSG_TUTORIAL_CLEAR,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleTutorialClear                      );
    /*0x2726*/ DEFINE_HANDLER(CMSG_TUTORIAL_RESET,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleTutorialReset                      );
    /*0x0535*/ DEFINE_HANDLER(CMSG_STANDSTATECHANGE,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleStandStateChangeOpcode             );
    /*0x4C26*/ DEFINE_HANDLER(CMSG_EMOTE,                                                            STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleEmoteOpcode                        );
    /*0x0A34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_EMOTE,                                              STATUS_NEVER);
    /*0x0104*/ DEFINE_HANDLER(CMSG_TEXT_EMOTE,                                                       STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleTextEmoteOpcode                    );
    /*0x0B05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TEXT_EMOTE,                                         STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_AUTOEQUIP_GROUND_ITEM,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0000*/ DEFINE_HANDLER(CMSG_AUTOSTORE_GROUND_ITEM,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0E34*/ DEFINE_HANDLER(CMSG_AUTOSTORE_LOOT_ITEM,                                              STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleAutostoreLootItemOpcode            );
    /*0x0000*/ DEFINE_HANDLER(CMSG_STORE_LOOT_IN_SLOT,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4304*/ DEFINE_HANDLER(CMSG_AUTOEQUIP_ITEM,                                                   STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleAutoEquipItemOpcode                );
    /*0x0236*/ DEFINE_HANDLER(CMSG_AUTOSTORE_BAG_ITEM,                                               STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleAutoStoreBagItemOpcode             );
    /*0x6326*/ DEFINE_HANDLER(CMSG_SWAP_ITEM,                                                        STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleSwapItem                           );
    /*0x2614*/ DEFINE_HANDLER(CMSG_SWAP_INV_ITEM,                                                    STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleSwapInvItemOpcode                  );
    /*0x0F17*/ DEFINE_HANDLER(CMSG_SPLIT_ITEM,                                                       STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleSplitItemOpcode                    );
    /*0x4A17*/ DEFINE_HANDLER(CMSG_AUTOEQUIP_ITEM_SLOT,                                              STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleAutoEquipItemSlotOpcode            );
    /*0x0110*/ DEFINE_HANDLER(CMSG_UNCLAIM_LICENSE,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0111*/ DEFINE_HANDLER(CMSG_DESTROYITEM,                                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleDestroyItemOpcode                  );
    /*0x2236*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INVENTORY_CHANGE_FAILURE,                           STATUS_NEVER);
    /*0x4714*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_OPEN_CONTAINER,                                     STATUS_NEVER);
    /*0x0927*/ DEFINE_HANDLER(CMSG_INSPECT,                                                          STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleInspectOpcode                      );
    /*0x0C14*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INSPECT_RESULTS_UPDATE,                             STATUS_NEVER);
    /*0x7916*/ DEFINE_HANDLER(CMSG_INITIATE_TRADE,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleInitiateTradeOpcode                );
    /*0x721E*/ DEFINE_HANDLER(CMSG_BEGIN_TRADE,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBeginTradeOpcode                   );
    /*0x331C*/ DEFINE_HANDLER(CMSG_BUSY_TRADE,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBusyTradeOpcode                    );
    /*0x7112*/ DEFINE_HANDLER(CMSG_IGNORE_TRADE,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleIgnoreTradeOpcode                  );
    /*0x7110*/ DEFINE_HANDLER(CMSG_ACCEPT_TRADE,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAcceptTradeOpcode                  );
    /*0x391A*/ DEFINE_HANDLER(CMSG_UNACCEPT_TRADE,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleUnacceptTradeOpcode                );
    /*0x731E*/ DEFINE_HANDLER(CMSG_CANCEL_TRADE,                                                     STATUS_LOGGEDIN_OR_RECENTLY_LOGGOUT,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCancelTradeOpcode);
    /*0x7B0C*/ DEFINE_HANDLER(CMSG_SET_TRADE_ITEM,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetTradeItemOpcode                 );
    /*0x7018*/ DEFINE_HANDLER(CMSG_CLEAR_TRADE_ITEM,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleClearTradeItemOpcode               );
    /*0x3008*/ DEFINE_HANDLER(CMSG_SET_TRADE_GOLD,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetTradeGoldOpcode                 );
    /*0x5CA3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TRADE_STATUS,                                       STATUS_NEVER);
    /*0x0121*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TRADE_STATUS_EXTENDED,                              STATUS_NEVER);
    /*0x4634*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INITIALIZE_FACTIONS,                                STATUS_NEVER);
    /*0x2525*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_FACTION_VISIBLE,                                STATUS_NEVER);
    /*0x0126*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_FACTION_STANDING,                               STATUS_NEVER);
    /*0x0706*/ DEFINE_HANDLER(CMSG_SET_FACTION_ATWAR,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetFactionAtWar                    );
    /*0x0000*/ DEFINE_HANDLER(CMSG_SET_FACTION_CHEAT,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetFactionCheat                    );
    /*0x6207*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_PROFICIENCY,                                    STATUS_NEVER);
    DEFINE_SERVER_OPCODE_HANDLER(SMSG_SETUP_CURRENCY,                                                STATUS_NEVER);
    /*0x6F06*/ DEFINE_HANDLER(CMSG_SET_ACTION_BUTTON,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetActionButtonOpcode              );
    /*0x38B5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_UPDATE_ACTION_BUTTONS,                              STATUS_NEVER);
    /*0x0104*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SEND_KNOWN_SPELLS,                                  STATUS_NEVER);
    /*0x58A2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LEARNED_SPELL,                                      STATUS_NEVER);
    /*0x012C*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SUPERCEDED_SPELL,                                   STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_NEW_SPELL_SLOT,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4C07*/ DEFINE_HANDLER(CMSG_CAST_SPELL,                                                       STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleCastSpellOpcode                    );
    /*0x0115*/ DEFINE_HANDLER(CMSG_CANCEL_CAST,                                                      STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleCancelCastOpcode                   );
    /*0x4D16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CAST_FAILED,                                        STATUS_NEVER);
    /*0x6415*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELL_START,                                        STATUS_NEVER);
    /*0x6E16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELL_GO,                                           STATUS_NEVER);
    /*0x4535*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELL_FAILURE,                                      STATUS_NEVER);
    /*0x4B16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELL_COOLDOWN,                                     STATUS_NEVER);
    /*0x4F26*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COOLDOWN_EVENT,                                     STATUS_NEVER);
    /*0x0E26*/ DEFINE_HANDLER(CMSG_CANCEL_AURA,                                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleCancelAuraOpcode                   );
    /*0x2216*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_EQUIPMENT_SET_SAVED,                                STATUS_NEVER);
    /*0x2B15*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_CAST_FAILED,                                    STATUS_NEVER);
    /*0x0A15*/ DEFINE_HANDLER(MSG_CHANNEL_START,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_CHANNEL_START, MSG_CHANNEL_START, MSG_CHANNEL_START_SERVER);
    /*0x2417*/ DEFINE_HANDLER(MSG_CHANNEL_UPDATE,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_CHANNEL_UPDATE, MSG_CHANNEL_UPDATE, MSG_CHANNEL_UPDATE_SERVER);
    /*0x6C25*/ DEFINE_HANDLER(CMSG_CANCEL_CHANNELLING,                                               STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleCancelChanneling                   );
    /*0x0637*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AI_REACTION,                                        STATUS_NEVER);
    /*0x0506*/ DEFINE_HANDLER(CMSG_SET_SELECTION,                                                    STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleSetSelectionOpcode                 );
    /*0x013E*/ DEFINE_HANDLER(CMSG_DELETEEQUIPMENT_SET,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleEquipmentSetDelete                 );
    /*0x013F*/ DEFINE_HANDLER(CMSG_INSTANCE_LOCK_RESPONSE,                                           STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleInstanceLockResponse               );
    /*0x0140*/ DEFINE_HANDLER(CMSG_DEBUG_PASSIVE_AURA,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0141*/ DEFINE_HANDLER(CMSG_ATTACKSWING,                                                      STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleAttackSwingOpcode                  );
    /*0x0142*/ DEFINE_HANDLER(CMSG_ATTACKSTOP,                                                       STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleAttackStopOpcode                   );
    /*0x0143*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ATTACKSTART,                                        STATUS_NEVER);
    /*0x0144*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ATTACKSTOP,                                         STATUS_NEVER);
    /*0x0B36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ATTACKSWING_NOTINRANGE,                             STATUS_NEVER);
    /*0x6C07*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ATTACKSWING_BADFACING,                              STATUS_NEVER);
    /*0x0147*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INSTANCE_LOCK_WARNING_QUERY,                        STATUS_NEVER);
    /*0x2B26*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ATTACKSWING_DEADTARGET,                             STATUS_NEVER);
    /*0x0016*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ATTACKSWING_CANT_ATTACK,                            STATUS_NEVER);
    /*0x014A*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ATTACKERSTATEUPDATE,                                STATUS_NEVER);
    /*0x35A3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEFIELD_PORT_DENIED,                            STATUS_NEVER);
    /*0x014C*/ DEFINE_HANDLER(CMSG_PERFORM_ACTION_SET,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x014D*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RESUME_CAST_BAR,                                    STATUS_NEVER);
    /*0x4F04*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CANCEL_COMBAT,                                      STATUS_NEVER);
    /*0x6B17*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLBREAKLOG,                                      STATUS_NEVER);
    /*0x2816*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLHEALLOG,                                       STATUS_NEVER);
    /*0x0151*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLENERGIZELOG,                                   STATUS_NEVER);
    /*0x0105*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BREAK_TARGET,                                       STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_SAVE_PLAYER,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0000*/ DEFINE_HANDLER(CMSG_SETDEATHBINDPOINT,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0527*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BIND_POINT_UPDATE,                                  STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_GETDEATHBINDZONE,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4C34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BINDZONEREPLY,                                      STATUS_NEVER);
    /*0x2516*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAYERBOUND,                                        STATUS_NEVER);
    /*0x2837*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CLIENT_CONTROL_UPDATE,                              STATUS_NEVER);
    /*0x6235*/ DEFINE_HANDLER(CMSG_REPOP_REQUEST,                                                    STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleRepopRequestOpcode                 );
    /*0x2905*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RESURRECT_REQUEST,                                  STATUS_NEVER);
    /*0x6827*/ DEFINE_HANDLER(CMSG_RESURRECT_RESPONSE,                                               STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleResurrectResponseOpcode            );
    /*0x0127*/ DEFINE_HANDLER(CMSG_LOOT,                                                             STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLootOpcode                         );
    /*0x6227*/ DEFINE_HANDLER(CMSG_LOOT_MONEY,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLootMoneyOpcode                    );
    /*0x2007*/ DEFINE_HANDLER(CMSG_LOOT_RELEASE,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLootReleaseOpcode                  );
    /*0x4C16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_RESPONSE,                                      STATUS_NEVER);
    /*0x0161*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_RELEASE_RESPONSE,                              STATUS_NEVER);
    /*0x6817*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_REMOVED,                                       STATUS_NEVER);
    /*0x2836*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_MONEY_NOTIFY,                                  STATUS_NEVER);
    /*0x6D15*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_ITEM_NOTIFY,                                   STATUS_NEVER);
    /*0x0165*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_CLEAR_MONEY,                                   STATUS_NEVER);
    /*0x0E15*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ITEM_PUSH_RESULT,                                   STATUS_NEVER);
    /*0x4504*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DUEL_REQUESTED,                                     STATUS_NEVER);
    /*0x0C26*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DUEL_OUTOFBOUNDS,                                   STATUS_NEVER);
    /*0x0A27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DUEL_INBOUNDS,                                      STATUS_NEVER);
    /*0x2527*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DUEL_COMPLETE,                                      STATUS_NEVER);
    /*0x2D36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DUEL_WINNER,                                        STATUS_NEVER);
    /*0x2136*/ DEFINE_HANDLER(CMSG_DUEL_ACCEPTED,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleDuelAcceptedOpcode                 );
    /*0x6624*/ DEFINE_HANDLER(CMSG_DUEL_CANCELLED,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleDuelCancelledOpcode                );
    /*0x016E*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOUNTRESULT,                                        STATUS_NEVER);
    /*0x0D25*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DISMOUNTRESULT,                                     STATUS_NEVER);
    /*0x0170*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_REMOVED_FROM_PVP_QUEUE,                             STATUS_NEVER);
    /*0x2807*/ DEFINE_HANDLER(CMSG_MOUNTSPECIAL_ANIM,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMountSpecialAnimOpcode             );
    /*0x0217*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOUNTSPECIAL_ANIM,                                  STATUS_NEVER);
    /*0x6B24*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_TAME_FAILURE,                                   STATUS_NEVER);
    /*0x6904*/ DEFINE_HANDLER(CMSG_PET_SET_ACTION,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandlePetSetAction                       );
    /*0x0226*/ DEFINE_HANDLER(CMSG_PET_ACTION,                                                       STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandlePetAction                          );
    /*0x0C24*/ DEFINE_HANDLER(CMSG_PET_ABANDON,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandlePetAbandon                         );
    /*0x6406*/ DEFINE_HANDLER(CMSG_PET_RENAME,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandlePetRename                          );
    /*0x6007*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_NAME_INVALID,                                   STATUS_NEVER);
    /*0x4114*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_SPELLS,                                         STATUS_NEVER);
    /*0x2235*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_MODE,                                           STATUS_NEVER);
    /*0x4525*/ DEFINE_HANDLER(CMSG_GOSSIP_HELLO,                                                     STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleGossipHelloOpcode                  );
    /*0x0216*/ DEFINE_HANDLER(CMSG_GOSSIP_SELECT_OPTION,                                             STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGossipSelectOptionOpcode           );
    /*0x2035*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GOSSIP_MESSAGE,                                     STATUS_NEVER);
    /*0x0806*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GOSSIP_COMPLETE,                                    STATUS_NEVER);
    /*0x4E24*/ DEFINE_HANDLER(CMSG_NPC_TEXT_QUERY,                                                   STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleNpcTextQueryOpcode                 );
    /*0x4436*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_NPC_TEXT_UPDATE,                                    STATUS_NEVER);
    /*0x0000*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_NPC_WONT_TALK,                                      STATUS_NEVER);
    /*0x0182*/ DEFINE_HANDLER(CMSG_QUESTGIVER_STATUS_QUERY,                                          STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleQuestgiverStatusQueryOpcode        );
    /*0x0183*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTGIVER_STATUS,                                  STATUS_NEVER);
    /*0x0184*/ DEFINE_HANDLER(CMSG_QUESTGIVER_HELLO,                                                 STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestgiverHelloOpcode              );
    /*0x0185*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTGIVER_QUEST_LIST,                              STATUS_NEVER);
    /*0x0186*/ DEFINE_HANDLER(CMSG_QUESTGIVER_QUERY_QUEST,                                           STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestgiverQueryQuestOpcode         );
    /*0x0187*/ DEFINE_HANDLER(CMSG_QUESTGIVER_QUEST_AUTOLAUNCH,                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestgiverQuestAutoLaunch          );
    /*0x0188*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTGIVER_QUEST_DETAILS,                           STATUS_NEVER);
    /*0x0189*/ DEFINE_HANDLER(CMSG_QUESTGIVER_ACCEPT_QUEST,                                          STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestgiverAcceptQuestOpcode        );
    /*0x018A*/ DEFINE_HANDLER(CMSG_QUESTGIVER_COMPLETE_QUEST,                                        STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestgiverCompleteQuest            );
    /*0x018B*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTGIVER_REQUEST_ITEMS,                           STATUS_NEVER);
    /*0x018C*/ DEFINE_HANDLER(CMSG_QUESTGIVER_REQUEST_REWARD,                                        STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestgiverRequestRewardOpcode      );
    /*0x018D*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTGIVER_OFFER_REWARD,                            STATUS_NEVER);
    /*0x018E*/ DEFINE_HANDLER(CMSG_QUESTGIVER_CHOOSE_REWARD,                                         STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestgiverChooseRewardOpcode       );
    /*0x018F*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTGIVER_QUEST_INVALID,                           STATUS_NEVER);
    /*0x0190*/ DEFINE_HANDLER(CMSG_QUESTGIVER_CANCEL,                                                STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestgiverCancel                   );
    /*0x0191*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTGIVER_QUEST_COMPLETE,                          STATUS_NEVER);
    /*0x0192*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTGIVER_QUEST_FAILED,                            STATUS_NEVER);
    /*0x0193*/ DEFINE_HANDLER(CMSG_QUESTLOG_SWAP_QUEST,                                              STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestLogSwapQuest                  );
    /*0x0194*/ DEFINE_HANDLER(CMSG_QUESTLOG_REMOVE_QUEST,                                            STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestLogRemoveQuest                );
    /*0x0195*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTLOG_FULL,                                      STATUS_NEVER);
    /*0x0196*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTUPDATE_FAILED,                                 STATUS_NEVER);
    /*0x0197*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTUPDATE_FAILEDTIMER,                            STATUS_NEVER);
    /*0x0198*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTUPDATE_COMPLETE,                               STATUS_NEVER);
    /*0x0199*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTUPDATE_ADD_KILL,                               STATUS_NEVER);
    /*0x0000*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTUPDATE_ADD_ITEM,                               STATUS_NEVER);
    /*0x0D15*/ DEFINE_HANDLER(CMSG_QUEST_CONFIRM_ACCEPT,                                             STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleQuestConfirmAccept                 );
    /*0x6F07*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUEST_CONFIRM_ACCEPT,                               STATUS_NEVER);
    /*0x4B14*/ DEFINE_HANDLER(CMSG_PUSHQUESTTOPARTY,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandlePushQuestToParty                   );
    /*0x2806*/ DEFINE_HANDLER(CMSG_LIST_INVENTORY,                                                   STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleListInventoryOpcode                );
    /*0x019F*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LIST_INVENTORY,                                     STATUS_NEVER);
    /*0x4E15*/ DEFINE_HANDLER(CMSG_SELL_ITEM,                                                        STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleSellItemOpcode                     );
    /*0x6105*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SELL_ITEM,                                          STATUS_NEVER);
    /*0x0736*/ DEFINE_HANDLER(CMSG_BUY_ITEM,                                                         STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleBuyItemOpcode                      );
    /*0x01A3*/ DEFINE_HANDLER(CMSG_BUY_ITEM_IN_SLOT,                                                 STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleBuyItemInSlotOpcode                );
    /*0x0F26*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BUY_ITEM,                                           STATUS_NEVER);
    /*0x6435*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BUY_FAILED,                                         STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_TAXICLEARALLNODES,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0000*/ DEFINE_HANDLER(CMSG_TAXIENABLEALLNODES,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0000*/ DEFINE_HANDLER(CMSG_TAXISHOWNODES,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2A36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SHOWTAXINODES,                                      STATUS_NEVER);
    /*0x2F25*/ DEFINE_HANDLER(CMSG_TAXINODE_STATUS_QUERY,                                            STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleTaxiNodeStatusQueryOpcode          );
    /*0x2936*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TAXINODE_STATUS,                                    STATUS_NEVER);
    /*0x6C06*/ DEFINE_HANDLER(CMSG_TAXIQUERYAVAILABLENODES,                                          STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleTaxiQueryAvailableNodes            );
    /*0x6E06*/ DEFINE_HANDLER(CMSG_ACTIVATETAXI,                                                     STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleActivateTaxiOpcode                 );
    /*0x6A37*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ACTIVATETAXIREPLY,                                  STATUS_NEVER);
    /*0x4B35*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_NEW_TAXI_PATH,                                      STATUS_NEVER);
    /*0x2336*/ DEFINE_HANDLER(CMSG_TRAINER_LIST,                                                     STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleTrainerListOpcode                  );
    /*0x4414*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TRAINER_LIST,                                       STATUS_NEVER);
    /*0x4415*/ DEFINE_HANDLER(CMSG_TRAINER_BUY_SPELL,                                                STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleTrainerBuySpellOpcode              );
    /*0x6A05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TRAINER_BUY_SUCCEEDED,                              STATUS_NEVER);
    /*0x0004*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TRAINER_BUY_FAILED,                                 STATUS_NEVER);
    /*0x4006*/ DEFINE_HANDLER(CMSG_BINDER_ACTIVATE,                                                  STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleBinderActivateOpcode               );
    /*0x6A24*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAYERBINDERROR,                                    STATUS_NEVER);
    /*0x0005*/ DEFINE_HANDLER(CMSG_BANKER_ACTIVATE,                                                  STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleBankerActivateOpcode               );
    /*0x2627*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SHOW_BANK,                                          STATUS_NEVER);
    /*0x0425*/ DEFINE_HANDLER(CMSG_BUY_BANK_SLOT,                                                    STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleBuyBankSlotOpcode                  );
    /*0x4806*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BUY_BANK_SLOT_RESULT,                               STATUS_NEVER);
    /*0x4617*/ DEFINE_HANDLER(CMSG_PETITION_SHOWLIST,                                                STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandlePetitionShowListOpcode             );
    /*0x6405*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PETITION_SHOWLIST,                                  STATUS_NEVER);
    /*0x4E05*/ DEFINE_HANDLER(CMSG_PETITION_BUY,                                                     STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandlePetitionBuyOpcode                  );
    /*0x4F15*/ DEFINE_HANDLER(CMSG_PETITION_SHOW_SIGNATURES,                                         STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandlePetitionShowSignOpcode             );
    /*0x0716*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PETITION_SHOW_SIGNATURES,                           STATUS_NEVER);
    /*0x0E04*/ DEFINE_HANDLER(CMSG_PETITION_SIGN,                                                    STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandlePetitionSignOpcode                 );
    /*0x6217*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PETITION_SIGN_RESULTS,                              STATUS_NEVER);
    /*0x4905*/ DEFINE_HANDLER(MSG_PETITION_DECLINE,                                                  STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandlePetitionDeclineOpcode              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_PETITION_DECLINE, MSG_PETITION_DECLINE, MSG_PETITION_DECLINE_SERVER);
    /*0x4817*/ DEFINE_HANDLER(CMSG_OFFER_PETITION,                                                   STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleOfferPetitionOpcode                );
    /*0x0B27*/ DEFINE_HANDLER(CMSG_TURN_IN_PETITION,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleTurnInPetitionOpcode               );
    /*0x0F07*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TURN_IN_PETITION_RESULTS,                           STATUS_NEVER);
    /*0x4424*/ DEFINE_HANDLER(CMSG_PETITION_QUERY,                                                   STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandlePetitionQueryOpcode                );
    /*0x4B37*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PETITION_QUERY_RESPONSE,                            STATUS_NEVER);
    /*0x0A17*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FISH_NOT_HOOKED,                                    STATUS_NEVER);
    /*0x2205*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FISH_ESCAPED,                                       STATUS_NEVER);
    /*0x4035*/ DEFINE_HANDLER(CMSG_BUG,                                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBugOpcode                          );
    /*0x14A0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_NOTIFICATION,                                       STATUS_NEVER);
    /*0x0804*/ DEFINE_HANDLER(CMSG_PLAYED_TIME,                                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandlePlayedTime                         );
    /*0x6037*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAYED_TIME,                                        STATUS_NEVER);
    /*0x0A36*/ DEFINE_HANDLER(CMSG_QUERY_TIME,                                                       STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleTimeQueryOpcode                    );
    /*0x2124*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUERY_TIME_RESPONSE,                                STATUS_NEVER);
    /*0x01D0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOG_XPGAIN,                                         STATUS_NEVER);
    /*0x0000*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AURACASTLOG,                                        STATUS_NEVER);
    /*0x4036*/ DEFINE_HANDLER(CMSG_RECLAIM_CORPSE,                                                   STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleReclaimCorpseOpcode                );
    /*0x4F06*/ DEFINE_HANDLER(CMSG_WRAP_ITEM,                                                        STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleWrapItemOpcode                     );
    /*0x01D4*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LEVELUP_INFO,                                       STATUS_NEVER);
    /*0x6635*/ DEFINE_HANDLER(MSG_MINIMAP_PING,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMinimapPingOpcode                  );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MINIMAP_PING, MSG_MINIMAP_PING, MSG_MINIMAP_PING_SERVER);
    /*0x0000*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RESISTLOG,                                          STATUS_NEVER);
    /*0x6035*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ENCHANTMENTLOG,                                     STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_SET_SKILL_CHEAT,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6824*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_START_MIRROR_TIMER,                                 STATUS_NEVER);
    /*0x4015*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PAUSE_MIRROR_TIMER,                                 STATUS_NEVER);
    /*0x0B06*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_STOP_MIRROR_TIMER,                                  STATUS_NEVER);
    /*0x444D*/ DEFINE_HANDLER(CMSG_PING,                                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_EarlyProccess                     );
    /*0x4D42*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PONG,                                               STATUS_NEVER);
    /*0x0627*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CLEAR_COOLDOWN,                                     STATUS_NEVER);
    /*0x2925*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GAMEOBJECT_PAGETEXT,                                STATUS_NEVER);
    /*0x4326*/ DEFINE_HANDLER(CMSG_SET_SHEATHED,                                                     STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleSetSheathedOpcode                  );
    /*0x4537*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COOLDOWN_CHEAT,                                     STATUS_NEVER);
    /*0x0715*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELL_DELAYED,                                      STATUS_NEVER);
    /*0x4037*/ DEFINE_HANDLER(CMSG_QUEST_POI_QUERY,                                                  STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQuestPOIQuery                      );
    /*0x6304*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUEST_POI_QUERY_RESPONSE,                           STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_GHOST,                                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0000*/ DEFINE_HANDLER(CMSG_GM_INVIS,                                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6F25*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INVALID_PROMOTION_CODE,                             STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_GM_BIND_OTHER,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GM_BIND_OTHER, MSG_GM_BIND_OTHER, MSG_GM_BIND_OTHER_SERVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_GM_SUMMON,                                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GM_SUMMON, MSG_GM_SUMMON, MSG_GM_SUMMON_SERVER);
    /*0x2407*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ITEM_TIME_UPDATE,                                   STATUS_NEVER);
    /*0x0F27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ITEM_ENCHANT_TIME_UPDATE,                           STATUS_NEVER);
    /*0x4542*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUTH_CHALLENGE,                                     STATUS_NEVER);
    DEFINE_SERVER_OPCODE_HANDLER(SMSG_HOTFIX_NOTIFY_BLOB,                                           STATUS_NEVER);
    /*0x0449*/ DEFINE_HANDLER(CMSG_AUTH_SESSION,                                                     STATUS_NEVER,      PROCESS_THREADUNSAFE,   &WorldSession::Handle_EarlyProccess                     );
    /*0x5DB6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUTH_RESPONSE,                                      STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(MSG_GM_SHOWLABEL,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GM_SHOWLABEL, MSG_GM_SHOWLABEL, MSG_GM_SHOWLABEL_SERVER);
    /*0x6337*/ DEFINE_HANDLER(CMSG_PET_CAST_SPELL,                                                   STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandlePetCastSpellOpcode                 );
    /*0x2404*/ DEFINE_HANDLER(MSG_SAVE_GUILD_EMBLEM,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSaveGuildEmblemOpcode              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_SAVE_GUILD_EMBLEM, MSG_SAVE_GUILD_EMBLEM, MSG_SAVE_GUILD_EMBLEM_SERVER);
    /*0x6926*/ DEFINE_HANDLER(MSG_TABARDVENDOR_ACTIVATE,                                             STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleTabardVendorActivateOpcode         );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_TABARDVENDOR_ACTIVATE, MSG_TABARDVENDOR_ACTIVATE, MSG_TABARDVENDOR_ACTIVATE_SERVER);
    /*0x10B1*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAY_SPELL_VISUAL,                                  STATUS_NEVER);
    /*0x4F37*/ DEFINE_HANDLER(CMSG_ZONEUPDATE,                                                       STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleZoneUpdateOpcode                   );
    /*0x4937*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PARTYKILLLOG,                                       STATUS_NEVER);
    /*0x01F6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMPRESSED_UPDATE_OBJECT,                           STATUS_NEVER);
    /*0x01F7*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAY_SPELL_IMPACT,                                  STATUS_NEVER);
    /*0x6716*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_EXPLORATION_EXPERIENCE,                             STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_GM_SET_SECURITY_GROUP,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0000*/ DEFINE_HANDLER(CMSG_GM_NUKE,                                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0905*/ DEFINE_HANDLER(MSG_RANDOM_ROLL,                                                       STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleRandomRollOpcode                   );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_RANDOM_ROLL, MSG_RANDOM_ROLL, MSG_RANDOM_ROLL_SERVER);
    /*0x6C05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ENVIRONMENTAL_DAMAGE_LOG,                           STATUS_NEVER);
    /*0x6107*/ DEFINE_HANDLER(CMSG_CHANGEPLAYER_DIFFICULTY,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2437*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RWHOIS,                                             STATUS_NEVER);
    /*0x6834*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_PLAYER_REWARD,                                  STATUS_NEVER);
    /*0x0E14*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_TELEPORT_DENIED,                                STATUS_NEVER);
    /*0x0201*/ DEFINE_HANDLER(CMSG_UNLEARN_SPELL,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6106*/ DEFINE_HANDLER(CMSG_UNLEARN_SKILL,                                                    STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleUnlearnSkillOpcode                 );
    /*0x0203*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_REMOVED_SPELL,                                      STATUS_NEVER);
    /*0x0137*/ DEFINE_HANDLER(CMSG_GMTICKET_CREATE,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGMTicketCreateOpcode               );
    /*0x2107*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GMTICKET_CREATE,                                    STATUS_NEVER);
    /*0x0636*/ DEFINE_HANDLER(CMSG_GMTICKET_UPDATETEXT,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGMTicketUpdateOpcode               );
    /*0x6535*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GMTICKET_UPDATETEXT,                                STATUS_NEVER);
    /*0x4B05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ACCOUNT_DATA_TIMES,                                 STATUS_NEVER);
    /*0x6505*/ DEFINE_HANDLER(CMSG_REQUEST_ACCOUNT_DATA,                                             STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleRequestAccountData                 );
    /*0x4736*/ DEFINE_HANDLER(CMSG_UPDATE_ACCOUNT_DATA,                                              STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleUpdateAccountData                  );
    /*0x6837*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_UPDATE_ACCOUNT_DATA,                                STATUS_NEVER);
    /*0x2A04*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CLEAR_FAR_SIGHT_IMMEDIATE,                          STATUS_NEVER);
    /*0x020E*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHANGEPLAYER_DIFFICULTY_RESULT,                     STATUS_NEVER);
    /*0x020F*/ DEFINE_HANDLER(CMSG_GM_TEACH,                                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0210*/ DEFINE_HANDLER(CMSG_GM_CREATE_ITEM_TARGET,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0326*/ DEFINE_HANDLER(CMSG_GMTICKET_GETTICKET,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGMTicketGetTicketOpcode            );
    /*0x2C15*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GMTICKET_GETTICKET,                                 STATUS_NEVER);
    /*0x0213*/ DEFINE_HANDLER(CMSG_UNLEARN_TALENTS,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4007*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_UPDATE_INSTANCE_ENCOUNTER_UNIT,                     STATUS_NEVER);
    /*0x6735*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GAMEOBJECT_DESPAWN_ANIM,                            STATUS_NEVER);
    /*0x4336*/ DEFINE_HANDLER(MSG_CORPSE_QUERY,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCorpseQueryOpcode                  );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_CORPSE_QUERY, MSG_CORPSE_QUERY, MSG_CORPSE_QUERY_SERVER);
    /*0x6B14*/ DEFINE_HANDLER(CMSG_GMTICKET_DELETETICKET,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGMTicketDeleteOpcode               );
    /*0x6D17*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GMTICKET_DELETETICKET,                              STATUS_NEVER);
    /*0x6724*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAT_WRONG_FACTION,                                 STATUS_NEVER);
    /*0x4205*/ DEFINE_HANDLER(CMSG_GMTICKET_SYSTEMSTATUS,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGMTicketSystemStatusOpcode         );
    /*0x0D35*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GMTICKET_SYSTEMSTATUS,                              STATUS_NEVER);
    /*0x2E26*/ DEFINE_HANDLER(CMSG_SPIRIT_HEALER_ACTIVATE,                                           STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSpiritHealerActivateOpcode         ); // pussywizard: corpse on other map, GetAreaFlag, this involved vmaps, grids and more
    /*0x021D*/ DEFINE_HANDLER(CMSG_SET_STAT_CHEAT,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6605*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUEST_FORCE_REMOVE,                                 STATUS_NEVER);
    /*0x021F*/ DEFINE_HANDLER(CMSG_SKILL_BUY_STEP,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0220*/ DEFINE_HANDLER(CMSG_SKILL_BUY_RANK,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0221*/ DEFINE_HANDLER(CMSG_XP_CHEAT,                                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4917*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPIRIT_HEALER_CONFIRM,                              STATUS_NEVER);
    /*0x0223*/ DEFINE_HANDLER(CMSG_CHARACTER_POINT_CHEAT,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4316*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GOSSIP_POI,                                         STATUS_NEVER);
    DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_SET_ACTIVE_MOVER,                                        STATUS_NEVER);
    /*0x0D54*/ DEFINE_HANDLER(CMSG_CHAT_IGNORED,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleChatIgnoredOpcode                  );
    /*0x0228*/ DEFINE_HANDLER(CMSG_GM_SILENCE,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0229*/ DEFINE_HANDLER(CMSG_GM_REVEALTO,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x022A*/ DEFINE_HANDLER(CMSG_GM_RESURRECT,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x022B*/ DEFINE_HANDLER(CMSG_GM_SUMMONMOB,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x022C*/ DEFINE_HANDLER(CMSG_GM_MOVECORPSE,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x022D*/ DEFINE_HANDLER(CMSG_GM_FREEZE,                                                        STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x022E*/ DEFINE_HANDLER(CMSG_GM_UBERINVIS,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x022F*/ DEFINE_HANDLER(CMSG_GM_REQUEST_PLAYER_INFO,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4A15*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GM_PLAYER_INFO,                                     STATUS_NEVER);
    /*0x0231*/ DEFINE_HANDLER(CMSG_GUILD_RANK,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildRankOpcode                    );
    /*0x3030*/ DEFINE_HANDLER(CMSG_GUILD_ADD_RANK,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildAddRankOpcode                 );
    /*0x3234*/ DEFINE_HANDLER(CMSG_GUILD_DEL_RANK,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildDelRankOpcode                 );
    /*0x1233*/ DEFINE_HANDLER(CMSG_GUILD_SET_NOTE,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildSetPublicNoteOpcode           );
    /*0x0235*/ DEFINE_HANDLER(CMSG_GUILD_SET_OFFICER_NOTE,                                           STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildSetOfficerNoteOpcode          );
    /*0x2005*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOGIN_VERIFY_WORLD,                                 STATUS_NEVER);
    DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOAD_CUF_PROFILES,                                            STATUS_NEVER);
    /*0x0523*/ DEFINE_HANDLER(CMSG_SEND_MAIL,                                                        STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSendMail                           );
    /*0x4927*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SEND_MAIL_RESULT,                                   STATUS_NEVER);
    /*0x4D37*/ DEFINE_HANDLER(CMSG_GET_MAIL_LIST,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGetMailList                        );
    /*0x4217*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MAIL_LIST_RESULT,                                   STATUS_NEVER);
    /*0x3814*/ DEFINE_HANDLER(CMSG_BATTLEFIELD_LIST,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBattlefieldListOpcode              );
    /*0x71B5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEFIELD_LIST,                                   STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_BATTLEFIELD_JOIN,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x023F*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_SET_VEHICLE_REC_ID,                           STATUS_NEVER);
    /*0x3108*/ DEFINE_HANDLER(CMSG_SET_VEHICLE_REC_ID_ACK,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0241*/ DEFINE_HANDLER(CMSG_TAXICLEARNODE,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0242*/ DEFINE_HANDLER(CMSG_TAXIENABLENODE,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2406*/ DEFINE_HANDLER(CMSG_ITEM_TEXT_QUERY,                                                  STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleItemTextQuery                      );
    /*0x2725*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ITEM_TEXT_QUERY_RESPONSE,                           STATUS_NEVER);
    /*0x4034*/ DEFINE_HANDLER(CMSG_MAIL_TAKE_MONEY,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMailTakeMoney                      );
    /*0x2B06*/ DEFINE_HANDLER(CMSG_MAIL_TAKE_ITEM,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMailTakeItem                       );
    /*0x0C07*/ DEFINE_HANDLER(CMSG_MAIL_MARK_AS_READ,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMailMarkAsRead                     );
    /*0x0816*/ DEFINE_HANDLER(CMSG_MAIL_RETURN_TO_SENDER,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMailReturnToSender                 );
    /*0x6104*/ DEFINE_HANDLER(CMSG_MAIL_DELETE,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMailDelete                         );
    /*0x0B14*/ DEFINE_HANDLER(CMSG_MAIL_CREATE_TEXT_ITEM,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMailCreateTextItem                 );
    /*0x024B*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLLOGMISS,                                       STATUS_NEVER);
    /*0x0626*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLLOGEXECUTE,                                    STATUS_NEVER);
    /*0x024D*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DEBUGAURAPROC,                                      STATUS_NEVER);
    /*0x024E*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PERIODICAURALOG,                                    STATUS_NEVER);
    /*0x024F*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLDAMAGESHIELD,                                  STATUS_NEVER);
    /*0x4315*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLNONMELEEDAMAGELOG,                             STATUS_NEVER);
    /*0x0306*/ DEFINE_HANDLER(CMSG_LEARN_TALENT,                                                     STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleLearnTalentOpcode                  );
    /*0x6705*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RESURRECT_FAILED,                                   STATUS_NEVER);
    /*0x6815*/ DEFINE_HANDLER(CMSG_TOGGLE_PVP,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleTogglePvP                          );
    /*0x0A06*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ZONE_UNDER_ATTACK,                                  STATUS_NEVER);
    /*0x2307*/ DEFINE_HANDLER(MSG_AUCTION_HELLO,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAuctionHelloOpcode                 );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_AUCTION_HELLO, MSG_AUCTION_HELLO, MSG_AUCTION_HELLO_SERVER);
    /*0x4A06*/ DEFINE_HANDLER(CMSG_AUCTION_SELL_ITEM,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAuctionSellItem                    );
    /*0x6426*/ DEFINE_HANDLER(CMSG_AUCTION_REMOVE_ITEM,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAuctionRemoveItem                  );
    /*0x0324*/ DEFINE_HANDLER(CMSG_AUCTION_LIST_ITEMS,                                               STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleAuctionListItems                   );
    /*0x0206*/ DEFINE_HANDLER(CMSG_AUCTION_LIST_OWNER_ITEMS,                                         STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleAuctionListOwnerItems              );
    /*0x2306*/ DEFINE_HANDLER(CMSG_AUCTION_PLACE_BID,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAuctionPlaceBid                    );
    /*0x4C25*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUCTION_COMMAND_RESULT,                             STATUS_NEVER);
    /*0x6637*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUCTION_LIST_RESULT,                                STATUS_NEVER);
    /*0x6C34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUCTION_OWNER_LIST_RESULT,                          STATUS_NEVER);
    /*0x4E27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUCTION_BIDDER_NOTIFICATION,                        STATUS_NEVER);
    /*0x4116*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUCTION_OWNER_NOTIFICATION,                         STATUS_NEVER);
    /*0x0426*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PROCRESIST,                                         STATUS_NEVER);
    /*0x2B07*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMBAT_EVENT_FAILED,                                STATUS_NEVER);
    /*0x0307*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DISPEL_FAILED,                                      STATUS_NEVER);
    /*0x4507*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLORDAMAGE_IMMUNE,                               STATUS_NEVER);
    /*0x6937*/ DEFINE_HANDLER(CMSG_AUCTION_LIST_BIDDER_ITEMS,                                        STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleAuctionListBidderItems             );
    /*0x0027*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUCTION_BIDDER_LIST_RESULT,                         STATUS_NEVER);
    /*0x2834*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_FLAT_SPELL_MODIFIER,                            STATUS_NEVER);
    /*0x0224*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_PCT_SPELL_MODIFIER,                             STATUS_NEVER);
    /*0x0268*/ DEFINE_HANDLER(CMSG_SET_AMMO,                                                         STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleSetAmmoOpcode                      );
    /*0x0D34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CORPSE_RECLAIM_DELAY,                               STATUS_NEVER);
    /*0x3314*/ DEFINE_HANDLER(CMSG_SET_ACTIVE_MOVER,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetActiveMoverOpcode               );
    /*0x3808*/ DEFINE_HANDLER(CMSG_OBJECT_UPDATE_FAILED,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleObjectUpdateFailedOpcode           );
    /*0x7202*/ DEFINE_HANDLER(CMSG_QUERY_BATTLEFIELD_STATE,                                         STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4407*/ DEFINE_HANDLER(CMSG_QUEST_GIVER_STATUS_QUERY,                                   STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x720A*/ DEFINE_HANDLER(CMSG_REQUEST_CEMETERY_LIST,                                           STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x3D54*/ DEFINE_HANDLER(CMSG_UNREGISTER_ALL_ADDON_PREFIXES,                                   STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2401*/ DEFINE_HANDLER(CMSG_DB_QUERY_BULK,                                                   STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x730E*/ DEFINE_HANDLER(CMSG_SAVE_CUF_PROFILES,                                               STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x7102*/ DEFINE_HANDLER(CMSG_REQUEST_CATEGORY_COOLDOWNS,                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0412*/ DEFINE_HANDLER(CMSG_LFG_LOCK_INFO_REQUEST,                                           STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfgPlayerLockInfoRequestOpcode     );
    /*0x4B25*/ DEFINE_HANDLER(CMSG_PET_CANCEL_AURA,                                                  STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandlePetCancelAuraOpcode                );
    /*0x026C*/ DEFINE_HANDLER(CMSG_PLAYER_AI_CHEAT,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6C35*/ DEFINE_HANDLER(CMSG_CANCEL_AUTO_REPEAT_SPELL,                                         STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleCancelAutoRepeatSpellOpcode        );
    /*0x026E*/ DEFINE_HANDLER(MSG_GM_ACCOUNT_ONLINE,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GM_ACCOUNT_ONLINE, MSG_GM_ACCOUNT_ONLINE, MSG_GM_ACCOUNT_ONLINE_SERVER);
    /*0x0834*/ DEFINE_HANDLER(MSG_LIST_STABLED_PETS,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleListStabledPetsOpcode              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_LIST_STABLED_PETS, MSG_LIST_STABLED_PETS, MSG_LIST_STABLED_PETS_SERVER);
    /*0x0270*/ DEFINE_HANDLER(CMSG_STABLE_PET,                                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleStablePet                          );
    /*0x0271*/ DEFINE_HANDLER(CMSG_UNSTABLE_PET,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleUnstablePet                        );
    /*0x0272*/ DEFINE_HANDLER(CMSG_BUY_STABLE_SLOT,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBuyStableSlot                      );
    /*0x2204*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_STABLE_RESULT,                                      STATUS_NEVER);
    /*0x0274*/ DEFINE_HANDLER(CMSG_STABLE_REVIVE_PET,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleStableRevivePet                    );
    /*0x0275*/ DEFINE_HANDLER(CMSG_STABLE_SWAP_PET,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleStableSwapPet                      );
    /*0x4515*/ DEFINE_HANDLER(MSG_QUEST_PUSH_RESULT,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleQuestPushResult                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_QUEST_PUSH_RESULT, MSG_QUEST_PUSH_RESULT, MSG_QUEST_PUSH_RESULT_SERVER);
    /*0x4B06*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAY_MUSIC,                                         STATUS_NEVER);
    /*0x2635*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAY_OBJECT_SOUND,                                  STATUS_NEVER);
    /*0x4924*/ DEFINE_HANDLER(CMSG_REQUEST_PET_INFO,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleRequestPetInfo                     );
    /*0x4835*/ DEFINE_HANDLER(CMSG_FAR_SIGHT,                                                        STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleFarSightOpcode                     );
    /*0x027B*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLDISPELLOG,                                     STATUS_NEVER);
    /*0x2436*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DAMAGE_CALC_LOG,                                    STATUS_NEVER);
    /*0x027D*/ DEFINE_HANDLER(CMSG_ENABLE_DAMAGE_LOG,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4124*/ DEFINE_HANDLER(CMSG_GROUP_CHANGE_SUB_GROUP,                                           STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupChangeSubGroupOpcode          );
    /*0x0C04*/ DEFINE_HANDLER(CMSG_REQUEST_PARTY_MEMBER_STATS,                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleRequestPartyMemberStatsOpcode      );
    /*0x0034*/ DEFINE_HANDLER(CMSG_GROUP_SWAP_SUB_GROUP,                                             STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupSwapSubGroupOpcode            );
    /*0x4469*/ DEFINE_HANDLER(CMSG_RESET_FACTION_CHEAT,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0607*/ DEFINE_HANDLER(CMSG_AUTOSTORE_BANK_ITEM,                                              STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleAutoStoreBankItemOpcode            );
    /*0x2537*/ DEFINE_HANDLER(CMSG_AUTOBANK_ITEM,                                                    STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleAutoBankItemOpcode                 );
    /*0x0F04*/ DEFINE_HANDLER(MSG_QUERY_NEXT_MAIL_TIME,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleQueryNextMailTime                  );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_QUERY_NEXT_MAIL_TIME, MSG_QUERY_NEXT_MAIL_TIME, MSG_QUERY_NEXT_MAIL_TIME_SERVER);
    /*0x2924*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RECEIVED_MAIL,                                      STATUS_NEVER);
    /*0x0837*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RAID_GROUP_ONLY,                                    STATUS_NEVER);
    /*0x0287*/ DEFINE_HANDLER(CMSG_SET_DURABILITY_CHEAT,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0288*/ DEFINE_HANDLER(CMSG_SET_PVP_RANK_CHEAT,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0289*/ DEFINE_HANDLER(CMSG_ADD_PVP_MEDAL_CHEAT,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x028A*/ DEFINE_HANDLER(CMSG_DEL_PVP_MEDAL_CHEAT,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x028B*/ DEFINE_HANDLER(CMSG_SET_PVP_TITLE,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6015*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PVP_CREDIT,                                         STATUS_NEVER);
    /*0x2334*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUCTION_REMOVED_NOTIFICATION,                       STATUS_NEVER);
    /*0x6E27*/ DEFINE_HANDLER(CMSG_GROUP_RAID_CONVERT,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupRaidConvertOpcode             );
    /*0x6025*/ DEFINE_HANDLER(CMSG_GROUP_ASSISTANT_LEADER,                                           STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGroupAssistantLeaderOpcode         );
    /*0x6C17*/ DEFINE_HANDLER(CMSG_BUYBACK_ITEM,                                                     STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleBuybackItem                        );
    /*0x0291*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAT_SERVER_MESSAGE,                                STATUS_NEVER);
    /*0x6706*/ DEFINE_HANDLER(CMSG_SET_SAVED_INSTANCE_EXTEND,                                        STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetSavedInstanceExtend             );
    /*0x6B27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_OFFER_CONTINUE,                                 STATUS_NEVER);
    /*0x0294*/ DEFINE_HANDLER(CMSG_TEST_DROP_RATE,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6816*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TEST_DROP_RATE_RESULT,                              STATUS_NEVER);
    /*0x2581*/ DEFINE_HANDLER(CMSG_LFG_GET_STATUS,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfgGetStatus                       );
    /*0x2524*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SHOW_MAILBOX,                                       STATUS_NEVER);
    /*0x0298*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RESET_RANGED_COMBAT_TIMER,                          STATUS_NEVER);
    /*0x6A14*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAT_NOT_IN_PARTY,                                  STATUS_NEVER);
    /*0x029A*/ DEFINE_SERVER_OPCODE_HANDLER(CMSG_GMTICKETSYSTEM_TOGGLE,                              STATUS_NEVER);
    /*0x0237*/ DEFINE_HANDLER(CMSG_CANCEL_GROWTH_AURA,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCancelGrowthAuraOpcode             );
    /*0x6436*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CANCEL_AUTO_REPEAT,                                 STATUS_NEVER);
    /*0x029D*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_STANDSTATE_UPDATE,                                  STATUS_NEVER);
    /*0x6237*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_ALL_PASSED,                                    STATUS_NEVER);
    /*0x6617*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_ROLL_WON,                                      STATUS_NEVER);
    /*0x6934*/ DEFINE_HANDLER(CMSG_LOOT_ROLL,                                                        STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLootRoll                           );
    /*0x2227*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_START_ROLL,                                    STATUS_NEVER);
    /*0x6507*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_ROLL,                                          STATUS_NEVER);
    /*0x4F35*/ DEFINE_HANDLER(CMSG_LOOT_MASTER_GIVE,                                                 STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleLootMasterGiveOpcode               );
    /*0x0325*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_MASTER_LIST,                                   STATUS_NEVER);
    /*0x4615*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_FORCED_REACTIONS,                               STATUS_NEVER);
    /*0x0C34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELL_FAILED_OTHER,                                 STATUS_NEVER);
    /*0x2A16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GAMEOBJECT_RESET_STATE,                             STATUS_NEVER);
    /*0x2917*/ DEFINE_HANDLER(CMSG_REPAIR_ITEM,                                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleRepairItemOpcode                   );
    /*0x2526*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAT_PLAYER_NOT_FOUND,                              STATUS_NEVER);
    /*0x0107*/ DEFINE_HANDLER(MSG_TALENT_WIPE_CONFIRM,                                               STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleTalentWipeConfirmOpcode            );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_TALENT_WIPE_CONFIRM, MSG_TALENT_WIPE_CONFIRM, MSG_TALENT_WIPE_CONFIRM_SERVER);
    /*0x2A07*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SUMMON_REQUEST,                                     STATUS_NEVER);
    /*0x6F27*/ DEFINE_HANDLER(CMSG_SUMMON_RESPONSE,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSummonResponseOpcode               );
    /*0x02AD*/ DEFINE_HANDLER(MSG_DEV_SHOWLABEL,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_DEV_SHOWLABEL, MSG_DEV_SHOWLABEL, MSG_DEV_SHOWLABEL_SERVER);
    /*0x02AE*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MONSTER_MOVE_TRANSPORT,                             STATUS_NEVER);
    /*0x2E27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_BROKEN,                                         STATUS_NEVER);
    /*0x02B0*/ DEFINE_HANDLER(MSG_MOVE_FEATHER_FALL,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_FEATHER_FALL, MSG_MOVE_FEATHER_FALL, MSG_MOVE_FEATHER_FALL_SERVER);
    /*0x02B1*/ DEFINE_HANDLER(MSG_MOVE_WATER_WALK,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_WATER_WALK, MSG_MOVE_WATER_WALK, MSG_MOVE_WATER_WALK_SERVER);
    /*0x02B2*/ DEFINE_HANDLER(CMSG_SERVER_BROADCAST,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6115*/ DEFINE_HANDLER(CMSG_SELF_RES,                                                         STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleSelfResOpcode                      );
    /*0x0D05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FEIGN_DEATH_RESISTED,                               STATUS_NEVER);
    /*0x02B5*/ DEFINE_HANDLER(CMSG_RUN_SCRIPT,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x02B6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SCRIPT_MESSAGE,                                     STATUS_NEVER);
    /*0x4836*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DUEL_COUNTDOWN,                                     STATUS_NEVER);
    /*0x4505*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AREA_TRIGGER_MESSAGE,                               STATUS_NEVER);
    /*0x0735*/ DEFINE_HANDLER(CMSG_SHOWING_HELM,                                                     STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleShowingHelmOpcode                  );
    /*0x4135*/ DEFINE_HANDLER(CMSG_SHOWING_CLOAK,                                                    STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleShowingCloakOpcode                 );
    /*0x6A26*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_ROLE_CHOSEN,                                    STATUS_NEVER);
    /*0x0116*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAYER_SKINNED,                                     STATUS_NEVER);
    /*0x4C27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DURABILITY_DAMAGE_DEATH,                            STATUS_NEVER);
    /*0x02BE*/ DEFINE_HANDLER(CMSG_SET_EXPLORATION,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2506*/ DEFINE_HANDLER(CMSG_SET_ACTIONBAR_TOGGLES,                                            STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleSetActionBarToggles                );
    /*0x2C0*/ DEFINE_HANDLER(UMSG_DELETE_GUILD_CHARTER,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4005*/ DEFINE_HANDLER(MSG_PETITION_RENAME,                                                   STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandlePetitionRenameOpcode               );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_PETITION_RENAME, MSG_PETITION_RENAME, MSG_PETITION_RENAME_SERVER);
    /*0x4C15*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INIT_WORLD_STATES,                                  STATUS_NEVER);
    /*0x4816*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_UPDATE_WORLD_STATE,                                 STATUS_NEVER);
    /*0x02C4*/ DEFINE_HANDLER(CMSG_ITEM_NAME_QUERY,                                                  STATUS_LOGGEDIN,   PROCESS_INPLACE,     &WorldSession::HandleItemNameQueryOpcode                );
    /*0x02C5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ITEM_NAME_QUERY_RESPONSE,                           STATUS_NEVER);
    /*0x0807*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_ACTION_FEEDBACK,                                STATUS_NEVER);
    /*0x2327*/ DEFINE_HANDLER(CMSG_CHAR_RENAME,                                                      STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleCharRenameOpcode                   );
    /*0x2024*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAR_RENAME,                                        STATUS_NEVER);
    /*0x790E*/ DEFINE_HANDLER(CMSG_MOVE_SPLINE_DONE,                                                 STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveSplineDoneOpcode               );
    /*0x310A*/ DEFINE_HANDLER(CMSG_MOVE_FALL_RESET,                                                  STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    /*0x0124*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INSTANCE_SAVE_CREATED,                              STATUS_NEVER);
    /*0x02CC*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INSTANCE_INFO,                                 STATUS_NEVER);
    /*0x2F26*/ DEFINE_HANDLER(CMSG_REQUEST_RAID_INFO,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleRequestRaidInfoOpcode              );
    /*0x7A0A*/ DEFINE_HANDLER(CMSG_MOVE_TIME_SKIPPED,                                                STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveTimeSkippedOpcode              );
    /*0x3110*/ DEFINE_HANDLER(CMSG_MOVE_FEATHER_FALL_ACK,                                            STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveFlagChangeOpcode               );
    /*0x3B00*/ DEFINE_HANDLER(CMSG_MOVE_WATER_WALK_ACK,                                              STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveFlagChangeOpcode               );
    /*0x7A1A*/ DEFINE_HANDLER(CMSG_MOVE_NOT_ACTIVE_MOVER,                                            STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveNotActiveMover                 );
    /*0x2134*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAY_SOUND,                                         STATUS_NEVER);
    /*0x2500*/ DEFINE_HANDLER(CMSG_BATTLEFIELD_STATUS,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBattlefieldStatusOpcode            );
    /*0x7DA1*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEFIELD_STATUS,                                 STATUS_NEVER);
    /*0x711A*/ DEFINE_HANDLER(CMSG_BATTLEFIELD_PORT,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBattleFieldPortOpcode              );
    /*0x02D6*/ DEFINE_HANDLER(MSG_INSPECT_HONOR_STATS,                                               STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleInspectHonorStatsOpcode            );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_INSPECT_HONOR_STATS, MSG_INSPECT_HONOR_STATS, MSG_INSPECT_HONOR_STATS_SERVER);
    /*0x0234*/ DEFINE_HANDLER(CMSG_BATTLEMASTER_HELLO,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBattlemasterHelloOpcode            );
    /*0x02D8*/ DEFINE_HANDLER(CMSG_MOVE_START_SWIM_CHEAT,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x02D9*/ DEFINE_HANDLER(CMSG_MOVE_STOP_SWIM_CHEAT,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x02DA*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_WALK_SPEED_CHANGE,                            STATUS_NEVER);
    /*0x02DB*/ DEFINE_HANDLER(CMSG_FORCE_WALK_SPEED_CHANGE_ACK,                                      STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleForceSpeedChangeAck                );
    /*0x02DC*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_SWIM_BACK_SPEED_CHANGE,                       STATUS_NEVER);
    /*0x02DD*/ DEFINE_HANDLER(CMSG_FORCE_SWIM_BACK_SPEED_CHANGE_ACK,                                 STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleForceSpeedChangeAck                );
    /*0x02DE*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_TURN_RATE_CHANGE,                             STATUS_NEVER);
    /*0x02DF*/ DEFINE_HANDLER(CMSG_FORCE_TURN_RATE_CHANGE_ACK,                                       STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleForceSpeedChangeAck                );
    /*0x0000*/ DEFINE_HANDLER(MSG_PVP_LOG_DATA,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandlePVPLogDataOpcode                   );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_PVP_LOG_DATA, MSG_PVP_LOG_DATA, MSG_PVP_LOG_DATA_SERVER);
    /*0x02E1*/ DEFINE_HANDLER(CMSG_LEAVE_BATTLEFIELD,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBattlefieldLeaveOpcode             );
    /*0x4907*/ DEFINE_HANDLER(CMSG_AREA_SPIRIT_HEALER_QUERY,                                         STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAreaSpiritHealerQueryOpcode        );
    /*0x4815*/ DEFINE_HANDLER(CMSG_AREA_SPIRIT_HEALER_QUEUE,                                         STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAreaSpiritHealerQueueOpcode        );
    /*0x0734*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AREA_SPIRIT_HEALER_TIME,                            STATUS_NEVER);
    /*0x02E5*/ DEFINE_HANDLER(CMSG_GM_UNTEACH,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x31A0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_WARDEN_DATA,                                        STATUS_NEVER);
    /*0x25A2*/ DEFINE_HANDLER(CMSG_WARDEN_DATA,                                                      STATUS_AUTHED,     PROCESS_THREADSAFE,     &WorldSession::HandleWardenDataOpcode                   );
    /*0x02E8*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GROUP_JOINED_BATTLEGROUND,                          STATUS_NEVER);
    /*0x02E9*/ DEFINE_HANDLER(MSG_BATTLEGROUND_PLAYER_POSITIONS,                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBattlegroundPlayerPositionsOpcode  );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_BATTLEGROUND_PLAYER_POSITIONS, MSG_BATTLEGROUND_PLAYER_POSITIONS, MSG_BATTLEGROUND_PLAYER_POSITIONS_SERVER);
    /*0x6C14*/ DEFINE_HANDLER(CMSG_PET_STOP_ATTACK,                                                  STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandlePetStopAttack                      );
    /*0x2835*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BINDER_CONFIRM,                                     STATUS_NEVER);
    /*0x50B0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEGROUND_PLAYER_JOINED,                         STATUS_NEVER);
    /*0x59A6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEGROUND_PLAYER_LEFT,                           STATUS_NEVER);
    /*0x7902*/ DEFINE_HANDLER(CMSG_BATTLEMASTER_JOIN,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBattlemasterJoinOpcode             );
    /*0x2C14*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ADDON_INFO,                                         STATUS_NEVER);
    /*0x02F0*/ DEFINE_HANDLER(CMSG_PET_UNLEARN,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x02F1*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_UNLEARN_CONFIRM,                                STATUS_NEVER);
    /*0x02F2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PARTY_MEMBER_STATS_FULL,                            STATUS_NEVER);
    /*0x2514*/ DEFINE_HANDLER(CMSG_PET_SPELL_AUTOCAST,                                               STATUS_LOGGEDIN,   PROCESS_INPLACE,     &WorldSession::HandlePetSpellAutocastOpcode             );
    /*0x2904*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_WEATHER,                                            STATUS_NEVER);
    /*0x4814*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAY_TIME_WARNING,                                  STATUS_NEVER);
    /*0x6727*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MINIGAME_SETUP,                                     STATUS_NEVER);
    /*0x2E17*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MINIGAME_STATE,                                     STATUS_NEVER);
    /*0x2A34*/ DEFINE_HANDLER(CMSG_MINIGAME_MOVE,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x02F9*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MINIGAME_MOVE_FAILED,                               STATUS_NEVER);
    /*0x6E15*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RAID_INSTANCE_MESSAGE,                              STATUS_NEVER);
    /*0x0517*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMPRESSED_MOVES,                                   STATUS_NEVER);
    /*0x3227*/ DEFINE_HANDLER(CMSG_GUILD_INFO_TEXT,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildChangeInfoTextOpcode          );
    /*0x6536*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAT_RESTRICTED,                                    STATUS_NEVER);
    /*0x02FE*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_SET_RUN_SPEED,                               STATUS_NEVER);
    /*0x02FF*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_SET_RUN_BACK_SPEED,                          STATUS_NEVER);
    /*0x0300*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_SET_SWIM_SPEED,                              STATUS_NEVER);
    /*0x0301*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_SET_WALK_SPEED,                              STATUS_NEVER);
    /*0x0302*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_SET_SWIM_BACK_SPEED,                         STATUS_NEVER);
    /*0x0303*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_SET_TURN_RATE,                               STATUS_NEVER);
    /*0x75B6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_UNROOT,                                 STATUS_NEVER);
    /*0x0305*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_FEATHER_FALL,                           STATUS_NEVER);
    /*0x0306*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_NORMAL_FALL,                            STATUS_NEVER);
    /*0x14B6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_SET_HOVER,                              STATUS_NEVER);
    /*0x7DA5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_UNSET_HOVER,                            STATUS_NEVER);
    /*0x50A2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_WATER_WALK,                             STATUS_NEVER);
    /*0x030A*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_LAND_WALK,                              STATUS_NEVER);
    /*0x31A5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_START_SWIM,                             STATUS_NEVER);
    /*0x1DA2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_STOP_SWIM,                              STATUS_NEVER);
    /*0x75A7*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_SET_RUN_MODE,                           STATUS_NEVER);
    /*0x54B6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_SET_WALK_MODE,                          STATUS_NEVER);
    /*0x030F*/ DEFINE_HANDLER(CMSG_GM_NUKE_ACCOUNT,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0310*/ DEFINE_HANDLER(MSG_GM_DESTROY_CORPSE,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GM_DESTROY_CORPSE, MSG_GM_DESTROY_CORPSE, MSG_GM_DESTROY_CORPSE_SERVER);
    /*0x0311*/ DEFINE_HANDLER(CMSG_GM_DESTROY_ONLINE_CORPSE,                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0515*/ DEFINE_HANDLER(CMSG_ACTIVATETAXIEXPRESS,                                              STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleActivateTaxiExpressOpcode          );
    /*0x4216*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_FACTION_ATWAR,                                  STATUS_NEVER);
    /*0x0315*/ DEFINE_HANDLER(CMSG_DEBUG_ACTIONS_START,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0316*/ DEFINE_HANDLER(CMSG_DEBUG_ACTIONS_STOP,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0E37*/ DEFINE_HANDLER(CMSG_SET_FACTION_INACTIVE,                                             STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetFactionInactiveOpcode           );
    /*0x2434*/ DEFINE_HANDLER(CMSG_SET_WATCHED_FACTION,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetWatchedFactionOpcode            );
    /*0x19B3*/ DEFINE_HANDLER(MSG_MOVE_TIME_SKIPPED,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_TIME_SKIPPED, MSG_MOVE_TIME_SKIPPED, MSG_MOVE_TIME_SKIPPED_SERVER);
    /*0x51B4*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_ROOT,                                   STATUS_NEVER);
    /*0x031B*/ DEFINE_HANDLER(CMSG_SET_EXPLORATION_ALL,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6325*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INVALIDATE_PLAYER,                                  STATUS_NEVER);
    /*0x6E14*/ DEFINE_HANDLER(CMSG_RESET_INSTANCES,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleResetInstancesOpcode               );
    /*0x6F05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INSTANCE_RESET,                                     STATUS_NEVER);
    /*0x4725*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INSTANCE_RESET_FAILED,                              STATUS_NEVER);
    /*0x0437*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_UPDATE_LAST_INSTANCE,                               STATUS_NEVER);
    /*0x2C36*/ DEFINE_HANDLER(MSG_RAID_TARGET_UPDATE,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleRaidTargetUpdateOpcode             );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_RAID_TARGET_UPDATE, MSG_RAID_TARGET_UPDATE, MSG_RAID_TARGET_UPDATE_SERVER);
    /*0x2304*/ DEFINE_HANDLER(MSG_RAID_READY_CHECK,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleRaidReadyCheckOpcode               );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_RAID_READY_CHECK, MSG_RAID_READY_CHECK, MSG_RAID_READY_CHECK_SERVER);
    /*0x0323*/ DEFINE_HANDLER(CMSG_LUA_USAGE,                                                        STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4324*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_ACTION_SOUND,                                   STATUS_NEVER);
    /*0x2B05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_DISMISS_SOUND,                                  STATUS_NEVER);
    /*0x0326*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GHOSTEE_GONE,                                       STATUS_NEVER);
    /*0x0327*/ DEFINE_HANDLER(CMSG_GM_UPDATE_TICKET_STATUS,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2C25*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GM_TICKET_STATUS_UPDATE,                            STATUS_NEVER);
    /*0x4925*/ DEFINE_HANDLER(MSG_SET_DUNGEON_DIFFICULTY,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetDungeonDifficultyOpcode         );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_SET_DUNGEON_DIFFICULTY, MSG_SET_DUNGEON_DIFFICULTY, MSG_SET_DUNGEON_DIFFICULTY_SERVER);
    /*0x2724*/ DEFINE_HANDLER(CMSG_GMSURVEY_SUBMIT,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGMSurveySubmit                     );
    /*0x4915*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_UPDATE_INSTANCE_OWNERSHIP,                          STATUS_NEVER);
    /*0x032C*/ DEFINE_HANDLER(CMSG_IGNORE_KNOCKBACK_CHEAT,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2F34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAT_PLAYER_AMBIGUOUS,                              STATUS_NEVER);
    /*0x032E*/ DEFINE_HANDLER(MSG_DELAY_GHOST_TELEPORT,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_DELAY_GHOST_TELEPORT, MSG_DELAY_GHOST_TELEPORT, MSG_DELAY_GHOST_TELEPORT_SERVER);
    /*0x6216*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLINSTAKILLLOG,                                  STATUS_NEVER);
    /*0x6006*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELL_UPDATE_CHAIN_TARGETS,                         STATUS_NEVER);
    /*0x0946*/ DEFINE_HANDLER(CMSG_CHAT_FILTERED,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4D36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_EXPECTED_SPAM_RECORDS,                              STATUS_NEVER);
    /*0x4E26*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELLSTEALLOG,                                      STATUS_NEVER);
    /*0x0334*/ DEFINE_HANDLER(CMSG_LOTTERY_QUERY_OBSOLETE,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0335*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOTTERY_QUERY_RESULT_OBSOLETE,                      STATUS_NEVER);
    /*0x0336*/ DEFINE_HANDLER(CMSG_BUY_LOTTERY_TICKET_OBSOLETE,                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0337*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOTTERY_RESULT_OBSOLETE,                            STATUS_NEVER);
    /*0x0338*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHARACTER_PROFILE,                                  STATUS_NEVER);
    /*0x0339*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHARACTER_PROFILE_REALM_CONNECTED,                  STATUS_NEVER);
    /*0x0314*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DEFENSE_MESSAGE,                                    STATUS_NEVER);
    /*0x31A2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_WORLD_SERVER_INFO,                                  STATUS_NEVER);
    /*0x033C*/ DEFINE_HANDLER(MSG_GM_RESETINSTANCELIMIT,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GM_RESETINSTANCELIMIT, MSG_GM_RESETINSTANCELIMIT, MSG_GM_RESETINSTANCELIMIT_SERVER);
    /*0x0A35*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOTD,                                               STATUS_NEVER);
    /*0x59A2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_SET_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY,       STATUS_NEVER);
    /*0x7DB2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_UNSET_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY,     STATUS_NEVER);
    /*0x3014*/ DEFINE_HANDLER(CMSG_MOVE_SET_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY_ACK,                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0341*/ DEFINE_HANDLER(MSG_MOVE_START_SWIM_CHEAT,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_SWIM_CHEAT, MSG_MOVE_START_SWIM_CHEAT, MSG_MOVE_START_SWIM_CHEAT_SERVER);
    /*0x0342*/ DEFINE_HANDLER(MSG_MOVE_STOP_SWIM_CHEAT,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_STOP_SWIM_CHEAT, MSG_MOVE_STOP_SWIM_CHEAT, MSG_MOVE_STOP_SWIM_CHEAT_SERVER);
    /*0x3DA1*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_SET_CAN_FLY,                                   STATUS_NEVER);
    /*0x15A2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_UNSET_CAN_FLY,                                 STATUS_NEVER);
    /*0x790C*/ DEFINE_HANDLER(CMSG_MOVE_SET_CAN_FLY_ACK,                                             STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveFlagChangeOpcode               );
    /*0x0346*/ DEFINE_HANDLER(CMSG_MOVE_SET_FLY,                                                     STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    /*0x2F04*/ DEFINE_HANDLER(CMSG_SOCKET_GEMS,                                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleSocketOpcode                       );
    /*0x04A1*/ DEFINE_HANDLER(CMSG_ARENA_TEAM_CREATE,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x39B3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ARENA_TEAM_COMMAND_RESULT,                          STATUS_NEVER);
    /*0x034A*/ DEFINE_HANDLER(MSG_MOVE_UPDATE_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY,                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_UPDATE_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY, MSG_MOVE_UPDATE_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY, MSG_MOVE_UPDATE_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY_SERVER);
    /*0x0514*/ DEFINE_HANDLER(CMSG_ARENA_TEAM_QUERY,                                                 STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleArenaTeamQueryOpcode               );
    /*0x6336*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ARENA_TEAM_QUERY_RESPONSE,                          STATUS_NEVER);
    /*0x6F37*/ DEFINE_HANDLER(CMSG_ARENA_TEAM_ROSTER,                                                STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleArenaTeamRosterOpcode              );
    /*0x2717*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ARENA_TEAM_ROSTER,                                  STATUS_NEVER);
    /*0x2F27*/ DEFINE_HANDLER(CMSG_ARENA_TEAM_INVITE,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleArenaTeamInviteOpcode              );
    /*0x0F36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ARENA_TEAM_INVITE,                                  STATUS_NEVER);
    /*0x2A25*/ DEFINE_HANDLER(CMSG_ARENA_TEAM_ACCEPT,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleArenaTeamAcceptOpcode              );
    /*0x6925*/ DEFINE_HANDLER(CMSG_ARENA_TEAM_DECLINE,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleArenaTeamDeclineOpcode             );
    /*0x0E16*/ DEFINE_HANDLER(CMSG_ARENA_TEAM_LEAVE,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleArenaTeamLeaveOpcode               );
    /*0x2F05*/ DEFINE_HANDLER(CMSG_ARENA_TEAM_REMOVE,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleArenaTeamRemoveOpcode              );
    /*0x6504*/ DEFINE_HANDLER(CMSG_ARENA_TEAM_DISBAND,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleArenaTeamDisbandOpcode             );
    /*0x4204*/ DEFINE_HANDLER(CMSG_ARENA_TEAM_LEADER,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleArenaTeamLeaderOpcode              );
    /*0x0617*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ARENA_TEAM_EVENT,                                   STATUS_NEVER);
    /*0x701C*/ DEFINE_HANDLER(CMSG_BATTLEMASTER_JOIN_ARENA,                                          STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBattlemasterJoinArena              );
    /*0x390A*/ DEFINE_HANDLER(MSG_MOVE_START_ASCEND,                                                 STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_ASCEND, MSG_MOVE_START_ASCEND, MSG_MOVE_START_ASCEND_SERVER);
    /*0x7B00*/ DEFINE_HANDLER(MSG_MOVE_STOP_ASCEND,                                                  STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_STOP_ASCEND, MSG_MOVE_STOP_ASCEND, MSG_MOVE_STOP_ASCEND_SERVER);
    /*0x4425*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ARENA_TEAM_STATS,                                   STATUS_NEVER);
    /*0x2430*/ DEFINE_HANDLER(CMSG_LFG_JOIN,                                                         STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfgJoinOpcode                      );
    /*0x2433*/ DEFINE_HANDLER(CMSG_LFG_LEAVE,                                                        STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfgLeaveOpcode                     );
    /*0x0000*/ DEFINE_HANDLER(CMSG_SEARCH_LFG_JOIN,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfrSearchJoinOpcode                );
    /*0x0000*/ DEFINE_HANDLER(CMSG_SEARCH_LFG_LEAVE,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfrSearchLeaveOpcode               );
    /*0x0360*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_UPDATE_LFG_LIST,                                    STATUS_NEVER);
    /*0x7DA6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_PROPOSAL_UPDATE,                                STATUS_NEVER);
    /*0x0403*/ DEFINE_HANDLER(CMSG_LFG_PROPOSAL_RESULT,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfgProposalResultOpcode            );
    /*0x0336*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_ROLE_CHECK_UPDATE,                              STATUS_NEVER);
    /*0x38B6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_JOIN_RESULT,                                    STATUS_NEVER);
    /*0x78B4*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_QUEUE_STATUS,                                   STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_SET_LFG_COMMENT,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfgSetCommentOpcode                );
    /*0x0367*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_UPDATE_PLAYER,                                  STATUS_NEVER);
    /*0x0368*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_UPDATE_PARTY,                                   STATUS_NEVER);
    /*0x0369*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_UPDATE_SEARCH,                                  STATUS_NEVER);
    /*0x0480*/ DEFINE_HANDLER(CMSG_LFG_SET_ROLES,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfgSetRolesOpcode                  );
    /*0x036B*/ DEFINE_HANDLER(CMSG_LFG_SET_NEEDS,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04B3*/ DEFINE_HANDLER(CMSG_LFG_SET_BOOT_VOTE,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfgSetBootVoteOpcode               );
    /*0x0F05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_BOOT_PROPOSAL_UPDATE,                           STATUS_NEVER);
    /*0x4B36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_PLAYER_INFO,                                    STATUS_NEVER);
    /*0x2482*/ DEFINE_HANDLER(CMSG_LFG_TELEPORT,                                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfgTeleportOpcode                  );
    /*0x0371*/ DEFINE_HANDLER(CMSG_LFD_PARTY_LOCK_INFO_REQUEST,                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleLfgPartyLockInfoRequestOpcode      );
    /*0x2325*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_PARTY_INFO,                                     STATUS_NEVER);
    /*0x2426*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TITLE_EARNED,                                       STATUS_NEVER);
    /*0x2117*/ DEFINE_HANDLER(CMSG_SET_TITLE,                                                        STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleSetTitleOpcode                     );
    /*0x0635*/ DEFINE_HANDLER(CMSG_CANCEL_MOUNT_AURA,                                                STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleCancelMountAuraOpcode              );
    /*0x2D17*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ARENA_ERROR,                                        STATUS_NEVER);
    /*0x2704*/ DEFINE_HANDLER(MSG_INSPECT_ARENA_TEAMS,                                               STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleInspectArenaTeamsOpcode            );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_INSPECT_ARENA_TEAMS, MSG_INSPECT_ARENA_TEAMS, MSG_INSPECT_ARENA_TEAMS_SERVER);
    /*0x2F07*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DEATH_RELEASE_LOC,                                  STATUS_NEVER);
    /*0x6C37*/ DEFINE_HANDLER(CMSG_CANCEL_TEMP_ENCHANTMENT,                                          STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleCancelTempEnchantmentOpcode        );
    /*0x2606*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCED_DEATH_UPDATE,                                STATUS_NEVER);
    /*0x037B*/ DEFINE_HANDLER(CMSG_CHEAT_SET_HONOR_CURRENCY,                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x037C*/ DEFINE_HANDLER(CMSG_CHEAT_SET_ARENA_CURRENCY,                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0000*/ DEFINE_HANDLER(MSG_MOVE_SET_FLIGHT_SPEED_CHEAT,                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_FLIGHT_SPEED_CHEAT, MSG_MOVE_SET_FLIGHT_SPEED_CHEAT, MSG_MOVE_SET_FLIGHT_SPEED_CHEAT_SERVER);
    /*0x037E*/ DEFINE_HANDLER(MSG_MOVE_SET_FLIGHT_SPEED,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_FLIGHT_SPEED, MSG_MOVE_SET_FLIGHT_SPEED, MSG_MOVE_SET_FLIGHT_SPEED_SERVER);
    /*0x037F*/ DEFINE_HANDLER(MSG_MOVE_SET_FLIGHT_BACK_SPEED_CHEAT,                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_FLIGHT_BACK_SPEED_CHEAT, MSG_MOVE_SET_FLIGHT_BACK_SPEED_CHEAT, MSG_MOVE_SET_FLIGHT_BACK_SPEED_CHEAT_SERVER);
    /*0x0380*/ DEFINE_HANDLER(MSG_MOVE_SET_FLIGHT_BACK_SPEED,                                        STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_FLIGHT_BACK_SPEED, MSG_MOVE_SET_FLIGHT_BACK_SPEED, MSG_MOVE_SET_FLIGHT_BACK_SPEED_SERVER);
    /*0x0381*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_FLIGHT_SPEED_CHANGE,                          STATUS_NEVER);
    /*0x0382*/ DEFINE_HANDLER(CMSG_FORCE_FLIGHT_SPEED_CHANGE_ACK,                                    STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleForceSpeedChangeAck                );
    /*0x0383*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_FLIGHT_BACK_SPEED_CHANGE,                     STATUS_NEVER);
    /*0x0384*/ DEFINE_HANDLER(CMSG_FORCE_FLIGHT_BACK_SPEED_CHANGE_ACK,                               STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleForceSpeedChangeAck                );
    /*0x0385*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_SET_FLIGHT_SPEED,                            STATUS_NEVER);
    /*0x0386*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_SET_FLIGHT_BACK_SPEED,                       STATUS_NEVER);
    /*0x0387*/ DEFINE_HANDLER(CMSG_MAELSTROM_INVALIDATE_CACHE,                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0924*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FLIGHT_SPLINE_SYNC,                                 STATUS_NEVER);
    /*0x4314*/ DEFINE_HANDLER(CMSG_SET_TAXI_BENCHMARK_MODE,                                          STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetTaxiBenchmarkOpcode             );
    /*0x0000*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_JOINED_BATTLEGROUND_QUEUE,                          STATUS_NEVER);
    /*0x2714*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_REALM_SPLIT,                                        STATUS_NEVER);
    /*0x2906*/ DEFINE_HANDLER(CMSG_REALM_SPLIT,                                                      STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleRealmSplitOpcode                   );
    /*0x3102*/ DEFINE_HANDLER(CMSG_MOVE_CHNG_TRANSPORT,                                              STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    /*0x0424*/ DEFINE_HANDLER(MSG_PARTY_ASSIGNMENT,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandlePartyAssignmentOpcode              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_PARTY_ASSIGNMENT, MSG_PARTY_ASSIGNMENT, MSG_PARTY_ASSIGNMENT_SERVER);
    /*0x2716*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_OFFER_PETITION_ERROR,                               STATUS_NEVER);
    /*0x3CA4*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TIME_SYNC_REQ,                                      STATUS_NEVER);
    /*0x3B0C*/ DEFINE_HANDLER(CMSG_TIME_SYNC_RESP,                                                   STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleTimeSyncResp                       );
    /*0x0392*/ DEFINE_HANDLER(CMSG_SEND_LOCAL_EVENT,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0393*/ DEFINE_HANDLER(CMSG_SEND_GENERAL_TRIGGER,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0394*/ DEFINE_HANDLER(CMSG_SEND_COMBAT_TRIGGER,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0395*/ DEFINE_HANDLER(CMSG_MAELSTROM_GM_SENT_MAIL,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4616*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RESET_FAILED_NOTIFY,                                STATUS_NEVER);
    /*0x0F34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_REAL_GROUP_UPDATE,                                  STATUS_NEVER);
    /*0x0815*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LFG_DISABLED,                                       STATUS_NEVER);
    /*0x0399*/ DEFINE_HANDLER(CMSG_ACTIVE_PVP_CHEAT,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x039A*/ DEFINE_HANDLER(CMSG_CHEAT_DUMP_ITEMS_DEBUG_ONLY,                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x039B*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHEAT_DUMP_ITEMS_DEBUG_ONLY_RESPONSE,               STATUS_NEVER);
    /*0x039C*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHEAT_DUMP_ITEMS_DEBUG_ONLY_RESPONSE_WRITE_FILE,    STATUS_NEVER);
    /*0x6B34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_UPDATE_COMBO_POINTS,                                STATUS_NEVER);
    /*0x2A17*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_VOICE_SESSION_ROSTER_UPDATE,                        STATUS_NEVER);
    /*0x2A24*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_VOICE_SESSION_LEAVE,                                STATUS_NEVER);
    /*0x03A0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_VOICE_SESSION_ADJUST_PRIORITY,                      STATUS_NEVER);
    /*0x03A1*/ DEFINE_HANDLER(CMSG_VOICE_SET_TALKER_MUTED_REQUEST,                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6E35*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_VOICE_SET_TALKER_MUTED,                             STATUS_NEVER);
    /*0x03A3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INIT_EXTRA_AURA_INFO_OBSOLETE,                      STATUS_NEVER);
    /*0x03A4*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_EXTRA_AURA_INFO_OBSOLETE,                       STATUS_NEVER);
    /*0x03A5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_EXTRA_AURA_INFO_NEED_UPDATE_OBSOLETE,           STATUS_NEVER);
    /*0x03A6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CLEAR_EXTRA_AURA_INFO_OBSOLETE,                     STATUS_NEVER);
    /*0x3800*/ DEFINE_HANDLER(MSG_MOVE_START_DESCEND,                                                STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMovementOpcodes                    );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_START_DESCEND, MSG_MOVE_START_DESCEND, MSG_MOVE_START_DESCEND_SERVER);
    /*0x03A8*/ DEFINE_HANDLER(CMSG_IGNORE_REQUIREMENTS_CHEAT,                                        STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4E36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_IGNORE_REQUIREMENTS_CHEAT,                          STATUS_NEVER);
    /*0x03AA*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELL_CHANCE_PROC_LOG,                              STATUS_NEVER);
    /*0x03AB*/ DEFINE_HANDLER(CMSG_MOVE_SET_RUN_SPEED,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2135*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DISMOUNT,                                           STATUS_NEVER);
    /*0x03AD*/ DEFINE_HANDLER(MSG_MOVE_UPDATE_CAN_FLY,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_UPDATE_CAN_FLY, MSG_MOVE_UPDATE_CAN_FLY, MSG_MOVE_UPDATE_CAN_FLY_SERVER);
    /*0x4F05*/ DEFINE_HANDLER(MSG_RAID_READY_CHECK_CONFIRM,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_RAID_READY_CHECK_CONFIRM, MSG_RAID_READY_CHECK_CONFIRM, MSG_RAID_READY_CHECK_CONFIRM_SERVER);
    /*0x2314*/ DEFINE_HANDLER(CMSG_VOICE_SESSION_ENABLE,                                             STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleVoiceSessionEnableOpcode           );
    /*0x03B0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_VOICE_SESSION_ENABLE,                               STATUS_NEVER);
    /*0x0534*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_VOICE_PARENTAL_CONTROLS,                            STATUS_NEVER);
    /*0x03B2*/ DEFINE_HANDLER(CMSG_GM_WHISPER,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6434*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GM_MESSAGECHAT,                                     STATUS_NEVER);
    /*0x03B4*/ DEFINE_HANDLER(MSG_GM_GEARRATING,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GM_GEARRATING, MSG_GM_GEARRATING, MSG_GM_GEARRATING_SERVER);
    /*0x0B07*/ DEFINE_HANDLER(CMSG_COMMENTATOR_ENABLE,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0737*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMMENTATOR_STATE_CHANGED,                          STATUS_NEVER);
    /*0x0026*/ DEFINE_HANDLER(CMSG_COMMENTATOR_GET_MAP_INFO,                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0327*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMMENTATOR_MAP_INFO,                               STATUS_NEVER);
    /*0x0D14*/ DEFINE_HANDLER(CMSG_COMMENTATOR_GET_PLAYER_INFO,                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03BA*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMMENTATOR_GET_PLAYER_INFO,                        STATUS_NEVER);
    /*0x2F36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMMENTATOR_PLAYER_INFO,                            STATUS_NEVER);
    /*0x4105*/ DEFINE_HANDLER(CMSG_COMMENTATOR_ENTER_INSTANCE,                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6136*/ DEFINE_HANDLER(CMSG_COMMENTATOR_EXIT_INSTANCE,                                        STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0917*/ DEFINE_HANDLER(CMSG_COMMENTATOR_INSTANCE_COMMAND,                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4B26*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CLEAR_TARGET,                                       STATUS_NEVER);
    /*0x03C0*/ DEFINE_HANDLER(CMSG_BOT_DETECTED,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2036*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CROSSED_INEBRIATION_THRESHOLD,                      STATUS_NEVER);
    /*0x03C2*/ DEFINE_HANDLER(CMSG_CHEAT_PLAYER_LOGIN,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03C3*/ DEFINE_HANDLER(CMSG_CHEAT_PLAYER_LOOKUP,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03C4*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHEAT_PLAYER_LOOKUP,                                STATUS_NEVER);
    /*0x4027*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_KICK_REASON,                                        STATUS_NEVER);
    /*0x2E15*/ DEFINE_HANDLER(MSG_RAID_READY_CHECK_FINISHED,                                         STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleRaidReadyCheckFinishedOpcode       );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_RAID_READY_CHECK_FINISHED, MSG_RAID_READY_CHECK_FINISHED, MSG_RAID_READY_CHECK_FINISHED_SERVER);
    /*0x03C7*/ DEFINE_HANDLER(CMSG_COMPLAIN,                                                         STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleComplainOpcode                     );
    /*0x03C8*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMPLAIN_RESULT,                                    STATUS_NEVER);
    /*0x3DB7*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FEATURE_SYSTEM_STATUS,                              STATUS_NEVER);
    /*0x03CA*/ DEFINE_HANDLER(CMSG_GM_SHOW_COMPLAINTS,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03CB*/ DEFINE_HANDLER(CMSG_GM_UNSQUELCH,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03CC*/ DEFINE_HANDLER(CMSG_CHANNEL_SILENCE_VOICE,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03CD*/ DEFINE_HANDLER(CMSG_CHANNEL_SILENCE_ALL,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03CE*/ DEFINE_HANDLER(CMSG_CHANNEL_UNSILENCE_VOICE,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03CF*/ DEFINE_HANDLER(CMSG_CHANNEL_UNSILENCE_ALL,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03D0*/ DEFINE_HANDLER(CMSG_TARGET_CAST,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03D1*/ DEFINE_HANDLER(CMSG_TARGET_SCRIPT_CAST,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03D2*/ DEFINE_HANDLER(CMSG_CHANNEL_DISPLAY_LIST,                                             STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleChannelDisplayListQuery            );
    /*0x4305*/ DEFINE_HANDLER(CMSG_SET_ACTIVE_VOICE_CHANNEL,                                         STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleSetActiveVoiceChannel              );
    /*0x03D4*/ DEFINE_HANDLER(CMSG_GET_CHANNEL_MEMBER_COUNT,                                         STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleGetChannelMemberCount              );
    /*0x6414*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHANNEL_MEMBER_COUNT,                               STATUS_NEVER);
    /*0x03D6*/ DEFINE_HANDLER(CMSG_CHANNEL_VOICE_ON,                                                 STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleChannelVoiceOnOpcode               );
    /*0x03D7*/ DEFINE_HANDLER(CMSG_CHANNEL_VOICE_OFF,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03D8*/ DEFINE_HANDLER(CMSG_DEBUG_LIST_TARGETS,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03D9*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DEBUG_LIST_TARGETS,                                 STATUS_NEVER);
    /*0x2E16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AVAILABLE_VOICE_CHANNEL,                            STATUS_NEVER);
    /*0x0F06*/ DEFINE_HANDLER(CMSG_ADD_VOICE_IGNORE,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0024*/ DEFINE_HANDLER(CMSG_DEL_VOICE_IGNORE,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6B26*/ DEFINE_HANDLER(CMSG_PARTY_SILENCE,                                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4D24*/ DEFINE_HANDLER(CMSG_PARTY_UNSILENCE,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4D06*/ DEFINE_HANDLER(MSG_NOTIFY_PARTY_SQUELCH,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_NOTIFY_PARTY_SQUELCH, MSG_NOTIFY_PARTY_SQUELCH, MSG_NOTIFY_PARTY_SQUELCH_SERVER);
    /*0x4D35*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMSAT_RECONNECT_TRY,                               STATUS_NEVER);
    /*0x0316*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMSAT_DISCONNECT,                                  STATUS_NEVER);
    /*0x6317*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMSAT_CONNECT_FAIL,                                STATUS_NEVER);
    /*0x0F15*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_VOICE_CHAT_STATUS,                                  STATUS_NEVER);
    /*0x6734*/ DEFINE_HANDLER(CMSG_REPORT_PVP_AFK,                                                   STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleReportPvPAFK                       );
    /*0x2D06*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_REPORT_PVP_AFK_RESULT,                              STATUS_NEVER);
    /*0x03E6*/ DEFINE_HANDLER(CMSG_GUILD_BANKER_ACTIVATE,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildBankerActivate                );
    /*0x2E35*/ DEFINE_HANDLER(CMSG_GUILD_BANK_QUERY_TAB,                                             STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildBankQueryTab                  );
    /*0x03E8*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GUILD_BANK_LIST,                                    STATUS_NEVER);
    /*0x2315*/ DEFINE_HANDLER(CMSG_GUILD_BANK_SWAP_ITEMS,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildBankSwapItems                 );
    /*0x0C37*/ DEFINE_HANDLER(CMSG_GUILD_BANK_BUY_TAB,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildBankBuyTab                    );
    /*0x0106*/ DEFINE_HANDLER(CMSG_GUILD_BANK_UPDATE_TAB,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildBankUpdateTab                 );
    /*0x0707*/ DEFINE_HANDLER(CMSG_GUILD_BANK_DEPOSIT_MONEY,                                         STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildBankDepositMoney              );
    /*0x0037*/ DEFINE_HANDLER(CMSG_GUILD_BANK_WITHDRAW_MONEY,                                        STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildBankWithdrawMoney             );
    /*0x03EE*/ DEFINE_HANDLER(MSG_GUILD_BANK_LOG_QUERY,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildBankLogQuery                  );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GUILD_BANK_LOG_QUERY, MSG_GUILD_BANK_LOG_QUERY, MSG_GUILD_BANK_LOG_QUERY_SERVER);
    /*0x4517*/ DEFINE_HANDLER(CMSG_SET_CHANNEL_WATCH,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetChannelWatch                    );
    /*0x0F37*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_USERLIST_ADD,                                       STATUS_NEVER);
    /*0x2006*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_USERLIST_REMOVE,                                    STATUS_NEVER);
    /*0x0135*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_USERLIST_UPDATE,                                    STATUS_NEVER);
    /*0x2604*/ DEFINE_HANDLER(CMSG_CLEAR_CHANNEL_WATCH,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleClearChannelWatch                  );
    /*0x4014*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INSPECT_TALENT,                                     STATUS_NEVER);
    /*0x03F5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GOGOGO_OBSOLETE,                                    STATUS_NEVER);
    /*0x0814*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ECHO_PARTY_SQUELCH,                                 STATUS_NEVER);
    /*0x03F7*/ DEFINE_HANDLER(CMSG_SET_TITLE_SUFFIX,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0805*/ DEFINE_HANDLER(CMSG_SPELLCLICK,                                                       STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleSpellClick                         );
    /*0x6807*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_LIST,                                          STATUS_NEVER);
    /*0x03FA*/ DEFINE_HANDLER(CMSG_GM_CHARACTER_RESTORE,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x03FB*/ DEFINE_HANDLER(CMSG_GM_CHARACTER_SAVE,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6225*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_VOICESESSION_FULL,                                  STATUS_NEVER);
    /*0x03FD*/ DEFINE_HANDLER(MSG_GUILD_PERMISSIONS,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildPermissions                   );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GUILD_PERMISSIONS, MSG_GUILD_PERMISSIONS, MSG_GUILD_PERMISSIONS_SERVER);
    DEFINE_HANDLER(CMSG_GUILD_BANK_REMAINING_WITHDRAW_MONEY_QUERY, STATUS_LOGGEDIN, PROCESS_THREADUNSAFE,
        &WorldSession::HandleGuildBankMoneyWithdrawn);
    DEFINE_SERVER_OPCODE_HANDLER(SMSG_GUILD_BANK_MONEY_WITHDRAWN, STATUS_NEVER);
    DEFINE_HANDLER(CMSG_GUILD_SET_ACHIEVEMENT_TRACKING, STATUS_UNHANDLED, PROCESS_INPLACE, &WorldSession::Handle_NULL);
    /*0x03FF*/ DEFINE_HANDLER(MSG_GUILD_EVENT_LOG_QUERY,                                             STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGuildEventLogQueryOpcode           );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GUILD_EVENT_LOG_QUERY, MSG_GUILD_EVENT_LOG_QUERY, MSG_GUILD_EVENT_LOG_QUERY_SERVER);
    /*0x0400*/ DEFINE_HANDLER(CMSG_MAELSTROM_RENAME_GUILD,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0C25*/ DEFINE_HANDLER(CMSG_GET_MIRRORIMAGE_DATA,                                             STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleMirrorImageDataRequest             );
    /*0x2634*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MIRRORIMAGE_DATA,                                   STATUS_NEVER);
    /*0x0000*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_DISPLAY_UPDATE,                               STATUS_NEVER);
    /*0x0404*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPELL_CHANCE_RESIST_PUSHBACK,                       STATUS_NEVER);
    /*0x0405*/ DEFINE_HANDLER(CMSG_IGNORE_DIMINISHING_RETURNS_CHEAT,                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0125*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_IGNORE_DIMINISHING_RETURNS_CHEAT,                   STATUS_NEVER);
    /*0x0015*/ DEFINE_HANDLER(CMSG_KEEP_ALIVE,                                                       STATUS_NEVER,      PROCESS_THREADUNSAFE,   &WorldSession::Handle_EarlyProccess                     );
    /*0x0408*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RAID_READY_CHECK_ERROR,                             STATUS_NEVER);
    /*0x6B16*/ DEFINE_HANDLER(CMSG_OPT_OUT_OF_LOOT,                                                  STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleOptOutOfLootOpcode                 );
    /*0x040A*/ DEFINE_HANDLER(MSG_QUERY_GUILD_BANK_TEXT,                                             STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleQueryGuildBankTabText              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_QUERY_GUILD_BANK_TEXT, MSG_QUERY_GUILD_BANK_TEXT, MSG_QUERY_GUILD_BANK_TEXT_SERVER);
    /*0x040B*/ DEFINE_HANDLER(CMSG_SET_GUILD_BANK_TEXT,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetGuildBankTabText                );
    /*0x040C*/ DEFINE_HANDLER(CMSG_SET_GRANTABLE_LEVELS,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6D16*/ DEFINE_HANDLER(CMSG_GRANT_LEVEL,                                                      STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGrantLevel                         );
    /*0x040E*/ DEFINE_HANDLER(CMSG_REFER_A_FRIEND,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x040F*/ DEFINE_HANDLER(MSG_GM_CHANGE_ARENA_RATING,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_GM_CHANGE_ARENA_RATING, MSG_GM_CHANGE_ARENA_RATING, MSG_GM_CHANGE_ARENA_RATING_SERVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_DECLINE_CHANNEL_INVITE,                                           STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleChannelDeclineInvite               );
    /*0x6524*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GROUPACTION_THROTTLED,                              STATUS_NEVER);
    /*0x4225*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_OVERRIDE_LIGHT,                                     STATUS_NEVER);
    /*0x2414*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TOTEM_CREATED,                                      STATUS_NEVER);
    /*0x4207*/ DEFINE_HANDLER(CMSG_TOTEM_DESTROYED,                                                  STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleTotemDestroyed                     );
    /*0x0415*/ DEFINE_HANDLER(CMSG_EXPIRE_RAID_INSTANCE,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0416*/ DEFINE_HANDLER(CMSG_NO_SPELL_VARIANCE,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6305*/ DEFINE_HANDLER(CMSG_QUESTGIVER_STATUS_MULTIPLE_QUERY,                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleQuestgiverStatusMultipleQuery      );
    /*0x4F25*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTGIVER_STATUS_MULTIPLE,                         STATUS_NEVER);
    /*0x6316*/ DEFINE_HANDLER(CMSG_SET_PLAYER_DECLINED_NAMES,                                        STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleSetPlayerDeclinedNames             );
    /*0x2B25*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_PLAYER_DECLINED_NAMES_RESULT,                   STATUS_NEVER);
    /*0x041B*/ DEFINE_HANDLER(CMSG_QUERY_SERVER_BUCK_DATA,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x041C*/ DEFINE_HANDLER(CMSG_CLEAR_SERVER_BUCK_DATA,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x041D*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SERVER_BUCK_DATA,                                   STATUS_NEVER);
    /*0x4E25*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SEND_UNLEARN_SPELLS,                                STATUS_NEVER);
    /*0x6114*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PROPOSE_LEVEL_GRANT,                                STATUS_NEVER);
    /*0x0205*/ DEFINE_HANDLER(CMSG_ACCEPT_LEVEL_GRANT,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAcceptGrantLevel                   );
    /*0x2037*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_REFER_A_FRIEND_FAILURE,                             STATUS_NEVER);
    /*0x31B5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_SET_FLYING,                             STATUS_NEVER);
    /*0x58A6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_UNSET_FLYING,                           STATUS_NEVER);
    /*0x0B34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SUMMON_CANCEL,                                      STATUS_NEVER);
    /*0x0914*/ DEFINE_HANDLER(CMSG_ALTER_APPEARANCE,                                                 STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAlterAppearance                    );
    /*0x2D16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ENABLE_BARBER_SHOP,                                 STATUS_NEVER);
    /*0x6125*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BARBER_SHOP_RESULT,                                 STATUS_NEVER);
    /*0x2814*/ DEFINE_HANDLER(CMSG_CALENDAR_GET_CALENDAR,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarGetCalendar                );
    /*0x6416*/ DEFINE_HANDLER(CMSG_CALENDAR_GET_EVENT,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarGetEvent                   );
    /*0x4A16*/ DEFINE_HANDLER(CMSG_CALENDAR_GUILD_FILTER,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarGuildFilter                );
    /*0x0204*/ DEFINE_HANDLER(CMSG_CALENDAR_ARENA_TEAM,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarArenaTeam                  );
    /*0x0726*/ DEFINE_HANDLER(CMSG_CALENDAR_ADD_EVENT,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarAddEvent                   );
    /*0x2114*/ DEFINE_HANDLER(CMSG_CALENDAR_UPDATE_EVENT,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarUpdateEvent                );
    /*0x6636*/ DEFINE_HANDLER(CMSG_CALENDAR_REMOVE_EVENT,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarRemoveEvent                );
    /*0x0207*/ DEFINE_HANDLER(CMSG_CALENDAR_COPY_EVENT,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarCopyEvent                  );
    /*0x2435*/ DEFINE_HANDLER(CMSG_CALENDAR_EVENT_INVITE,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarEventInvite                );
    /*0x0227*/ DEFINE_HANDLER(CMSG_CALENDAR_EVENT_RSVP,                                              STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarEventRsvp                  );
    /*0x4337*/ DEFINE_HANDLER(CMSG_CALENDAR_EVENT_REMOVE_INVITE,                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarEventRemoveInvite          );
    /*0x2D24*/ DEFINE_HANDLER(CMSG_CALENDAR_EVENT_STATUS,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarEventStatus                );
    /*0x6B35*/ DEFINE_HANDLER(CMSG_CALENDAR_EVENT_MODERATOR_STATUS,                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarEventModeratorStatus       );
    /*0x6805*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_SEND_CALENDAR,                             STATUS_NEVER);
    /*0x0C35*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_SEND_EVENT,                                STATUS_NEVER);
    /*0x4A26*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_FILTER_GUILD,                              STATUS_NEVER);
    /*0x0615*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_ARENA_TEAM,                                STATUS_NEVER);
    /*0x4E16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_INVITE,                              STATUS_NEVER);
    /*0x0725*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_INVITE_REMOVED,                      STATUS_NEVER);
    /*0x2A27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_STATUS,                              STATUS_NEVER);
    /*0x6F36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_COMMAND_RESULT,                            STATUS_NEVER);
    /*0x2305*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_RAID_LOCKOUT_ADDED,                        STATUS_NEVER);
    /*0x2E25*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_RAID_LOCKOUT_REMOVED,                      STATUS_NEVER);
    /*0x2A05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_INVITE_ALERT,                        STATUS_NEVER);
    /*0x2617*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_INVITE_REMOVED_ALERT,                STATUS_NEVER);
    /*0x6625*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_INVITE_STATUS_ALERT,                 STATUS_NEVER);
    /*0x6D35*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_REMOVED_ALERT,                       STATUS_NEVER);
    /*0x0907*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_UPDATED_ALERT,                       STATUS_NEVER);
    /*0x6B06*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_MODERATOR_STATUS_ALERT,              STATUS_NEVER);
    /*0x4C36*/ DEFINE_HANDLER(CMSG_CALENDAR_COMPLAIN,                                                STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarComplain                   );
    /*0x4D05*/ DEFINE_HANDLER(CMSG_CALENDAR_GET_NUM_PENDING,                                         STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarGetNumPending              );
    /*0x0C17*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_SEND_NUM_PENDING,                          STATUS_NEVER);
    /*0x449*/ //DEFINE_HANDLER(CMSG_SAVE_DANCE,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4904*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_NOTIFY_DANCE,                                       STATUS_NEVER);
    /*0x6914*/ DEFINE_HANDLER(CMSG_PLAY_DANCE,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4704*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAY_DANCE,                                         STATUS_NEVER);
    /*0x044D*/ DEFINE_HANDLER(CMSG_LOAD_DANCES,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2907*/ DEFINE_HANDLER(CMSG_STOP_DANCE,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4637*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_STOP_DANCE,                                         STATUS_NEVER);
    /*0x0036*/ DEFINE_HANDLER(CMSG_SYNC_DANCE,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4E07*/ DEFINE_HANDLER(CMSG_DANCE_QUERY,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2F06*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DANCE_QUERY_RESPONSE,                               STATUS_NEVER);
    /*0x0E27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_INVALIDATE_DANCE,                                   STATUS_NEVER);
    /*0x0454*/ DEFINE_HANDLER(CMSG_DELETE_DANCE,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0E05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LEARNED_DANCE_MOVES,                                STATUS_NEVER);
    /*0x0456*/ DEFINE_HANDLER(CMSG_LEARN_DANCE_MOVE,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0457*/ DEFINE_HANDLER(CMSG_UNLEARN_DANCE_MOVE,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0458*/ DEFINE_HANDLER(CMSG_SET_RUNE_COUNT,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0459*/ DEFINE_HANDLER(CMSG_SET_RUNE_COOLDOWN,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x045A*/ DEFINE_HANDLER(MSG_MOVE_SET_PITCH_RATE_CHEAT,                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_PITCH_RATE_CHEAT, MSG_MOVE_SET_PITCH_RATE_CHEAT, MSG_MOVE_SET_PITCH_RATE_CHEAT_SERVER);
    /*0x045B*/ DEFINE_HANDLER(MSG_MOVE_SET_PITCH_RATE,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_PITCH_RATE, MSG_MOVE_SET_PITCH_RATE, MSG_MOVE_SET_PITCH_RATE_SERVER);
    /*0x045C*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_PITCH_RATE_CHANGE,                            STATUS_NEVER);
    /*0x045D*/ DEFINE_HANDLER(CMSG_FORCE_PITCH_RATE_CHANGE_ACK,                                      STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleForceSpeedChangeAck                );
    /*0x045E*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_SET_PITCH_RATE,                              STATUS_NEVER);
    /*0x045F*/ DEFINE_HANDLER(CMSG_CALENDAR_EVENT_INVITE_NOTES,                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0E17*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_INVITE_NOTES,                        STATUS_NEVER);
    /*0x2535*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_EVENT_INVITE_NOTES_ALERT,                  STATUS_NEVER);
    /*0x781E*/ DEFINE_HANDLER(CMSG_UPDATE_MISSILE_TRAJECTORY,                                        STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleUpdateMissileTrajectory            );
    /*0x2015*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_UPDATE_ACCOUNT_DATA_COMPLETE,                       STATUS_NEVER);
    /*0x4625*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TRIGGER_MOVIE,                                      STATUS_NEVER);
    /*0x4136*/ DEFINE_HANDLER(CMSG_COMPLETE_MOVIE,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0466*/ DEFINE_HANDLER(CMSG_SET_GLYPH_SLOT,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0467*/ DEFINE_HANDLER(CMSG_SET_GLYPH,                                                        STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4405*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ACHIEVEMENT_EARNED,                                 STATUS_NEVER);
    /*0x0469*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DYNAMIC_DROP_ROLL_RESULT,                           STATUS_NEVER);
    /*0x6E37*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CRITERIA_UPDATE,                                    STATUS_NEVER);
    /*0x4D27*/ DEFINE_HANDLER(CMSG_QUERY_INSPECT_ACHIEVEMENTS,                                       STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQueryInspectAchievements           );
    /*0x15B0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RESPOND_INSPECT_ACHIEVEMENTS,                       STATUS_NEVER);
    /*0x3218*/ DEFINE_HANDLER(CMSG_DISMISS_CONTROLLED_VEHICLE,                                       STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleDismissControlledVehicle           );
    /*0x046E*/ DEFINE_HANDLER(CMSG_COMPLETE_ACHIEVEMENT_CHEAT,                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x046F*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUESTUPDATE_ADD_PVP_KILL,                           STATUS_NEVER);
    /*0x0470*/ DEFINE_HANDLER(CMSG_SET_CRITERIA_CHEAT,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4636*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_RAID_LOCKOUT_UPDATED,                      STATUS_NEVER);
    /*0x0472*/ DEFINE_HANDLER(CMSG_UNITANIMTIER_CHEAT,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2C34*/ DEFINE_HANDLER(CMSG_CHAR_CUSTOMIZE,                                                   STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleCharCustomize                      );
    /*0x4F16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAR_CUSTOMIZE,                                     STATUS_NEVER);
    /*0x2B27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_RENAMEABLE,                                     STATUS_NEVER);
    /*0x2B35*/ DEFINE_HANDLER(CMSG_REQUEST_VEHICLE_EXIT,                                             STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleRequestVehicleExit                 );
    /*0x4C04*/ DEFINE_HANDLER(CMSG_REQUEST_VEHICLE_PREV_SEAT,                                        STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleChangeSeatsOnControlledVehicle     );
    /*0x4434*/ DEFINE_HANDLER(CMSG_REQUEST_VEHICLE_NEXT_SEAT,                                        STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleChangeSeatsOnControlledVehicle     );
    /*0x4C14*/ DEFINE_HANDLER(CMSG_REQUEST_VEHICLE_SWITCH_SEAT,                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleChangeSeatsOnControlledVehicle     );
    /*0x6725*/ DEFINE_HANDLER(CMSG_PET_LEARN_TALENT,                                                 STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandlePetLearnTalent                     );
    /*0x047B*/ DEFINE_HANDLER(CMSG_PET_UNLEARN_TALENTS,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x047C*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_PHASE_SHIFT,                                    STATUS_NEVER);
    /*0x58B1*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ALL_ACHIEVEMENT_DATA,                               STATUS_NEVER);
    /*0x047E*/ DEFINE_HANDLER(CMSG_FORCE_SAY_CHEAT,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4734*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_HEALTH_UPDATE,                                      STATUS_NEVER);
    /*0x4A07*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_POWER_UPDATE,                                       STATUS_NEVER);
    /*0x4827*/ DEFINE_HANDLER(CMSG_GAMEOBJ_REPORT_USE,                                               STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleGameobjectReportUse                );
    /*0x4104*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_HIGHEST_THREAT_UPDATE,                              STATUS_NEVER);
    /*0x4735*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_THREAT_UPDATE,                                      STATUS_NEVER);
    /*0x2E05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_THREAT_REMOVE,                                      STATUS_NEVER);
    /*0x6437*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_THREAT_CLEAR,                                       STATUS_NEVER);
    /*0x4F14*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CONVERT_RUNE,                                       STATUS_NEVER);
    /*0x6224*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_RESYNC_RUNES,                                       STATUS_NEVER);
    /*0x6915*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ADD_RUNE_POWER,                                     STATUS_NEVER);
    /*0x0000*/ DEFINE_HANDLER(CMSG_START_QUEST,                                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x048A*/ DEFINE_HANDLER(CMSG_REMOVE_GLYPH,                                                     STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleRemoveGlyph                        );
    /*0x048B*/ DEFINE_HANDLER(CMSG_DUMP_OBJECTS,                                                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x048C*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DUMP_OBJECTS_DATA,                                  STATUS_NEVER);
    /*0x4227*/ DEFINE_HANDLER(CMSG_DISMISS_CRITTER,                                                  STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleDismissCritter                     );
    /*0x6204*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_NOTIFY_DEST_LOC_SPELL_CAST,                         STATUS_NEVER);
    /*0x2C17*/ DEFINE_HANDLER(CMSG_AUCTION_LIST_PENDING_SALES,                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleAuctionListPendingSales            );
    /*0x6A27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AUCTION_LIST_PENDING_SALES,                         STATUS_NEVER);
    /*0x6016*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MODIFY_COOLDOWN,                                    STATUS_NEVER);
    /*0x4325*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_UPDATE_COMBO_POINTS,                            STATUS_NEVER);
    /*0x0C16*/ DEFINE_HANDLER(CMSG_ENABLETAXI,                                                       STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleTaxiQueryAvailableNodes            );
    /*0x6C36*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PRE_RESURRECT,                                      STATUS_NEVER);
    /*0x6916*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AURA_UPDATE_ALL,                                    STATUS_NEVER);
    /*0x4707*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AURA_UPDATE,                                        STATUS_NEVER);
    /*0x0497*/ DEFINE_HANDLER(CMSG_FLOOD_GRACE_CHEAT,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6424*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SERVER_FIRST_ACHIEVEMENT,                           STATUS_NEVER);
    /*0x0507*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_LEARNED_SPELL,                                  STATUS_NEVER);
    /*0x049A*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_UNLEARNED_SPELL,                                STATUS_NEVER);
    /*0x7310*/ DEFINE_HANDLER(CMSG_CHANGE_SEATS_ON_CONTROLLED_VEHICLE,                               STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleChangeSeatsOnControlledVehicle     );
    /*0x4B34*/ DEFINE_HANDLER(CMSG_HEARTH_AND_RESURRECT,                                             STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleHearthAndResurrect                 );
    /*0x4D34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ON_CANCEL_EXPECTED_RIDE_VEHICLE_AURA,               STATUS_NEVER);
    /*0x2915*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CRITERIA_DELETED,                                   STATUS_NEVER);
    /*0x6A16*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ACHIEVEMENT_DELETED,                                STATUS_NEVER);
    /*0x04A0*/ DEFINE_HANDLER(CMSG_SERVER_INFO_QUERY,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x74B5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SERVER_INFO_RESPONSE,                               STATUS_NEVER);
    /*0x04A2*/ DEFINE_HANDLER(CMSG_CHECK_LOGIN_CRITERIA,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04A3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SERVER_BUCK_DATA_START,                             STATUS_NEVER);
    /*0x04A4*/ DEFINE_HANDLER(CMSG_SET_BREATH,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04A5*/ DEFINE_HANDLER(CMSG_QUERY_VEHICLE_STATUS,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x34B2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEGROUND_INFO_THROTTLED,                        STATUS_NEVER);
    /*0x04A7*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PLAYER_VEHICLE_DATA,                                STATUS_NEVER);
    /*0x2705*/ DEFINE_HANDLER(CMSG_PLAYER_VEHICLE_ENTER,                                             STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleEnterPlayerVehicle                 );
    /*0x04A9*/ DEFINE_HANDLER(CMSG_CONTROLLER_EJECT_PASSENGER,                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleEjectPassenger                     );
    /*0x2D26*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PET_GUIDS,                                          STATUS_NEVER);
    /*0x2734*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CLIENTCACHE_VERSION,                                STATUS_NEVER);
    /*0x04AC*/ DEFINE_HANDLER(CMSG_CHANGE_GDF_ARENA_RATING,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04AD*/ DEFINE_HANDLER(CMSG_SET_ARENA_TEAM_RATING_BY_INDEX,                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04AE*/ DEFINE_HANDLER(CMSG_SET_ARENA_TEAM_WEEKLY_GAMES,                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04AF*/ DEFINE_HANDLER(CMSG_SET_ARENA_TEAM_SEASON_GAMES,                                      STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04B0*/ DEFINE_HANDLER(CMSG_SET_ARENA_MEMBER_WEEKLY_GAMES,                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04B1*/ DEFINE_HANDLER(CMSG_SET_ARENA_MEMBER_SEASON_GAMES,                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x15A3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ITEM_REFUND_INFO_RESPONSE,                          STATUS_NEVER);
    /*0x2206*/ DEFINE_HANDLER(CMSG_ITEM_REFUND_INFO,                                                 STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleItemRefundInfoRequest              );
    /*0x6134*/ DEFINE_HANDLER(CMSG_ITEM_REFUND,                                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleItemRefund                         );
    /*0x5DB1*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ITEM_REFUND_RESULT,                                 STATUS_NEVER);
    /*0x6205*/ DEFINE_HANDLER(CMSG_CORPSE_MAP_POSITION_QUERY,                                        STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCorpseMapPositionQuery             );
    /*0x0E35*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CORPSE_MAP_POSITION_QUERY_RESPONSE,                 STATUS_NEVER);
    /*0x04B8*/ DEFINE_HANDLER(CMSG_UNUSED5,                                                          STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::Handle_NULL                              );
    /*0x04B9*/ DEFINE_HANDLER(CMSG_UNUSED6,                                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6606*/ DEFINE_HANDLER(CMSG_CALENDAR_EVENT_SIGNUP,                                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleCalendarEventSignup                );
    /*0x2106*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CALENDAR_CLEAR_PENDING_ACTION,                      STATUS_NEVER);
    /*0x2E04*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_EQUIPMENT_SET_LIST,                                 STATUS_NEVER);
    /*0x4F27*/ DEFINE_HANDLER(CMSG_EQUIPMENT_SET_SAVE,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleEquipmentSetSave                   );
    /*0x0E24*/ DEFINE_HANDLER(CMSG_UPDATE_PROJECTILE_POSITION,                                       STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleUpdateProjectilePosition           );
    /*0x2616*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SET_PROJECTILE_POSITION,                            STATUS_NEVER);
    /*0x6F26*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TALENTS_INFO,                                       STATUS_NEVER);
    /*0x2415*/ DEFINE_HANDLER(CMSG_LEARN_PREVIEW_TALENTS,                                            STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleLearnPreviewTalents                );
    /*0x6E24*/ DEFINE_HANDLER(CMSG_LEARN_PREVIEW_TALENTS_PET,                                        STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleLearnPreviewTalentsPet             );
    /*0x04C3*/ DEFINE_HANDLER(CMSG_SET_ACTIVE_TALENT_GROUP_OBSOLETE,                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04C4*/ DEFINE_HANDLER(CMSG_GM_GRANT_ACHIEVEMENT,                                             STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04C5*/ DEFINE_HANDLER(CMSG_GM_REMOVE_ACHIEVEMENT,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04C6*/ DEFINE_HANDLER(CMSG_GM_SET_CRITERIA_FOR_PLAYER,                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2637*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ARENA_UNIT_DESTROYED,                               STATUS_NEVER);
    /*0x6E34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_ARENA_TEAM_CHANGE_FAILED_QUEUED,                    STATUS_NEVER);
    /*0x04C9*/ DEFINE_HANDLER(CMSG_PROFILEDATA_REQUEST,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04CA*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PROFILEDATA_RESPONSE,                               STATUS_NEVER);
    /*0x04CB*/ DEFINE_HANDLER(CMSG_START_BATTLEFIELD_CHEAT,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04CC*/ DEFINE_HANDLER(CMSG_END_BATTLEFIELD_CHEAT,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6736*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MULTIPLE_PACKETS,                                   STATUS_NEVER);
    /*0x75B2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_GRAVITY_DISABLE,                               STATUS_NEVER);
    /*0x3118*/ DEFINE_HANDLER(CMSG_MOVE_GRAVITY_DISABLE_ACK,                                         STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveFlagChangeOpcode               );
    /*0x30B3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_GRAVITY_ENABLE,                                STATUS_NEVER);
    /*0x700A*/ DEFINE_HANDLER(CMSG_MOVE_GRAVITY_ENABLE_ACK,                                          STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleMoveFlagChangeOpcode               );
    /*0x04D2*/ DEFINE_SERVER_OPCODE_HANDLER(MSG_MOVE_GRAVITY_CHNG,                                   STATUS_NEVER);
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_GRAVITY_CHNG, MSG_MOVE_GRAVITY_CHNG_CLIENT, MSG_MOVE_GRAVITY_CHNG);
    /*0x5DB5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_GRAVITY_DISABLE,                        STATUS_NEVER);
    /*0x3CA6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SPLINE_MOVE_GRAVITY_ENABLE,                         STATUS_NEVER);
    /*0x0417*/ DEFINE_HANDLER(CMSG_EQUIPMENT_SET_USE,                                                STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleEquipmentSetUse                    );
    /*0x2424*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_EQUIPMENT_SET_USE_RESULT,                           STATUS_NEVER);
    /*0x04D7*/ DEFINE_HANDLER(CMSG_FORCE_ANIM,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4C05*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_ANIM,                                         STATUS_NEVER);
    /*0x2735*/ DEFINE_HANDLER(CMSG_CHAR_FACTION_CHANGE,                                              STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleCharFactionOrRaceChange            );
    /*0x4C06*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CHAR_FACTION_CHANGE,                                STATUS_NEVER);
    /*0x04DB*/ DEFINE_HANDLER(CMSG_PVP_QUEUE_STATS_REQUEST,                                          STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04DC*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PVP_QUEUE_STATS,                                    STATUS_NEVER);
    /*0x04DD*/ DEFINE_HANDLER(CMSG_SET_PAID_SERVICE_CHEAT,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x34B3*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEFIELD_MGR_ENTRY_INVITE,                       STATUS_NEVER);
    /*0x05A3*/ DEFINE_HANDLER(CMSG_BATTLEFIELD_MGR_ENTRY_INVITE_RESPONSE,                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBfEntryInviteResponse              ); // pussywizard: unsafe, changes groups and much more >_>
    /*0x5CA0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEFIELD_MGR_ENTERED,                            STATUS_NEVER);
    /*0x15A6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEFIELD_MGR_QUEUE_INVITE,                       STATUS_NEVER);
    /*0x0413*/ DEFINE_HANDLER(CMSG_BATTLEFIELD_MGR_QUEUE_INVITE_RESPONSE,                            STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBfQueueInviteResponse              );
    /*0x710C*/ DEFINE_HANDLER(CMSG_BATTLEFIELD_MGR_QUEUE_REQUEST,                                    STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x79B6*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE,             STATUS_NEVER);
    /*0x34A2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEFIELD_MGR_EJECT_PENDING,                      STATUS_NEVER);
    /*0x7DB7*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEFIELD_MGR_EJECTED,                            STATUS_NEVER);
    /*0x2490*/ DEFINE_HANDLER(CMSG_BATTLEFIELD_MGR_EXIT_REQUEST,                                     STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleBfExitRequest                      );
    /*0x35B4*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_BATTLEFIELD_MGR_STATE_CHANGE,                       STATUS_NEVER);
    /*0x04E9*/ DEFINE_HANDLER(CMSG_BATTLEFIELD_MANAGER_ADVANCE_STATE,                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04EA*/ DEFINE_HANDLER(CMSG_BATTLEFIELD_MANAGER_SET_NEXT_TRANSITION_TIME,                     STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0614*/ DEFINE_HANDLER(MSG_SET_RAID_DIFFICULTY,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleSetRaidDifficultyOpcode            );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_SET_RAID_DIFFICULTY, MSG_SET_RAID_DIFFICULTY, MSG_SET_RAID_DIFFICULTY_SERVER);
    /*0x04EC*/ DEFINE_HANDLER(CMSG_TOGGLE_XP_GAIN,                                                   STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x6704*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TOGGLE_XP_GAIN,                                     STATUS_NEVER);
    /*0x0006*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GMRESPONSE_DB_ERROR,                                STATUS_NEVER);
    /*0x2E34*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GMRESPONSE_RECEIVED,                                STATUS_NEVER);
    /*0x6506*/ DEFINE_HANDLER(CMSG_GMRESPONSE_RESOLVE,                                               STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleGMResponseResolve                  );
    /*0x0A04*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GMRESPONSE_STATUS_UPDATE,                           STATUS_NEVER);
    /*0x04F2*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_GMRESPONSE_CREATE_TICKET,                           STATUS_NEVER);
    /*0x04F3*/ DEFINE_HANDLER(CMSG_GMRESPONSE_CREATE_TICKET,                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04F4*/ DEFINE_HANDLER(CMSG_SERVERINFO,                                                       STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x04F5*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SERVERINFO,                                         STATUS_NEVER);
    /*0x4605*/ DEFINE_HANDLER(CMSG_WORLD_STATE_UI_TIMER_UPDATE,                                      STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleWorldStateUITimerUpdate            );
    /*0x4A14*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_WORLD_STATE_UI_TIMER_UPDATE,                        STATUS_NEVER);
    /*0x0D24*/ DEFINE_HANDLER(CMSG_CHAR_RACE_CHANGE,                                                 STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleCharFactionOrRaceChange            );
    /*0x04F9*/ DEFINE_HANDLER(MSG_VIEW_PHASE_SHIFT,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_VIEW_PHASE_SHIFT, MSG_VIEW_PHASE_SHIFT, MSG_VIEW_PHASE_SHIFT_SERVER);
    /*0x2C27*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_TALENTS_INVOLUNTARILY_RESET,                        STATUS_NEVER);
    /*0x04FB*/ DEFINE_HANDLER(CMSG_DEBUG_SERVER_GEO,                                                 STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0235*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_DEBUG_SERVER_GEO,                                   STATUS_NEVER);
    /*0x2935*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_LOOT_SLOT_CHANGED,                                  STATUS_NEVER);
    /*0x4FE*/ DEFINE_HANDLER(UMSG_UPDATE_GROUP_INFO,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2B16*/ DEFINE_HANDLER(CMSG_READY_FOR_ACCOUNT_DATA_TIMES,                                     STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleReadyForAccountDataTimes           );
    /*0x2317*/ DEFINE_HANDLER(CMSG_QUERY_QUESTS_COMPLETED,                                           STATUS_LOGGEDIN,   PROCESS_INPLACE,        &WorldSession::HandleQueryQuestsCompleted               );
    /*0x6314*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_QUERY_QUESTS_COMPLETED_RESPONSE,                    STATUS_NEVER);
    /*0x6726*/ DEFINE_HANDLER(CMSG_GM_REPORT_LAG,                                                    STATUS_LOGGEDIN,   PROCESS_THREADUNSAFE,   &WorldSession::HandleReportLag                          );
    /*0x0503*/ DEFINE_HANDLER(CMSG_AFK_MONITOR_INFO_REQUEST,                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0504*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_AFK_MONITOR_INFO_RESPONSE,                          STATUS_NEVER);
    /*0x0505*/ DEFINE_HANDLER(CMSG_AFK_MONITOR_INFO_CLEAR,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2A14*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CORPSE_NOT_IN_INSTANCE,                             STATUS_NEVER);
    /*0x0507*/ DEFINE_HANDLER(CMSG_GM_NUKE_CHARACTER,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4435*/ DEFINE_HANDLER(CMSG_SET_ALLOW_LOW_LEVEL_RAID1,                                        STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0536*/ DEFINE_HANDLER(CMSG_SET_ALLOW_LOW_LEVEL_RAID2,                                        STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4214*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_CAMERA_SHAKE,                                       STATUS_NEVER);
    /*0x6014*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SOCKET_GEMS_RESULT,                                 STATUS_NEVER);
    /*0x050C*/ DEFINE_HANDLER(CMSG_SET_CHARACTER_MODEL,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x050D*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_REDIRECT_CLIENT,                                    STATUS_NEVER);
    /*0x050E*/ DEFINE_HANDLER(CMSG_REDIRECTION_FAILED,                                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x4140*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SUSPEND_COMMS,                                      STATUS_NEVER);
    /*0x0510*/ DEFINE_HANDLER(CMSG_SUSPEND_COMMS_ACK,                                                STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0511*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_FORCE_SEND_QUEUED_PACKETS,                          STATUS_NEVER);
    /*0x0512*/ DEFINE_HANDLER(CMSG_REDIRECTION_AUTH_PROOF,                                           STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0513*/ DEFINE_HANDLER(CMSG_DROP_NEW_CONNECTION,                                              STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0514*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_SEND_ALL_COMBAT_LOG,                                STATUS_NEVER);
    /*0x2C37*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_OPEN_LFG_DUNGEON_FINDER,                            STATUS_NEVER);
    /*0x0516*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MOVE_SET_COLLISION_HGT,                             STATUS_NEVER);
    /*0x0517*/ DEFINE_HANDLER(CMSG_MOVE_SET_COLLISION_HGT_ACK,                                       STATUS_LOGGEDIN,   PROCESS_THREADSAFE,     &WorldSession::HandleForceSpeedChangeAck                );
    /*0x0518*/ DEFINE_HANDLER(MSG_MOVE_SET_COLLISION_HGT,                                            STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    DEFINE_BIDIRECTIONAL_OPCODE(MSG_MOVE_SET_COLLISION_HGT, MSG_MOVE_SET_COLLISION_HGT, MSG_MOVE_SET_COLLISION_HGT_SERVER);
    /*0x0519*/ DEFINE_HANDLER(CMSG_CLEAR_RANDOM_BG_WIN_TIME,                                         STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x051A*/ DEFINE_HANDLER(CMSG_CLEAR_HOLIDAY_BG_WIN_TIME,                                        STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x0025*/ DEFINE_HANDLER(CMSG_COMMENTATOR_SKIRMISH_QUEUE_COMMAND,                               STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_NULL                              );
    /*0x2126*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMMENTATOR_SKIRMISH_QUEUE_RESULT1,                 STATUS_NEVER);
    /*0x6814*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_COMMENTATOR_SKIRMISH_QUEUE_RESULT2,                 STATUS_NEVER);
    /*0x051E*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_MULTIPLE_MOVES, STATUS_NEVER);
    /*0x51F*/ DEFINE_HANDLER(TC9_CMSG_PREPARE_FOR_REDIRECT,                                         STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleTC9PrepareForRedirect);
    /*0x520*/ DEFINE_SERVER_OPCODE_HANDLER(TC9_SMSG_READY_FOR_REDIRECT, STATUS_NEVER);
    /* CATA */
    /*0x446D*/ DEFINE_HANDLER(CMSG_LOG_DISCONNECT,                                                  STATUS_NEVER,      PROCESS_INPLACE,        &WorldSession::Handle_EarlyProccess                     );
    /*0x2422*/ DEFINE_HANDLER(CMSG_LOADING_SCREEN_NOTIFY,                                           STATUS_AUTHED,     PROCESS_THREADUNSAFE,   &WorldSession::HandleLoadScreenOpcode                   );
    /*0x7816*/ DEFINE_HANDLER(CMSG_VIOLENCE_LEVEL,                                                  STATUS_AUTHED,     PROCESS_INPLACE,        &WorldSession::HandleViolenceLevel                      );
    /*0x70A0*/ DEFINE_SERVER_OPCODE_HANDLER(SMSG_PHASE_SHIFT_CHANGE,                                STATUS_NEVER);

#undef DEFINE_HANDLER
#undef DEFINE_SERVER_OPCODE_HANDLER
#undef DEFINE_BIDIRECTIONAL_OPCODE
}

namespace
{
    std::string FormatOpcodeNameForLogging(uint32 id, char const* name)
    {
        uint16 opcode = uint16(id);
        std::ostringstream ss;
        ss << '[';

        if (id < NUM_OPCODE_HANDLERS)
        {
            if (name)
                ss << name;
            else
                ss << "UNKNOWN OPCODE";
        }
        else
            ss << "INVALID OPCODE";

        ss << " 0x" << std::hex << std::setw(4) << std::setfill('0') << std::uppercase << opcode << std::nouppercase << std::dec << " (" << opcode << ")]";
        return ss.str();
    }
}

std::string OpcodeTable::GetOpcodeNameForLogging(OpcodeClient opcode) const
{
    uint32 value = uint32(opcode);
    char const* name = nullptr;
    if (value < NUM_OPCODE_HANDLERS)
        name = _internalTableClientNames[value] ? _internalTableClientNames[value] : _internalTableServerNames[value];
    return FormatOpcodeNameForLogging(value, name);
}

std::string OpcodeTable::GetOpcodeNameForLogging(OpcodeServer opcode) const
{
    uint32 value = uint32(opcode);
    return FormatOpcodeNameForLogging(value, value < NUM_OPCODE_HANDLERS ? _internalTableServerNames[value] : nullptr);
}

std::string GetOpcodeNameForLogging(OpcodeClient opcode)
{
    return opcodeTable.GetOpcodeNameForLogging(opcode);
}

std::string GetOpcodeNameForLogging(OpcodeServer opcode)
{
    return opcodeTable.GetOpcodeNameForLogging(opcode);
}
