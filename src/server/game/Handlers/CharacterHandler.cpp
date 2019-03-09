/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "AccountMgr.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "AuctionHouseMgr.h"
#include "Battleground.h"
#include "CalendarMgr.h"
#include "Chat.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "Group.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "Language.h"
#include "LFGMgr.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Pet.h"
#include "PlayerDump.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "ServerMotd.h"
#include "SharedDefines.h"
#include "SocialMgr.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "GitRevision.h"
#include "UpdateMask.h"
#include "Util.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Transport.h"
#ifdef ELUNA
#include "LuaEngine.h"
#endif

class LoginQueryHolder : public SQLQueryHolder
{
    private:
        uint32 m_accountId;
        uint64 m_guid;
    public:
        LoginQueryHolder(uint32 accountId, uint64 guid)
            : m_accountId(accountId), m_guid(guid) { }
        uint64 GetGuid() const { return m_guid; }
        uint32 GetAccountId() const { return m_accountId; }
        bool Initialize();
};

bool LoginQueryHolder::Initialize()
{
    SetSize(MAX_PLAYER_LOGIN_QUERY);

    bool res = true;
    uint32 lowGuid = GUID_LOPART(m_guid);

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_FROM, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_AURAS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_AURAS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_SPELL);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_SPELLS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_QUESTSTATUS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_QUEST_STATUS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_DAILYQUESTSTATUS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_DAILY_QUEST_STATUS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_WEEKLYQUESTSTATUS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_WEEKLY_QUEST_STATUS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_MONTHLYQUESTSTATUS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_MONTHLY_QUEST_STATUS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_SEASONALQUESTSTATUS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_SEASONAL_QUEST_STATUS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_REPUTATION);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_REPUTATION, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_INVENTORY);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_INVENTORY, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_ACTIONS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_ACTIONS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_MAILCOUNT);
    stmt->setUInt32(0, lowGuid);
    stmt->setUInt64(1, uint64(time(NULL)));
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_MAIL_COUNT, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_MAILDATE);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_MAIL_DATE, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_SOCIALLIST);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_SOCIAL_LIST, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_HOMEBIND);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_HOME_BIND, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_SPELLCOOLDOWNS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_SPELL_COOLDOWNS, stmt);

    if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_DECLINEDNAMES);
        stmt->setUInt32(0, lowGuid);
        res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_DECLINED_NAMES, stmt);
    }

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_ACHIEVEMENTS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_ACHIEVEMENTS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_CRITERIAPROGRESS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_CRITERIA_PROGRESS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_EQUIPMENTSETS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_EQUIPMENT_SETS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_ENTRY_POINT);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_ENTRY_POINT, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_GLYPHS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_GLYPHS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_TALENTS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_TALENTS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_ACCOUNT_DATA);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_ACCOUNT_DATA, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_SKILLS);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_SKILLS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_RANDOMBG);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_RANDOM_BG, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_BANNED);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_BANNED, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_QUESTSTATUSREW);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_QUEST_STATUS_REW, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAIL_ASYNCH);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_MAIL, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_BREW_OF_THE_MONTH);
    stmt->setUInt32(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_BREW_OF_THE_MONTH, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ACCOUNT_INSTANCELOCKTIMES);
    stmt->setUInt32(0, m_accountId);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_INSTANCE_LOCK_TIMES, stmt);

    return res;
}

void WorldSession::HandleCharEnum(PreparedQueryResult result)
{
    WorldPacket data(SMSG_CHAR_ENUM, 100);                  // we guess size

    uint8 num = 0;

    data << num;

    _legitCharacters.clear();
    if (result)
    {
        do
        {
            uint32 guidlow = (*result)[0].GetUInt32();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDetail("Loading char guid %u from account %u.", guidlow, GetAccountId());
#endif
            if (Player::BuildEnumData(result, &data))
            {
                _legitCharacters.insert(guidlow);
                ++num;
            }
        }
        while (result->NextRow());
    }

    data.put<uint8>(0, num);

    SendPacket(&data);
}

void WorldSession::HandleCharEnumOpcode(WorldPacket & /*recvData*/)
{
    // remove expired bans
    // pussywizard: moved to world update to do it once >_>
    // PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_EXPIRED_BANS);
    // CharacterDatabase.Execute(stmt);
    PreparedStatement* stmt;

    /// get all the data necessary for loading all characters (along with their pets) on the account

    if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ENUM_DECLINED_NAME);
    else
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ENUM);

    stmt->setUInt8(0, PET_SAVE_AS_CURRENT);
    stmt->setUInt32(1, GetAccountId());

    _charEnumCallback = CharacterDatabase.AsyncQuery(stmt);
}

void WorldSession::HandleCharCreateOpcode(WorldPacket& recvData)
{
    std::string name;
    uint8 race_, class_;

    recvData >> name;

    recvData >> race_;
    recvData >> class_;

    // extract other data required for player creating
    uint8 gender, skin, face, hairStyle, hairColor, facialHair, outfitId;
    recvData >> gender >> skin >> face;
    recvData >> hairStyle >> hairColor >> facialHair >> outfitId;

    WorldPacket data(SMSG_CHAR_CREATE, 1);                  // returned with diff.values in all cases

    if (AccountMgr::IsPlayerAccount(GetSecurity()))
    {
        if (uint32 mask = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_DISABLED))
        {
            if (mask & (1 << Player::TeamIdForRace(race_)))
            {
                data << (uint8)CHAR_CREATE_DISABLED;
                SendPacket(&data);
                return;
            }
        }
    }

    ChrClassesEntry const* classEntry = sChrClassesStore.LookupEntry(class_);
    if (!classEntry)
    {
        data << (uint8)CHAR_CREATE_FAILED;
        SendPacket(&data);
        sLog->outError("Class (%u) not found in DBC while creating new char for account (ID: %u): wrong DBC files or cheater?", class_, GetAccountId());
        return;
    }

    ChrRacesEntry const* raceEntry = sChrRacesStore.LookupEntry(race_);
    if (!raceEntry)
    {
        data << (uint8)CHAR_CREATE_FAILED;
        SendPacket(&data);
        sLog->outError("Race (%u) not found in DBC while creating new char for account (ID: %u): wrong DBC files or cheater?", race_, GetAccountId());
        return;
    }

    // prevent character creating Expansion race without Expansion account
    if (raceEntry->expansion > Expansion())
    {
        data << (uint8)CHAR_CREATE_EXPANSION;
        sLog->outError("Expansion %u account:[%d] tried to Create character with expansion %u race (%u)", Expansion(), GetAccountId(), raceEntry->expansion, race_);
        SendPacket(&data);
        return;
    }

    // prevent character creating Expansion class without Expansion account
    if (classEntry->expansion > Expansion())
    {
        data << (uint8)CHAR_CREATE_EXPANSION_CLASS;
        sLog->outError("Expansion %u account:[%d] tried to Create character with expansion %u class (%u)", Expansion(), GetAccountId(), classEntry->expansion, class_);
        SendPacket(&data);
        return;
    }

    if (AccountMgr::IsPlayerAccount(GetSecurity()))
    {
        uint32 raceMaskDisabled = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_DISABLED_RACEMASK);
        if ((1 << (race_ - 1)) & raceMaskDisabled)
        {
            data << uint8(CHAR_CREATE_DISABLED);
            SendPacket(&data);
            return;
        }

        uint32 classMaskDisabled = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_DISABLED_CLASSMASK);
        if ((1 << (class_ - 1)) & classMaskDisabled)
        {
            data << uint8(CHAR_CREATE_DISABLED);
            SendPacket(&data);
            return;
        }
    }

    // prevent character creating with invalid name
    if (!normalizePlayerName(name))
    {
        data << (uint8)CHAR_NAME_NO_NAME;
        SendPacket(&data);
        sLog->outError("Account:[%d] but tried to Create character with empty [name] ", GetAccountId());
        return;
    }

    // check name limitations
    uint8 res = ObjectMgr::CheckPlayerName(name, true);
    if (res != CHAR_NAME_SUCCESS)
    {
        data << uint8(res);
        SendPacket(&data);
        return;
    }

    if (AccountMgr::IsPlayerAccount(GetSecurity()) && sObjectMgr->IsReservedName(name))
    {
        data << (uint8)CHAR_NAME_RESERVED;
        SendPacket(&data);
        return;
    }

    // speedup check for heroic class disabled case
    uint32 heroic_free_slots = sWorld->getIntConfig(CONFIG_HEROIC_CHARACTERS_PER_REALM);
    if (heroic_free_slots == 0 && AccountMgr::IsPlayerAccount(GetSecurity()) && class_ == CLASS_DEATH_KNIGHT)
    {
        data << (uint8)CHAR_CREATE_UNIQUE_CLASS_LIMIT;
        SendPacket(&data);
        return;
    }

    // speedup check for heroic class disabled case
    uint32 req_level_for_heroic = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_MIN_LEVEL_FOR_HEROIC_CHARACTER);
    if (AccountMgr::IsPlayerAccount(GetSecurity()) && class_ == CLASS_DEATH_KNIGHT && req_level_for_heroic > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
    {
        data << (uint8)CHAR_CREATE_LEVEL_REQUIREMENT;
        SendPacket(&data);
        return;
    }

    delete _charCreateCallback.GetParam();  // Delete existing if any, to make the callback chain reset to stage 0
    _charCreateCallback.SetParam(new CharacterCreateInfo(name, race_, class_, gender, skin, face, hairStyle, hairColor, facialHair, outfitId, recvData));
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHECK_NAME);
    stmt->setString(0, name);
    _charCreateCallback.SetFutureResult(CharacterDatabase.AsyncQuery(stmt));
}

void WorldSession::HandleCharCreateCallback(PreparedQueryResult result, CharacterCreateInfo* createInfo)
{
    /** This is a series of callbacks executed consecutively as a result from the database becomes available.
        This is much more efficient than synchronous requests on packet handler, and much less DoS prone.
        It also prevents data syncrhonisation errors.
    */
    switch (_charCreateCallback.GetStage())
    {
        case 0:
        {
            if (result)
            {
                WorldPacket data(SMSG_CHAR_CREATE, 1);
                data << uint8(CHAR_CREATE_NAME_IN_USE);
                SendPacket(&data);
                delete createInfo;
                _charCreateCallback.Reset();
                return;
            }

            ASSERT(_charCreateCallback.GetParam() == createInfo);

            PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_SUM_REALM_CHARACTERS);
            stmt->setUInt32(0, GetAccountId());

            _charCreateCallback.FreeResult();
            _charCreateCallback.SetFutureResult(LoginDatabase.AsyncQuery(stmt));
            _charCreateCallback.NextStage();
        }
        break;
        case 1:
        {
            uint16 acctCharCount = 0;
            if (result)
            {
                Field* fields = result->Fetch();
                // SELECT SUM(x) is MYSQL_TYPE_NEWDECIMAL - needs to be read as string
                const char* ch = fields[0].GetCString();
                if (ch)
                    acctCharCount = atoi(ch);
            }

            if (acctCharCount >= sWorld->getIntConfig(CONFIG_CHARACTERS_PER_ACCOUNT))
            {
                WorldPacket data(SMSG_CHAR_CREATE, 1);
                data << uint8(CHAR_CREATE_ACCOUNT_LIMIT);
                SendPacket(&data);
                delete createInfo;
                _charCreateCallback.Reset();
                return;
            }


            ASSERT(_charCreateCallback.GetParam() == createInfo);

            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_SUM_CHARS);
            stmt->setUInt32(0, GetAccountId());

            _charCreateCallback.FreeResult();
            _charCreateCallback.SetFutureResult(CharacterDatabase.AsyncQuery(stmt));
            _charCreateCallback.NextStage();
        }
        break;
        case 2:
        {
            if (result)
            {
                Field* fields = result->Fetch();
                createInfo->CharCount = uint8(fields[0].GetUInt64()); // SQL's COUNT() returns uint64 but it will always be less than uint8.Max

                if (createInfo->CharCount >= sWorld->getIntConfig(CONFIG_CHARACTERS_PER_REALM))
                {
                    WorldPacket data(SMSG_CHAR_CREATE, 1);
                    data << uint8(CHAR_CREATE_SERVER_LIMIT);
                    SendPacket(&data);
                    delete createInfo;
                    _charCreateCallback.Reset();
                    return;
                }
            }

            bool allowTwoSideAccounts = !sWorld->IsPvPRealm() || sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_ACCOUNTS) || !AccountMgr::IsPlayerAccount(GetSecurity());
            uint32 skipCinematics = sWorld->getIntConfig(CONFIG_SKIP_CINEMATICS);

            _charCreateCallback.FreeResult();

            if (!allowTwoSideAccounts || skipCinematics == 1 || createInfo->Class == CLASS_DEATH_KNIGHT)
            {
                PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_CREATE_INFO);
                stmt->setUInt32(0, GetAccountId());
                stmt->setUInt32(1, (skipCinematics == 1 || createInfo->Class == CLASS_DEATH_KNIGHT) ? 10 : 1);
                _charCreateCallback.SetFutureResult(CharacterDatabase.AsyncQuery(stmt));
                _charCreateCallback.NextStage();
                return;
            }

            _charCreateCallback.NextStage();
            HandleCharCreateCallback(PreparedQueryResult(NULL), createInfo);   // Will jump to case 3
        }
        break;
        case 3:
        {
            bool haveSameRace = false;
            uint32 heroicReqLevel = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_MIN_LEVEL_FOR_HEROIC_CHARACTER);
            bool hasHeroicReqLevel = (heroicReqLevel == 0);
            bool allowTwoSideAccounts = !sWorld->IsPvPRealm() || sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_ACCOUNTS) || !AccountMgr::IsPlayerAccount(GetSecurity());
            uint32 skipCinematics = sWorld->getIntConfig(CONFIG_SKIP_CINEMATICS);

            if (result)
            {
                TeamId teamId = Player::TeamIdForRace(createInfo->Race);
                uint32 freeHeroicSlots = sWorld->getIntConfig(CONFIG_HEROIC_CHARACTERS_PER_REALM);

                Field* field = result->Fetch();
                uint8 accRace  = field[1].GetUInt8();

                if (AccountMgr::IsPlayerAccount(GetSecurity()) && createInfo->Class == CLASS_DEATH_KNIGHT)
                {
                    uint8 accClass = field[2].GetUInt8();
                    if (accClass == CLASS_DEATH_KNIGHT)
                    {
                        if (freeHeroicSlots > 0)
                            --freeHeroicSlots;

                        if (freeHeroicSlots == 0)
                        {
                            WorldPacket data(SMSG_CHAR_CREATE, 1);
                            data << uint8(CHAR_CREATE_UNIQUE_CLASS_LIMIT);
                            SendPacket(&data);
                            delete createInfo;
                            _charCreateCallback.Reset();
                            return;
                        }
                    }

                    if (!hasHeroicReqLevel)
                    {
                        uint8 accLevel = field[0].GetUInt8();
                        if (accLevel >= heroicReqLevel)
                            hasHeroicReqLevel = true;
                    }
                }

                // need to check team only for first character
                // TODO: what to if account already has characters of both races?
                if (!allowTwoSideAccounts)
                {
                    uint32 accTeamId = TEAM_NEUTRAL;
                    if (accRace > 0)
                        accTeamId = Player::TeamIdForRace(accRace);

                    if (accTeamId != teamId)
                    {
                        WorldPacket data(SMSG_CHAR_CREATE, 1);
                        data << uint8(CHAR_CREATE_PVP_TEAMS_VIOLATION);
                        SendPacket(&data);
                        delete createInfo;
                        _charCreateCallback.Reset();
                        return;
                    }
                }

                // search same race for cinematic or same class if need
                // TODO: check if cinematic already shown? (already logged in?; cinematic field)
                while ((skipCinematics == 1 && !haveSameRace) || createInfo->Class == CLASS_DEATH_KNIGHT)
                {
                    if (!result->NextRow())
                        break;

                    field = result->Fetch();
                    accRace = field[1].GetUInt8();

                    if (!haveSameRace)
                        haveSameRace = createInfo->Race == accRace;

                    if (AccountMgr::IsPlayerAccount(GetSecurity()) && createInfo->Class == CLASS_DEATH_KNIGHT)
                    {
                        uint8 acc_class = field[2].GetUInt8();
                        if (acc_class == CLASS_DEATH_KNIGHT)
                        {
                            if (freeHeroicSlots > 0)
                                --freeHeroicSlots;

                            if (freeHeroicSlots == 0)
                            {
                                WorldPacket data(SMSG_CHAR_CREATE, 1);
                                data << uint8(CHAR_CREATE_UNIQUE_CLASS_LIMIT);
                                SendPacket(&data);
                                delete createInfo;
                                _charCreateCallback.Reset();
                                return;
                            }
                        }

                        if (!hasHeroicReqLevel)
                        {
                            uint8 acc_level = field[0].GetUInt8();
                            if (acc_level >= heroicReqLevel)
                                hasHeroicReqLevel = true;
                        }
                    }
                }
            }

            if (AccountMgr::IsPlayerAccount(GetSecurity()) && createInfo->Class == CLASS_DEATH_KNIGHT && !hasHeroicReqLevel)
            {
                WorldPacket data(SMSG_CHAR_CREATE, 1);
                data << uint8(CHAR_CREATE_LEVEL_REQUIREMENT);
                SendPacket(&data);
                delete createInfo;
                _charCreateCallback.Reset();
                return;
            }

            if (createInfo->Data.rpos() < createInfo->Data.wpos())
            {
                uint8 unk;
                createInfo->Data >> unk;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_NETWORKIO, "Character creation %s (account %u) has unhandled tail data: [%u]", createInfo->Name.c_str(), GetAccountId(), unk);
#endif
            }

            // pussywizard:
            if (sWorld->GetGlobalPlayerGUID(createInfo->Name))
            {
                WorldPacket data(SMSG_CHAR_CREATE, 1);
                data << uint8(CHAR_CREATE_NAME_IN_USE);
                SendPacket(&data);
                delete createInfo;
                _charCreateCallback.Reset();
                return;
            }

            Player newChar(this);
            newChar.GetMotionMaster()->Initialize();
            if (!newChar.Create(sObjectMgr->GenerateLowGuid(HIGHGUID_PLAYER), createInfo))
            {
                // Player not create (race/class/etc problem?)
                newChar.CleanupsBeforeDelete();

                WorldPacket data(SMSG_CHAR_CREATE, 1);
                data << uint8(CHAR_CREATE_ERROR);
                SendPacket(&data);
                delete createInfo;
                _charCreateCallback.Reset();
                return;
            }

            if ((haveSameRace && skipCinematics == 1) || skipCinematics == 2)
                newChar.setCinematic(1);                          // not show intro

            newChar.SetAtLoginFlag(AT_LOGIN_FIRST);               // First login

            // Player created, save it now
            newChar.SaveToDB(true, false);
            createInfo->CharCount += 1;

            SQLTransaction trans = LoginDatabase.BeginTransaction();

            PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_REALM_CHARACTERS_BY_REALM);
            stmt->setUInt32(0, GetAccountId());
            stmt->setUInt32(1, realmID);
            trans->Append(stmt);

            stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_REALM_CHARACTERS);
            stmt->setUInt32(0, createInfo->CharCount);
            stmt->setUInt32(1, GetAccountId());
            stmt->setUInt32(2, realmID);
            trans->Append(stmt);

            LoginDatabase.CommitTransaction(trans);

            WorldPacket data(SMSG_CHAR_CREATE, 1);
            data << uint8(CHAR_CREATE_SUCCESS);
            SendPacket(&data);

            std::string IP_str = GetRemoteAddress();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDetail("Account: %d (IP: %s) Create Character:[%s] (GUID: %u)", GetAccountId(), IP_str.c_str(), createInfo->Name.c_str(), newChar.GetGUIDLow());
#endif
            sLog->outChar("Account: %d (IP: %s) Create Character:[%s] (GUID: %u)", GetAccountId(), IP_str.c_str(), createInfo->Name.c_str(), newChar.GetGUIDLow());
            sScriptMgr->OnPlayerCreate(&newChar);
            sWorld->AddGlobalPlayerData(newChar.GetGUIDLow(), GetAccountId(), newChar.GetName(), newChar.getGender(), newChar.getRace(), newChar.getClass(), newChar.getLevel(), 0, 0);

            newChar.CleanupsBeforeDelete();
            delete createInfo;
            _charCreateCallback.Reset();
        }
        break;
    }
}

void WorldSession::HandleCharDeleteOpcode(WorldPacket& recvData)
{
    uint64 guid;
    recvData >> guid;
    // Initiating
    uint32 initAccountId = GetAccountId();

    // can't delete loaded character
    if (ObjectAccessor::FindPlayerInOrOutOfWorld(guid) || sWorld->FindOfflineSessionForCharacterGUID(GUID_LOPART(guid)))
    {
        sScriptMgr->OnPlayerFailedDelete(guid, initAccountId);
        WorldPacket data(SMSG_CHAR_DELETE, 1);
        data << (uint8)CHAR_DELETE_FAILED;
        SendPacket(&data);
        return;
    }

    uint32 accountId = 0;
    std::string name;

    // is guild leader
    if (sGuildMgr->GetGuildByLeader(guid))
    {
        sScriptMgr->OnPlayerFailedDelete(guid, initAccountId);
        WorldPacket data(SMSG_CHAR_DELETE, 1);
        data << (uint8)CHAR_DELETE_FAILED_GUILD_LEADER;
        SendPacket(&data);
        return;
    }

    // is arena team captain
    if (sArenaTeamMgr->GetArenaTeamByCaptain(guid))
    {
        sScriptMgr->OnPlayerFailedDelete(guid, initAccountId);
        WorldPacket data(SMSG_CHAR_DELETE, 1);
        data << (uint8)CHAR_DELETE_FAILED_ARENA_CAPTAIN;
        SendPacket(&data);
        return;
    }

    if (GlobalPlayerData const* playerData = sWorld->GetGlobalPlayerData(GUID_LOPART(guid)))
    {
        accountId     = playerData->accountId;
        name          = playerData->name;
    }

    // prevent deleting other players' characters using cheating tools
    if (accountId != initAccountId)
    {
        sScriptMgr->OnPlayerFailedDelete(guid, initAccountId);
        return;
    }

    std::string IP_str = GetRemoteAddress();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDetail("Account: %d (IP: %s) Delete Character:[%s] (GUID: %u)", GetAccountId(), IP_str.c_str(), name.c_str(), GUID_LOPART(guid));
#endif
    sLog->outChar("Account: %d (IP: %s) Delete Character:[%s] (GUID: %u)", GetAccountId(), IP_str.c_str(), name.c_str(), GUID_LOPART(guid));

    // To prevent hook failure, place hook before removing reference from DB
    sScriptMgr->OnPlayerDelete(guid, initAccountId); // To prevent race conditioning, but as it also makes sense, we hand the accountId over for successful delete.
    // Shouldn't interfere with character deletion though

    if (sLog->IsOutCharDump())                                // optimize GetPlayerDump call
    {
        std::string dump;
        if (PlayerDumpWriter().GetDump(GUID_LOPART(guid), dump))
            sLog->outCharDump(dump.c_str(), GetAccountId(), GUID_LOPART(guid), name.c_str());
    }

    sCalendarMgr->RemoveAllPlayerEventsAndInvites(guid);
    Player::DeleteFromDB(guid, GetAccountId(), true, false);

    sWorld->DeleteGlobalPlayerData(GUID_LOPART(guid), name);
    WorldPacket data(SMSG_CHAR_DELETE, 1);
    data << (uint8)CHAR_DELETE_SUCCESS;
    SendPacket(&data);
}

void WorldSession::HandlePlayerLoginOpcode(WorldPacket & recvData)
{
    if (PlayerLoading() || GetPlayer() != NULL)
    {
        sLog->outError("Player tries to login again, AccountId = %d", GetAccountId());
        KickPlayer("Player tries to login again");
        return;
    }

    uint64 playerGuid = 0;
    recvData >> playerGuid;

    if (!IsLegitCharacterForAccount(GUID_LOPART(playerGuid)))
    {
        sLog->outError("Account (%u) can't login with that character (%u).", GetAccountId(), GUID_LOPART(playerGuid));
        KickPlayer("Account can't login with this character");
        return;
    }
    
    // pussywizard:
    if (WorldSession* sess = sWorld->FindOfflineSessionForCharacterGUID(GUID_LOPART(playerGuid)))
        if (sess->GetAccountId() != GetAccountId())
        {
            WorldPacket data(SMSG_CHARACTER_LOGIN_FAILED, 1);
            data << (uint8)CHAR_LOGIN_DUPLICATE_CHARACTER;
            SendPacket(&data);
            return;
        }
    // pussywizard:
    if (WorldSession* sess = sWorld->FindOfflineSession(GetAccountId()))
    {
        Player* p = sess->GetPlayer();
        if (!p || sess->IsKicked())
        {
            WorldPacket data(SMSG_CHARACTER_LOGIN_FAILED, 1);
            data << (uint8)CHAR_LOGIN_DUPLICATE_CHARACTER;
            SendPacket(&data);
            return;
        }

        if (p->GetGUID() != playerGuid)
            sess->KickPlayer("No return, go to normal loading"); // no return, go to normal loading
        else
        {
            // pussywizard: players stay ingame no matter what (prevent abuse), but allow to turn it off to stop crashing
            if (!sWorld->getBoolConfig(CONFIG_ENABLE_LOGIN_AFTER_DC))
            {
                WorldPacket data(SMSG_CHARACTER_LOGIN_FAILED, 1);
                data << (uint8)CHAR_LOGIN_DUPLICATE_CHARACTER;
                SendPacket(&data);
                return;
            }

            uint8 limitA = 10, limitB = 10, limitC = 10; // pussywizard: this somehow froze (probably, ahh crash logs ...), and while (far) have never frozen in LogoutPlayer o_O maybe it's the combination of while(far); while(near);
            while (sess->GetPlayer() && (sess->GetPlayer()->IsBeingTeleportedFar() || (sess->GetPlayer()->IsInWorld() && sess->GetPlayer()->IsBeingTeleportedNear())))
            {
                if (limitA == 0 || --limitA == 0)
                {
                    sLog->outMisc("HandlePlayerLoginOpcode A");
                    break;
                }
                while (sess->GetPlayer() && sess->GetPlayer()->IsBeingTeleportedFar())
                {
                    if (limitB == 0 || --limitB == 0)
                    {
                        sLog->outMisc("HandlePlayerLoginOpcode B");
                        break;
                    }
                    sess->HandleMoveWorldportAckOpcode();
                }
                while (sess->GetPlayer() && sess->GetPlayer()->IsInWorld() && sess->GetPlayer()->IsBeingTeleportedNear())
                {
                    if (limitC == 0 || --limitC == 0)
                    {
                        sLog->outMisc("HandlePlayerLoginOpcode C");
                        break;
                    }
                    Player* plMover = sess->GetPlayer()->m_mover->ToPlayer();
                    if (!plMover)
                        break;
                    WorldPacket pkt(MSG_MOVE_TELEPORT_ACK, 20);
                    pkt.append(plMover->GetPackGUID());
                    pkt << uint32(0); // flags
                    pkt << uint32(0); // time
                    sess->HandleMoveTeleportAck(pkt);
                }
            }
            if (!p->FindMap() || !p->IsInWorld() || sess->IsKicked())
            {
                WorldPacket data(SMSG_CHARACTER_LOGIN_FAILED, 1);
                data << (uint8)CHAR_LOGIN_DUPLICATE_CHARACTER;
                SendPacket(&data);
                return;
            }

            sess->SetPlayer(NULL);
            SetPlayer(p);
            p->SetSession(this);
            delete p->PlayerTalkClass;
            p->PlayerTalkClass = new PlayerMenu(p->GetSession());
            HandlePlayerLoginToCharInWorld(p);
            return;
        }
    }

    m_playerLoading = true;

    LoginQueryHolder *holder = new LoginQueryHolder(GetAccountId(), playerGuid);
    if (!holder->Initialize())
    {
        delete holder;                                      // delete all unprocessed queries
        m_playerLoading = false;
        return;
    }

    _charLoginCallback = CharacterDatabase.DelayQueryHolder((SQLQueryHolder*)holder);
}

void WorldSession::HandlePlayerLoginFromDB(LoginQueryHolder* holder)
{
    uint64 playerGuid = holder->GetGuid();

    Player* pCurrChar = new Player(this);
     // for send server info and strings (config)
    ChatHandler chH = ChatHandler(this);

    // "GetAccountId() == db stored account id" checked in LoadFromDB (prevent login not own character using cheating tools)
    if (!pCurrChar->LoadFromDB(GUID_LOPART(playerGuid), holder))
    {
        SetPlayer(NULL);
        KickPlayer("HandlePlayerLoginFromDB");              // disconnect client, player no set to session and it will not deleted or saved at kick
        delete pCurrChar;                                   // delete it manually
        delete holder;                                      // delete all unprocessed queries
        m_playerLoading = false;
        return;
    }

    pCurrChar->GetMotionMaster()->Initialize();
    pCurrChar->SendDungeonDifficulty(false);

    WorldPacket data(SMSG_LOGIN_VERIFY_WORLD, 20);
    data << pCurrChar->GetMapId();
    data << pCurrChar->GetPositionX();
    data << pCurrChar->GetPositionY();
    data << pCurrChar->GetPositionZ() + pCurrChar->GetHoverHeight();
    data << pCurrChar->GetOrientation();
    SendPacket(&data);

    // load player specific part before send times
    LoadAccountData(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_ACCOUNT_DATA), PER_CHARACTER_CACHE_MASK);
    SendAccountDataTimes(PER_CHARACTER_CACHE_MASK);

    data.Initialize(SMSG_FEATURE_SYSTEM_STATUS, 2);         // added in 2.2.0
    data << uint8(2);                                       // unknown value
    data << uint8(0);                                       // enable(1)/disable(0) voice chat interface in client
    SendPacket(&data);

    // Send MOTD
    {
        SendPacket(Motd::GetMotdPacket());

        // send server info
        if (sWorld->getIntConfig(CONFIG_ENABLE_SINFO_LOGIN) == 1)
            chH.PSendSysMessage("%s", GitRevision::GetFullVersion());

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("WORLD: Sent server info");
#endif
    }

    if (uint32 guildId = Player::GetGuildIdFromStorage(pCurrChar->GetGUIDLow()))
    {
        Guild* guild = sGuildMgr->GetGuildById(guildId);
        Guild::Member const* member = guild ? guild->GetMember(pCurrChar->GetGUID()) : NULL;
        if (member)
        {
            pCurrChar->SetInGuild(guildId);
            pCurrChar->SetRank(member->GetRankId());
            guild->SendLoginInfo(this);
        }
        else
        {
            sLog->outError("Player %s (GUID: %u) marked as member of not existing guild (id: %u), removing guild membership for player.", pCurrChar->GetName().c_str(), pCurrChar->GetGUIDLow(), guildId);
            pCurrChar->SetInGuild(0);
            pCurrChar->SetRank(0);
        }
    }
    else
    {
        pCurrChar->SetInGuild(0);
        pCurrChar->SetRank(0);
    }


    data.Initialize(SMSG_LEARNED_DANCE_MOVES, 4+4);
    data << uint32(0);
    data << uint32(0);
    SendPacket(&data);

    pCurrChar->SendInitialPacketsBeforeAddToMap();

    //Show cinematic at the first time that player login
    if (!pCurrChar->getCinematic())
    {
        pCurrChar->setCinematic(1);

        if (ChrClassesEntry const* cEntry = sChrClassesStore.LookupEntry(pCurrChar->getClass()))
        {
            if (cEntry->CinematicSequence)
                pCurrChar->SendCinematicStart(cEntry->CinematicSequence);
            else if (ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(pCurrChar->getRace()))
                pCurrChar->SendCinematicStart(rEntry->CinematicSequence);

            // send new char string if not empty
            if (!sWorld->GetNewCharString().empty())
                chH.PSendSysMessage("%s", sWorld->GetNewCharString().c_str());
        }
    }

    // Xinef: moved this from below
    sObjectAccessor->AddObject(pCurrChar);

    if (!pCurrChar->GetMap()->AddPlayerToMap(pCurrChar) || !pCurrChar->CheckInstanceLoginValid())
    {
        AreaTriggerTeleport const* at = sObjectMgr->GetGoBackTrigger(pCurrChar->GetMapId());
        if (at)
            pCurrChar->TeleportTo(at->target_mapId, at->target_X, at->target_Y, at->target_Z, pCurrChar->GetOrientation());
        else
            pCurrChar->TeleportTo(pCurrChar->m_homebindMapId, pCurrChar->m_homebindX, pCurrChar->m_homebindY, pCurrChar->m_homebindZ, pCurrChar->GetOrientation());
    }

    //sLog->outDebug("Player %s added to Map.", pCurrChar->GetName().c_str());

    // pussywizard: optimization
    std::string charName = pCurrChar->GetName();
    std::transform(charName.begin(), charName.end(), charName.begin(), ::tolower);
    sObjectAccessor->playerNameToPlayerPointer[charName] = pCurrChar;

    pCurrChar->SendInitialPacketsAfterAddToMap();

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_ONLINE);
    stmt->setUInt32(0, pCurrChar->GetGUIDLow());
    CharacterDatabase.Execute(stmt);

    stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_ONLINE);
    stmt->setUInt32(0, realmID);
    stmt->setUInt32(1, GetAccountId());
    LoginDatabase.Execute(stmt);

    pCurrChar->SetInGameTime(World::GetGameTimeMS());

    // announce group about member online (must be after add to player list to receive announce to self)
    if (Group* group = pCurrChar->GetGroup())
    {
        //pCurrChar->groupInfo.group->SendInit(this); // useless
        group->SendUpdate();
        group->ResetMaxEnchantingLevel();
    }

    // pussywizard: send instance welcome message as when entering the instance through a portal
    if (MapDifficulty const* mapDiff = GetMapDifficultyData(pCurrChar->GetMap()->GetId(), pCurrChar->GetMap()->GetDifficulty()))
        if (mapDiff->resetTime)
            if (time_t timeReset = sInstanceSaveMgr->GetResetTimeFor(pCurrChar->GetMap()->GetId(), pCurrChar->GetMap()->GetDifficulty()))
            {
                uint32 timeleft = uint32(timeReset - time(NULL));
                pCurrChar->SendInstanceResetWarning(pCurrChar->GetMap()->GetId(), pCurrChar->GetMap()->GetDifficulty(), timeleft, true);
            }

    // pussywizard: ensure that we end up on map with our loaded transport:
    if (Transport* t = pCurrChar->GetTransport())
        if (!t->IsInMap(pCurrChar))
        {
            t->RemovePassenger(pCurrChar);
            pCurrChar->m_transport = NULL;
            pCurrChar->m_movementInfo.transport.Reset();
            pCurrChar->m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
        }

    // friend status
    if (AccountMgr::IsGMAccount(GetSecurity())) // pussywizard: only for non-gms
        sSocialMgr->SendFriendStatus(pCurrChar, FRIEND_ONLINE, pCurrChar->GetGUIDLow(), true);

    // Place character in world (and load zone) before some object loading
    pCurrChar->LoadCorpse();

    // setting Ghost+speed if dead
    if (pCurrChar->m_deathState != ALIVE)
    {
        // not blizz like, we must correctly save and load player instead...
        if (pCurrChar->getRace() == RACE_NIGHTELF)
            pCurrChar->CastSpell(pCurrChar, 20584, true, 0);// auras SPELL_AURA_INCREASE_SPEED(+speed in wisp form), SPELL_AURA_INCREASE_SWIM_SPEED(+swim speed in wisp form), SPELL_AURA_TRANSFORM (to wisp form)
        pCurrChar->CastSpell(pCurrChar, 8326, true, 0);     // auras SPELL_AURA_GHOST, SPELL_AURA_INCREASE_SPEED(why?), SPELL_AURA_INCREASE_SWIM_SPEED(why?)

        pCurrChar->SetMovement(MOVE_WATER_WALK);
    }

    // Set FFA PvP for non GM in non-rest mode
    if (sWorld->IsFFAPvPRealm() && !pCurrChar->IsGameMaster() && !pCurrChar->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING))
        pCurrChar->SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);

    if (pCurrChar->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_CONTESTED_PVP))
        pCurrChar->SetContestedPvP();

    // Apply at_login requests
    if (pCurrChar->HasAtLoginFlag(AT_LOGIN_RESET_SPELLS))
    {
        pCurrChar->resetSpells();
        SendNotification(LANG_RESET_SPELLS);
    }

    if (pCurrChar->HasAtLoginFlag(AT_LOGIN_RESET_TALENTS))
    {
        pCurrChar->resetTalents(true);
        pCurrChar->SendTalentsInfoData(false);              // original talents send already in to SendInitialPacketsBeforeAddToMap, resend reset state
        SendNotification(LANG_RESET_TALENTS);
    }

    if (pCurrChar->HasAtLoginFlag(AT_LOGIN_FIRST)) {
        pCurrChar->RemoveAtLoginFlag(AT_LOGIN_FIRST);

        sScriptMgr->OnFirstLogin(pCurrChar);
    }

    if (pCurrChar->HasAtLoginFlag(AT_LOGIN_CHECK_ACHIEVS))
    {
        pCurrChar->RemoveAtLoginFlag(AT_LOGIN_CHECK_ACHIEVS, true);
        pCurrChar->CheckAllAchievementCriteria();
    }

        // Reputations if "StartAllReputation" is enabled, -- TODO: Fix this in a better way
    if (sWorld->getBoolConfig(CONFIG_START_ALL_REP))
    {
        ReputationMgr& repMgr = pCurrChar->GetReputationMgr();
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(942), 42999, false);
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(935), 42999, false);
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(936), 42999, false);
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(1011), 42999, false);
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(970), 42999, false);
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(967), 42999, false);
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(989), 42999, false);
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(932), 42999, false);
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(934), 42999, false);
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(1038), 42999, false);
        repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(1077), 42999, false);

        switch (pCurrChar->getFaction())
        {
            case ALLIANCE:
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(72), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(47), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(69), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(930), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(730), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(978), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(54), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(946), 42999, false);
                break;
            case HORDE:
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(76), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(68), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(81), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(911), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(729), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(941), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(530), 42999, false);
                repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(947), 42999, false);
                break;
            default:
                break;
        }
        repMgr.SendStates();
    }

    // show time before shutdown if shutdown planned.
    if (sWorld->IsShuttingDown())
        sWorld->ShutdownMsg(true, pCurrChar);

    if (sWorld->getBoolConfig(CONFIG_ALL_TAXI_PATHS))
        pCurrChar->SetTaxiCheater(true);

    if (pCurrChar->IsGameMaster())
        SendNotification(LANG_GM_ON);

    std::string IP_str = GetRemoteAddress();
    sLog->outChar("Account: %d (IP: %s) Login Character:[%s] (GUID: %u) Level: %d",
        GetAccountId(), IP_str.c_str(), pCurrChar->GetName().c_str(), pCurrChar->GetGUIDLow(), pCurrChar->getLevel());

    if (!pCurrChar->IsStandState() && !pCurrChar->HasUnitState(UNIT_STATE_STUNNED))
        pCurrChar->SetStandState(UNIT_STAND_STATE_STAND);

    m_playerLoading = false;


    // Handle Login-Achievements (should be handled after loading)
    _player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_ON_LOGIN, 1);

    // Xinef: fix vendors falling of player vehicle, due to isBeingLoaded checks
    if (pCurrChar->IsInWorld())
    {
        if (pCurrChar->GetMountBlockId() && !pCurrChar->HasAuraType(SPELL_AURA_MOUNTED))
        {
            pCurrChar->CastSpell(pCurrChar, pCurrChar->GetMountBlockId(), true);
            pCurrChar->SetMountBlockId(0);

            // Xinef: refresh this in case mount aura changes anything (eg no fly zone)
            pCurrChar->UpdateAreaDependentAuras(pCurrChar->GetAreaId());
            pCurrChar->UpdateZoneDependentAuras(pCurrChar->GetZoneId());
        }
    }

    // pussywizard: pvp mode
    pCurrChar->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_PVP_TIMER);
    if (pCurrChar->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP))
        pCurrChar->UpdatePvP(true, true);

    // pussywizard: on login it's not possible to go back to arena as a spectator, HandleMoveWorldportAckOpcode is not sent, so call it here
    pCurrChar->SetIsSpectator(false);

    // xinef: do this after everything is loaded
    pCurrChar->ContinueTaxiFlight();

    // reset for all pets before pet loading
    if (pCurrChar->HasAtLoginFlag(AT_LOGIN_RESET_PET_TALENTS))
        Pet::resetTalentsForAllPetsOf(pCurrChar);

    // Load pet if any (if player not alive and in taxi flight or another then pet will remember as temporary unsummoned)
    pCurrChar->LoadPet();

    if (pCurrChar->GetSession()->GetRecruiterId() != 0 || pCurrChar->GetSession()->IsARecruiter())
    {
        bool isReferrer = pCurrChar->GetSession()->IsARecruiter();

        for (SessionMap::const_iterator itr = sWorld->GetAllSessions().begin(); itr != sWorld->GetAllSessions().end(); ++itr)
        {
            if (!itr->second->GetRecruiterId() && !itr->second->IsARecruiter())
                continue;
            if ((isReferrer && pCurrChar->GetSession()->GetAccountId() == itr->second->GetRecruiterId()) || (!isReferrer && pCurrChar->GetSession()->GetRecruiterId() == itr->second->GetAccountId()))
            {
                Player * rf = itr->second->GetPlayer();
                if (rf != NULL)
                {
                    pCurrChar->SendUpdateToPlayer(rf);
                    rf->SendUpdateToPlayer(pCurrChar);
                }
            }
        }
    }

    sScriptMgr->OnPlayerLogin(pCurrChar);
    delete holder;
}

void WorldSession::HandlePlayerLoginToCharInWorld(Player* pCurrChar)
{
    ChatHandler chH = ChatHandler(this);
    m_playerLoading = true;

    pCurrChar->SendDungeonDifficulty(false);

    WorldPacket data(SMSG_LOGIN_VERIFY_WORLD, 20);
    data << pCurrChar->GetMapId();
    data << pCurrChar->GetPositionX();
    data << pCurrChar->GetPositionY();
    data << pCurrChar->GetPositionZ() + pCurrChar->GetHoverHeight();
    data << pCurrChar->GetOrientation();
    SendPacket(&data);

    SendAccountDataTimes(PER_CHARACTER_CACHE_MASK);

    data.Initialize(SMSG_FEATURE_SYSTEM_STATUS, 2);         // added in 2.2.0
    data << uint8(2);                                       // unknown value
    data << uint8(0);                                       // enable(1)/disable(0) voice chat interface in client
    SendPacket(&data);

    // Send MOTD
    {
        SendPacket(Motd::GetMotdPacket());

        // send server info
        if (sWorld->getIntConfig(CONFIG_ENABLE_SINFO_LOGIN) == 1)
            chH.PSendSysMessage("%s", GitRevision::GetFullVersion());

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("WORLD: Sent server info");
#endif
    }

    data.Initialize(SMSG_LEARNED_DANCE_MOVES, 4+4);
    data << uint32(0);
    data << uint32(0);
    SendPacket(&data);

    // Xinef: fix possible problem with flag UNIT_FLAG_STUNNED added during logout
    if (!pCurrChar->HasUnitState(UNIT_STATE_STUNNED))
        pCurrChar->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);

    pCurrChar->SendInitialPacketsBeforeAddToMap();

    // necessary actions from AddPlayerToMap:
    pCurrChar->GetMap()->SendInitTransports(pCurrChar);
    pCurrChar->GetMap()->SendInitSelf(pCurrChar);
    pCurrChar->GetMap()->SendZoneDynamicInfo(pCurrChar);
    pCurrChar->m_clientGUIDs.clear();
    pCurrChar->UpdateObjectVisibility(false);

    pCurrChar->CleanupChannels();
    pCurrChar->SendInitialPacketsAfterAddToMap();
    uint32 currZone, currArea;
    pCurrChar->GetZoneAndAreaId(currZone, currArea, false);
    pCurrChar->SendInitWorldStates(currZone, currArea);
    pCurrChar->SetInGameTime(World::GetGameTimeMS());

    // Xinef: we need to resend all spell mods
    for (uint16 Opcode = SMSG_SET_FLAT_SPELL_MODIFIER; Opcode <= SMSG_SET_PCT_SPELL_MODIFIER; ++Opcode) // PCT = FLAT+1
    {
        uint32 modType = (Opcode == SMSG_SET_FLAT_SPELL_MODIFIER) ? SPELLMOD_FLAT : SPELLMOD_PCT;
        for (uint32 opType = SPELLMOD_DAMAGE; opType < MAX_SPELLMOD; ++opType)
        {
            int32 i = 0;
            flag96 _mask = 0;
            SpellModList const& spellMods = pCurrChar->GetSpellModList(opType);
            if (spellMods.empty())
                continue;

            for (int32 eff = 0; eff < 96; ++eff)
            {
                if (eff != 0 && eff%32 == 0)
                    _mask[i++] = 0;

                _mask[i] = uint32(1) << (eff-(32*i));
                int32 val = 0;
                for (SpellModList::const_iterator itr = spellMods.begin(); itr != spellMods.end(); ++itr)
                    if ((*itr)->type == modType && (*itr)->mask & _mask)
                        val += (*itr)->value;

                if (val == 0)
                    continue;

                WorldPacket data(Opcode, (1+1+4));
                data << uint8(eff);
                data << uint8(opType);
                data << int32(val);
                SendPacket(&data);
            }
        }
    }
    
    if (Group* group = pCurrChar->GetGroup())
        group->SendUpdate();

    // pussywizard: send instance welcome message as when entering the instance through a portal
    if (MapDifficulty const* mapDiff = GetMapDifficultyData(pCurrChar->GetMap()->GetId(), pCurrChar->GetMap()->GetDifficulty()))
        if (mapDiff->resetTime)
            if (time_t timeReset = sInstanceSaveMgr->GetResetTimeFor(pCurrChar->GetMap()->GetId(), pCurrChar->GetMap()->GetDifficulty()))
            {
                uint32 timeleft = uint32(timeReset - time(NULL));
                GetPlayer()->SendInstanceResetWarning(pCurrChar->GetMap()->GetId(), pCurrChar->GetMap()->GetDifficulty(), timeleft, true);
            }

    // this shouldn't do anything, becaues offline can't be on taxi, but just in case
    pCurrChar->ContinueTaxiFlight();

    // send pet data, action bar, talents, etc.
    pCurrChar->PetSpellInitialize();
    pCurrChar->SendTalentsInfoData(true);

    // show time before shutdown if shutdown planned.
    if (sWorld->IsShuttingDown())
        sWorld->ShutdownMsg(true, pCurrChar);

    if (pCurrChar->IsGameMaster())
        SendNotification(LANG_GM_ON);

    m_playerLoading = false;
}

void WorldSession::HandlePlayerLoginToCharOutOfWorld(Player*  /*pCurrChar*/)
{
    ASSERT(false);
}

void WorldSession::HandleSetFactionAtWar(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("WORLD: Received CMSG_SET_FACTION_ATWAR");
#endif

    uint32 repListID;
    uint8  flag;

    recvData >> repListID;
    recvData >> flag;

    GetPlayer()->GetReputationMgr().SetAtWar(repListID, flag);
}

//I think this function is never used :/ I dunno, but i guess this opcode not exists
void WorldSession::HandleSetFactionCheat(WorldPacket & /*recvData*/)
{
    sLog->outError("WORLD SESSION: HandleSetFactionCheat, not expected call, please report.");
    GetPlayer()->GetReputationMgr().SendStates();
}

void WorldSession::HandleTutorialFlag(WorldPacket& recvData)
{
    uint32 data;
    recvData >> data;

    uint8 index = uint8(data / 32);
    if (index >= MAX_ACCOUNT_TUTORIAL_VALUES)
        return;

    uint32 value = (data % 32);

    uint32 flag = GetTutorialInt(index);
    flag |= (1 << value);
    SetTutorialInt(index, flag);
}

void WorldSession::HandleTutorialClear(WorldPacket & /*recvData*/)
{
    for (uint8 i = 0; i < MAX_ACCOUNT_TUTORIAL_VALUES; ++i)
        SetTutorialInt(i, 0xFFFFFFFF);
}

void WorldSession::HandleTutorialReset(WorldPacket & /*recvData*/)
{
    for (uint8 i = 0; i < MAX_ACCOUNT_TUTORIAL_VALUES; ++i)
        SetTutorialInt(i, 0x00000000);
}

void WorldSession::HandleSetWatchedFactionOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("WORLD: Received CMSG_SET_WATCHED_FACTION");
#endif
    uint32 fact;
    recvData >> fact;
    GetPlayer()->SetUInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX, fact);
}

void WorldSession::HandleSetFactionInactiveOpcode(WorldPacket & recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("WORLD: Received CMSG_SET_FACTION_INACTIVE");
#endif
    uint32 replistid;
    uint8 inactive;
    recvData >> replistid >> inactive;

    _player->GetReputationMgr().SetInactive(replistid, inactive);
}

void WorldSession::HandleShowingHelmOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("CMSG_SHOWING_HELM for %s", _player->GetName().c_str());
#endif
    recvData.read_skip<uint8>(); // unknown, bool?
    _player->ToggleFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_HELM);
}

void WorldSession::HandleShowingCloakOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("CMSG_SHOWING_CLOAK for %s", _player->GetName().c_str());
#endif
    recvData.read_skip<uint8>(); // unknown, bool?
    _player->ToggleFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_CLOAK);
}

void WorldSession::HandleCharRenameOpcode(WorldPacket& recvData)
{
    uint64 guid;
    std::string newName;

    recvData >> guid;
    recvData >> newName;

    // prevent character rename to invalid name
    if (!normalizePlayerName(newName))
    {
        WorldPacket data(SMSG_CHAR_RENAME, 1);
        data << uint8(CHAR_NAME_NO_NAME);
        SendPacket(&data);
        return;
    }

    uint8 res = ObjectMgr::CheckPlayerName(newName, true);
    if (res != CHAR_NAME_SUCCESS)
    {
        WorldPacket data(SMSG_CHAR_RENAME, 1+8+(newName.size()+1));
        data << uint8(res);
        data << uint64(guid);
        data << newName;
        SendPacket(&data);
        return;
    }

    // check name limitations
    if (AccountMgr::IsPlayerAccount(GetSecurity()) && sObjectMgr->IsReservedName(newName))
    {
        WorldPacket data(SMSG_CHAR_RENAME, 1);
        data << uint8(CHAR_NAME_RESERVED);
        SendPacket(&data);
        return;
    }

    // Ensure that the character belongs to the current account, that rename at login is enabled
    // and that there is no character with the desired new name
    _charRenameCallback.SetParam(newName);

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_FREE_NAME);

    stmt->setUInt32(0, GUID_LOPART(guid));
    stmt->setUInt32(1, GetAccountId());
    stmt->setUInt16(2, AT_LOGIN_RENAME);
    stmt->setUInt16(3, AT_LOGIN_RENAME);
    stmt->setString(4, newName);

    _charRenameCallback.SetFutureResult(CharacterDatabase.AsyncQuery(stmt));
}

void WorldSession::HandleChangePlayerNameOpcodeCallBack(PreparedQueryResult result, std::string const& newName)
{
    if (!result)
    {
        WorldPacket data(SMSG_CHAR_RENAME, 1);
        data << uint8(CHAR_CREATE_ERROR);
        SendPacket(&data);
        return;
    }

    Field* fields = result->Fetch();

    uint32 guidLow      = fields[0].GetUInt32();
    std::string oldName = fields[1].GetString();

    uint64 guid = MAKE_NEW_GUID(guidLow, 0, HIGHGUID_PLAYER);

    // pussywizard:
    if (ObjectAccessor::FindPlayerInOrOutOfWorld(guid) || sWorld->FindOfflineSessionForCharacterGUID(guidLow))
    {
        WorldPacket data(SMSG_CHAR_RENAME, 1);
        data << uint8(CHAR_CREATE_ERROR);
        SendPacket(&data);
        return;
    }

    // Update name and at_login flag in the db
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NAME);

    stmt->setString(0, newName);
    stmt->setUInt16(1, AT_LOGIN_RENAME);
    stmt->setUInt32(2, guidLow);

    CharacterDatabase.Execute(stmt);

    // Removed declined name from db
    if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_DECLINED_NAME);

        stmt->setUInt32(0, guidLow);

        CharacterDatabase.Execute(stmt);
    }

    sLog->outChar("Account: %d (IP: %s), Character [%s] (guid: %u) Changed name to: %s", GetAccountId(), GetRemoteAddress().c_str(), oldName.c_str(), guidLow, newName.c_str());

    WorldPacket data(SMSG_CHAR_RENAME, 1+8+(newName.size()+1));
    data << uint8(RESPONSE_SUCCESS);
    data << uint64(guid);
    data << newName;
    SendPacket(&data);

    // xinef: update global data
    sWorld->UpdateGlobalNameData(guidLow, oldName, newName);
    sWorld->UpdateGlobalPlayerData(guidLow, PLAYER_UPDATE_DATA_NAME, newName);
}

void WorldSession::HandleSetPlayerDeclinedNames(WorldPacket& recvData)
{
    // pussywizard:
    if (!sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
        return;

    uint64 guid;

    recvData >> guid;

    // not accept declined names for unsupported languages
    std::string name;
    if (!sObjectMgr->GetPlayerNameByGUID(guid, name))
    {
        WorldPacket data(SMSG_SET_PLAYER_DECLINED_NAMES_RESULT, 4+8);
        data << uint32(1);
        data << uint64(guid);
        SendPacket(&data);
        return;
    }

    std::wstring wname;
    if (!Utf8toWStr(name, wname))
    {
        WorldPacket data(SMSG_SET_PLAYER_DECLINED_NAMES_RESULT, 4+8);
        data << uint32(1);
        data << uint64(guid);
        SendPacket(&data);
        return;
    }

    if (!isCyrillicCharacter(wname[0]))                      // name already stored as only single alphabet using
    {
        WorldPacket data(SMSG_SET_PLAYER_DECLINED_NAMES_RESULT, 4+8);
        data << uint32(1);
        data << uint64(guid);
        SendPacket(&data);
        return;
    }

    std::string name2;
    DeclinedName declinedname;

    recvData >> name2;

    if (name2 != name)                                       // character have different name
    {
        WorldPacket data(SMSG_SET_PLAYER_DECLINED_NAMES_RESULT, 4+8);
        data << uint32(1);
        data << uint64(guid);
        SendPacket(&data);
        return;
    }

    for (int i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
    {
        recvData >> declinedname.name[i];
        if (!normalizePlayerName(declinedname.name[i]))
        {
            WorldPacket data(SMSG_SET_PLAYER_DECLINED_NAMES_RESULT, 4+8);
            data << uint32(1);
            data << uint64(guid);
            SendPacket(&data);
            return;
        }
    }

    if (!ObjectMgr::CheckDeclinedNames(wname, declinedname))
    {
        WorldPacket data(SMSG_SET_PLAYER_DECLINED_NAMES_RESULT, 4+8);
        data << uint32(1);
        data << uint64(guid);
        SendPacket(&data);
        return;
    }

    for (int i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
        CharacterDatabase.EscapeString(declinedname.name[i]);

    SQLTransaction trans = CharacterDatabase.BeginTransaction();

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_DECLINED_NAME);
    stmt->setUInt32(0, GUID_LOPART(guid));
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_DECLINED_NAME);
    stmt->setUInt32(0, GUID_LOPART(guid));

    for (uint8 i = 0; i < 5; i++)
        stmt->setString(i+1, declinedname.name[i]);

    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);

    WorldPacket data(SMSG_SET_PLAYER_DECLINED_NAMES_RESULT, 4+8);
    data << uint32(0);                                      // OK
    data << uint64(guid);
    SendPacket(&data);
}

void WorldSession::HandleAlterAppearance(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_ALTER_APPEARANCE");
#endif

    uint32 Hair, Color, FacialHair, SkinColor;
    recvData >> Hair >> Color >> FacialHair >> SkinColor;

    BarberShopStyleEntry const* bs_hair = sBarberShopStyleStore.LookupEntry(Hair);

    if (!bs_hair || bs_hair->type != 0 || bs_hair->race != _player->getRace() || bs_hair->gender != _player->getGender())
        return;

    BarberShopStyleEntry const* bs_facialHair = sBarberShopStyleStore.LookupEntry(FacialHair);

    if (!bs_facialHair || bs_facialHair->type != 2 || bs_facialHair->race != _player->getRace() || bs_facialHair->gender != _player->getGender())
        return;

    BarberShopStyleEntry const* bs_skinColor = sBarberShopStyleStore.LookupEntry(SkinColor);

    if (bs_skinColor && (bs_skinColor->type != 3 || bs_skinColor->race != _player->getRace() || bs_skinColor->gender != _player->getGender()))
        return;

    GameObject* go = _player->FindNearestGameObjectOfType(GAMEOBJECT_TYPE_BARBER_CHAIR, 5.0f);
    if (!go)
    {
        WorldPacket data(SMSG_BARBER_SHOP_RESULT, 4);
        data << uint32(2);
        SendPacket(&data);
        return;
    }

    if (_player->getStandState() != UNIT_STAND_STATE_SIT_LOW_CHAIR + go->GetGOInfo()->barberChair.chairheight)
    {
        WorldPacket data(SMSG_BARBER_SHOP_RESULT, 4);
        data << uint32(2);
        SendPacket(&data);
        return;
    }

    uint32 cost = _player->GetBarberShopCost(bs_hair->hair_id, Color, bs_facialHair->hair_id, bs_skinColor);

    // 0 - ok
    // 1, 3 - not enough money
    // 2 - you have to seat on barber chair
    if (!_player->HasEnoughMoney(cost))
    {
        WorldPacket data(SMSG_BARBER_SHOP_RESULT, 4);
        data << uint32(1);                                  // no money
        SendPacket(&data);
        return;
    }
    else
    {
        WorldPacket data(SMSG_BARBER_SHOP_RESULT, 4);
        data << uint32(0);                                  // ok
        SendPacket(&data);
    }

    _player->ModifyMoney(-int32(cost));                     // it isn't free
    _player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_AT_BARBER, cost);

    _player->SetByteValue(PLAYER_BYTES, 2, uint8(bs_hair->hair_id));
    _player->SetByteValue(PLAYER_BYTES, 3, uint8(Color));
    _player->SetByteValue(PLAYER_BYTES_2, 0, uint8(bs_facialHair->hair_id));
    if (bs_skinColor)
        _player->SetByteValue(PLAYER_BYTES, 0, uint8(bs_skinColor->hair_id));

    _player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_VISIT_BARBER_SHOP, 1);

    _player->SetStandState(0);                              // stand up
}

void WorldSession::HandleRemoveGlyph(WorldPacket& recvData)
{
    uint32 slot;
    recvData >> slot;

    if (slot >= MAX_GLYPH_SLOT_INDEX)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "Client sent wrong glyph slot number in opcode CMSG_REMOVE_GLYPH %u", slot);
#endif
        return;
    }

    if (uint32 glyph = _player->GetGlyph(slot))
    {
        if (GlyphPropertiesEntry const* glyphEntry = sGlyphPropertiesStore.LookupEntry(glyph))
        {
            _player->RemoveAurasDueToSpell(glyphEntry->SpellId);
            _player->SetGlyph(slot, 0, true);
            _player->SendTalentsInfoData(false);
        }
    }
}

void WorldSession::HandleCharCustomize(WorldPacket& recvData)
{
    uint64 guid;
    std::string newName;

    recvData >> guid;
    if (!IsLegitCharacterForAccount(GUID_LOPART(guid)))
    {
        sLog->outError("Account %u, IP: %s tried to customise character %u, but it does not belong to their account!",
            GetAccountId(), GetRemoteAddress().c_str(), GUID_LOPART(guid));
        recvData.rfinish();
        KickPlayer("HandleCharCustomize");
        return;
    }

    // pussywizard:
    if (ObjectAccessor::FindPlayerInOrOutOfWorld(guid) || sWorld->FindOfflineSessionForCharacterGUID(GUID_LOPART(guid)))
    {
        recvData.rfinish();
        WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1);
        data << uint8(CHAR_CREATE_ERROR);
        SendPacket(&data);
        return;
    }

    recvData >> newName;

    uint8 gender, skin, face, hairStyle, hairColor, facialHair;
    recvData >> gender >> skin >> hairColor >> hairStyle >> facialHair >> face;

    // xinef: zomg! sync query
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_AT_LOGIN);

    stmt->setUInt32(0, GUID_LOPART(guid));

    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1);
        data << uint8(CHAR_CREATE_ERROR);
        SendPacket(&data);
        return;
    }

    // get the players old (at this moment current) race
    GlobalPlayerData const* playerData = sWorld->GetGlobalPlayerData(GUID_LOPART(guid));
    if (!playerData)
    {
        WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1);
        data << uint8(CHAR_CREATE_ERROR);
        SendPacket(&data);
        return;
    }

    Field* fields = result->Fetch();
    uint32 at_loginFlags = fields[0].GetUInt16();

    if (!(at_loginFlags & AT_LOGIN_CUSTOMIZE))
    {
        WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1);
        data << uint8(CHAR_CREATE_ERROR);
        SendPacket(&data);
        return;
    }

    // prevent character rename to invalid name
    if (!normalizePlayerName(newName))
    {
        WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1);
        data << uint8(CHAR_NAME_NO_NAME);
        SendPacket(&data);
        return;
    }

    uint8 res = ObjectMgr::CheckPlayerName(newName, true);
    if (res != CHAR_NAME_SUCCESS)
    {
        WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1);
        data << uint8(res);
        SendPacket(&data);
        return;
    }

    // check name limitations
    if (AccountMgr::IsPlayerAccount(GetSecurity()) && sObjectMgr->IsReservedName(newName))
    {
        WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1);
        data << uint8(CHAR_NAME_RESERVED);
        SendPacket(&data);
        return;
    }

    // character with this name already exist
    if (uint64 newguid = sObjectMgr->GetPlayerGUIDByName(newName))
    {
        if (newguid != guid)
        {
            WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1);
            data << uint8(CHAR_CREATE_NAME_IN_USE);
            SendPacket(&data);
            return;
        }
    }

    sLog->outChar("Account: %d (IP: %s), Character [%s] (guid: %u) Customized to: %s", GetAccountId(), GetRemoteAddress().c_str(), playerData->name.c_str(), GUID_LOPART(guid), newName.c_str());

    Player::Customize(guid, gender, skin, face, hairStyle, hairColor, facialHair);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_NAME_AT_LOGIN);

    stmt->setString(0, newName);
    stmt->setUInt16(1, uint16(AT_LOGIN_CUSTOMIZE));
    stmt->setUInt32(2, GUID_LOPART(guid));

    CharacterDatabase.Execute(stmt);

    if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_DECLINED_NAME);

        stmt->setUInt32(0, GUID_LOPART(guid));

        CharacterDatabase.Execute(stmt);
    }

    // xinef: update global data
    sWorld->UpdateGlobalNameData(GUID_LOPART(guid), playerData->name, newName);
    sWorld->UpdateGlobalPlayerData(GUID_LOPART(guid), PLAYER_UPDATE_DATA_NAME|PLAYER_UPDATE_DATA_GENDER, newName, 0, gender);

    WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1+8+(newName.size()+1)+6);
    data << uint8(RESPONSE_SUCCESS);
    data << uint64(guid);
    data << newName;
    data << uint8(gender);
    data << uint8(skin);
    data << uint8(face);
    data << uint8(hairStyle);
    data << uint8(hairColor);
    data << uint8(facialHair);
    SendPacket(&data);
}

void WorldSession::HandleEquipmentSetSave(WorldPacket &recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_EQUIPMENT_SET_SAVE");
#endif

    uint64 setGuid;
    recvData.readPackGUID(setGuid);

    uint32 index;
    recvData >> index;
    if (index >= MAX_EQUIPMENT_SET_INDEX)                    // client set slots amount
        return;

    std::string name;
    recvData >> name;

    std::string iconName;
    recvData >> iconName;

    EquipmentSet eqSet;

    eqSet.Guid      = setGuid;
    eqSet.Name      = name;
    eqSet.IconName  = iconName;
    eqSet.state     = EQUIPMENT_SET_NEW;

    for (uint32 i = 0; i < EQUIPMENT_SLOT_END; ++i)
    {
        uint64 itemGuid;
        recvData.readPackGUID(itemGuid);

        // xinef: if client sends 0, it means empty slot
        if (itemGuid == 0)
        {
            eqSet.Items[i] = 0;
            continue;
        }

        // equipment manager sends "1" (as raw GUID) for slots set to "ignore" (don't touch slot at equip set)
        if (itemGuid == 1)
        {
            // ignored slots saved as bit mask because we have no free special values for Items[i]
            eqSet.IgnoreMask |= 1 << i;
            continue;
        }

        // xinef: some cheating checks
        Item* item = _player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (!item || item->GetGUID() != itemGuid)
        {
            eqSet.Items[i] = 0;
            continue;
        }

        eqSet.Items[i] = GUID_LOPART(itemGuid);
    }

    _player->SetEquipmentSet(index, eqSet);
}

void WorldSession::HandleEquipmentSetDelete(WorldPacket &recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_EQUIPMENT_SET_DELETE");
#endif

    uint64 setGuid;
    recvData.readPackGUID(setGuid);

    _player->DeleteEquipmentSet(setGuid);
}

void WorldSession::HandleEquipmentSetUse(WorldPacket &recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_EQUIPMENT_SET_USE");
#endif

    for (uint32 i = 0; i < EQUIPMENT_SLOT_END; ++i)
    {
        uint64 itemGuid;
        recvData.readPackGUID(itemGuid);

        uint8 srcbag, srcslot;
        recvData >> srcbag >> srcslot;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "Item " UI64FMTD ": srcbag %u, srcslot %u", itemGuid, srcbag, srcslot);
#endif

        // check if item slot is set to "ignored" (raw value == 1), must not be unequipped then
        if (itemGuid == 1)
            continue;

        // Only equip weapons in combat
        if (_player->IsInCombat() && i != EQUIPMENT_SLOT_MAINHAND && i != EQUIPMENT_SLOT_OFFHAND && i != EQUIPMENT_SLOT_RANGED)
            continue;

        Item* item = NULL;
        if (itemGuid > 0)
            item = _player->GetItemByGuid(itemGuid);

        uint16 dstpos = i | (INVENTORY_SLOT_BAG_0 << 8);
        
        InventoryResult msg;

        Item* uItem = _player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (uItem) {
            if (uItem->IsEquipped()) {
                msg = _player->CanUnequipItem(dstpos, true);
                if (msg != EQUIP_ERR_OK) {
                    _player->SendEquipError(msg, uItem, NULL);
                    continue;
                }
            }

            if (!item)
            {
                ItemPosCountVec sDest;
                msg = _player->CanStoreItem(NULL_BAG, NULL_SLOT, sDest, uItem, false);
                if (msg == EQUIP_ERR_OK)
                {
                    _player->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
                    _player->StoreItem(sDest, uItem, true);
                }
                else
                    _player->SendEquipError(msg, uItem, NULL);

                continue;
            }
        }

        if (item) {
            if (item->GetPos() == dstpos)
                continue;

            if (!item->IsEquipped()) {
                uint16 _candidatePos;
                msg = _player->CanEquipItem(NULL_SLOT, _candidatePos, item, true);
                if (msg != EQUIP_ERR_OK) {
                    _player->SendEquipError(msg, item, NULL);
                    continue;
                }
            }

            _player->SwapItem(item->GetPos(), dstpos);
        }
    }

    WorldPacket data(SMSG_EQUIPMENT_SET_USE_RESULT, 1);
    data << uint8(0);                                       // 4 - equipment swap failed - inventory is full
    SendPacket(&data);
}

void WorldSession::HandleCharFactionOrRaceChange(WorldPacket& recvData)
{
    uint64 guid;
    std::string newname;
    uint8 gender, skin, face, hairStyle, hairColor, facialHair, race;
    recvData >> guid;

    if (!IsLegitCharacterForAccount(GUID_LOPART(guid)))
    {
        sLog->outError("Account %u, IP: %s tried to factionchange character %u, but it does not belong to their account!",
            GetAccountId(), GetRemoteAddress().c_str(), GUID_LOPART(guid));
        recvData.rfinish();
        KickPlayer("HandleCharFactionOrRaceChange");
        return;
    }

    // pussywizard:
    if (ObjectAccessor::FindPlayerInOrOutOfWorld(guid) || sWorld->FindOfflineSessionForCharacterGUID(GUID_LOPART(guid)))
    {
        recvData.rfinish();
        WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
        data << (uint8)CHAR_CREATE_ERROR;
        SendPacket(&data);
        return;
    }

    recvData >> newname;
    recvData >> gender >> skin >> hairColor >> hairStyle >> facialHair >> face >> race;

    uint32 lowGuid = GUID_LOPART(guid);

    // get the players old (at this moment current) race
    GlobalPlayerData const* playerData = sWorld->GetGlobalPlayerData(lowGuid);
    if (!playerData) // pussywizard: restoring character via www spoils nameData (it's not restored so it may be null)
    {
        WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
        data << (uint8)CHAR_CREATE_ERROR;
        SendPacket(&data);
        return;
    }

    // xinef: add some safety checks
    if (recvData.GetOpcode() == CMSG_CHAR_FACTION_CHANGE)
    {
        // if player is in a guild
        if (playerData->guildId && !sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GUILD))
        {
            WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
            data << (uint8)CHAR_CREATE_CHARACTER_IN_GUILD;
            SendPacket(&data);
            return;
        }

        // is arena team captain
        if (sArenaTeamMgr->GetArenaTeamByCaptain(guid))
        {
            WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
            data << (uint8)CHAR_CREATE_CHARACTER_ARENA_LEADER;
            SendPacket(&data);
            return;
        }

        // check mailbox
        if (playerData->mailCount)
        {
            WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
            data << (uint8)CHAR_CREATE_CHARACTER_DELETE_MAIL;
            SendPacket(&data);
            return;
        }

        // check auctions, current packet is processed single-threaded way, so not a problem
        bool has_auctions = false;
        for (uint8 i=0; i<2; ++i) // check both neutral and faction-specific AH
        {
            AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(i == 0 ? 0 : (((1<<(playerData->race-1))&RACEMASK_ALLIANCE) ? 12 : 29));
            AuctionHouseObject::AuctionEntryMap::const_iterator itr = auctionHouse->GetAuctionsBegin();
            AuctionHouseObject::AuctionEntryMap::const_iterator _end = auctionHouse->GetAuctionsEnd();
            for (; itr != _end; ++itr)
            {
                AuctionEntry* Aentry = itr->second;
                if (Aentry && (Aentry->owner == lowGuid || Aentry->bidder == lowGuid))
                {
                    has_auctions = true;
                    break;
                }
            }
            if (has_auctions)
                break;
        }
        if (has_auctions)
        {
            WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
            data << (uint8)CHAR_CREATE_ERROR;
            SendPacket(&data);
            return;
        }
    }

    uint8 oldRace = playerData->race;
    uint8 playerClass = playerData->playerClass;
    uint8 level = playerData->level;

    // xinef: zomg! sync query
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_AT_LOGIN_TITLES_MONEY);
    stmt->setUInt32(0, lowGuid);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
        data << uint8(CHAR_CREATE_ERROR);
        SendPacket(&data);
        return;
    }

    Field* fields = result->Fetch();
    uint32 at_loginFlags = fields[0].GetUInt16();
    char const* knownTitlesStr = fields[1].GetCString();
    uint32 money = fields[2].GetUInt32();
    uint32 used_loginFlag = ((recvData.GetOpcode() == CMSG_CHAR_RACE_CHANGE) ? AT_LOGIN_CHANGE_RACE : AT_LOGIN_CHANGE_FACTION);

    // xinef: check money
    bool valid = Player::TeamIdForRace(oldRace) == Player::TeamIdForRace(race);
    if ((level < 10 && money <= 0) || (level > 10 && level <= 30 && money <= 3000000 ) || (level > 30 && level <= 50 && money <= 10000000) ||
        (level > 50 && level <= 70 && money <= 50000000) || (level > 70 && money <= 200000000))
        valid = true;
    if (!valid)
    {
        WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
        data << uint8(CHAR_CREATE_CHARACTER_GOLD_LIMIT);
        SendPacket(&data);
        return;
    }

    // pussywizard: check titles here to prevent return while building queries
    const uint32 ktcount = KNOWN_TITLES_SIZE * 2;
    Tokenizer tokensTitles(knownTitlesStr, ' ', ktcount);
    if (recvData.GetOpcode() == CMSG_CHAR_FACTION_CHANGE)
    {
        if (tokensTitles.size() != ktcount)
        {
            WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
            data << uint8(CHAR_CREATE_ERROR);
            SendPacket(&data);
            return;
        }
    }

    if (!sObjectMgr->GetPlayerInfo(race, playerClass))
    {
        WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
        data << uint8(CHAR_CREATE_ERROR);
        SendPacket(&data);
        return;
    }

    if (!(at_loginFlags & used_loginFlag))
    {
        WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
        data << uint8(CHAR_CREATE_ERROR);
        SendPacket(&data);
        return;
    }

    if (AccountMgr::IsPlayerAccount(GetSecurity()))
    {
        uint32 raceMaskDisabled = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_DISABLED_RACEMASK);
        if ((1 << (race - 1)) & raceMaskDisabled)
        {
            WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
            data << uint8(CHAR_CREATE_ERROR);
            SendPacket(&data);
            return;
        }
    }

    // prevent character rename to invalid name
    if (!normalizePlayerName(newname))
    {
        WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
        data << uint8(CHAR_NAME_NO_NAME);
        SendPacket(&data);
        return;
    }

    uint8 res = ObjectMgr::CheckPlayerName(newname, true);
    if (res != CHAR_NAME_SUCCESS)
    {
        WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
        data << uint8(res);
        SendPacket(&data);
        return;
    }

    // check name limitations
    if (AccountMgr::IsPlayerAccount(GetSecurity()) && sObjectMgr->IsReservedName(newname))
    {
        WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
        data << uint8(CHAR_NAME_RESERVED);
        SendPacket(&data);
        return;
    }

    // character with this name already exist
    if (uint64 newguid = sObjectMgr->GetPlayerGUIDByName(newname))
    {
        if (newguid != guid)
        {
            WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
            data << uint8(CHAR_CREATE_NAME_IN_USE);
            SendPacket(&data);
            return;
        }
    }

    CharacterDatabase.EscapeString(newname);
    Player::Customize(guid, gender, skin, face, hairStyle, hairColor, facialHair);
    SQLTransaction trans = CharacterDatabase.BeginTransaction();

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_FACTION_OR_RACE);
    stmt->setString(0, newname);
    stmt->setUInt8(1, race);
    stmt->setUInt16(2, used_loginFlag);
    stmt->setUInt32(3, lowGuid);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_DECLINED_NAME);
    stmt->setUInt32(0, lowGuid);
    trans->Append(stmt);

    sLog->outChar("Account: %d (IP: %s), Character [%s] (guid: %u) Changed Race/Faction to: %s", GetAccountId(), GetRemoteAddress().c_str(), playerData->name.c_str(), lowGuid, newname.c_str());

    // xinef: update global data
    sWorld->UpdateGlobalNameData(GUID_LOPART(guid), playerData->name, newname);
    sWorld->UpdateGlobalPlayerData(GUID_LOPART(guid), 
        PLAYER_UPDATE_DATA_NAME|PLAYER_UPDATE_DATA_RACE|PLAYER_UPDATE_DATA_GENDER, newname, 0, gender, race);

    if (oldRace != race)
    {
        TeamId team = TEAM_ALLIANCE;

        // Search each faction is targeted
        switch (race)
        {
            case RACE_ORC:
            case RACE_TAUREN:
            case RACE_UNDEAD_PLAYER:
            case RACE_TROLL:
            case RACE_BLOODELF:
                team = TEAM_HORDE;
                break;
            default:
                break;
        }

        // Switch Languages
        // delete all languages first
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SKILL_LANGUAGES);
        stmt->setUInt32(0, lowGuid);
        trans->Append(stmt);

        // Now add them back
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_SKILL_LANGUAGE);
        stmt->setUInt32(0, lowGuid);

        // Faction specific languages
        if (team == TEAM_HORDE)
            stmt->setUInt16(1, 109);
        else
            stmt->setUInt16(1, 98);

        trans->Append(stmt);

        // Race specific languages
        if (race != RACE_ORC && race != RACE_HUMAN)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_SKILL_LANGUAGE);
            stmt->setUInt32(0, lowGuid);

            switch (race)
            {
                case RACE_DWARF:
                    stmt->setUInt16(1, 111);
                    break;
                case RACE_DRAENEI:
                    stmt->setUInt16(1, 759);
                    break;
                case RACE_GNOME:
                    stmt->setUInt16(1, 313);
                    break;
                case RACE_NIGHTELF:
                    stmt->setUInt16(1, 113);
                    break;
                case RACE_UNDEAD_PLAYER:
                    stmt->setUInt16(1, 673);
                    break;
                case RACE_TAUREN:
                    stmt->setUInt16(1, 115);
                    break;
                case RACE_TROLL:
                    stmt->setUInt16(1, 315);
                    break;
                case RACE_BLOODELF:
                    stmt->setUInt16(1, 137);
                    break;
            }

            trans->Append(stmt);
        }

        if (recvData.GetOpcode() == CMSG_CHAR_FACTION_CHANGE)
        {
            // Delete all Flypaths
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_TAXI_PATH);
            stmt->setUInt32(0, lowGuid);
            trans->Append(stmt);

            if (level > 7)
            {
                // Update Taxi path
                // this doesn't seem to be 100% blizzlike... but it can't really be helped.
                std::ostringstream taximaskstream;
                uint32 numFullTaximasks = level / 7;
                if (numFullTaximasks > 11)
                    numFullTaximasks = 11;
                if (team == TEAM_ALLIANCE)
                {
                    if (playerClass != CLASS_DEATH_KNIGHT)
                    {
                        for (uint8 i = 0; i < numFullTaximasks; ++i)
                            taximaskstream << uint32(sAllianceTaxiNodesMask[i]) << ' ';
                    }
                    else
                    {
                        for (uint8 i = 0; i < numFullTaximasks; ++i)
                            taximaskstream << uint32(sAllianceTaxiNodesMask[i] | sDeathKnightTaxiNodesMask[i]) << ' ';
                    }
                }
                else
                {
                    if (playerClass != CLASS_DEATH_KNIGHT)
                    {
                        for (uint8 i = 0; i < numFullTaximasks; ++i)
                            taximaskstream << uint32(sHordeTaxiNodesMask[i]) << ' ';
                    }
                    else
                    {
                        for (uint8 i = 0; i < numFullTaximasks; ++i)
                            taximaskstream << uint32(sHordeTaxiNodesMask[i] | sDeathKnightTaxiNodesMask[i]) << ' ';
                    }
                }

                uint32 numEmptyTaximasks = 11 - numFullTaximasks;
                for (uint8 i = 0; i < numEmptyTaximasks; ++i)
                    taximaskstream << "0 ";
                taximaskstream << '0';
                std::string taximask = taximaskstream.str();

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_TAXIMASK);
                stmt->setString(0, taximask);
                stmt->setUInt32(1, lowGuid);
                trans->Append(stmt);
            }

            // Reset guild
            if (!sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GUILD))
            {
                if (uint32 guildId = playerData->guildId)
                    if (Guild* guild = sGuildMgr->GetGuildById(guildId))
                        guild->DeleteMember(MAKE_NEW_GUID(lowGuid, 0, HIGHGUID_PLAYER), false, false, true);
            }

            if (!sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_ADD_FRIEND))
            {
                // Delete Friend List
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SOCIAL_BY_GUID);
                stmt->setUInt32(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SOCIAL_BY_FRIEND);
                stmt->setUInt32(0, lowGuid);
                trans->Append(stmt);
            }

            // Leave Arena Teams
            Player::LeaveAllArenaTeams(guid);

            // Reset homebind and position
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_HOMEBIND);
            stmt->setUInt32(0, lowGuid);
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PLAYER_HOMEBIND);
            stmt->setUInt32(0, lowGuid);
            if (team == TEAM_ALLIANCE)
            {
                stmt->setUInt16(1, 0);
                stmt->setUInt16(2, 1519);
                stmt->setFloat (3, -8867.68f);
                stmt->setFloat (4, 673.373f);
                stmt->setFloat (5, 97.9034f);
                Player::SavePositionInDB(0, -8867.68f, 673.373f, 97.9034f, 0.0f, 1519, lowGuid);
            }
            else
            {
                stmt->setUInt16(1, 1);
                stmt->setUInt16(2, 1637);
                stmt->setFloat (3, 1633.33f);
                stmt->setFloat (4, -4439.11f);
                stmt->setFloat (5, 15.7588f);
                Player::SavePositionInDB(1, 1633.33f, -4439.11f, 15.7588f, 0.0f, 1637, lowGuid);
            }
            trans->Append(stmt);

            // Achievement conversion
            for (std::map<uint32, uint32>::const_iterator it = sObjectMgr->FactionChangeAchievements.begin(); it != sObjectMgr->FactionChangeAchievements.end(); ++it)
            {
                uint32 achiev_alliance = it->first;
                uint32 achiev_horde = it->second;

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACHIEVEMENT_BY_ACHIEVEMENT);
                stmt->setUInt16(0, uint16(team == TEAM_ALLIANCE ? achiev_alliance : achiev_horde));
                stmt->setUInt32(1, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_ACHIEVEMENT);
                stmt->setUInt16(0, uint16(team == TEAM_ALLIANCE ? achiev_alliance : achiev_horde));
                stmt->setUInt16(1, uint16(team == TEAM_ALLIANCE ? achiev_horde : achiev_alliance));
                stmt->setUInt32(2, lowGuid);
                trans->Append(stmt);
            }

            // Item conversion
            for (std::map<uint32, uint32>::const_iterator it = sObjectMgr->FactionChangeItems.begin(); it != sObjectMgr->FactionChangeItems.end(); ++it)
            {
                uint32 item_alliance = it->first;
                uint32 item_horde = it->second;
                uint32 new_entry = (team == TEAM_ALLIANCE ? item_alliance : item_horde);
                uint32 old_entry = (team == TEAM_ALLIANCE ? item_horde : item_alliance);
                if (old_entry == 45978 /*Solid Gold Coin*/ || old_entry == 2589 /*Linen Cloth*/ || old_entry == 5976 /*Guild Tabard*/)
                    continue;

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_INVENTORY_FACTION_CHANGE);
                stmt->setUInt32(0, new_entry);
                stmt->setUInt32(1, old_entry);
                stmt->setUInt32(2, guid);
                trans->Append(stmt);
            }

            // Delete all current quests
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS);
            stmt->setUInt32(0, GUID_LOPART(guid));
            trans->Append(stmt);

            // Quest conversion
            for (std::map<uint32, uint32>::const_iterator it = sObjectMgr->FactionChangeQuests.begin(); it != sObjectMgr->FactionChangeQuests.end(); ++it)
            {
                uint32 quest_alliance = it->first;
                uint32 quest_horde = it->second;

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_REWARDED_BY_QUEST);
                stmt->setUInt32(0, lowGuid);
                stmt->setUInt32(1, (team == TEAM_ALLIANCE ? quest_alliance : quest_horde));
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_QUESTSTATUS_REWARDED_FACTION_CHANGE);
                stmt->setUInt32(0, (team == TEAM_ALLIANCE ? quest_alliance : quest_horde));
                stmt->setUInt32(1, (team == TEAM_ALLIANCE ? quest_horde : quest_alliance));
                stmt->setUInt32(2, lowGuid);
                trans->Append(stmt);
            }

            // Mark all rewarded quests as "active" (will count for completed quests achievements)
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_QUESTSTATUS_REWARDED_ACTIVE);
            stmt->setUInt32(0, lowGuid);
            trans->Append(stmt);

            // Disable all old-faction specific quests
            {
                ObjectMgr::QuestMap const& questTemplates = sObjectMgr->GetQuestTemplates();
                for (ObjectMgr::QuestMap::const_iterator iter = questTemplates.begin(); iter != questTemplates.end(); ++iter)
                {
                    Quest const* quest = iter->second;
                    uint32 newRaceMask = (team == TEAM_ALLIANCE) ? RACEMASK_ALLIANCE : RACEMASK_HORDE;
                    if (quest->GetAllowableRaces() && !(quest->GetAllowableRaces() & newRaceMask))
                    {
                        stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_QUESTSTATUS_REWARDED_ACTIVE_BY_QUEST);
                        stmt->setUInt32(0, quest->GetQuestId());
                        stmt->setUInt32(1, lowGuid);
                        trans->Append(stmt);
                    }
                }
            }

            // Spell conversion
            for (std::map<uint32, uint32>::const_iterator it = sObjectMgr->FactionChangeSpells.begin(); it != sObjectMgr->FactionChangeSpells.end(); ++it)
            {
                uint32 spell_alliance = it->first;
                uint32 spell_horde = it->second;

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SPELL_BY_SPELL);
                stmt->setUInt32(0, lowGuid);
                stmt->setUInt32(1, (team == TEAM_ALLIANCE ? spell_alliance : spell_horde));
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_SPELL_FACTION_CHANGE);
                stmt->setUInt32(0, (team == TEAM_ALLIANCE ? spell_alliance : spell_horde));
                stmt->setUInt32(1, (team == TEAM_ALLIANCE ? spell_horde : spell_alliance));
                stmt->setUInt32(2, lowGuid);
                trans->Append(stmt);
            }

            // Reputation conversion
            for (std::map<uint32, uint32>::const_iterator it = sObjectMgr->FactionChangeReputation.begin(); it != sObjectMgr->FactionChangeReputation.end(); ++it)
            {
                uint32 reputation_alliance = it->first;
                uint32 reputation_horde = it->second;
                uint32 newReputation = (team == TEAM_ALLIANCE) ? reputation_alliance : reputation_horde;
                uint32 oldReputation = (team == TEAM_ALLIANCE) ? reputation_horde : reputation_alliance;

                // select old standing set in db
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_REP_BY_FACTION);
                stmt->setUInt32(0, oldReputation);
                stmt->setUInt32(1, lowGuid);
                PreparedQueryResult result = CharacterDatabase.Query(stmt);

                if (!result)
                {
                    continue; // pussywizard
                    /*WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1);
                    data << uint8(CHAR_CREATE_ERROR);
                    SendPacket(&data);
                    return;*/
                }

                Field* fields = result->Fetch();
                int32 oldDBRep = fields[0].GetInt32();
                FactionEntry const* factionEntry = sFactionStore.LookupEntry(oldReputation);

                // old base reputation
                int32 oldBaseRep = sObjectMgr->GetBaseReputationOf(factionEntry, oldRace, playerClass);

                // new base reputation
                int32 newBaseRep = sObjectMgr->GetBaseReputationOf(sFactionStore.LookupEntry(newReputation), race, playerClass);

                // final reputation shouldnt change
                int32 FinalRep = oldDBRep + oldBaseRep;
                int32 newDBRep = FinalRep - newBaseRep;

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_REP_BY_FACTION);
                stmt->setUInt32(0, newReputation);
                stmt->setUInt32(1, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_REP_FACTION_CHANGE);
                stmt->setUInt16(0, uint16(newReputation));
                stmt->setInt32(1, newDBRep);
                stmt->setUInt16(2, uint16(oldReputation));
                stmt->setUInt32(3, lowGuid);
                trans->Append(stmt);
            }

            // Title conversion
            if (knownTitlesStr)
            {
                uint32 knownTitles[ktcount];

                //if (tokens.size() != ktcount) // pussywizard: checked at the beginning
                //    return;

                for (uint32 index = 0; index < ktcount; ++index)
                    knownTitles[index] = atol(tokensTitles[index]);

                for (std::map<uint32, uint32>::const_iterator it = sObjectMgr->FactionChangeTitles.begin(); it != sObjectMgr->FactionChangeTitles.end(); ++it)
                {
                    uint32 title_alliance = it->first;
                    uint32 title_horde = it->second;

                    CharTitlesEntry const* atitleInfo = sCharTitlesStore.LookupEntry(title_alliance);
                    CharTitlesEntry const* htitleInfo = sCharTitlesStore.LookupEntry(title_horde);
                    // new team
                    if (team == TEAM_ALLIANCE)
                    {
                        uint32 bitIndex = htitleInfo->bit_index;
                        uint32 index = bitIndex / 32;
                        uint32 old_flag = 1 << (bitIndex % 32);
                        uint32 new_flag = 1 << (atitleInfo->bit_index % 32);
                        if (knownTitles[index] & old_flag)
                        {
                            knownTitles[index] &= ~old_flag;
                            // use index of the new title
                            knownTitles[atitleInfo->bit_index / 32] |= new_flag;
                        }
                    }
                    else
                    {
                        uint32 bitIndex = atitleInfo->bit_index;
                        uint32 index = bitIndex / 32;
                        uint32 old_flag = 1 << (bitIndex % 32);
                        uint32 new_flag = 1 << (htitleInfo->bit_index % 32);
                        if (knownTitles[index] & old_flag)
                        {
                            knownTitles[index] &= ~old_flag;
                            // use index of the new title
                            knownTitles[htitleInfo->bit_index / 32] |= new_flag;
                        }
                    }

                    std::ostringstream ss;
                    for (uint32 index = 0; index < ktcount; ++index)
                        ss << knownTitles[index] << ' ';

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_TITLES_FACTION_CHANGE);
                    stmt->setString(0, ss.str().c_str());
                    stmt->setUInt32(1, lowGuid);
                    trans->Append(stmt);

                    // unset any currently chosen title
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_RES_CHAR_TITLES_FACTION_CHANGE);
                    stmt->setUInt32(0, lowGuid);
                    trans->Append(stmt);
                }
            }
        }
    }

    CharacterDatabase.CommitTransaction(trans);

    if (recvData.GetOpcode() == CMSG_CHAR_FACTION_CHANGE)
    {
        PreparedStatement* stmnt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
        stmnt->setUInt16(0, uint16(AT_LOGIN_CHECK_ACHIEVS));
        stmnt->setUInt32(1, lowGuid);
        CharacterDatabase.Execute(stmnt);
    }

    std::string IP_str = GetRemoteAddress();
    //sLog->outDebug(LOG_FILTER_PLAYER, "%s (IP: %s) changed race from %u to %u", GetPlayerInfo().c_str(), IP_str.c_str(), oldRace, race);

    WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1 + 8 + (newname.size() + 1) + 1 + 1 + 1 + 1 + 1 + 1 + 1);
    data << uint8(RESPONSE_SUCCESS);
    data << uint64(guid);
    data << newname;
    data << uint8(gender);
    data << uint8(skin);
    data << uint8(face);
    data << uint8(hairStyle);
    data << uint8(hairColor);
    data << uint8(facialHair);
    data << uint8(race);
    SendPacket(&data);
}
