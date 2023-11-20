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

#include "AccountMgr.h"
#include "CellImpl.h"
#include "ChannelMgr.h"
#include "Chat.h"
#include "ChatPackets.h"
#include "Common.h"
#include "GameTime.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "Language.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "Util.h"
#include "Warden.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

inline bool isNasty(uint8 c)
{
    if (c == '\t')
    {
        return false;
    }

    if (c <= '\037') // ASCII control block
    {
        return true;
    }

    return false;
}

void WorldSession::HandleMessagechatOpcode(WorldPacket& recvData)
{
    uint32 type;
    uint32 lang;

    recvData >> type;
    recvData >> lang;

    if (type >= MAX_CHAT_MSG_TYPE)
    {
        LOG_ERROR("network.opcode", "CHAT: Wrong message type received: {}", type);
        recvData.rfinish();
        return;
    }

    if (lang == LANG_UNIVERSAL && type != CHAT_MSG_AFK && type != CHAT_MSG_DND)
    {
        LOG_ERROR("entities.player.cheat", "CMSG_MESSAGECHAT: Possible hacking-attempt: {} tried to send a message in universal language", GetPlayerInfo());
        SendNotification(LANG_UNKNOWN_LANGUAGE);
        recvData.rfinish();
        return;
    }

    Player* sender = GetPlayer();

    // prevent talking at unknown language (cheating)
    LanguageDesc const* langDesc = GetLanguageDescByID(lang);
    if (!langDesc)
    {
        SendNotification(LANG_UNKNOWN_LANGUAGE);
        recvData.rfinish();
        return;
    }

    if (langDesc->skill_id != 0 && !sender->HasSkill(langDesc->skill_id))
    {
        // also check SPELL_AURA_COMPREHEND_LANGUAGE (client offers option to speak in that language)
        bool foundAura = false;
        for (auto const& auraEff : sender->GetAuraEffectsByType(SPELL_AURA_COMPREHEND_LANGUAGE))
        {
            if (auraEff->GetMiscValue() == int32(lang))
            {
                foundAura = true;
                break;
            }
        }

        if (!foundAura)
        {
            SendNotification(LANG_NOT_LEARNED_LANGUAGE);
            recvData.rfinish();
            return;
        }
    }

    // pussywizard: chatting on most chat types requires 2 hours played to prevent spam/abuse
    if (AccountMgr::IsPlayerAccount(GetSecurity()))
    {
        switch (type)
        {
            case CHAT_MSG_ADDON:
            case CHAT_MSG_PARTY:
            case CHAT_MSG_RAID:
            case CHAT_MSG_GUILD:
            case CHAT_MSG_OFFICER:
            case CHAT_MSG_AFK:
            case CHAT_MSG_DND:
            case CHAT_MSG_RAID_LEADER:
            case CHAT_MSG_RAID_WARNING:
            case CHAT_MSG_BATTLEGROUND:
            case CHAT_MSG_BATTLEGROUND_LEADER:
            case CHAT_MSG_PARTY_LEADER:
                break;
            default:
            {
                if (sWorld->getBoolConfig(CONFIG_CHAT_MUTE_FIRST_LOGIN))
                {
                    uint32 minutes = sWorld->getIntConfig(CONFIG_CHAT_TIME_MUTE_FIRST_LOGIN);

                    if (sender->GetTotalPlayedTime() < minutes * MINUTE)
                    {
                        SendNotification(LANG_MUTED_PLAYER, minutes);
                        recvData.rfinish();
                        return;
                    }
                }
            }
        }
    }

    // pussywizard:
    switch (type)
    {
        case CHAT_MSG_SAY:
        case CHAT_MSG_YELL:
        case CHAT_MSG_EMOTE:
        case CHAT_MSG_TEXT_EMOTE:
        case CHAT_MSG_AFK:
        case CHAT_MSG_DND:
        if (sender->IsSpectator())
        {
            recvData.rfinish();
            return;
        }
    }

    if (sender->HasAura(1852) && type != CHAT_MSG_WHISPER)
    {
        SendNotification(GetAcoreString(LANG_GM_SILENCE), sender->GetName().c_str());
        recvData.rfinish();
        return;
    }

    if (lang == LANG_ADDON)
    {
        // LANG_ADDON is only valid for the following message types
        switch (type)
        {
            case CHAT_MSG_PARTY:
            case CHAT_MSG_RAID:
            case CHAT_MSG_GUILD:
            case CHAT_MSG_BATTLEGROUND:
            case CHAT_MSG_WHISPER:
                // check if addon messages are disabled
                if (!sWorld->getBoolConfig(CONFIG_ADDON_CHANNEL))
                {
                    recvData.rfinish();
                    return;
                }
                break;
            default:
                LOG_ERROR("network", "Player {} ({}) sent a chatmessage with an invalid language/message type combination",
                               GetPlayer()->GetName(), GetPlayer()->GetGUID().ToString());

                recvData.rfinish();
                return;
        }
    }
    else
    {
        // send in universal language if player in .gmon mode (ignore spell effects)
        if (sender->IsGameMaster())
            lang = LANG_UNIVERSAL;
        else
        {
            // send in universal language in two side iteration allowed mode
            if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHAT))
                lang = LANG_UNIVERSAL;
            else
            {
                switch (type)
                {
                    case CHAT_MSG_PARTY:
                    case CHAT_MSG_PARTY_LEADER:
                    case CHAT_MSG_RAID:
                    case CHAT_MSG_RAID_LEADER:
                    case CHAT_MSG_RAID_WARNING:
                        // allow two side chat at group channel if two side group allowed
                        if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP))
                            lang = LANG_UNIVERSAL;
                        break;
                    case CHAT_MSG_GUILD:
                    case CHAT_MSG_OFFICER:
                        // allow two side chat at guild channel if two side guild allowed
                        if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GUILD))
                            lang = LANG_UNIVERSAL;
                        break;
                }
            }
            // Overwritten by SPELL_AURA_MOD_LANGUAGE auras (Affects only Say and Yell)
            Unit::AuraEffectList const& ModLangAuras = sender->GetAuraEffectsByType(SPELL_AURA_MOD_LANGUAGE);
            if (!ModLangAuras.empty() && (type == CHAT_MSG_SAY || type == CHAT_MSG_YELL))
                lang = ModLangAuras.front()->GetMiscValue();
        }

        if (type != CHAT_MSG_AFK && type != CHAT_MSG_DND)
            sender->UpdateSpeakTime(lang == LANG_ADDON ? Player::ChatFloodThrottle::ADDON : Player::ChatFloodThrottle::REGULAR);
    }

    std::string to, channel, msg;
    bool ignoreChecks = false;
    switch (type)
    {
        case CHAT_MSG_SAY:
        case CHAT_MSG_EMOTE:
        case CHAT_MSG_YELL:
        case CHAT_MSG_PARTY:
        case CHAT_MSG_PARTY_LEADER:
        case CHAT_MSG_GUILD:
        case CHAT_MSG_OFFICER:
        case CHAT_MSG_RAID:
        case CHAT_MSG_RAID_LEADER:
        case CHAT_MSG_RAID_WARNING:
        case CHAT_MSG_BATTLEGROUND:
        case CHAT_MSG_BATTLEGROUND_LEADER:
            msg = recvData.ReadCString(lang != LANG_ADDON);
            break;
        case CHAT_MSG_WHISPER:
            recvData >> to;
            msg = recvData.ReadCString(lang != LANG_ADDON);
            break;
        case CHAT_MSG_CHANNEL:
            recvData >> channel;
            msg = recvData.ReadCString(lang != LANG_ADDON);
            break;
        case CHAT_MSG_AFK:
        case CHAT_MSG_DND:
            msg = recvData.ReadCString(lang != LANG_ADDON);
            ignoreChecks = true;
            break;
    }

    // Our Warden module also uses SendAddonMessage as a way to communicate Lua check results to the server, see if this is that
    if (type == CHAT_MSG_GUILD && lang == LANG_ADDON && _warden && _warden->ProcessLuaCheckResponse(msg))
    {
        return;
    }

    // pussywizard:
    if (msg.length() > 255 || (lang != LANG_ADDON && msg.find("|0") != std::string::npos))
        return;

    if (!ignoreChecks)
    {
        if (msg.empty())
            return;

        if (ChatHandler(this).ParseCommands(msg.c_str()))
            return;

        if (!_player->CanSpeak())
        {
            std::string timeStr = secsToTimeString(m_muteTime - GameTime::GetGameTime().count());
            SendNotification(GetAcoreString(LANG_WAIT_BEFORE_SPEAKING), timeStr.c_str());
            return;
        }
    }

    // do message validity checks
    if (lang != LANG_ADDON)
    {
        // cut at the first newline or carriage return
        std::string::size_type pos = msg.find_first_of("\n\r");

        if (pos == 0)
        {
            return;
        }
        else if (pos != std::string::npos)
        {
            msg.erase(pos);
        }

        // abort on any sort of nasty character
        for (uint8 c : msg)
        {
            if (isNasty(c))
            {
                LOG_ERROR("network", "Player {} {} sent a message containing invalid character {} - blocked", GetPlayer()->GetName(),
                    GetPlayer()->GetGUID().ToString(), uint8(c));
                return;
            }
        }

        // collapse multiple spaces into one
        if (sWorld->getBoolConfig(CONFIG_CHAT_FAKE_MESSAGE_PREVENTING))
        {
            auto end = std::unique(msg.begin(), msg.end(), [](char c1, char c2) { return (c1 == ' ') && (c2 == ' '); });
            msg.erase(end, msg.end());
        }

        // Validate hyperlinks
        if (!ValidateHyperlinksAndMaybeKick(msg))
        {
            return;
        }
    }

    else
    {
        ++_addonMessageReceiveCount;
    }

    sScriptMgr->OnBeforeSendChatMessage(_player, type, lang, msg);

    switch (type)
    {
        case CHAT_MSG_SAY:
        case CHAT_MSG_EMOTE:
        case CHAT_MSG_YELL:
            {
                // Prevent cheating
                if (!sender->IsAlive())
                    return;

                if (sender->GetLevel() < sWorld->getIntConfig(CONFIG_CHAT_SAY_LEVEL_REQ))
                {
                    SendNotification(GetAcoreString(LANG_SAY_REQ), sWorld->getIntConfig(CONFIG_CHAT_SAY_LEVEL_REQ));
                    return;
                }

                if (type == CHAT_MSG_SAY)
                    sender->Say(msg, Language(lang));
                else if (type == CHAT_MSG_EMOTE)
                    sender->TextEmote(msg);
                else if (type == CHAT_MSG_YELL)
                    sender->Yell(msg, Language(lang));
            }
            break;
        case CHAT_MSG_WHISPER:
            {
                if (!normalizePlayerName(to))
                {
                    SendPlayerNotFoundNotice(to);
                    break;
                }

                Player* receiver = ObjectAccessor::FindPlayerByName(to, false);
                bool senderIsPlayer = AccountMgr::IsPlayerAccount(GetSecurity());
                bool receiverIsPlayer = AccountMgr::IsPlayerAccount(receiver ? receiver->GetSession()->GetSecurity() : SEC_PLAYER);

                if (sender->GetLevel() < sWorld->getIntConfig(CONFIG_CHAT_WHISPER_LEVEL_REQ) && receiver != sender)
                {
                    SendNotification(GetAcoreString(LANG_WHISPER_REQ), sWorld->getIntConfig(CONFIG_CHAT_WHISPER_LEVEL_REQ));
                    return;
                }

                if (!receiver || (senderIsPlayer && !receiverIsPlayer && !receiver->isAcceptWhispers() && !receiver->IsInWhisperWhiteList(sender->GetGUID())))
                {
                    SendPlayerNotFoundNotice(to);
                    return;
                }

                if (!sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHAT) && senderIsPlayer && receiverIsPlayer)
                    if (GetPlayer()->GetTeamId() != receiver->GetTeamId())
                    {
                        SendWrongFactionNotice();
                        return;
                    }

                // pussywizard: optimization
                if (GetPlayer()->HasAura(1852) && !receiver->IsGameMaster())
                {
                    SendNotification(GetAcoreString(LANG_GM_SILENCE), GetPlayer()->GetName().c_str());
                    return;
                }

                // If player is a Gamemaster and doesn't accept whisper, we auto-whitelist every player that the Gamemaster is talking to
                if (!senderIsPlayer && !sender->isAcceptWhispers() && !sender->IsInWhisperWhiteList(receiver->GetGUID()))
                    sender->AddWhisperWhiteList(receiver->GetGUID());

                if (!sScriptMgr->CanPlayerUseChat(GetPlayer(), type, lang, msg, receiver))
                {
                    return;
                }

                sScriptMgr->OnPlayerChat(GetPlayer(), type, lang, msg, receiver);

                GetPlayer()->Whisper(msg, Language(lang), receiver);
            }
            break;
        case CHAT_MSG_PARTY:
        case CHAT_MSG_PARTY_LEADER:
            {
                // if player is in battleground, he cannot say to battleground members by /p
                Group* group = GetPlayer()->GetOriginalGroup();
                if (!group)
                {
                    group = sender->GetGroup();
                    if (!group || group->isBGGroup())
                        return;
                }

                if (type == CHAT_MSG_PARTY_LEADER && !group->IsLeader(sender->GetGUID()))
                    return;

                if (!sScriptMgr->CanPlayerUseChat(GetPlayer(), type, lang, msg, group))
                {
                    return;
                }

                sScriptMgr->OnPlayerChat(GetPlayer(), type, lang, msg, group);

                WorldPacket data;
                ChatHandler::BuildChatPacket(data, ChatMsg(type), Language(lang), sender, nullptr, msg);
                group->BroadcastPacket(&data, false, group->GetMemberGroup(GetPlayer()->GetGUID()));
            }
            break;
        case CHAT_MSG_GUILD:
            {
                if (GetPlayer()->GetGuildId())
                {
                    if (Guild* guild = sGuildMgr->GetGuildById(GetPlayer()->GetGuildId()))
                    {
                        if (!sScriptMgr->CanPlayerUseChat(GetPlayer(), type, lang, msg, guild))
                        {
                            return;
                        }

                        sScriptMgr->OnPlayerChat(GetPlayer(), type, lang, msg, guild);

                        guild->BroadcastToGuild(this, false, msg, lang == LANG_ADDON ? LANG_ADDON : LANG_UNIVERSAL);
                    }
                    else
                    {
                        sScriptMgr->OnPlayerChat(GetPlayer(), type, lang, msg);
                    }
                }
            }
            break;
        case CHAT_MSG_OFFICER:
            {
                if (GetPlayer()->GetGuildId())
                {
                    if (Guild* guild = sGuildMgr->GetGuildById(GetPlayer()->GetGuildId()))
                    {
                        if (!sScriptMgr->CanPlayerUseChat(GetPlayer(), type, lang, msg, guild))
                        {
                            return;
                        }

                        sScriptMgr->OnPlayerChat(GetPlayer(), type, lang, msg, guild);

                        guild->BroadcastToGuild(this, true, msg, lang == LANG_ADDON ? LANG_ADDON : LANG_UNIVERSAL);
                    }
                }
            }
            break;
        case CHAT_MSG_RAID:
            {
                // if player is in battleground, he cannot say to battleground members by /ra
                Group* group = GetPlayer()->GetOriginalGroup();
                if (!group)
                {
                    group = GetPlayer()->GetGroup();
                    if (!group || group->isBGGroup() || !group->isRaidGroup())
                        return;
                }

                if (!sScriptMgr->CanPlayerUseChat(GetPlayer(), type, lang, msg, group))
                {
                    return;
                }

                sScriptMgr->OnPlayerChat(GetPlayer(), type, lang, msg, group);

                WorldPacket data;
                ChatHandler::BuildChatPacket(data, CHAT_MSG_RAID, Language(lang), sender, nullptr, msg);
                group->BroadcastPacket(&data, false);
            }
            break;
        case CHAT_MSG_RAID_LEADER:
            {
                // if player is in battleground, he cannot say to battleground members by /ra
                Group* group = GetPlayer()->GetOriginalGroup();
                if (!group)
                {
                    group = GetPlayer()->GetGroup();
                    if (!group || group->isBGGroup() || !group->isRaidGroup() || !group->IsLeader(sender->GetGUID()))
                        return;
                }

                if (!sScriptMgr->CanPlayerUseChat(GetPlayer(), type, lang, msg, group))
                {
                    return;
                }

                sScriptMgr->OnPlayerChat(GetPlayer(), type, lang, msg, group);

                WorldPacket data;
                ChatHandler::BuildChatPacket(data, CHAT_MSG_RAID_LEADER, Language(lang), sender, nullptr, msg);
                group->BroadcastPacket(&data, false);
            }
            break;
        case CHAT_MSG_RAID_WARNING:
            {
                Group* group = GetPlayer()->GetGroup();
                if (!group || !group->isRaidGroup() || !(group->IsLeader(GetPlayer()->GetGUID()) || group->IsAssistant(GetPlayer()->GetGUID())) || group->isBGGroup())
                    return;

                if (!sScriptMgr->CanPlayerUseChat(GetPlayer(), type, lang, msg, group))
                {
                    return;
                }

                sScriptMgr->OnPlayerChat(GetPlayer(), type, lang, msg, group);

                // In battleground, raid warning is sent only to players in battleground - code is ok
                WorldPacket data;
                ChatHandler::BuildChatPacket(data, CHAT_MSG_RAID_WARNING, Language(lang), sender, nullptr, msg);
                group->BroadcastPacket(&data, false);
            }
            break;
        case CHAT_MSG_BATTLEGROUND:
            {
                //battleground raid is always in Player->GetGroup(), never in GetOriginalGroup()
                Group* group = GetPlayer()->GetGroup();
                if (!group || !group->isBGGroup())
                    return;

                if (!sScriptMgr->CanPlayerUseChat(GetPlayer(), type, lang, msg, group))
                {
                    return;
                }

                sScriptMgr->OnPlayerChat(GetPlayer(), type, lang, msg, group);

                WorldPacket data;
                ChatHandler::BuildChatPacket(data, CHAT_MSG_BATTLEGROUND, Language(lang), sender, nullptr, msg);
                group->BroadcastPacket(&data, false);
            }
            break;
        case CHAT_MSG_BATTLEGROUND_LEADER:
            {
                // battleground raid is always in Player->GetGroup(), never in GetOriginalGroup()
                Group* group = GetPlayer()->GetGroup();
                if (!group || !group->isBGGroup() || !group->IsLeader(GetPlayer()->GetGUID()))
                    return;

                if (!sScriptMgr->CanPlayerUseChat(GetPlayer(), type, lang, msg, group))
                {
                    return;
                }

                sScriptMgr->OnPlayerChat(GetPlayer(), type, lang, msg, group);

                WorldPacket data;
                ChatHandler::BuildChatPacket(data, CHAT_MSG_BATTLEGROUND_LEADER, Language(lang), sender, nullptr, msg);
                group->BroadcastPacket(&data, false);
            }
            break;
        case CHAT_MSG_CHANNEL:
            {
                if (AccountMgr::IsPlayerAccount(GetSecurity()))
                {
                    if (sender->GetLevel() < sWorld->getIntConfig(CONFIG_CHAT_CHANNEL_LEVEL_REQ))
                    {
                        SendNotification(GetAcoreString(LANG_CHANNEL_REQ), sWorld->getIntConfig(CONFIG_CHAT_CHANNEL_LEVEL_REQ));
                        return;
                    }
                }

                if (ChannelMgr* cMgr = ChannelMgr::forTeam(sender->GetTeamId()))
                {
                    if (Channel* chn = cMgr->GetChannel(channel, sender))
                    {
                        if (!sScriptMgr->CanPlayerUseChat(sender, type, lang, msg, chn))
                        {
                            return;
                        }

                        sScriptMgr->OnPlayerChat(sender, type, lang, msg, chn);

                        chn->Say(sender->GetGUID(), msg.c_str(), lang);
                    }
                }
            }
            break;
        case CHAT_MSG_AFK:
            {
                if (!sender->IsInCombat())
                {
                    if (sender->isAFK())                       // Already AFK
                    {
                        if (msg.empty())
                            sender->ToggleAFK();               // Remove AFK
                        else
                            sender->autoReplyMsg = msg;        // Update message
                    }
                    else                                        // New AFK mode
                    {
                        sender->autoReplyMsg = msg.empty() ? GetAcoreString(LANG_PLAYER_AFK_DEFAULT) : msg;

                        if (sender->isDND())
                            sender->ToggleDND();

                        sender->ToggleAFK();
                    }

                    if (!sScriptMgr->CanPlayerUseChat(sender, type, lang, msg))
                    {
                        return;
                    }

                    sScriptMgr->OnPlayerChat(sender, type, lang, msg);
                }
                break;
            }
        case CHAT_MSG_DND:
            {
                if (sender->isDND())                           // Already DND
                {
                    if (msg.empty())
                        sender->ToggleDND();                   // Remove DND
                    else
                        sender->autoReplyMsg = msg;            // Update message
                }
                else                                            // New DND mode
                {
                    sender->autoReplyMsg = msg.empty() ? GetAcoreString(LANG_PLAYER_DND_DEFAULT) : msg;

                    if (sender->isAFK())
                        sender->ToggleAFK();

                    sender->ToggleDND();
                }

                if (!sScriptMgr->CanPlayerUseChat(sender, type, lang, msg))
                {
                    return;
                }

                sScriptMgr->OnPlayerChat(sender, type, lang, msg);

                break;
            }
        default:
            LOG_ERROR("network.opcode", "CHAT: unknown message type {}, lang: {}", type, lang);
            break;
    }
}

void WorldSession::HandleEmoteOpcode(WorldPackets::Chat::EmoteClient& packet)
{
    if (GetPlayer()->IsSpectator())
        return;

    uint32 emoteId = packet.EmoteID;

    // restrict to the only emotes hardcoded in client
    if (emoteId != EMOTE_ONESHOT_NONE && emoteId != EMOTE_ONESHOT_WAVE)
        return;

    if (!_player->IsAlive() || _player->HasUnitState(UNIT_STATE_DIED))
        return;

    sScriptMgr->OnPlayerEmote(_player, emoteId);
    _player->HandleEmoteCommand(emoteId);
}

namespace Acore
{
    class EmoteChatBuilder
    {
    public:
        EmoteChatBuilder(Player const& player, uint32 text_emote, uint32 emote_num, Unit const* target)
            : i_player(player), i_text_emote(text_emote), i_emote_num(emote_num), i_target(target) {}

        void operator()(WorldPacket& data, LocaleConstant loc_idx)
        {
            std::string const name(i_target ? i_target->GetNameForLocaleIdx(loc_idx) : "");
            uint32 namlen = name.size();

            data.Initialize(SMSG_TEXT_EMOTE, 20 + namlen);
            data << i_player.GetGUID();
            data << uint32(i_text_emote);
            data << uint32(i_emote_num);
            data << uint32(namlen);
            if (namlen > 1)
                data << name;
            else
                data << uint8(0x00);
        }

    private:
        Player const& i_player;
        uint32        i_text_emote;
        uint32        i_emote_num;
        Unit const*   i_target;
    };
}                                                           // namespace Acore

void WorldSession::HandleTextEmoteOpcode(WorldPacket& recvData)
{
    if (!GetPlayer()->IsAlive())
        return;

    GetPlayer()->UpdateSpeakTime(Player::ChatFloodThrottle::REGULAR);

    if (!GetPlayer()->CanSpeak())
    {
        std::string timeStr = secsToTimeString(m_muteTime - GameTime::GetGameTime().count());
        SendNotification(GetAcoreString(LANG_WAIT_BEFORE_SPEAKING), timeStr.c_str());
        return;
    }

    if (GetPlayer()->IsSpectator())
        return;

    uint32 text_emote, emoteNum;
    ObjectGuid guid;

    recvData >> text_emote;
    recvData >> emoteNum;
    recvData >> guid;

    sScriptMgr->OnPlayerTextEmote(GetPlayer(), text_emote, emoteNum, guid);

    EmotesTextEntry const* em = sEmotesTextStore.LookupEntry(text_emote);
    if (!em)
        return;

    uint32 emote_anim = em->textid;

    switch (emote_anim)
    {
        case EMOTE_STATE_SLEEP:
        case EMOTE_STATE_SIT:
        case EMOTE_STATE_KNEEL:
        case EMOTE_ONESHOT_NONE:
            break;
        case EMOTE_STATE_DANCE:
            GetPlayer()->SetUInt32Value(UNIT_NPC_EMOTESTATE, emote_anim);
            break;
        default:
            // Only allow text-emotes for "dead" entities (feign death included)
            if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
                break;
            GetPlayer()->HandleEmoteCommand(emote_anim);
            break;
    }

    Unit* unit = ObjectAccessor::GetUnit(*_player, guid);

    CellCoord p = Acore::ComputeCellCoord(GetPlayer()->GetPositionX(), GetPlayer()->GetPositionY());

    Cell cell(p);
    cell.SetNoCreate();

    Acore::EmoteChatBuilder emote_builder(*GetPlayer(), text_emote, emoteNum, unit);
    Acore::LocalizedPacketDo<Acore::EmoteChatBuilder > emote_do(emote_builder);
    Acore::PlayerDistWorker<Acore::LocalizedPacketDo<Acore::EmoteChatBuilder > > emote_worker(GetPlayer(), sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_TEXTEMOTE), emote_do);
    TypeContainerVisitor<Acore::PlayerDistWorker<Acore::LocalizedPacketDo<Acore::EmoteChatBuilder> >, WorldTypeMapContainer> message(emote_worker);
    cell.Visit(p, message, *GetPlayer()->GetMap(), *GetPlayer(), sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_TEXTEMOTE));

    GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_DO_EMOTE, text_emote, 0, unit);

    //Send scripted event call
    if (unit && unit->GetTypeId() == TYPEID_UNIT && ((Creature*)unit)->AI())
        ((Creature*)unit)->AI()->ReceiveEmote(GetPlayer(), text_emote);
}

void WorldSession::HandleChatIgnoredOpcode(WorldPacket& recvData)
{
    ObjectGuid iguid;
    uint8 unk;

    recvData >> iguid;
    recvData >> unk;                                       // probably related to spam reporting

    Player* player = ObjectAccessor::FindConnectedPlayer(iguid);
    if (!player)
        return;

    WorldPacket data;
    ChatHandler::BuildChatPacket(data, CHAT_MSG_IGNORED, LANG_UNIVERSAL, _player, _player, GetPlayer()->GetName());
    player->GetSession()->SendPacket(&data);
}

void WorldSession::HandleChannelDeclineInvite(WorldPacket& recvPacket)
{
    // used only with EXTRA_LOGS
    (void)recvPacket;

    LOG_DEBUG("network", "Opcode {}", recvPacket.GetOpcode());
}

void WorldSession::SendPlayerNotFoundNotice(std::string const& name)
{
    WorldPacket data(SMSG_CHAT_PLAYER_NOT_FOUND, name.size() + 1);
    data << name;
    SendPacket(&data);
}

void WorldSession::SendPlayerAmbiguousNotice(std::string const& name)
{
    WorldPacket data(SMSG_CHAT_PLAYER_AMBIGUOUS, name.size() + 1);
    data << name;
    SendPacket(&data);
}

void WorldSession::SendWrongFactionNotice()
{
    WorldPacket data(SMSG_CHAT_WRONG_FACTION, 0);
    SendPacket(&data);
}

void WorldSession::SendChatRestrictedNotice(ChatRestrictionType restriction)
{
    WorldPacket data(SMSG_CHAT_RESTRICTED, 1);
    data << uint8(restriction);
    SendPacket(&data);
}
