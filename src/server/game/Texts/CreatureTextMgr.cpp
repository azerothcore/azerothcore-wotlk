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

#include "CreatureTextMgr.h"
#include "Cell.h"
#include "CellImpl.h"
#include "Chat.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "GridNotifiers.h"
#include "MiscPackets.h"
#include "ObjectMgr.h"

class CreatureTextBuilder
{
public:
    CreatureTextBuilder(WorldObject* obj, uint8 gender, ChatMsg msgtype, uint8 textGroup, uint32 id, uint32 language, WorldObject const* target)
        : _source(obj), _gender(gender), _msgType(msgtype), _textGroup(textGroup), _textId(id), _language(language), _target(target) { }

    std::size_t operator()(WorldPacket* data, LocaleConstant locale) const
    {
        std::string const& text = sCreatureTextMgr->GetLocalizedChatString(_source->GetEntry(), _gender, _textGroup, _textId, locale);

        return ChatHandler::BuildChatPacket(*data, _msgType, Language(_language), _source, _target, text, 0, "", locale);
    }

private:
    WorldObject* _source;
    uint8 _gender;
    ChatMsg _msgType;
    uint8 _textGroup;
    uint32 _textId;
    uint32 _language;
    WorldObject const* _target;
};

class PlayerTextBuilder
{
public:
    PlayerTextBuilder(WorldObject* obj, WorldObject* speaker, uint8 gender, ChatMsg msgtype, uint8 textGroup, uint32 id, uint32 language, WorldObject const* target)
        : _source(obj), _talker(speaker), _gender(gender), _msgType(msgtype), _textGroup(textGroup), _textId(id), _language(language), _target(target) { }

    std::size_t operator()(WorldPacket* data, LocaleConstant locale) const
    {
        std::string const& text = sCreatureTextMgr->GetLocalizedChatString(_source->GetEntry(), _gender, _textGroup, _textId, locale);

        return ChatHandler::BuildChatPacket(*data, _msgType, Language(_language), _talker, _target, text, 0, "", locale);
    }

private:
    WorldObject* _source;
    WorldObject* _talker;
    uint8 _gender;
    ChatMsg _msgType;
    uint8 _textGroup;
    uint32 _textId;
    uint32 _language;
    WorldObject const* _target;
};

CreatureTextMgr* CreatureTextMgr::instance()
{
    static CreatureTextMgr instance;
    return &instance;
}

void CreatureTextMgr::LoadCreatureTexts()
{
    uint32 oldMSTime = getMSTime();

    mTextMap.clear(); // for reload case
    mTextRepeatMap.clear(); //reset all currently used temp texts

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_CREATURE_TEXT);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 ceature texts. DB table `creature_texts` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 textCount = 0;

    do
    {
        Field* fields = result->Fetch();
        CreatureTextEntry temp;

        temp.entry           = fields[0].Get<uint32>();
        temp.group           = fields[1].Get<uint8>();
        temp.id              = fields[2].Get<uint8>();
        temp.text            = fields[3].Get<std::string>();
        temp.type            = ChatMsg(fields[4].Get<uint8>());
        temp.lang            = Language(fields[5].Get<uint8>());
        temp.probability     = fields[6].Get<float>();
        temp.emote           = Emote(fields[7].Get<uint32>());
        temp.duration        = fields[8].Get<uint32>();
        temp.sound           = fields[9].Get<uint32>();
        temp.BroadcastTextId = fields[10].Get<uint32>();
        temp.TextRange       = CreatureTextRange(fields[11].Get<uint8>());

        if (temp.sound)
        {
            if (!sSoundEntriesStore.LookupEntry(temp.sound))
            {
                LOG_ERROR("sql.sql", "CreatureTextMgr: Entry {}, Group {} in table `creature_texts` has Sound {} but sound does not exist.", temp.entry, temp.group, temp.sound);
                temp.sound = 0;
            }
        }
        if (!GetLanguageDescByID(temp.lang))
        {
            LOG_ERROR("sql.sql", "CreatureTextMgr: Entry {}, Group {} in table `creature_texts` using Language {} but Language does not exist.", temp.entry, temp.group, uint32(temp.lang));
            temp.lang = LANG_UNIVERSAL;
        }
        if (temp.type >= MAX_CHAT_MSG_TYPE)
        {
            LOG_ERROR("sql.sql", "CreatureTextMgr: Entry {}, Group {} in table `creature_texts` has Type {} but this Chat Type does not exist.", temp.entry, temp.group, uint32(temp.type));
            temp.type = CHAT_MSG_SAY;
        }
        if (temp.emote)
        {
            if (!sEmotesStore.LookupEntry(temp.emote))
            {
                LOG_ERROR("sql.sql", "CreatureTextMgr: Entry {}, Group {} in table `creature_texts` has Emote {} but emote does not exist.", temp.entry, temp.group, uint32(temp.emote));
                temp.emote = EMOTE_ONESHOT_NONE;
            }
        }
        if (temp.BroadcastTextId)
        {
            if (!sObjectMgr->GetBroadcastText(temp.BroadcastTextId))
            {
                LOG_ERROR("sql.sql", "CreatureTextMgr: Entry {}, Group {}, Id {} in table `creature_text` has non-existing or incompatible BroadcastTextId {}.", temp.entry, temp.group, temp.id, temp.BroadcastTextId);
                temp.BroadcastTextId = 0;
            }
        }
        if (temp.TextRange > TEXT_RANGE_WORLD)
        {
            LOG_ERROR("sql.sql", "CreatureTextMgr: Entry {}, Group {}, Id {} in table `creature_text` has incorrect TextRange {}.", temp.entry, temp.group, temp.id, temp.TextRange);
            temp.TextRange = TEXT_RANGE_NORMAL;
        }

        //add the text into our entry's group
        mTextMap[temp.entry][temp.group].push_back(temp);

        ++textCount;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creature Texts For {} Creatures in {} ms", textCount, mTextMap.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void CreatureTextMgr::LoadCreatureTextLocales()
{
    uint32 oldMSTime = getMSTime();

    mLocaleTextMap.clear(); // for reload case

    QueryResult result = WorldDatabase.Query("SELECT CreatureId, GroupId, ID, Locale, Text FROM creature_text_locale");

    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 CreatureId           = fields[0].Get<uint32>();
        uint32 GroupId              = fields[1].Get<uint8>();
        uint32 ID                   = fields[2].Get<uint8>();

        LocaleConstant locale = GetLocaleByName(fields[3].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        CreatureTextLocale& data = mLocaleTextMap[CreatureTextId(CreatureId, GroupId, ID)];
        ObjectMgr::AddLocaleString(fields[4].Get<std::string>(), locale, data.Text);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creature Text Locale in {} ms", uint32(mLocaleTextMap.size()), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

uint32 CreatureTextMgr::SendChat(Creature* source, uint8 textGroup, WorldObject const* target /*= nullptr*/, ChatMsg msgType /*= CHAT_MSG_ADDON*/, Language language /*= LANG_ADDON*/, CreatureTextRange range /*= TEXT_RANGE_NORMAL*/, uint32 sound /*= 0*/, TeamId teamId /*= TEAM_NEUTRAL*/, bool gmOnly /*= false*/, Player* srcPlr /*= nullptr*/)
{
    if (!source)
        return 0;

    CreatureTextMap::const_iterator sList = mTextMap.find(source->GetEntry());
    if (sList == mTextMap.end())
    {
        LOG_ERROR("sql.sql", "CreatureTextMgr: Could not find Text for Creature({}) Entry {} in 'creature_text' table. Ignoring.", source->GetName(), source->GetEntry());
        return 0;
    }

    CreatureTextHolder const& textHolder = sList->second;
    CreatureTextHolder::const_iterator itr = textHolder.find(textGroup);
    if (itr == textHolder.end())
    {
        LOG_ERROR("sql.sql", "CreatureTextMgr: Could not find TextGroup {} for Creature {} ({}). Ignoring.",
            uint32(textGroup), source->GetName(), source->GetGUID().ToString());
        return 0;
    }

    CreatureTextGroup const& textGroupContainer = itr->second;  //has all texts in the group
    CreatureTextRepeatIds repeatGroup = GetRepeatGroup(source, textGroup);//has all textIDs from the group that were already said
    CreatureTextGroup tempGroup;//will use this to talk after sorting repeatGroup

    for (CreatureTextGroup::const_iterator giter = textGroupContainer.begin(); giter != textGroupContainer.end(); ++giter)
        if (std::find(repeatGroup.begin(), repeatGroup.end(), giter->id) == repeatGroup.end())
            tempGroup.push_back(*giter);

    if (tempGroup.empty())
    {
        CreatureTextRepeatMap::iterator mapItr = mTextRepeatMap.find(source->GetGUID());
        if (mapItr != mTextRepeatMap.end())
        {
            CreatureTextRepeatGroup::iterator groupItr = mapItr->second.find(textGroup);
            groupItr->second.clear();
        }

        tempGroup = textGroupContainer;
    }

    uint8 count = 0;
    float lastChance = -1;
    bool isEqualChanced = true;

    float totalChance = 0;

    for (CreatureTextGroup::const_iterator iter = tempGroup.begin(); iter != tempGroup.end(); ++iter)
    {
        if (lastChance >= 0 && lastChance != iter->probability)
            isEqualChanced = false;

        lastChance = iter->probability;
        totalChance += iter->probability;
        ++count;
    }

    int32 offset = -1;
    if (!isEqualChanced)
    {
        for (CreatureTextGroup::const_iterator iter = tempGroup.begin(); iter != tempGroup.end(); ++iter)
        {
            uint32 chance = uint32(iter->probability);
            uint32 r = urand(0, 100);
            ++offset;
            if (r <= chance)
                break;
        }
    }

    uint32 pos = 0;
    if (isEqualChanced || offset < 0)
        pos = urand(0, count - 1);
    else if (offset >= 0)
        pos = offset;

    CreatureTextGroup::const_iterator iter = tempGroup.begin() + pos;

    ChatMsg finalType = (msgType == CHAT_MSG_ADDON) ? iter->type : msgType;
    Language finalLang = (language == LANG_ADDON) ? iter->lang : language;
    uint32 finalSound = sound ? sound : iter->sound;

    if (range == TEXT_RANGE_NORMAL)
        range = iter->TextRange;

    if (finalSound)
        SendSound(source, finalSound, finalType, target, range, teamId, gmOnly);

    Unit* finalSource = source;
    if (srcPlr)
        finalSource = srcPlr;

    if (iter->emote)
        SendEmote(finalSource, iter->emote);

    if (srcPlr)
    {
        PlayerTextBuilder builder(source, finalSource, finalSource->getGender(), finalType, iter->group, iter->id, finalLang, target);
        SendChatPacket(finalSource, builder, finalType, target, range, teamId, gmOnly);
    }
    else
    {
        CreatureTextBuilder builder(finalSource, finalSource->getGender(), finalType, iter->group, iter->id, finalLang, target);
        SendChatPacket(finalSource, builder, finalType, target, range, teamId, gmOnly);
    }
    if (isEqualChanced || (!isEqualChanced && totalChance == 100.0f))
        SetRepeatId(source, textGroup, iter->id);

    return iter->duration;
}

float CreatureTextMgr::GetRangeForChatType(ChatMsg msgType) const
{
    float dist = sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY);
    switch (msgType)
    {
        case CHAT_MSG_MONSTER_YELL:
            dist = sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_YELL);
            break;
        case CHAT_MSG_MONSTER_EMOTE:
        case CHAT_MSG_RAID_BOSS_EMOTE:
            dist = sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_TEXTEMOTE);
            break;
        default:
            break;
    }

    return dist;
}

void CreatureTextMgr::SendSound(Creature* source, uint32 sound, ChatMsg msgType, WorldObject const* target, CreatureTextRange range, TeamId teamId, bool gmOnly)
{
    if (!sound || !source)
        return;

    SendNonChatPacket(source, WorldPackets::Misc::Playsound(sound).Write(), msgType, target, range, teamId, gmOnly);
}

void CreatureTextMgr::SendNonChatPacket(WorldObject* source, WorldPacket const* data, ChatMsg msgType, WorldObject const* target, CreatureTextRange range, TeamId teamId, bool gmOnly) const
{
    float dist = GetRangeForChatType(msgType);

    switch (msgType)
    {
        case CHAT_MSG_MONSTER_WHISPER:
        case CHAT_MSG_RAID_BOSS_WHISPER:
            {
                if (range == TEXT_RANGE_NORMAL) // ignores team and GM only
                {
                    if (!target || !target->IsPlayer())
                        return;

                    target->ToPlayer()->GetSession()->SendPacket(data);
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
                        itr->GetSource()->GetSession()->SendPacket(data);
                return;
            }
        case TEXT_RANGE_ZONE:
            {
                uint32 zoneId = source->GetZoneId();
                Map::PlayerList const& players = source->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    if (itr->GetSource()->GetZoneId() == zoneId && (teamId == TEAM_NEUTRAL || itr->GetSource()->GetTeamId() == teamId) && (!gmOnly || itr->GetSource()->IsGameMaster()))
                        itr->GetSource()->GetSession()->SendPacket(data);
                return;
            }
        case TEXT_RANGE_MAP:
            {
                Map::PlayerList const& players = source->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    if ((teamId == TEAM_NEUTRAL || itr->GetSource()->GetTeamId() == teamId) && (!gmOnly || itr->GetSource()->IsGameMaster()))
                        itr->GetSource()->GetSession()->SendPacket(data);
                return;
            }
        case TEXT_RANGE_WORLD:
            {
                WorldSessionMgr::SessionMap const& sessionMap = sWorldSessionMgr->GetAllSessions();
                for (WorldSessionMgr::SessionMap::const_iterator itr = sessionMap.begin(); itr != sessionMap.end(); ++itr)
                    if (Player* player = itr->second->GetPlayer())
                        if ((teamId == TEAM_NEUTRAL || player->GetTeamId() == teamId) && (!gmOnly || player->IsGameMaster()))
                            player->GetSession()->SendPacket(data);
                return;
            }
        case TEXT_RANGE_NORMAL:
        default:
            break;
    }

    source->SendMessageToSetInRange(data, dist, true);
}

void CreatureTextMgr::SendEmote(Unit* source, uint32 emote)
{
    if (!source)
        return;

    source->HandleEmoteCommand(emote);
}

void CreatureTextMgr::SetRepeatId(Creature* source, uint8 textGroup, uint8 id)
{
    if (!source)
        return;

    CreatureTextRepeatIds& repeats = mTextRepeatMap[source->GetGUID()][textGroup];
    if (std::find(repeats.begin(), repeats.end(), id) == repeats.end())
        repeats.push_back(id);
    else
        LOG_ERROR("sql.sql", "CreatureTextMgr: TextGroup {} for Creature {} ({}), id {} already added",
            uint32(textGroup), source->GetName(), source->GetGUID().ToString(), uint32(id));
}

CreatureTextRepeatIds CreatureTextMgr::GetRepeatGroup(Creature* source, uint8 textGroup)
{
    ASSERT(source);//should never happen
    CreatureTextRepeatIds ids;

    CreatureTextRepeatMap::const_iterator mapItr = mTextRepeatMap.find(source->GetGUID());
    if (mapItr != mTextRepeatMap.end())
    {
        CreatureTextRepeatGroup::const_iterator groupItr = (*mapItr).second.find(textGroup);
        if (groupItr != mapItr->second.end())
            ids = groupItr->second;
    }
    return ids;
}

bool CreatureTextMgr::TextExist(uint32 sourceEntry, uint8 textGroup)
{
    if (!sourceEntry)
        return false;

    CreatureTextMap::const_iterator sList = mTextMap.find(sourceEntry);
    if (sList == mTextMap.end())
    {
        LOG_DEBUG("entities.unit", "CreatureTextMgr::TextExist: Could not find Text for Creature (entry {}) in 'creature_text' table.", sourceEntry);
        return false;
    }

    CreatureTextHolder const& textHolder = sList->second;
    CreatureTextHolder::const_iterator itr = textHolder.find(textGroup);
    if (itr == textHolder.end())
    {
        LOG_DEBUG("entities.unit", "CreatureTextMgr::TextExist: Could not find TextGroup {} for Creature (entry {}).", uint32(textGroup), sourceEntry);
        return false;
    }

    return true;
}

std::string CreatureTextMgr::GetLocalizedChatString(uint32 entry, uint8 gender, uint8 textGroup, uint32 id, LocaleConstant locale) const
{
    CreatureTextMap::const_iterator mapitr = mTextMap.find(entry);
    if (mapitr == mTextMap.end())
        return "";

    CreatureTextHolder::const_iterator holderItr = mapitr->second.find(textGroup);
    if (holderItr == mapitr->second.end())
        return "";

    CreatureTextGroup::const_iterator groupItr = holderItr->second.begin();
    for (; groupItr != holderItr->second.end(); ++groupItr)
        if (groupItr->id == id)
            break;

    if (groupItr == holderItr->second.end())
        return "";

    if (locale > MAX_LOCALES)
        locale = DEFAULT_LOCALE;

    std::string baseText = "";

    BroadcastText const* bct = sObjectMgr->GetBroadcastText(groupItr->BroadcastTextId);
    if (bct)
        baseText = bct->GetText(locale, gender);
    else
        baseText = groupItr->text;

    if (locale != DEFAULT_LOCALE && !bct)
    {
        LocaleCreatureTextMap::const_iterator locItr = mLocaleTextMap.find(CreatureTextId(entry, uint32(textGroup), id));
        if (locItr != mLocaleTextMap.end())
            ObjectMgr::GetLocaleString(locItr->second.Text, locale, baseText);
    }

    return baseText;
}
