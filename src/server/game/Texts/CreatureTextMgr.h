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

#ifndef ACORE_CREATURE_TEXT_MGR_H
#define ACORE_CREATURE_TEXT_MGR_H

#include "Creature.h"
#include "GridNotifiers.h"
#include "ObjectAccessor.h"
#include "SharedDefines.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"

enum CreatureTextRange
{
    TEXT_RANGE_NORMAL   = 0,
    TEXT_RANGE_AREA     = 1,
    TEXT_RANGE_ZONE     = 2,
    TEXT_RANGE_MAP      = 3,
    TEXT_RANGE_WORLD    = 4
};

struct CreatureTextEntry
{
    uint32 entry;
    uint8 group;
    uint8 id;
    std::string text;
    ChatMsg type;
    Language lang;
    float probability;
    Emote emote;
    uint32 duration;
    uint32 sound;
    CreatureTextRange TextRange;
    uint32 BroadcastTextId;
};

struct CreatureTextLocale
{
    std::vector<std::string> Text;
};

struct CreatureTextId
{
    CreatureTextId(uint32 e, uint32 g, uint32 i) : entry(e), textGroup(g), textId(i)
    {
    }

    bool operator<(CreatureTextId const& right) const
    {
        return memcmp(this, &right, sizeof(CreatureTextId)) < 0;
    }

    uint32 entry;
    uint32 textGroup;
    uint32 textId;
};

typedef std::vector<CreatureTextEntry> CreatureTextGroup;              // texts in a group
typedef std::unordered_map<uint8, CreatureTextGroup> CreatureTextHolder;    // groups for a creature by groupid
typedef std::unordered_map<uint32, CreatureTextHolder> CreatureTextMap;     // all creatures by entry

typedef std::map<CreatureTextId, CreatureTextLocale> LocaleCreatureTextMap;

class CreatureTextMgr
{
    CreatureTextMgr() { }

public:
    static CreatureTextMgr* instance();

    ~CreatureTextMgr() { }
    void LoadCreatureTexts();
    void LoadCreatureTextLocales();
    CreatureTextMap  const& GetTextMap() const { return mTextMap; }

    void SendSound(Creature* source, uint32 sound, ChatMsg msgType, WorldObject const* target, CreatureTextRange range, TeamId teamId, bool gmOnly);
    void SendEmote(Unit* source, uint32 emote);

    //if sent, returns the 'duration' of the text else 0 if error
    uint32 SendChat(Creature* source, uint8 textGroup, WorldObject const* target = nullptr, ChatMsg msgType = CHAT_MSG_ADDON, Language language = LANG_ADDON, CreatureTextRange range = TEXT_RANGE_NORMAL, uint32 sound = 0, TeamId teamId = TEAM_NEUTRAL, bool gmOnly = false, Player* srcPlr = nullptr);
    bool TextExist(uint32 sourceEntry, uint8 textGroup);
    std::string GetLocalizedChatString(uint32 entry, uint8 gender, uint8 textGroup, uint32 id, LocaleConstant locale) const;

    template<class Builder> void SendChatPacket(WorldObject* source, Builder const& builder, ChatMsg msgType, WorldObject const* target = nullptr, CreatureTextRange range = TEXT_RANGE_NORMAL, TeamId teamId = TEAM_NEUTRAL, bool gmOnly = false) const;

private:
    void SendNonChatPacket(WorldObject* source, WorldPacket const* data, ChatMsg msgType, WorldObject const* target, CreatureTextRange range, TeamId teamId, bool gmOnly) const;
    float GetRangeForChatType(ChatMsg msgType) const;

    CreatureTextMap mTextMap;
    LocaleCreatureTextMap mLocaleTextMap;
};

#define sCreatureTextMgr CreatureTextMgr::instance()

template<class Builder>
class CreatureTextLocalizer
{
public:
    CreatureTextLocalizer(Builder const& builder, ChatMsg msgType) : _builder(builder), _msgType(msgType)
    {
        _packetCache.resize(TOTAL_LOCALES, nullptr);
    }

    ~CreatureTextLocalizer()
    {
        for (std::size_t i = 0; i < _packetCache.size(); ++i)
        {
            if (_packetCache[i])
                delete _packetCache[i]->first;
            delete _packetCache[i];
        }
    }

    void operator()(Player* player)
    {
        LocaleConstant loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
        WorldPacket* messageTemplate;
        std::size_t whisperGUIDpos;

        // create if not cached yet
        if (!_packetCache[loc_idx])
        {
            messageTemplate = new WorldPacket();
            whisperGUIDpos = _builder(messageTemplate, loc_idx);
            _packetCache[loc_idx] = new std::pair<WorldPacket*, std::size_t>(messageTemplate, whisperGUIDpos);
        }
        else
        {
            messageTemplate = _packetCache[loc_idx]->first;
            whisperGUIDpos = _packetCache[loc_idx]->second;
        }

        WorldPacket data(*messageTemplate);
        switch (_msgType)
        {
            case CHAT_MSG_MONSTER_WHISPER:
            case CHAT_MSG_RAID_BOSS_WHISPER:
                data.put<uint64>(whisperGUIDpos, player->GetGUID().GetRawValue());
                break;
            default:
                break;
        }

        player->SendDirectMessage(&data);
    }

private:
    std::vector<std::pair<WorldPacket*, std::size_t>* > _packetCache;
    Builder const& _builder;
    ChatMsg _msgType;
};

template<class Builder>
void CreatureTextMgr::SendChatPacket(WorldObject* source, Builder const& builder, ChatMsg msgType, WorldObject const* target /*= nullptr*/, CreatureTextRange range /*= TEXT_RANGE_NORMAL*/, TeamId teamId /*= TEAM_NEUTRAL*/, bool gmOnly /*= false*/) const
{
    if (!source)
        return;

    CreatureTextLocalizer<Builder> localizer(builder, msgType);

    switch (msgType)
    {
        case CHAT_MSG_MONSTER_WHISPER:
        case CHAT_MSG_RAID_BOSS_WHISPER:
            {
                if (range == TEXT_RANGE_NORMAL) // ignores team and GM only
                {
                    if (!target || !target->IsPlayer())
                        return;

                    localizer(const_cast<Player*>(target->ToPlayer()));
                    return;
                }
                break;
            }
        default:
            break;
    }

    switch (range)
    {
        case TEXT_RANGE_AREA:
            {
                uint32 areaId = source->GetAreaId();
                Map::PlayerList const& players = source->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    if (itr->GetSource()->GetAreaId() == areaId && (teamId == TEAM_NEUTRAL || itr->GetSource()->GetTeamId() == teamId) && (!gmOnly || itr->GetSource()->IsGameMaster()))
                        localizer(itr->GetSource());
                return;
            }
        case TEXT_RANGE_ZONE:
            {
                uint32 zoneId = source->GetZoneId();
                Map::PlayerList const& players = source->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    if (itr->GetSource()->GetZoneId() == zoneId && (teamId == TEAM_NEUTRAL || itr->GetSource()->GetTeamId() == teamId) && (!gmOnly || itr->GetSource()->IsGameMaster()))
                        localizer(itr->GetSource());
                return;
            }
        case TEXT_RANGE_MAP:
            {
                Map::PlayerList const& players = source->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    if ((teamId == TEAM_NEUTRAL || itr->GetSource()->GetTeamId() == teamId) && (!gmOnly || itr->GetSource()->IsGameMaster()))
                        localizer(itr->GetSource());
                return;
            }
        case TEXT_RANGE_WORLD:
            {
                WorldSessionMgr::SessionMap const& smap = sWorldSessionMgr->GetAllSessions();
                for (WorldSessionMgr::SessionMap::const_iterator itr = smap.begin(); itr != smap.end(); ++itr)
                    if (Player* player = itr->second->GetPlayer())
                        if ((teamId == TEAM_NEUTRAL || player->GetTeamId() == teamId) && (!gmOnly || player->IsGameMaster()))
                            localizer(player);
                return;
            }
        case TEXT_RANGE_NORMAL:
        default:
            break;
    }

    float dist = GetRangeForChatType(msgType);
    // xinef: hack for boss emote
    if (msgType == CHAT_MSG_RAID_BOSS_EMOTE && source->GetMap()->IsDungeon())
        dist = 250.0f;

    Acore::PlayerDistWorker<CreatureTextLocalizer<Builder> > worker(source, dist, localizer);
    Cell::VisitObjects(source, worker, dist);
}

#endif
