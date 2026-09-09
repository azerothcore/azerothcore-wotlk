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

/// \addtogroup u2w
/// @{
/// \file

#ifndef _OPCODES_H
#define _OPCODES_H

#include "Define.h"
#include <string>

/// Lists of opcodes by wire direction
enum OpcodeClient : uint16
{
    CMSG_BOOTME                                     = 0x001, // DEPRECATED
    CMSG_DBLOOKUP                                   = 0x002, // DEPRECATED
    CMSG_QUERY_OBJECT_POSITION                      = 0x004, // DEPRECATED
    CMSG_QUERY_OBJECT_ROTATION                      = 0x006, // DEPRECATED
    CMSG_WORLD_TELEPORT                             = 0x24B2,
    CMSG_TELEPORT_TO_UNIT                           = 0x4206,
    CMSG_ZONE_MAP                                   = 0x00A, // DEPRECATED
    CMSG_DEBUG_CHANGECELLZONE                       = 0x00C, // DEPRECATED
    CMSG_MOVE_CHARACTER_CHEAT                       = 0x00D, // DEPRECATED
    CMSG_RECHARGE                                   = 0x00F, // DEPRECATED
    CMSG_LEARN_SPELL                                = 0x010, // DEPRECATED
    CMSG_CREATEMONSTER                              = 0x011, // DEPRECATED
    CMSG_DESTROYMONSTER                             = 0x012, // DEPRECATED
    CMSG_CREATEITEM                                 = 0x013, // DEPRECATED
    CMSG_CREATEGAMEOBJECT                           = 0x014, // DEPRECATED
    CMSG_MAKEMONSTERATTACKGUID                      = 0x016, // DEPRECATED
    CMSG_BOT_DETECTED2                              = 0x0000,
    CMSG_FORCEACTION                                = 0x018, // DEPRECATED
    CMSG_FORCEACTIONONOTHER                         = 0x019, // DEPRECATED
    CMSG_FORCEACTIONSHOW                            = 0x01A, // DEPRECATED
    CMSG_PETGODMODE                                 = 0x01C, // DEPRECATED
    CMSG_WEATHER_SPEED_CHEAT                        = 0x01F, // DEPRECATED
    CMSG_UNDRESSPLAYER                              = 0x020, // DEPRECATED
    CMSG_BEASTMASTER                                = 0x021, // DEPRECATED
    CMSG_GODMODE                                    = 0x022, // DEPRECATED
    CMSG_SET_WORLDSTATE                             = 0x027, // DEPRECATED
    CMSG_COOLDOWN_CHEAT                             = 0x028, // DEPRECATED
    CMSG_USE_SKILL_CHEAT                            = 0x029, // DEPRECATED
    CMSG_FLAG_QUEST                                 = 0x02A, // DEPRECATED
    CMSG_FLAG_QUEST_FINISH                          = 0x02B, // DEPRECATED
    CMSG_CLEAR_QUEST                                = 0x02C, // DEPRECATED
    CMSG_SEND_EVENT                                 = 0x02D, // DEPRECATED
    CMSG_DEBUG_AISTATE                              = 0x02E, // DEPRECATED
    CMSG_DISABLE_PVP_CHEAT                          = 0x030, // DEPRECATED
    CMSG_ADVANCE_SPAWN_TIME                         = 0x031, // DEPRECATED
    CMSG_AUTH_SRP6_BEGIN                            = 0x033, // DEPRECATED
    CMSG_AUTH_SRP6_RECODE                           = 0x035, // DEPRECATED
    CMSG_CHAR_CREATE                                = 0x4A36,
    CMSG_CHAR_ENUM                                  = 0x0502,
    CMSG_CHAR_DELETE                                = 0x6425,
    CMSG_PLAYER_LOGIN                               = 0x05B1,
    CMSG_GAMETIME_SET                               = 0x0000,
    CMSG_GAMESPEED_SET                              = 0x0000,
    CMSG_SERVERTIME                                 = 0x0000,
    CMSG_PLAYER_LOGOUT                              = 0x0000,
    CMSG_LOGOUT_REQUEST                             = 0x0A25,
    CMSG_LOGOUT_CANCEL                              = 0x2324,
    CMSG_NAME_QUERY                                 = 0x2224,
    CMSG_PET_NAME_QUERY                             = 0x6F24,
    CMSG_GUILD_QUERY                                = 0x4426,
    CMSG_ITEM_QUERY_SINGLE                          = 0x056, // DEPRECATED
    CMSG_ITEM_QUERY_MULTIPLE                        = 0x057, // DEPRECATED
    CMSG_PAGE_TEXT_QUERY                            = 0x6614,
    CMSG_QUEST_QUERY                                = 0x05C, // DEPRECATED
    CMSG_GAMEOBJECT_QUERY                           = 0x4017,
    CMSG_CREATURE_QUERY                             = 0x2706,
    CMSG_WHO                                        = 0x6C15,
    CMSG_WHOIS                                      = 0x6B05,
    CMSG_CONTACT_LIST                               = 0x4534,
    CMSG_ADD_FRIEND                                 = 0x6527,
    CMSG_DEL_FRIEND                                 = 0x6A15,
    CMSG_SET_CONTACT_NOTES                          = 0x6135,
    CMSG_ADD_IGNORE                                 = 0x4726,
    CMSG_DEL_IGNORE                                 = 0x6D26, // got here
    CMSG_GROUP_INVITE                               = 0x06E,
    CMSG_GROUP_CANCEL                               = 0x0000,
    CMSG_GROUP_ACCEPT                               = 0x072,
    CMSG_GROUP_DECLINE                              = 0x073,
    CMSG_GROUP_UNINVITE                             = 0x0000,
    CMSG_GROUP_UNINVITE_GUID                        = 0x2E07,
    CMSG_GROUP_SET_LEADER                           = 0x4C17,
    CMSG_LOOT_METHOD                                = 0x2F24,
    CMSG_GROUP_DISBAND                              = 0x2804,
    UMSG_UPDATE_GROUP_MEMBERS                       = 0x080,
    CMSG_GUILD_CREATE                               = 0x081,
    CMSG_GUILD_INVITE                               = 0x24B0,
    CMSG_GUILD_ACCEPT                               = 0x2531,
    CMSG_GUILD_DECLINE                              = 0x3231,
    CMSG_GUILD_INFO                                 = 0x0000,
    CMSG_GUILD_ROSTER                               = 0x089,
    CMSG_GUILD_PROMOTE                              = 0x1030,
    CMSG_GUILD_DEMOTE                               = 0x1020,
    CMSG_GUILD_LEAVE                                = 0x1021,
    CMSG_GUILD_REMOVE                               = 0x1231,
    CMSG_GUILD_DISBAND                              = 0x3226,
    CMSG_GUILD_LEADER                               = 0x090,
    CMSG_GUILD_MOTD                                 = 0x1035,
    UMSG_UPDATE_GUILD                               = 0x094,
    CMSG_MESSAGECHAT                                = 0x095,
    CMSG_JOIN_CHANNEL                               = 0x156,
    CMSG_LEAVE_CHANNEL                              = 0x2D56,
    CMSG_CHANNEL_LIST                               = 0x09A,
    CMSG_CHANNEL_PASSWORD                           = 0x09C,
    CMSG_CHANNEL_SET_OWNER                          = 0x09D,
    CMSG_CHANNEL_OWNER                              = 0x09E,
    CMSG_CHANNEL_MODERATOR                          = 0x09F,
    CMSG_CHANNEL_UNMODERATOR                        = 0x0A0,
    CMSG_CHANNEL_MUTE                               = 0x0A1,
    CMSG_CHANNEL_UNMUTE                             = 0x0A2,
    CMSG_CHANNEL_INVITE                             = 0x0A3,
    CMSG_CHANNEL_KICK                               = 0x0A4,
    CMSG_CHANNEL_BAN                                = 0x0A5,
    CMSG_CHANNEL_UNBAN                              = 0x0A6,
    CMSG_CHANNEL_ANNOUNCEMENTS                      = 0x0A7,
    CMSG_CHANNEL_MODERATE                           = 0x0A8,
    CMSG_USE_ITEM                                   = 0x2C06,
    CMSG_OPEN_ITEM                                  = 0x6A34,
    CMSG_READ_ITEM                                  = 0x2F16,
    CMSG_GAMEOBJ_USE                                = 0x4E17,
    CMSG_DESTROY_ITEMS                              = 0x0B2,
    CMSG_AREATRIGGER                                = 0x0937,
    MSG_MOVE_START_FORWARD                          = 0x7814,
    MSG_MOVE_START_BACKWARD                         = 0x330A,
    MSG_MOVE_STOP                                   = 0x320A,
    MSG_MOVE_START_STRAFE_LEFT                      = 0x3A16,
    MSG_MOVE_START_STRAFE_RIGHT                     = 0x3A02,
    MSG_MOVE_STOP_STRAFE                            = 0x3002,
    MSG_MOVE_JUMP                                   = 0x7A06,
    MSG_MOVE_START_TURN_LEFT                        = 0x700C,
    MSG_MOVE_START_TURN_RIGHT                       = 0x7000,
    MSG_MOVE_STOP_TURN                              = 0x331E,
    MSG_MOVE_START_PITCH_UP                         = 0x3304,
    MSG_MOVE_START_PITCH_DOWN                       = 0x3908,
    MSG_MOVE_STOP_PITCH                             = 0x7216,
    MSG_MOVE_SET_RUN_MODE                           = 0x791A,
    MSG_MOVE_SET_WALK_MODE                          = 0x7002,
    MSG_MOVE_TOGGLE_LOGGING                         = 0x0000,
    MSG_MOVE_TELEPORT                               = 0x55A0,
    MSG_MOVE_TELEPORT_CHEAT                         = 0x3A10,
    MSG_MOVE_TELEPORT_ACK                           = 0x390C,
    MSG_MOVE_TOGGLE_FALL_LOGGING                    = 0x0000,
    MSG_MOVE_FALL_LAND                              = 0x380A,
    MSG_MOVE_START_SWIM                             = 0x3206,
    MSG_MOVE_STOP_SWIM                              = 0x3802,
    MSG_MOVE_SET_RUN_SPEED_CHEAT                    = 0x0000,
    MSG_MOVE_SET_RUN_BACK_SPEED_CHEAT               = 0x0000,
    MSG_MOVE_SET_RUN_BACK_SPEED                     = 0x0CF,
    MSG_MOVE_SET_WALK_SPEED_CHEAT                   = 0x0000,
    MSG_MOVE_SET_WALK_SPEED                         = 0x0D1,
    MSG_MOVE_SET_SWIM_SPEED_CHEAT                   = 0x0000,
    MSG_MOVE_SET_SWIM_SPEED                         = 0x0D3,
    MSG_MOVE_SET_SWIM_BACK_SPEED_CHEAT              = 0x0000,
    MSG_MOVE_SET_SWIM_BACK_SPEED                    = 0x0D5,
    MSG_MOVE_SET_ALL_SPEED_CHEAT                    = 0x0000,
    MSG_MOVE_SET_TURN_RATE_CHEAT                    = 0x0000,
    MSG_MOVE_SET_TURN_RATE                          = 0x0D8,
    MSG_MOVE_TOGGLE_COLLISION_CHEAT                 = 0x7B04,
    MSG_MOVE_SET_FACING                             = 0x7914,
    MSG_MOVE_SET_PITCH                              = 0x7312,
    MSG_MOVE_WORLDPORT_ACK                          = 0x2411,
    CMSG_MOVE_CHARM_PORT_CHEAT                      = 0x0E0,
    CMSG_MOVE_SET_RAW_POSITION                      = 0x0E1,
    CMSG_MOVE_FORCE_RUN_SPEED_CHANGE_ACK            = 0x7818,
    CMSG_FORCE_RUN_BACK_SPEED_CHANGE_ACK            = 0x0E5,
    CMSG_FORCE_SWIM_SPEED_CHANGE_ACK                = 0x0E7,
    CMSG_FORCE_MOVE_ROOT_ACK                        = 0x701E,
    CMSG_FORCE_MOVE_UNROOT_ACK                      = 0x7808,
    MSG_MOVE_ROOT                                   = 0x0EC,
    MSG_MOVE_UNROOT                                 = 0x0ED,
    MSG_MOVE_HEARTBEAT                              = 0x3914,
    CMSG_MOVE_KNOCK_BACK_ACK                        = 0x721C,
    MSG_MOVE_KNOCK_BACK                             = 0x0F1,
    CMSG_MOVE_HOVER_ACK                             = 0x3318,
    CMSG_TRIGGER_CINEMATIC_CHEAT                    = 0x0000,
    CMSG_OPENING_CINEMATIC                          = 0x0A16,
    CMSG_NEXT_CINEMATIC_CAMERA                      = 0x2014,
    CMSG_COMPLETE_CINEMATIC                         = 0x2116,
    CMSG_TUTORIAL_FLAG                              = 0x6C26,
    CMSG_TUTORIAL_CLEAR                             = 0x6515,
    CMSG_TUTORIAL_RESET                             = 0x2726,
    CMSG_STANDSTATECHANGE                           = 0x0535,
    CMSG_EMOTE                                      = 0x4C26,
    CMSG_TEXT_EMOTE                                 = 0x104,
    CMSG_AUTOEQUIP_GROUND_ITEM                      = 0x0000,
    CMSG_AUTOSTORE_GROUND_ITEM                      = 0x0000,
    CMSG_AUTOSTORE_LOOT_ITEM                        = 0x0E34,
    CMSG_STORE_LOOT_IN_SLOT                         = 0x0000,
    CMSG_AUTOEQUIP_ITEM                             = 0x4304,
    CMSG_AUTOSTORE_BAG_ITEM                         = 0x0236,
    CMSG_SWAP_ITEM                                  = 0x6326,
    CMSG_SWAP_INV_ITEM                              = 0x2614,
    CMSG_SPLIT_ITEM                                 = 0xF17,
    CMSG_AUTOEQUIP_ITEM_SLOT                        = 0x4A17,
    CMSG_UNCLAIM_LICENSE                            = 0x110,
    CMSG_DESTROYITEM                                = 0x111,
    CMSG_INSPECT                                    = 0x0927,
    CMSG_INITIATE_TRADE                             = 0x7916,
    CMSG_BEGIN_TRADE                                = 0x721E,
    CMSG_BUSY_TRADE                                 = 0x331C,
    CMSG_IGNORE_TRADE                               = 0x7112,
    CMSG_ACCEPT_TRADE                               = 0x7110,
    CMSG_UNACCEPT_TRADE                             = 0x391A,
    CMSG_CANCEL_TRADE                               = 0x731E,
    CMSG_SET_TRADE_ITEM                             = 0x7B0C,
    CMSG_CLEAR_TRADE_ITEM                           = 0x7018,
    CMSG_SET_TRADE_GOLD                             = 0x3008,
    CMSG_SET_FACTION_ATWAR                          = 0x0706,
    CMSG_SET_FACTION_CHEAT                          = 0x0000,
    CMSG_SET_ACTION_BUTTON                          = 0x6F06,
    CMSG_NEW_SPELL_SLOT                             = 0x0000,
    CMSG_CAST_SPELL                                 = 0x4C07,
    CMSG_CANCEL_CAST                                = 0x115,
    CMSG_CANCEL_AURA                                = 0xE26,
    MSG_CHANNEL_START                               = 0x0A15,
    MSG_CHANNEL_UPDATE                              = 0x2417,
    CMSG_CANCEL_CHANNELLING                         = 0x6C25,
    CMSG_SET_SELECTION                              = 0x506,
    CMSG_DELETEEQUIPMENT_SET                        = 0x13E,
    CMSG_INSTANCE_LOCK_RESPONSE                     = 0x13F,
    CMSG_DEBUG_PASSIVE_AURA                         = 0x140,
    CMSG_ATTACKSWING                                = 0x141,
    CMSG_ATTACKSTOP                                 = 0x142,
    CMSG_PERFORM_ACTION_SET                         = 0x14C,
    CMSG_SAVE_PLAYER                                = 0x0000,
    CMSG_SETDEATHBINDPOINT                          = 0x0000,
    CMSG_GETDEATHBINDZONE                           = 0x0000,
    CMSG_REPOP_REQUEST                              = 0x6235,
    CMSG_RESURRECT_RESPONSE                         = 0x6827,
    CMSG_LOOT                                       = 0x0127,
    CMSG_LOOT_MONEY                                 = 0x6227,
    CMSG_LOOT_RELEASE                               = 0x2007,
    CMSG_DUEL_ACCEPTED                              = 0x2136,
    CMSG_DUEL_CANCELLED                             = 0x6624,
    CMSG_MOUNTSPECIAL_ANIM                          = 0x2807,
    CMSG_PET_SET_ACTION                             = 0x6904,
    CMSG_PET_ACTION                                 = 0x0226,
    CMSG_PET_ABANDON                                = 0x0C24,
    CMSG_PET_RENAME                                 = 0x6406,
    CMSG_GOSSIP_HELLO                               = 0x4525,
    CMSG_GOSSIP_SELECT_OPTION                       = 0x0216,
    CMSG_NPC_TEXT_QUERY                             = 0x4E24,
    CMSG_QUESTGIVER_STATUS_QUERY                    = 0x182,
    CMSG_QUESTGIVER_HELLO                           = 0x184,
    CMSG_QUESTGIVER_QUERY_QUEST                     = 0x186,
    CMSG_QUESTGIVER_QUEST_AUTOLAUNCH                = 0x187,
    CMSG_QUESTGIVER_ACCEPT_QUEST                    = 0x189,
    CMSG_QUESTGIVER_COMPLETE_QUEST                  = 0x18A,
    CMSG_QUESTGIVER_REQUEST_REWARD                  = 0x18C,
    CMSG_QUESTGIVER_CHOOSE_REWARD                   = 0x18E,
    CMSG_QUESTGIVER_CANCEL                          = 0x190,
    CMSG_QUESTLOG_SWAP_QUEST                        = 0x193,
    CMSG_QUESTLOG_REMOVE_QUEST                      = 0x194,
    CMSG_QUEST_CONFIRM_ACCEPT                       = 0x0D15,
    CMSG_PUSHQUESTTOPARTY                           = 0x4B14,
    CMSG_LIST_INVENTORY                             = 0x2806,
    CMSG_SELL_ITEM                                  = 0x4E15,
    CMSG_BUY_ITEM                                   = 0x0736,
    CMSG_BUY_ITEM_IN_SLOT                           = 0x1A3,
    CMSG_TAXICLEARALLNODES                          = 0x0000,
    CMSG_TAXIENABLEALLNODES                         = 0x0000,
    CMSG_TAXISHOWNODES                              = 0x0000,
    CMSG_TAXINODE_STATUS_QUERY                      = 0x2F25,
    CMSG_TAXIQUERYAVAILABLENODES                    = 0x6C06,
    CMSG_ACTIVATETAXI                               = 0x6E06,
    CMSG_TRAINER_LIST                               = 0x2336,
    CMSG_TRAINER_BUY_SPELL                          = 0x4415,
    CMSG_BINDER_ACTIVATE                            = 0x4006,
    CMSG_BANKER_ACTIVATE                            = 0x0005,
    CMSG_BUY_BANK_SLOT                              = 0x0425,
    CMSG_PETITION_SHOWLIST                          = 0x4617,
    CMSG_PETITION_BUY                               = 0x4E05,
    CMSG_PETITION_SHOW_SIGNATURES                   = 0x4F15,
    CMSG_PETITION_SIGN                              = 0x0E04,
    MSG_PETITION_DECLINE                            = 0x4905,
    CMSG_OFFER_PETITION                             = 0x4817,
    CMSG_TURN_IN_PETITION                           = 0x0B27,
    CMSG_PETITION_QUERY                             = 0x4424,
    CMSG_BUG                                        = 0x4035,
    CMSG_PLAYED_TIME                                = 0x804,
    CMSG_QUERY_TIME                                 = 0xA36,
    CMSG_RECLAIM_CORPSE                             = 0x4036,
    CMSG_WRAP_ITEM                                  = 0x4F06,
    MSG_MINIMAP_PING                                = 0x6635,
    CMSG_SET_SKILL_CHEAT                            = 0x0000,
    CMSG_PING                                       = 0x444D,
    CMSG_SET_SHEATHED                               = 0x4326,
    CMSG_QUEST_POI_QUERY                            = 0x4037,
    CMSG_GHOST                                      = 0x0000,
    CMSG_GM_INVIS                                   = 0x0000,
    MSG_GM_BIND_OTHER                               = 0x0000,
    MSG_GM_SUMMON                                   = 0x0000,
    CMSG_AUTH_SESSION                               = 0x0449,
    MSG_GM_SHOWLABEL                                = 0x0000,
    CMSG_PET_CAST_SPELL                             = 0x6337,
    MSG_SAVE_GUILD_EMBLEM                           = 0x2404,
    MSG_TABARDVENDOR_ACTIVATE                       = 0x6926,
    CMSG_ZONEUPDATE                                 = 0x4F37,
    CMSG_GM_SET_SECURITY_GROUP                      = 0x0000,
    CMSG_GM_NUKE                                    = 0x0000,
    MSG_RANDOM_ROLL                                 = 0x0905,
    CMSG_CHANGEPLAYER_DIFFICULTY                    = 0x6107,
    CMSG_UNLEARN_SPELL                              = 0x201,
    CMSG_UNLEARN_SKILL                              = 0x6106,
    CMSG_GMTICKET_CREATE                            = 0x0137,
    CMSG_GMTICKET_UPDATETEXT                        = 0x0636,
    CMSG_REQUEST_ACCOUNT_DATA                       = 0x6505,
    CMSG_UPDATE_ACCOUNT_DATA                        = 0x4736,
    CMSG_GM_TEACH                                   = 0x20F,
    CMSG_GM_CREATE_ITEM_TARGET                      = 0x210,
    CMSG_GMTICKET_GETTICKET                         = 0x326,
    CMSG_UNLEARN_TALENTS                            = 0x213,
    MSG_CORPSE_QUERY                                = 0x4336,
    CMSG_GMTICKET_DELETETICKET                      = 0x6B14,
    CMSG_GMTICKET_SYSTEMSTATUS                      = 0x4205,
    CMSG_SPIRIT_HEALER_ACTIVATE                     = 0x2E26,
    CMSG_SET_STAT_CHEAT                             = 0x21D,
    CMSG_SKILL_BUY_STEP                             = 0x21F,
    CMSG_SKILL_BUY_RANK                             = 0x220,
    CMSG_XP_CHEAT                                   = 0x221,
    CMSG_CHARACTER_POINT_CHEAT                      = 0x223,
    CMSG_CHAT_IGNORED                               = 0x0D54,
    CMSG_GM_SILENCE                                 = 0x228,
    CMSG_GM_REVEALTO                                = 0x229,
    CMSG_GM_RESURRECT                               = 0x22A,
    CMSG_GM_SUMMONMOB                               = 0x22B,
    CMSG_GM_MOVECORPSE                              = 0x22C,
    CMSG_GM_FREEZE                                  = 0x22D,
    CMSG_GM_UBERINVIS                               = 0x22E,
    CMSG_GM_REQUEST_PLAYER_INFO                     = 0x22F,
    CMSG_GUILD_RANK                                 = 0x231,
    CMSG_GUILD_ADD_RANK                             = 0x3030,
    CMSG_GUILD_DEL_RANK                             = 0x3234,
    CMSG_GUILD_SET_NOTE                      = 0x1233,
    CMSG_GUILD_SET_OFFICER_NOTE                     = 0x235,
    CMSG_SEND_MAIL                                  = 0x0523,
    CMSG_GET_MAIL_LIST                              = 0x4D37,
    CMSG_BATTLEFIELD_LIST                           = 0x3814,
    CMSG_BATTLEFIELD_JOIN                           = 0x0000,
    CMSG_SET_VEHICLE_REC_ID_ACK                     = 0x3108,
    CMSG_TAXICLEARNODE                              = 0x241,
    CMSG_TAXIENABLENODE                             = 0x242,
    CMSG_ITEM_TEXT_QUERY                            = 0x2406,
    CMSG_MAIL_TAKE_MONEY                            = 0x4034,
    CMSG_MAIL_TAKE_ITEM                             = 0x2B06,
    CMSG_MAIL_MARK_AS_READ                          = 0x0C07,
    CMSG_MAIL_RETURN_TO_SENDER                      = 0x0816,
    CMSG_MAIL_DELETE                                = 0x6104,
    CMSG_MAIL_CREATE_TEXT_ITEM                      = 0x0B14,
    CMSG_LEARN_TALENT                               = 0x0306,
    CMSG_TOGGLE_PVP                                 = 0x6815,
    MSG_AUCTION_HELLO                               = 0x2307,
    CMSG_AUCTION_SELL_ITEM                          = 0x4A06,
    CMSG_AUCTION_REMOVE_ITEM                        = 0x6426,
    CMSG_AUCTION_LIST_ITEMS                         = 0x0324,
    CMSG_AUCTION_LIST_OWNER_ITEMS                   = 0x0206,
    CMSG_AUCTION_PLACE_BID                          = 0x2306,
    CMSG_AUCTION_LIST_BIDDER_ITEMS                  = 0x6937,
    CMSG_SET_AMMO                                   = 0x268,
    CMSG_SET_ACTIVE_MOVER                           = 0x3314,
    // Opcodes the real build 15595 client sends that this fork did not define at all
    // (values from cata-js's proven-working table). Without these the server logs them
    // as UNKNOWN and cannot even see what the client is reporting -- notably
    // CMSG_OBJECT_UPDATE_FAILED, which is the client telling us it could not build an
    // object from an SMSG_UPDATE_OBJECT block. See issue #40.
    CMSG_OBJECT_UPDATE_FAILED                       = 0x3808,
    CMSG_QUERY_BATTLEFIELD_STATE                    = 0x7202,
    CMSG_QUEST_GIVER_STATUS_QUERY              = 0x4407,
    CMSG_REQUEST_CEMETERY_LIST                      = 0x720A,
    CMSG_UNREGISTER_ALL_ADDON_PREFIXES              = 0x3D54,
    CMSG_DB_QUERY_BULK                              = 0x2401,
    CMSG_SAVE_CUF_PROFILES                          = 0x730E,
    CMSG_REQUEST_CATEGORY_COOLDOWNS                 = 0x7102,
    CMSG_LFG_LOCK_INFO_REQUEST                      = 0x0412,
    CMSG_PET_CANCEL_AURA                            = 0x4B25,
    CMSG_PLAYER_AI_CHEAT                            = 0x26C,
    CMSG_CANCEL_AUTO_REPEAT_SPELL                   = 0x6C35,
    MSG_GM_ACCOUNT_ONLINE                           = 0x26E,
    MSG_LIST_STABLED_PETS                           = 0x0834,
    CMSG_STABLE_PET                                 = 0x270,
    CMSG_UNSTABLE_PET                               = 0x271,
    CMSG_BUY_STABLE_SLOT                            = 0x272,
    CMSG_STABLE_REVIVE_PET                          = 0x274,
    CMSG_STABLE_SWAP_PET                            = 0x275,
    MSG_QUEST_PUSH_RESULT                           = 0x4515,
    CMSG_REQUEST_PET_INFO                           = 0x4924,
    CMSG_FAR_SIGHT                                  = 0x4835,
    CMSG_ENABLE_DAMAGE_LOG                          = 0x27D,
    CMSG_GROUP_CHANGE_SUB_GROUP                     = 0x4124,
    CMSG_REQUEST_PARTY_MEMBER_STATS                 = 0x0C04,
    CMSG_GROUP_SWAP_SUB_GROUP                       = 0x0034,
    CMSG_RESET_FACTION_CHEAT                        = 0x4469,
    CMSG_AUTOSTORE_BANK_ITEM                        = 0x0607,
    CMSG_AUTOBANK_ITEM                              = 0x2537,
    MSG_QUERY_NEXT_MAIL_TIME                        = 0x0F04,
    CMSG_SET_DURABILITY_CHEAT                       = 0x287,
    CMSG_SET_PVP_RANK_CHEAT                         = 0x288,
    CMSG_ADD_PVP_MEDAL_CHEAT                        = 0x289,
    CMSG_DEL_PVP_MEDAL_CHEAT                        = 0x28A,
    CMSG_SET_PVP_TITLE                              = 0x28B,
    CMSG_GROUP_RAID_CONVERT                         = 0x6E27,
    CMSG_GROUP_ASSISTANT_LEADER                     = 0x6025,
    CMSG_BUYBACK_ITEM                               = 0x6C17,
    CMSG_SET_SAVED_INSTANCE_EXTEND                  = 0x6706,
    CMSG_TEST_DROP_RATE                             = 0x294,
    CMSG_LFG_GET_STATUS                             = 0x2581,
    CMSG_CANCEL_GROWTH_AURA                         = 0x0237,
    CMSG_LOOT_ROLL                                  = 0x6934,
    CMSG_LOOT_MASTER_GIVE                           = 0x4F35,
    CMSG_REPAIR_ITEM                                = 0x2917,
    MSG_TALENT_WIPE_CONFIRM                         = 0x0107,
    CMSG_SUMMON_RESPONSE                            = 0x6F27,
    MSG_DEV_SHOWLABEL                               = 0x2AD,
    MSG_MOVE_FEATHER_FALL                           = 0x2B0,
    MSG_MOVE_WATER_WALK                             = 0x2B1,
    CMSG_SERVER_BROADCAST                           = 0x2B2,
    CMSG_SELF_RES                                   = 0x6115,
    CMSG_RUN_SCRIPT                                 = 0x2B5,
    CMSG_SHOWING_HELM                               = 0x0735,
    CMSG_SHOWING_CLOAK                              = 0x4135,
    CMSG_SET_EXPLORATION                            = 0x2BE,
    CMSG_SET_ACTIONBAR_TOGGLES                      = 0x2506,
    UMSG_DELETE_GUILD_CHARTER                       = 0x2C0,
    MSG_PETITION_RENAME                             = 0x4005,
    CMSG_ITEM_NAME_QUERY                            = 0x2C4,
    CMSG_CHAR_RENAME                                = 0x2327,
    CMSG_MOVE_SPLINE_DONE                           = 0x790E,
    CMSG_MOVE_FALL_RESET                            = 0x310A,
    CMSG_REQUEST_RAID_INFO                          = 0x2F26,
    CMSG_MOVE_TIME_SKIPPED                          = 0x7A0A,
    CMSG_MOVE_FEATHER_FALL_ACK                      = 0x3110,
    CMSG_MOVE_WATER_WALK_ACK                        = 0x3B00,
    CMSG_MOVE_NOT_ACTIVE_MOVER                      = 0x7A1A,
    CMSG_BATTLEFIELD_STATUS                         = 0x2500,
    CMSG_BATTLEFIELD_PORT                           = 0x711A,
    MSG_INSPECT_HONOR_STATS                         = 0x2D6,
    CMSG_BATTLEMASTER_HELLO                         = 0x0234,
    CMSG_MOVE_START_SWIM_CHEAT                      = 0x2D8,
    CMSG_MOVE_STOP_SWIM_CHEAT                       = 0x2D9,
    CMSG_FORCE_WALK_SPEED_CHANGE_ACK                = 0x2DB,
    CMSG_FORCE_SWIM_BACK_SPEED_CHANGE_ACK           = 0x2DD,
    CMSG_FORCE_TURN_RATE_CHANGE_ACK                 = 0x2DF,
    MSG_PVP_LOG_DATA                                = 0x0000,
    CMSG_LEAVE_BATTLEFIELD                          = 0x2E1,
    CMSG_AREA_SPIRIT_HEALER_QUERY                   = 0x4907,
    CMSG_AREA_SPIRIT_HEALER_QUEUE                   = 0x4815,
    CMSG_GM_UNTEACH                                 = 0x2E5,
    CMSG_WARDEN_DATA                                = 0x25A2,
    MSG_BATTLEGROUND_PLAYER_POSITIONS               = 0x2E9,
    CMSG_PET_STOP_ATTACK                            = 0x6C14,
    CMSG_BATTLEMASTER_JOIN                          = 0x7902,
    CMSG_PET_UNLEARN                                = 0x2F0,    // Deprecated 3.x
    CMSG_PET_SPELL_AUTOCAST                         = 0x2514,
    CMSG_MINIGAME_MOVE                              = 0x2A34,
    CMSG_GUILD_INFO_TEXT                            = 0x3227,
    CMSG_GM_NUKE_ACCOUNT                            = 0x30F,
    MSG_GM_DESTROY_CORPSE                           = 0x310,
    CMSG_GM_DESTROY_ONLINE_CORPSE                   = 0x311,
    CMSG_ACTIVATETAXIEXPRESS                        = 0x0515,
    CMSG_DEBUG_ACTIONS_START                        = 0x315,
    CMSG_DEBUG_ACTIONS_STOP                         = 0x316,
    CMSG_SET_FACTION_INACTIVE                       = 0x0E37,
    CMSG_SET_WATCHED_FACTION                        = 0x2434,
    MSG_MOVE_TIME_SKIPPED                           = 0x19B3,
    CMSG_SET_EXPLORATION_ALL                        = 0x31B,
    CMSG_RESET_INSTANCES                            = 0x6E14,
    MSG_RAID_TARGET_UPDATE                          = 0x2C36,
    MSG_RAID_READY_CHECK                            = 0x2304,
    CMSG_LUA_USAGE                                  = 0x323,
    CMSG_GM_UPDATE_TICKET_STATUS                    = 0x327,
    MSG_SET_DUNGEON_DIFFICULTY                      = 0x4925,
    CMSG_GMSURVEY_SUBMIT                            = 0x2724,
    CMSG_IGNORE_KNOCKBACK_CHEAT                     = 0x32C,
    MSG_DELAY_GHOST_TELEPORT                        = 0x32E,
    CMSG_CHAT_FILTERED                              = 0x0946,
    CMSG_LOTTERY_QUERY_OBSOLETE                     = 0x334,
    CMSG_BUY_LOTTERY_TICKET_OBSOLETE                = 0x336,
    MSG_GM_RESETINSTANCELIMIT                       = 0x33C,
    CMSG_MOVE_SET_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY_ACK = 0x3014,
    MSG_MOVE_START_SWIM_CHEAT                       = 0x341,
    MSG_MOVE_STOP_SWIM_CHEAT                        = 0x342,
    CMSG_MOVE_SET_CAN_FLY_ACK                       = 0x790C,
    CMSG_MOVE_SET_FLY                               = 0x346,
    CMSG_SOCKET_GEMS                                = 0x2F04,
    CMSG_ARENA_TEAM_CREATE                          = 0x04A1,
    MSG_MOVE_UPDATE_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY = 0x34A,
    CMSG_ARENA_TEAM_QUERY                           = 0x0514,
    CMSG_ARENA_TEAM_ROSTER                          = 0x6F37,
    CMSG_ARENA_TEAM_INVITE                          = 0x2F27,
    CMSG_ARENA_TEAM_ACCEPT                          = 0x2A25,
    CMSG_ARENA_TEAM_DECLINE                         = 0x6925,
    CMSG_ARENA_TEAM_LEAVE                           = 0x0E16,
    CMSG_ARENA_TEAM_REMOVE                          = 0x2F05,
    CMSG_ARENA_TEAM_DISBAND                         = 0x6504,
    CMSG_ARENA_TEAM_LEADER                          = 0x4204,
    CMSG_BATTLEMASTER_JOIN_ARENA                    = 0x701C,
    MSG_MOVE_START_ASCEND                           = 0x390A,
    MSG_MOVE_STOP_ASCEND                            = 0x7B00,
    CMSG_LFG_JOIN                                   = 0x2430,
    CMSG_LFG_LEAVE                                  = 0x2433,
    CMSG_SEARCH_LFG_JOIN                            = 0x0000,
    CMSG_SEARCH_LFG_LEAVE                           = 0x0000,
    CMSG_LFG_PROPOSAL_RESULT                        = 0x0403,
    CMSG_SET_LFG_COMMENT                            = 0x0000,
    CMSG_LFG_SET_ROLES                              = 0x0480,
    CMSG_LFG_SET_NEEDS                              = 0x36B,
    CMSG_LFG_SET_BOOT_VOTE                          = 0x04B3,
    CMSG_LFG_TELEPORT                               = 0x2482,
    CMSG_LFD_PARTY_LOCK_INFO_REQUEST                = 0x371,
    CMSG_SET_TITLE                                  = 0x2117,
    CMSG_CANCEL_MOUNT_AURA                          = 0x0635,
    MSG_INSPECT_ARENA_TEAMS                         = 0x2704,
    CMSG_CANCEL_TEMP_ENCHANTMENT                    = 0x6C37,
    CMSG_CHEAT_SET_HONOR_CURRENCY                   = 0x37B,
    CMSG_CHEAT_SET_ARENA_CURRENCY                   = 0x37C,
    MSG_MOVE_SET_FLIGHT_SPEED_CHEAT                 = 0x0000,
    MSG_MOVE_SET_FLIGHT_SPEED                       = 0x37E,
    MSG_MOVE_SET_FLIGHT_BACK_SPEED_CHEAT            = 0x37F,
    MSG_MOVE_SET_FLIGHT_BACK_SPEED                  = 0x380,
    CMSG_FORCE_FLIGHT_SPEED_CHANGE_ACK              = 0x382,
    CMSG_FORCE_FLIGHT_BACK_SPEED_CHANGE_ACK         = 0x384,
    CMSG_MAELSTROM_INVALIDATE_CACHE                 = 0x387,
    CMSG_SET_TAXI_BENCHMARK_MODE                    = 0x4314,
    CMSG_REALM_SPLIT                                = 0x2906,
    CMSG_MOVE_CHNG_TRANSPORT                        = 0x3102,
    MSG_PARTY_ASSIGNMENT                            = 0x0424,
    CMSG_TIME_SYNC_RESP                             = 0x3B0C,
    CMSG_SEND_LOCAL_EVENT                           = 0x392,
    CMSG_SEND_GENERAL_TRIGGER                       = 0x393,
    CMSG_SEND_COMBAT_TRIGGER                        = 0x394,
    CMSG_MAELSTROM_GM_SENT_MAIL                     = 0x395,
    CMSG_ACTIVE_PVP_CHEAT                           = 0x399,
    CMSG_CHEAT_DUMP_ITEMS_DEBUG_ONLY                = 0x39A,
    CMSG_VOICE_SET_TALKER_MUTED_REQUEST             = 0x3A1,
    MSG_MOVE_START_DESCEND                          = 0x3800,
    CMSG_IGNORE_REQUIREMENTS_CHEAT                  = 0x3A8,
    CMSG_MOVE_SET_RUN_SPEED                         = 0x3AB,
    MSG_MOVE_UPDATE_CAN_FLY                         = 0x3AD,
    MSG_RAID_READY_CHECK_CONFIRM                    = 0x4F05,
    CMSG_VOICE_SESSION_ENABLE                       = 0x2314,
    CMSG_GM_WHISPER                                 = 0x3B2,
    MSG_GM_GEARRATING                               = 0x3B4,
    CMSG_COMMENTATOR_ENABLE                         = 0x0B07,
    CMSG_COMMENTATOR_GET_MAP_INFO                   = 0x0026,
    CMSG_COMMENTATOR_GET_PLAYER_INFO                = 0x0D14,
    CMSG_COMMENTATOR_ENTER_INSTANCE                 = 0x4105,
    CMSG_COMMENTATOR_EXIT_INSTANCE                  = 0x6136,
    CMSG_COMMENTATOR_INSTANCE_COMMAND               = 0x0917,
    CMSG_BOT_DETECTED                               = 0x3C0,
    CMSG_CHEAT_PLAYER_LOGIN                         = 0x3C2,
    CMSG_CHEAT_PLAYER_LOOKUP                        = 0x3C3,
    MSG_RAID_READY_CHECK_FINISHED                   = 0x2E15,
    CMSG_COMPLAIN                                   = 0x3C7,
    CMSG_GM_SHOW_COMPLAINTS                         = 0x3CA,
    CMSG_GM_UNSQUELCH                               = 0x3CB,
    CMSG_CHANNEL_SILENCE_VOICE                      = 0x3CC,
    CMSG_CHANNEL_SILENCE_ALL                        = 0x3CD,
    CMSG_CHANNEL_UNSILENCE_VOICE                    = 0x3CE,
    CMSG_CHANNEL_UNSILENCE_ALL                      = 0x3CF,
    CMSG_TARGET_CAST                                = 0x3D0,
    CMSG_TARGET_SCRIPT_CAST                         = 0x3D1,
    CMSG_CHANNEL_DISPLAY_LIST                       = 0x3D2,
    CMSG_SET_ACTIVE_VOICE_CHANNEL                   = 0x4305,
    CMSG_GET_CHANNEL_MEMBER_COUNT                   = 0x3D4,
    CMSG_CHANNEL_VOICE_ON                           = 0x3D6,
    CMSG_CHANNEL_VOICE_OFF                          = 0x3D7,
    CMSG_DEBUG_LIST_TARGETS                         = 0x3D8,
    CMSG_ADD_VOICE_IGNORE                           = 0x0F06,
    CMSG_DEL_VOICE_IGNORE                           = 0x0024,
    CMSG_PARTY_SILENCE                              = 0x6B26,
    CMSG_PARTY_UNSILENCE                            = 0x4D24,
    MSG_NOTIFY_PARTY_SQUELCH                        = 0x4D06,
    CMSG_REPORT_PVP_AFK                             = 0x6734,
    CMSG_GUILD_BANKER_ACTIVATE                      = 0x3E6,
    CMSG_GUILD_BANK_QUERY_TAB                       = 0x2E35,
    CMSG_GUILD_BANK_SWAP_ITEMS                      = 0x2315,
    CMSG_GUILD_BANK_BUY_TAB                         = 0x0C37,
    CMSG_GUILD_BANK_UPDATE_TAB                      = 0x0106,
    CMSG_GUILD_BANK_DEPOSIT_MONEY                   = 0x0707,
    CMSG_GUILD_BANK_WITHDRAW_MONEY                  = 0x0037,
    MSG_GUILD_BANK_LOG_QUERY                        = 0x3EE,
    CMSG_SET_CHANNEL_WATCH                          = 0x4517,
    CMSG_CLEAR_CHANNEL_WATCH                        = 0x2604,
    CMSG_SET_TITLE_SUFFIX                           = 0x3F7,
    CMSG_SPELLCLICK                                 = 0x0805,
    CMSG_GM_CHARACTER_RESTORE                       = 0x3FA,
    CMSG_GM_CHARACTER_SAVE                          = 0x3FB,
    MSG_GUILD_PERMISSIONS                           = 0x3FD,
    CMSG_GUILD_BANK_REMAINING_WITHDRAW_MONEY_QUERY   = 0x1225,
    CMSG_GUILD_SET_ACHIEVEMENT_TRACKING              = 0x1027,
    MSG_GUILD_EVENT_LOG_QUERY                       = 0x3FF,
    CMSG_MAELSTROM_RENAME_GUILD                     = 0x400,
    CMSG_GET_MIRRORIMAGE_DATA                       = 0x0C25,
    CMSG_IGNORE_DIMINISHING_RETURNS_CHEAT           = 0x405,
    CMSG_KEEP_ALIVE                                 = 0x0015,
    CMSG_OPT_OUT_OF_LOOT                            = 0x6B16,
    MSG_QUERY_GUILD_BANK_TEXT                       = 0x40A,
    CMSG_SET_GUILD_BANK_TEXT                        = 0x40B,
    CMSG_SET_GRANTABLE_LEVELS                       = 0x40C,
    CMSG_GRANT_LEVEL                                = 0x6D16,
    CMSG_REFER_A_FRIEND                             = 0x40E,
    MSG_GM_CHANGE_ARENA_RATING                      = 0x40F,
    CMSG_DECLINE_CHANNEL_INVITE                     = 0x0000,
    CMSG_TOTEM_DESTROYED                            = 0x4207,
    CMSG_EXPIRE_RAID_INSTANCE                       = 0x415,
    CMSG_NO_SPELL_VARIANCE                          = 0x416,
    CMSG_QUESTGIVER_STATUS_MULTIPLE_QUERY           = 0x6305,
    CMSG_SET_PLAYER_DECLINED_NAMES                  = 0x6316,
    CMSG_QUERY_SERVER_BUCK_DATA                     = 0x41B,
    CMSG_CLEAR_SERVER_BUCK_DATA                     = 0x41C,
    CMSG_ACCEPT_LEVEL_GRANT                         = 0x0205,
    CMSG_ALTER_APPEARANCE                           = 0x0914,
    CMSG_CALENDAR_GET_CALENDAR                      = 0x2814,
    CMSG_CALENDAR_GET_EVENT                         = 0x6416,
    CMSG_CALENDAR_GUILD_FILTER                      = 0x4A16,
    CMSG_CALENDAR_ARENA_TEAM                        = 0x0204,
    CMSG_CALENDAR_ADD_EVENT                         = 0x0726,
    CMSG_CALENDAR_UPDATE_EVENT                      = 0x2114,
    CMSG_CALENDAR_REMOVE_EVENT                      = 0x6636,
    CMSG_CALENDAR_COPY_EVENT                        = 0x0207,
    CMSG_CALENDAR_EVENT_INVITE                      = 0x2435,
    CMSG_CALENDAR_EVENT_RSVP                        = 0x0227,
    CMSG_CALENDAR_EVENT_REMOVE_INVITE               = 0x4337,
    CMSG_CALENDAR_EVENT_STATUS                      = 0x2D24,
    CMSG_CALENDAR_EVENT_MODERATOR_STATUS            = 0x6B35,
    CMSG_CALENDAR_COMPLAIN                          = 0x4C36,
    CMSG_CALENDAR_GET_NUM_PENDING                   = 0x4D05,
    CMSG_PLAY_DANCE                                 = 0x6914,
    CMSG_LOAD_DANCES                                = 0x44D,
    CMSG_STOP_DANCE                                 = 0x2907,
    CMSG_SYNC_DANCE                                 = 0x0036,
    CMSG_DANCE_QUERY                                = 0x4E07,
    CMSG_DELETE_DANCE                               = 0x454,
    CMSG_LEARN_DANCE_MOVE                           = 0x456,
    CMSG_UNLEARN_DANCE_MOVE                         = 0x457,
    CMSG_SET_RUNE_COUNT                             = 0x458,
    CMSG_SET_RUNE_COOLDOWN                          = 0x459,
    MSG_MOVE_SET_PITCH_RATE_CHEAT                   = 0x45A,
    MSG_MOVE_SET_PITCH_RATE                         = 0x45B,
    CMSG_FORCE_PITCH_RATE_CHANGE_ACK                = 0x45D,
    CMSG_CALENDAR_EVENT_INVITE_NOTES                = 0x45F,
    CMSG_UPDATE_MISSILE_TRAJECTORY                  = 0x781E,
    CMSG_COMPLETE_MOVIE                             = 0x4136,
    CMSG_SET_GLYPH_SLOT                             = 0x466,
    CMSG_SET_GLYPH                                  = 0x467,
    CMSG_QUERY_INSPECT_ACHIEVEMENTS                 = 0x4D27,
    CMSG_DISMISS_CONTROLLED_VEHICLE                 = 0x3218,
    CMSG_COMPLETE_ACHIEVEMENT_CHEAT                 = 0x46E,
    CMSG_SET_CRITERIA_CHEAT                         = 0x470,
    CMSG_UNITANIMTIER_CHEAT                         = 0x472,
    CMSG_CHAR_CUSTOMIZE                             = 0x2C34,
    CMSG_REQUEST_VEHICLE_EXIT                       = 0x2B35,
    CMSG_REQUEST_VEHICLE_PREV_SEAT                  = 0x4C04,
    CMSG_REQUEST_VEHICLE_NEXT_SEAT                  = 0x4434,
    CMSG_REQUEST_VEHICLE_SWITCH_SEAT                = 0x4C14,
    CMSG_PET_LEARN_TALENT                           = 0x6725,
    CMSG_PET_UNLEARN_TALENTS                        = 0x47B,
    CMSG_FORCE_SAY_CHEAT                            = 0x47E,
    CMSG_GAMEOBJ_REPORT_USE                         = 0x4827,
    CMSG_START_QUEST                                = 0x0000,
    CMSG_REMOVE_GLYPH                               = 0x48A,
    CMSG_DUMP_OBJECTS                               = 0x48B,
    CMSG_DISMISS_CRITTER                            = 0x4227,
    CMSG_AUCTION_LIST_PENDING_SALES                 = 0x2C17,
    CMSG_ENABLETAXI                                 = 0x0C16,
    CMSG_FLOOD_GRACE_CHEAT                          = 0x497,
    CMSG_CHANGE_SEATS_ON_CONTROLLED_VEHICLE         = 0x7310,
    CMSG_HEARTH_AND_RESURRECT                       = 0x4B34,
    CMSG_SERVER_INFO_QUERY                          = 0x4A0,
    CMSG_CHECK_LOGIN_CRITERIA                       = 0x4A2,
    CMSG_SET_BREATH                                 = 0x4A4,
    CMSG_QUERY_VEHICLE_STATUS                       = 0x4A5,
    CMSG_PLAYER_VEHICLE_ENTER                       = 0x2705, // uint64
    CMSG_CONTROLLER_EJECT_PASSENGER                 = 0x4A9, // uint64
    CMSG_CHANGE_GDF_ARENA_RATING                    = 0x4AC,
    CMSG_SET_ARENA_TEAM_RATING_BY_INDEX             = 0x4AD,
    CMSG_SET_ARENA_TEAM_WEEKLY_GAMES                = 0x4AE,
    CMSG_SET_ARENA_TEAM_SEASON_GAMES                = 0x4AF,
    CMSG_SET_ARENA_MEMBER_WEEKLY_GAMES              = 0x4B0,
    CMSG_SET_ARENA_MEMBER_SEASON_GAMES              = 0x4B1,
    CMSG_ITEM_REFUND_INFO                           = 0x2206,
    CMSG_ITEM_REFUND                                = 0x6134, // lua: ContainerRefundItemPurchase
    CMSG_CORPSE_MAP_POSITION_QUERY                  = 0x6205, // uint32
    CMSG_UNUSED5                                    = 0x4B8,
    CMSG_UNUSED6                                    = 0x4B9,
    CMSG_CALENDAR_EVENT_SIGNUP                      = 0x6606, // uint64
    CMSG_EQUIPMENT_SET_SAVE                         = 0x4F27,
    CMSG_UPDATE_PROJECTILE_POSITION                 = 0x0E24,
    CMSG_LEARN_PREVIEW_TALENTS                      = 0x2415,
    CMSG_LEARN_PREVIEW_TALENTS_PET                  = 0x6E24,
    CMSG_SET_ACTIVE_TALENT_GROUP_OBSOLETE           = 0x4C3,
    CMSG_GM_GRANT_ACHIEVEMENT                       = 0x4C4,
    CMSG_GM_REMOVE_ACHIEVEMENT                      = 0x4C5,
    CMSG_GM_SET_CRITERIA_FOR_PLAYER                 = 0x4C6,
    CMSG_PROFILEDATA_REQUEST                        = 0x4C9,
    CMSG_START_BATTLEFIELD_CHEAT                    = 0x4CB,
    CMSG_END_BATTLEFIELD_CHEAT                      = 0x4CC,
    CMSG_MOVE_GRAVITY_DISABLE_ACK                   = 0x3118,
    CMSG_MOVE_GRAVITY_ENABLE_ACK                    = 0x700A,
    CMSG_EQUIPMENT_SET_USE                          = 0x0417,
    CMSG_FORCE_ANIM                                 = 0x4D7,
    CMSG_CHAR_FACTION_CHANGE                        = 0x2735,
    CMSG_PVP_QUEUE_STATS_REQUEST                    = 0x4DB,
    CMSG_SET_PAID_SERVICE_CHEAT                     = 0x4DD,
    CMSG_BATTLEFIELD_MGR_ENTRY_INVITE_RESPONSE      = 0x05A3,
    CMSG_BATTLEFIELD_MGR_QUEUE_INVITE_RESPONSE      = 0x0413,
    CMSG_BATTLEFIELD_MGR_QUEUE_REQUEST              = 0x710C,
    CMSG_BATTLEFIELD_MGR_EXIT_REQUEST               = 0x2490,
    CMSG_BATTLEFIELD_MANAGER_ADVANCE_STATE          = 0x4E9,
    CMSG_BATTLEFIELD_MANAGER_SET_NEXT_TRANSITION_TIME = 0x4EA,
    MSG_SET_RAID_DIFFICULTY                         = 0x0614,
    CMSG_TOGGLE_XP_GAIN                             = 0x4EC,
    CMSG_GMRESPONSE_RESOLVE                         = 0x6506,
    CMSG_GMRESPONSE_CREATE_TICKET                   = 0x4F3,
    CMSG_SERVERINFO                                 = 0x4F4,
    CMSG_WORLD_STATE_UI_TIMER_UPDATE                = 0x4605,
    CMSG_CHAR_RACE_CHANGE                           = 0x0D24,
    MSG_VIEW_PHASE_SHIFT                            = 0x4F9,
    CMSG_DEBUG_SERVER_GEO                           = 0x4FB,
    UMSG_UPDATE_GROUP_INFO                          = 0x4FE,
    CMSG_READY_FOR_ACCOUNT_DATA_TIMES               = 0x2B16,
    CMSG_QUERY_QUESTS_COMPLETED                     = 0x2317,
    CMSG_GM_REPORT_LAG                              = 0x6726,
    CMSG_AFK_MONITOR_INFO_REQUEST                   = 0x503,
    CMSG_AFK_MONITOR_INFO_CLEAR                     = 0x505,
    CMSG_GM_NUKE_CHARACTER                          = 0x507,
    CMSG_SET_ALLOW_LOW_LEVEL_RAID1                  = 0x4435,
    CMSG_SET_ALLOW_LOW_LEVEL_RAID2                  = 0x0536,
    CMSG_SET_CHARACTER_MODEL                        = 0x50C,
    CMSG_REDIRECTION_FAILED                         = 0x50E, // something with networking
    CMSG_SUSPEND_COMMS_ACK                          = 0x510,
    CMSG_REDIRECTION_AUTH_PROOF                     = 0x512,
    CMSG_DROP_NEW_CONNECTION                        = 0x513,
    CMSG_MOVE_SET_COLLISION_HGT_ACK                 = 0x517,
    MSG_MOVE_SET_COLLISION_HGT                      = 0x518,
    CMSG_CLEAR_RANDOM_BG_WIN_TIME                   = 0x519,
    CMSG_CLEAR_HOLIDAY_BG_WIN_TIME                  = 0x51A,
    CMSG_COMMENTATOR_SKIRMISH_QUEUE_COMMAND         = 0x0025,
    TC9_CMSG_PREPARE_FOR_REDIRECT                   = 0x51F,
    CMSG_LOG_DISCONNECT                             = 0x446D,
    CMSG_LOADING_SCREEN_NOTIFY                      = 0x2422,
    CMSG_VIOLENCE_LEVEL                             = 0x7816,
};

enum OpcodeServer : uint16
{
    SMSG_DBLOOKUP                                   = 0x003, // DEPRECATED
    SMSG_QUERY_OBJECT_POSITION                      = 0x005, // DEPRECATED
    SMSG_QUERY_OBJECT_ROTATION                      = 0x007, // DEPRECATED
    SMSG_ZONE_MAP                                   = 0x00B, // DEPRECATED
    SMSG_MOVE_CHARACTER_CHEAT                       = 0x00E, // DEPRECATED
    SMSG_CHECK_FOR_BOTS                             = 0x0000,
    SMSG_FORCEACTIONSHOW                            = 0x6126,
    SMSG_PETGODMODE                                 = 0x2E36,
    SMSG_REFER_A_FRIEND_EXPIRED                     = 0x4934,
    SMSG_GODMODE                                    = 0x0405,
    SMSG_DEBUG_AISTATE                              = 0x02F, // DEPRECATED
    SMSG_DESTRUCTIBLE_BUILDING_DAMAGE               = 0x4825,
    SMSG_AUTH_SRP6_RESPONSE                         = 0x039, // DEPRECATED
    SMSG_CHAR_CREATE                                = 0x2D05,
    SMSG_CHAR_ENUM                                  = 0x10B0,
    SMSG_CHAR_DELETE                                = 0x03C, // DEPRECATED
    SMSG_NEW_WORLD                                  = 0x79B1,
    SMSG_TRANSFER_PENDING                           = 0x18A6,
    SMSG_TRANSFER_ABORTED                           = 0x0537,
    SMSG_CHARACTER_LOGIN_FAILED                     = 0x4417,
    SMSG_LOGIN_SET_TIME_SPEED                       = 0x4D15,
    SMSG_GAMETIME_UPDATE                            = 0x4127,
    SMSG_GAMETIME_SET                               = 0x0014,
    SMSG_GAMESPEED_SET                              = 0x4E34,
    SMSG_SERVERTIME                                 = 0x6327,
    SMSG_LOGOUT_RESPONSE                            = 0x0524,
    SMSG_LOGOUT_COMPLETE                            = 0x2137,
    SMSG_LOGOUT_CANCEL_ACK                          = 0x6514,
    SMSG_NAME_QUERY_RESPONSE                        = 0x6E04, // Cata: SMSG_QUERY_PLAYER_NAME_RESPONSE
    SMSG_PET_NAME_QUERY_RESPONSE                    = 0x4C37,
    SMSG_GUILD_QUERY_RESPONSE                       = 0x055, // DEPRECATED
    SMSG_ITEM_QUERY_SINGLE_RESPONSE                 = 0x058, // DEPRECATED
    SMSG_ITEM_QUERY_MULTIPLE_RESPONSE               = 0x059, // DEPRECATED
    SMSG_PAGE_TEXT_QUERY_RESPONSE                   = 0x2B14,
    SMSG_QUEST_QUERY_RESPONSE                       = 0x6936,
    SMSG_GAMEOBJECT_QUERY_RESPONSE                  = 0x0915,
    SMSG_CREATURE_QUERY_RESPONSE                    = 0x6024,
    SMSG_WHO                                        = 0x6907,
    SMSG_WHOIS                                      = 0x6917,
    SMSG_CONTACT_LIST                               = 0x6017,
    SMSG_FRIEND_STATUS                              = 0x0717,
    SMSG_GROUP_INVITE                               = 0x06F,
    SMSG_GROUP_CANCEL                               = 0x4D25,
    SMSG_GROUP_DECLINE                              = 0x6835,
    SMSG_GROUP_UNINVITE                             = 0x0A07,
    SMSG_GROUP_SET_LEADER                           = 0x0526,
    SMSG_GROUP_DESTROYED                            = 0x2207,
    SMSG_GROUP_LIST                                 = 0x07D,
    SMSG_PARTY_MEMBER_STATS                         = 0x07E,
    SMSG_PARTY_COMMAND_RESULT                       = 0x6E07,
    SMSG_GUILD_INVITE                               = 0x14A2,
    SMSG_GUILD_DECLINE                              = 0x2C07,
    SMSG_GUILD_INFO                                 = 0x088,
    SMSG_GUILD_ROSTER                               = 0x3DA3,
    SMSG_GUILD_EVENT                                = 0x0705,
    SMSG_GUILD_COMMAND_RESULT                       = 0x7DB3,
    SMSG_MESSAGECHAT                                = 0x2026,
    SMSG_CHANNEL_NOTIFY                             = 0x0825,
    SMSG_CHANNEL_LIST                               = 0x2214,
    SMSG_UPDATE_OBJECT                              = 0x4715,
    SMSG_DESTROY_OBJECT                             = 0x4724,
    SMSG_READ_ITEM_OK                               = 0x2605,
    SMSG_READ_ITEM_FAILED                           = 0x0F16,
    SMSG_ITEM_COOLDOWN                              = 0x4D14,
    SMSG_GAMEOBJECT_CUSTOM_ANIM                     = 0x4936,
    SMSG_MONSTER_MOVE                               = 0x6E17,
    SMSG_MOVE_WATER_WALK                            = 0x75B1,
    SMSG_MOVE_LAND_WALK                             = 0x34B7,
    SMSG_MOVE_SET_RUN_SPEED                         = 0x3DB5,
    SMSG_FORCE_RUN_BACK_SPEED_CHANGE                = 0x0E4,
    SMSG_FORCE_SWIM_SPEED_CHANGE                    = 0x0E6,
    SMSG_FORCE_MOVE_ROOT                            = 0x0E8,
    SMSG_FORCE_MOVE_UNROOT                          = 0x0EA,
    SMSG_MOVE_KNOCK_BACK                            = 0x5CB4,
    SMSG_MOVE_FEATHER_FALL                          = 0x79B0,
    SMSG_MOVE_NORMAL_FALL                           = 0x51B6,
    SMSG_MOVE_SET_HOVER                             = 0x5CB3,
    SMSG_MOVE_UNSET_HOVER                           = 0x51B3,
    MSG_MOVE_HOVER                                  = 0x0F7,
    SMSG_TRIGGER_CINEMATIC                          = 0x6C27,
    SMSG_TUTORIAL_FLAGS                             = 0x0B35,
    SMSG_EMOTE                                      = 0x0A34,
    SMSG_TEXT_EMOTE                                 = 0x0B05,
    SMSG_INVENTORY_CHANGE_FAILURE                   = 0x2236,
    SMSG_OPEN_CONTAINER                             = 0x4714,
    SMSG_INSPECT_RESULTS_UPDATE                     = 0x0C14,
    SMSG_TRADE_STATUS                               = 0x5CA3,
    SMSG_TRADE_STATUS_EXTENDED                      = 0x121,
    SMSG_INITIALIZE_FACTIONS                        = 0x4634,
    SMSG_SET_FACTION_VISIBLE                        = 0x2525,
    SMSG_SET_FACTION_STANDING                       = 0x0126,
    SMSG_SET_PROFICIENCY                            = 0x6207,
    SMSG_SETUP_CURRENCY                             = 0x15A5,
    SMSG_UPDATE_ACTION_BUTTONS                      = 0x38B5,
    SMSG_SEND_KNOWN_SPELLS                          = 0x0104,
    SMSG_LEARNED_SPELL                              = 0x58A2,
    SMSG_SUPERCEDED_SPELL                           = 0x12C,
    SMSG_CAST_FAILED                                = 0x4D16,
    SMSG_SPELL_START                                = 0x6415,
    SMSG_SPELL_GO                                   = 0x6E16,
    SMSG_SPELL_FAILURE                              = 0x4535,
    SMSG_SPELL_COOLDOWN                             = 0x4B16,
    SMSG_COOLDOWN_EVENT                             = 0x4F26,
    SMSG_EQUIPMENT_SET_SAVED                        = 0x2216,
    SMSG_PET_CAST_FAILED                            = 0x2B15,
    SMSG_AI_REACTION                                = 0x0637,
    SMSG_ATTACKSTART                                = 0x143,
    SMSG_ATTACKSTOP                                 = 0x144,
    SMSG_ATTACKSWING_NOTINRANGE                     = 0x0B36,
    SMSG_ATTACKSWING_BADFACING                      = 0x6C07,
    SMSG_INSTANCE_LOCK_WARNING_QUERY                = 0x147,
    SMSG_ATTACKSWING_DEADTARGET                     = 0x2B26,
    SMSG_ATTACKSWING_CANT_ATTACK                    = 0x0016,
    SMSG_ATTACKERSTATEUPDATE                        = 0x14A,
    SMSG_BATTLEFIELD_PORT_DENIED                    = 0x35A3,
    SMSG_RESUME_CAST_BAR                            = 0x14D,
    SMSG_CANCEL_COMBAT                              = 0x4F04,
    SMSG_SPELLBREAKLOG                              = 0x6B17,
    SMSG_SPELLHEALLOG                               = 0x2816,
    SMSG_SPELLENERGIZELOG                           = 0x151,
    SMSG_BREAK_TARGET                               = 0x0105,
    SMSG_BIND_POINT_UPDATE                          = 0x0527,
    SMSG_BINDZONEREPLY                              = 0x4C34,
    SMSG_PLAYERBOUND                                = 0x2516,
    SMSG_CLIENT_CONTROL_UPDATE                      = 0x2837,
    SMSG_RESURRECT_REQUEST                          = 0x2905,
    SMSG_LOOT_RESPONSE                              = 0x4C16,
    SMSG_LOOT_RELEASE_RESPONSE                      = 0x161,
    SMSG_LOOT_REMOVED                               = 0x6817,
    SMSG_LOOT_MONEY_NOTIFY                          = 0x2836,
    SMSG_LOOT_ITEM_NOTIFY                           = 0x6D15,
    SMSG_LOOT_CLEAR_MONEY                           = 0x165,
    SMSG_ITEM_PUSH_RESULT                           = 0xE15,
    SMSG_DUEL_REQUESTED                             = 0x4504,
    SMSG_DUEL_OUTOFBOUNDS                           = 0x0C26,
    SMSG_DUEL_INBOUNDS                              = 0x0A27,
    SMSG_DUEL_COMPLETE                              = 0x2527,
    SMSG_DUEL_WINNER                                = 0x2D36,
    SMSG_MOUNTRESULT                                = 0x16E,
    SMSG_DISMOUNTRESULT                             = 0x0D25,
    SMSG_REMOVED_FROM_PVP_QUEUE                     = 0x170,
    SMSG_MOUNTSPECIAL_ANIM                          = 0x0217,
    SMSG_PET_TAME_FAILURE                           = 0x6B24,
    SMSG_PET_NAME_INVALID                           = 0x6007,
    SMSG_PET_SPELLS                                 = 0x4114,
    SMSG_PET_MODE                                   = 0x2235,
    SMSG_GOSSIP_MESSAGE                             = 0x2035,
    SMSG_GOSSIP_COMPLETE                            = 0x0806,
    SMSG_NPC_TEXT_UPDATE                            = 0x4436,
    SMSG_NPC_WONT_TALK                              = 0x0000,
    SMSG_QUESTGIVER_STATUS                          = 0x183,
    SMSG_QUESTGIVER_QUEST_LIST                      = 0x185,
    SMSG_QUESTGIVER_QUEST_DETAILS                   = 0x188,
    SMSG_QUESTGIVER_REQUEST_ITEMS                   = 0x18B,
    SMSG_QUESTGIVER_OFFER_REWARD                    = 0x18D,
    SMSG_QUESTGIVER_QUEST_INVALID                   = 0x18F,
    SMSG_QUESTGIVER_QUEST_COMPLETE                  = 0x191,
    SMSG_QUESTGIVER_QUEST_FAILED                    = 0x192,
    SMSG_QUESTLOG_FULL                              = 0x195,
    SMSG_QUESTUPDATE_FAILED                         = 0x196,
    SMSG_QUESTUPDATE_FAILEDTIMER                    = 0x197,
    SMSG_QUESTUPDATE_COMPLETE                       = 0x198,
    SMSG_QUESTUPDATE_ADD_KILL                       = 0x199,
    SMSG_QUESTUPDATE_ADD_ITEM                       = 0x0000,
    SMSG_QUEST_CONFIRM_ACCEPT                       = 0x6F07,
    SMSG_LIST_INVENTORY                             = 0x19F,
    SMSG_SELL_ITEM                                  = 0x6105,
    SMSG_BUY_ITEM                                   = 0x0F26,
    SMSG_BUY_FAILED                                 = 0x6435,
    SMSG_SHOWTAXINODES                              = 0x2A36,
    SMSG_TAXINODE_STATUS                            = 0x2936,
    SMSG_ACTIVATETAXIREPLY                          = 0x6A37,
    SMSG_NEW_TAXI_PATH                              = 0x4B35,
    SMSG_TRAINER_LIST                               = 0x4414,
    SMSG_TRAINER_BUY_SUCCEEDED                      = 0x6A05,
    SMSG_TRAINER_BUY_FAILED                         = 0x0004,
    SMSG_PLAYERBINDERROR                            = 0x6A24,
    SMSG_SHOW_BANK                                  = 0x2627,
    SMSG_BUY_BANK_SLOT_RESULT                       = 0x4806,
    SMSG_PETITION_SHOWLIST                          = 0x6405,
    SMSG_PETITION_SHOW_SIGNATURES                   = 0x0716,
    SMSG_PETITION_SIGN_RESULTS                      = 0x6217,
    SMSG_TURN_IN_PETITION_RESULTS                   = 0x0F07,
    SMSG_PETITION_QUERY_RESPONSE                    = 0x4B37,
    SMSG_FISH_NOT_HOOKED                            = 0x0A17,
    SMSG_FISH_ESCAPED                               = 0x2205,
    SMSG_NOTIFICATION                               = 0x14A0,
    SMSG_PLAYED_TIME                                = 0x6037,
    SMSG_QUERY_TIME_RESPONSE                        = 0x2124,
    SMSG_LOG_XPGAIN                                 = 0x1D0,
    SMSG_AURACASTLOG                                = 0x0000,
    SMSG_LEVELUP_INFO                               = 0x1D4,
    SMSG_RESISTLOG                                  = 0x0000,
    SMSG_ENCHANTMENTLOG                             = 0x6035,
    SMSG_START_MIRROR_TIMER                         = 0x6824,
    SMSG_PAUSE_MIRROR_TIMER                         = 0x4015,
    SMSG_STOP_MIRROR_TIMER                          = 0x0B06,
    SMSG_PONG                                       = 0x4D42,
    SMSG_CLEAR_COOLDOWN                             = 0x0627,
    SMSG_GAMEOBJECT_PAGETEXT                        = 0x2925,
    SMSG_COOLDOWN_CHEAT                             = 0x4537,
    SMSG_SPELL_DELAYED                              = 0x0715,
    SMSG_QUEST_POI_QUERY_RESPONSE                   = 0x6304,
    SMSG_INVALID_PROMOTION_CODE                     = 0x6F25,
    SMSG_ITEM_TIME_UPDATE                           = 0x2407,
    SMSG_ITEM_ENCHANT_TIME_UPDATE                   = 0x0F27,
    SMSG_AUTH_CHALLENGE                             = 0x4542,
    SMSG_AUTH_RESPONSE                              = 0x5DB6,
    SMSG_HOTFIX_NOTIFY_BLOB                         = 0x19B5,
    SMSG_PLAY_SPELL_VISUAL                          = 0x10B1,
    SMSG_PARTYKILLLOG                               = 0x4937,
    SMSG_COMPRESSED_UPDATE_OBJECT                   = 0x1F6,
    SMSG_PLAY_SPELL_IMPACT                          = 0x1F7,
    SMSG_EXPLORATION_EXPERIENCE                     = 0x6716,
    SMSG_ENVIRONMENTAL_DAMAGE_LOG                   = 0x6C05,
    SMSG_RWHOIS                                     = 0x2437,
    SMSG_LFG_PLAYER_REWARD                          = 0x6834, // uint32, uint8, uint32, uint32, uint32, uint32, uint32, uint8, for (uint8) {uint32, uint32, uint32}
    SMSG_LFG_TELEPORT_DENIED                        = 0x0E14, // uint32 (1, 2, 4, 6;0, 5, 7)
    SMSG_REMOVED_SPELL                              = 0x203,
    SMSG_GMTICKET_CREATE                            = 0x2107,
    SMSG_GMTICKET_UPDATETEXT                        = 0x6535,
    SMSG_ACCOUNT_DATA_TIMES                         = 0x4B05,
    SMSG_UPDATE_ACCOUNT_DATA                        = 0x6837,
    SMSG_CLEAR_FAR_SIGHT_IMMEDIATE                  = 0x2A04,
    SMSG_CHANGEPLAYER_DIFFICULTY_RESULT             = 0x20E,
    SMSG_GMTICKET_GETTICKET                         = 0x2C15,
    SMSG_UPDATE_INSTANCE_ENCOUNTER_UNIT             = 0x4007,
    SMSG_GAMEOBJECT_DESPAWN_ANIM                    = 0x6735,
    SMSG_GMTICKET_DELETETICKET                      = 0x6D17,
    SMSG_CHAT_WRONG_FACTION                         = 0x6724,
    SMSG_GMTICKET_SYSTEMSTATUS                      = 0x0D35,
    SMSG_QUEST_FORCE_REMOVE                         = 0x6605, // uint32 questid
    SMSG_SPIRIT_HEALER_CONFIRM                      = 0x4917,
    SMSG_GOSSIP_POI                                 = 0x4316,
    SMSG_MOVE_SET_ACTIVE_MOVER                       = 0x11B3,
    SMSG_MOVE_UPDATE                                 = 0x79A2,
    SMSG_MOVE_UPDATE_RUN_SPEED                       = 0x14A6,
    SMSG_GM_PLAYER_INFO                             = 0x4A15,
    SMSG_LOGIN_VERIFY_WORLD                         = 0x2005,
    SMSG_LOAD_CUF_PROFILES                          = 0x50B1,
    SMSG_SEND_MAIL_RESULT                           = 0x4927,
    SMSG_MAIL_LIST_RESULT                           = 0x4217,
    SMSG_BATTLEFIELD_LIST                           = 0x71B5,
    SMSG_FORCE_SET_VEHICLE_REC_ID                   = 0x23F,
    SMSG_ITEM_TEXT_QUERY_RESPONSE                   = 0x2725,
    SMSG_SPELLLOGMISS                               = 0x24B,
    SMSG_SPELLLOGEXECUTE                            = 0x0626,
    SMSG_DEBUGAURAPROC                              = 0x24D,
    SMSG_PERIODICAURALOG                            = 0x24E,
    SMSG_SPELLDAMAGESHIELD                          = 0x24F,
    SMSG_SPELLNONMELEEDAMAGELOG                     = 0x4315,
    SMSG_RESURRECT_FAILED                           = 0x6705,
    SMSG_ZONE_UNDER_ATTACK                          = 0x0A06,
    SMSG_AUCTION_COMMAND_RESULT                     = 0x4C25,
    SMSG_AUCTION_LIST_RESULT                        = 0x6637,
    SMSG_AUCTION_OWNER_LIST_RESULT                  = 0x6C34,
    SMSG_AUCTION_BIDDER_NOTIFICATION                = 0x4E27,
    SMSG_AUCTION_OWNER_NOTIFICATION                 = 0x4116,
    SMSG_PROCRESIST                                 = 0x0426,
    SMSG_COMBAT_EVENT_FAILED                        = 0x2B07,
    SMSG_DISPEL_FAILED                              = 0x0307,
    SMSG_SPELLORDAMAGE_IMMUNE                       = 0x4507,
    SMSG_AUCTION_BIDDER_LIST_RESULT                 = 0x0027,
    SMSG_SET_FLAT_SPELL_MODIFIER                    = 0x2834,
    SMSG_SET_PCT_SPELL_MODIFIER                     = 0x0224,
    SMSG_CORPSE_RECLAIM_DELAY                       = 0x0D34,
    SMSG_STABLE_RESULT                              = 0x2204,
    SMSG_PLAY_MUSIC                                 = 0x4B06,
    SMSG_PLAY_OBJECT_SOUND                          = 0x2635,
    SMSG_SPELLDISPELLOG                             = 0x27B,
    SMSG_DAMAGE_CALC_LOG                            = 0x2436,
    SMSG_RECEIVED_MAIL                              = 0x2924,
    SMSG_RAID_GROUP_ONLY                            = 0x0837,
    SMSG_PVP_CREDIT                                 = 0x6015,
    SMSG_AUCTION_REMOVED_NOTIFICATION               = 0x2334,
    SMSG_CHAT_SERVER_MESSAGE                        = 0x291,
    SMSG_LFG_OFFER_CONTINUE                         = 0x6B27,
    SMSG_TEST_DROP_RATE_RESULT                      = 0x6816,
    SMSG_SHOW_MAILBOX                               = 0x2524,
    SMSG_RESET_RANGED_COMBAT_TIMER                  = 0x298,
    SMSG_CHAT_NOT_IN_PARTY                          = 0x6A14, // uint32, errors: ERR_NOT_IN_GROUP (2, 51) and ERR_NOT_IN_RAID (3, 39, 40)
    CMSG_GMTICKETSYSTEM_TOGGLE                      = 0x29A,
    SMSG_CANCEL_AUTO_REPEAT                         = 0x6436,
    SMSG_STANDSTATE_UPDATE                          = 0x29D,
    SMSG_LOOT_ALL_PASSED                            = 0x6237,
    SMSG_LOOT_ROLL_WON                              = 0x6617,
    SMSG_LOOT_START_ROLL                            = 0x2227,
    SMSG_LOOT_ROLL                                  = 0x6507,
    SMSG_LOOT_MASTER_LIST                           = 0x0325,
    SMSG_SET_FORCED_REACTIONS                       = 0x4615,
    SMSG_SPELL_FAILED_OTHER                         = 0x0C34,
    SMSG_GAMEOBJECT_RESET_STATE                     = 0x2A16,
    SMSG_CHAT_PLAYER_NOT_FOUND                      = 0x2526,
    SMSG_SUMMON_REQUEST                             = 0x2A07,
    SMSG_MONSTER_MOVE_TRANSPORT                     = 0x2AE,
    SMSG_PET_BROKEN                                 = 0x2E27,
    SMSG_FEIGN_DEATH_RESISTED                       = 0x0D05,
    SMSG_SCRIPT_MESSAGE                             = 0x2B6,
    SMSG_DUEL_COUNTDOWN                             = 0x4836,
    SMSG_AREA_TRIGGER_MESSAGE                       = 0x4505,
    SMSG_LFG_ROLE_CHOSEN                            = 0x6A26,
    SMSG_PLAYER_SKINNED                             = 0x0116,
    SMSG_DURABILITY_DAMAGE_DEATH                    = 0x4C27,
    SMSG_INIT_WORLD_STATES                          = 0x4C15,
    SMSG_UPDATE_WORLD_STATE                         = 0x4816,
    SMSG_ITEM_NAME_QUERY_RESPONSE                   = 0x2C5,
    SMSG_PET_ACTION_FEEDBACK                        = 0x0807,
    SMSG_CHAR_RENAME                                = 0x2024,
    SMSG_INSTANCE_SAVE_CREATED                      = 0x0124,
    SMSG_INSTANCE_INFO                         = 0x6626,
    SMSG_PLAY_SOUND                                 = 0x2134,
    SMSG_BATTLEFIELD_STATUS                         = 0x7DA1,
    SMSG_FORCE_WALK_SPEED_CHANGE                    = 0x2DA,
    SMSG_FORCE_SWIM_BACK_SPEED_CHANGE               = 0x2DC,
    SMSG_FORCE_TURN_RATE_CHANGE                     = 0x2DE,
    SMSG_AREA_SPIRIT_HEALER_TIME                    = 0x0734,
    SMSG_WARDEN_DATA                                = 0x31A0,
    SMSG_GROUP_JOINED_BATTLEGROUND                  = 0x2E8,
    SMSG_BINDER_CONFIRM                             = 0x2835,
    SMSG_BATTLEGROUND_PLAYER_JOINED                 = 0x50B0,
    SMSG_BATTLEGROUND_PLAYER_LEFT                   = 0x59A6,
    SMSG_ADDON_INFO                                 = 0x2C14,
    SMSG_PET_UNLEARN_CONFIRM                        = 0x2F1,    // Deprecated 3.x
    SMSG_PARTY_MEMBER_STATS_FULL                    = 0x2F2,
    SMSG_WEATHER                                    = 0x2904,
    SMSG_PLAY_TIME_WARNING                          = 0x4814,
    SMSG_MINIGAME_SETUP                             = 0x6727,
    SMSG_MINIGAME_STATE                             = 0x2E17,
    SMSG_MINIGAME_MOVE_FAILED                       = 0x2F9,
    SMSG_RAID_INSTANCE_MESSAGE                      = 0x6E15,
    SMSG_COMPRESSED_MOVES                           = 0x0517,
    SMSG_CHAT_RESTRICTED                            = 0x6536,
    SMSG_SPLINE_SET_RUN_SPEED                       = 0x2FE,
    SMSG_SPLINE_SET_RUN_BACK_SPEED                  = 0x2FF,
    SMSG_SPLINE_SET_SWIM_SPEED                      = 0x300,
    SMSG_SPLINE_SET_WALK_SPEED                      = 0x301,
    SMSG_SPLINE_SET_SWIM_BACK_SPEED                 = 0x302,
    SMSG_SPLINE_SET_TURN_RATE                       = 0x303,
    SMSG_SPLINE_MOVE_UNROOT                         = 0x75B6,
    SMSG_SPLINE_MOVE_FEATHER_FALL                   = 0x305,
    SMSG_SPLINE_MOVE_NORMAL_FALL                    = 0x306,
    SMSG_SPLINE_MOVE_SET_HOVER                      = 0x14B6,
    SMSG_SPLINE_MOVE_UNSET_HOVER                    = 0x7DA5,
    SMSG_SPLINE_MOVE_WATER_WALK                     = 0x50A2,
    SMSG_SPLINE_MOVE_LAND_WALK                      = 0x30A,
    SMSG_SPLINE_MOVE_START_SWIM                     = 0x31A5,
    SMSG_SPLINE_MOVE_STOP_SWIM                      = 0x1DA2,
    SMSG_SPLINE_MOVE_SET_RUN_MODE                   = 0x75A7,
    SMSG_SPLINE_MOVE_SET_WALK_MODE                  = 0x54B6,
    SMSG_SET_FACTION_ATWAR                          = 0x4216,
    SMSG_SPLINE_MOVE_ROOT                           = 0x51B4,
    SMSG_INVALIDATE_PLAYER                          = 0x6325,
    SMSG_INSTANCE_RESET                             = 0x6F05,
    SMSG_INSTANCE_RESET_FAILED                      = 0x4725,
    SMSG_UPDATE_LAST_INSTANCE                       = 0x0437,
    SMSG_PET_ACTION_SOUND                           = 0x4324,
    SMSG_PET_DISMISS_SOUND                          = 0x2B05,
    SMSG_GHOSTEE_GONE                               = 0x326,
    SMSG_GM_TICKET_STATUS_UPDATE                    = 0x2C25,
    SMSG_UPDATE_INSTANCE_OWNERSHIP                  = 0x4915,
    SMSG_CHAT_PLAYER_AMBIGUOUS                      = 0x2F34,
    SMSG_SPELLINSTAKILLLOG                          = 0x6216,
    SMSG_SPELL_UPDATE_CHAIN_TARGETS                 = 0x6006,
    SMSG_EXPECTED_SPAM_RECORDS                      = 0x4D36,
    SMSG_SPELLSTEALLOG                              = 0x4E26,
    SMSG_LOTTERY_QUERY_RESULT_OBSOLETE              = 0x335,
    SMSG_LOTTERY_RESULT_OBSOLETE                    = 0x337,
    SMSG_CHARACTER_PROFILE                          = 0x338,
    SMSG_CHARACTER_PROFILE_REALM_CONNECTED          = 0x339,
    SMSG_DEFENSE_MESSAGE                            = 0x0314,
    SMSG_WORLD_SERVER_INFO                          = 0x31A2,
    SMSG_MOTD                                       = 0x0A35,
    SMSG_MOVE_SET_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY = 0x59A2,
    SMSG_MOVE_UNSET_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY = 0x7DB2,
    SMSG_MOVE_SET_CAN_FLY                           = 0x3DA1,
    SMSG_MOVE_UNSET_CAN_FLY                         = 0x15A2,
    SMSG_ARENA_TEAM_COMMAND_RESULT                  = 0x39B3,
    SMSG_ARENA_TEAM_QUERY_RESPONSE                  = 0x6336,
    SMSG_ARENA_TEAM_ROSTER                          = 0x2717,
    SMSG_ARENA_TEAM_INVITE                          = 0x0F36,
    SMSG_ARENA_TEAM_EVENT                           = 0x0617,
    SMSG_ARENA_TEAM_STATS                           = 0x4425,
    SMSG_UPDATE_LFG_LIST                            = 0x360,    // uint32, uint32, if (uint8) { uint32 count, for (count) { uint64} }, uint32 count2, uint32, for (count2) { uint64, uint32 flags, if (flags & 0x2) {string}, if (flags & 0x10) {for (3) uint8}, if (flags & 0x80) {uint64, uint32}}, uint32 count3, uint32, for (count3) {uint64, uint32 flags, if (flags & 0x1) {uint8, uint8, uint8, for (3) uint8, uint32, uint32, uint32, uint32, uint32, uint32, float, float, uint32, uint32, uint32, uint32, uint32, float, uint32, uint32, uint32, uint32, uint32, uint32}, if (flags&0x2) string, if (flags&0x4) uint8, if (flags&0x8) uint64, if (flags&0x10) uint8, if (flags&0x20) uint32, if (flags&0x40) uint8, if (flags& 0x80) {uint64, uint32}}
    SMSG_LFG_PROPOSAL_UPDATE                        = 0x7DA6,    // uint32, uint8, uint32, uint32, uint8, for (uint8) {uint32, uint8, uint8, uint8, uint8}
    SMSG_LFG_ROLE_CHECK_UPDATE                      = 0x0336,    // uint32, uint8, for (uint8) uint32, uint8, for (uint8) { uint64, uint8, uint32, uint8, }
    SMSG_LFG_JOIN_RESULT                            = 0x38B6,    // uint32 unk, uint32, if (unk == 6) { uint8 count, for (count) uint64 }
    SMSG_LFG_QUEUE_STATUS                           = 0x78B4,    // uint32 dungeon, uint32 lfgtype, uint32, uint32, uint32, uint32, uint8, uint8, uint8, uint8
    SMSG_LFG_UPDATE_PLAYER                          = 0x367,    // uint8, if (uint8) { uint8, uint8, uint8, uint8, if (uint8) for (uint8) uint32, string}
    SMSG_LFG_UPDATE_PARTY                           = 0x368,    // uint8, if (uint8) { uint8, uint8, uint8, for (3) uint8, uint8, if (uint8) for (uint8) uint32, string}
    SMSG_LFG_UPDATE_SEARCH                          = 0x369,    // uint8
    SMSG_LFG_BOOT_PROPOSAL_UPDATE                   = 0x0F05,    // uint8, uint8, uint8, uint64, uint32, uint32, uint32, uint32
    SMSG_LFG_PLAYER_INFO                            = 0x4B36,    // uint8, for (uint8) { uint32, uint8, uint32, uint32, uint32, uint32, uint8, for (uint8) {uint32, uint32, uint32}}, uint32, for (uint32) {uint32, uint32}
    SMSG_LFG_PARTY_INFO                             = 0x2325,    // uint8, for (uint8) uint64
    SMSG_TITLE_EARNED                               = 0x2426,
    SMSG_ARENA_ERROR                                = 0x2D17,
    SMSG_DEATH_RELEASE_LOC                          = 0x2F07,
    SMSG_FORCED_DEATH_UPDATE                        = 0x2606,
    SMSG_FORCE_FLIGHT_SPEED_CHANGE                  = 0x381,
    SMSG_FORCE_FLIGHT_BACK_SPEED_CHANGE             = 0x383,
    SMSG_SPLINE_SET_FLIGHT_SPEED                    = 0x385,
    SMSG_SPLINE_SET_FLIGHT_BACK_SPEED               = 0x386,
    SMSG_FLIGHT_SPLINE_SYNC                         = 0x0924,
    SMSG_JOINED_BATTLEGROUND_QUEUE                  = 0x0000,
    SMSG_REALM_SPLIT                                = 0x2714,
    SMSG_OFFER_PETITION_ERROR                       = 0x2716,
    SMSG_TIME_SYNC_REQ                              = 0x3CA4,
    SMSG_RESET_FAILED_NOTIFY                        = 0x4616,
    SMSG_REAL_GROUP_UPDATE                          = 0x0F34,
    SMSG_LFG_DISABLED                               = 0x0815,
    SMSG_CHEAT_DUMP_ITEMS_DEBUG_ONLY_RESPONSE       = 0x39B,
    SMSG_CHEAT_DUMP_ITEMS_DEBUG_ONLY_RESPONSE_WRITE_FILE = 0x39C,
    SMSG_UPDATE_COMBO_POINTS                        = 0x6B34,
    SMSG_VOICE_SESSION_ROSTER_UPDATE                = 0x2A17,
    SMSG_VOICE_SESSION_LEAVE                        = 0x2A24,
    SMSG_VOICE_SESSION_ADJUST_PRIORITY              = 0x3A0,
    SMSG_VOICE_SET_TALKER_MUTED                     = 0x6E35,
    SMSG_INIT_EXTRA_AURA_INFO_OBSOLETE              = 0x3A3,
    SMSG_SET_EXTRA_AURA_INFO_OBSOLETE               = 0x3A4,
    SMSG_SET_EXTRA_AURA_INFO_NEED_UPDATE_OBSOLETE   = 0x3A5,
    SMSG_CLEAR_EXTRA_AURA_INFO_OBSOLETE             = 0x3A6,
    SMSG_IGNORE_REQUIREMENTS_CHEAT                  = 0x4E36,
    SMSG_SPELL_CHANCE_PROC_LOG                      = 0x3AA,
    SMSG_DISMOUNT                                   = 0x2135,
    SMSG_VOICE_SESSION_ENABLE                       = 0x3B0,
    SMSG_VOICE_PARENTAL_CONTROLS                    = 0x0534,
    SMSG_GM_MESSAGECHAT                             = 0x6434,
    SMSG_COMMENTATOR_STATE_CHANGED                  = 0x0737,
    SMSG_COMMENTATOR_MAP_INFO                       = 0x0327,
    SMSG_COMMENTATOR_GET_PLAYER_INFO                = 0x3BA,
    SMSG_COMMENTATOR_PLAYER_INFO                    = 0x2F36,
    SMSG_CLEAR_TARGET                               = 0x4B26,
    SMSG_CROSSED_INEBRIATION_THRESHOLD              = 0x2036,
    SMSG_CHEAT_PLAYER_LOOKUP                        = 0x3C4,
    SMSG_KICK_REASON                                = 0x4027,
    SMSG_COMPLAIN_RESULT                            = 0x3C8,
    SMSG_FEATURE_SYSTEM_STATUS                      = 0x3DB7,
    SMSG_CHANNEL_MEMBER_COUNT                       = 0x6414,
    SMSG_DEBUG_LIST_TARGETS                         = 0x3D9,
    SMSG_AVAILABLE_VOICE_CHANNEL                    = 0x2E16,
    SMSG_COMSAT_RECONNECT_TRY                       = 0x4D35,
    SMSG_COMSAT_DISCONNECT                          = 0x0316,
    SMSG_COMSAT_CONNECT_FAIL                        = 0x6317,
    SMSG_VOICE_CHAT_STATUS                          = 0x0F15,
    SMSG_REPORT_PVP_AFK_RESULT                      = 0x2D06,
    SMSG_GUILD_BANK_LIST                            = 0x3E8,
    SMSG_GUILD_BANK_MONEY_WITHDRAWN                  = 0x5DB4,
    SMSG_USERLIST_ADD                               = 0x0F37,
    SMSG_USERLIST_REMOVE                            = 0x2006,
    SMSG_USERLIST_UPDATE                            = 0x0135,
    SMSG_INSPECT_TALENT                             = 0x4014,
    SMSG_GOGOGO_OBSOLETE                            = 0x3F5,
    SMSG_ECHO_PARTY_SQUELCH                         = 0x0814,
    SMSG_LOOT_LIST                                  = 0x6807,
    SMSG_VOICESESSION_FULL                          = 0x6225,
    SMSG_MIRRORIMAGE_DATA                           = 0x2634,
    SMSG_FORCE_DISPLAY_UPDATE                       = 0x0000,
    SMSG_SPELL_CHANCE_RESIST_PUSHBACK               = 0x404,
    SMSG_IGNORE_DIMINISHING_RETURNS_CHEAT           = 0x0125,
    SMSG_RAID_READY_CHECK_ERROR                     = 0x408,
    SMSG_GROUPACTION_THROTTLED                      = 0x6524,
    SMSG_OVERRIDE_LIGHT                             = 0x4225, // uint32 defaultMapLight, uint32 overrideLight, uint32 transitionTimeMs
    SMSG_TOTEM_CREATED                              = 0x2414,
    SMSG_QUESTGIVER_STATUS_MULTIPLE                 = 0x4F25,
    SMSG_SET_PLAYER_DECLINED_NAMES_RESULT           = 0x2B25,
    SMSG_SERVER_BUCK_DATA                           = 0x41D,
    SMSG_SEND_UNLEARN_SPELLS                        = 0x4E25,
    SMSG_PROPOSE_LEVEL_GRANT                        = 0x6114,
    SMSG_REFER_A_FRIEND_FAILURE                     = 0x2037,
    SMSG_SPLINE_MOVE_SET_FLYING                     = 0x31B5,
    SMSG_SPLINE_MOVE_UNSET_FLYING                   = 0x58A6,
    SMSG_SUMMON_CANCEL                              = 0x0B34,
    SMSG_ENABLE_BARBER_SHOP                         = 0x2D16,
    SMSG_BARBER_SHOP_RESULT                         = 0x6125,
    SMSG_CALENDAR_SEND_CALENDAR                     = 0x6805,
    SMSG_CALENDAR_SEND_EVENT                        = 0x0C35,
    SMSG_CALENDAR_FILTER_GUILD                      = 0x4A26,
    SMSG_CALENDAR_ARENA_TEAM                        = 0x0615,
    SMSG_CALENDAR_EVENT_INVITE                      = 0x4E16,
    SMSG_CALENDAR_EVENT_INVITE_REMOVED              = 0x0725,
    SMSG_CALENDAR_EVENT_STATUS                      = 0x2A27,
    SMSG_CALENDAR_COMMAND_RESULT                    = 0x6F36,
    SMSG_CALENDAR_RAID_LOCKOUT_ADDED                = 0x2305,
    SMSG_CALENDAR_RAID_LOCKOUT_REMOVED              = 0x2E25,
    SMSG_CALENDAR_EVENT_INVITE_ALERT                = 0x2A05,
    SMSG_CALENDAR_EVENT_INVITE_REMOVED_ALERT        = 0x2617,
    SMSG_CALENDAR_EVENT_INVITE_STATUS_ALERT         = 0x6625,
    SMSG_CALENDAR_EVENT_REMOVED_ALERT               = 0x6D35,
    SMSG_CALENDAR_EVENT_UPDATED_ALERT               = 0x0907,
    SMSG_CALENDAR_EVENT_MODERATOR_STATUS_ALERT      = 0x6B06,
    SMSG_CALENDAR_SEND_NUM_PENDING                  = 0x0C17,
    SMSG_NOTIFY_DANCE                               = 0x4904,
    SMSG_PLAY_DANCE                                 = 0x4704,
    SMSG_STOP_DANCE                                 = 0x4637,
    SMSG_DANCE_QUERY_RESPONSE                       = 0x2F06,
    SMSG_INVALIDATE_DANCE                           = 0x0E27,
    SMSG_LEARNED_DANCE_MOVES                        = 0x0E05,
    SMSG_FORCE_PITCH_RATE_CHANGE                    = 0x45C,
    SMSG_SPLINE_SET_PITCH_RATE                      = 0x45E,
    SMSG_CALENDAR_EVENT_INVITE_NOTES                = 0x0E17,
    SMSG_CALENDAR_EVENT_INVITE_NOTES_ALERT          = 0x2535,
    SMSG_UPDATE_ACCOUNT_DATA_COMPLETE               = 0x2015,
    SMSG_TRIGGER_MOVIE                              = 0x4625,
    SMSG_ACHIEVEMENT_EARNED                         = 0x4405,
    SMSG_DYNAMIC_DROP_ROLL_RESULT                   = 0x469,
    SMSG_CRITERIA_UPDATE                            = 0x6E37,
    SMSG_RESPOND_INSPECT_ACHIEVEMENTS               = 0x15B0,
    SMSG_QUESTUPDATE_ADD_PVP_KILL                   = 0x46F,
    SMSG_CALENDAR_RAID_LOCKOUT_UPDATED              = 0x4636,
    SMSG_CHAR_CUSTOMIZE                             = 0x4F16,
    SMSG_PET_RENAMEABLE                             = 0x2B27,
    SMSG_SET_PHASE_SHIFT                            = 0x47C,
    SMSG_ALL_ACHIEVEMENT_DATA                       = 0x58B1,
    SMSG_HEALTH_UPDATE                              = 0x4734,
    SMSG_POWER_UPDATE                               = 0x4A07,
    SMSG_HIGHEST_THREAT_UPDATE                      = 0x4104,
    SMSG_THREAT_UPDATE                              = 0x4735,
    SMSG_THREAT_REMOVE                              = 0x2E05,
    SMSG_THREAT_CLEAR                               = 0x6437,
    SMSG_CONVERT_RUNE                               = 0x4F14,
    SMSG_RESYNC_RUNES                               = 0x6224,
    SMSG_ADD_RUNE_POWER                             = 0x6915,
    SMSG_DUMP_OBJECTS_DATA                          = 0x48C,
    SMSG_NOTIFY_DEST_LOC_SPELL_CAST                 = 0x6204,
    SMSG_AUCTION_LIST_PENDING_SALES                 = 0x6A27,
    SMSG_MODIFY_COOLDOWN                            = 0x6016,
    SMSG_PET_UPDATE_COMBO_POINTS                    = 0x4325,
    SMSG_PRE_RESURRECT                              = 0x6C36,
    SMSG_AURA_UPDATE_ALL                            = 0x6916,
    SMSG_AURA_UPDATE                                = 0x4707,
    SMSG_SERVER_FIRST_ACHIEVEMENT                   = 0x6424,
    SMSG_PET_LEARNED_SPELL                          = 0x0507,
    SMSG_PET_UNLEARNED_SPELL                        = 0x49A,
    SMSG_ON_CANCEL_EXPECTED_RIDE_VEHICLE_AURA       = 0x4D34,
    SMSG_CRITERIA_DELETED                           = 0x2915,
    SMSG_ACHIEVEMENT_DELETED                        = 0x6A16,
    SMSG_SERVER_INFO_RESPONSE                       = 0x74B5,
    SMSG_SERVER_BUCK_DATA_START                     = 0x4A3,
    SMSG_BATTLEGROUND_INFO_THROTTLED                = 0x34B2, // empty, "You can't do that yet"
    SMSG_PLAYER_VEHICLE_DATA                        = 0x4A7, // guid+uint32 (vehicle)
    SMSG_PET_GUIDS                                  = 0x2D26,
    SMSG_CLIENTCACHE_VERSION                        = 0x2734,
    SMSG_ITEM_REFUND_INFO_RESPONSE                  = 0x15A3,
    SMSG_ITEM_REFUND_RESULT                         = 0x5DB1,
    SMSG_CORPSE_MAP_POSITION_QUERY_RESPONSE         = 0x0E35, // 3*float+float
    SMSG_CALENDAR_CLEAR_PENDING_ACTION              = 0x2106,
    SMSG_EQUIPMENT_SET_LIST                         = 0x2E04, // equipment manager list?
    SMSG_SET_PROJECTILE_POSITION                    = 0x2616,
    SMSG_TALENTS_INFO                               = 0x6F26,
    SMSG_ARENA_UNIT_DESTROYED                       = 0x2637,
    SMSG_ARENA_TEAM_CHANGE_FAILED_QUEUED            = 0x6E34, // uint32 "Can't modify arena team while queued or in a match."
    SMSG_PROFILEDATA_RESPONSE                       = 0x4CA,
    SMSG_MULTIPLE_PACKETS                           = 0x6736,
    SMSG_MOVE_GRAVITY_DISABLE                       = 0x75B2,
    SMSG_MOVE_GRAVITY_ENABLE                        = 0x30B3,
    MSG_MOVE_GRAVITY_CHNG                           = 0x4D2,
    SMSG_SPLINE_MOVE_GRAVITY_DISABLE                = 0x5DB5,
    SMSG_SPLINE_MOVE_GRAVITY_ENABLE                 = 0x3CA6,
    SMSG_EQUIPMENT_SET_USE_RESULT                   = 0x2424,
    SMSG_FORCE_ANIM                                 = 0x4C05,
    SMSG_CHAR_FACTION_CHANGE                        = 0x4C06,
    SMSG_PVP_QUEUE_STATS                            = 0x4DC,
    SMSG_BATTLEFIELD_MGR_ENTRY_INVITE               = 0x34B3, // uint32
    SMSG_BATTLEFIELD_MGR_ENTERED                    = 0x5CA0, // uint32, uint8, uint8
    SMSG_BATTLEFIELD_MGR_QUEUE_INVITE               = 0x15A6, // uint32
    SMSG_BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE     = 0x79B6, // uint32, uint8
    SMSG_BATTLEFIELD_MGR_EJECT_PENDING              = 0x34A2, // uint32
    SMSG_BATTLEFIELD_MGR_EJECTED                    = 0x7DB7, // uint32, uint32, uint8
    SMSG_BATTLEFIELD_MGR_STATE_CHANGE               = 0x35B4, // uint32, uint32
    SMSG_TOGGLE_XP_GAIN                             = 0x6704, // enable/disable XP gain console message
    SMSG_GMRESPONSE_DB_ERROR                        = 0x0006, // empty
    SMSG_GMRESPONSE_RECEIVED                        = 0x2E34, // uint32, uint32, string[2000], string[4000][4]
    SMSG_GMRESPONSE_STATUS_UPDATE                   = 0x0A04, // uint8 (1 - EVENT_GMSURVEY_DISPLAY, 0 - EVENT_UPDATE_TICKET)
    SMSG_GMRESPONSE_CREATE_TICKET                   = 0x4F2,
    SMSG_SERVERINFO                                 = 0x4F5,
    SMSG_WORLD_STATE_UI_TIMER_UPDATE                = 0x4A14,
    SMSG_TALENTS_INVOLUNTARILY_RESET                = 0x2C27, // uint8
    SMSG_DEBUG_SERVER_GEO                           = 0x0235,
    SMSG_LOOT_SLOT_CHANGED                          = 0x2935,
    SMSG_QUERY_QUESTS_COMPLETED_RESPONSE            = 0x6314,
    SMSG_AFK_MONITOR_INFO_RESPONSE                  = 0x504,
    SMSG_CORPSE_NOT_IN_INSTANCE                     = 0x2A14,
    SMSG_CAMERA_SHAKE                               = 0x4214, // uint32 SpellEffectCameraShakes.dbc index, uint32
    SMSG_SOCKET_GEMS_RESULT                         = 0x6014,
    SMSG_REDIRECT_CLIENT                            = 0x50D, // uint32 ip, uint16 port, uint32 unk, uint8[20] hash (ip + port, seed=sessionkey)
    SMSG_SUSPEND_COMMS                              = 0x4140,
    SMSG_FORCE_SEND_QUEUED_PACKETS                  = 0x511,
    SMSG_SEND_ALL_COMBAT_LOG                        = 0x514,
    SMSG_OPEN_LFG_DUNGEON_FINDER                    = 0x2C37,
    SMSG_MOVE_SET_COLLISION_HGT                     = 0x516,
    SMSG_COMMENTATOR_SKIRMISH_QUEUE_RESULT1         = 0x2126,
    SMSG_COMMENTATOR_SKIRMISH_QUEUE_RESULT2         = 0x6814,
    SMSG_MULTIPLE_MOVES                             = 0x51E, // uncompressed version of SMSG_COMPRESSED_MOVES
    TC9_SMSG_READY_FOR_REDIRECT                     = 0x520,
    SMSG_PHASE_SHIFT_CHANGE                         = 0x70A0,
};

inline constexpr OpcodeServer MSG_MOVE_START_FORWARD_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_FORWARD);
inline constexpr OpcodeServer MSG_MOVE_START_BACKWARD_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_BACKWARD);
inline constexpr OpcodeServer MSG_MOVE_STOP_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_STOP);
inline constexpr OpcodeServer MSG_MOVE_START_STRAFE_LEFT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_STRAFE_LEFT);
inline constexpr OpcodeServer MSG_MOVE_START_STRAFE_RIGHT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_STRAFE_RIGHT);
inline constexpr OpcodeServer MSG_MOVE_STOP_STRAFE_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_STOP_STRAFE);
inline constexpr OpcodeServer MSG_MOVE_JUMP_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_JUMP);
inline constexpr OpcodeServer MSG_MOVE_START_TURN_LEFT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_TURN_LEFT);
inline constexpr OpcodeServer MSG_MOVE_START_TURN_RIGHT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_TURN_RIGHT);
inline constexpr OpcodeServer MSG_MOVE_STOP_TURN_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_STOP_TURN);
inline constexpr OpcodeServer MSG_MOVE_START_PITCH_UP_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_PITCH_UP);
inline constexpr OpcodeServer MSG_MOVE_START_PITCH_DOWN_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_PITCH_DOWN);
inline constexpr OpcodeServer MSG_MOVE_STOP_PITCH_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_STOP_PITCH);
inline constexpr OpcodeServer MSG_MOVE_SET_RUN_MODE_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_RUN_MODE);
inline constexpr OpcodeServer MSG_MOVE_SET_WALK_MODE_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_WALK_MODE);
inline constexpr OpcodeServer MSG_MOVE_TOGGLE_LOGGING_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_TOGGLE_LOGGING);
inline constexpr OpcodeServer MSG_MOVE_TELEPORT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_TELEPORT);
inline constexpr OpcodeServer MSG_MOVE_TELEPORT_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_TELEPORT_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_TELEPORT_ACK_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_TELEPORT_ACK);
inline constexpr OpcodeServer MSG_MOVE_TOGGLE_FALL_LOGGING_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_TOGGLE_FALL_LOGGING);
inline constexpr OpcodeServer MSG_MOVE_FALL_LAND_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_FALL_LAND);
inline constexpr OpcodeServer MSG_MOVE_START_SWIM_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_SWIM);
inline constexpr OpcodeServer MSG_MOVE_STOP_SWIM_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_STOP_SWIM);
inline constexpr OpcodeServer MSG_MOVE_SET_RUN_SPEED_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_RUN_SPEED_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_RUN_BACK_SPEED_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_RUN_BACK_SPEED_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_RUN_BACK_SPEED_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_RUN_BACK_SPEED);
inline constexpr OpcodeServer MSG_MOVE_SET_WALK_SPEED_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_WALK_SPEED_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_WALK_SPEED_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_WALK_SPEED);
inline constexpr OpcodeServer MSG_MOVE_SET_SWIM_SPEED_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_SWIM_SPEED_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_SWIM_SPEED_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_SWIM_SPEED);
inline constexpr OpcodeServer MSG_MOVE_SET_SWIM_BACK_SPEED_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_SWIM_BACK_SPEED_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_SWIM_BACK_SPEED_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_SWIM_BACK_SPEED);
inline constexpr OpcodeServer MSG_MOVE_SET_ALL_SPEED_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_ALL_SPEED_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_TURN_RATE_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_TURN_RATE_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_TURN_RATE_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_TURN_RATE);
inline constexpr OpcodeServer MSG_MOVE_TOGGLE_COLLISION_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_TOGGLE_COLLISION_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_FACING_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_FACING);
inline constexpr OpcodeServer MSG_MOVE_SET_PITCH_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_PITCH);
inline constexpr OpcodeServer MSG_MOVE_WORLDPORT_ACK_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_WORLDPORT_ACK);
inline constexpr OpcodeServer MSG_MOVE_ROOT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_ROOT);
inline constexpr OpcodeServer MSG_MOVE_UNROOT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_UNROOT);
inline constexpr OpcodeServer MSG_MOVE_HEARTBEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_HEARTBEAT);
inline constexpr OpcodeServer MSG_MOVE_KNOCK_BACK_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_KNOCK_BACK);
inline constexpr OpcodeClient MSG_MOVE_HOVER_CLIENT =
    static_cast<OpcodeClient>(MSG_MOVE_HOVER);
inline constexpr OpcodeServer MSG_CHANNEL_START_SERVER =
    static_cast<OpcodeServer>(MSG_CHANNEL_START);
inline constexpr OpcodeServer MSG_CHANNEL_UPDATE_SERVER =
    static_cast<OpcodeServer>(MSG_CHANNEL_UPDATE);
inline constexpr OpcodeServer MSG_PETITION_DECLINE_SERVER =
    static_cast<OpcodeServer>(MSG_PETITION_DECLINE);
inline constexpr OpcodeServer MSG_MINIMAP_PING_SERVER =
    static_cast<OpcodeServer>(MSG_MINIMAP_PING);
inline constexpr OpcodeServer MSG_GM_BIND_OTHER_SERVER =
    static_cast<OpcodeServer>(MSG_GM_BIND_OTHER);
inline constexpr OpcodeServer MSG_GM_SUMMON_SERVER =
    static_cast<OpcodeServer>(MSG_GM_SUMMON);
inline constexpr OpcodeServer MSG_GM_SHOWLABEL_SERVER =
    static_cast<OpcodeServer>(MSG_GM_SHOWLABEL);
inline constexpr OpcodeServer MSG_SAVE_GUILD_EMBLEM_SERVER =
    static_cast<OpcodeServer>(MSG_SAVE_GUILD_EMBLEM);
inline constexpr OpcodeServer MSG_TABARDVENDOR_ACTIVATE_SERVER =
    static_cast<OpcodeServer>(MSG_TABARDVENDOR_ACTIVATE);
inline constexpr OpcodeServer MSG_RANDOM_ROLL_SERVER =
    static_cast<OpcodeServer>(MSG_RANDOM_ROLL);
inline constexpr OpcodeServer MSG_CORPSE_QUERY_SERVER =
    static_cast<OpcodeServer>(MSG_CORPSE_QUERY);
inline constexpr OpcodeServer MSG_AUCTION_HELLO_SERVER =
    static_cast<OpcodeServer>(MSG_AUCTION_HELLO);
inline constexpr OpcodeServer MSG_GM_ACCOUNT_ONLINE_SERVER =
    static_cast<OpcodeServer>(MSG_GM_ACCOUNT_ONLINE);
inline constexpr OpcodeServer MSG_LIST_STABLED_PETS_SERVER =
    static_cast<OpcodeServer>(MSG_LIST_STABLED_PETS);
inline constexpr OpcodeServer MSG_QUEST_PUSH_RESULT_SERVER =
    static_cast<OpcodeServer>(MSG_QUEST_PUSH_RESULT);
inline constexpr OpcodeServer MSG_QUERY_NEXT_MAIL_TIME_SERVER =
    static_cast<OpcodeServer>(MSG_QUERY_NEXT_MAIL_TIME);
inline constexpr OpcodeServer MSG_TALENT_WIPE_CONFIRM_SERVER =
    static_cast<OpcodeServer>(MSG_TALENT_WIPE_CONFIRM);
inline constexpr OpcodeServer MSG_DEV_SHOWLABEL_SERVER =
    static_cast<OpcodeServer>(MSG_DEV_SHOWLABEL);
inline constexpr OpcodeServer MSG_MOVE_FEATHER_FALL_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_FEATHER_FALL);
inline constexpr OpcodeServer MSG_MOVE_WATER_WALK_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_WATER_WALK);
inline constexpr OpcodeServer MSG_PETITION_RENAME_SERVER =
    static_cast<OpcodeServer>(MSG_PETITION_RENAME);
inline constexpr OpcodeServer MSG_INSPECT_HONOR_STATS_SERVER =
    static_cast<OpcodeServer>(MSG_INSPECT_HONOR_STATS);
inline constexpr OpcodeServer MSG_PVP_LOG_DATA_SERVER =
    static_cast<OpcodeServer>(MSG_PVP_LOG_DATA);
inline constexpr OpcodeServer MSG_BATTLEGROUND_PLAYER_POSITIONS_SERVER =
    static_cast<OpcodeServer>(MSG_BATTLEGROUND_PLAYER_POSITIONS);
inline constexpr OpcodeServer MSG_GM_DESTROY_CORPSE_SERVER =
    static_cast<OpcodeServer>(MSG_GM_DESTROY_CORPSE);
inline constexpr OpcodeServer MSG_MOVE_TIME_SKIPPED_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_TIME_SKIPPED);
inline constexpr OpcodeServer MSG_RAID_TARGET_UPDATE_SERVER =
    static_cast<OpcodeServer>(MSG_RAID_TARGET_UPDATE);
inline constexpr OpcodeServer MSG_RAID_READY_CHECK_SERVER =
    static_cast<OpcodeServer>(MSG_RAID_READY_CHECK);
inline constexpr OpcodeServer MSG_SET_DUNGEON_DIFFICULTY_SERVER =
    static_cast<OpcodeServer>(MSG_SET_DUNGEON_DIFFICULTY);
inline constexpr OpcodeServer MSG_DELAY_GHOST_TELEPORT_SERVER =
    static_cast<OpcodeServer>(MSG_DELAY_GHOST_TELEPORT);
inline constexpr OpcodeServer MSG_GM_RESETINSTANCELIMIT_SERVER =
    static_cast<OpcodeServer>(MSG_GM_RESETINSTANCELIMIT);
inline constexpr OpcodeServer MSG_MOVE_START_SWIM_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_SWIM_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_STOP_SWIM_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_STOP_SWIM_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_UPDATE_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_UPDATE_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY);
inline constexpr OpcodeServer MSG_MOVE_START_ASCEND_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_ASCEND);
inline constexpr OpcodeServer MSG_MOVE_STOP_ASCEND_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_STOP_ASCEND);
inline constexpr OpcodeServer MSG_INSPECT_ARENA_TEAMS_SERVER =
    static_cast<OpcodeServer>(MSG_INSPECT_ARENA_TEAMS);
inline constexpr OpcodeServer MSG_MOVE_SET_FLIGHT_SPEED_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_FLIGHT_SPEED_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_FLIGHT_SPEED_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_FLIGHT_SPEED);
inline constexpr OpcodeServer MSG_MOVE_SET_FLIGHT_BACK_SPEED_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_FLIGHT_BACK_SPEED_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_FLIGHT_BACK_SPEED_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_FLIGHT_BACK_SPEED);
inline constexpr OpcodeServer MSG_PARTY_ASSIGNMENT_SERVER =
    static_cast<OpcodeServer>(MSG_PARTY_ASSIGNMENT);
inline constexpr OpcodeServer MSG_MOVE_START_DESCEND_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_START_DESCEND);
inline constexpr OpcodeServer MSG_MOVE_UPDATE_CAN_FLY_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_UPDATE_CAN_FLY);
inline constexpr OpcodeServer MSG_RAID_READY_CHECK_CONFIRM_SERVER =
    static_cast<OpcodeServer>(MSG_RAID_READY_CHECK_CONFIRM);
inline constexpr OpcodeServer MSG_GM_GEARRATING_SERVER =
    static_cast<OpcodeServer>(MSG_GM_GEARRATING);
inline constexpr OpcodeServer MSG_RAID_READY_CHECK_FINISHED_SERVER =
    static_cast<OpcodeServer>(MSG_RAID_READY_CHECK_FINISHED);
inline constexpr OpcodeServer MSG_NOTIFY_PARTY_SQUELCH_SERVER =
    static_cast<OpcodeServer>(MSG_NOTIFY_PARTY_SQUELCH);
inline constexpr OpcodeServer MSG_GUILD_BANK_LOG_QUERY_SERVER =
    static_cast<OpcodeServer>(MSG_GUILD_BANK_LOG_QUERY);
inline constexpr OpcodeServer MSG_GUILD_PERMISSIONS_SERVER =
    static_cast<OpcodeServer>(MSG_GUILD_PERMISSIONS);
inline constexpr OpcodeServer MSG_GUILD_EVENT_LOG_QUERY_SERVER =
    static_cast<OpcodeServer>(MSG_GUILD_EVENT_LOG_QUERY);
inline constexpr OpcodeServer MSG_QUERY_GUILD_BANK_TEXT_SERVER =
    static_cast<OpcodeServer>(MSG_QUERY_GUILD_BANK_TEXT);
inline constexpr OpcodeServer MSG_GM_CHANGE_ARENA_RATING_SERVER =
    static_cast<OpcodeServer>(MSG_GM_CHANGE_ARENA_RATING);
inline constexpr OpcodeServer MSG_MOVE_SET_PITCH_RATE_CHEAT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_PITCH_RATE_CHEAT);
inline constexpr OpcodeServer MSG_MOVE_SET_PITCH_RATE_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_PITCH_RATE);
inline constexpr OpcodeClient MSG_MOVE_GRAVITY_CHNG_CLIENT =
    static_cast<OpcodeClient>(MSG_MOVE_GRAVITY_CHNG);
inline constexpr OpcodeServer MSG_SET_RAID_DIFFICULTY_SERVER =
    static_cast<OpcodeServer>(MSG_SET_RAID_DIFFICULTY);
inline constexpr OpcodeServer MSG_VIEW_PHASE_SHIFT_SERVER =
    static_cast<OpcodeServer>(MSG_VIEW_PHASE_SHIFT);
inline constexpr OpcodeServer MSG_MOVE_SET_COLLISION_HGT_SERVER =
    static_cast<OpcodeServer>(MSG_MOVE_SET_COLLISION_HGT);

enum OpcodeMisc : uint16
{
    NUM_MSG_TYPES = 0xFFFF,
    NUM_OPCODE_HANDLERS = NUM_MSG_TYPES,
    NULL_OPCODE = 0x0000,
    COMPRESSED_OPCODE_MASK = 0x8000
};

/// Player state
enum SessionStatus
{
    STATUS_AUTHED = 0,                                      // Player authenticated (_player == nullptr, m_playerRecentlyLogout = false or will be reset before handler call, m_GUID have garbage)
    STATUS_LOGGEDIN,                                        // Player in game (_player != nullptr, m_GUID == _player->GetGUID(), inWorld())
    STATUS_TRANSFER,                                        // Player transferring to another map (_player != nullptr, m_GUID == _player->GetGUID(), !inWorld())
    STATUS_LOGGEDIN_OR_RECENTLY_LOGGOUT,                    // _player != nullptr or _player == nullptr && m_playerRecentlyLogout && m_playerLogout, m_GUID store last _player guid)
    STATUS_NEVER,                                           // Opcode not accepted from client (deprecated or server side only)
    STATUS_UNHANDLED,                                       // Opcode not handled yet
};

enum PacketProcessing
{
    PROCESS_INPLACE = 0,                                    //process packet whenever we receive it - mostly for non-handled or non-implemented packets
    PROCESS_THREADUNSAFE,                                   //packet is not thread-safe - process it in World::UpdateSessions()
    PROCESS_THREADSAFE                                      //packet is thread-safe - process it in Map::Update()
};

class WorldSession;
class WorldPacket;

class OpcodeHandler
{
public:
    OpcodeHandler(char const* name, SessionStatus status) : Name(name), Status(status) { }
    virtual ~OpcodeHandler() = default;

    char const* Name;
    SessionStatus Status;
};

class ClientOpcodeHandler : public OpcodeHandler
{
public:
    ClientOpcodeHandler(char const* name, SessionStatus status, PacketProcessing processing)
        : OpcodeHandler(name, status), ProcessingPlace(processing) { }

    virtual void Call(WorldSession* session, WorldPacket& packet) const = 0;

    PacketProcessing ProcessingPlace;
};

class ServerOpcodeHandler : public OpcodeHandler
{
public:
    ServerOpcodeHandler(char const* name, SessionStatus status)
        : OpcodeHandler(name, status) { }
};

class OpcodeTable
{
public:
    OpcodeTable();

    OpcodeTable(OpcodeTable const&) = delete;
    OpcodeTable& operator=(OpcodeTable const&) = delete;

    ~OpcodeTable();

    void Initialize();

    ClientOpcodeHandler const* operator[](OpcodeClient index) const
    {
        return _internalTableClient[index];
    }

    ServerOpcodeHandler const* operator[](OpcodeServer index) const
    {
        return _internalTableServer[index];
    }

    OpcodeHandler const* GetIncomingOpcode(uint16 opcode) const;
    std::string GetOpcodeNameForLogging(OpcodeClient opcode) const;
    std::string GetOpcodeNameForLogging(OpcodeServer opcode) const;

private:
    template<typename Handler, Handler HandlerFunction>
    void ValidateAndSetClientOpcode(OpcodeClient opcode, char const* name, SessionStatus status, PacketProcessing processing);

    void ValidateAndSetServerOpcode(OpcodeServer opcode, char const* name, SessionStatus status);

    void SetBidirectionalOpcodeNames(char const* name, OpcodeClient clientOpcode, OpcodeServer serverOpcode);

    ClientOpcodeHandler* _internalTableClient[NUM_OPCODE_HANDLERS];
    ServerOpcodeHandler* _internalTableServer[NUM_OPCODE_HANDLERS];
    char const* _internalTableClientNames[NUM_OPCODE_HANDLERS];
    char const* _internalTableServerNames[NUM_OPCODE_HANDLERS];
};

extern OpcodeTable opcodeTable;

/// Lookup opcode name for human understandable logging
std::string GetOpcodeNameForLogging(OpcodeClient opcode);
std::string GetOpcodeNameForLogging(OpcodeServer opcode);

#endif
