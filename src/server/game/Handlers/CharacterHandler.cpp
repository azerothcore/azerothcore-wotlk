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
#include "ArenaTeamMgr.h"
#include "AuctionHouseMgr.h"
#include "Battleground.h"
#include "CalendarMgr.h"
#include "CharacterCache.h"
#include "CharacterPackets.h"
#include "Chat.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "GitRevision.h"
#include "Group.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "InstanceSaveMgr.h"
#include "Language.h"
#include "Log.h"
#include "MapMgr.h"
#include "Metric.h"
#include "MotdMgr.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Pet.h"
#include "Player.h"
#include "PlayerDump.h"
#include "QueryHolder.h"
#include "Realm.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "SocialMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "Transport.h"
#include "Util.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

class LoginQueryHolder : public CharacterDatabaseQueryHolder
{
private:
    uint32 m_accountId;
    ObjectGuid m_guid;
public:
    LoginQueryHolder(uint32 accountId, ObjectGuid guid)
        : m_accountId(accountId), m_guid(guid) { }

    ObjectGuid GetGuid() const { return m_guid; }
    uint32 GetAccountId() const { return m_accountId; }
    bool Initialize();
};

bool LoginQueryHolder::Initialize()
{
    SetSize(MAX_PLAYER_LOGIN_QUERY);

    bool res = true;
    ObjectGuid::LowType lowGuid = m_guid.GetCounter();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_FROM, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_AURAS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_AURAS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_SPELL);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_SPELLS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_QUESTSTATUS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_QUEST_STATUS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_DAILYQUESTSTATUS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_DAILY_QUEST_STATUS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_WEEKLYQUESTSTATUS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_WEEKLY_QUEST_STATUS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_MONTHLYQUESTSTATUS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_MONTHLY_QUEST_STATUS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_SEASONALQUESTSTATUS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_SEASONAL_QUEST_STATUS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_REPUTATION);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_REPUTATION, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_INVENTORY);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_INVENTORY, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_ACTIONS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_ACTIONS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAIL);
    stmt->SetData(0, lowGuid);
    stmt->SetData(1, uint32(GameTime::GetGameTime().count()));
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_MAILS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAILITEMS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_MAIL_ITEMS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_SOCIALLIST);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_SOCIAL_LIST, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_HOMEBIND);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_HOME_BIND, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_SPELLCOOLDOWNS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_SPELL_COOLDOWNS, stmt);

    if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_DECLINEDNAMES);
        stmt->SetData(0, lowGuid);
        res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_DECLINED_NAMES, stmt);
    }

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_ACHIEVEMENTS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_ACHIEVEMENTS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_CRITERIAPROGRESS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_CRITERIA_PROGRESS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_EQUIPMENTSETS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_EQUIPMENT_SETS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_ENTRY_POINT);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_ENTRY_POINT, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_GLYPHS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_GLYPHS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_TALENTS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_TALENTS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_ACCOUNT_DATA);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_ACCOUNT_DATA, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_SKILLS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_SKILLS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_RANDOMBG);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_RANDOM_BG, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_BANNED);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_BANNED, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_QUESTSTATUSREW);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_QUEST_STATUS_REW, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_BREW_OF_THE_MONTH);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_BREW_OF_THE_MONTH, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ACCOUNT_INSTANCELOCKTIMES);
    stmt->SetData(0, m_accountId);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_INSTANCE_LOCK_TIMES, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CORPSE_LOCATION);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_CORPSE_LOCATION, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_SETTINGS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_CHARACTER_SETTINGS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PETS);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_PET_SLOTS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_ACHIEVEMENT_OFFLINE_UPDATES);
    stmt->SetData(0, lowGuid);
    res &= SetPreparedQuery(PLAYER_LOGIN_QUERY_LOAD_OFFLINE_ACHIEVEMENTS_UPDATES, stmt);

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
            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>((*result)[0].Get<uint32>());
            LOG_DEBUG("network.opcode", "Loading char {} from account {}.", guid.ToString(), GetAccountId());
            if (Player::BuildEnumData(result, &data))
            {
                _legitCharacters.insert(guid);
                ++num;
            }
        } while (result->NextRow());
    }

    data.put<uint8>(0, num);

    SendPacket(&data);
}

void WorldSession::HandleCharEnumOpcode(WorldPacket& /*recvData*/)
{
    CharacterDatabasePreparedStatement* stmt = nullptr;

    /// get all the data necessary for loading all characters (along with their pets) on the account

    if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ENUM_DECLINED_NAME);
    else
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ENUM);

    stmt->SetData(0, PET_SAVE_AS_CURRENT);
    stmt->SetData(1, GetAccountId());

    _queryProcessor.AddCallback(CharacterDatabase.AsyncQuery(stmt).WithPreparedCallback(std::bind(&WorldSession::HandleCharEnum, this, std::placeholders::_1)));
}

void WorldSession::HandleCharCreateOpcode(WorldPacket& recvData)
{
    std::shared_ptr<CharacterCreateInfo> createInfo = std::make_shared<CharacterCreateInfo>();

    recvData >> createInfo->Name
             >> createInfo->Race
             >> createInfo->Class
             >> createInfo->Gender
             >> createInfo->Skin
             >> createInfo->Face
             >> createInfo->HairStyle
             >> createInfo->HairColor
             >> createInfo->FacialHair
             >> createInfo->OutfitId;

    if (AccountMgr::IsPlayerAccount(GetSecurity()))
    {
        if (uint32 mask = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_DISABLED))
        {
            if (mask & (1 << Player::TeamIdForRace(createInfo->Race)))
            {
                SendCharCreate(CHAR_CREATE_DISABLED);
                return;
            }
        }
    }

    ChrClassesEntry const* classEntry = sChrClassesStore.LookupEntry(createInfo->Class);
    if (!classEntry)
    {
        SendCharCreate(CHAR_CREATE_FAILED);
        LOG_ERROR("network.opcode", "Class ({}) not found in DBC while creating new char for account (ID: {}): wrong DBC files or cheater?", createInfo->Class, GetAccountId());
        return;
    }

    ChrRacesEntry const* raceEntry = sChrRacesStore.LookupEntry(createInfo->Race);
    if (!raceEntry)
    {
        SendCharCreate(CHAR_CREATE_FAILED);
        LOG_ERROR("network.opcode", "Race ({}) not found in DBC while creating new char for account (ID: {}): wrong DBC files or cheater?", createInfo->Race, GetAccountId());
        return;
    }

    // prevent character creating Expansion race without Expansion account
    if (raceEntry->expansion > Expansion())
    {
        SendCharCreate(CHAR_CREATE_EXPANSION);
        LOG_ERROR("network.opcode", "Expansion {} account:[{}] tried to Create character with expansion {} race ({})", Expansion(), GetAccountId(), raceEntry->expansion, createInfo->Race);
        return;
    }

    // prevent character creating Expansion class without Expansion account
    if (classEntry->expansion > Expansion())
    {
        SendCharCreate(CHAR_CREATE_EXPANSION_CLASS);
        LOG_ERROR("network.opcode", "Expansion {} account:[{}] tried to Create character with expansion {} class ({})", Expansion(), GetAccountId(), classEntry->expansion, createInfo->Class);
        return;
    }

    if (AccountMgr::IsPlayerAccount(GetSecurity()))
    {
        uint32 raceMaskDisabled = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_DISABLED_RACEMASK);
        if ((1 << (createInfo->Race - 1)) & raceMaskDisabled)
        {
            SendCharCreate(CHAR_CREATE_DISABLED);
            return;
        }

        uint32 classMaskDisabled = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_DISABLED_CLASSMASK);
        if ((1 << (createInfo->Class - 1)) & classMaskDisabled)
        {
            SendCharCreate(CHAR_CREATE_DISABLED);
            return;
        }
    }

    // prevent character creating with invalid name
    if (!normalizePlayerName(createInfo->Name))
    {
        SendCharCreate(CHAR_NAME_NO_NAME);
        LOG_ERROR("network.opcode", "Account:[{}] but tried to Create character with empty [name] ", GetAccountId());
        return;
    }

    // check name limitations
    uint8 res = ObjectMgr::CheckPlayerName(createInfo->Name, true);
    if (res != CHAR_NAME_SUCCESS)
    {
        SendCharCreate(ResponseCodes(res));
        return;
    }

    // speedup check for heroic class disabled case
    uint32 heroic_free_slots = sWorld->getIntConfig(CONFIG_HEROIC_CHARACTERS_PER_REALM);
    if (heroic_free_slots == 0 && AccountMgr::IsPlayerAccount(GetSecurity()) && createInfo->Class == CLASS_DEATH_KNIGHT)
    {
        SendCharCreate(CHAR_CREATE_UNIQUE_CLASS_LIMIT);
        return;
    }

    // speedup check for heroic class disabled case
    uint32 req_level_for_heroic = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_MIN_LEVEL_FOR_HEROIC_CHARACTER);
    if (AccountMgr::IsPlayerAccount(GetSecurity()) && createInfo->Class == CLASS_DEATH_KNIGHT && req_level_for_heroic > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
    {
        SendCharCreate(CHAR_CREATE_LEVEL_REQUIREMENT);
        return;
    }

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHECK_NAME);
    stmt->SetData(0, createInfo->Name);

    _queryProcessor.AddCallback(CharacterDatabase.AsyncQuery(stmt)
    .WithChainingPreparedCallback([this](QueryCallback& queryCallback, PreparedQueryResult result)
    {
        if (result)
        {
            SendCharCreate(CHAR_CREATE_NAME_IN_USE);
            return;
        }

        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_SUM_REALM_CHARACTERS);
        stmt->SetData(0, GetAccountId());
        queryCallback.SetNextQuery(LoginDatabase.AsyncQuery(stmt));
    })
    .WithChainingPreparedCallback([this](QueryCallback& queryCallback, PreparedQueryResult result)
    {
        uint64 acctCharCount = 0;
        if (result)
        {
            Field* fields = result->Fetch();
            acctCharCount = uint64(fields[0].Get<double>());
        }

        if (acctCharCount >= static_cast<uint64>(sWorld->getIntConfig(CONFIG_CHARACTERS_PER_ACCOUNT)))
        {
            SendCharCreate(CHAR_CREATE_ACCOUNT_LIMIT);
            return;
        }

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_SUM_CHARS);
        stmt->SetData(0, GetAccountId());
        queryCallback.SetNextQuery(CharacterDatabase.AsyncQuery(stmt));
    })
    .WithChainingPreparedCallback([this, createInfo](QueryCallback& queryCallback, PreparedQueryResult result)
    {
        if (result)
        {
            Field* fields = result->Fetch();
            createInfo->CharCount = uint8(fields[0].Get<uint64>()); // SQL's COUNT() returns uint64 but it will always be less than uint8.Max

            if (createInfo->CharCount >= sWorld->getIntConfig(CONFIG_CHARACTERS_PER_REALM))
            {
                SendCharCreate(CHAR_CREATE_SERVER_LIMIT);
                return;
            }
        }

        bool allowTwoSideAccounts = !sWorld->IsPvPRealm() || sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_ACCOUNTS) || !AccountMgr::IsPlayerAccount(GetSecurity());
        uint32 skipCinematics = sWorld->getIntConfig(CONFIG_SKIP_CINEMATICS);

        std::function<void(PreparedQueryResult)> finalizeCharacterCreation = [this, createInfo](PreparedQueryResult result)
        {
            if (!sScriptMgr->CanAccountCreateCharacter(GetAccountId(), createInfo->Race, createInfo->Class))
            {
                SendCharCreate(CHAR_CREATE_DISABLED);
                return;
            }
            bool haveSameRace = false;
            uint32 heroicReqLevel = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_MIN_LEVEL_FOR_HEROIC_CHARACTER);
            bool hasHeroicReqLevel = (heroicReqLevel == 0);
            bool allowTwoSideAccounts = !sWorld->IsPvPRealm() || sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_ACCOUNTS) || !AccountMgr::IsPlayerAccount(GetSecurity());
            uint32 skipCinematics = sWorld->getIntConfig(CONFIG_SKIP_CINEMATICS);
            bool checkDeathKnightReqs = AccountMgr::IsPlayerAccount(GetSecurity()) && createInfo->Class == CLASS_DEATH_KNIGHT;

            if (result)
            {
                TeamId teamId = Player::TeamIdForRace(createInfo->Race);
                uint32 freeDeathKnightSlots = sWorld->getIntConfig(CONFIG_HEROIC_CHARACTERS_PER_REALM);

                Field* field = result->Fetch();
                uint8 accRace = field[1].Get<uint8>();

                if (checkDeathKnightReqs)
                {
                    uint8 accClass = field[2].Get<uint8>();
                    if (accClass == CLASS_DEATH_KNIGHT)
                    {
                        if (freeDeathKnightSlots > 0)
                            --freeDeathKnightSlots;

                        if (freeDeathKnightSlots == 0)
                        {
                            SendCharCreate(CHAR_CREATE_UNIQUE_CLASS_LIMIT);
                            return;
                        }
                    }

                    if (!hasHeroicReqLevel)
                    {
                        uint8 accLevel = field[0].Get<uint8>();
                        if (accLevel >= heroicReqLevel)
                            hasHeroicReqLevel = true;
                    }
                }

                // need to check team only for first character
                /// @todo what to if account already has characters of both races?
                if (!allowTwoSideAccounts)
                {
                    uint32 accTeam = 0;
                    if (accRace > 0)
                        accTeam = Player::TeamIdForRace(accRace);

                    if (accTeam != teamId)
                    {
                        SendCharCreate(CHAR_CREATE_PVP_TEAMS_VIOLATION);
                        return;
                    }
                }

                // search same race for cinematic or same class if need
                /// @todo check if cinematic already shown? (already logged in?; cinematic field)
                while ((skipCinematics == 1 && !haveSameRace) || createInfo->Class == CLASS_DEATH_KNIGHT)
                {
                    if (!result->NextRow())
                        break;

                    field = result->Fetch();
                    accRace = field[1].Get<uint8>();

                    if (!haveSameRace)
                        haveSameRace = createInfo->Race == accRace;

                    if (checkDeathKnightReqs)
                    {
                        uint8 acc_class = field[2].Get<uint8>();
                        if (acc_class == CLASS_DEATH_KNIGHT)
                        {
                            if (freeDeathKnightSlots > 0)
                                --freeDeathKnightSlots;

                            if (freeDeathKnightSlots == 0)
                            {
                                SendCharCreate(CHAR_CREATE_UNIQUE_CLASS_LIMIT);
                                return;
                            }
                        }

                        if (!hasHeroicReqLevel)
                        {
                            uint8 acc_level = field[0].Get<uint8>();
                            if (acc_level >= heroicReqLevel)
                                hasHeroicReqLevel = true;
                        }
                    }
                }
            }

            if (checkDeathKnightReqs && !hasHeroicReqLevel)
            {
                SendCharCreate(CHAR_CREATE_LEVEL_REQUIREMENT);
                return;
            }

            // Check name uniqueness in the same step as saving to database
            if (sCharacterCache->GetCharacterGuidByName(createInfo->Name))
            {
                SendCharCreate(CHAR_CREATE_NAME_IN_USE);
                return;
            }

            std::shared_ptr<Player> newChar(new Player(this), [](Player* ptr)
            {
                // Only when player is created correctly do clean
                if (ptr->HasAtLoginFlag(AT_LOGIN_FIRST))
                {
                    ptr->CleanupsBeforeDelete();
                }
                delete ptr;
            });

            newChar->GetMotionMaster()->Initialize();
            if (!newChar->Create(sObjectMgr->GetGenerator<HighGuid::Player>().Generate(), createInfo.get()))
            {
                // Player not create (race/class/etc problem?)
                SendCharCreate(CHAR_CREATE_ERROR);
                return;
            }

            if ((haveSameRace && skipCinematics == 1) || skipCinematics == 2)
                newChar->setCinematic(1);                         // not show intro

            newChar->SetAtLoginFlag(AT_LOGIN_FIRST);              // First login

            CharacterDatabaseTransaction characterTransaction = CharacterDatabase.BeginTransaction();
            LoginDatabaseTransaction trans = LoginDatabase.BeginTransaction();

            // Player created, save it now
            newChar->SaveToDB(characterTransaction, true, false);
            createInfo->CharCount++;

            LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_REP_REALM_CHARACTERS);
            stmt->SetData(0, createInfo->CharCount);
            stmt->SetData(1, GetAccountId());
            stmt->SetData(2, realm.Id.Realm);
            trans->Append(stmt);

            LoginDatabase.CommitTransaction(trans);

            AddTransactionCallback(CharacterDatabase.AsyncCommitTransaction(characterTransaction)).AfterComplete([this, newChar = std::move(newChar)](bool success)
            {
                if (success)
                {
                    LOG_INFO("entities.player.character", "Account: {} (IP: {}) Create Character: {} {}", GetAccountId(), GetRemoteAddress(), newChar->GetName(), newChar->GetGUID().ToString());
                    sScriptMgr->OnPlayerCreate(newChar.get());
                    sCharacterCache->AddCharacterCacheEntry(newChar->GetGUID(), GetAccountId(), newChar->GetName(), newChar->getGender(), newChar->getRace(), newChar->getClass(), newChar->GetLevel());
                    SendCharCreate(CHAR_CREATE_SUCCESS);
                }
                else
                    SendCharCreate(CHAR_CREATE_ERROR);
            });
        };

        if (allowTwoSideAccounts && !skipCinematics && createInfo->Class != CLASS_DEATH_KNIGHT)
        {
            finalizeCharacterCreation(PreparedQueryResult(nullptr));
            return;
        }

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_CREATE_INFO);
        stmt->SetData(0, GetAccountId());
        stmt->SetData(1, (skipCinematics == 1 || createInfo->Class == CLASS_DEATH_KNIGHT) ? 10 : 1);
        queryCallback.WithPreparedCallback(std::move(finalizeCharacterCreation)).SetNextQuery(CharacterDatabase.AsyncQuery(stmt));
    }));
}

void WorldSession::HandleCharDeleteOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    recvData >> guid;

    // Initiating
    uint32 initAccountId = GetAccountId();

    // can't delete loaded character
    if (ObjectAccessor::FindConnectedPlayer(guid) || sWorld->FindOfflineSessionForCharacterGUID(guid.GetCounter()))
    {
        sScriptMgr->OnPlayerFailedDelete(guid, initAccountId);
        return;
    }

    uint32 accountId = 0;
    uint8 level = 0;
    std::string name;

    // is guild leader
    if (sGuildMgr->GetGuildByLeader(guid))
    {
        sScriptMgr->OnPlayerFailedDelete(guid, initAccountId);
        SendCharDelete(CHAR_DELETE_FAILED_GUILD_LEADER);
        return;
    }

    // is arena team captain
    if (sArenaTeamMgr->GetArenaTeamByCaptain(guid))
    {
        sScriptMgr->OnPlayerFailedDelete(guid, initAccountId);
        SendCharDelete(CHAR_DELETE_FAILED_ARENA_CAPTAIN);
        return;
    }

    if (CharacterCacheEntry const* playerData = sCharacterCache->GetCharacterCacheByGuid(guid))
    {
        accountId = playerData->AccountId;
        name = playerData->Name;
        level = playerData->Level;
    }

    // prevent deleting other players' characters using cheating tools
    if (accountId != initAccountId)
    {
        sScriptMgr->OnPlayerFailedDelete(guid, initAccountId);
        return;
    }

    LOG_INFO("entities.player.character", "Account: {}, IP: {} deleted character: {}, {}, Level: {}", accountId, GetRemoteAddress(), name, guid.ToString(), level);

    // To prevent hook failure, place hook before removing reference from DB
    sScriptMgr->OnPlayerDelete(guid, initAccountId); // To prevent race conditioning, but as it also makes sense, we hand the accountId over for successful delete.
    sCalendarMgr->RemoveAllPlayerEventsAndInvites(guid);
    Player::DeleteFromDB(guid.GetCounter(), GetAccountId(), true, false);

    sWorld->UpdateRealmCharCount(GetAccountId());

    SendCharDelete(CHAR_DELETE_SUCCESS);
}

void WorldSession::HandlePlayerLoginOpcode(WorldPacket& recvData)
{
    m_playerLoading = true;
    ObjectGuid playerGuid;
    recvData >> playerGuid;

    if (PlayerLoading() || GetPlayer() != nullptr || !playerGuid.IsPlayer())
    {
        // limit player interaction with the world
        if (!sWorld->getBoolConfig(CONFIG_REALM_LOGIN_ENABLED))
        {
            WorldPacket data(SMSG_CHARACTER_LOGIN_FAILED, 1);
            // see LoginFailureReason enum for more reasons
            data << uint8(LoginFailureReason::NoWorld);
            SendPacket(&data);
            return;
        }
    }

    if (!playerGuid.IsPlayer() || !IsLegitCharacterForAccount(playerGuid))
    {
        LOG_ERROR("network", "Account ({}) can't login with that character ({}).", GetAccountId(), playerGuid.ToString());
        KickPlayer("Account can't login with this character");
        return;
    }

    auto SendCharLogin = [&](ResponseCodes result)
    {
        WorldPacket data(SMSG_CHARACTER_LOGIN_FAILED, 1);
        data << uint8(result);
        SendPacket(&data);
    };

    // pussywizard:
    if (WorldSession* sess = sWorld->FindOfflineSessionForCharacterGUID(playerGuid.GetCounter()))
        if (sess->GetAccountId() != GetAccountId())
        {
            SendCharLogin(CHAR_LOGIN_DUPLICATE_CHARACTER);
            return;
        }
    // pussywizard:
    if (WorldSession* sess = sWorld->FindOfflineSession(GetAccountId()))
    {
        Player* p = sess->GetPlayer();
        if (!p || sess->IsKicked())
        {
            SendCharLogin(CHAR_LOGIN_DUPLICATE_CHARACTER);
            return;
        }

        if (p->GetGUID() != playerGuid)
            sess->KickPlayer("No return, go to normal loading"); // no return, go to normal loading
        else
        {
            // pussywizard: players stay ingame no matter what (prevent abuse), but allow to turn it off to stop crashing
            if (!sWorld->getBoolConfig(CONFIG_ENABLE_LOGIN_AFTER_DC))
            {
                SendCharLogin(CHAR_LOGIN_DUPLICATE_CHARACTER);
                return;
            }

            uint8 limitA = 10, limitB = 10, limitC = 10; // pussywizard: this somehow froze (probably, ahh crash logs ...), and while (far) have never frozen in LogoutPlayer o_O maybe it's the combination of while(far); while(near);
            while (sess->GetPlayer() && (sess->GetPlayer()->IsBeingTeleportedFar() || (sess->GetPlayer()->IsInWorld() && sess->GetPlayer()->IsBeingTeleportedNear())))
            {
                if (limitA == 0 || --limitA == 0)
                {
                    LOG_INFO("misc", "HandlePlayerLoginOpcode A");
                    break;
                }
                while (sess->GetPlayer() && sess->GetPlayer()->IsBeingTeleportedFar())
                {
                    if (limitB == 0 || --limitB == 0)
                    {
                        LOG_INFO("misc", "HandlePlayerLoginOpcode B");
                        break;
                    }
                    sess->HandleMoveWorldportAck();
                }
                while (sess->GetPlayer() && sess->GetPlayer()->IsInWorld() && sess->GetPlayer()->IsBeingTeleportedNear())
                {
                    if (limitC == 0 || --limitC == 0)
                    {
                        LOG_INFO("misc", "HandlePlayerLoginOpcode C");
                        break;
                    }

                    Player* plMover = sess->GetPlayer()->m_mover->ToPlayer();
                    if (!plMover)
                        break;

                    WorldPacket pkt(MSG_MOVE_TELEPORT_ACK, 20);
                    pkt << plMover->GetPackGUID();
                    pkt << uint32(0); // flags
                    pkt << uint32(0); // time
                    sess->HandleMoveTeleportAck(pkt);
                }
            }
            if (!p->FindMap() || !p->IsInWorld() || sess->IsKicked())
            {
                SendCharLogin(CHAR_LOGIN_DUPLICATE_CHARACTER);
                return;
            }

            sess->SetPlayer(nullptr);
            SetPlayer(p);
            p->SetSession(this);
            delete p->PlayerTalkClass;
            p->PlayerTalkClass = new PlayerMenu(p->GetSession());
            HandlePlayerLoginToCharInWorld(p);
            return;
        }
    }

    std::shared_ptr<LoginQueryHolder> holder = std::make_shared<LoginQueryHolder>(GetAccountId(), playerGuid);
    if (!holder->Initialize())
    {
        m_playerLoading = false;
        return;
    }

    AddQueryHolderCallback(CharacterDatabase.DelayQueryHolder(holder)).AfterComplete([this](SQLQueryHolderBase const& holder)
    {
        HandlePlayerLoginFromDB(static_cast<LoginQueryHolder const&>(holder));
    });
}

void WorldSession::HandlePlayerLoginFromDB(LoginQueryHolder const& holder)
{
    ObjectGuid playerGuid = holder.GetGuid();

    Player* pCurrChar = new Player(this);
    // for send server info and strings (config)
    ChatHandler chH = ChatHandler(pCurrChar->GetSession());

    // "GetAccountId() == db stored account id" checked in LoadFromDB (prevent login not own character using cheating tools)
    if (!pCurrChar->LoadFromDB(playerGuid, holder))
    {
        SetPlayer(nullptr);
        KickPlayer("WorldSession::HandlePlayerLogin Player::LoadFromDB failed"); // disconnect client, player no set to session and it will not deleted or saved at kick
        delete pCurrChar; // delete it manually
        m_playerLoading = false;
        return;
    }

    pCurrChar->GetMotionMaster()->Initialize();
    pCurrChar->SendDungeonDifficulty(false);

    WorldPacket data(SMSG_LOGIN_VERIFY_WORLD, 20);
    data << pCurrChar->GetMapId();
    data << pCurrChar->GetPositionX();
    data << pCurrChar->GetPositionY();
    data << pCurrChar->GetPositionZ();
    data << pCurrChar->GetOrientation();
    SendPacket(&data);

    // load player specific part before send times
    LoadAccountData(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_ACCOUNT_DATA), PER_CHARACTER_CACHE_MASK);
    SendAccountDataTimes(PER_CHARACTER_CACHE_MASK);

    data.Initialize(SMSG_FEATURE_SYSTEM_STATUS, 2);         // added in 2.2.0
    data << uint8(2);                                       // 2 - COMPLAINT_ENABLED_WITH_AUTO_IGNORE
    data << uint8(0);                                       // enable(1)/disable(0) voice chat interface in client
    SendPacket(&data);

    // Send MOTD
    {
        SendPacket(sMotdMgr->GetMotdPacket());

        // send server info
        if (sWorld->getIntConfig(CONFIG_ENABLE_SINFO_LOGIN) == 1)
            chH.PSendSysMessage("{}", GitRevision::GetFullVersion());
    }

    if (uint32 guildId = sCharacterCache->GetCharacterGuildIdByGuid(pCurrChar->GetGUID()))
    {
        Guild* guild = sGuildMgr->GetGuildById(guildId);
        Guild::Member const* member = guild ? guild->GetMember(pCurrChar->GetGUID()) : nullptr;
        if (member)
        {
            pCurrChar->SetInGuild(guildId);
            pCurrChar->SetRank(member->GetRankId());
            guild->SendLoginInfo(this);
        }
        else
        {
            LOG_ERROR("network.opcode", "Player {} ({}) marked as member of not existing guild (id: {}), removing guild membership for player.",
                pCurrChar->GetName(), pCurrChar->GetGUID().ToString(), guildId);
            pCurrChar->SetInGuild(0);
            pCurrChar->SetRank(0);
        }
    }
    else
    {
        pCurrChar->SetInGuild(0);
        pCurrChar->SetRank(0);
    }

    data.Initialize(SMSG_LEARNED_DANCE_MOVES, 4 + 4);
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
                chH.PSendSysMessage("{}", sWorld->GetNewCharString());
        }
    }

    // Xinef: moved this from below
    ObjectAccessor::AddObject(pCurrChar);

    if (!pCurrChar->GetMap()->AddPlayerToMap(pCurrChar) || !pCurrChar->CheckInstanceLoginValid())
    {
        AreaTriggerTeleport const* at = sObjectMgr->GetGoBackTrigger(pCurrChar->GetMapId());
        if (at)
            pCurrChar->TeleportTo(at->target_mapId, at->target_X, at->target_Y, at->target_Z, pCurrChar->GetOrientation());
        else
            pCurrChar->TeleportTo(pCurrChar->m_homebindMapId, pCurrChar->m_homebindX, pCurrChar->m_homebindY, pCurrChar->m_homebindZ, pCurrChar->GetOrientation());

        // Probably a hackfix, but currently the best workaround to prevent character names showing as Unknown after teleport out from instances at login.
        pCurrChar->GetSession()->SendNameQueryOpcode(pCurrChar->GetGUID());
    }

    pCurrChar->SendInitialPacketsAfterAddToMap();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_ONLINE);
    stmt->SetData(0, pCurrChar->GetGUID().GetCounter());
    CharacterDatabase.Execute(stmt);

    LoginDatabasePreparedStatement* loginStmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_ONLINE);
    loginStmt->SetData(0, realm.Id.Realm);
    loginStmt->SetData(1, GetAccountId());
    LoginDatabase.Execute(loginStmt);

    pCurrChar->SetInGameTime(GameTime::GetGameTimeMS().count());

    // announce group about member online (must be after add to player list to receive announce to self)
    if (Group* group = pCurrChar->GetGroup())
    {
        group->SendUpdate();
        group->ResetMaxEnchantingLevel();
    }

    // pussywizard: send instance welcome message as when entering the instance through a portal
    if (MapDifficulty const* mapDiff = GetMapDifficultyData(pCurrChar->GetMap()->GetId(), pCurrChar->GetMap()->GetDifficulty()))
        if (mapDiff->resetTime)
            if (time_t timeReset = sInstanceSaveMgr->GetResetTimeFor(pCurrChar->GetMap()->GetId(), pCurrChar->GetMap()->GetDifficulty()))
            {
                uint32 timeleft = uint32(timeReset - GameTime::GetGameTime().count());
                pCurrChar->SendInstanceResetWarning(pCurrChar->GetMap()->GetId(), pCurrChar->GetMap()->GetDifficulty(), timeleft, true);
            }

    // pussywizard: ensure that we end up on map with our loaded transport:
    if (Transport* t = pCurrChar->GetTransport())
        if (!t->IsInMap(pCurrChar))
        {
            t->RemovePassenger(pCurrChar);
            pCurrChar->m_transport = nullptr;
            pCurrChar->m_movementInfo.transport.Reset();
            pCurrChar->m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
        }

    // friend status
    sSocialMgr->SendFriendStatus(pCurrChar, FRIEND_ONLINE, pCurrChar->GetGUID(), true);

    // Place character in world (and load zone) before some object loading
    pCurrChar->LoadCorpse(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_CORPSE_LOCATION));

    // setting Ghost+speed if dead
    if (pCurrChar->m_deathState != DeathState::Alive)
    {
        // not blizz like, we must correctly save and load player instead...
        if (pCurrChar->getRace() == RACE_NIGHTELF)
            pCurrChar->CastSpell(pCurrChar, 20584, true, 0); // auras SPELL_AURA_INCREASE_SPEED(+speed in wisp form), SPELL_AURA_INCREASE_SWIM_SPEED(+swim speed in wisp form), SPELL_AURA_TRANSFORM (to wisp form)

        pCurrChar->CastSpell(pCurrChar, 8326, true, 0);     // auras SPELL_AURA_GHOST, SPELL_AURA_INCREASE_SPEED(why?), SPELL_AURA_INCREASE_SWIM_SPEED(why?)
        pCurrChar->SetMovement(MOVE_WATER_WALK);
    }

    // Set FFA PvP for non GM in non-rest mode
    if (sWorld->IsFFAPvPRealm() && !pCurrChar->IsGameMaster() && !pCurrChar->HasPlayerFlag(PLAYER_FLAGS_RESTING))
        if (!pCurrChar->HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP))
        {
            sScriptMgr->OnFfaPvpStateUpdate(pCurrChar,true);
            pCurrChar->SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
        }

    if (pCurrChar->HasPlayerFlag(PLAYER_FLAGS_CONTESTED_PVP))
    {
        pCurrChar->SetContestedPvP(nullptr, false);
    }

    // Apply at_login requests
    if (pCurrChar->HasAtLoginFlag(AT_LOGIN_RESET_SPELLS))
    {
        pCurrChar->resetSpells();
        ChatHandler(this).SendNotification(LANG_RESET_SPELLS);
    }

    if (pCurrChar->HasAtLoginFlag(AT_LOGIN_RESET_TALENTS))
    {
        pCurrChar->resetTalents(true);
        pCurrChar->SendTalentsInfoData(false);              // original talents send already in to SendInitialPacketsBeforeAddToMap, resend reset state
        ChatHandler(this).SendNotification(LANG_RESET_TALENTS);
    }

    if (pCurrChar->HasAtLoginFlag(AT_LOGIN_CHECK_ACHIEVS))
    {
        // If we process the check while players are loading they won't be notified of the changes.
        pCurrChar->m_Events.AddEventAtOffset([pCurrChar]
        {
            pCurrChar->RemoveAtLoginFlag(AT_LOGIN_CHECK_ACHIEVS, true);
            pCurrChar->CheckAllAchievementCriteria();
        }, 1s);
    }

    bool firstLogin = pCurrChar->HasAtLoginFlag(AT_LOGIN_FIRST);
    if (firstLogin)
    {
        PlayerInfo const* info = sObjectMgr->GetPlayerInfo(pCurrChar->getRace(), pCurrChar->getClass());
        for (uint32 spellId : info->castSpells)
        {
            pCurrChar->CastSpell(pCurrChar, spellId, true);
        }

        // start with every map explored
        if (sWorld->getBoolConfig(CONFIG_START_ALL_EXPLORED))
        {
            for (uint8 i = 0; i < PLAYER_EXPLORED_ZONES_SIZE; i++)
            {
                pCurrChar->SetFlag(PLAYER_EXPLORED_ZONES_1 + i, 0xFFFFFFFF);
            }
        }

        // Reputations if "StartAllReputation" is enabled, -- TODO: Fix this in a better way
        if (sWorld->getBoolConfig(CONFIG_START_ALL_REP))
        {
            ReputationMgr& repMgr = pCurrChar->GetReputationMgr();

            auto SendFullReputation = [&repMgr](std::initializer_list<uint32> factionsList)
            {
                for (auto const& itr : factionsList)
                {
                    repMgr.SetOneFactionReputation(sFactionStore.LookupEntry(itr), 42999.f, false);
                }
            };

            SendFullReputation({ 942, 935, 936, 1011, 970, 967, 989, 932, 934, 1038, 1077, 1106, 1104, 1090, 1098, 1156, 1073, 1105, 1119, 1091 });

            switch (pCurrChar->GetFaction())
            {
                case ALLIANCE:
                    SendFullReputation({ 72, 47, 69, 930, 730, 978, 54, 946, 1037, 1068, 1126, 1094, 1050 });
                    break;
                case HORDE:
                    SendFullReputation({ 76, 68, 81, 911, 729, 941, 530, 947, 1052, 1067, 1124, 1064, 1085 });
                    break;
                default:
                    break;
            }

            repMgr.SendStates();
        }
    }

    // show time before shutdown if shutdown planned.
    if (sWorld->IsShuttingDown())
        sWorld->ShutdownMsg(true, pCurrChar);

    if (sWorld->getBoolConfig(CONFIG_ALL_TAXI_PATHS))
        pCurrChar->SetTaxiCheater(true);

    if (pCurrChar->IsGameMaster())
        ChatHandler(this).SendNotification(LANG_GM_ON);

    std::string IP_str = GetRemoteAddress();
    LOG_INFO("entities.player", "Account: {} (IP: {}) Login Character:[{}] ({}) Level: {}",
                  GetAccountId(), IP_str, pCurrChar->GetName(), pCurrChar->GetGUID().ToString(), pCurrChar->GetLevel());

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
    pCurrChar->RemovePlayerFlag(PLAYER_FLAGS_PVP_TIMER);
    if (pCurrChar->HasPlayerFlag(PLAYER_FLAGS_IN_PVP))
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

        for (auto const& [accID, session] : sWorld->GetAllSessions())
        {
            if (!session->GetRecruiterId() && !session->IsARecruiter())
                continue;

            if ((isReferrer && pCurrChar->GetSession()->GetAccountId() == session->GetRecruiterId()) || (!isReferrer && pCurrChar->GetSession()->GetRecruiterId() == session->GetAccountId()))
            {
                Player* rf = session->GetPlayer();
                if (rf)
                {
                    pCurrChar->SendUpdateToPlayer(rf);
                    rf->SendUpdateToPlayer(pCurrChar);
                }
            }
        }
    }

    sScriptMgr->OnPlayerLogin(pCurrChar);

    if (pCurrChar->HasAtLoginFlag(AT_LOGIN_FIRST))
    {
        pCurrChar->RemoveAtLoginFlag(AT_LOGIN_FIRST);
        sScriptMgr->OnFirstLogin(pCurrChar);
    }

    METRIC_EVENT("player_events", "Login", pCurrChar->GetName());
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
    data << pCurrChar->GetPositionZ();
    data << pCurrChar->GetOrientation();
    SendPacket(&data);

    SendAccountDataTimes(PER_CHARACTER_CACHE_MASK);

    data.Initialize(SMSG_FEATURE_SYSTEM_STATUS, 2);         // added in 2.2.0
    data << uint8(2);                                       // unknown value
    data << uint8(0);                                       // enable(1)/disable(0) voice chat interface in client
    SendPacket(&data);

    // Send MOTD
    {
        SendPacket(sMotdMgr->GetMotdPacket());

        // send server info
        if (sWorld->getIntConfig(CONFIG_ENABLE_SINFO_LOGIN) == 1)
            chH.PSendSysMessage("{}", GitRevision::GetFullVersion());

        LOG_DEBUG("network.opcode", "WORLD: Sent server info");
    }

    data.Initialize(SMSG_LEARNED_DANCE_MOVES, 4 + 4);
    data << uint32(0);
    data << uint32(0);
    SendPacket(&data);

    // Xinef: fix possible problem with flag UNIT_FLAG_STUNNED added during logout
    if (!pCurrChar->HasUnitState(UNIT_STATE_STUNNED))
        pCurrChar->RemoveUnitFlag(UNIT_FLAG_STUNNED);

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
    pCurrChar->GetZoneAndAreaId(currZone, currArea);
    pCurrChar->SendInitWorldStates(currZone, currArea);
    pCurrChar->SetInGameTime(GameTime::GetGameTimeMS().count());

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
                if (eff != 0 && eff % 32 == 0)
                    _mask[i++] = 0;

                _mask[i] = uint32(1) << (eff - (32 * i));
                int32 val = 0;
                for (auto const& spellMod : spellMods)
                    if (spellMod->type == modType && spellMod->mask & _mask)
                        val += spellMod->value;

                if (val == 0)
                    continue;

                WorldPacket data(Opcode, (1 + 1 + 4));
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
                uint32 timeleft = uint32(timeReset - GameTime::GetGameTime().count());
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
        ChatHandler(pCurrChar->GetSession()).SendNotification(LANG_GM_ON);

    m_playerLoading = false;
}

void WorldSession::HandlePlayerLoginToCharOutOfWorld(Player* /*pCurrChar*/)
{
    ABORT();
}

void WorldSession::HandleSetFactionAtWar(WorldPacket& recvData)
{
    uint32 repListID;
    uint8  flag;

    recvData >> repListID;
    recvData >> flag;

    GetPlayer()->GetReputationMgr().SetAtWar(repListID, flag);
}

//I think this function is never used :/ I dunno, but i guess this opcode not exists
void WorldSession::HandleSetFactionCheat(WorldPacket& /*recvData*/)
{
    LOG_ERROR("network.opcode", "WORLD SESSION: HandleSetFactionCheat, not expected call, please report.");
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

void WorldSession::HandleTutorialClear(WorldPacket& /*recvData*/)
{
    for (uint8 i = 0; i < MAX_ACCOUNT_TUTORIAL_VALUES; ++i)
        SetTutorialInt(i, 0xFFFFFFFF);
}

void WorldSession::HandleTutorialReset(WorldPacket& /*recvData*/)
{
    for (uint8 i = 0; i < MAX_ACCOUNT_TUTORIAL_VALUES; ++i)
        SetTutorialInt(i, 0x00000000);
}

void WorldSession::HandleSetWatchedFactionOpcode(WorldPacket& recvData)
{
    uint32 fact;
    recvData >> fact;
    GetPlayer()->SetUInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX, fact);
}

void WorldSession::HandleSetFactionInactiveOpcode(WorldPacket& recvData)
{
    uint32 replistid;
    uint8 inactive;
    recvData >> replistid >> inactive;

    _player->GetReputationMgr().SetInactive(replistid, inactive);
}

void WorldSession::HandleShowingHelmOpcode(WorldPackets::Character::ShowingHelm& packet)
{
    if (packet.ShowHelm)
        _player->RemovePlayerFlag(PLAYER_FLAGS_HIDE_HELM);
    else
        _player->SetPlayerFlag(PLAYER_FLAGS_HIDE_HELM);
}

void WorldSession::HandleShowingCloakOpcode(WorldPackets::Character::ShowingCloak& packet)
{
    if (packet.ShowCloak)
        _player->RemovePlayerFlag(PLAYER_FLAGS_HIDE_CLOAK);
    else
        _player->SetPlayerFlag(PLAYER_FLAGS_HIDE_CLOAK);
}

void WorldSession::HandleCharRenameOpcode(WorldPacket& recvData)
{
    std::shared_ptr<CharacterRenameInfo> renameInfo = std::make_shared<CharacterRenameInfo>();

    recvData >> renameInfo->Guid
             >> renameInfo->Name;

    // prevent character rename to invalid name
    if (!normalizePlayerName(renameInfo->Name))
    {
        SendCharRename(CHAR_NAME_NO_NAME, renameInfo.get());
        return;
    }

    uint8 res = ObjectMgr::CheckPlayerName(renameInfo->Name, true);
    if (res != CHAR_NAME_SUCCESS)
    {
        SendCharRename(ResponseCodes(res), renameInfo.get());
        return;
    }

    // Ensure that the character belongs to the current account, that rename at login is enabled
    // and that there is no character with the desired new name
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_FREE_NAME);

    stmt->SetData(0, renameInfo->Guid.GetCounter());
    stmt->SetData(1, GetAccountId());
    stmt->SetData(2, renameInfo->Name);

    _queryProcessor.AddCallback(CharacterDatabase.AsyncQuery(stmt)
        .WithPreparedCallback(std::bind(&WorldSession::HandleCharRenameCallBack, this, renameInfo, std::placeholders::_1)));
}

void WorldSession::HandleCharRenameCallBack(std::shared_ptr<CharacterRenameInfo> renameInfo, PreparedQueryResult result)
{
    if (!result)
    {
        SendCharRename(CHAR_CREATE_ERROR, renameInfo.get());
        return;
    }

    Field* fields = result->Fetch();

    ObjectGuid::LowType guidLow = fields[0].Get<uint32>();
    std::string oldName = fields[1].Get<std::string>();
    uint16 atLoginFlags = fields[2].Get<uint16>();

    if (!(atLoginFlags & AT_LOGIN_RENAME))
    {
        SendCharRename(CHAR_CREATE_ERROR, renameInfo.get());
        return;
    }

    atLoginFlags &= ~AT_LOGIN_RENAME;

    // pussywizard:
    if (ObjectAccessor::FindConnectedPlayer(ObjectGuid::Create<HighGuid::Player>(guidLow)) || sWorld->FindOfflineSessionForCharacterGUID(guidLow))
    {
        SendCharRename(CHAR_CREATE_ERROR, renameInfo.get());
        return;
    }

    // Update name and at_login flag in the db
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_NAME_AT_LOGIN);
    stmt->SetData(0, renameInfo->Name);
    stmt->SetData(1, atLoginFlags);
    stmt->SetData(2, guidLow);
    CharacterDatabase.Execute(stmt);

    // Removed declined name from db
    if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_DECLINED_NAME);
        stmt->SetData(0, guidLow);
        CharacterDatabase.Execute(stmt);
    }

    LOG_INFO("entities.player.character", "Account: {} (IP: {}), Character [{}] (guid: {}) Changed name to: {}", GetAccountId(), GetRemoteAddress(), oldName, guidLow, renameInfo->Name);

    SendCharRename(RESPONSE_SUCCESS, renameInfo.get());

    // xinef: update global data
    sCharacterCache->UpdateCharacterData(renameInfo->Guid, renameInfo->Name);
}

void WorldSession::HandleSetPlayerDeclinedNames(WorldPacket& recvData)
{
    // pussywizard:
    if (!sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
        return;

    ObjectGuid guid;
    recvData >> guid;

    // not accept declined names for unsupported languages
    std::string name;
    if (!sCharacterCache->GetCharacterNameByGuid(guid, name))
    {
        SendSetPlayerDeclinedNamesResult(DECLINED_NAMES_RESULT_ERROR, guid);
        return;
    }

    std::wstring wname;
    if (!Utf8toWStr(name, wname))
    {
        SendSetPlayerDeclinedNamesResult(DECLINED_NAMES_RESULT_ERROR, guid);
        return;
    }

    if (!isCyrillicCharacter(wname[0]))                      // name already stored as only single alphabet using
    {
        SendSetPlayerDeclinedNamesResult(DECLINED_NAMES_RESULT_ERROR, guid);
        return;
    }

    std::string name2;
    DeclinedName declinedname;

    recvData >> name2;

    if (name2 != name)                                       // character have different name
    {
        SendSetPlayerDeclinedNamesResult(DECLINED_NAMES_RESULT_ERROR, guid);
        return;
    }

    for (int i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
    {
        recvData >> declinedname.name[i];
        if (!normalizePlayerName(declinedname.name[i]))
        {
            SendSetPlayerDeclinedNamesResult(DECLINED_NAMES_RESULT_ERROR, guid);
            return;
        }
    }

    if (!ObjectMgr::CheckDeclinedNames(wname, declinedname))
    {
        SendSetPlayerDeclinedNamesResult(DECLINED_NAMES_RESULT_ERROR, guid);
        return;
    }

    for (int i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
        CharacterDatabase.EscapeString(declinedname.name[i]);

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_DECLINED_NAME);
    stmt->SetData(0, guid.GetCounter());
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_DECLINED_NAME);
    stmt->SetData(0, guid.GetCounter());

    for (uint8 i = 0; i < 5; i++)
        stmt->SetData(i + 1, declinedname.name[i]);

    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);

    SendSetPlayerDeclinedNamesResult(DECLINED_NAMES_RESULT_SUCCESS, guid);
}

void WorldSession::HandleAlterAppearance(WorldPacket& recvData)
{
    LOG_DEBUG("network", "CMSG_ALTER_APPEARANCE");

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
        LOG_DEBUG("network", "Client sent wrong glyph slot number in opcode CMSG_REMOVE_GLYPH {}", slot);
        return;
    }

    if (uint32 glyph = _player->GetGlyph(slot))
    {
        if (GlyphPropertiesEntry const* glyphEntry = sGlyphPropertiesStore.LookupEntry(glyph))
        {
            _player->RemoveAurasDueToSpell(glyphEntry->SpellId);

            // Removed any triggered auras
            Unit::AuraMap& ownedAuras = _player->GetOwnedAuras();
            for (Unit::AuraMap::iterator iter = ownedAuras.begin(); iter != ownedAuras.end();)
            {
                Aura* aura = iter->second;
                if (SpellInfo const* triggeredByAuraSpellInfo = aura->GetTriggeredByAuraSpellInfo())
                {
                    if (triggeredByAuraSpellInfo->Id == glyphEntry->SpellId)
                    {
                        _player->RemoveOwnedAura(iter);
                        continue;
                    }
                }
                ++iter;
            }

            _player->SendLearnPacket(glyphEntry->SpellId, false); // Send packet to properly handle client-side spell tooltips
            _player->SetGlyph(slot, 0, true);
            _player->SendTalentsInfoData(false);
        }
    }
}

void WorldSession::HandleCharCustomize(WorldPacket& recvData)
{
    std::shared_ptr<CharacterCustomizeInfo> customizeInfo = std::make_shared<CharacterCustomizeInfo>();

    recvData >> customizeInfo->Guid;

    if (!IsLegitCharacterForAccount(customizeInfo->Guid))
    {
        LOG_ERROR("entities.player.cheat", "Account {}, IP: {} tried to customise {}, but it does not belong to their account!",
            GetAccountId(), GetRemoteAddress(), customizeInfo->Guid.ToString());
        recvData.rfinish();
        KickPlayer("WorldSession::HandleCharCustomize Trying to customise character of another account");
        return;
    }

    // pussywizard:
    if (ObjectAccessor::FindConnectedPlayer(customizeInfo->Guid) || sWorld->FindOfflineSessionForCharacterGUID(customizeInfo->Guid.GetCounter()))
    {
        recvData.rfinish();
        WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1);
        data << uint8(CHAR_CREATE_ERROR);
        SendPacket(&data);
        return;
    }

    recvData >> customizeInfo->Name
             >> customizeInfo->Gender
             >> customizeInfo->Skin
             >> customizeInfo->HairColor
             >> customizeInfo->HairStyle
             >> customizeInfo->FacialHair
             >> customizeInfo->Face;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_CUSTOMIZE_INFO);
    stmt->SetData(0, customizeInfo->Guid.GetCounter());

    _queryProcessor.AddCallback(CharacterDatabase.AsyncQuery(stmt)
        .WithPreparedCallback(std::bind(&WorldSession::HandleCharCustomizeCallback, this, customizeInfo, std::placeholders::_1)));
}

void WorldSession::HandleCharCustomizeCallback(std::shared_ptr<CharacterCustomizeInfo> customizeInfo, PreparedQueryResult result)
{
    if (!result)
    {
        SendCharCustomize(CHAR_CREATE_ERROR, customizeInfo.get());
        return;
    }

    // get the players old (at this moment current) race
    CharacterCacheEntry const* playerData = sCharacterCache->GetCharacterCacheByGuid(customizeInfo->Guid);
    if (!playerData)
    {
        SendCharCustomize(CHAR_CREATE_ERROR, customizeInfo.get());
        return;
    }

    Field* fields = result->Fetch();
    std::string oldName = fields[0].Get<std::string>();
    //uint8 plrRace = fields[1].Get<uint8>();
    //uint8 plrClass = fields[2].Get<uint8>();
    //uint8 plrGender = fields[3].Get<uint8>();
    uint32 atLoginFlags = fields[4].Get<uint16>();

    if (!(atLoginFlags & AT_LOGIN_CUSTOMIZE))
    {
        SendCharCustomize(CHAR_CREATE_ERROR, customizeInfo.get());
        return;
    }

    atLoginFlags &= ~AT_LOGIN_CUSTOMIZE;

    // prevent character rename to invalid name
    if (!normalizePlayerName(customizeInfo->Name))
    {
        SendCharCustomize(CHAR_NAME_NO_NAME, customizeInfo.get());
        return;
    }

    ResponseCodes res = static_cast<ResponseCodes>(ObjectMgr::CheckPlayerName(customizeInfo->Name, true));
    if (res != CHAR_NAME_SUCCESS)
    {
        SendCharCustomize(res, customizeInfo.get());
        return;
    }

    // character with this name already exist
    if (ObjectGuid newguid = sCharacterCache->GetCharacterGuidByName(customizeInfo->Name))
    {
        if (newguid != customizeInfo->Guid)
        {
            SendCharCustomize(CHAR_CREATE_NAME_IN_USE, customizeInfo.get());
            return;
        }
    }

    CharacterDatabasePreparedStatement* stmt = nullptr;
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    ObjectGuid::LowType lowGuid = customizeInfo->Guid.GetCounter();

    /// Customize
    Player::Customize(customizeInfo.get(), trans);

    /// Name Change and update atLogin flags
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_NAME_AT_LOGIN);
        stmt->SetData(0, customizeInfo->Name);
        stmt->SetData(1, atLoginFlags);
        stmt->SetData(2, lowGuid);

        trans->Append(stmt);

        if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_DECLINED_NAME);
            stmt->SetData(0, lowGuid);

            trans->Append(stmt);
        }
    }

    CharacterDatabase.CommitTransaction(trans);

    sCharacterCache->UpdateCharacterData(customizeInfo->Guid, customizeInfo->Name, customizeInfo->Gender);

    SendCharCustomize(RESPONSE_SUCCESS, customizeInfo.get());

    LOG_INFO("entities.player.character", "Account: {} (IP: {}), Character[{}] ({}) Customized to: {}",
        GetAccountId(), GetRemoteAddress(), oldName, customizeInfo->Guid.ToString(), customizeInfo->Name);
}

void WorldSession::HandleEquipmentSetSave(WorldPacket& recvData)
{
    LOG_DEBUG("network", "CMSG_EQUIPMENT_SET_SAVE");

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
        ObjectGuid itemGuid;
        recvData >> itemGuid.ReadAsPacked();

        // xinef: if client sends 0, it means empty slot
        if (!itemGuid)
        {
            eqSet.Items[i].Clear();
            continue;
        }

        // equipment manager sends "1" (as raw GUID) for slots set to "ignore" (don't touch slot at equip set)
        if (itemGuid.GetRawValue() == 1)
        {
            // ignored slots saved as bit mask because we have no free special values for Items[i]
            eqSet.IgnoreMask |= 1 << i;
            continue;
        }

        // xinef: some cheating checks
        Item* item = _player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (!item || item->GetGUID() != itemGuid)
        {
            eqSet.Items[i].Clear();
            continue;
        }

        eqSet.Items[i] = itemGuid;
    }

    _player->SetEquipmentSet(index, eqSet);
}

void WorldSession::HandleEquipmentSetDelete(WorldPacket& recvData)
{
    LOG_DEBUG("network", "CMSG_EQUIPMENT_SET_DELETE");

    uint64 setGuid;
    recvData.readPackGUID(setGuid);

    _player->DeleteEquipmentSet(setGuid);
}

void WorldSession::HandleEquipmentSetUse(WorldPacket& recvData)
{
    LOG_DEBUG("network", "CMSG_EQUIPMENT_SET_USE");

    std::vector<std::unique_ptr<SavedItem>> savedItems;
    uint8 errorId = 0;
    for (uint32 i = 0; i < EQUIPMENT_SLOT_END; ++i)
    {
        ObjectGuid itemGuid;
        recvData >> itemGuid.ReadAsPacked();

        uint8 srcbag, srcslot;
        recvData >> srcbag >> srcslot;

        LOG_DEBUG("entities.player.items", "Item {}: srcbag {}, srcslot {}", itemGuid.ToString(), srcbag, srcslot);

        // check if item slot is set to "ignored" (raw value == 1), must not be unequipped then
        if (itemGuid.GetRawValue() == 1)
            continue;

        // Only equip weapons in combat
        if (_player->IsInCombat() && i != EQUIPMENT_SLOT_MAINHAND && i != EQUIPMENT_SLOT_OFFHAND && i != EQUIPMENT_SLOT_RANGED)
            continue;

        Item* item = nullptr;
        if (itemGuid)
            item = _player->GetItemByGuid(itemGuid);

        uint16 dstpos = i | (INVENTORY_SLOT_BAG_0 << 8);

        InventoryResult msg;
        Item* uItem = _player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (uItem)
        {
            if (uItem->IsEquipped())
            {
                msg = _player->CanUnequipItem(dstpos, true);
                if (msg != EQUIP_ERR_OK)
                {
                    _player->SendEquipError(msg, uItem, nullptr);
                    continue;
                }
            }

            if (!item)
            {
                ItemPosCountVec sDest;
                msg = _player->CanStoreItem(NULL_BAG, NULL_SLOT, sDest, uItem, false);
                if (msg == EQUIP_ERR_OK)
                {
                    savedItems.emplace_back(std::make_unique<SavedItem>(uItem, dstpos));
                    _player->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
                    _player->StoreItem(sDest, uItem, true);
                }
                else
                {
                    errorId = 4;
                    for (uint8_t j = 0; j < savedItems.size(); ++j)
                    {
                        _player->SwapItem(savedItems[j].get()->item->GetPos(), savedItems[j].get()->dstpos);
                    }
                    break;
                }

                continue;
            }
        }

        if (item)
        {
            if (item->GetPos() == dstpos)
                continue;

            if (!item->IsEquipped())
            {
                uint16 _candidatePos;
                msg = _player->CanEquipItem(NULL_SLOT, _candidatePos, item, true);
                if (msg != EQUIP_ERR_OK)
                {
                    _player->SendEquipError(msg, item, nullptr);
                    continue;
                }
            }

            _player->SwapItem(item->GetPos(), dstpos);
        }
    }

    WorldPacket data(SMSG_EQUIPMENT_SET_USE_RESULT, 1);
    data << uint8(errorId);                                       // 4 - equipment swap failed - inventory is full
    SendPacket(&data);
}

void WorldSession::HandleCharFactionOrRaceChange(WorldPacket& recvData)
{
    std::shared_ptr<CharacterFactionChangeInfo> factionChangeInfo = std::make_shared<CharacterFactionChangeInfo>();

    recvData >> factionChangeInfo->Guid;

    if (!IsLegitCharacterForAccount(factionChangeInfo->Guid))
    {
        LOG_ERROR("entities.player.cheat", "Account {}, IP: {} tried to factionchange character {}, but it does not belong to their account!",
            GetAccountId(), GetRemoteAddress(), factionChangeInfo->Guid.ToString());
        recvData.rfinish();
        KickPlayer("WorldSession::HandleCharFactionOrRaceChange Trying to change faction of character of another account");
        return;
    }

    recvData >> factionChangeInfo->Name
             >> factionChangeInfo->Gender
             >> factionChangeInfo->Skin
             >> factionChangeInfo->HairColor
             >> factionChangeInfo->HairStyle
             >> factionChangeInfo->FacialHair
             >> factionChangeInfo->Face
             >> factionChangeInfo->Race;

    // pussywizard:
    if (ObjectAccessor::FindConnectedPlayer(factionChangeInfo->Guid) || sWorld->FindOfflineSessionForCharacterGUID(factionChangeInfo->Guid.GetCounter()))
    {
        SendCharFactionChange(CHAR_CREATE_ERROR, factionChangeInfo.get());
        return;
    }

    factionChangeInfo->FactionChange = (recvData.GetOpcode() == CMSG_CHAR_FACTION_CHANGE);

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_RACE_OR_FACTION_CHANGE_INFOS);
    stmt->SetData(0, factionChangeInfo->Guid.GetCounter());

    _queryProcessor.AddCallback(CharacterDatabase.AsyncQuery(stmt)
        .WithPreparedCallback(std::bind(&WorldSession::HandleCharFactionOrRaceChangeCallback, this, factionChangeInfo, std::placeholders::_1)));
}

void WorldSession::HandleCharFactionOrRaceChangeCallback(std::shared_ptr<CharacterFactionChangeInfo> factionChangeInfo, PreparedQueryResult result)
{
    if (!result)
    {
        SendCharFactionChange(CHAR_CREATE_ERROR, factionChangeInfo.get());
        return;
    }

    ObjectGuid::LowType lowGuid = factionChangeInfo->Guid.GetCounter();

    // get the players old (at this moment current) race
    CharacterCacheEntry const* playerData = sCharacterCache->GetCharacterCacheByGuid(factionChangeInfo->Guid);
    if (!playerData)
    {
        SendCharFactionChange(CHAR_CREATE_ERROR, factionChangeInfo.get());
        return;
    }

    uint8 oldRace = playerData->Race;
    uint8 playerClass = playerData->Class;
    uint8 level = playerData->Level;

    if (!sObjectMgr->GetPlayerInfo(factionChangeInfo->Race, playerClass))
    {
        SendCharFactionChange(CHAR_CREATE_ERROR, factionChangeInfo.get());
        return;
    }

    Field* fields = result->Fetch();
    uint32 atLoginFlags = fields[0].Get<uint16>();
    std::string knownTitlesStr = fields[1].Get<std::string>();
    uint32 money = fields[2].Get<uint32>();

    uint32 usedLoginFlag = (factionChangeInfo->FactionChange ? AT_LOGIN_CHANGE_FACTION : AT_LOGIN_CHANGE_RACE);
    if (!(atLoginFlags & usedLoginFlag))
    {
        SendCharFactionChange(CHAR_CREATE_ERROR, factionChangeInfo.get());
        return;
    }

    // xinef: add some safety checks
    if (factionChangeInfo->FactionChange)
    {
        // if player is in a guild
        if (playerData->GuildId && !sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GUILD))
        {
            SendCharFactionChange(CHAR_CREATE_CHARACTER_IN_GUILD, factionChangeInfo.get());
            return;
        }

        // is arena team captain
        if (sArenaTeamMgr->GetArenaTeamByCaptain(factionChangeInfo->Guid))
        {
            SendCharFactionChange(CHAR_CREATE_CHARACTER_ARENA_LEADER, factionChangeInfo.get());
            return;
        }

        // check mailbox
        if (playerData->MailCount)
        {
            SendCharFactionChange(CHAR_CREATE_CHARACTER_DELETE_MAIL, factionChangeInfo.get());
            return;
        }

        // check auctions, current packet is processed single-threaded way, so not a problem
        bool has_auctions = false;

        for (uint8 i = 0; i < 2; ++i) // check both neutral and faction-specific AH
        {
            AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(i == 0 ? 0 : (((1 << (playerData->Race - 1)) & RACEMASK_ALLIANCE) ? 12 : 29));

            for (auto const& [auID, Aentry] : auctionHouse->GetAuctions())
            {
                if (Aentry && (Aentry->owner == factionChangeInfo->Guid || Aentry->bidder == factionChangeInfo->Guid))
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
            SendCharFactionChange(CHAR_CREATE_ERROR, factionChangeInfo.get());
            return;
        }
    }

    TeamId newTeam = Player::TeamIdForRace(factionChangeInfo->Race);
    if (factionChangeInfo->FactionChange == (Player::TeamIdForRace(oldRace) == newTeam))
    {
        SendCharFactionChange(factionChangeInfo->FactionChange ? CHAR_CREATE_CHARACTER_SWAP_FACTION : CHAR_CREATE_CHARACTER_RACE_ONLY, factionChangeInfo.get());
        return;
    }

    uint32 maxMoney = sWorld->getIntConfig(CONFIG_CHANGE_FACTION_MAX_MONEY);
    if (maxMoney && money > maxMoney)
    {
        SendCharFactionChange(CHAR_CREATE_CHARACTER_GOLD_LIMIT, factionChangeInfo.get());
        return;
    }

    // pussywizard: check titles here to prevent return while building queries
    const uint32 ktcount = KNOWN_TITLES_SIZE * 2;
    std::vector<std::string_view> tokens = Acore::Tokenize(knownTitlesStr, ' ', false);

    if (factionChangeInfo->FactionChange && tokens.size() != ktcount)
    {
        SendCharFactionChange(CHAR_CREATE_ERROR, factionChangeInfo.get());
        return;
    }

    if (AccountMgr::IsPlayerAccount(GetSecurity()))
    {
        uint32 raceMaskDisabled = sWorld->getIntConfig(CONFIG_CHARACTER_CREATING_DISABLED_RACEMASK);
        if ((1 << (factionChangeInfo->Race - 1)) & raceMaskDisabled)
        {
            SendCharFactionChange(CHAR_CREATE_ERROR, factionChangeInfo.get());
            return;
        }
    }

    // prevent character rename to invalid name
    if (!normalizePlayerName(factionChangeInfo->Name))
    {
        SendCharFactionChange(CHAR_NAME_NO_NAME, factionChangeInfo.get());
        return;
    }

    ResponseCodes res = static_cast<ResponseCodes>(ObjectMgr::CheckPlayerName(factionChangeInfo->Name, true));
    if (res != CHAR_NAME_SUCCESS)
    {
        SendCharFactionChange(res, factionChangeInfo.get());
        return;
    }

    // character with this name already exist
    if (ObjectGuid newguid = sCharacterCache->GetCharacterGuidByName(factionChangeInfo->Name))
    {
        if (newguid != factionChangeInfo->Guid)
        {
            SendCharFactionChange(CHAR_CREATE_NAME_IN_USE, factionChangeInfo.get());
            return;
        }
    }

    CharacterDatabasePreparedStatement* stmt = nullptr;
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    // resurrect the character in case he's dead
    Player::OfflineResurrect(factionChangeInfo->Guid, trans);

    // Name Change and update atLogin flags
    {
        CharacterDatabase.EscapeString(factionChangeInfo->Name);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_NAME_AT_LOGIN);
        stmt->SetData(0, factionChangeInfo->Name);
        stmt->SetData(1, uint16((atLoginFlags | AT_LOGIN_RESURRECT) & ~usedLoginFlag));
        stmt->SetData(2, lowGuid);
        trans->Append(stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_DECLINED_NAME);
        stmt->SetData(0, lowGuid);
        trans->Append(stmt);
    }

    // Customize
    Player::Customize(factionChangeInfo.get(), trans);

    // Race Change
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_RACE);
        stmt->SetData(0, factionChangeInfo->Race);
        stmt->SetData(1, lowGuid);
        trans->Append(stmt);
    }

    LOG_INFO("entities.player.character", "Account: {} (IP: {}), Character [{}] (guid: {}) Changed Race/Faction to: {}",
        GetAccountId(), GetRemoteAddress(), playerData->Name, lowGuid, factionChangeInfo->Name);

    // xinef: update global data
    sCharacterCache->UpdateCharacterData(factionChangeInfo->Guid, factionChangeInfo->Name, factionChangeInfo->Gender, factionChangeInfo->Race);

    if (oldRace != factionChangeInfo->Race)
    {
        // Switch Languages
        // delete all languages first
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SKILL_LANGUAGES);
        stmt->SetData(0, lowGuid);
        trans->Append(stmt);

        // Now add them back
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_SKILL_LANGUAGE);
        stmt->SetData(0, lowGuid);

        // Faction specific languages
        if (newTeam == TEAM_HORDE)
            stmt->SetData(1, 109);
        else
            stmt->SetData(1, 98);

        trans->Append(stmt);

        // Race specific languages
        if (factionChangeInfo->Race != RACE_ORC && factionChangeInfo->Race != RACE_HUMAN)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_SKILL_LANGUAGE);
            stmt->SetData(0, lowGuid);

            switch (factionChangeInfo->Race)
            {
            case RACE_DWARF:
                stmt->SetData(1, 111);
                break;
            case RACE_DRAENEI:
                stmt->SetData(1, 759);
                break;
            case RACE_GNOME:
                stmt->SetData(1, 313);
                break;
            case RACE_NIGHTELF:
                stmt->SetData(1, 113);
                break;
            case RACE_UNDEAD_PLAYER:
                stmt->SetData(1, 673);
                break;
            case RACE_TAUREN:
                stmt->SetData(1, 115);
                break;
            case RACE_TROLL:
                stmt->SetData(1, 315);
                break;
            case RACE_BLOODELF:
                stmt->SetData(1, 137);
                break;
            }

            trans->Append(stmt);
        }

        if (factionChangeInfo->FactionChange)
        {
            {
                // Delete all Flypaths
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_TAXI_PATH);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                // Update Taxi path
                TaxiMask newTaxiMask;
                newTaxiMask.fill(0);

                TaxiMask const& factionMask = newTeam == TEAM_HORDE ? sHordeTaxiNodesMask : sAllianceTaxiNodesMask;
                for (auto const& itr : sTaxiPathSetBySource)
                {
                    auto FillTaxiMask = [&](uint8 field, uint32 mask)
                    {
                        if (playerClass == CLASS_DEATH_KNIGHT)
                        {
                            newTaxiMask[field] |= uint32(mask | (sDeathKnightTaxiNodesMask[field] & mask));
                        }
                        else
                        {
                            newTaxiMask[field] |= mask;
                        }
                    };

                    uint32 nodeId = itr.first;
                    uint8 field = (uint8)((nodeId - 1) / 32);
                    uint32 submask = 1 << ((nodeId - 1) % 32);

                    if ((factionMask[field] & submask) == 0)
                    {
                        FillTaxiMask(field, 0);
                        continue;
                    }

                    TaxiPathSetForSource const& taxiPaths = itr.second;
                    if (taxiPaths.empty())
                    {
                        FillTaxiMask(field, 0);
                        continue;
                    }

                    TaxiPathEntry const* taxiPath = taxiPaths.begin()->second;
                    if (!taxiPath)
                    {
                        FillTaxiMask(field, 0);
                        continue;
                    }

                    TaxiPathNodeList const& taxiNodePaths = sTaxiPathNodesByPath[taxiPath->ID];
                    if (taxiNodePaths.empty())
                    {
                        FillTaxiMask(field, 0);
                        continue;
                    }

                    TaxiPathNodeEntry const* pathNode = taxiNodePaths.front();
                    if (!pathNode)
                    {
                        FillTaxiMask(field, 0);
                        continue;
                    }

                    AreaTableEntry const* zone = sAreaTableStore.LookupEntry(sMapMgr->GetZoneId(PHASEMASK_NORMAL, pathNode->mapid, pathNode->x, pathNode->y, pathNode->z));
                    if (!zone)
                    {
                        FillTaxiMask(field, 0);
                        continue;
                    }

                    LFGDungeonEntry const* lfgDungeon = GetZoneLFGDungeonEntry(zone->area_name[GetSessionDbLocaleIndex()], GetSessionDbLocaleIndex());
                    if (!lfgDungeon)
                    {
                        FillTaxiMask(field, 0);
                        continue;
                    }

                    // Get level from LFGDungeonEntry because the one from AreaTableEntry is not valid
                    // If area level is too big, do not add new taxi
                    if (lfgDungeon->MinLevel > level)
                    {
                        FillTaxiMask(field, 0);
                        continue;
                    }

                    FillTaxiMask(field, submask);
                }

                std::ostringstream taximaskstream;
                for (uint8 i = 0; i < TaxiMaskSize; ++i)
                    taximaskstream << uint32(newTaxiMask[i]) << ' ';

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_TAXIMASK);
                stmt->SetData(0, taximaskstream.str());
                stmt->SetData(1, lowGuid);
                trans->Append(stmt);
            }

            // Reset guild
            if (!sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GUILD))
            {
                if (uint32 guildId = playerData->GuildId)
                    if (Guild* guild = sGuildMgr->GetGuildById(guildId))
                        guild->DeleteMember(factionChangeInfo->Guid, false, false, true);
            }

            if (!sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_ADD_FRIEND))
            {
                // Delete Friend List
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SOCIAL_BY_GUID);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SOCIAL_BY_FRIEND);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);
            }

            // Leave Arena Teams
            Player::LeaveAllArenaTeams(factionChangeInfo->Guid);

            // Reset homebind and position
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_HOMEBIND);
            stmt->SetData(0, lowGuid);
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PLAYER_HOMEBIND);
            stmt->SetData(0, lowGuid);

            WorldLocation loc;
            uint16 zoneId = 0;

            if (newTeam == TEAM_ALLIANCE)
            {
                loc.WorldRelocate(0, -8867.68f, 673.373f, 97.9034f, 0.0f);
                zoneId = 1519;
            }
            else
            {
                loc.WorldRelocate(1, 1633.33f, -4439.11f, 15.7588f, 0.0f);
                zoneId = 1637;
            }

            stmt->SetData(1, loc.GetMapId());
            stmt->SetData(2, zoneId);
            stmt->SetData(3, loc.GetPositionX());
            stmt->SetData(4, loc.GetPositionY());
            stmt->SetData(5, loc.GetPositionZ());
            trans->Append(stmt);

            Player::SavePositionInDB(loc, zoneId, factionChangeInfo->Guid, trans);

            // Achievement conversion
            for (auto const& [achiev_alliance, achiev_horde] : sObjectMgr->FactionChangeAchievements)
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACHIEVEMENT_BY_ACHIEVEMENT);
                stmt->SetData(0, uint16(newTeam == TEAM_ALLIANCE ? achiev_alliance : achiev_horde));
                stmt->SetData(1, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_ACHIEVEMENT);
                stmt->SetData(0, uint16(newTeam == TEAM_ALLIANCE ? achiev_alliance : achiev_horde));
                stmt->SetData(1, uint16(newTeam == TEAM_ALLIANCE ? achiev_horde : achiev_alliance));
                stmt->SetData(2, lowGuid);
                trans->Append(stmt);
            }

            // Item conversion
            for (auto const& [item_alliance, item_horde] : sObjectMgr->FactionChangeItems)
            {
                uint32 new_entry = (newTeam == TEAM_ALLIANCE ? item_alliance : item_horde);
                uint32 old_entry = (newTeam == TEAM_ALLIANCE ? item_horde : item_alliance);

                if (old_entry == 45978 /*Solid Gold Coin*/ || old_entry == 2589 /*Linen Cloth*/ || old_entry == 5976 /*Guild Tabard*/)
                    continue;

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_INVENTORY_FACTION_CHANGE);
                stmt->SetData(0, new_entry);
                stmt->SetData(1, old_entry);
                stmt->SetData(2, lowGuid);
                trans->Append(stmt);
            }

            // Delete all current quests
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS);
            stmt->SetData(0, lowGuid);
            trans->Append(stmt);

            // Quest conversion
            for (auto const& [quest_alliance, quest_horde] : sObjectMgr->FactionChangeQuests)
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_REWARDED_BY_QUEST);
                stmt->SetData(0, lowGuid);
                stmt->SetData(1, (newTeam == TEAM_ALLIANCE ? quest_alliance : quest_horde));
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_QUESTSTATUS_REWARDED_FACTION_CHANGE);
                stmt->SetData(0, (newTeam == TEAM_ALLIANCE ? quest_alliance : quest_horde));
                stmt->SetData(1, (newTeam == TEAM_ALLIANCE ? quest_horde : quest_alliance));
                stmt->SetData(2, lowGuid);
                trans->Append(stmt);
            }

            // Mark all rewarded quests as "active" (will count for completed quests achievements)
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_QUESTSTATUS_REWARDED_ACTIVE);
            stmt->SetData(0, lowGuid);
            trans->Append(stmt);

            // Disable all old-faction specific quests
            for (auto const& [questID, quest] : sObjectMgr->GetQuestTemplates())
            {
                uint32 newRaceMask = (newTeam == TEAM_ALLIANCE) ? RACEMASK_ALLIANCE : RACEMASK_HORDE;

                if (quest->GetAllowableRaces() && !(quest->GetAllowableRaces() & newRaceMask))
                {
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_QUESTSTATUS_REWARDED_ACTIVE_BY_QUEST);
                    stmt->SetData(0, quest->GetQuestId());
                    stmt->SetData(1, lowGuid);
                    trans->Append(stmt);
                }
            }

            // Spell conversion
            for (auto const& [spell_alliance, spell_horde] : sObjectMgr->FactionChangeSpells)
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SPELL_BY_SPELL);
                stmt->SetData(0, lowGuid);
                stmt->SetData(1, (newTeam == TEAM_ALLIANCE ? spell_alliance : spell_horde));
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_SPELL_FACTION_CHANGE);
                stmt->SetData(0, (newTeam == TEAM_ALLIANCE ? spell_alliance : spell_horde));
                stmt->SetData(1, (newTeam == TEAM_ALLIANCE ? spell_horde : spell_alliance));
                stmt->SetData(2, lowGuid);
                trans->Append(stmt);
            }

            // Reputation conversion
            for (auto const& [reputation_alliance, reputation_horde] : sObjectMgr->FactionChangeReputation)
            {
                uint32 newReputation = (newTeam == TEAM_ALLIANCE) ? reputation_alliance : reputation_horde;
                uint32 oldReputation = (newTeam == TEAM_ALLIANCE) ? reputation_horde : reputation_alliance;

                // select old standing set in db
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_REP_BY_FACTION);
                stmt->SetData(0, oldReputation);
                stmt->SetData(1, lowGuid);

                PreparedQueryResult result = CharacterDatabase.Query(stmt);
                if (!result)
                    continue;

                fields = result->Fetch();
                int32 oldDBRep = fields[0].Get<int32>();
                FactionEntry const* factionEntry = sFactionStore.LookupEntry(oldReputation);

                // old base reputation
                int32 oldBaseRep = sObjectMgr->GetBaseReputationOf(factionEntry, oldRace, playerClass);

                // new base reputation
                int32 newBaseRep = sObjectMgr->GetBaseReputationOf(sFactionStore.LookupEntry(newReputation), factionChangeInfo->Race, playerClass);

                // final reputation shouldnt change
                int32 FinalRep = oldDBRep + oldBaseRep;
                int32 newDBRep = FinalRep - newBaseRep;

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_REP_BY_FACTION);
                stmt->SetData(0, newReputation);
                stmt->SetData(1, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_REP_FACTION_CHANGE);
                stmt->SetData(0, uint16(newReputation));
                stmt->SetData(1, newDBRep);
                stmt->SetData(2, uint16(oldReputation));
                stmt->SetData(3, lowGuid);
                trans->Append(stmt);
            }

            // Title conversion
            if (!knownTitlesStr.empty())
            {
                std::array<uint32, KNOWN_TITLES_SIZE * 2> knownTitles;

                for (uint32 index = 0; index < knownTitles.size(); ++index)
                {
                    Optional<uint32> thisMask;
                    if (index < tokens.size())
                        thisMask = Acore::StringTo<uint32>(tokens[index]);

                    if (thisMask)
                        knownTitles[index] = *thisMask;
                    else
                    {
                        LOG_WARN("entities.player", "{} has invalid title data '{}' at index {} - skipped, this may result in titles being lost",
                            GetPlayerInfo(), (index < tokens.size()) ? std::string(tokens[index]) : "<none>", index);

                        knownTitles[index] = 0;
                    }
                }

                for (auto const& [title_alliance, title_horde] : sObjectMgr->FactionChangeTitles)
                {
                    CharTitlesEntry const* atitleInfo = sCharTitlesStore.LookupEntry(title_alliance);
                    CharTitlesEntry const* htitleInfo = sCharTitlesStore.LookupEntry(title_horde);

                    // new team
                    if (newTeam == TEAM_ALLIANCE)
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
                    for (uint32 mask : knownTitles)
                        ss << mask << ' ';

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_TITLES_FACTION_CHANGE);
                    stmt->SetData(0, ss.str().c_str());
                    stmt->SetData(1, lowGuid);
                    trans->Append(stmt);

                    // unset any currently chosen title
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_RES_CHAR_TITLES_FACTION_CHANGE);
                    stmt->SetData(0, lowGuid);
                    trans->Append(stmt);
                }
            }
        }
    }

    // Re-check all achievement criterias
    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
    stmt->SetData(0, uint16(AT_LOGIN_CHECK_ACHIEVS));
    stmt->SetData(1, lowGuid);
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);

    LOG_DEBUG("entities.player", "{} (IP: {}) changed race from {} to {}", GetPlayerInfo(), GetRemoteAddress(), oldRace, factionChangeInfo->Race);

    SendCharFactionChange(RESPONSE_SUCCESS, factionChangeInfo.get());
}

void WorldSession::SendCharCreate(ResponseCodes result)
{
    WorldPacket data(SMSG_CHAR_CREATE, 1);
    data << uint8(result);
    SendPacket(&data);
}

void WorldSession::SendCharDelete(ResponseCodes result)
{
    WorldPacket data(SMSG_CHAR_DELETE, 1);
    data << uint8(result);
    SendPacket(&data);
}

void WorldSession::SendCharRename(ResponseCodes result, CharacterRenameInfo const* renameInfo)
{
    WorldPacket data(SMSG_CHAR_RENAME, 1 + 8 + renameInfo->Name.size() + 1);
    data << uint8(result);
    if (result == RESPONSE_SUCCESS)
    {
        data << renameInfo->Guid;
        data << renameInfo->Name;
    }
    SendPacket(&data);
}

void WorldSession::SendCharFactionChange(ResponseCodes result, CharacterFactionChangeInfo const* factionChangeInfo)
{
    WorldPacket data(SMSG_CHAR_FACTION_CHANGE, 1 + 8 + factionChangeInfo->Name.size() + 1 + 7);
    data << uint8(result);
    if (result == RESPONSE_SUCCESS)
    {
        data << factionChangeInfo->Guid;
        data << factionChangeInfo->Name;
        data << uint8(factionChangeInfo->Gender);
        data << uint8(factionChangeInfo->Skin);
        data << uint8(factionChangeInfo->Face);
        data << uint8(factionChangeInfo->HairStyle);
        data << uint8(factionChangeInfo->HairColor);
        data << uint8(factionChangeInfo->FacialHair);
        data << uint8(factionChangeInfo->Race);
    }
    SendPacket(&data);
}

void WorldSession::SendCharCustomize(ResponseCodes result, CharacterCustomizeInfo const* customizeInfo)
{
    WorldPacket data(SMSG_CHAR_CUSTOMIZE, 1 + 8 + customizeInfo->Name.size() + 1 + 6);
    data << uint8(result);
    if (result == RESPONSE_SUCCESS)
    {
        data << customizeInfo->Guid;
        data << customizeInfo->Name;
        data << uint8(customizeInfo->Gender);
        data << uint8(customizeInfo->Skin);
        data << uint8(customizeInfo->Face);
        data << uint8(customizeInfo->HairStyle);
        data << uint8(customizeInfo->HairColor);
        data << uint8(customizeInfo->FacialHair);
    }
    SendPacket(&data);
}

void WorldSession::SendSetPlayerDeclinedNamesResult(DeclinedNameResult result, ObjectGuid guid)
{
    WorldPacket data(SMSG_SET_PLAYER_DECLINED_NAMES_RESULT, 4 + 8);
    data << uint32(result);
    data << guid;
    SendPacket(&data);
}
