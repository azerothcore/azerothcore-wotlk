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

#include "Player.h"
#include "AccountMgr.h"
#include "AchievementMgr.h"
#include "ArenaSpectator.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "BattlefieldWG.h"
#include "Battleground.h"
#include "BattlegroundAV.h"
#include "BattlegroundMgr.h"
#include "CellImpl.h"
#include "CharmInfo.h"
#include "Channel.h"
#include "CharacterCache.h"
#include "CharacterDatabaseCleaner.h"
#include "Chat.h"
#include "CombatLogPackets.h"
#include "Common.h"
#include "ConditionMgr.h"
#include "Config.h"
#include "CreatureAI.h"
#include "DatabaseEnv.h"
#include "DisableMgr.h"
#include "Formulas.h"
#include "GameEventMgr.h"
#include "GameGraveyard.h"
#include "GameTime.h"
#include "GossipDef.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "GroupMgr.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "InstanceSaveMgr.h"
#include "InstanceScript.h"
#include "LFGMgr.h"
#include "Log.h"
#include "LootItemStorage.h"
#include "MapMgr.h"
#include "MiscPackets.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "OutdoorPvP.h"
#include "OutdoorPvPMgr.h"
#include "Pet.h"
#include "PetitionMgr.h"
#include "QuestDef.h"
#include "Realm.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "SocialMgr.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "StringConvert.h"
#include "TicketMgr.h"
#include "Tokenize.h"
#include "Transport.h"
#include "UpdateData.h"
#include "Util.h"
#include "Vehicle.h"
#include "Weather.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include <cmath>

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

enum CharacterFlags
{
    CHARACTER_FLAG_NONE                 = 0x00000000,
    CHARACTER_FLAG_UNK1                 = 0x00000001,
    CHARACTER_FLAG_UNK2                 = 0x00000002,
    CHARACTER_LOCKED_FOR_TRANSFER       = 0x00000004,
    CHARACTER_FLAG_UNK4                 = 0x00000008,
    CHARACTER_FLAG_UNK5                 = 0x00000010,
    CHARACTER_FLAG_UNK6                 = 0x00000020,
    CHARACTER_FLAG_UNK7                 = 0x00000040,
    CHARACTER_FLAG_UNK8                 = 0x00000080,
    CHARACTER_FLAG_UNK9                 = 0x00000100,
    CHARACTER_FLAG_UNK10                = 0x00000200,
    CHARACTER_FLAG_HIDE_HELM            = 0x00000400,
    CHARACTER_FLAG_HIDE_CLOAK           = 0x00000800,
    CHARACTER_FLAG_UNK13                = 0x00001000,
    CHARACTER_FLAG_GHOST                = 0x00002000,
    CHARACTER_FLAG_RENAME               = 0x00004000,
    CHARACTER_FLAG_UNK16                = 0x00008000,
    CHARACTER_FLAG_UNK17                = 0x00010000,
    CHARACTER_FLAG_UNK18                = 0x00020000,
    CHARACTER_FLAG_UNK19                = 0x00040000,
    CHARACTER_FLAG_UNK20                = 0x00080000,
    CHARACTER_FLAG_UNK21                = 0x00100000,
    CHARACTER_FLAG_UNK22                = 0x00200000,
    CHARACTER_FLAG_UNK23                = 0x00400000,
    CHARACTER_FLAG_UNK24                = 0x00800000,
    CHARACTER_FLAG_LOCKED_BY_BILLING    = 0x01000000,
    CHARACTER_FLAG_DECLINED             = 0x02000000,
    CHARACTER_FLAG_UNK27                = 0x04000000,
    CHARACTER_FLAG_UNK28                = 0x08000000,
    CHARACTER_FLAG_UNK29                = 0x10000000,
    CHARACTER_FLAG_UNK30                = 0x20000000,
    CHARACTER_FLAG_UNK31                = 0x40000000,
    CHARACTER_FLAG_UNK32                = 0x80000000
};

enum CharacterCustomizeFlags
{
    CHAR_CUSTOMIZE_FLAG_NONE            = 0x00000000,
    CHAR_CUSTOMIZE_FLAG_CUSTOMIZE       = 0x00000001,       // name, gender, etc...
    CHAR_CUSTOMIZE_FLAG_FACTION         = 0x00010000,       // name, gender, faction, etc...
    CHAR_CUSTOMIZE_FLAG_RACE            = 0x00100000        // name, gender, race, etc...
};

static uint32 copseReclaimDelay[MAX_DEATH_COUNT] = { 30, 60, 120 };

// we can disable this warning for this since it only
// causes undefined behavior when passed to the base class constructor
#ifdef _MSC_VER
#pragma warning(disable:4355)
#endif
Player::Player(WorldSession* session): Unit(true), m_mover(this)
{
#ifdef _MSC_VER
#pragma warning(default:4355)
#endif

    m_objectType |= TYPEMASK_PLAYER;
    m_objectTypeId = TYPEID_PLAYER;

    m_valuesCount = PLAYER_END;

    m_session = session;

    m_ingametime = 0;

    m_ExtraFlags = 0;

    m_spellModTakingSpell = nullptr;
    //m_pad = 0;

    // players always accept
    if (AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()))
        SetAcceptWhispers(true);

    m_usedTalentCount = 0;
    m_questRewardTalentCount = 0;
    m_extraBonusTalentCount = 0;

    m_regenTimer = 0;
    m_regenTimerCount = 0;
    m_foodEmoteTimerCount = 0;
    m_weaponChangeTimer = 0;

    m_zoneUpdateId = uint32(-1);
    m_zoneUpdateTimer = 0;

    m_nextSave = sWorld->getIntConfig(CONFIG_INTERVAL_SAVE);

    m_areaUpdateId = 0;
    m_team = TEAM_NEUTRAL;

    m_needZoneUpdate = false;

    m_additionalSaveTimer = 0;
    m_additionalSaveMask = 0;
    m_hostileReferenceCheckTimer = 15000;

    clearResurrectRequestData();

    memset(m_items, 0, sizeof(Item*)*PLAYER_SLOTS_COUNT);

    m_social = nullptr;

    // group is initialized in the reference constructor
    SetGroupInvite(nullptr);
    m_groupUpdateMask = 0;
    m_auraRaidUpdateMask = 0;
    m_bPassOnGroupLoot = false;

    m_GuildIdInvited = 0;
    m_ArenaTeamIdInvited = 0;

    m_atLoginFlags = AT_LOGIN_NONE;

    mSemaphoreTeleport_Near = 0;
    mSemaphoreTeleport_Far = 0;

    m_DelayedOperations = 0;
    m_bMustDelayTeleport = false;
    m_bHasDelayedTeleport = false;
    teleportStore_options = 0;
    m_canTeleport = false;
    m_canKnockback = false;

    m_trade = nullptr;

    m_cinematic = 0;

    PlayerTalkClass = new PlayerMenu(GetSession());
    m_currentBuybackSlot = BUYBACK_SLOT_START;

    m_DailyQuestChanged = false;
    m_lastDailyQuestTime = 0;

    for (uint8 i = 0; i < MAX_TIMERS; i++)
        m_MirrorTimer[i] = DISABLED_MIRROR_TIMER;

    m_MirrorTimerFlags = UNDERWATER_NONE;
    m_MirrorTimerFlagsLast = UNDERWATER_NONE;
    m_isInWater = false;
    m_drunkTimer = 0;
    m_deathTimer = 0;
    m_deathExpireTime = 0;

    m_flightSpellActivated = 0;

    m_swingErrorMsg = 0;

    for (uint8 j = 0; j < PLAYER_MAX_BATTLEGROUND_QUEUES; ++j)
    {
        _BgBattlegroundQueueID[j].bgQueueTypeId = BATTLEGROUND_QUEUE_NONE;
        _BgBattlegroundQueueID[j].invitedToInstance = 0;
    }

    m_logintime = GameTime::GetGameTime().count();
    m_Last_tick = m_logintime;
    m_Played_time[PLAYED_TIME_TOTAL] = 0;
    m_Played_time[PLAYED_TIME_LEVEL] = 0;
    m_WeaponProficiency = 0;
    m_ArmorProficiency = 0;
    m_canParry = false;
    m_canBlock = false;
    m_canTitanGrip = false;
    m_ammoDPS = 0.0f;

    m_temporaryUnsummonedPetNumber = 0;
    //cache for UNIT_CREATED_BY_SPELL to allow
    //returning reagents for temporarily removed pets
    //when dying/logging out
    m_oldpetspell = 0;
    m_lastpetnumber = 0;

    ////////////////////Rest System/////////////////////
    _restTime = 0;
    _innTriggerId = 0;
    _restBonus = 0;
    _restFlagMask = 0;
    ////////////////////Rest System/////////////////////

    m_mailsUpdated = false;
    unReadMails = 0;
    m_nextMailDelivereTime = time_t(0);

    m_resetTalentsCost = 0;
    m_resetTalentsTime = 0;
    m_itemUpdateQueueBlocked = false;

    for (uint8 i = 0; i < MAX_MOVE_TYPE; ++i)
        m_forced_speed_changes[i] = 0;

    /////////////////// Instance System /////////////////////

    m_HomebindTimer = 0;
    m_InstanceValid = true;
    m_dungeonDifficulty = DUNGEON_DIFFICULTY_NORMAL;
    m_raidDifficulty = RAID_DIFFICULTY_10MAN_NORMAL;
    m_raidMapDifficulty = RAID_DIFFICULTY_10MAN_NORMAL;

    m_lastPotionId = 0;

    m_activeSpec = 0;
    m_specsCount = 1;

    for (uint8 i = 0; i < MAX_TALENT_SPECS; ++i)
    {
        for (uint8 g = 0; g < MAX_GLYPH_SLOT_INDEX; ++g)
            m_Glyphs[i][g] = 0;
    }

    for (uint8 i = 0; i < BASEMOD_END; ++i)
    {
        m_auraBaseMod[i][FLAT_MOD] = 0.0f;
        m_auraBaseMod[i][PCT_MOD] = 1.0f;
    }

    for (uint8 i = 0; i < MAX_COMBAT_RATING; i++)
        m_baseRatingValue[i] = 0;

    m_baseSpellPower = 0;
    m_baseFeralAP = 0;
    m_baseManaRegen = 0;
    m_baseHealthRegen = 0;
    m_spellPenetrationItemMod = 0;

    // Honor System
    m_lastHonorUpdateTime = GameTime::GetGameTime().count();

    m_IsBGRandomWinner = false;

    // Player summoning
    m_summon_expire = 0;
    m_summon_mapid = 0;
    m_summon_x = 0.0f;
    m_summon_y = 0.0f;
    m_summon_z = 0.0f;
    m_summon_asSpectator = false;

    //m_mover = this;
    m_movedByPlayer.Initialize(this);
    m_seer = this;

    m_recallMap = 0;
    m_recallX = 0;
    m_recallY = 0;
    m_recallZ = 0;
    m_recallO = 0;

    m_homebindMapId = 0;
    m_homebindAreaId = 0;
    m_homebindX = 0;
    m_homebindY = 0;
    m_homebindZ = 0;

    m_contestedPvPTimer = 0;

    m_declinedname = nullptr;

    m_isActive = true;

    m_runes = nullptr;

    m_lastFallTime = 0;
    m_lastFallZ = 0;

    m_grantableLevels = 0;

    m_ControlledByPlayer = true;

    sWorld->IncreasePlayerCount();

    m_ChampioningFaction = 0;

    for (uint8 i = 0; i < MAX_POWERS; ++i)
        m_powerFraction[i] = 0;

    isDebugAreaTriggers = false;

    m_WeeklyQuestChanged = false;

    m_MonthlyQuestChanged = false;

    m_SeasonalQuestChanged = false;

    SetPendingBind(0, 0);

    _activeCheats = CHEAT_NONE;

    m_creationTime = 0s;

    _cinematicMgr = new CinematicMgr(this);

    m_achievementMgr = new AchievementMgr(this);
    m_reputationMgr = new ReputationMgr(this);

    // Ours
    m_NeedToSaveGlyphs = false;
    m_MountBlockId = 0;
    m_realDodge = 0.0f;
    m_realParry = 0.0f;
    m_pendingSpectatorForBG = 0;
    m_pendingSpectatorInviteInstanceId = 0;

    m_charmUpdateTimer = 0;

    for( int i = 0; i < NUM_CAI_SPELLS; ++i )
        m_charmAISpells[i] = 0;

    m_applyResilience = true;

    m_isInstantFlightOn = true;

    _wasOutdoor = true;
    sScriptMgr->OnConstructPlayer(this);
}

Player::~Player()
{
    sScriptMgr->OnDestructPlayer(this);

    // it must be unloaded already in PlayerLogout and accessed only for loggined player
    //m_social = nullptr;

    // Note: buy back item already deleted from DB when player was saved
    for (uint8 i = 0; i < PLAYER_SLOTS_COUNT; ++i)
        delete m_items[i];

    for (PlayerSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
        delete itr->second;

    for (PlayerTalentMap::const_iterator itr = m_talents.begin(); itr != m_talents.end(); ++itr)
        delete itr->second;

    //all mailed items should be deleted, also all mail should be deallocated
    for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
    {
        delete *itr;
    }

    for (ItemMap::iterator iter = mMitems.begin(); iter != mMitems.end(); ++iter)
        delete iter->second;                                //if item is duplicated... then server may crash ... but that item should be deallocated

    delete PlayerTalkClass;

    for (std::size_t x = 0; x < ItemSetEff.size(); x++)
        delete ItemSetEff[x];

    delete m_declinedname;
    delete m_runes;
    delete m_achievementMgr;
    delete m_reputationMgr;
    delete _cinematicMgr;

    sWorld->DecreasePlayerCount();

    if (!m_isInSharedVisionOf.empty())
    {
        do
        {
            Unit* u = *(m_isInSharedVisionOf.begin());
            u->RemovePlayerFromVision(this);
        } while (!m_isInSharedVisionOf.empty());
    }
}

void Player::CleanupsBeforeDelete(bool finalCleanup)
{
    TradeCancel(false);
    DuelComplete(DUEL_INTERRUPTED);

    Unit::CleanupsBeforeDelete(finalCleanup);
}

bool Player::Create(ObjectGuid::LowType guidlow, CharacterCreateInfo* createInfo)
{
    // FIXME: outfitId not used in player creating
    /// @todo: need more checks against packet modifications
    // should check that skin, face, hair* are valid via DBC per race/class
    // also do it in Player::BuildEnumData, Player::LoadFromDB

    Object::_Create(guidlow, 0, HighGuid::Player);

    m_name = createInfo->Name;

    PlayerInfo const* info = sObjectMgr->GetPlayerInfo(createInfo->Race, createInfo->Class);
    if (!info)
    {
        LOG_ERROR("entities.player", "Player::Create: Possible hacking-attempt: Account {} tried creating a character named '{}' with an invalid race/class pair ({}/{}) - refusing to do so.",
                       GetSession()->GetAccountId(), m_name, createInfo->Race, createInfo->Class);
        return false;
    }

    for (uint8 i = 0; i < PLAYER_SLOTS_COUNT; i++)
        m_items[i] = nullptr;

    Relocate(info->positionX, info->positionY, info->positionZ, info->orientation);

    ChrClassesEntry const* cEntry = sChrClassesStore.LookupEntry(createInfo->Class);
    if (!cEntry)
    {
        LOG_ERROR("entities.player", "Player::Create: Possible hacking-attempt: Account {} tried creating a character named '{}' with an invalid character class ({}) - refusing to do so (wrong DBC-files?)",
                       GetSession()->GetAccountId(), m_name, createInfo->Class);
        return false;
    }

    SetMap(sMapMgr->CreateMap(info->mapId, this));

    uint8 powertype = cEntry->powerType;

    SetObjectScale(1.0f);

    m_realRace = createInfo->Race; // set real race flag
    m_race = createInfo->Race; // set real race flag

    SetFactionForRace(createInfo->Race);

    if (!IsValidGender(createInfo->Gender))
    {
        LOG_ERROR("entities.player", "Player::Create: Possible hacking-attempt: Account {} tried creating a character named '{}' with an invalid gender ({}) - refusing to do so",
                       GetSession()->GetAccountId(), m_name, createInfo->Gender);
        return false;
    }

    uint32 RaceClassGender = (createInfo->Race) | (createInfo->Class << 8) | (createInfo->Gender << 16);

    SetUInt32Value(UNIT_FIELD_BYTES_0, (RaceClassGender | (powertype << 24)));
    InitDisplayIds();
    if (sWorld->getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_PVP || sWorld->getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_RPPVP)
    {
        SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_PVP);
        SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
    }
    SetUnitFlag2(UNIT_FLAG2_REGENERATE_POWER);
    SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);               // fix cast time showed in spell tooltip on client
    SetFloatValue(UNIT_FIELD_HOVERHEIGHT, 1.0f);            // default for players in 3.0.3

    // -1 is default value
    SetInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX, uint32(-1));

    SetUInt32Value(PLAYER_BYTES, (createInfo->Skin | (createInfo->Face << 8) | (createInfo->HairStyle << 16) | (createInfo->HairColor << 24)));
    SetUInt32Value(PLAYER_BYTES_2, (createInfo->FacialHair |
                                    (0x00 << 8) |
                                    (0x00 << 16) |
                                    (((GetSession()->IsARecruiter() || GetSession()->GetRecruiterId() != 0) ? REST_STATE_RAF_LINKED : REST_STATE_NOT_RAF_LINKED) << 24)));
    SetByteValue(PLAYER_BYTES_3, 0, createInfo->Gender);
    SetByteValue(PLAYER_BYTES_3, 3, 0);                     // BattlefieldArenaFaction (0 or 1)

    SetUInt32Value(PLAYER_GUILDID, 0);
    SetUInt32Value(PLAYER_GUILDRANK, 0);
    SetUInt32Value(PLAYER_GUILD_TIMESTAMP, 0);

    for (int i = 0; i < KNOWN_TITLES_SIZE; ++i)
        SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES + i, 0);  // 0=disabled
    SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);

    SetUInt32Value(PLAYER_FIELD_KILLS, 0);
    SetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 0);
    SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, 0);
    SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, 0);

    // set starting level
    uint32 start_level = !IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT)
                         ? sWorld->getIntConfig(CONFIG_START_PLAYER_LEVEL)
                         : sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_LEVEL);

    if (!AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()))
    {
        uint32 gm_level = sWorld->getIntConfig(CONFIG_START_GM_LEVEL);
        if (gm_level > start_level)
            start_level = gm_level;
    }

    SetUInt32Value(UNIT_FIELD_LEVEL, start_level);

    InitRunes();

    SetUInt32Value(PLAYER_FIELD_COINAGE, !IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT)
                                         ? sWorld->getIntConfig(CONFIG_START_PLAYER_MONEY)
                                         : sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_MONEY));
    SetHonorPoints(sWorld->getIntConfig(CONFIG_START_HONOR_POINTS));
    SetArenaPoints(sWorld->getIntConfig(CONFIG_START_ARENA_POINTS));

    // Played time
    m_Last_tick = GameTime::GetGameTime().count();
    m_Played_time[PLAYED_TIME_TOTAL] = 0;
    m_Played_time[PLAYED_TIME_LEVEL] = 0;

    // base stats and related field values
    InitStatsForLevel();
    InitTaxiNodesForLevel();
    InitGlyphsForLevel();
    InitTalentForLevel();
    InitPrimaryProfessions();                               // to max set before any spell added

    // apply original stats mods before spell loading or item equipment that call before equip _RemoveStatsMods()
    if (HasActivePowerType(POWER_MANA))
    {
        UpdateMaxPower(POWER_MANA);                         // Update max Mana (for add bonus from intellect)
        SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
    }

    if (HasActivePowerType(POWER_RUNIC_POWER))
    {
        SetPower(POWER_RUNE, 8);
        SetMaxPower(POWER_RUNE, 8);
        SetPower(POWER_RUNIC_POWER, 0);
        SetMaxPower(POWER_RUNIC_POWER, 1000);
    }

    // original spells
    LearnDefaultSkills();
    LearnCustomSpells();

    // original action bar
    for (PlayerCreateInfoActions::const_iterator action_itr = info->action.begin(); action_itr != info->action.end(); ++action_itr)
        addActionButton(action_itr->button, action_itr->action, action_itr->type);

    // original items
    if (CharStartOutfitEntry const* oEntry = GetCharStartOutfitEntry(createInfo->Race, createInfo->Class, createInfo->Gender))
    {
        for (int j = 0; j < MAX_OUTFIT_ITEMS; ++j)
        {
            if (oEntry->ItemId[j] <= 0)
                continue;

            uint32 itemId = oEntry->ItemId[j];

            // just skip, reported in ObjectMgr::LoadItemTemplates
            ItemTemplate const* iProto = sObjectMgr->GetItemTemplate(itemId);
            if (!iProto)
                continue;

            // BuyCount by default
            uint32 count = iProto->BuyCount;

            // special amount for food/drink
            if (iProto->Class == ITEM_CLASS_CONSUMABLE && iProto->SubClass == ITEM_SUBCLASS_FOOD)
            {
                switch (iProto->Spells[0].SpellCategory)
                {
                    case SPELL_CATEGORY_FOOD:                                // food
                        count = IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT) ? 10 : 4;
                        break;
                    case SPELL_CATEGORY_DRINK:                                // drink
                        count = 2;
                        break;
                }
                if (iProto->GetMaxStackSize() < count)
                    count = iProto->GetMaxStackSize();
            }
            StoreNewItemInBestSlots(itemId, count);
        }
    }

    for (PlayerCreateInfoItems::const_iterator item_id_itr = info->item.begin(); item_id_itr != info->item.end(); ++item_id_itr)
        StoreNewItemInBestSlots(item_id_itr->item_id, item_id_itr->item_amount);

    // bags and main-hand weapon must equipped at this moment
    // now second pass for not equipped (offhand weapon/shield if it attempt equipped before main-hand weapon)
    // or ammo not equipped in special bag
    for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            uint16 eDest;
            // equip offhand weapon/shield if it attempt equipped before main-hand weapon
            InventoryResult msg = CanEquipItem(NULL_SLOT, eDest, pItem, false);
            if (msg == EQUIP_ERR_OK)
            {
                RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
                EquipItem(eDest, pItem, true);
            }
            // move other items to more appropriate slots (ammo not equipped in special bag)
            else
            {
                ItemPosCountVec sDest;
                msg = CanStoreItem(NULL_BAG, NULL_SLOT, sDest, pItem, false);
                if (msg == EQUIP_ERR_OK)
                {
                    RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
                    pItem = StoreItem(sDest, pItem, true);
                }

                // if  this is ammo then use it
                msg = CanUseAmmo(pItem->GetEntry());
                if (msg == EQUIP_ERR_OK)
                    SetAmmo(pItem->GetEntry());
            }
        }
    }
    // all item positions resolved

    // ensure player starts with full health
    UpdateAllStats();
    SetFullHealth();

    CheckAllAchievementCriteria();

    return true;
}

bool Player::StoreNewItemInBestSlots(uint32 titem_id, uint32 titem_amount)
{
    LOG_DEBUG("entities.player.items", "STORAGE: Creating initial item, itemId = {}, count = {}", titem_id, titem_amount);

    // attempt equip by one
    while (titem_amount > 0)
    {
        uint16 eDest;
        InventoryResult msg = CanEquipNewItem(NULL_SLOT, eDest, titem_id, false);
        if (msg != EQUIP_ERR_OK)
            break;

        EquipNewItem(eDest, titem_id, true);
        AutoUnequipOffhandIfNeed();
        --titem_amount;
    }

    if (titem_amount == 0)
        return true;                                        // equipped

    // attempt store
    ItemPosCountVec sDest;
    // store in main bag to simplify second pass (special bags can be not equipped yet at this moment)
    InventoryResult msg = CanStoreNewItem(INVENTORY_SLOT_BAG_0, NULL_SLOT, sDest, titem_id, titem_amount);
    if (msg == EQUIP_ERR_OK)
    {
        StoreNewItem(sDest, titem_id, true);
        return true;                                        // stored
    }

    // item can't be added
    LOG_ERROR("entities.player", "STORAGE: Can't equip or store initial item {} for race {} class {}, error msg = {}", titem_id, getRace(true), getClass(), msg);
    return false;
}

void Player::SendMirrorTimer(MirrorTimerType Type, uint32 MaxValue, uint32 CurrentValue, int32 Regen)
{
    if (int(MaxValue) == DISABLED_MIRROR_TIMER)
    {
        if (int(CurrentValue) != DISABLED_MIRROR_TIMER)
            StopMirrorTimer(Type);
        return;
    }
    SendDirectMessage(WorldPackets::Misc::StartMirrorTimer(Type, CurrentValue, MaxValue, Regen, 0, 0).Write());
}

void Player::StopMirrorTimer(MirrorTimerType Type)
{
    m_MirrorTimer[Type] = DISABLED_MIRROR_TIMER;
    SendDirectMessage(WorldPackets::Misc::StopMirrorTimer(Type).Write());
}

bool Player::IsImmuneToEnvironmentalDamage()
{
    // check for GM and death state included in isAttackableByAOE
    return (!isTargetableForAttack(false, nullptr)) || isTotalImmune();
}

uint32 Player::EnvironmentalDamage(EnviromentalDamage type, uint32 damage)
{
    if (IsImmuneToEnvironmentalDamage())
        return 0;

    // Absorb, resist some environmental damage type
    uint32 absorb = 0;
    uint32 resist = 0;

    switch (type)
    {
        case DAMAGE_LAVA:
        case DAMAGE_SLIME:
        {
            DamageInfo dmgInfo(this, this, damage, nullptr, type == DAMAGE_LAVA ? SPELL_SCHOOL_MASK_FIRE : SPELL_SCHOOL_MASK_NATURE, DIRECT_DAMAGE);
            Unit::CalcAbsorbResist(dmgInfo);
            absorb = dmgInfo.GetAbsorb();
            resist = dmgInfo.GetResist();
            damage = dmgInfo.GetDamage();
        }
        default:
            break;
    }

    Unit::DealDamageMods(this, damage, &absorb);

    WorldPackets::CombatLog::EnvironmentalDamageLog packet;
    packet.Victim = GetGUID();
    packet.Type = type != DAMAGE_FALL_TO_VOID ? type : DAMAGE_FALL;
    packet.Amount = damage;
    packet.Absorbed = absorb;
    packet.Resisted = resist;
    SendMessageToSet(packet.Write(), true);

    uint32 final_damage = Unit::DealDamage(this, this, damage, nullptr, SELF_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, nullptr, false);

    if (!IsAlive())
    {
        if (type == DAMAGE_FALL)                               // DealDamage not apply item durability loss at self damage
        {
            LOG_DEBUG("entities.player", "Player::EnvironmentalDamage: Player '{}' ({}) fall to death, losing {} durability",
                GetName(), GetGUID().ToString(), sWorld->getRate(RATE_DURABILITY_LOSS_ON_DEATH));
            DurabilityLossAll(sWorld->getRate(RATE_DURABILITY_LOSS_ON_DEATH), false);
            // durability lost message
            SendDurabilityLoss();
        }

        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_DEATHS_FROM, 1, type);
    }

    return final_damage;
}

int32 Player::getMaxTimer(MirrorTimerType timer)
{
    switch (timer)
    {
        case FATIGUE_TIMER:
            return MINUTE * IN_MILLISECONDS;
        case BREATH_TIMER:
            {
                if (!IsAlive() || HasAuraType(SPELL_AURA_WATER_BREATHING) || GetSession()->GetSecurity() >= AccountTypes(sWorld->getIntConfig(CONFIG_DISABLE_BREATHING)))
                    return DISABLED_MIRROR_TIMER;
                int32 UnderWaterTime = sWorld->getIntConfig(CONFIG_WATER_BREATH_TIMER);
                AuraEffectList const& mModWaterBreathing = GetAuraEffectsByType(SPELL_AURA_MOD_WATER_BREATHING);
                for (AuraEffectList::const_iterator i = mModWaterBreathing.begin(); i != mModWaterBreathing.end(); ++i)
                    AddPct(UnderWaterTime, (*i)->GetAmount());
                return UnderWaterTime;
            }
        case FIRE_TIMER:
            {
                if (!IsAlive())
                    return DISABLED_MIRROR_TIMER;
                return 2020;
            }
        default:
            return 0;
    }
}

void Player::HandleDrowning(uint32 time_diff)
{
    if (!m_MirrorTimerFlags)
        return;

    // In water
    if (m_MirrorTimerFlags & UNDERWATER_INWATER)
    {
        // Breath timer not activated - activate it
        if (m_MirrorTimer[BREATH_TIMER] == DISABLED_MIRROR_TIMER)
        {
            m_MirrorTimer[BREATH_TIMER] = getMaxTimer(BREATH_TIMER);
            SendMirrorTimer(BREATH_TIMER, m_MirrorTimer[BREATH_TIMER], m_MirrorTimer[BREATH_TIMER], -1);
        }
        else                                                              // If activated - do tick
        {
            m_MirrorTimer[BREATH_TIMER] -= time_diff;
            // Timer limit - need deal damage
            if (m_MirrorTimer[BREATH_TIMER] < 0)
            {
                m_MirrorTimer[BREATH_TIMER] += 1 * IN_MILLISECONDS;
                // Calculate and deal damage
                /// @todo: Check this formula
                uint32 damage = GetMaxHealth() / 5 + urand(0, GetLevel() - 1);
                EnvironmentalDamage(DAMAGE_DROWNING, damage);
            }
            else if (!(m_MirrorTimerFlagsLast & UNDERWATER_INWATER))      // Update time in client if need
                SendMirrorTimer(BREATH_TIMER, getMaxTimer(BREATH_TIMER), m_MirrorTimer[BREATH_TIMER], -1);
        }
    }
    else if (m_MirrorTimer[BREATH_TIMER] != DISABLED_MIRROR_TIMER)        // Regen timer
    {
        int32 UnderWaterTime = getMaxTimer(BREATH_TIMER);
        // Need breath regen
        m_MirrorTimer[BREATH_TIMER] += 10 * time_diff;
        if (m_MirrorTimer[BREATH_TIMER] >= UnderWaterTime || !IsAlive())
            StopMirrorTimer(BREATH_TIMER);
        else if (m_MirrorTimerFlagsLast & UNDERWATER_INWATER)
            SendMirrorTimer(BREATH_TIMER, UnderWaterTime, m_MirrorTimer[BREATH_TIMER], 10);
    }

    // In dark water
    if (m_MirrorTimerFlags & UNDERWATER_INDARKWATER)
    {
        // Fatigue timer not activated - activate it
        if (m_MirrorTimer[FATIGUE_TIMER] == DISABLED_MIRROR_TIMER)
        {
            m_MirrorTimer[FATIGUE_TIMER] = getMaxTimer(FATIGUE_TIMER);
            SendMirrorTimer(FATIGUE_TIMER, m_MirrorTimer[FATIGUE_TIMER], m_MirrorTimer[FATIGUE_TIMER], -1);
        }
        else
        {
            m_MirrorTimer[FATIGUE_TIMER] -= time_diff;
            // Timer limit - need deal damage or teleport ghost to graveyard
            if (m_MirrorTimer[FATIGUE_TIMER] < 0)
            {
                m_MirrorTimer[FATIGUE_TIMER] += 1 * IN_MILLISECONDS;
                if (IsAlive())                                            // Calculate and deal damage
                {
                    uint32 damage = GetMaxHealth() / 5 + urand(0, GetLevel() - 1);
                    EnvironmentalDamage(DAMAGE_EXHAUSTED, damage);
                }
                else if (HasPlayerFlag(PLAYER_FLAGS_GHOST))       // Teleport ghost to graveyard
                    RepopAtGraveyard();
            }
            else if (!(m_MirrorTimerFlagsLast & UNDERWATER_INDARKWATER))
                SendMirrorTimer(FATIGUE_TIMER, getMaxTimer(FATIGUE_TIMER), m_MirrorTimer[FATIGUE_TIMER], -1);
        }
    }
    else if (m_MirrorTimer[FATIGUE_TIMER] != DISABLED_MIRROR_TIMER)       // Regen timer
    {
        int32 DarkWaterTime = getMaxTimer(FATIGUE_TIMER);
        m_MirrorTimer[FATIGUE_TIMER] += 10 * time_diff;
        if (m_MirrorTimer[FATIGUE_TIMER] >= DarkWaterTime || !IsAlive())
            StopMirrorTimer(FATIGUE_TIMER);
        else if (m_MirrorTimerFlagsLast & UNDERWATER_INDARKWATER)
            SendMirrorTimer(FATIGUE_TIMER, DarkWaterTime, m_MirrorTimer[FATIGUE_TIMER], 10);
    }

    if (m_MirrorTimerFlags & (UNDERWATER_INLAVA /*| UNDERWATER_INSLIME*/) && !(_lastLiquid && _lastLiquid->SpellId))
    {
        // Breath timer not activated - activate it
        if (m_MirrorTimer[FIRE_TIMER] == DISABLED_MIRROR_TIMER)
            m_MirrorTimer[FIRE_TIMER] = getMaxTimer(FIRE_TIMER);
        else
        {
            m_MirrorTimer[FIRE_TIMER] -= time_diff;
            if (m_MirrorTimer[FIRE_TIMER] < 0)
            {
                m_MirrorTimer[FIRE_TIMER] += 2020;
                // Calculate and deal damage
                /// @todo: Check this formula
                uint32 damage = urand(600, 700);
                if (m_MirrorTimerFlags & UNDERWATER_INLAVA)
                    EnvironmentalDamage(DAMAGE_LAVA, damage);
                // need to skip Slime damage in Undercity,
                // maybe someone can find better way to handle environmental damage
                //else if (m_zoneUpdateId != 1497)
                //    EnvironmentalDamage(DAMAGE_SLIME, damage);
            }
        }
    }
    else
        m_MirrorTimer[FIRE_TIMER] = DISABLED_MIRROR_TIMER;

    // Recheck timers flag
    m_MirrorTimerFlags &= ~UNDERWATER_EXIST_TIMERS;
    for (uint8 i = 0; i < MAX_TIMERS; ++i)
        if (m_MirrorTimer[i] != DISABLED_MIRROR_TIMER)
        {
            m_MirrorTimerFlags |= UNDERWATER_EXIST_TIMERS;
            break;
        }
    m_MirrorTimerFlagsLast = m_MirrorTimerFlags;
}

///The player sobers by 1% every 9 seconds
void Player::HandleSobering()
{
    m_drunkTimer = 0;

    uint8 currentDrunkValue = GetDrunkValue();
    uint8 drunk = currentDrunkValue ? --currentDrunkValue : 0;
    SetDrunkValue(drunk);
}

/*static*/ DrunkenState Player::GetDrunkenstateByValue(uint8 value)
{
    if (value >= 90)
        return DRUNKEN_SMASHED;
    if (value >= 50)
        return DRUNKEN_DRUNK;
    if (value)
        return DRUNKEN_TIPSY;
    return DRUNKEN_SOBER;
}

void Player::SetDrunkValue(uint8 newDrunkValue, uint32 itemId /*= 0*/)
{
    newDrunkValue = std::min<uint8>(newDrunkValue, 100);
    if (newDrunkValue == GetDrunkValue())
        return;

    uint32 oldDrunkenState = Player::GetDrunkenstateByValue(GetDrunkValue());
    uint32 newDrunkenState = Player::GetDrunkenstateByValue(newDrunkValue);

    SetByteValue(PLAYER_BYTES_3, PLAYER_BYTES_3_OFFSET_INEBRIATION, newDrunkValue);
    UpdateInvisibilityDrunkDetect();

    m_drunkTimer = 0; // reset sobering timer

    if (newDrunkenState == oldDrunkenState)
        return;

    WorldPackets::Misc::CrossedInebriationThreshold data;
    data.Guid = GetGUID();
    data.Threshold = newDrunkenState;
    data.ItemID = itemId;

    SendMessageToSet(data.Write(), true);
}

void Player::UpdateInvisibilityDrunkDetect()
{
    // select drunk percent or total SPELL_AURA_MOD_FAKE_INEBRIATE amount, whichever is higher for visibility updates
    uint8 drunkValue        = GetDrunkValue();
    int32 fakeDrunkValue    = GetFakeDrunkValue();
    int32 maxDrunkValue     = std::max<int32>(drunkValue, fakeDrunkValue);

    if (maxDrunkValue != 0)
    {
        m_invisibilityDetect.AddFlag(INVISIBILITY_DRUNK);
        m_invisibilityDetect.SetValue(INVISIBILITY_DRUNK, maxDrunkValue);
    }
    else
        m_invisibilityDetect.DelFlag(INVISIBILITY_DRUNK);

    UpdateObjectVisibility();
}

void Player::setDeathState(DeathState s, bool /*despawn = false*/)
{
    uint32 ressSpellId = 0;

    bool cur = IsAlive();

    if (s == DeathState::JustDied)
    {
        if (!cur)
        {
            LOG_ERROR("entities.player", "setDeathState: attempt to kill a dead player {} ({})", GetName(), GetGUID().ToString());
            return;
        }

        // drunken state is cleared on death
        SetDrunkValue(0);
        // lost combo points at any target (targeted combo points clear in Unit::setDeathState)
        ClearComboPoints();

        clearResurrectRequestData();

        //FIXME: is pet dismissed at dying or releasing spirit? if second, add setDeathState(DeathState::Dead) to HandleRepopRequestOpcode and define pet unsummon here with (s == DEAD)
        RemovePet(nullptr, PET_SAVE_NOT_IN_SLOT, true);

        // save value before aura remove in Unit::setDeathState
        ressSpellId = GetUInt32Value(PLAYER_SELF_RES_SPELL);

        // xinef: disable passive area auras!
        AddUnitState(UNIT_STATE_ISOLATED);

        // passive spell
        if (!ressSpellId)
            ressSpellId = GetResurrectionSpellId();
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_DEATH_AT_MAP, 1);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_DEATH, 1);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_DEATH_IN_DUNGEON, 1);

        // Xinef: reset all death criterias
        ResetAchievementCriteria(ACHIEVEMENT_CRITERIA_CONDITION_NO_DEATH, 0);
    }
    // xinef: enable passive area auras!
    else if (s == DeathState::Alive)
        ClearUnitState(UNIT_STATE_ISOLATED);

    Unit::setDeathState(s);

    if (NeedSendSpectatorData())
        ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "STA", IsAlive() ? 1 : 0);

    // restore resurrection spell id for player after aura remove
    if (s == DeathState::JustDied && cur && ressSpellId)
        SetUInt32Value(PLAYER_SELF_RES_SPELL, ressSpellId);

    if (IsAlive() && !cur)
        //clear aura case after resurrection by another way (spells will be applied before next death)
        SetUInt32Value(PLAYER_SELF_RES_SPELL, 0);
}

void Player::SetRestState(uint32 triggerId)
{
    _innTriggerId = triggerId;
    _restTime = GameTime::GetGameTime().count();
    SetPlayerFlag(PLAYER_FLAGS_RESTING);
}

void Player::RemoveRestState()
{
    _innTriggerId = 0;
    _restTime = 0;
    RemovePlayerFlag(PLAYER_FLAGS_RESTING);
}

bool Player::BuildEnumData(PreparedQueryResult result, WorldPacket* data)
{
    //             0               1                2                3                 4                  5                 6               7
    //    "SELECT characters.guid, characters.name, characters.race, characters.class, characters.gender, characters.skin, characters.face, characters.hairStyle,
    //     8                     9                       10              11               12              13                     14                     15
    //    characters.hairColor, characters.facialStyle, character.level, characters.zone, characters.map, characters.position_x, characters.position_y, characters.position_z,
    //    16                    17                      18                   19                   20                     21                   22               23
    //    guild_member.guildid, characters.playerFlags, characters.at_login, character_pet.entry, character_pet.modelid, character_pet.level, characters.equipmentCache, character_banned.guid,
    //    24                      25
    //    characters.extra_flags, character_declinedname.genitive

    Field* fields = result->Fetch();

    ObjectGuid::LowType guidLow = fields[0].Get<uint32>();
    uint8 plrRace = fields[2].Get<uint8>();
    uint8 plrClass = fields[3].Get<uint8>();
    uint8 gender = fields[4].Get<uint8>();

    ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(guidLow);

    PlayerInfo const* info = sObjectMgr->GetPlayerInfo(plrRace, plrClass);
    if (!info)
    {
        LOG_ERROR("entities.player", "Player {} has incorrect race/class pair. Don't build enum.", guid.ToString());
        return false;
    }
    else if (!IsValidGender(gender))
    {
        LOG_ERROR("entities.player", "Player ({}) has incorrect gender ({}), don't build enum.", guid.ToString(), gender);
        return false;
    }

    *data << guid;
    *data << fields[1].Get<std::string>();                          // name
    *data << uint8(plrRace);                                 // race
    *data << uint8(plrClass);                                // class
    *data << uint8(gender);                                  // gender

    uint8 skin = fields[5].Get<uint8>();
    uint8 face = fields[6].Get<uint8>();
    uint8 hairStyle = fields[7].Get<uint8>();
    uint8 hairColor = fields[8].Get<uint8>();
    uint8 facialStyle = fields[9].Get<uint8>();

    uint32 charFlags = 0;
    uint32 playerFlags = fields[17].Get<uint32>();
    uint16 atLoginFlags = fields[18].Get<uint16>();
    uint32 zone = (atLoginFlags & AT_LOGIN_FIRST) != 0 ? 0 : fields[11].Get<uint16>(); // if first login do not show the zone

    *data << uint8(skin);
    *data << uint8(face);
    *data << uint8(hairStyle);
    *data << uint8(hairColor);
    *data << uint8(facialStyle);

    *data << uint8(fields[10].Get<uint8>());                   // level
    *data << uint32(zone);                                   // zone
    *data << uint32(fields[12].Get<uint16>());                 // map

    *data << fields[13].Get<float>();                          // x
    *data << fields[14].Get<float>();                          // y
    *data << fields[15].Get<float>();                          // z

    *data << uint32(fields[16].Get<uint32>());                 // guild id

    if (atLoginFlags & AT_LOGIN_RESURRECT)
        playerFlags &= ~PLAYER_FLAGS_GHOST;
    if (playerFlags & PLAYER_FLAGS_HIDE_HELM)
        charFlags |= CHARACTER_FLAG_HIDE_HELM;
    if (playerFlags & PLAYER_FLAGS_HIDE_CLOAK)
        charFlags |= CHARACTER_FLAG_HIDE_CLOAK;
    if (playerFlags & PLAYER_FLAGS_GHOST)
        charFlags |= CHARACTER_FLAG_GHOST;
    if (atLoginFlags & AT_LOGIN_RENAME)
        charFlags |= CHARACTER_FLAG_RENAME;
    if (fields[23].Get<uint32>())
        charFlags |= CHARACTER_FLAG_LOCKED_BY_BILLING;
    if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
    {
        if (!fields[25].Get<std::string>().empty())
            charFlags |= CHARACTER_FLAG_DECLINED;
    }
    else
        charFlags |= CHARACTER_FLAG_DECLINED;

    *data << uint32(charFlags);                              // character flags

    // character customize flags
    if (atLoginFlags & AT_LOGIN_CUSTOMIZE)
        *data << uint32(CHAR_CUSTOMIZE_FLAG_CUSTOMIZE);
    else if (atLoginFlags & AT_LOGIN_CHANGE_FACTION)
        *data << uint32(CHAR_CUSTOMIZE_FLAG_FACTION);
    else if (atLoginFlags & AT_LOGIN_CHANGE_RACE)
        *data << uint32(CHAR_CUSTOMIZE_FLAG_RACE);
    else
        *data << uint32(CHAR_CUSTOMIZE_FLAG_NONE);

    // First login
    *data << uint8(atLoginFlags & AT_LOGIN_FIRST ? 1 : 0);

    // Pets info
    uint32 petDisplayId = 0;
    uint32 petLevel = 0;
    uint32 petFamily = 0;

    // show pet at selection character in character list only for non-ghost character
    if (result && !(playerFlags & PLAYER_FLAGS_GHOST) && (plrClass == CLASS_WARLOCK || plrClass == CLASS_HUNTER || (plrClass == CLASS_DEATH_KNIGHT && (fields[21].Get<uint32>()&PLAYER_EXTRA_SHOW_DK_PET))))
    {
        uint32 entry = fields[19].Get<uint32>();
        CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(entry);
        if (creatureInfo)
        {
            petDisplayId = fields[20].Get<uint32>();
            petLevel = fields[21].Get<uint16>();
            petFamily = creatureInfo->family;
        }
    }

    *data << uint32(petDisplayId);
    *data << uint32(petLevel);
    *data << uint32(petFamily);

    std::vector<std::string_view> equipment = Acore::Tokenize(fields[22].Get<std::string_view>(), ' ', false);
    for (uint8 slot = 0; slot < INVENTORY_SLOT_BAG_END; ++slot)
    {
        uint32 const visualBase = slot * 2;
        Optional<uint32> itemId;

        if (visualBase < equipment.size())
        {
            itemId = Acore::StringTo<uint32>(equipment[visualBase]);
        }

        ItemTemplate const* proto = nullptr;
        if (itemId)
        {
            proto = sObjectMgr->GetItemTemplate(*itemId);
        }

        if (!proto)
        {
            if (!itemId || *itemId)
            {
                LOG_WARN("entities.player.loading", "Player {} has invalid equipment '{}' in `equipmentcache` at index {}. Skipped.",
                    guid.ToString(), (visualBase < equipment.size()) ? equipment[visualBase] : "<none>", visualBase);
            }

            *data << uint32(0);
            *data << uint8(0);
            *data << uint32(0);

            continue;
        }

        SpellItemEnchantmentEntry const* enchant = nullptr;

        Optional<uint32> enchants = {};
        if ((visualBase + 1) < equipment.size())
        {
            enchants = Acore::StringTo<uint32>(equipment[visualBase + 1]);
        }

        if (!enchants)
        {
            LOG_WARN("entities.player.loading", "Player {} has invalid enchantment info '{}' in `equipmentcache` at index {}. Skipped.",
                guid.ToString(), ((visualBase + 1) < equipment.size()) ? equipment[visualBase + 1] : "<none>", visualBase + 1);

            enchants = 0;
        }

        for (uint8 enchantSlot = PERM_ENCHANTMENT_SLOT; enchantSlot <= TEMP_ENCHANTMENT_SLOT; ++enchantSlot)
        {
            // values stored in 2 uint16
            uint32 enchantId = 0x0000FFFF & ((*enchants) >> enchantSlot * 16);
            if (!enchantId)
            {
                continue;
            }

            enchant = sSpellItemEnchantmentStore.LookupEntry(enchantId);
            if (enchant)
            {
                break;
            }
        }

        *data << uint32(proto->DisplayInfoID);
        *data << uint8(proto->InventoryType);
        *data << uint32(enchant ? enchant->aura_id : 0);
    }

    return true;
}

bool Player::IsClass(Classes unitClass, ClassContext context) const
{
    Optional<bool> scriptResult = sScriptMgr->OnPlayerIsClass(this, unitClass, context);
    if (scriptResult != std::nullopt)
        return *scriptResult;
    else
        return (getClass() == unitClass);
}

void Player::ToggleAFK()
{
    ToggleFlag(PLAYER_FLAGS, PLAYER_FLAGS_AFK);

    // afk player not allowed in battleground
    if (!IsGameMaster() && isAFK() && InBattleground())
        LeaveBattleground();
}

void Player::ToggleDND()
{
    ToggleFlag(PLAYER_FLAGS, PLAYER_FLAGS_DND);
}

uint8 Player::GetChatTag() const
{
    uint8 tag = CHAT_TAG_NONE;

    if (isGMChat())
        tag |= CHAT_TAG_GM;
    if (isDND())
        tag |= CHAT_TAG_DND;
    if (isAFK())
        tag |= CHAT_TAG_AFK;
    if (IsCommentator())
        tag |= CHAT_TAG_COM;
    if (IsDeveloper())
        tag |= CHAT_TAG_DEV;

    return tag;
}

void Player::SendTeleportAckPacket()
{
    WorldPacket data(MSG_MOVE_TELEPORT_ACK, 41);
    data << GetPackGUID();
    data << uint32(0);                                     // this value increments every time
    BuildMovementPacket(&data);
    GetSession()->SendPacket(&data);
}

bool Player::TeleportTo(uint32 mapid, float x, float y, float z, float orientation, uint32 options /*= 0*/, Unit* target /*= nullptr*/, bool newInstance /*= false*/)
{
    if (!MapMgr::IsValidMapCoord(mapid, x, y, z, orientation))
    {
        LOG_ERROR("entities.player", "TeleportTo: invalid map ({}) or invalid coordinates (X: {}, Y: {}, Z: {}, O: {}) given when teleporting player ({}, name: {}, map: {}, X: {}, Y: {}, Z: {}, O: {}).",
                       mapid, x, y, z, orientation, GetGUID().ToString(), GetName(), GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
        return false;
    }

    if (AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()) && DisableMgr::IsDisabledFor(DISABLE_TYPE_MAP, mapid, this))
    {
        LOG_ERROR("entities.player", "Player ({}, name: {}) tried to enter a forbidden map {}", GetGUID().ToString(), GetName(), mapid);
        SendTransferAborted(mapid, TRANSFER_ABORT_MAP_NOT_ALLOWED);
        return false;
    }

    // preparing unsummon pet if lost (we must get pet before teleportation or will not find it later)
    Pet* pet = GetPet();

    MapEntry const* mEntry = sMapStore.LookupEntry(mapid);

    // don't let enter battlegrounds without assigned battleground id (for example through areatrigger)...
    if (!InBattleground() && mEntry->IsBattlegroundOrArena())
        return false;

    // pussywizard: arena spectator, prevent teleporting from arena to instance/etc
    if (GetMapId() != mapid && IsSpectator() && mEntry->Instanceable())
    {
        SendTransferAborted(mapid, TRANSFER_ABORT_MAP_NOT_ALLOWED);
        return false;
    }

    // client without expansion support
    if (GetSession()->Expansion() < mEntry->Expansion())
    {
        LOG_DEBUG("maps", "Player {} using client without required expansion tried teleport to non accessible map {}", GetName(), mapid);

        if (GetTransport())
        {
            m_transport->RemovePassenger(this);
            m_transport = nullptr;
            m_movementInfo.transport.Reset();
            m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
            RepopAtGraveyard();                             // teleport to near graveyard if on transport, looks blizz like :)
        }

        SendTransferAborted(mapid, TRANSFER_ABORT_INSUF_EXPAN_LVL, mEntry->Expansion());

        return false;                                       // normal client can't teleport to this map...
    }
    else
        LOG_DEBUG("maps", "Player {} is being teleported to map {}", GetName(), mapid);

    // xinef: do this here in case teleport failed in above checks
    if (!(options & TELE_TO_NOT_LEAVE_TAXI) && IsInFlight())
    {
        GetMotionMaster()->MovementExpired();
        CleanupAfterTaxiFlight();
    }

    if (!(options & TELE_TO_NOT_LEAVE_VEHICLE) && m_vehicle)
        ExitVehicle();

    // reset movement flags at teleport, because player will continue move with these flags after teleport
    SetUnitMovementFlags(GetUnitMovementFlags() & MOVEMENTFLAG_MASK_HAS_PLAYER_STATUS_OPCODE);
    DisableSpline();

    // Xinef: Remove all movement imparing effects auras, skip small teleport like blink
    if (mapid != GetMapId() || GetDistance2d(x, y) > 100)
    {
        RemoveAurasByType(SPELL_AURA_MOD_STUN);
        RemoveAurasByType(SPELL_AURA_MOD_FEAR);
        RemoveAurasByType(SPELL_AURA_MOD_CONFUSE);
        RemoveAurasByType(SPELL_AURA_MOD_ROOT);
        // remove auras that should be removed when being teleported
        RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TELEPORTED);
    }

    if (m_transport)
    {
        if (options & TELE_TO_NOT_LEAVE_TRANSPORT)
            AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
        else
        {
            m_transport->RemovePassenger(this);
            m_transport = nullptr;
            m_movementInfo.transport.Reset();
            m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
        }
    }

    // The player was ported to another map and loses the duel immediately.
    // We have to perform this check before the teleport, otherwise the
    // ObjectAccessor won't find the flag.
    if (duel && GetMapId() != mapid && GetMap()->GetGameObject(GetGuidValue(PLAYER_DUEL_ARBITER)))
        DuelComplete(DUEL_FLED);

    if (!sScriptMgr->OnBeforePlayerTeleport(this, mapid, x, y, z, orientation, options, target))
        return false;

    if (GetMapId() == mapid && !newInstance)
    {
        //lets reset far teleport flag if it wasn't reset during chained teleports
        SetSemaphoreTeleportFar(0);

        SetHasDelayedTeleport(false); // pussywizard: current teleport cancels stored one
        //if teleport spell is casted in Unit::Update() func
        //then we need to delay it until update process will be finished
        if (MustDelayTeleport())
        {
            SetHasDelayedTeleport(true);
            SetSemaphoreTeleportNear(GameTime::GetGameTime().count());
            //lets save teleport destination for player
            teleportStore_dest = WorldLocation(mapid, x, y, z, orientation);
            teleportStore_options = options;
            return true;
        }

        if (options & TELE_TO_WITH_PET)
            UnsummonPetTemporaryIfAny();

        if (!(options & TELE_TO_NOT_UNSUMMON_PET))
        {
            //same map, only remove pet if out of range for new position
            if (pet && !pet->IsWithinDist3d(x, y, z, GetMap()->GetVisibilityRange()))
                UnsummonPetTemporaryIfAny();
        }

        if (!(options & TELE_TO_NOT_LEAVE_COMBAT))
            CombatStop();

        // this will be used instead of the current location in SaveToDB
        teleportStore_dest = WorldLocation(mapid, x, y, z, orientation);
        SetFallInformation(GameTime::GetGameTime().count(), z);

        // code for finish transfer called in WorldSession::HandleMovementOpcodes()
        // at client packet MSG_MOVE_TELEPORT_ACK
        SetSemaphoreTeleportNear(GameTime::GetGameTime().count());
        // near teleport, triggering send MSG_MOVE_TELEPORT_ACK from client at landing
        if (!GetSession()->PlayerLogout())
        {
            SetCanTeleport(true);
            Position oldPos = GetPosition();
            Relocate(x, y, z, orientation);
            SendTeleportAckPacket();
            SendTeleportPacket(oldPos); // this automatically relocates to oldPos in order to broadcast the packet in the right place
        }
    }
    else
    {
        if (IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_TELEPORT) && GetMapId() == 609 && !IsGameMaster() && !HasSpell(50977))
        {
            SendTransferAborted(mapid, TRANSFER_ABORT_UNIQUE_MESSAGE, 1);
            return false;
        }

        // far teleport to another map
        Map* oldmap = IsInWorld() ? GetMap() : nullptr;
        // check if we can enter before stopping combat / removing pet / totems / interrupting spells

        // Check enter rights before map getting to avoid creating instance copy for player
        // this check not dependent from map instance copy and same for all instance copies of selected map
        if (!(options & TELE_TO_GM_MODE) && sMapMgr->PlayerCannotEnter(mapid, this, false))
            return false;

        // if PlayerCannotEnter -> CanEnter: checked above
        {
            //lets reset near teleport flag if it wasn't reset during chained teleports
            SetSemaphoreTeleportNear(0);

            SetHasDelayedTeleport(false); // pussywizard: current teleport cancels stored one
            //if teleport spell is casted in Unit::Update() func
            //then we need to delay it until update process will be finished
            if (MustDelayTeleport())
            {
                SetHasDelayedTeleport(true);
                SetSemaphoreTeleportFar(GameTime::GetGameTime().count());
                //lets save teleport destination for player
                teleportStore_dest = WorldLocation(mapid, x, y, z, orientation);
                teleportStore_options = options;
                return true;
            }

            SetSelection(ObjectGuid::Empty);

            CombatStop();

            // remove arena spell coldowns/buffs now to also remove pet's cooldowns before it's temporarily unsummoned
            if (mEntry->IsBattleArena() && (HasPendingSpectatorForBG(0) || !HasPendingSpectatorForBG(GetBattlegroundId())))
            {
                // KEEP THIS ORDER!
                RemoveArenaAuras();
                if (pet)
                    pet->RemoveArenaAuras();

                RemoveArenaSpellCooldowns(true);
            }

            // remove pet on map change
            if (pet)
                UnsummonPetTemporaryIfAny();

            // remove all dyn objects
            RemoveAllDynObjects();

            // stop spellcasting
            // not attempt interrupt teleportation spell at caster teleport
            if (!(options & TELE_TO_SPELL))
                if (IsNonMeleeSpellCast(true))
                    InterruptNonMeleeSpells(true);

            //remove auras before removing from map...
            RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_CHANGE_MAP | AURA_INTERRUPT_FLAG_MOVE | AURA_INTERRUPT_FLAG_TURNING);

            if (!GetSession()->PlayerLogout())
            {
                // send transfer packets
                WorldPacket data(SMSG_TRANSFER_PENDING, 4 + 4 + 4);
                data << uint32(mapid);
                if (m_transport)
                    data << m_transport->GetEntry() << GetMapId();

                GetSession()->SendPacket(&data);
            }

            // remove from old map now
            if (oldmap)
                oldmap->RemovePlayerFromMap(this, false);

            // xinef: do this before setting fall information!
            if (IsMounted() && (!GetMap()->GetEntry()->IsDungeon() && !GetMap()->GetEntry()->IsBattlegroundOrArena()) && !m_transport)
            {
                AuraEffectList const& auras = GetAuraEffectsByType(SPELL_AURA_MOUNTED);
                if (!auras.empty())
                {
                    SetMountBlockId((*auras.begin())->GetId());
                    RemoveAurasByType(SPELL_AURA_MOUNTED);
                }
            }

            teleportStore_dest = WorldLocation(mapid, x, y, z, orientation);
            SetFallInformation(GameTime::GetGameTime().count(), z);
            // if the player is saved before worldportack (at logout for example)
            // this will be used instead of the current location in SaveToDB

            if (!GetSession()->PlayerLogout())
            {
                SetCanTeleport(true);
                WorldPacket data(SMSG_NEW_WORLD, 4 + 4 + 4 + 4 + 4);
                data << uint32(mapid);
                if (m_transport)
                    data << m_movementInfo.transport.pos.PositionXYZOStream();
                else
                    data << teleportStore_dest.PositionXYZOStream();

                GetSession()->SendPacket(&data);
                SendSavedInstances();
            }

            // move packet sent by client always after far teleport
            // code for finish transfer to new map called in WorldSession::HandleMoveWorldportAckOpcode at client packet
            SetSemaphoreTeleportFar(GameTime::GetGameTime().count());
        }
    }
    return true;
}

bool Player::TeleportToEntryPoint()
{
    ScheduleDelayedOperation(DELAYED_BG_MOUNT_RESTORE);
    ScheduleDelayedOperation(DELAYED_BG_TAXI_RESTORE);
    ScheduleDelayedOperation(DELAYED_BG_GROUP_RESTORE);

    WorldLocation loc = m_entryPointData.joinPos;
    m_entryPointData.joinPos.m_mapId = MAPID_INVALID;

    if (loc.m_mapId == MAPID_INVALID)
    {
        return TeleportTo(m_homebindMapId, m_homebindX, m_homebindY, m_homebindZ, GetOrientation());
    }

    return TeleportTo(loc);
}

void Player::ProcessDelayedOperations()
{
    if (m_DelayedOperations == 0)
        return;

    if (m_DelayedOperations & DELAYED_RESURRECT_PLAYER)
    {
        ResurrectPlayer(0.0f, false);

        if (GetMaxHealth() > m_resurrectHealth)
            SetHealth(m_resurrectHealth);
        else
            SetFullHealth();

        if (GetMaxPower(POWER_MANA) > m_resurrectMana)
            SetPower(POWER_MANA, m_resurrectMana);
        else
            SetPower(POWER_MANA, GetMaxPower(POWER_MANA));

        SetPower(POWER_RAGE, 0);
        SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));

        SpawnCorpseBones();
    }

    if (m_DelayedOperations & DELAYED_SAVE_PLAYER)
        SaveToDB(false, false);

    if (m_DelayedOperations & DELAYED_SPELL_CAST_DESERTER)
    {
        Aura* aura = GetAura(26013);
        if (!aura || aura->GetDuration() <= 900000)
            CastSpell(this, 26013, true);
    }

    if (m_DelayedOperations & DELAYED_BG_MOUNT_RESTORE)
    {
        if (m_entryPointData.mountSpell)
        {
            // xinef: remove shapeshift auras
            if (IsInDisallowedMountForm())
            {
                RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);
            }
            AddAura(m_entryPointData.mountSpell, this);
            m_entryPointData.mountSpell = 0;
        }
    }

    if (m_DelayedOperations & DELAYED_BG_TAXI_RESTORE)
    {
        if (m_entryPointData.HasTaxiPath())
        {
            m_taxi.AddTaxiDestination(m_entryPointData.taxiPath[0]);
            m_taxi.AddTaxiDestination(m_entryPointData.taxiPath[1]);
            m_entryPointData.ClearTaxiPath();
            ContinueTaxiFlight();
        }
    }

    if (m_DelayedOperations & DELAYED_BG_GROUP_RESTORE)
    {
        if (Group* g = GetGroup())
            g->SendUpdateToPlayer(GetGUID());
    }

    if (m_DelayedOperations & DELAYED_VEHICLE_TELEPORT)
    {
        if (Vehicle* vehicle = GetVehicle())
        {
            SeatMap::iterator itr = vehicle->GetSeatIteratorForPassenger(this);
            if (itr != vehicle->Seats.end())
                if (Unit* base = vehicle->GetBase())
                {
                    ExitVehicle();
                    base->HandleSpellClick(this, itr->first);
                }
        }
    }

    //we have executed ALL delayed ops, so clear the flag
    m_DelayedOperations = 0;
}

void Player::AddToWorld()
{
    ///- Do not add/remove the player from the object storage
    ///- It will crash when updating the ObjectAccessor
    ///- The player should only be added when logging in
    Unit::AddToWorld();

    for (uint8 i = PLAYER_SLOT_START; i < PLAYER_SLOT_END; ++i)
        if (m_items[i])
            m_items[i]->AddToWorld();
}

void Player::RemoveFromWorld()
{
    // cleanup
    if (IsInWorld())
    {
        ///- Release charmed creatures, unsummon totems and remove pets/guardians
        StopCastingCharm();
        StopCastingBindSight();
        UnsummonPetTemporaryIfAny();
        ClearComboPoints(); // pussywizard: crashfix
        ClearComboPointHolders(); // pussywizard: crashfix
        if (ObjectGuid lguid = GetLootGUID()) // pussywizard: crashfix
            m_session->DoLootRelease(lguid);
        sOutdoorPvPMgr->HandlePlayerLeaveZone(this, m_zoneUpdateId);
        sBattlefieldMgr->HandlePlayerLeaveZone(this, m_zoneUpdateId);
    }

    // Remove items from world before self - player must be found in Item::RemoveFromObjectUpdate
    for (uint8 i = PLAYER_SLOT_START; i < PLAYER_SLOT_END; ++i)
    {
        if (m_items[i])
            m_items[i]->RemoveFromWorld();
    }

    for (ItemMap::iterator iter = mMitems.begin(); iter != mMitems.end(); ++iter)
        iter->second->RemoveFromWorld();

    ///- Do not add/remove the player from the object storage
    ///- It will crash when updating the ObjectAccessor
    ///- The player should only be removed when logging out
    Unit::RemoveFromWorld();

    if (m_uint32Values)
    {
        if (WorldObject* viewpoint = GetViewpoint())
        {
            LOG_FATAL("entities.player", "Player {} has viewpoint {} {} when removed from world", GetName(), viewpoint->GetEntry(), viewpoint->GetTypeId());
            SetViewpoint(viewpoint, false);
        }
    }
}

void Player::RegenerateAll()
{
    //if (m_regenTimer <= 500)
    //    return;

    m_regenTimerCount += m_regenTimer;
    m_foodEmoteTimerCount += m_regenTimer;

    Regenerate(POWER_ENERGY);

    Regenerate(POWER_MANA);

    // Runes act as cooldowns, and they don't need to send any data
    if (IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
        for (uint8 i = 0; i < MAX_RUNES; ++i)
        {
            // xinef: implement grace
            if (int32 cd = GetRuneCooldown(i))
            {
                SetRuneCooldown(i, (cd > m_regenTimer) ? cd - m_regenTimer : 0);
                // start grace counter, player must be in combat and rune has to go off cooldown
                if (IsInCombat() && cd <= m_regenTimer)
                    SetGracePeriod(i, m_regenTimer - cd + 1); // added 1 because m_regenTimer-cd can be equal 0
            }
            // xinef: if grace is started, increase it but no more than cap
            else if (uint32 grace = GetGracePeriod(i))
            {
                if (grace < RUNE_GRACE_PERIOD)
                    SetGracePeriod(i, std::min<uint32>(grace + m_regenTimer, RUNE_GRACE_PERIOD));
            }
        }

    if (m_regenTimerCount >= 2000)
    {
        // Not in combat or they have regeneration
        if (!IsInCombat() || IsPolymorphed() || m_baseHealthRegen ||
                HasAuraType(SPELL_AURA_MOD_REGEN_DURING_COMBAT) ||
                HasAuraType(SPELL_AURA_MOD_HEALTH_REGEN_IN_COMBAT))
        {
            RegenerateHealth();
        }

        Regenerate(POWER_RAGE);
        if (IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
            Regenerate(POWER_RUNIC_POWER);

        m_regenTimerCount -= 2000;
    }

    m_regenTimer = 0;

    // Handles the emotes for drinking and eating.
    // According to sniffs there is a background timer going on that repeats independed from the time window where the aura applies.
    // That's why we dont need to reset the timer on apply. In sniffs I have seen that the first call for the spell visual is totally random, then after
    // 5 seconds over and over again which confirms my theory that we have a independed timer.
    if (m_foodEmoteTimerCount >= 5000)
    {
        std::vector<AuraEffect*> auraList;
        AuraEffectList const& ModRegenAuras = GetAuraEffectsByType(SPELL_AURA_MOD_REGEN);
        AuraEffectList const& ModPowerRegenAuras = GetAuraEffectsByType(SPELL_AURA_MOD_POWER_REGEN);

        auraList.reserve(ModRegenAuras.size() + ModPowerRegenAuras.size());
        auraList.insert(auraList.end(), ModRegenAuras.begin(), ModRegenAuras.end());
        auraList.insert(auraList.end(), ModPowerRegenAuras.begin(), ModPowerRegenAuras.end());

        for (auto itr = auraList.begin(); itr != auraList.end(); ++itr)
        {
            // Food emote comes above drinking emote if we have to decide (mage regen food for example)
            if ((*itr)->GetBase()->HasEffectType(SPELL_AURA_MOD_REGEN) && (*itr)->GetSpellInfo()->AuraInterruptFlags & AURA_INTERRUPT_FLAG_NOT_SEATED)
            {
                SendPlaySpellVisual(SPELL_VISUAL_KIT_FOOD);
                break;
            }
            else if ((*itr)->GetBase()->HasEffectType(SPELL_AURA_MOD_POWER_REGEN) && (*itr)->GetSpellInfo()->AuraInterruptFlags & AURA_INTERRUPT_FLAG_NOT_SEATED)
            {
                SendPlaySpellVisual(SPELL_VISUAL_KIT_DRINK);
                break;
            }
        }
        m_foodEmoteTimerCount -= 5000;
    }
}

void Player::Regenerate(Powers power)
{
    uint32 maxValue = GetMaxPower(power);
    if (!maxValue)
        return;

    //If .cheat power is on always have the max power
    if (GetCommandStatus(CHEAT_POWER))
    {
        if (m_regenTimerCount >= 2000)
        {
            //Set the value to 0 first then set it to max to force resend of packet as for range clients keeps removing rage
            if (power == POWER_RAGE || power == POWER_RUNIC_POWER)
            {
                UpdateUInt32Value(static_cast<uint16>(UNIT_FIELD_POWER1) + power, 0);
            }

            SetPower(power, maxValue);
            return;
        }
    }

    uint32 curValue = GetPower(power);

    /// @todo: possible use of miscvalueb instead of amount
    if (HasAuraTypeWithMiscvalue(SPELL_AURA_PREVENT_REGENERATE_POWER, power + 1))
        return;

    float addvalue = 0.0f;

    switch (power)
    {
        case POWER_MANA:
            {
                bool recentCast = IsUnderLastManaUseEffect();
                float ManaIncreaseRate = sWorld->getRate(RATE_POWER_MANA);

                if (sWorld->getBoolConfig(CONFIG_LOW_LEVEL_REGEN_BOOST) && GetLevel() < 15)
                    ManaIncreaseRate = sWorld->getRate(RATE_POWER_MANA) * (2.066f - (GetLevel() * 0.066f));

                if (recentCast) // Trinity Updates Mana in intervals of 2s, which is correct
                    addvalue += GetFloatValue(UNIT_FIELD_POWER_REGEN_INTERRUPTED_FLAT_MODIFIER) *  ManaIncreaseRate * 0.001f * m_regenTimer;
                else
                    addvalue += GetFloatValue(UNIT_FIELD_POWER_REGEN_FLAT_MODIFIER) * ManaIncreaseRate * 0.001f * m_regenTimer;
            }
            break;
        case POWER_RAGE:                                    // Regenerate rage
            {
                if (!IsInCombat() && !HasAuraType(SPELL_AURA_INTERRUPT_REGEN))
                {
                    float RageDecreaseRate = sWorld->getRate(RATE_POWER_RAGE_LOSS);
                    addvalue += -20 * RageDecreaseRate;               // 2 rage by tick (= 2 seconds => 1 rage/sec)
                }
            }
            break;
        case POWER_ENERGY:                                  // Regenerate energy (rogue)
            addvalue += 0.01f * m_regenTimer * sWorld->getRate(RATE_POWER_ENERGY);
            break;
        case POWER_RUNIC_POWER:
            {
                if (!IsInCombat() && !HasAuraType(SPELL_AURA_INTERRUPT_REGEN))
                {
                    float RunicPowerDecreaseRate = sWorld->getRate(RATE_POWER_RUNICPOWER_LOSS);
                    addvalue += -30 * RunicPowerDecreaseRate;         // 3 RunicPower by tick
                }
            }
            break;
        case POWER_RUNE:
        case POWER_FOCUS:
        case POWER_HAPPINESS:
            break;
        case POWER_HEALTH:
            return;
        default:
            break;
    }

    // Mana regen calculated in Player::UpdateManaRegen()
    if (power != POWER_MANA)
    {
        AuraEffectList const& ModPowerRegenPCTAuras = GetAuraEffectsByType(SPELL_AURA_MOD_POWER_REGEN_PERCENT);
        for (AuraEffectList::const_iterator i = ModPowerRegenPCTAuras.begin(); i != ModPowerRegenPCTAuras.end(); ++i)
            if (Powers((*i)->GetMiscValue()) == power)
                AddPct(addvalue, (*i)->GetAmount());

        // Butchery requires combat for this effect
        if (power != POWER_RUNIC_POWER || IsInCombat())
            addvalue += float(GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_POWER_REGEN, power) * ((power != POWER_ENERGY) ? m_regenTimerCount : m_regenTimer)) / (5.0f * IN_MILLISECONDS);
    }

    if (addvalue < 0.0f)
    {
        if (curValue == 0)
            return;
    }
    else if (addvalue > 0.0f)
    {
        if (curValue == maxValue)
            return;
    }
    else
        return;

    addvalue += m_powerFraction[power];
    uint32 integerValue = uint32(std::fabs(addvalue));

    bool forcedUpdate = false;
    if (addvalue < 0.0f)
    {
        if (curValue > integerValue)
        {
            curValue -= integerValue;
            m_powerFraction[power] = addvalue + integerValue;
        }
        else
        {
            curValue = 0;
            m_powerFraction[power] = 0;
            forcedUpdate = true;
        }
    }
    else
    {
        curValue += integerValue;

        if (curValue >= maxValue)
        {
            curValue = maxValue;
            m_powerFraction[power] = 0;
            forcedUpdate = true;
        }
        else
        {
            m_powerFraction[power] = addvalue - integerValue;
        }
    }

    if (m_regenTimerCount >= 2000 || forcedUpdate)
    {
        SetPower(power, curValue, true, true);
    }
    else
    {
        UpdateUInt32Value(static_cast<uint16>(UNIT_FIELD_POWER1) + power, curValue);
    }
}

void Player::RegenerateHealth()
{
    uint32 curValue = GetHealth();
    uint32 maxValue = GetMaxHealth();

    if (curValue >= maxValue)
        return;

    float HealthIncreaseRate = sWorld->getRate(RATE_HEALTH);

    if (sWorld->getBoolConfig(CONFIG_LOW_LEVEL_REGEN_BOOST) && GetLevel() < 15)
        HealthIncreaseRate = sWorld->getRate(RATE_HEALTH) * (2.066f - (GetLevel() * 0.066f));

    float addvalue = 0.0f;

    // polymorphed case
    if (IsPolymorphed())
        addvalue = (float)GetMaxHealth() / 3;
    // normal regen case (maybe partly in combat case)
    else if (!IsInCombat() || HasAuraType(SPELL_AURA_MOD_REGEN_DURING_COMBAT))
    {
        addvalue = OCTRegenHPPerSpirit() * HealthIncreaseRate;

        if (!IsStandState())
        {
            addvalue *= 1.33f;
        }

        AuraEffectList const& mModHealthRegenPct = GetAuraEffectsByType(SPELL_AURA_MOD_HEALTH_REGEN_PERCENT);
        for (AuraEffectList::const_iterator i = mModHealthRegenPct.begin(); i != mModHealthRegenPct.end(); ++i)
        {
            AddPct(addvalue, (*i)->GetAmount());
        }

        if (!IsInCombat())
        {
            addvalue += GetTotalAuraModifier(SPELL_AURA_MOD_REGEN) * 2 * IN_MILLISECONDS / (5 * IN_MILLISECONDS);
        }
        else if (HasAuraType(SPELL_AURA_MOD_REGEN_DURING_COMBAT))
        {
            ApplyPct(addvalue, GetTotalAuraModifier(SPELL_AURA_MOD_REGEN_DURING_COMBAT));
        }
    }

    // always regeneration bonus (including combat)
    addvalue += GetTotalAuraModifier(SPELL_AURA_MOD_HEALTH_REGEN_IN_COMBAT);
    addvalue += m_baseHealthRegen / 2.5f;

    if (addvalue < 0)
        addvalue = 0;

    ModifyHealth(int32(addvalue));
}

void Player::ResetAllPowers()
{
    SetHealth(GetMaxHealth());
    if (HasActivePowerType(POWER_MANA))
    {
        SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
    }
    if (HasActivePowerType(POWER_RAGE))
    {
        SetPower(POWER_RAGE, 0);
    }
    if (HasActivePowerType(POWER_ENERGY))
    {
        SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));
    }
    if (HasActivePowerType(POWER_RUNIC_POWER))
    {
        SetPower(POWER_RUNIC_POWER, 0);
    }
}

bool Player::CanInteractWithQuestGiver(Object* questGiver)
{
    switch (questGiver->GetTypeId())
    {
        case TYPEID_UNIT:
            return GetNPCIfCanInteractWith(questGiver->GetGUID(), UNIT_NPC_FLAG_QUESTGIVER) != nullptr;
        case TYPEID_GAMEOBJECT:
            return GetGameObjectIfCanInteractWith(questGiver->GetGUID(), GAMEOBJECT_TYPE_QUESTGIVER) != nullptr;
        case TYPEID_PLAYER:
            return IsAlive() && questGiver->ToPlayer()->IsAlive();
        case TYPEID_ITEM:
            return IsAlive();
        default:
            break;
    }
    return false;
}

Creature* Player::GetNPCIfCanInteractWith(ObjectGuid guid, uint32 npcflagmask)
{
    // unit checks
    if (!guid)
        return nullptr;

    if (!IsInWorld())
        return nullptr;

    if (IsInFlight())
        return nullptr;

    // exist (we need look pets also for some interaction (quest/etc)
    Creature* creature = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, guid);
    if (!creature)
        return nullptr;

    // Deathstate checks
    if (!IsAlive() && !(creature->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_VISIBLE_TO_GHOSTS))
        return nullptr;

    // alive or spirit healer
    if (!creature->IsAlive() && !(creature->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_INTERACT_WHILE_DEAD))
        return nullptr;

    // appropriate npc type
    if (npcflagmask && !creature->HasNpcFlag(NPCFlags(npcflagmask)))
        return nullptr;

    // not allow interaction under control, but allow with own pets
    if (creature->GetCharmerGUID())
        return nullptr;

    // xinef: perform better check
    if (creature->GetReactionTo(this) <= REP_UNFRIENDLY)
        return nullptr;

    // xinef: not needed, CORRECTLY checked above including forced reputations etc
    // not unfriendly
    //if (FactionTemplateEntry const* factionTemplate = sFactionTemplateStore.LookupEntry(creature->GetFaction()))
    //    if (factionTemplate->faction)
    //        if (FactionEntry const* faction = sFactionStore.LookupEntry(factionTemplate->faction))
    //            if (faction->reputationListID >= 0 && GetReputationMgr().GetRank(faction) <= REP_UNFRIENDLY)
    //                return nullptr;

    // not too far
    if (!creature->IsWithinDistInMap(this, INTERACTION_DISTANCE))
        return nullptr;

    // pussywizard: many npcs have missing conditions for class training and rogue trainer can for eg. train dual wield to a shaman :/ too many to change in sql and watch in the future
    // pussywizard: this function is not used when talking, but when already taking action (buy spell, reset talents, show spell list)
    if (npcflagmask & (UNIT_NPC_FLAG_TRAINER | UNIT_NPC_FLAG_TRAINER_CLASS) && creature->GetCreatureTemplate()->trainer_type == TRAINER_TYPE_CLASS && !IsClass((Classes)creature->GetCreatureTemplate()->trainer_class, CLASS_CONTEXT_CLASS_TRAINER))
        return nullptr;

    return creature;
}

GameObject* Player::GetGameObjectIfCanInteractWith(ObjectGuid guid, GameobjectTypes type) const
{
    if (GameObject* go = GetMap()->GetGameObject(guid))
    {
        if (go->GetGoType() == type)
        {
            // Players cannot interact with gameobjects that use the "Point" icon
            if (go->GetGOInfo()->IconName == "Point")
            {
                return nullptr;
            }

            if (go->IsWithinDistInMap(this))
            {
                return go;
            }

            LOG_DEBUG("maps", "IsGameObjectOfTypeInRange: GameObject '{}' [{}] is too far away from player {} [{}] to be used by him (distance={}, maximal 10 is allowed)",
                go->GetGOInfo()->name, go->GetGUID().ToString(), GetName(), GetGUID().ToString(), go->GetDistance(this));
        }
    }
    return nullptr;
}

bool Player::IsFalling() const
{
    // Xinef: Added !IsInFlight check
    return GetPositionZ() < m_lastFallZ && !IsInFlight();
}

void Player::SetInWater(bool apply)
{
    if (m_isInWater == apply)
        return;

    //define player in water by opcodes
    //move player's guid into HateOfflineList of those mobs
    //which can't swim and move guid back into ThreatList when
    //on surface.
    //TODO: exist also swimming mobs, and function must be symmetric to enter/leave water
    m_isInWater = apply;

    // remove auras that need water/land
    RemoveAurasWithInterruptFlags(apply ? AURA_INTERRUPT_FLAG_NOT_ABOVEWATER : AURA_INTERRUPT_FLAG_NOT_UNDERWATER);

    getHostileRefMgr().updateThreatTables();

    if (InstanceScript* instance = GetInstanceScript())
        instance->OnPlayerInWaterStateUpdate(this, apply);
}

bool Player::IsInAreaTriggerRadius(AreaTrigger const* trigger, float delta) const
{
    if (!trigger || GetMapId() != trigger->map)
        return false;

    if (trigger->radius > 0)
    {
        // if we have radius check it
        float dist = GetDistance(trigger->x, trigger->y, trigger->z);
        if (dist > trigger->radius + delta)
            return false;
    }
    else
    {
        Position center(trigger->x, trigger->y, trigger->z, trigger->orientation);
        if (!IsWithinBox(center, trigger->length / 2 + delta, trigger->width / 2 + delta, trigger->height / 2 + delta))
            return false;
    }

    return true;
}

void Player::SetGameMaster(bool on)
{
    if (on)
    {
        m_ExtraFlags |= PLAYER_EXTRA_GM_ON;
        if (GetSession()->IsGMAccount())
            SetFaction(FACTION_FRIENDLY);
        SetPlayerFlag(PLAYER_FLAGS_GM);
        SetUnitFlag2(UNIT_FLAG2_ALLOW_CHEAT_SPELLS);

        if (Pet* pet = GetPet())
        {
            if (GetSession()->IsGMAccount())
                pet->SetFaction(FACTION_FRIENDLY);
            pet->getHostileRefMgr().setOnlineOfflineState(false);
        }
        if (HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP))
        {
            RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
            sScriptMgr->OnFfaPvpStateUpdate(this, false);
        }
        ResetContestedPvP();

        getHostileRefMgr().setOnlineOfflineState(false);
        CombatStopWithPets();

        SetPhaseMask(uint32(PHASEMASK_ANYWHERE), false);    // see and visible in all phases
        m_serverSideVisibilityDetect.SetValue(SERVERSIDE_VISIBILITY_GM, GetSession()->GetSecurity());
    }
    else
    {
        // restore phase
        uint32 newPhase = GetPhaseByAuras();

        if (!newPhase)
            newPhase = PHASEMASK_NORMAL;

        SetPhaseMask(newPhase, false);

        m_ExtraFlags &= ~ PLAYER_EXTRA_GM_ON;
        SetFactionForRace(getRace(true));
        RemovePlayerFlag(PLAYER_FLAGS_GM);
        RemoveUnitFlag2(UNIT_FLAG2_ALLOW_CHEAT_SPELLS);

        if (Pet* pet = GetPet())
        {
            pet->SetFaction(GetFaction());
            pet->getHostileRefMgr().setOnlineOfflineState(true);
        }

        // restore FFA PvP Server state
        if (sWorld->IsFFAPvPRealm())
        {
            if (!HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP))
            {
                SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
                sScriptMgr->OnFfaPvpStateUpdate(this, true);
            }
        }
        // restore FFA PvP area state, remove not allowed for GM mounts
        UpdateArea(m_areaUpdateId);

        getHostileRefMgr().setOnlineOfflineState(true);
        m_serverSideVisibilityDetect.SetValue(SERVERSIDE_VISIBILITY_GM, SEC_PLAYER);
    }

    UpdateObjectVisibility();
}

void Player::SetGMVisible(bool on)
{
    const uint32 VISUAL_AURA = 37800;

    if (on)
    {
        RemoveAurasDueToSpell(VISUAL_AURA);
        m_ExtraFlags &= ~PLAYER_EXTRA_GM_INVISIBLE;
        m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GM, SEC_PLAYER);

        getHostileRefMgr().setOnlineOfflineState(false);
        CombatStopWithPets();
    }
    else
    {
        AddAura(VISUAL_AURA, this);
        m_ExtraFlags |= PLAYER_EXTRA_GM_INVISIBLE;
        m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GM, GetSession()->GetSecurity());
    }
}

bool Player::IsGroupVisibleFor(Player const* p) const
{
    switch (sWorld->getIntConfig(CONFIG_GROUP_VISIBILITY))
    {
        default:
            return IsInSameGroupWith(p);
        case 1:
            return IsInSameRaidWith(p);
        case 2:
            return GetTeamId() == p->GetTeamId();
    }
}

bool Player::IsInSameGroupWith(Player const* p) const
{
    return p == this || (GetGroup() &&
                         GetGroup() == p->GetGroup() &&
                         GetGroup()->SameSubGroup(this, p));
}

///- If the player is invited, remove him. If the group if then only 1 person, disband the group.
void Player::UninviteFromGroup()
{
    Group* group = GetGroupInvite();
    if (!group)
        return;

    group->RemoveInvite(this);

    if (group->IsCreated())
    {
        if (group->GetMembersCount() <= 1)                       // group has just 1 member => disband
        {
            group->Disband(true);
            group = nullptr; // gets deleted in disband
        }
    }
    else
    {
        if (group->GetInviteeCount() <= 1)
        {
            group->RemoveAllInvites();
            delete group;
            group = nullptr;
        }
    }
}

void Player::RemoveFromGroup(Group* group, ObjectGuid guid, RemoveMethod method /* = GROUP_REMOVEMETHOD_DEFAULT*/, ObjectGuid kicker /* = ObjectGuid::Empty */, const char* reason /* = nullptr */)
{
    if (group)
    {
        group->RemoveMember(guid, method, kicker, reason);
        group = nullptr;
    }
}

void Player::SendLogXPGain(uint32 GivenXP, Unit* victim, uint32 BonusXP, bool recruitAFriend, float /*group_rate*/)
{
    WorldPacket data(SMSG_LOG_XPGAIN, 22); // guess size?
    data << (victim ? victim->GetGUID() : ObjectGuid::Empty);   // guid
    data << uint32(GivenXP + BonusXP);                          // given experience
    data << uint8(victim ? 0 : 1);                              // 00-kill_xp type, 01-non_kill_xp type

    if (victim)
    {
        data << uint32(GivenXP);                            // experience without bonus

        // should use group_rate here but can't figure out how
        data << float(1);                                   // 1 - none 0 - 100% group bonus output
    }

    data << uint8(recruitAFriend ? 1 : 0);                  // does the GivenXP include a RaF bonus?
    GetSession()->SendPacket(&data);
}

void Player::GiveXP(uint32 xp, Unit* victim, float group_rate, bool isLFGReward)
{
    if (xp < 1)
    {
        return;
    }

    if (!IsAlive() && !GetBattlegroundId() && !isLFGReward)
    {
        return;
    }

    if (HasPlayerFlag(PLAYER_FLAGS_NO_XP_GAIN))
    {
        return;
    }

    if (victim && victim->IsCreature() && !victim->ToCreature()->hasLootRecipient())
    {
        return;
    }

    uint8 level = GetLevel();

    // Favored experience increase START
    uint32 zone = GetZoneId();
    float favored_exp_mult = 0;
    if ((zone == 3483 || zone == 3562 || zone == 3836 || zone == 3713 || zone == 3714) && (HasAura(32096) || HasAura(32098)))
        favored_exp_mult = 0.05f; // Thrallmar's Favor and Honor Hold's Favor

    xp = uint32(xp * (1 + favored_exp_mult));
    // Favored experience increase END

    // XP to money conversion processed in Player::RewardQuest
    if (level >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        return;

    uint32 bonus_xp = 0;
    bool recruitAFriend = GetsRecruitAFriendBonus(true);

    // RaF does NOT stack with rested experience
    if (recruitAFriend)
        bonus_xp = 2 * xp; // xp + bonus_xp must add up to 3 * xp for RaF; calculation for quests done client-side
    else
        bonus_xp = victim ? GetXPRestBonus(xp) : 0; // XP resting bonus

    // hooks and multipliers can modify the xp with a zero or negative value
    // check again before sending invalid xp to the client
    if (xp < 1)
    {
        return;
    }

    SendLogXPGain(xp, victim, bonus_xp, recruitAFriend, group_rate);

    uint32 curXP = GetUInt32Value(PLAYER_XP);
    uint32 nextLvlXP = GetUInt32Value(PLAYER_NEXT_LEVEL_XP);
    uint32 newXP = curXP + xp + bonus_xp;

    while (newXP >= nextLvlXP && level < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
    {
        newXP -= nextLvlXP;

        if (level < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            GiveLevel(level + 1);

        level = GetLevel();
        nextLvlXP = GetUInt32Value(PLAYER_NEXT_LEVEL_XP);
    }

    SetUInt32Value(PLAYER_XP, newXP);
}

// Update player to next level
// Current player experience not update (must be update by caller)
void Player::GiveLevel(uint8 level)
{
    uint8 oldLevel = GetLevel();
    if (level == oldLevel)
        return;

    if (Guild* guild = GetGuild())
        guild->UpdateMemberData(this, GUILD_MEMBER_DATA_LEVEL, level);

    PlayerLevelInfo info;
    sObjectMgr->GetPlayerLevelInfo(getRace(true), getClass(), level, &info);

    PlayerClassLevelInfo classInfo;
    sObjectMgr->GetPlayerClassLevelInfo(getClass(), level, &classInfo);

    WorldPackets::Misc::LevelUpInfo packet;
    packet.Level = level;
    packet.HealthDelta = int32(classInfo.basehealth) - int32(GetCreateHealth());

    /// @todo find some better solution
    // for (int i = 0; i < MAX_POWERS; ++i)
    packet.PowerDelta[0] = int32(classInfo.basemana) - int32(GetCreateMana());
    packet.PowerDelta[1] = 0;
    packet.PowerDelta[2] = 0;
    packet.PowerDelta[3] = 0;
    packet.PowerDelta[4] = 0;
    packet.PowerDelta[5] = 0;

    for (uint8 i = STAT_STRENGTH; i < MAX_STATS; ++i)
        packet.StatDelta[i] = int32(info.stats[i]) - GetCreateStat(Stats(i));

    SendDirectMessage(packet.Write());

    SetUInt32Value(PLAYER_NEXT_LEVEL_XP, sObjectMgr->GetXPForLevel(level));

    //update level, max level of skills
    m_Played_time[PLAYED_TIME_LEVEL] = 0;                   // Level Played Time reset

    _ApplyAllLevelScaleItemMods(false);

    SetLevel(level);

    UpdateSkillsForLevel();

    // save base values (bonuses already included in stored stats
    for (uint8 i = STAT_STRENGTH; i < MAX_STATS; ++i)
        SetCreateStat(Stats(i), info.stats[i]);

    SetCreateHealth(classInfo.basehealth);
    SetCreateMana(classInfo.basemana);

    InitTalentForLevel();
    InitTaxiNodesForLevel();
    InitGlyphsForLevel();

    UpdateAllStats();

    if (sWorld->getBoolConfig(CONFIG_ALWAYS_MAXSKILL)) // Max weapon skill when leveling up
        UpdateSkillsToMaxSkillsForLevel();

    _ApplyAllLevelScaleItemMods(true);

    // set current level health and mana/energy to maximum after applying all mods.
    SetFullHealth();
    SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
    SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));
    if (GetPower(POWER_RAGE) > GetMaxPower(POWER_RAGE))
        SetPower(POWER_RAGE, GetMaxPower(POWER_RAGE));
    SetPower(POWER_FOCUS, 0);
    SetPower(POWER_HAPPINESS, 0);

    // update level to hunter/summon pet
    if (Pet* pet = GetPet())
        pet->SynchronizeLevelWithOwner();

    MailLevelReward const* mailReward = sObjectMgr->GetMailLevelReward(level, getRaceMask());
    if (mailReward && sScriptMgr->CanGiveMailRewardAtGiveLevel(this, level))
    {
        //- TODO: Poor design of mail system
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        MailDraft(mailReward->mailTemplateId).SendMailTo(trans, this, MailSender(MAIL_CREATURE, mailReward->senderEntry));
        CharacterDatabase.CommitTransaction(trans);
    }

    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_REACH_LEVEL);

    // Refer-A-Friend
    if (GetSession()->GetRecruiterId())
        if (level < sWorld->getIntConfig(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL))
            if (level % 2 == 0)
            {
                ++m_grantableLevels;

                if (!HasByteFlag(PLAYER_FIELD_BYTES, 1, 0x01))
                    SetByteFlag(PLAYER_FIELD_BYTES, 1, 0x01);
            }

    SendQuestGiverStatusMultiple();

    sScriptMgr->OnPlayerLevelChanged(this, oldLevel);
}

bool Player::IsMaxLevel() const
{
    return GetLevel() >= GetUInt32Value(PLAYER_FIELD_MAX_LEVEL);
}

void Player::InitTalentForLevel()
{
    uint32 talentPointsForLevel = CalculateTalentsPoints();

    // xinef: more talent points that we have are used, reset
    if (m_usedTalentCount > talentPointsForLevel)
        resetTalents(true);
    // xinef: else, recalculate free talent points count
    else
        SetFreeTalentPoints(talentPointsForLevel - m_usedTalentCount);

    if (!GetSession()->PlayerLoading())
        SendTalentsInfoData(false);                         // update at client
}

void Player::InitStatsForLevel(bool reapplyMods)
{
    if (reapplyMods)                                        //reapply stats values only on .reset stats (level) command
        _RemoveAllStatBonuses();

    PlayerClassLevelInfo classInfo;
    sObjectMgr->GetPlayerClassLevelInfo(getClass(), GetLevel(), &classInfo);

    PlayerLevelInfo info;
    sObjectMgr->GetPlayerLevelInfo(getRace(true), getClass(), GetLevel(), &info);

    uint32 maxPlayerLevel = sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL);
    sScriptMgr->OnSetMaxLevel(this, maxPlayerLevel);
    SetUInt32Value(PLAYER_FIELD_MAX_LEVEL, maxPlayerLevel);
    SetUInt32Value(PLAYER_NEXT_LEVEL_XP, sObjectMgr->GetXPForLevel(GetLevel()));

    // reset before any aura state sources (health set/aura apply)
    SetUInt32Value(UNIT_FIELD_AURASTATE, 0);

    UpdateSkillsForLevel();

    // set default cast time multiplier
    SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);

    // reset size before reapply auras
    SetObjectScale(1.0f);

    // save base values (bonuses already included in stored stats
    for (uint8 i = STAT_STRENGTH; i < MAX_STATS; ++i)
        SetCreateStat(Stats(i), info.stats[i]);

    for (uint8 i = STAT_STRENGTH; i < MAX_STATS; ++i)
        SetStat(Stats(i), info.stats[i]);

    SetCreateHealth(classInfo.basehealth);

    //set create powers
    SetCreateMana(classInfo.basemana);

    SetArmor(int32(m_createStats[STAT_AGILITY] * 2));

    InitStatBuffMods();

    //reset rating fields values
    for (uint16 index = PLAYER_FIELD_COMBAT_RATING_1; index < PLAYER_FIELD_COMBAT_RATING_1 + MAX_COMBAT_RATING; ++index)
        SetUInt32Value(index, 0);

    SetUInt32Value(PLAYER_FIELD_MOD_HEALING_DONE_POS, 0);
    for (uint8 i = 0; i < 7; ++i)
    {
        SetInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + i, 0);
        SetInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + i, 0);
        SetFloatValue(PLAYER_FIELD_MOD_DAMAGE_DONE_PCT + i, 1.00f);
    }

    //reset attack power, damage and attack speed fields
    SetFloatValue(UNIT_FIELD_BASEATTACKTIME, 2000.0f);
    SetFloatValue(UNIT_FIELD_BASEATTACKTIME + 1, 2000.0f); // offhand attack time
    SetFloatValue(UNIT_FIELD_RANGEDATTACKTIME, 2000.0f);

    SetFloatValue(UNIT_FIELD_MINDAMAGE, 0.0f);
    SetFloatValue(UNIT_FIELD_MAXDAMAGE, 0.0f);
    SetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE, 0.0f);
    SetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE, 0.0f);
    SetFloatValue(UNIT_FIELD_MINRANGEDDAMAGE, 0.0f);
    SetFloatValue(UNIT_FIELD_MAXRANGEDDAMAGE, 0.0f);

    SetInt32Value(UNIT_FIELD_ATTACK_POWER,            0);
    SetInt32Value(UNIT_FIELD_ATTACK_POWER_MODS,       0);
    SetFloatValue(UNIT_FIELD_ATTACK_POWER_MULTIPLIER, 0.0f);
    SetInt32Value(UNIT_FIELD_RANGED_ATTACK_POWER,     0);
    SetInt32Value(UNIT_FIELD_RANGED_ATTACK_POWER_MODS, 0);
    SetFloatValue(UNIT_FIELD_RANGED_ATTACK_POWER_MULTIPLIER, 0.0f);

    // Base crit values (will be recalculated in UpdateAllStats() at loading and in _ApplyAllStatBonuses() at reset
    SetFloatValue(PLAYER_CRIT_PERCENTAGE, 0.0f);
    SetFloatValue(PLAYER_OFFHAND_CRIT_PERCENTAGE, 0.0f);
    SetFloatValue(PLAYER_RANGED_CRIT_PERCENTAGE, 0.0f);

    // Init spell schools (will be recalculated in UpdateAllStats() at loading and in _ApplyAllStatBonuses() at reset
    for (uint8 i = 0; i < 7; ++i)
        SetFloatValue(PLAYER_SPELL_CRIT_PERCENTAGE1 + i, 0.0f);

    SetFloatValue(PLAYER_PARRY_PERCENTAGE, 0.0f);
    SetFloatValue(PLAYER_BLOCK_PERCENTAGE, 0.0f);
    SetUInt32Value(PLAYER_SHIELD_BLOCK, 0);

    // Dodge percentage
    SetFloatValue(PLAYER_DODGE_PERCENTAGE, 0.0f);

    // set armor (resistance 0) to original value (create_agility*2)
    SetArmor(int32(m_createStats[STAT_AGILITY] * 2));
    SetResistanceBuffMods(SpellSchools(0), true, 0.0f);
    SetResistanceBuffMods(SpellSchools(0), false, 0.0f);
    // set other resistance to original value (0)
    for (uint8 i = 1; i < MAX_SPELL_SCHOOL; ++i)
    {
        SetResistance(SpellSchools(i), 0);
        SetResistanceBuffMods(SpellSchools(i), true, 0.0f);
        SetResistanceBuffMods(SpellSchools(i), false, 0.0f);
    }

    SetUInt32Value(PLAYER_FIELD_MOD_TARGET_RESISTANCE, 0);
    SetUInt32Value(PLAYER_FIELD_MOD_TARGET_PHYSICAL_RESISTANCE, 0);
    for (uint8 i = 0; i < MAX_SPELL_SCHOOL; ++i)
    {
        SetUInt32Value(UNIT_FIELD_POWER_COST_MODIFIER + i, 0);
        SetFloatValue(UNIT_FIELD_POWER_COST_MULTIPLIER + i, 0.0f);
    }
    // Reset no reagent cost field
    for (uint8 i = 0; i < 3; ++i)
        SetUInt32Value(PLAYER_NO_REAGENT_COST_1 + i, 0);
    // Init data for form but skip reapply item mods for form
    InitDataForForm(reapplyMods);

    // save new stats
    for (uint8 i = POWER_MANA; i < MAX_POWERS; ++i)
        SetMaxPower(Powers(i),  uint32(GetCreatePowers(Powers(i))));

    SetMaxHealth(classInfo.basehealth);                     // stamina bonus will applied later

    // cleanup mounted state (it will set correctly at aura loading if player saved at mount.
    SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);

    // cleanup unit flags (will be re-applied if need at aura load).
    RemoveFlag(UNIT_FIELD_FLAGS,
               UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE  | UNIT_FLAG_NOT_ATTACKABLE_1 |
               UNIT_FLAG_LOOTING        | UNIT_FLAG_PET_IN_COMBAT | UNIT_FLAG_SILENCED         |
               UNIT_FLAG_PACIFIED       | UNIT_FLAG_STUNNED       | UNIT_FLAG_IN_COMBAT        |
               UNIT_FLAG_DISARMED       | UNIT_FLAG_CONFUSED      | UNIT_FLAG_FLEEING          |
               UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_SKINNABLE     | UNIT_FLAG_MOUNT            |
               UNIT_FLAG_TAXI_FLIGHT);
    SetImmuneToAll(false);
    SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);   // must be set

    SetUnitFlag2(UNIT_FLAG2_REGENERATE_POWER);// must be set

    // cleanup player flags (will be re-applied if need at aura load), to avoid have ghost flag without ghost aura, for example.
    RemovePlayerFlag(PLAYER_FLAGS_AFK | PLAYER_FLAGS_DND | PLAYER_FLAGS_GM | PLAYER_FLAGS_GHOST | PLAYER_ALLOW_ONLY_ABILITY);

    RemoveStandFlags(UNIT_STAND_FLAGS_ALL);                 // one form stealth modified bytes
    if (HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP))
    {
        RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP | UNIT_BYTE2_FLAG_SANCTUARY);
        sScriptMgr->OnFfaPvpStateUpdate(this, false);

    }
    // restore if need some important flags
    SetUInt32Value(PLAYER_FIELD_BYTES2, 0);                 // flags empty by default

    if (reapplyMods)                                        // reapply stats values only on .reset stats (level) command
        _ApplyAllStatBonuses();

    // set current level health and mana/energy to maximum after applying all mods.
    SetFullHealth();
    SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
    SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));
    if (GetPower(POWER_RAGE) > GetMaxPower(POWER_RAGE))
        SetPower(POWER_RAGE, GetMaxPower(POWER_RAGE));
    SetPower(POWER_FOCUS, 0);
    SetPower(POWER_HAPPINESS, 0);
    SetPower(POWER_RUNIC_POWER, 0);

    // update level to hunter/summon pet
    if (Pet* pet = GetPet())
        pet->SynchronizeLevelWithOwner();
}

bool Player::HasActivePowerType(Powers power)
{
    if (sScriptMgr->OnPlayerHasActivePowerType(this, power))
        return true;
    else
        return (getPowerType() == power);
}

void Player::SendInitialSpells()
{
    uint32 curTime = GameTime::GetGameTimeMS().count();
    uint32 infTime = GameTime::GetGameTimeMS().count() + infinityCooldownDelayCheck;

    uint16 spellCount = 0;

    WorldPacket data(SMSG_INITIAL_SPELLS, (1 + 2 + 4 * m_spells.size() + 2 + m_spellCooldowns.size() * (4 + 2 + 2 + 4 + 4)));
    data << uint8(0);

    std::size_t countPos = data.wpos();
    data << uint16(spellCount);                             // spell count placeholder

    for (PlayerSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
    {
        if (itr->second->State == PLAYERSPELL_REMOVED)
            continue;

        if (!itr->second->Active || !itr->second->IsInSpec(GetActiveSpec()))
            continue;

        data << uint32(itr->first);
        data << uint16(0);                                  // it's not slot id

        ++spellCount;
    }

    // Added spells from glyphs too (needed by spell tooltips)
    for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
    {
        if (uint32 glyph = GetGlyph(i))
        {
            if (GlyphPropertiesEntry const* glyphEntry = sGlyphPropertiesStore.LookupEntry(glyph))
            {
                data << uint32(glyphEntry->SpellId);
                data << uint16(0); // it's not slot id

                ++spellCount;
            }
        }
    }

    // xinef: we have to send talents, but not those on m_spells list
    for (PlayerTalentMap::iterator itr = m_talents.begin(); itr != m_talents.end(); ++itr)
    {
        if (itr->second->State == PLAYERSPELL_REMOVED)
            continue;

        // xinef: remove all active talent auras
        if (!(itr->second->specMask & GetActiveSpecMask()))
            continue;

        // xinef: already sent from m_spells
        if (itr->second->inSpellBook)
            continue;

        data << uint32(itr->first);
        data << uint16(0);                                  // it's not slot id

        ++spellCount;
    }

    data.put<uint16>(countPos, spellCount);                  // write real count value

    uint16 spellCooldowns = m_spellCooldowns.size();
    data << uint16(spellCooldowns);
    for (SpellCooldowns::const_iterator itr = m_spellCooldowns.begin(); itr != m_spellCooldowns.end(); ++itr)
    {
        if (!itr->second.needSendToClient)
            continue;

        SpellInfo const* sEntry = sSpellMgr->GetSpellInfo(itr->first);
        if (!sEntry)
            continue;

        data << uint32(itr->first);

        data << uint16(itr->second.itemid);                 // cast item id
        data << uint16(itr->second.category);               // spell category

        // send infinity cooldown in special format
        if (itr->second.end >= infTime)
        {
            data << uint32(1);                              // cooldown
            data << uint32(0x80000000);                     // category cooldown
            continue;
        }

        uint32 cooldown = itr->second.end > curTime ? itr->second.end - curTime : 0;
        data << uint32(itr->second.category ? 0 : cooldown);    // cooldown
        data << uint32(itr->second.category ? cooldown : 0);    // category cooldown
    }

    GetSession()->SendPacket(&data);
}

void Player::RemoveMail(uint32 id)
{
    for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
    {
        if ((*itr)->messageID == id)
        {
            //do not delete item, because Player::removeMail() is called when returning mail to sender.
            m_mail.erase(itr);
            return;
        }
    }
}

void Player::SendMailResult(uint32 mailId, MailResponseType mailAction, MailResponseResult mailError, uint32 equipError, ObjectGuid::LowType item_guid, uint32 item_count)
{
    WorldPacket data(SMSG_SEND_MAIL_RESULT, (4 + 4 + 4 + (mailError == MAIL_ERR_EQUIP_ERROR ? 4 : (mailAction == MAIL_ITEM_TAKEN ? 4 + 4 : 0))));
    data << (uint32) mailId;
    data << (uint32) mailAction;
    data << (uint32) mailError;
    if (mailError == MAIL_ERR_EQUIP_ERROR)
        data << (uint32) equipError;
    else if (mailAction == MAIL_ITEM_TAKEN)
    {
        data << (uint32) item_guid;                         // item guid low?
        data << (uint32) item_count;                        // item count?
    }
    GetSession()->SendPacket(&data);
}

void Player::SendNewMail()
{
    // deliver undelivered mail
    WorldPacket data(SMSG_RECEIVED_MAIL, 4);
    data << (uint32) 0;
    GetSession()->SendPacket(&data);
}

void Player::AddNewMailDeliverTime(time_t deliver_time)
{
    if (deliver_time <= GameTime::GetGameTime().count())                      // ready now
    {
        ++unReadMails;
        SendNewMail();
    }
    else                                                    // not ready and no have ready mails
    {
        if (!m_nextMailDelivereTime || m_nextMailDelivereTime > deliver_time)
            m_nextMailDelivereTime = deliver_time;
    }
}

bool Player::addTalent(uint32 spellId, uint8 addSpecMask, uint8 oldTalentRank)
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!SpellMgr::CheckSpellValid(spellInfo, spellId, true))
        return false;

    TalentSpellPos const* talentPos = GetTalentSpellPos(spellId);
    if (!talentPos)
        return false;

    TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentPos->talent_id);
    if (!talentInfo)
        return false;

    // xinef: remove old talent rank if any
    if (oldTalentRank)
    {
        _removeTalent(talentInfo->RankID[oldTalentRank - 1], addSpecMask);
        _removeTalentAurasAndSpells(talentInfo->RankID[oldTalentRank - 1]);
        SendLearnPacket(talentInfo->RankID[oldTalentRank - 1], false);
    }

    // xinef: add talent auras and spells
    if (GetActiveSpecMask() & addSpecMask)
        _addTalentAurasAndSpells(spellId);

    // xinef: find the spell on our talent map
    PlayerTalentMap::iterator itr = m_talents.find(spellId);

    // xinef: we do not have such a spell on our talent map
    if (itr == m_talents.end())
    {
        PlayerSpellState state = isBeingLoaded() ? PLAYERSPELL_UNCHANGED : PLAYERSPELL_NEW;
        PlayerTalent* newTalent = new PlayerTalent();
        newTalent->State = state;
        newTalent->specMask = addSpecMask;
        newTalent->talentID = talentInfo->TalentID;
        newTalent->inSpellBook = talentInfo->addToSpellBook && !spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL);

        m_talents[spellId] = newTalent;
        return true;
    }
    // xinef: if current mask does not cover addMask, add it to iterator and save changes to DB
    else if (!(itr->second->specMask & addSpecMask))
    {
        itr->second->specMask |= addSpecMask;
        if (itr->second->State != PLAYERSPELL_NEW)
            itr->second->State = PLAYERSPELL_CHANGED;

        return true;
    }

    return false;
}

void Player::_removeTalent(uint32 spellId, uint8 specMask)
{
    PlayerTalentMap::iterator itr = m_talents.find(spellId);
    if (itr == m_talents.end() || itr->second->State == PLAYERSPELL_REMOVED)
        return;

    _removeTalent(itr, specMask);
}

void Player::_removeTalent(PlayerTalentMap::iterator& itr, uint8 specMask)
{
    // xinef: remove spec mask from iterator
    itr->second->specMask &= ~specMask;

    // xinef: if talent is not present in any spec - remove
    if (itr->second->specMask == 0)
    {
        if (itr->second->State == PLAYERSPELL_NEW)
        {
            delete itr->second;
            m_talents.erase(itr);
            return;
        }
        else
            itr->second->State = PLAYERSPELL_REMOVED;
    }
    // xinef: otherwise save changes to DB
    else if (itr->second->State != PLAYERSPELL_NEW)
        itr->second->State = PLAYERSPELL_CHANGED;
}

void Player::_removeTalentAurasAndSpells(uint32 spellId)
{
    RemoveOwnedAura(spellId);

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        // pussywizard: remove pet auras
        if (PetAura const* petSpell = sSpellMgr->GetPetAura(spellId, i))
            RemovePetAura(petSpell);

        // pussywizard: remove all triggered auras
        if (spellInfo->Effects[i].TriggerSpell > 0)
            RemoveAurasDueToSpell(spellInfo->Effects[i].TriggerSpell);

        // xinef: remove temporary spells added by talent
        // xinef: recursively remove all learnt spells
        if (spellInfo->Effects[i].TriggerSpell > 0 && spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL)
        {
            removeSpell(spellInfo->Effects[i].TriggerSpell, SPEC_MASK_ALL, true);
            _removeTalentAurasAndSpells(spellInfo->Effects[i].TriggerSpell);
        }
    }
}

void Player::_addTalentAurasAndSpells(uint32 spellId)
{
    // pussywizard: spells learnt from talents are added as TEMPORARY, so not saved to db (only the talent itself is saved)
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
    {
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL && !sSpellMgr->IsAdditionalTalentSpell(spellInfo->Effects[i].TriggerSpell))
                _addSpell(spellInfo->Effects[i].TriggerSpell, SPEC_MASK_ALL, true);
    }
    else if (spellInfo->IsPassive() || (spellInfo->HasAttribute(SPELL_ATTR0_DO_NOT_DISPLAY) && spellInfo->Stances))
    {
        if (IsNeedCastPassiveSpellAtLearn(spellInfo))
            CastSpell(this, spellId, true);
    }
}

void Player::SendLearnPacket(uint32 spellId, bool learn)
{
    if (learn)
    {
        WorldPacket data(SMSG_LEARNED_SPELL, 6);
        data << uint32(spellId);
        data << uint16(0);
        GetSession()->SendPacket(&data);
    }
    else
    {
        WorldPacket data(SMSG_REMOVED_SPELL, 4);
        data << uint32(spellId);
        GetSession()->SendPacket(&data);
    }
}

bool Player::addSpell(uint32 spellId, uint8 addSpecMask, bool updateActive, bool temporary /*= false*/, bool learnFromSkill /*= false*/)
{
    if (!_addSpell(spellId, addSpecMask, temporary, learnFromSkill))
        return false;

    if (!updateActive)
        return true;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId); // must exist, checked in _addSpell

    // pussywizard: now update active state for all ranks of this spell! and send packet to swap on action bar
    // pussywizard: assumption - it's in all specs, can't be a talent
    if (!spellInfo->IsStackableWithRanks() && spellInfo->IsRanked())
    {
        SpellInfo const* nextSpellInfo = sSpellMgr->GetSpellInfo(sSpellMgr->GetFirstSpellInChain(spellInfo->Id));
        while (nextSpellInfo)
        {
            PlayerSpellMap::iterator itr = m_spells.find(nextSpellInfo->Id);
            if (itr != m_spells.end() && itr->second->State != PLAYERSPELL_REMOVED && itr->second->Active)
            {
                if (nextSpellInfo->GetRank() < spellInfo->GetRank())
                {
                    itr->second->Active = false;
                    if (IsInWorld())
                    {
                        WorldPacket data(SMSG_SUPERCEDED_SPELL, 4 + 4);
                        data << uint32(nextSpellInfo->Id);
                        data << uint32(spellInfo->Id);
                        GetSession()->SendPacket(&data);
                    }
                    return false;
                }
                else if (nextSpellInfo->GetRank() > spellInfo->GetRank())
                {
                    PlayerSpellMap::iterator itr2 = m_spells.find(spellInfo->Id);
                    if (itr2 != m_spells.end())
                        itr2->second->Active = false;
                    return false;
                }
            }
            nextSpellInfo = nextSpellInfo->GetNextRankSpell();
        }
    }

    return true;
}

bool Player::_addSpell(uint32 spellId, uint8 addSpecMask, bool temporary, bool learnFromSkill /*= false*/)
{
    // pussywizard: this can be called to OVERWRITE currently existing spell params! usually to set active = false for lower ranks of a spell

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!SpellMgr::CheckSpellValid(spellInfo, spellId, false))
        return false;

    // pussywizard: already found and temporary, nothing to do
    PlayerSpellMap::iterator itr = m_spells.find(spellId);
    if (itr != m_spells.end() && itr->second->State == PLAYERSPELL_TEMPORARY)
        return false;

    // xinef: send packet so client can properly recognize this new spell
    // xinef: ignore passive spells and spells with learn effect
    // xinef: send spells with no aura effects (ie dual wield)
    if (IsInWorld() && !isBeingLoaded() && temporary && !learnFromSkill && (!spellInfo->HasAttribute(SpellAttr0(SPELL_ATTR0_PASSIVE | SPELL_ATTR0_DO_NOT_DISPLAY)) || !spellInfo->HasAnyAura()) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
        SendLearnPacket(spellInfo->Id, true);

    // xinef: DO NOT allow to learn spell with effect learn spell!
    // xinef: if spell possess spell learn effects only, learn those spells as temporary (eg. Metamorphosis, Tree of Life)
    if (temporary && spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
    {
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            if (spellInfo->Effects[i].IsEffect())
            {
                if (spellInfo->Effects[i].Effect != SPELL_EFFECT_LEARN_SPELL)
                {
                    LOG_INFO("entities.player", "TRYING TO LEARN SPELL WITH EFFECT LEARN: {}, PLAYER: {}", spellId, GetGUID().ToString());
                    return false;
                    //ABORT();
                }
                else if (SpellInfo const* learnSpell = sSpellMgr->GetSpellInfo(spellInfo->Effects[i].TriggerSpell))
                    _addSpell(learnSpell->Id, SPEC_MASK_ALL, true);
            }

        return false;
    }

    if (itr != m_spells.end()) // pussywizard: already know this spell, so update information
    {
        // pussywizard: do nothing if already set as wanted
        if (itr->second->State != PLAYERSPELL_REMOVED && (itr->second->specMask & addSpecMask) == addSpecMask)
            return false;

        // pussywizard: need cast auras, learn linked spells, do professions stuff, etc.
        // pussywizard: but only for spells that are really added (inactive -> active OR added to current spec)
        bool spellIsNew = true;

        // pussywizard: present in m_spells, not removed, already in current spec, already active
        if (itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(m_activeSpec))
            spellIsNew = false;

        // pussywizard: update info in m_spells
        if (itr->second->State != PLAYERSPELL_NEW && (itr->second->specMask & addSpecMask) != addSpecMask)
            itr->second->State = PLAYERSPELL_CHANGED;
        itr->second->Active = true;
        itr->second->specMask |= addSpecMask;

        if (!spellIsNew)
            return true;
    }
    else // pussywizard: not found in m_spells
    {
        PlayerSpell* newspell = new PlayerSpell;
        newspell->Active = true;
        newspell->State = temporary ? PLAYERSPELL_TEMPORARY : (isBeingLoaded() ? PLAYERSPELL_UNCHANGED : PLAYERSPELL_NEW);
        newspell->specMask = addSpecMask;

        m_spells[spellId] = newspell;
    }

    // pussywizard: return if spell not in current spec
    // pussywizard: return true to fix active for ranks, this condition is true only at loading, so no problems with learning packets
    if (!((1 << GetActiveSpec()) & addSpecMask))
        return true;

    // xinef: do not add spells with effect learn spell
    if (spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
    {
        LOG_INFO("entities.player", "TRYING TO LEARN SPELL WITH EFFECT LEARN 2: {}, PLAYER: {}", spellId, GetGUID().ToString());
        m_spells.erase(spellInfo->Id); // mem leak, but should never happen
        return false;
        //ABORT();
    }
    // pussywizard: cast passive spells (including all talents without SPELL_EFFECT_LEARN_SPELL) with additional checks
    else if (spellInfo->IsPassive() || (spellInfo->HasAttribute(SPELL_ATTR0_DO_NOT_DISPLAY) && spellInfo->Stances))
    {
        if (IsNeedCastPassiveSpellAtLearn(spellInfo))
            CastSpell(this, spellId, true);
    }
    // pussywizard: cast and return, learnt spells will update profession count, etc.
    else if (spellInfo->HasEffect(SPELL_EFFECT_SKILL_STEP))
    {
        CastSpell(this, spellId, true);
        return false;
    }

    // xinef: unapply aura stats if dont meet requirements
    // xinef: handle only if player is not loaded, loading is handled in loadfromdb
    if (!isBeingLoaded())
        if (Aura* aura = GetAura(spellId))
        {
            if (aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTHLESS_35_PERCENT ||
                    aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTH_ABOVE_75_PERCENT ||
                    aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTHLESS_20_PERCENT )
                if (!HasAuraState((AuraStateType)aura->GetSpellInfo()->CasterAuraState))
                    aura->HandleAllEffects(aura->GetApplicationOfTarget(GetGUID()), AURA_EFFECT_HANDLE_REAL, false);
        }

    // pussywizard: update free primary prof points
    if (uint32 freeProfs = GetFreePrimaryProfessionPoints())
    {
        if (spellInfo->IsPrimaryProfessionFirstRank())
            SetFreePrimaryProfessions(freeProfs - 1);
    }

    uint16 maxskill = GetMaxSkillValueForLevel();
    SpellLearnSkillNode const* spellLearnSkill = sSpellMgr->GetSpellLearnSkill(spellId);
    SkillLineAbilityMapBounds skill_bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spellId);
    // xinef: set appropriate skill value
    if (spellLearnSkill)
    {
        uint32 skill_value = GetPureSkillValue(spellLearnSkill->skill);
        uint32 skill_max_value = GetPureMaxSkillValue(spellLearnSkill->skill);
        uint32 new_skill_max_value = spellLearnSkill->maxvalue == 0 ? maxskill : spellLearnSkill->maxvalue;

        if (skill_value < spellLearnSkill->value)
            skill_value = spellLearnSkill->value;
        if (skill_max_value < new_skill_max_value)
            skill_max_value = new_skill_max_value;

        SetSkill(spellLearnSkill->skill, spellLearnSkill->step, skill_value, skill_max_value);
    }
    else
    {
        // not ranked skills
        for (SkillLineAbilityMap::const_iterator _spell_idx = skill_bounds.first; _spell_idx != skill_bounds.second; ++_spell_idx)
        {
            SkillLineEntry const* pSkill = sSkillLineStore.LookupEntry(_spell_idx->second->SkillLine);
            if (!pSkill)
            {
                continue;
            }

           /// @todo confirm if rogues start wth lockpicking skill at level 1 but only recieve the spell to use it at level 16
            // Added for runeforging, it is confirmed via sniff that this happens when death knights learn the spell, not on character creation.
            if ((_spell_idx->second->AcquireMethod == SKILL_LINE_ABILITY_LEARNED_ON_SKILL_LEARN && !HasSkill(pSkill->id)) || ((pSkill->id == SKILL_LOCKPICKING || pSkill->id == SKILL_RUNEFORGING) && _spell_idx->second->TrivialSkillLineRankHigh == 0))
            {
                LearnDefaultSkill(pSkill->id, 0);
            }

            if (pSkill->id == SKILL_MOUNTS && !Has310Flyer(false))
            {
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                {
                    if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED && spellInfo->Effects[i].CalcValue() == 310)
                    {
                        SetHas310Flyer(true);
                    }
                }
            }
        }
    }

    // xinef: update achievement criteria
    if (!GetSession()->PlayerLoading())
    {
        for (SkillLineAbilityMap::const_iterator _spell_idx = skill_bounds.first; _spell_idx != skill_bounds.second; ++_spell_idx)
        {
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LINE, _spell_idx->second->SkillLine);
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILLLINE_SPELLS, _spell_idx->second->SkillLine);
        }
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LEARN_SPELL, spellId);
    }

    return true;
}

bool Player::IsNeedCastPassiveSpellAtLearn(SpellInfo const* spellInfo) const
{
    // note: form passives activated with shapeshift spells be implemented by HandleShapeshiftBoosts instead of spell_learn_spell
    // talent dependent passives activated at form apply have proper stance data
    ShapeshiftForm form = GetShapeshiftForm();
    return (!spellInfo->Stances || (form && (spellInfo->Stances & (1 << (form - 1)))) ||
            (!form && spellInfo->HasAttribute(SPELL_ATTR2_ALLOW_WHILE_NOT_SHAPESHIFTED)));
}

void Player::learnSpell(uint32 spellId, bool temporary /*= false*/, bool learnFromSkill /*= false*/)
{
    // Xinef: don't allow to learn active spell once more
    if (HasActiveSpell(spellId))
    {
        LOG_DEBUG("entities.player", "Player ({}) tries to learn already active spell: {}", GetGUID().ToString(), spellId);
        return;
    }

    uint32 firstRankSpellId = sSpellMgr->GetFirstSpellInChain(spellId);
    bool thisSpec = GetTalentSpellCost(firstRankSpellId) > 0 || sSpellMgr->IsAdditionalTalentSpell(firstRankSpellId);
    bool added = addSpell(spellId, thisSpec ? GetActiveSpecMask() : SPEC_MASK_ALL, true, temporary, learnFromSkill);
    if (added)
    {
        sScriptMgr->OnPlayerLearnSpell(this, spellId);

        // pussywizard: a system message "you have learnt spell X (rank Y)"
        if (IsInWorld())
            SendLearnPacket(spellId, true);
    }

    // pussywizard: rank stuff at the end!
    if (uint32 nextSpell = sSpellMgr->GetNextSpellInChain(spellId))
    {
        // pussywizard: lookup next rank in m_spells (the only talents on m_spella are for example pyroblast, that have all ranks restored upon learning rank 1)
        // pussywizard: next ranks must not be in current spec (otherwise no need to learn already learnt)
        PlayerSpellMap::iterator itr = m_spells.find(nextSpell);
        if (itr != m_spells.end() && itr->second->State != PLAYERSPELL_REMOVED && !itr->second->IsInSpec(m_activeSpec))
            learnSpell(nextSpell, temporary);
    }

    // xinef: if we learn new spell, check all spells requiring this spell, if we have such a spell, and it is not in current spec - learn it
    SpellsRequiringSpellMapBounds spellsRequiringSpell = sSpellMgr->GetSpellsRequiringSpellBounds(spellId);
    for (SpellsRequiringSpellMap::const_iterator itr = spellsRequiringSpell.first; itr != spellsRequiringSpell.second; ++itr)
    {
        PlayerSpellMap::iterator itr2 = m_spells.find(itr->second);
        if (itr2 != m_spells.end() && itr2->second->State != PLAYERSPELL_REMOVED && !itr2->second->IsInSpec(m_activeSpec))
            learnSpell(itr2->first, temporary);
    }
}

void Player::removeSpell(uint32 spell_id, uint8 removeSpecMask, bool onlyTemporary)
{
    PlayerSpellMap::iterator itr = m_spells.find(spell_id);
    if (itr == m_spells.end())
        return;

    // pussywizard: nothing to do if already removed or not in specs of removeSpecMask
    if (itr->second->State == PLAYERSPELL_REMOVED || (itr->second->specMask & removeSpecMask) == 0)
        return;

    // pussywizard: avoid any possible bugs
    if (onlyTemporary && itr->second->State != PLAYERSPELL_TEMPORARY)
        return;

    // pussywizard: remove non-talent higher ranks (recursive)
    // pussywizard: do this at the beginning, not in the middle of removing!
    if (uint32 nextSpell = sSpellMgr->GetNextSpellInChain(spell_id))
        if (!GetTalentSpellPos(nextSpell))
            removeSpell(nextSpell, removeSpecMask, onlyTemporary);

    // xinef: if current spell has talentcost, remove spells requiring this spell
    uint32 firstRankSpellId = sSpellMgr->GetFirstSpellInChain(spell_id);
    if (GetTalentSpellCost(firstRankSpellId))
    {
        SpellsRequiringSpellMapBounds spellsRequiringSpell = sSpellMgr->GetSpellsRequiringSpellBounds(firstRankSpellId);
        for (auto spellsItr = spellsRequiringSpell.first; spellsItr != spellsRequiringSpell.second; ++spellsItr)
        {
            removeSpell(spellsItr->second, removeSpecMask, onlyTemporary);
        }
    }

    // pussywizard: re-search, it can be corrupted in prev loop
    itr = m_spells.find(spell_id);
    if (itr == m_spells.end())
        return;

    itr->second->specMask = (((uint8)itr->second->specMask) & ~removeSpecMask); // pussywizard: update specMask in map

    // pussywizard: some more conditions needed for spells like pyroblast (shouldn't be fully removed when not available in any spec, should stay in db with specMask = 0)
    if (GetTalentSpellCost(firstRankSpellId) == 0 && !sSpellMgr->IsAdditionalTalentSpell(firstRankSpellId) && itr->second->specMask == 0)
    {
        if (itr->second->State == PLAYERSPELL_NEW || itr->second->State == PLAYERSPELL_TEMPORARY)
        {
            delete itr->second;
            m_spells.erase(itr);
        }
        else
            itr->second->State = PLAYERSPELL_REMOVED;
    }
    else if (itr->second->State != PLAYERSPELL_NEW && itr->second->State != PLAYERSPELL_TEMPORARY)
        itr->second->State = PLAYERSPELL_CHANGED;

    // xinef: this is used for talents and they are not removed in removeSpell function...
    // xinef: however ill leave this here just in case
    // pussywizard: remove owned aura obtained from currently removed spell
    RemoveOwnedAura(spell_id);

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell_id);
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        // pussywizard: remove pet auras
        if (PetAura const* petSpell = sSpellMgr->GetPetAura(spell_id, i))
            RemovePetAura(petSpell);

        // pussywizard: remove all triggered auras
        if (spellInfo->Effects[i].TriggerSpell > 0)
            RemoveAurasDueToSpell(spellInfo->Effects[i].TriggerSpell);
    }

    // pussywizard: update free primary prof points
    if (spellInfo->IsPrimaryProfessionFirstRank())
    {
        uint32 freeProfs = GetFreePrimaryProfessionPoints() + 1;
        if (freeProfs <= sWorld->getIntConfig(CONFIG_MAX_PRIMARY_TRADE_SKILL))
            SetFreePrimaryProfessions(freeProfs);
    }

    // pussywizard: update 310 flyer
    if (Has310Flyer(false))
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED && spellInfo->Effects[i].CalcValue() == 310)
                Has310Flyer(true, spell_id);

    // pussywizard: remove dependent skill
    SpellLearnSkillNode const* spellLearnSkill = sSpellMgr->GetSpellLearnSkill(spell_id);
    if (spellLearnSkill)
    {
        uint32 prev_spell = sSpellMgr->GetPrevSpellInChain(spell_id);

        if (!prev_spell) // pussywizard: first rank, remove skill
            SetSkill(spellLearnSkill->skill, 0, 0, 0);
        else // pussywizard: search previous ranks
        {
            SpellLearnSkillNode const* prevSkill = sSpellMgr->GetSpellLearnSkill(prev_spell);
            while (!prevSkill && prev_spell)
            {
                prev_spell = sSpellMgr->GetPrevSpellInChain(prev_spell);
                prevSkill = sSpellMgr->GetSpellLearnSkill(sSpellMgr->GetFirstSpellInChain(prev_spell));
            }

            if (!prevSkill) // pussywizard: not found prev skill setting, remove skill
                SetSkill(spellLearnSkill->skill, 0, 0, 0);
            else // pussywizard: set to prev skill setting values
            {
                uint32 skill_value = GetPureSkillValue(prevSkill->skill);
                uint32 skill_max_value = GetPureMaxSkillValue(prevSkill->skill);
                uint32 new_skill_max_value = prevSkill->maxvalue == 0 ? GetMaxSkillValueForLevel() : prevSkill->maxvalue;

                if (skill_value > prevSkill->value)
                    skill_value = prevSkill->value;
                if (skill_max_value > new_skill_max_value)
                    skill_max_value = new_skill_max_value;

                SetSkill(prevSkill->skill, prevSkill->step, skill_value, skill_max_value);
            }
        }
    }
    else
    {
        SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spell_id);
        // most likely will never be used, haven't heard of cases where players unlearn a mount
        if (Has310Flyer(false) && spellInfo)
        {
            for (SkillLineAbilityMap::const_iterator _spell_idx = bounds.first; _spell_idx != bounds.second; ++_spell_idx)
            {
                SkillLineEntry const* pSkill = sSkillLineStore.LookupEntry(_spell_idx->second->SkillLine);
                if (!pSkill)
                    continue;

                if (_spell_idx->second->SkillLine == SKILL_MOUNTS)
                {
                    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                    {
                        if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED &&
                            spellInfo->Effects[i].CalcValue() == 310)
                        {
                            Has310Flyer(true, spell_id);    // with true as first argument its also used to set/remove the flag
                            break;
                        }
                    }
                }
            }
        }
    }

    // pussywizard: remove from spell book (can't be replaced by previous rank, because such spells can't be unlearnt)
    if (!onlyTemporary || ((!spellInfo->HasAttribute(SpellAttr0(SPELL_ATTR0_PASSIVE | SPELL_ATTR0_DO_NOT_DISPLAY)) || !spellInfo->HasAnyAura()) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL)))
    {
        sScriptMgr->OnPlayerForgotSpell(this, spell_id);
        SendLearnPacket(spell_id, false);
    }
}

bool Player::Has310Flyer(bool checkAllSpells, uint32 excludeSpellId)
{
    if (!checkAllSpells)
        return m_ExtraFlags & PLAYER_EXTRA_HAS_310_FLYER;
    else
    {
        SetHas310Flyer(false);
        SpellInfo const* spellInfo;
        for (PlayerSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
        {
            // pussywizard:
            if (itr->second->State == PLAYERSPELL_REMOVED)
                continue;

            if (itr->first == excludeSpellId)
                continue;

            SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(itr->first);
            for (SkillLineAbilityMap::const_iterator _spell_idx = bounds.first; _spell_idx != bounds.second; ++_spell_idx)
            {
                if (_spell_idx->second->SkillLine != SKILL_MOUNTS)
                    break;  // We can break because mount spells belong only to one skillline (at least 310 flyers do)

                spellInfo = sSpellMgr->AssertSpellInfo(itr->first);
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                    if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED &&
                            spellInfo->Effects[i].CalcValue() == 310)
                    {
                        SetHas310Flyer(true);
                        return true;
                    }
            }
        }
    }

    return false;
}

void Player::RemoveSpellCooldown(uint32 spell_id, bool update /* = false */)
{
    m_spellCooldowns.erase(spell_id);

    if (update)
        SendClearCooldown(spell_id, this);
}

void Player::RemoveCategoryCooldown(uint32 cat)
{
    SpellCategoryStore::const_iterator i_scstore = sSpellsByCategoryStore.find(cat);
    if (i_scstore != sSpellsByCategoryStore.end())
        for (SpellCategorySet::const_iterator i_scset = i_scstore->second.begin(); i_scset != i_scstore->second.end(); ++i_scset)
            RemoveSpellCooldown(i_scset->second, true);
}

void Player::RemoveArenaSpellCooldowns(bool removeActivePetCooldowns)
{
    // remove cooldowns on spells that have < 10 min CD
    uint32 infTime = GameTime::GetGameTimeMS().count() + infinityCooldownDelayCheck;
    SpellCooldowns::iterator itr, next;
    for (itr = m_spellCooldowns.begin(); itr != m_spellCooldowns.end(); itr = next)
    {
        next = itr;
        ++next;
        SpellInfo const* spellInfo = sSpellMgr->CheckSpellInfo(itr->first);
        if (!spellInfo)
        {
            continue;
        }

        if (spellInfo->HasAttribute(SPELL_ATTR4_IGNORE_DEFAULT_ARENA_RESTRICTIONS))
            RemoveSpellCooldown(itr->first, true);
        else if (spellInfo->RecoveryTime < 10 * MINUTE * IN_MILLISECONDS && spellInfo->CategoryRecoveryTime < 10 * MINUTE * IN_MILLISECONDS && itr->second.end < infTime// xinef: dont remove active cooldowns - bugz
                 && itr->second.maxduration < 10 * MINUTE * IN_MILLISECONDS) // xinef: dont clear cooldowns that have maxduration > 10 minutes (eg item cooldowns with no spell.dbc cooldown info)
            RemoveSpellCooldown(itr->first, true);
    }

    // pet cooldowns
    if (removeActivePetCooldowns)
        if (Pet* pet = GetPet())
        {
            // notify player
            for (CreatureSpellCooldowns::const_iterator itr2 = pet->m_CreatureSpellCooldowns.begin(); itr2 != pet->m_CreatureSpellCooldowns.end(); ++itr2)
                SendClearCooldown(itr2->first, pet);

            // actually clear cooldowns
            pet->m_CreatureSpellCooldowns.clear();
        }
}

void Player::RemoveAllSpellCooldown()
{
    uint32 infTime = GameTime::GetGameTimeMS().count() + infinityCooldownDelayCheck;
    if (!m_spellCooldowns.empty())
    {
        for (SpellCooldowns::const_iterator itr = m_spellCooldowns.begin(); itr != m_spellCooldowns.end(); ++itr)
            if (itr->second.end < infTime)
                SendClearCooldown(itr->first, this);

        m_spellCooldowns.clear();
    }
}

void Player::_LoadSpellCooldowns(PreparedQueryResult result)
{
    // some cooldowns can be already set at aura loading...

    //QueryResult* result = CharacterDatabase.Query("SELECT spell, category, item, time FROM character_spell_cooldown WHERE guid = '{}'", GetGUID().GetCounter()());

    if (result)
    {
        time_t curTime = GameTime::GetGameTime().count();

        do
        {
            Field* fields = result->Fetch();
            uint32 spell_id = fields[0].Get<uint32>();
            uint16 category = fields[1].Get<uint16>();
            uint32 item_id  = fields[2].Get<uint32>();
            uint32 db_time  = fields[3].Get<uint32>();
            bool needSend   = fields[4].Get<bool>();

            if (!sSpellMgr->GetSpellInfo(spell_id))
            {
                LOG_ERROR("entities.player", "Player {} has unknown spell {} in `character_spell_cooldown`, skipping.", GetGUID().ToString(), spell_id);
                continue;
            }

            // skip outdated cooldown
            if (db_time <= curTime)
                continue;

            _AddSpellCooldown(spell_id, category, item_id, (db_time - curTime) * IN_MILLISECONDS, needSend);

            LOG_DEBUG("entities.player.loading", "Player ({}) spell {}, item {} cooldown loaded ({} secs).", GetGUID().ToString(), spell_id, item_id, uint32(db_time - curTime));
        } while (result->NextRow());
    }
}

void Player::_SaveSpellCooldowns(CharacterDatabaseTransaction trans, bool logout)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SPELL_COOLDOWN);
    stmt->SetData(0, GetGUID().GetCounter());
    trans->Append(stmt);

    time_t curTime = GameTime::GetGameTime().count();
    uint32 curMSTime = GameTime::GetGameTimeMS().count();
    uint32 infTime = curMSTime + infinityCooldownDelayCheck;

    bool first_round = true;
    std::ostringstream ss;

    // remove outdated and save active
    for (SpellCooldowns::iterator itr = m_spellCooldowns.begin(); itr != m_spellCooldowns.end();)
    {
        // Xinef: dummy cooldown for procs
        if (itr->first == uint32(-1))
        {
            ++itr;
            continue;
        }

        if (itr->second.end <= curMSTime + 1000)
            m_spellCooldowns.erase(itr++);
        else if (itr->second.end <= infTime && (logout || itr->second.end > (curMSTime + 5 * MINUTE * IN_MILLISECONDS)))             // not save locked cooldowns, it will be reset or set at reload
        {
            if (first_round)
            {
                ss << "INSERT INTO character_spell_cooldown (guid, spell, category, item, time, needSend) VALUES ";
                first_round = false;
            }
            // next new/changed record prefix
            else
                ss << ',';

            uint64 cooldown = uint64(((itr->second.end - curMSTime) / IN_MILLISECONDS) + curTime);
            ss << '(' << GetGUID().GetCounter() << ',' << itr->first << ',' << itr->second.category << "," << itr->second.itemid << ',' << cooldown << ',' << (itr->second.needSendToClient ? '1' : '0') << ')';
            ++itr;
        }
        else
            ++itr;
    }
    // if something changed execute
    if (!first_round)
        trans->Append(ss.str().c_str());
}

uint32 Player::resetTalentsCost() const
{
    // The first time reset costs 1 gold
    if (m_resetTalentsCost < 1 * GOLD)
        return 1 * GOLD;
    // then 5 gold
    else if (m_resetTalentsCost < 5 * GOLD)
        return 5 * GOLD;
    // After that it increases in increments of 5 gold
    else if (m_resetTalentsCost < 10 * GOLD)
        return 10 * GOLD;
    else
    {
        uint64 months = (GameTime::GetGameTime().count() - m_resetTalentsTime) / MONTH;
        if (months > 0)
        {
            // This cost will be reduced by a rate of 5 gold per month
            int32 new_cost = int32(m_resetTalentsCost - 5 * GOLD * months);
            // to a minimum of 10 gold.
            return (new_cost < 10 * GOLD ? 10 * GOLD : new_cost);
        }
        else
        {
            // After that it increases in increments of 5 gold
            int32 new_cost = m_resetTalentsCost + 5 * GOLD;
            // until it hits a cap of 50 gold.
            if (new_cost > 50 * GOLD)
                new_cost = 50 * GOLD;
            return new_cost;
        }
    }
}

bool Player::resetTalents(bool noResetCost)
{
    sScriptMgr->OnPlayerTalentsReset(this, noResetCost);

    // xinef: remove at login flag upon talents reset
    if (HasAtLoginFlag(AT_LOGIN_RESET_TALENTS))
        RemoveAtLoginFlag(AT_LOGIN_RESET_TALENTS, true);

    // xinef: get max available talent points amount
    uint32 talentPointsForLevel = CalculateTalentsPoints();

    // xinef: no talent points are used, return
    if (m_usedTalentCount == 0)
        return false;
    m_usedTalentCount = 0;

    // xinef: check if we have enough money
    uint32 resetCost = 0;
    if (!noResetCost && !sWorld->getBoolConfig(CONFIG_NO_RESET_TALENT_COST))
    {
        resetCost = resetTalentsCost();
        if (!HasEnoughMoney(resetCost))
        {
            SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, 0, 0, 0);
            return false;
        }
    }

    RemovePet(nullptr, PET_SAVE_NOT_IN_SLOT, true);

    // xinef: reset talents
    for (PlayerTalentMap::iterator iter = m_talents.begin(); iter != m_talents.end(); )
    {
        PlayerTalentMap::iterator itr = iter++;

        if (itr->second->State == PLAYERSPELL_REMOVED)
            continue;

        // xinef: talent not in current spec
        if (!(itr->second->specMask & GetActiveSpecMask()))
            continue;

        // xinef: remove talent auras
        _removeTalentAurasAndSpells(itr->first);

        // xinef: check if talent learns spell to spell book
        TalentEntry const* talentInfo = sTalentStore.LookupEntry(itr->second->talentID);
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);

        bool removed = false;
        if (talentInfo->addToSpellBook)
            if (!spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
            {
                removeSpell(itr->first, GetActiveSpecMask(), false);
                removed = true;
            }

        // Xinef: send unlearn spell packet at talent remove
        if (!removed)
            SendLearnPacket(itr->first, false);

        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL)
                if (sSpellMgr->IsAdditionalTalentSpell(spellInfo->Effects[i].TriggerSpell))
                    removeSpell(spellInfo->Effects[i].TriggerSpell, GetActiveSpecMask(), false);

        // xinef: remove talent modifies m_talents, move itr to map begin
        _removeTalent(itr, GetActiveSpecMask());
    }

    // xinef: remove titan grip if player had it set
    if (m_canTitanGrip)
        SetCanTitanGrip(false);
    // xinef: remove dual wield if player does not have dual wield spell (shamans)
    if (!HasSpell(674) && m_canDualWield)
        SetCanDualWield(false);

    AutoUnequipOffhandIfNeed();

    // pussywizard: removed saving to db, nothing important happens and saving only spells and talents may cause data integrity problems (eg. with skills saved to db)
    SetFreeTalentPoints(talentPointsForLevel);

    if (!noResetCost)
    {
        ModifyMoney(-(int32)resetCost);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_TALENTS, resetCost);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_NUMBER_OF_TALENT_RESETS, 1);

        m_resetTalentsCost = resetCost;
        m_resetTalentsTime = GameTime::GetGameTime().count();
    }

    return true;
}

void Player::SetFreeTalentPoints(uint32 points)
{
    sScriptMgr->OnPlayerFreeTalentPointsChanged(this, points);
    SetUInt32Value(PLAYER_CHARACTER_POINTS1, points);
}

Mail* Player::GetMail(uint32 id)
{
    for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
    {
        if ((*itr)->messageID == id)
        {
            return (*itr);
        }
    }
    return nullptr;
}

void Player::BuildCreateUpdateBlockForPlayer(UpdateData* data, Player* target)
{
    if (target == this)
    {
        for (uint8 i = 0; i < EQUIPMENT_SLOT_END; ++i)
        {
            if (!m_items[i])
                continue;

            m_items[i]->BuildCreateUpdateBlockForPlayer(data, target);
        }

        for (uint8 i = INVENTORY_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
        {
            if (!m_items[i])
                continue;

            m_items[i]->BuildCreateUpdateBlockForPlayer(data, target);
        }
        for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
        {
            if (!m_items[i])
                continue;

            m_items[i]->BuildCreateUpdateBlockForPlayer(data, target);
        }
    }

    Unit::BuildCreateUpdateBlockForPlayer(data, target);
}

void Player::DestroyForPlayer(Player* target, bool onDeath) const
{
    Unit::DestroyForPlayer(target, onDeath);

    for (uint8 i = 0; i < EQUIPMENT_SLOT_END; ++i) // xinef: previously INVENTORY_SLOT_BAG_END
    {
        if (!m_items[i])
            continue;

        m_items[i]->DestroyForPlayer(target);
    }

    if (target == this)
    {
        for (uint8 i = INVENTORY_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
        {
            if (!m_items[i])
                continue;

            m_items[i]->DestroyForPlayer(target);
        }
        for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
        {
            if (!m_items[i])
                continue;

            m_items[i]->DestroyForPlayer(target);
        }
    }
}

bool Player::HasSpell(uint32 spell) const
{
    PlayerSpellMap::const_iterator itr = m_spells.find(spell);
    return (itr != m_spells.end() && itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(m_activeSpec));
}

bool Player::HasTalent(uint32 spell, uint8  /*spec*/) const
{
    PlayerTalentMap::const_iterator itr = m_talents.find(spell);
    return (itr != m_talents.end() && itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(m_activeSpec));
}

bool Player::HasActiveSpell(uint32 spell) const
{
    PlayerSpellMap::const_iterator itr = m_spells.find(spell);
    return (itr != m_spells.end() && itr->second->State != PLAYERSPELL_REMOVED && itr->second->Active && itr->second->IsInSpec(m_activeSpec));
}

TrainerSpellState Player::GetTrainerSpellState(TrainerSpell const* trainer_spell) const
{
    if (!trainer_spell)
        return TRAINER_SPELL_RED;

    bool hasSpell = true;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (!trainer_spell->learnedSpell[i])
            continue;

        if (!HasSpell(trainer_spell->learnedSpell[i]))
        {
            hasSpell = false;
            break;
        }
    }
    // known spell
    if (hasSpell)
        return TRAINER_SPELL_GRAY;

    // check skill requirement
    if (trainer_spell->reqSkill && GetBaseSkillValue(trainer_spell->reqSkill) < trainer_spell->reqSkillValue)
        return TRAINER_SPELL_RED;

    // check level requirement
    if (GetLevel() < trainer_spell->reqLevel)
        return TRAINER_SPELL_RED;

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (!trainer_spell->learnedSpell[i])
            continue;

        // check race/class requirement
        if (!IsSpellFitByClassAndRace(trainer_spell->learnedSpell[i]))
            return TRAINER_SPELL_RED;

        if (uint32 prevSpell = sSpellMgr->GetPrevSpellInChain(trainer_spell->learnedSpell[i]))
        {
            // check prev.rank requirement
            if (prevSpell && !HasSpell(prevSpell))
                return TRAINER_SPELL_RED;
        }

        SpellsRequiringSpellMapBounds spellsRequired = sSpellMgr->GetSpellsRequiredForSpellBounds(trainer_spell->learnedSpell[i]);
        for (SpellsRequiringSpellMap::const_iterator itr = spellsRequired.first; itr != spellsRequired.second; ++itr)
        {
            // check additional spell requirement
            if (!HasSpell(itr->second))
                return TRAINER_SPELL_RED;
        }
    }

    // check primary prof. limit
    // first rank of primary profession spell when there are no proffesions avalible is disabled
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (!trainer_spell->learnedSpell[i])
            continue;
        SpellInfo const* learnedSpellInfo = sSpellMgr->GetSpellInfo(trainer_spell->learnedSpell[i]);
        if (learnedSpellInfo && learnedSpellInfo->IsPrimaryProfessionFirstRank() && (GetFreePrimaryProfessionPoints() == 0))
            return TRAINER_SPELL_GREEN_DISABLED;
    }

    return TRAINER_SPELL_GREEN;
}

/**
 * Deletes a character from the database
 *
 * The way, how the characters will be deleted is decided based on the config option.
 *
 * @param playerguid       the low-GUID from the player which should be deleted
 * @param accountId        the account id from the player
 * @param updateRealmChars when this flag is set, the amount of characters on that realm will be updated in the realmlist
 * @param deleteFinally    if this flag is set, the config option will be ignored and the character will be permanently removed from the database
 */
void Player::DeleteFromDB(ObjectGuid::LowType lowGuid, uint32 accountId, bool updateRealmChars, bool deleteFinally)
{
    // for not existed account avoid update realm
    if (!accountId)
        updateRealmChars = false;

    ObjectGuid playerGuid = ObjectGuid::Create<HighGuid::Player>(lowGuid);

    uint32 charDelete_method = sWorld->getIntConfig(CONFIG_CHARDELETE_METHOD);
    uint32 charDelete_minLvl = sWorld->getIntConfig(CONFIG_CHARDELETE_MIN_LEVEL);

    // if we want to finally delete the character or the character does not meet the level requirement,
    // we set it to mode CHAR_DELETE_REMOVE
    if (deleteFinally || sCharacterCache->GetCharacterLevelByGuid(playerGuid) < charDelete_minLvl)
        charDelete_method = CHAR_DELETE_REMOVE;

    if (uint32 guildId = sCharacterCache->GetCharacterGuildIdByGuid(playerGuid))
        if (Guild* guild = sGuildMgr->GetGuildById(guildId))
            guild->DeleteMember(playerGuid, false, false, true);

    // remove from arena teams
    LeaveAllArenaTeams(playerGuid);

    // close player ticket if any
    GmTicket* ticket = sTicketMgr->GetTicketByPlayer(playerGuid);
    if (ticket)
        sTicketMgr->CloseTicket(ticket->GetId(), playerGuid);

    // remove from group
    if (ObjectGuid groupId = sCharacterCache->GetCharacterGroupGuidByGuid(playerGuid))
        if (Group* group = sGroupMgr->GetGroupByGUID(groupId.GetCounter()))
            RemoveFromGroup(group, playerGuid);

    // Remove signs from petitions (also remove petitions if owner);
    RemovePetitionsAndSigns(playerGuid, 10);

    CharacterDatabasePreparedStatement* stmt = nullptr;

    switch (charDelete_method)
    {
        // Completely remove from the database
        case CHAR_DELETE_REMOVE:
            {
                CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_COD_ITEM_MAIL);
                stmt->SetData(0, lowGuid);
                PreparedQueryResult resultMail = CharacterDatabase.Query(stmt);

                if (resultMail)
                {
                    std::unordered_map<uint32, std::vector<Item*>> itemsByMail;

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAILITEMS);
                    stmt->SetData(0, lowGuid);
                    PreparedQueryResult resultItems = CharacterDatabase.Query(stmt);

                    if (resultItems)
                    {
                        do
                        {
                            Field* fields = resultItems->Fetch();
                            uint32 mailId = fields[14].Get<uint32>();
                            if (Item* mailItem = _LoadMailedItem(playerGuid, nullptr, mailId, nullptr, fields))
                            {
                                itemsByMail[mailId].push_back(mailItem);
                            }
                        } while (resultItems->NextRow());
                    }

                    do
                    {
                        Field* mailFields = resultMail->Fetch();

                        uint32 mail_id       = mailFields[0].Get<uint32>();
                        uint8 mailType       = mailFields[1].Get<uint8>();
                        uint16 mailTemplateId = mailFields[2].Get<uint16>();
                        uint32 sender        = mailFields[3].Get<uint32>();
                        std::string subject  = mailFields[4].Get<std::string>();
                        std::string body     = mailFields[5].Get<std::string>();
                        uint32 money         = mailFields[6].Get<uint32>();
                        bool has_items       = mailFields[7].Get<bool>();

                        // We can return mail now
                        // So firstly delete the old one
                        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_BY_ID);
                        stmt->SetData(0, mail_id);
                        trans->Append(stmt);

                        // Mail is not from player
                        if (mailType != MAIL_NORMAL)
                        {
                            if (has_items)
                            {
                                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM_BY_ID);
                                stmt->SetData(0, mail_id);
                                trans->Append(stmt);
                            }
                            continue;
                        }

                        MailDraft draft(subject, body);
                        if (mailTemplateId)
                            draft = MailDraft(mailTemplateId, false);    // items are already included

                        auto itemsItr = itemsByMail.find(mail_id);
                        if (itemsItr != itemsByMail.end())
                        {
                            for (Item* item : itemsItr->second)
                            {
                                draft.AddItem(item);
                            }

                            // MailDraft will take care of freeing memory.
                            itemsByMail.erase(itemsItr);
                        }

                        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM_BY_ID);
                        stmt->SetData(0, mail_id);
                        trans->Append(stmt);

                        uint32 pl_account = sCharacterCache->GetCharacterAccountIdByGuid(ObjectGuid(HighGuid::Player, lowGuid));

                        draft.AddMoney(money).SendReturnToSender(pl_account, lowGuid, sender, trans);
                    } while (resultMail->NextRow());
                }

                // Unsummon and delete for pets in world is not required: player deleted from CLI or character list with not loaded pet.
                // NOW we can finally clear other DB data related to character
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PET_IDS);
                stmt->SetData(0, lowGuid);
                PreparedQueryResult resultPets = CharacterDatabase.Query(stmt);

                if (resultPets)
                {
                    do
                    {
                        ObjectGuid::LowType petguidlow = (*resultPets)[0].Get<uint32>();
                        Pet::DeleteFromDB(petguidlow);
                    } while (resultPets->NextRow());
                }

                // Delete char from social list of online chars
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_SOCIAL);
                stmt->SetData(0, lowGuid);
                PreparedQueryResult resultFriends = CharacterDatabase.Query(stmt);

                if (resultFriends)
                {
                    do
                    {
                        if (Player* pFriend = ObjectAccessor::FindPlayerByLowGUID((*resultFriends)[0].Get<uint32>()))
                        {
                            pFriend->GetSocial()->RemoveFromSocialList(playerGuid, SOCIAL_FLAG_ALL);
                            sSocialMgr->SendFriendStatus(pFriend, FRIEND_REMOVED, playerGuid, false);
                        }
                    } while (resultFriends->NextRow());
                }

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHARACTER);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_ACCOUNT_DATA);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_DECLINED_NAME);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACTION);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_AURA);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_GIFT);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_HOMEBIND);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INSTANCE);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_REWARDED);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_REPUTATION);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SPELL);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SPELL_COOLDOWN);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                if (sWorld->getBoolConfig(CONFIG_DELETE_CHARACTER_TICKET_TRACE))
                {
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_PLAYER_GM_TICKETS_ON_CHAR_DELETION);
                    stmt->SetData(0, lowGuid);
                    trans->Append(stmt);
                }
                else
                {
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_GM_TICKETS);
                    stmt->SetData(0, lowGuid);
                    trans->Append(stmt);
                }

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE_BY_OWNER);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SOCIAL_BY_FRIEND);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SOCIAL_BY_GUID);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEMS);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_BY_OWNER);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_DECLINEDNAME_BY_OWNER);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACHIEVEMENTS);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACHIEVEMENT_PROGRESS);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_EQUIPMENTSETS);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GUILD_EVENTLOG_BY_PLAYER);
                stmt->SetData(0, lowGuid);
                stmt->SetData(1, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GUILD_BANK_EVENTLOG_BY_PLAYER);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_ENTRY_POINT);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_GLYPHS);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_DAILY_CHAR);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_WEEKLY_CHAR);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_MONTHLY_CHAR);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_SEASONAL_CHAR);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_TALENT);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SKILLS);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SETTINGS);
                stmt->SetData(0, lowGuid);
                trans->Append(stmt);

                Corpse::DeleteFromDB(playerGuid, trans);

                sScriptMgr->OnDeleteFromDB(trans, lowGuid);

                CharacterDatabase.CommitTransaction(trans);
                break;
            }
        // The character gets unlinked from the account, the name gets freed up and appears as deleted ingame
        case CHAR_DELETE_UNLINK:
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_DELETE_INFO);

                stmt->SetData(0, lowGuid);

                CharacterDatabase.Execute(stmt);
                break;
            }
        default:
            LOG_ERROR("entities.player", "Player::DeleteFromDB: Unsupported delete method: {}.", charDelete_method);
            return;
    }

    if (CharacterCacheEntry const* cache = sCharacterCache->GetCharacterCacheByGuid(playerGuid))
    {
        std::string name = cache->Name;
        sCharacterCache->DeleteCharacterCacheEntry(playerGuid, name);
    }

    if (updateRealmChars)
    {
        sWorld->UpdateRealmCharCount(accountId);
    }
}

/**
 * Characters which were kept back in the database after being deleted and are now too old (see config option "CharDelete.KeepDays"), will be completely deleted.
 */
void Player::DeleteOldCharacters()
{
    uint32 keepDays = sWorld->getIntConfig(CONFIG_CHARDELETE_KEEP_DAYS);
    if (!keepDays)
        return;

    Player::DeleteOldCharacters(keepDays);
}

/**
 * Characters which were kept back in the database after being deleted and are older than the specified amount of days, will be completely deleted.
 */
void Player::DeleteOldCharacters(uint32 keepDays)
{
    LOG_INFO("server.loading", "Player::DeleteOldChars: Deleting all characters which have been deleted {} days before...", keepDays);
    LOG_INFO("server.loading", " ");

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_OLD_CHARS);
    stmt->SetData(0, uint32(GameTime::GetGameTime().count() - time_t(keepDays * DAY)));
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (result)
    {
        LOG_INFO("server.loading", "Player::DeleteOldChars: Found {} character(s) to delete", result->GetRowCount());
        do
        {
            Field* fields = result->Fetch();
            Player::DeleteFromDB(fields[0].Get<uint32>(), fields[1].Get<uint32>(), true, true);
        } while (result->NextRow());
    }
}

/**
 * Items which were kept back in the database after being deleted and are now too old (see config option "ItemDelete.KeepDays"), will be completely deleted.
 */
void Player::DeleteOldRecoveryItems()
{
    uint32 keepDays = sWorld->getIntConfig(CONFIG_ITEMDELETE_KEEP_DAYS);
    if (!keepDays)
        return;

    Player::DeleteOldRecoveryItems(keepDays);
}

/**
 * Items which were kept back in the database after being deleted and are older than the specified amount of days, will be completely deleted.
 */
void Player::DeleteOldRecoveryItems(uint32 keepDays)
{
    LOG_INFO("server.loading", "Player::DeleteOldRecoveryItems: Deleting all items which have been deleted {} days before...", keepDays);
    LOG_INFO("server.loading", " ");

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_RECOVERY_ITEM_OLD_ITEMS);
    stmt->SetData(0, uint32(GameTime::GetGameTime().count() - time_t(keepDays * DAY)));
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (result)
    {
        LOG_INFO("server.loading", "Player::DeleteOldRecoveryItems: Found {} item(s) to delete", result->GetRowCount());
        do
        {
            Field* fields = result->Fetch();

            uint32 guid = fields[0].Get<uint32>();
            uint32 itemEntry = fields[1].Get<uint32>();

            CharacterDatabasePreparedStatement* deleteStmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_RECOVERY_ITEM_BY_GUID);
            deleteStmt->SetData(0, guid);
            CharacterDatabase.Execute(deleteStmt);

            LOG_INFO("server.loading", "Deleted item from recovery_item table where guid {} and item id {}", guid, itemEntry);
        } while (result->NextRow());
    }
}

void Player::SetMovement(PlayerMovementType pType)
{
    WorldPacket data;
    switch (pType)
    {
        case MOVE_ROOT:
            data.Initialize(SMSG_FORCE_MOVE_ROOT,   GetPackGUID().size() + 4);
            break;
        case MOVE_UNROOT:
            data.Initialize(SMSG_FORCE_MOVE_UNROOT, GetPackGUID().size() + 4);
            break;
        case MOVE_WATER_WALK:
            data.Initialize(SMSG_MOVE_WATER_WALK,   GetPackGUID().size() + 4);
            break;
        case MOVE_LAND_WALK:
            data.Initialize(SMSG_MOVE_LAND_WALK,    GetPackGUID().size() + 4);
            break;
        default:
            LOG_ERROR("entities.player", "Player::SetMovement: Unsupported move type ({}), data not sent to client.", pType);
            return;
    }
    data << GetPackGUID();
    data << uint32(0);
    GetSession()->SendPacket(&data);
}

/* Preconditions:
  - a resurrectable corpse must not be loaded for the player (only bones)
  - the player must be in world
*/
void Player::BuildPlayerRepop()
{
    WorldPacket data(SMSG_PRE_RESURRECT, GetPackGUID().size());
    data << GetPackGUID();
    GetSession()->SendPacket(&data);
    if (getRace(true) == RACE_NIGHTELF)
    {
        CastSpell(this, 20584, true);
    }
    CastSpell(this, 8326, true);

    // there must be SMSG.FORCE_RUN_SPEED_CHANGE, SMSG.FORCE_SWIM_SPEED_CHANGE, SMSG.MOVE_WATER_WALK
    // there must be SMSG.STOP_MIRROR_TIMER

    // the player cannot have a corpse already on current map, only bones which are not returned by GetCorpse
    WorldLocation corpseLocation = GetCorpseLocation();
    if (GetCorpse() && corpseLocation.GetMapId() == GetMapId())
    {
        LOG_ERROR("entities.player", "BuildPlayerRepop: player {} ({}) already has a corpse", GetName(), GetGUID().ToString());
        return;
    }

    // create a corpse and place it at the player's location
    Corpse* corpse = CreateCorpse();
    if (!corpse)
    {
        LOG_ERROR("entities.player", "Error creating corpse for Player {} [{}]", GetName(), GetGUID().ToString());
        return;
    }
    GetMap()->AddToMap(corpse);
    SetHealth(1); // convert player body to ghost
    SetMovement(MOVE_WATER_WALK);
    SetWaterWalking(true);
    if (!GetSession()->isLogingOut())
    {
        SetMovement(MOVE_UNROOT);
    }
    RemoveUnitFlag(UNIT_FLAG_SKINNABLE); // BG - remove insignia related
    int32 corpseReclaimDelay = CalculateCorpseReclaimDelay();
    if (corpseReclaimDelay >= 0)
    {
        SendCorpseReclaimDelay(corpseReclaimDelay);
    }
    corpse->ResetGhostTime(); // to prevent cheating
    StopMirrorTimers(); // disable timers on bars
    SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, UNIT_BYTE1_FLAG_ALWAYS_STAND); // set and clear other
    sScriptMgr->OnPlayerReleasedGhost(this);
}

void Player::ResurrectPlayer(float restore_percent, bool applySickness)
{
    WorldPacket data(SMSG_DEATH_RELEASE_LOC, 4 * 4);        // remove spirit healer position
    data << uint32(-1);
    data << float(0);
    data << float(0);
    data << float(0);
    GetSession()->SendPacket(&data);

    // speed change, land walk

    // remove death flag + set aura
    SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, UNIT_BYTE1_FLAG_GROUND);
    RemoveAurasDueToSpell(20584);                           // speed bonuses
    RemoveAurasDueToSpell(8326);                            // SPELL_AURA_GHOST

    if (GetSession()->IsARecruiter() || (GetSession()->GetRecruiterId() != 0))
        SetDynamicFlag(UNIT_DYNFLAG_REFER_A_FRIEND);

    setDeathState(DeathState::Alive);
    SetMovement(MOVE_LAND_WALK);
    SetMovement(MOVE_UNROOT);
    SetWaterWalking(false);
    m_deathTimer = 0;

    // set health/powers (0- will be set in caller)
    if (restore_percent > 0.0f)
    {
        SetHealth(uint32(GetMaxHealth()*restore_percent));
        SetPower(POWER_MANA, uint32(GetMaxPower(POWER_MANA)*restore_percent));
        SetPower(POWER_RAGE, 0);
        SetPower(POWER_ENERGY, uint32(GetMaxPower(POWER_ENERGY)*restore_percent));
    }

    // trigger update zone for alive state zone updates
    uint32 newzone, newarea;
    GetZoneAndAreaId(newzone, newarea);
    UpdateZone(newzone, newarea);
    sOutdoorPvPMgr->HandlePlayerResurrects(this, newzone);

    if (Battleground* bg = GetBattleground())
        bg->HandlePlayerResurrect(this);

    // update visibility
    UpdateObjectVisibility();

    sScriptMgr->OnPlayerResurrect(this, restore_percent, applySickness);

    if (!applySickness)
    {
        return;
    }

    //Characters from level 1-10 are not affected by resurrection sickness.
    //Characters from level 11-19 will suffer from one minute of sickness
    //for each level they are above 10.
    //Characters level 20 and up suffer from ten minutes of sickness.
    int32 startLevel = sWorld->getIntConfig(CONFIG_DEATH_SICKNESS_LEVEL);

    if (int32(GetLevel()) >= startLevel)
    {
        // set resurrection sickness
        CastSpell(this, 15007, true);

        // not full duration
        if (int32(GetLevel()) < startLevel + 9)
        {
            int32 delta = (int32(GetLevel()) - startLevel + 1) * MINUTE;

            if (Aura* aur = GetAura(15007, GetGUID()))
            {
                aur->SetDuration(delta * IN_MILLISECONDS);
            }
        }
    }
}

void Player::KillPlayer()
{
    if (IsFlying() && !GetTransport())
        GetMotionMaster()->MoveFall();

    SetMovement(MOVE_ROOT);

    StopMirrorTimers();                                     //disable timers(bars)

    setDeathState(DeathState::Corpse);
    //SetUnitFlag(UNIT_FLAG_NOT_IN_PVP);

    ReplaceAllDynamicFlags(UNIT_DYNFLAG_NONE);
    ApplyModFlag(PLAYER_FIELD_BYTES, PLAYER_FIELD_BYTE_RELEASE_TIMER, !sMapStore.LookupEntry(GetMapId())->Instanceable() && !HasAuraType(SPELL_AURA_PREVENT_RESURRECTION));

    // 6 minutes until repop at graveyard
    m_deathTimer = 6 * MINUTE * IN_MILLISECONDS;

    UpdateCorpseReclaimDelay();                             // dependent at use SetDeathPvP() call before kill

    int32 corpseReclaimDelay = CalculateCorpseReclaimDelay();

    if (corpseReclaimDelay >= 0)
        SendCorpseReclaimDelay(corpseReclaimDelay);

    sScriptMgr->OnPlayerJustDied(this);
    // don't create corpse at this moment, player might be falling

    // update visibility
    //UpdateObjectVisibility(); // pussywizard: not needed
}

void Player::OfflineResurrect(ObjectGuid const guid, CharacterDatabaseTransaction trans)
{
    Corpse::DeleteFromDB(guid, trans);
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
    stmt->SetData(0, uint16(AT_LOGIN_RESURRECT));
    stmt->SetData(1, guid.GetCounter());
    CharacterDatabase.ExecuteOrAppend(trans, stmt);
}

Corpse* Player::CreateCorpse()
{
    // prevent existence 2 corpse for player
    SpawnCorpseBones();

    uint32 _uf, _pb, _pb2, _cfb1, _cfb2;

    Corpse* corpse = new Corpse((m_ExtraFlags & PLAYER_EXTRA_PVP_DEATH) ? CORPSE_RESURRECTABLE_PVP : CORPSE_RESURRECTABLE_PVE);
    SetPvPDeath(false);

    if (!corpse->Create(GetMap()->GenerateLowGuid<HighGuid::Corpse>(), this))
    {
        delete corpse;
        return nullptr;
    }

    _corpseLocation.WorldRelocate(*this);

    _uf = getRace();
    _pb = GetUInt32Value(PLAYER_BYTES);
    _pb2 = GetUInt32Value(PLAYER_BYTES_2);

    uint8 race       = (uint8)(_uf);
    uint8 skin       = (uint8)(_pb);
    uint8 face       = (uint8)(_pb >> 8);
    uint8 hairstyle  = (uint8)(_pb >> 16);
    uint8 haircolor  = (uint8)(_pb >> 24);
    uint8 facialhair = (uint8)(_pb2);

    _cfb1 = ((0x00) | (race << 8) | (GetByteValue(PLAYER_BYTES_3, 0) << 16) | (skin << 24));
    _cfb2 = ((face) | (hairstyle << 8) | (haircolor << 16) | (facialhair << 24));

    corpse->SetUInt32Value(CORPSE_FIELD_BYTES_1, _cfb1);
    corpse->SetUInt32Value(CORPSE_FIELD_BYTES_2, _cfb2);

    uint32 flags = CORPSE_FLAG_UNK2;
    if (HasPlayerFlag(PLAYER_FLAGS_HIDE_HELM))
        flags |= CORPSE_FLAG_HIDE_HELM;
    if (HasPlayerFlag(PLAYER_FLAGS_HIDE_CLOAK))
        flags |= CORPSE_FLAG_HIDE_CLOAK;

    // Xinef: Player can loop corpses while in BG or in WG
    if (InBattleground() && !InArena())
        flags |= CORPSE_FLAG_LOOTABLE;
    Battlefield* Bf = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
    if (Bf && Bf->IsWarTime())
        flags |= CORPSE_FLAG_LOOTABLE;

    corpse->SetUInt32Value(CORPSE_FIELD_FLAGS, flags);

    corpse->SetUInt32Value(CORPSE_FIELD_DISPLAY_ID, GetNativeDisplayId());

    corpse->SetUInt32Value(CORPSE_FIELD_GUILD, GetGuildId());

    uint32 iDisplayID;
    uint32 iIventoryType;
    uint32 _cfi;
    for (uint8 i = 0; i < EQUIPMENT_SLOT_END; i++)
    {
        if (m_items[i])
        {
            iDisplayID = m_items[i]->GetTemplate()->DisplayInfoID;
            iIventoryType = m_items[i]->GetTemplate()->InventoryType;

            _cfi = iDisplayID | (iIventoryType << 24);
            corpse->SetUInt32Value(CORPSE_FIELD_ITEM + i, _cfi);
        }
    }

    // register for player, but not show
    GetMap()->AddCorpse(corpse);

    UpdatePositionData();

    // we do not need to save corpses for BG/arenas
    if (!GetMap()->IsBattlegroundOrArena())
        corpse->SaveToDB();

    return corpse;
}

void Player::RemoveCorpse()
{
    if (GetCorpse())
    {
        GetCorpse()->RemoveFromWorld();
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    Corpse::DeleteFromDB(GetGUID(), trans);
    CharacterDatabase.CommitTransaction(trans);

    _corpseLocation.WorldRelocate();
}

void Player::SpawnCorpseBones(bool triggerSave /*= true*/)
{
    _corpseLocation.WorldRelocate();
    if (GetMap()->ConvertCorpseToBones(GetGUID()))
        if (triggerSave && !GetSession()->PlayerLogoutWithSave())   // at logout we will already store the player
        {
            // prevent loading as ghost without corpse
            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

            // pussywizard: update only ghost flag instead of whole character table entry! data integrity is crucial
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_REMOVE_GHOST);
            stmt->SetData(0, GetGUID().GetCounter());
            trans->Append(stmt);

            _SaveAuras(trans, false);

            CharacterDatabase.CommitTransaction(trans);
        }
}

Corpse* Player::GetCorpse() const
{
    return GetMap()->GetCorpseByPlayer(GetGUID());
}

void Player::SendDurabilityLoss()
{
    SendDirectMessage(WorldPackets::Misc::DurabilityDamageDeath().Write());
}

void Player::DurabilityLossAll(double percent, bool inventory)
{
    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            DurabilityLoss(pItem, percent);

    if (inventory)
    {
        // bags not have durability
        // for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)

        for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
            if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                DurabilityLoss(pItem, percent);

        // keys not have durability
        //for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)

        for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
            if (Bag* pBag = GetBagByPos(i))
                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                    if (Item* pItem = GetItemByPos(i, j))
                        DurabilityLoss(pItem, percent);
    }
}

void Player::DurabilityLoss(Item* item, double percent)
{
    if (!item || percent == 0.0)
        return;

    uint32 pMaxDurability = item ->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);

    if (!pMaxDurability)
        return;

    uint32 pDurabilityLoss = uint32(pMaxDurability * percent);

    if (pDurabilityLoss < 1)
        pDurabilityLoss = 1;

    DurabilityPointsLoss(item, pDurabilityLoss);
}

void Player::DurabilityPointsLossAll(int32 points, bool inventory)
{
    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            DurabilityPointsLoss(pItem, points);

    if (inventory)
    {
        // bags not have durability
        // for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)

        for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
            if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                DurabilityPointsLoss(pItem, points);

        // keys not have durability
        //for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)

        for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
            if (Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                    if (Item* pItem = GetItemByPos(i, j))
                        DurabilityPointsLoss(pItem, points);
    }
}

void Player::DurabilityPointsLoss(Item* item, int32 points)
{
    if (HasAuraType(SPELL_AURA_PREVENT_DURABILITY_LOSS))
    {
        return;
    }

    int32 pMaxDurability = item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);
    int32 pOldDurability = item->GetUInt32Value(ITEM_FIELD_DURABILITY);
    int32 pNewDurability = pOldDurability - points;

    if (pNewDurability < 0)
        pNewDurability = 0;
    else if (pNewDurability > pMaxDurability)
        pNewDurability = pMaxDurability;

    if (pOldDurability != pNewDurability)
    {
        // modify item stats _before_ Durability set to 0 to pass _ApplyItemMods internal check
        if (pNewDurability == 0 && pOldDurability > 0 && item->IsEquipped())
            _ApplyItemMods(item, item->GetSlot(), false);

        item->SetUInt32Value(ITEM_FIELD_DURABILITY, pNewDurability);

        // modify item stats _after_ restore durability to pass _ApplyItemMods internal check
        if (pNewDurability > 0 && pOldDurability == 0 && item->IsEquipped())
            _ApplyItemMods(item, item->GetSlot(), true);

        item->SetState(ITEM_CHANGED, this);
    }
}

void Player::DurabilityPointLossForEquipSlot(EquipmentSlots slot)
{
    if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
        DurabilityPointsLoss(pItem, 1);
}

uint32 Player::DurabilityRepairAll(bool cost, float discountMod, bool guildBank)
{
    uint32 TotalCost = 0;
    // equipped, backpack, bags itself
    for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
        TotalCost += DurabilityRepair(((INVENTORY_SLOT_BAG_0 << 8) | i), cost, discountMod, guildBank);

    // bank, buyback and keys not repaired

    // items in inventory bags
    for (uint8 j = INVENTORY_SLOT_BAG_START; j < INVENTORY_SLOT_BAG_END; j++)
        for (uint8 i = 0; i < MAX_BAG_SIZE; i++)
            TotalCost += DurabilityRepair(((j << 8) | i), cost, discountMod, guildBank);
    return TotalCost;
}

uint32 Player::DurabilityRepair(uint16 pos, bool cost, float discountMod, bool guildBank)
{
    Item* item = GetItemByPos(pos);

    uint32 TotalCost = 0;
    if (!item)
        return TotalCost;

    uint32 maxDurability = item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);
    if (!maxDurability)
        return TotalCost;

    uint32 curDurability = item->GetUInt32Value(ITEM_FIELD_DURABILITY);

    if (cost)
    {
        uint32 LostDurability = maxDurability - curDurability;
        if (LostDurability > 0)
        {
            ItemTemplate const* ditemProto = item->GetTemplate();

            DurabilityCostsEntry const* dcost = sDurabilityCostsStore.LookupEntry(ditemProto->ItemLevel);
            if (!dcost)
            {
                LOG_ERROR("entities.player", "RepairDurability: Wrong item lvl {}", ditemProto->ItemLevel);
                return TotalCost;
            }

            uint32 dQualitymodEntryId = (ditemProto->Quality + 1) * 2;
            DurabilityQualityEntry const* dQualitymodEntry = sDurabilityQualityStore.LookupEntry(dQualitymodEntryId);
            if (!dQualitymodEntry)
            {
                LOG_ERROR("entities.player", "RepairDurability: Wrong dQualityModEntry {}", dQualitymodEntryId);
                return TotalCost;
            }

            uint32 dmultiplier = dcost->multiplier[ItemSubClassToDurabilityMultiplierId(ditemProto->Class, ditemProto->SubClass)];
            uint32 costs = uint32(LostDurability * dmultiplier * double(dQualitymodEntry->quality_mod));

            costs = uint32(costs * discountMod * sWorld->getRate(RATE_REPAIRCOST));

            if (costs == 0)                                   //fix for ITEM_QUALITY_ARTIFACT
                costs = 1;

            if (guildBank)
            {
                if (GetGuildId() == 0)
                {
                    // LOG_DEBUG("entities.player", "You are not member of a guild");
                    return TotalCost;
                }

                Guild* guild = sGuildMgr->GetGuildById(GetGuildId());
                if (!guild)
                    return TotalCost;

                if (!guild->HandleMemberWithdrawMoney(GetSession(), costs, true))
                    return TotalCost;

                TotalCost = costs;
            }
            else if (!HasEnoughMoney(costs))
            {
                // LOG_DEBUG("entities.player", "You do not have enough money");
                return TotalCost;
            }
            else
                ModifyMoney(-int32(costs));
        }
    }

    item->SetUInt32Value(ITEM_FIELD_DURABILITY, maxDurability);
    item->SetState(ITEM_CHANGED, this);

    // reapply mods for total broken and repaired item if equipped
    if (IsEquipmentPos(pos) && !curDurability)
        _ApplyItemMods(item, pos & 255, true);
    return TotalCost;
}

void Player::RepopAtGraveyard()
{
    // note: this can be called also when the player is alive
    // for example from WorldSession::HandleMovementOpcodes

    AreaTableEntry const* zone = sAreaTableStore.LookupEntry(GetAreaId());

    if (!sScriptMgr->CanRepopAtGraveyard(this))
        return;

    // Such zones are considered unreachable as a ghost and the player must be automatically revived
    // Xinef: Get Transport Check is not needed
    if ((!IsAlive() && zone && zone->flags & AREA_FLAG_NEED_FLY) /*|| GetTransport()*/ || GetPositionZ() < GetMap()->GetMinHeight(GetPositionX(), GetPositionY()))
    {
        ResurrectPlayer(0.5f);
        SpawnCorpseBones();
    }

    GraveyardStruct const* ClosestGrave = nullptr;

    // Special handle for battleground maps
    if (Battleground* bg = GetBattleground())
        ClosestGrave = bg->GetClosestGraveyard(this);
    else
    {
        if (sBattlefieldMgr->GetBattlefieldToZoneId(GetZoneId()))
            ClosestGrave = sBattlefieldMgr->GetBattlefieldToZoneId(GetZoneId())->GetClosestGraveyard(this);
        else
            ClosestGrave = sGraveyard->GetClosestGraveyard(this, GetTeamId());
    }

    // stop countdown until repop
    m_deathTimer = 0;

    // if no grave found, stay at the current location
    // and don't show spirit healer location
    if (ClosestGrave)
    {
        TeleportTo(ClosestGrave->Map, ClosestGrave->x, ClosestGrave->y, ClosestGrave->z, GetOrientation());
        if (isDead())                                        // not send if alive, because it used in TeleportTo()
        {
            WorldPacket data(SMSG_DEATH_RELEASE_LOC, 4 * 4); // show spirit healer position on minimap
            data << ClosestGrave->Map;
            data << ClosestGrave->x;
            data << ClosestGrave->y;
            data << ClosestGrave->z;
            GetSession()->SendPacket(&data);
        }
    }
    else if (GetPositionZ() < GetMap()->GetMinHeight(GetPositionX(), GetPositionY()))
        TeleportTo(m_homebindMapId, m_homebindX, m_homebindY, m_homebindZ, GetOrientation());

    RemovePlayerFlag(PLAYER_FLAGS_IS_OUT_OF_BOUNDS);
}

bool Player::CanJoinConstantChannelInZone(ChatChannelsEntry const* channel, AreaTableEntry const* zone)
{
    // Player can join LFG anywhere
    if (channel->flags & CHANNEL_DBC_FLAG_LFG && sWorld->getBoolConfig(CONFIG_LFG_LOCATION_ALL))
        return true;

    if (channel->flags & CHANNEL_DBC_FLAG_ZONE_DEP && zone->flags & AREA_FLAG_ARENA_INSTANCE)
        return false;

    if ((channel->flags & CHANNEL_DBC_FLAG_CITY_ONLY) && (!(zone->flags & AREA_FLAG_SLAVE_CAPITAL)))
        return false;

    if ((channel->flags & CHANNEL_DBC_FLAG_GUILD_REQ) && GetGuildId())
        return false;

    return true;
}

void Player::JoinedChannel(Channel* c)
{
    m_channels.push_back(c);
}

void Player::LeftChannel(Channel* c)
{
    m_channels.remove(c);
}

void Player::CleanupChannels()
{
    while (!m_channels.empty())
    {
        Channel* ch = *m_channels.begin();
        m_channels.erase(m_channels.begin());               // remove from player's channel list
        ch->LeaveChannel(this, false);                     // not send to client, not remove from player's channel list
    }
}

void Player::ClearChannelWatch()
{
    for (JoinedChannelsList::iterator itr = m_channels.begin(); itr != m_channels.end(); ++itr)
        (*itr)->RemoveWatching(this);
}

void Player::HandleBaseModValue(BaseModGroup modGroup, BaseModType modType, float amount, bool apply)
{
    if (modGroup >= BASEMOD_END)
    {
        LOG_ERROR("entities.player", "ERROR in HandleBaseModValue(): non existed BaseModGroup!");
        return;
    }

    switch (modType)
    {
        case FLAT_MOD:
            m_auraBaseMod[modGroup][modType] += apply ? amount : -amount;
            break;
        case PCT_MOD:
            ApplyPercentModFloatVar(m_auraBaseMod[modGroup][modType], amount, apply);
            break;
    }

    if (!CanModifyStats())
        return;

    switch (modGroup)
    {
        case CRIT_PERCENTAGE:
            UpdateCritPercentage(BASE_ATTACK);
            break;
        case RANGED_CRIT_PERCENTAGE:
            UpdateCritPercentage(RANGED_ATTACK);
            break;
        case OFFHAND_CRIT_PERCENTAGE:
            UpdateCritPercentage(OFF_ATTACK);
            break;
        case SHIELD_BLOCK_VALUE:
            UpdateShieldBlockValue();
            break;
        default:
            break;
    }
}

float Player::GetBaseModValue(BaseModGroup modGroup, BaseModType modType) const
{
    if (modGroup >= BASEMOD_END)
    {
        LOG_ERROR("entities.player", "trial to access non existed BaseModGroup!");
        return 0.0f;
    }

    if (modType == PCT_MOD && m_auraBaseMod[modGroup][PCT_MOD] <= 0.0f)
        return 0.0f;

    return m_auraBaseMod[modGroup][modType];
}

float Player::GetTotalBaseModValue(BaseModGroup modGroup) const
{
    if (modGroup >= BASEMOD_END)
    {
        LOG_ERROR("entities.player", "wrong BaseModGroup in GetTotalBaseModValue()!");
        return 0.0f;
    }

    if (m_auraBaseMod[modGroup][PCT_MOD] <= 0.0f)
        return 0.0f;

    return m_auraBaseMod[modGroup][FLAT_MOD] * m_auraBaseMod[modGroup][PCT_MOD];
}

uint32 Player::GetShieldBlockValue() const
{
    float value = (m_auraBaseMod[SHIELD_BLOCK_VALUE][FLAT_MOD] + GetStat(STAT_STRENGTH) * 0.5f - 10) * m_auraBaseMod[SHIELD_BLOCK_VALUE][PCT_MOD];

    value = (value < 0) ? 0 : value;

    return uint32(value);
}

float Player::GetMeleeCritFromAgility()
{
    uint8 level = GetLevel();
    uint32 pclass = getClass();

    if (level > GT_MAX_LEVEL)
        level = GT_MAX_LEVEL;

    GtChanceToMeleeCritBaseEntry const* critBase  = sGtChanceToMeleeCritBaseStore.LookupEntry(pclass - 1);
    GtChanceToMeleeCritEntry     const* critRatio = sGtChanceToMeleeCritStore.LookupEntry((pclass - 1) * GT_MAX_LEVEL + level - 1);
    if (!critBase || !critRatio)
        return 0.0f;

    float crit = critBase->base + GetStat(STAT_AGILITY) * critRatio->ratio;
    return crit * 100.0f;
}

void Player::GetDodgeFromAgility(float& diminishing, float& nondiminishing)
{
    // Table for base dodge values
    const float dodge_base[MAX_CLASSES] =
    {
        0.036640f, // Warrior
        0.034943f, // Paladi
        -0.040873f, // Hunter
        0.020957f, // Rogue
        0.034178f, // Priest
        0.036640f, // DK
        0.021080f, // Shaman
        0.036587f, // Mage
        0.024211f, // Warlock
        0.0f,      // ??
        0.056097f  // Druid
    };
    // Crit/agility to dodge/agility coefficient multipliers; 3.2.0 increased required agility by 15%
    const float crit_to_dodge[MAX_CLASSES] =
    {
        0.85f / 1.15f,  // Warrior
        1.00f / 1.15f,  // Paladin
        1.11f / 1.15f,  // Hunter
        2.00f / 1.15f,  // Rogue
        1.00f / 1.15f,  // Priest
        0.85f / 1.15f,  // DK
        1.60f / 1.15f,  // Shaman
        1.00f / 1.15f,  // Mage
        0.97f / 1.15f,  // Warlock (?)
        0.0f,           // ??
        2.00f / 1.15f   // Druid
    };

    uint8 level = GetLevel();
    uint32 pclass = getClass();

    if (level > GT_MAX_LEVEL)
        level = GT_MAX_LEVEL;

    // Dodge per agility is proportional to crit per agility, which is available from DBC files
    GtChanceToMeleeCritEntry  const* dodgeRatio = sGtChanceToMeleeCritStore.LookupEntry((pclass - 1) * GT_MAX_LEVEL + level - 1);
    if (!dodgeRatio || pclass > MAX_CLASSES)
        return;

    /// @todo: research if talents/effects that increase total agility by x% should increase non-diminishing part
    float base_agility = GetCreateStat(STAT_AGILITY) * m_auraModifiersGroup[UNIT_MOD_STAT_START + static_cast<uint16>(STAT_AGILITY)][BASE_PCT];
    float bonus_agility = GetStat(STAT_AGILITY) - base_agility;

    // calculate diminishing (green in char screen) and non-diminishing (white) contribution
    diminishing = 100.0f * bonus_agility * dodgeRatio->ratio * crit_to_dodge[pclass - 1];
    nondiminishing = 100.0f * (dodge_base[pclass - 1] + base_agility * dodgeRatio->ratio * crit_to_dodge[pclass - 1]);
}

float Player::GetSpellCritFromIntellect()
{
    uint8 level = GetLevel();
    uint32 pclass = getClass();

    if (level > GT_MAX_LEVEL)
        level = GT_MAX_LEVEL;

    GtChanceToSpellCritBaseEntry const* critBase  = sGtChanceToSpellCritBaseStore.LookupEntry(pclass - 1);
    GtChanceToSpellCritEntry     const* critRatio = sGtChanceToSpellCritStore.LookupEntry((pclass - 1) * GT_MAX_LEVEL + level - 1);
    if (!critBase || !critRatio)
        return 0.0f;

    float crit = critBase->base + GetStat(STAT_INTELLECT) * critRatio->ratio;
    return crit * 100.0f;
}

float Player::GetRatingMultiplier(CombatRating cr) const
{
    uint8 level = GetLevel();

    if (level > GT_MAX_LEVEL)
        level = GT_MAX_LEVEL;

    GtCombatRatingsEntry const* Rating = sGtCombatRatingsStore.LookupEntry(cr * GT_MAX_LEVEL + level - 1);
    // gtOCTClassCombatRatingScalarStore.dbc starts with 1, CombatRating with zero, so cr+1
    GtOCTClassCombatRatingScalarEntry const* classRating = sGtOCTClassCombatRatingScalarStore.LookupEntry((getClass() - 1) * GT_MAX_RATING + cr + 1);
    if (!Rating || !classRating)
        return 1.0f;                                        // By default use minimum coefficient (not must be called)

    return classRating->ratio / Rating->ratio;
}

float Player::GetRatingBonusValue(CombatRating cr) const
{
    return float(GetUInt32Value(static_cast<uint16>(PLAYER_FIELD_COMBAT_RATING_1) + cr)) * GetRatingMultiplier(cr);
}

float Player::GetExpertiseDodgeOrParryReduction(WeaponAttackType attType) const
{
    switch (attType)
    {
        case BASE_ATTACK:
            return GetUInt32Value(PLAYER_EXPERTISE) / 4.0f;
        case OFF_ATTACK:
            return GetUInt32Value(PLAYER_OFFHAND_EXPERTISE) / 4.0f;
        default:
            break;
    }
    return 0.0f;
}

float Player::OCTRegenHPPerSpirit()
{
    uint8 level = GetLevel();
    uint32 pclass = getClass();

    if (level > GT_MAX_LEVEL)
        level = GT_MAX_LEVEL;

    GtOCTRegenHPEntry     const* baseRatio = sGtOCTRegenHPStore.LookupEntry((pclass - 1) * GT_MAX_LEVEL + level - 1);
    GtRegenHPPerSptEntry  const* moreRatio = sGtRegenHPPerSptStore.LookupEntry((pclass - 1) * GT_MAX_LEVEL + level - 1);
    if (!baseRatio || !moreRatio)
        return 0.0f;

    // Formula from PaperDollFrame script
    float spirit = GetStat(STAT_SPIRIT);
    float baseSpirit = spirit;
    if (baseSpirit > 50)
        baseSpirit = 50;
    float moreSpirit = spirit - baseSpirit;
    float regen = (baseSpirit * baseRatio->ratio + moreSpirit * moreRatio->ratio) * 2;
    return regen;
}

float Player::OCTRegenMPPerSpirit()
{
    uint8 level = GetLevel();
    uint32 pclass = getClass();

    if (level > GT_MAX_LEVEL)
        level = GT_MAX_LEVEL;

    //    GtOCTRegenMPEntry     const* baseRatio = sGtOCTRegenMPStore.LookupEntry((pclass-1)*GT_MAX_LEVEL + level-1);
    GtRegenMPPerSptEntry  const* moreRatio = sGtRegenMPPerSptStore.LookupEntry((pclass - 1) * GT_MAX_LEVEL + level - 1);
    if (!moreRatio)
        return 0.0f;

    // Formula get from PaperDollFrame script
    float spirit    = GetStat(STAT_SPIRIT);
    float regen     = spirit * moreRatio->ratio;
    return regen;
}

void Player::ApplyRatingMod(CombatRating cr, int32 value, bool apply)
{
    float oldRating = m_baseRatingValue[cr];
    m_baseRatingValue[cr] += (apply ? value : -value);
    // explicit affected values
    if (cr == CR_HASTE_MELEE || cr == CR_HASTE_RANGED || cr == CR_HASTE_SPELL)
    {
        float const mult = GetRatingMultiplier(cr);
        float const oldVal = oldRating * mult;
        float const newVal = m_baseRatingValue[cr] * mult;
        switch (cr)
        {
            case CR_HASTE_MELEE:
                ApplyAttackTimePercentMod(BASE_ATTACK, oldVal, false);
                ApplyAttackTimePercentMod(OFF_ATTACK, oldVal, false);
                ApplyAttackTimePercentMod(BASE_ATTACK, newVal, true);
                ApplyAttackTimePercentMod(OFF_ATTACK, newVal, true);
                break;
            case CR_HASTE_RANGED:
                ApplyAttackTimePercentMod(RANGED_ATTACK, oldVal, false);
                ApplyAttackTimePercentMod(RANGED_ATTACK, newVal, true);
                break;
            case CR_HASTE_SPELL:
                ApplyCastTimePercentMod(oldVal, false);
                ApplyCastTimePercentMod(newVal, true);
                break;
            default:
                break;
        }
    }

    UpdateRating(cr);
}

void Player::SetRegularAttackTime()
{
    for (uint8 i = 0; i < MAX_ATTACK; ++i)
    {
        Item* tmpitem = GetWeaponForAttack(WeaponAttackType(i), true);
        if (tmpitem && !tmpitem->IsBroken())
        {
            ItemTemplate const* proto = tmpitem->GetTemplate();
            if (proto->Delay)
                SetAttackTime(WeaponAttackType(i), proto->Delay);
        }
        else
            SetAttackTime(WeaponAttackType(i), BASE_ATTACK_TIME);  // If there is no weapon reset attack time to base (might have been changed from forms)
    }
}

void Player::ModifySkillBonus(uint32 skillid, int32 val, bool talent)
{
    SkillStatusMap::const_iterator itr = mSkillStatus.find(skillid);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return;

    uint32 bonusIndex = PLAYER_SKILL_BONUS_INDEX(itr->second.pos);

    uint32 bonus_val = GetUInt32Value(bonusIndex);
    int16 temp_bonus = SKILL_TEMP_BONUS(bonus_val);
    int16 perm_bonus = SKILL_PERM_BONUS(bonus_val);

    if (talent)                                          // permanent bonus stored in high part
        SetUInt32Value(bonusIndex, MAKE_SKILL_BONUS(temp_bonus, perm_bonus + val));
    else                                                // temporary/item bonus stored in low part
        SetUInt32Value(bonusIndex, MAKE_SKILL_BONUS(temp_bonus + val, perm_bonus));
}

// This functions sets a skill line value (and adds if doesn't exist yet)
// To "remove" a skill line, set it's values to zero
void Player::SetSkill(uint16 id, uint16 step, uint16 newVal, uint16 maxVal)
{
    if (!id)
        return;

    uint16 currVal;
    SkillStatusMap::iterator itr = mSkillStatus.find(id);

    //has skill
    if (itr != mSkillStatus.end() && itr->second.uState != SKILL_DELETED)
    {
        currVal = SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos)));
        if (newVal)
        {
            // if skill value is going down, update enchantments before setting the new value
            if (newVal < currVal)
                UpdateSkillEnchantments(id, currVal, newVal);
            // update step
            SetUInt32Value(PLAYER_SKILL_INDEX(itr->second.pos), MAKE_PAIR32(id, step));
            // update value
            SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos), MAKE_SKILL_VALUE(newVal, maxVal));
            if (itr->second.uState != SKILL_NEW)
                itr->second.uState = SKILL_CHANGED;
            learnSkillRewardedSpells(id, newVal);
            // if skill value is going up, update enchantments after setting the new value
            if (newVal > currVal)
                UpdateSkillEnchantments(id, currVal, newVal);
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL, id);
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LEVEL, id);
        }
        else                                                //remove
        {
            //remove enchantments needing this skill
            UpdateSkillEnchantments(id, currVal, 0);
            // clear skill fields
            SetUInt32Value(PLAYER_SKILL_INDEX(itr->second.pos), 0);
            SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos), 0);
            SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos), 0);

            // mark as deleted or simply remove from map if not saved yet
            if (itr->second.uState != SKILL_NEW)
                itr->second.uState = SKILL_DELETED;
            else
                mSkillStatus.erase(itr);

            // remove all spells that related to this skill
            for (SkillLineAbilityEntry const* pAbility : GetSkillLineAbilitiesBySkillLine(id))
                removeSpell(sSpellMgr->GetFirstSpellInChain(pAbility->Spell), SPEC_MASK_ALL, false);
        }
    }
    else if (newVal)                                        //add
    {
        currVal = 0;
        for (int i = 0; i < PLAYER_MAX_SKILLS; ++i)
            if (!GetUInt32Value(PLAYER_SKILL_INDEX(i)))
            {
                SkillLineEntry const* pSkill = sSkillLineStore.LookupEntry(id);
                if (!pSkill)
                {
                    LOG_ERROR("entities.player", "Skill not found in SkillLineStore: skill #{}", id);
                    return;
                }

                SetUInt32Value(PLAYER_SKILL_INDEX(i), MAKE_PAIR32(id, step));
                SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i), MAKE_SKILL_VALUE(newVal, maxVal));
                UpdateSkillEnchantments(id, currVal, newVal);

                // insert new entry or update if not deleted old entry yet
                if (itr != mSkillStatus.end())
                {
                    itr->second.pos = i;
                    itr->second.uState = SKILL_CHANGED;
                }
                else
                    mSkillStatus.insert(SkillStatusMap::value_type(id, SkillStatusData(i, SKILL_NEW)));

                // apply skill bonuses
                SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i), 0);

                // temporary bonuses
                AuraEffectList const& mModSkill = GetAuraEffectsByType(SPELL_AURA_MOD_SKILL);
                for (AuraEffectList::const_iterator j = mModSkill.begin(); j != mModSkill.end(); ++j)
                    if ((*j)->GetMiscValue() == int32(id))
                        (*j)->HandleEffect(this, AURA_EFFECT_HANDLE_SKILL, true);

                // permanent bonuses
                AuraEffectList const& mModSkillTalent = GetAuraEffectsByType(SPELL_AURA_MOD_SKILL_TALENT);
                for (AuraEffectList::const_iterator j = mModSkillTalent.begin(); j != mModSkillTalent.end(); ++j)
                    if ((*j)->GetMiscValue() == int32(id))
                        (*j)->HandleEffect(this, AURA_EFFECT_HANDLE_SKILL, true);

                // Learn all spells for skill
                learnSkillRewardedSpells(id, newVal);
                UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL, id);
                UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LEVEL, id);
                return;
            }
    }
}

bool Player::HasSkill(uint32 skill) const
{
    if (!skill)
        return false;

    SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
    return (itr != mSkillStatus.end() && itr->second.uState != SKILL_DELETED);
}

uint16 Player::GetSkillStep(uint16 skill) const
{
    if (!skill)
        return 0;

    SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return 0;

    return PAIR32_HIPART(GetUInt32Value(PLAYER_SKILL_INDEX(itr->second.pos)));
}

uint16 Player::GetSkillValue(uint32 skill) const
{
    if (!skill)
        return 0;

    SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return 0;

    uint32 bonus = GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos));

    int32 result = int32(SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos))));
    result += SKILL_TEMP_BONUS(bonus);
    result += SKILL_PERM_BONUS(bonus);
    return result < 0 ? 0 : result;
}

uint16 Player::GetMaxSkillValue(uint32 skill) const
{
    if (!skill)
        return 0;

    SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return 0;

    uint32 bonus = GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos));

    int32 result = int32(SKILL_MAX(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos))));
    sScriptMgr->OnGetMaxSkillValue(const_cast<Player*>(this), skill, result, false);
    result += SKILL_TEMP_BONUS(bonus);
    result += SKILL_PERM_BONUS(bonus);
    return result < 0 ? 0 : result;
}

uint16 Player::GetPureMaxSkillValue(uint32 skill) const
{
    if (!skill)
        return 0;

    SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return 0;

    int32 result = int32(SKILL_MAX(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos))));

    sScriptMgr->OnGetMaxSkillValue(const_cast<Player*>(this), skill, result, true);

    return result < 0 ? 0 : result;
}

uint16 Player::GetBaseSkillValue(uint32 skill) const
{
    if (!skill)
        return 0;

    SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return 0;

    int32 result = int32(SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos))));
    result += SKILL_PERM_BONUS(GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos)));
    return result < 0 ? 0 : result;
}

uint16 Player::GetPureSkillValue(uint32 skill) const
{
    if (!skill)
        return 0;

    SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return 0;

    return SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos)));
}

int16 Player::GetSkillPermBonusValue(uint32 skill) const
{
    if (!skill)
        return 0;

    SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return 0;

    return SKILL_PERM_BONUS(GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos)));
}

int16 Player::GetSkillTempBonusValue(uint32 skill) const
{
    if (!skill)
        return 0;

    SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return 0;

    return SKILL_TEMP_BONUS(GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos)));
}

void Player::SendActionButtons(uint32 state) const
{
    LOG_DEBUG("entities.player", "Sending Action Buttons for {} spec {}", GetGUID().ToString(), m_activeSpec);

    WorldPacket data(SMSG_ACTION_BUTTONS, 1 + (MAX_ACTION_BUTTONS * 4));
    data << uint8(state);
    /*
        state can be 0, 1, 2
        0 - Looks to be sent when initial action buttons get sent, however on Trinity we use 1 since 0 had some difficulties
        1 - Used in any SMSG_ACTION_BUTTONS packet with button data on Trinity. Only used after spec swaps on retail.
        2 - Clears the action bars client sided. This is sent during spec swap before unlearning and before sending the new buttons
    */
    if (state != 2)
    {
        for (uint8 button = 0; button < MAX_ACTION_BUTTONS; ++button)
        {
            ActionButtonList::const_iterator itr = m_actionButtons.find(button);
            if (itr != m_actionButtons.end() && itr->second.uState != ACTIONBUTTON_DELETED)
                data << uint32(itr->second.packedData);
            else
                data << uint32(0);
        }
    }

    GetSession()->SendPacket(&data);
    LOG_DEBUG("entities.player", "Action Buttons for {} spec {} Sent", GetGUID().ToString(), m_activeSpec);
}

bool Player::IsActionButtonDataValid(uint8 button, uint32 action, uint8 type)
{
    if (button >= MAX_ACTION_BUTTONS)
    {
        LOG_ERROR("entities.player", "Action {} not added into button {} for player {}: button must be < {}", action, button, GetName(), MAX_ACTION_BUTTONS);
        return false;
    }

    if (action >= MAX_ACTION_BUTTON_ACTION_VALUE)
    {
        LOG_ERROR("entities.player", "Action {} not added into button {} for player {}: action must be < {}", action, button, GetName(), MAX_ACTION_BUTTON_ACTION_VALUE);
        return false;
    }

    switch (type)
    {
        case ACTION_BUTTON_SPELL:
            if (!sSpellMgr->GetSpellInfo(action))
            {
                LOG_ERROR("entities.player", "Spell action {} not added into button {} for player {}: spell not exist", action, button, GetName());
                return false;
            }

            if (!HasSpell(action))
            {
                LOG_DEBUG("entities.player.loading", "Player::IsActionButtonDataValid Spell action {} not added into button {} for player {}: player don't known this spell", action, button, GetName());
                return false;
            }
            break;
        case ACTION_BUTTON_ITEM:
            if (!sObjectMgr->GetItemTemplate(action))
            {
                LOG_ERROR("entities.player", "Item action {} not added into button {} for player {}: item not exist", action, button, GetName());
                return false;
            }
            break;
        default:
            break;                                          // other cases not checked at this moment
    }

    return true;
}

ActionButton* Player::addActionButton(uint8 button, uint32 action, uint8 type)
{
    if (!IsActionButtonDataValid(button, action, type))
        return nullptr;

    // it create new button (NEW state) if need or return existed
    ActionButton& ab = m_actionButtons[button];

    // set data and update to CHANGED if not NEW
    ab.SetActionAndType(action, ActionButtonType(type));

    LOG_DEBUG("entities.player", "Player {} Added Action {} (type {}) to Button {}", GetGUID().ToString(), action, type, button);
    return &ab;
}

void Player::removeActionButton(uint8 button)
{
    ActionButtonList::iterator buttonItr = m_actionButtons.find(button);
    if (buttonItr == m_actionButtons.end() || buttonItr->second.uState == ACTIONBUTTON_DELETED)
        return;

    if (buttonItr->second.uState == ACTIONBUTTON_NEW)
        m_actionButtons.erase(buttonItr);                   // new and not saved
    else
        buttonItr->second.uState = ACTIONBUTTON_DELETED;    // saved, will deleted at next save

    LOG_DEBUG("entities.player", "Action Button {} Removed from Player {}", button, GetGUID().ToString());
}

ActionButton const* Player::GetActionButton(uint8 button)
{
    ActionButtonList::iterator buttonItr = m_actionButtons.find(button);
    if (buttonItr == m_actionButtons.end() || buttonItr->second.uState == ACTIONBUTTON_DELETED)
        return nullptr;

    return &buttonItr->second;
}

void Player::SaveRecallPosition()
{
    m_recallMap = GetMapId();
    m_recallX = GetPositionX();
    m_recallY = GetPositionY();
    m_recallZ = GetPositionZ();
    m_recallO = GetOrientation();
}

void Player::SendMessageToSet(WorldPacket const* data, bool self) const
{
    SendMessageToSetInRange(data, GetVisibilityRange(), self);
}

void Player::SendMessageToSetInRange(WorldPacket const* data, float dist, bool self) const
{
    if (self)
        SendDirectMessage(data);

    Acore::MessageDistDeliverer notifier(this, data, dist);
    Cell::VisitWorldObjects(this, notifier, dist);
}

void Player::SendMessageToSetInRange(WorldPacket const* data, float dist, bool self, bool includeMargin, bool ownTeamOnly, bool required3dDist) const
{
    if (self)
        SendDirectMessage(data);

    dist += GetObjectSize();
    if (includeMargin)
        dist += VISIBILITY_COMPENSATION; // pussywizard: to ensure everyone receives all important packets

    Acore::MessageDistDeliverer notifier(this, data, dist, ownTeamOnly, nullptr, required3dDist);
    Cell::VisitWorldObjects(this, notifier, dist);
}

void Player::SendMessageToSet(WorldPacket const* data, Player const* skipped_rcvr) const
{
    if (skipped_rcvr != this)
        SendDirectMessage(data);

    Acore::MessageDistDeliverer notifier(this, data, GetVisibilityRange(), false, skipped_rcvr);
    Cell::VisitWorldObjects(this, notifier, GetVisibilityRange());
}

void Player::SendDirectMessage(WorldPacket const* data) const
{
    m_session->SendPacket(data);
}

void Player::SendCinematicStart(uint32 CinematicSequenceId) const
{
    WorldPacket data(SMSG_TRIGGER_CINEMATIC, 4);
    data << uint32(CinematicSequenceId);
    SendDirectMessage(&data);
    if (CinematicSequencesEntry const* sequence = sCinematicSequencesStore.LookupEntry(CinematicSequenceId))
    {
        _cinematicMgr->SetActiveCinematicCamera(sequence->cinematicCamera);
    }
}

void Player::SendMovieStart(uint32 MovieId)
{
    WorldPacket data(SMSG_TRIGGER_MOVIE, 4);
    data << uint32(MovieId);
    SendDirectMessage(&data);
}

void Player::CheckAreaExploreAndOutdoor()
{
    if (!IsAlive())
        return;

    if (IsInFlight())
        return;

    bool isOutdoor = IsOutdoors();
    uint32 areaId = GetAreaId();
    AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(areaId);

    if (sWorld->getBoolConfig(CONFIG_VMAP_INDOOR_CHECK) && _wasOutdoor != isOutdoor)
    {
        _wasOutdoor = isOutdoor;

        SpellAttr0 attrToRemove = isOutdoor ? SPELL_ATTR0_ONLY_INDOORS : SPELL_ATTR0_ONLY_OUTDOORS;
        SpellAttr0 attrToRecalculate = isOutdoor ? SPELL_ATTR0_ONLY_OUTDOORS : SPELL_ATTR0_ONLY_INDOORS;
        for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
        {
            Aura* aura = iter->second->GetBase();
            SpellInfo const* spell = aura->GetSpellInfo();
            if (spell->Attributes & attrToRemove)
            {
                // if passive - do not remove and just turn off all effects
                if (aura->IsPassive())
                {
                    aura->HandleAllEffects(iter->second, AURA_EFFECT_HANDLE_REAL, false);
                    ++iter;
                    continue;
                }

                RemoveAura(iter);
            }
            else if ((spell->Attributes & attrToRecalculate) && aura->IsPassive())
            {
                // if passive - turn on all effects
                aura->HandleAllEffects(iter->second, AURA_EFFECT_HANDLE_REAL, true);
                ++iter;
            }
            else
            {
                ++iter;
            }
        }
    }

    if (!sScriptMgr->CanAreaExploreAndOutdoor(this))
        return;

    if (!areaId)
        return;

    if (!areaEntry)
    {
        LOG_ERROR("entities.player", "Player '{}' ({}) discovered unknown area (x: {} y: {} z: {} map: {})",
                       GetName(), GetGUID().ToString(), GetPositionX(), GetPositionY(), GetPositionZ(), GetMapId());
        return;
    }

    uint32 offset = areaEntry->exploreFlag / 32;

    if (offset >= PLAYER_EXPLORED_ZONES_SIZE)
    {
        LOG_ERROR("entities.player", "Wrong area flag {} in map data for (X: {} Y: {}) point to field PLAYER_EXPLORED_ZONES_1 + {} ( {} must be < {} ).", areaEntry->flags, GetPositionX(), GetPositionY(), offset, offset, PLAYER_EXPLORED_ZONES_SIZE);
        return;
    }

    uint32 val = (uint32)(1 << (areaEntry->exploreFlag % 32));
    uint32 currFields = GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset);

    if (!(currFields & val))
    {
        SetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset, (uint32)(currFields | val));

        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EXPLORE_AREA, areaId);

        if (areaEntry->area_level > 0)
        {
            if (GetLevel() >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            {
                SendExplorationExperience(areaId, 0);
            }
            else
            {
                int32 diff = int32(GetLevel()) - areaEntry->area_level;
                uint32 XP = 0;
                if (diff < -5)
                {
                    XP = uint32(sObjectMgr->GetBaseXP(GetLevel() + 5) * sWorld->getRate(RATE_XP_EXPLORE));
                }
                else if (diff > 5)
                {
                    int32 exploration_percent = (100 - ((diff - 5) * 5));
                    if (exploration_percent > 100)
                        exploration_percent = 100;
                    else if (exploration_percent < 0)
                        exploration_percent = 0;

                    XP = uint32(sObjectMgr->GetBaseXP(areaEntry->area_level) * exploration_percent / 100 * sWorld->getRate(RATE_XP_EXPLORE));
                }
                else
                {
                    XP = uint32(sObjectMgr->GetBaseXP(areaEntry->area_level) * sWorld->getRate(RATE_XP_EXPLORE));
                }

                sScriptMgr->OnGivePlayerXP(this, XP, nullptr, PlayerXPSource::XPSOURCE_EXPLORE);
                GiveXP(XP, nullptr);
                SendExplorationExperience(areaId, XP);
            }
            LOG_DEBUG("entities.player", "Player {} discovered a new area: {}", GetGUID().ToString(), areaId);
        }
    }
}

TeamId Player::TeamIdForRace(uint8 race)
{
    if (ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(race))
    {
        switch (rEntry->TeamID)
        {
            case 1:
                return TEAM_HORDE;
            case 7:
                return TEAM_ALLIANCE;
        }
        LOG_ERROR("entities.player", "Race ({}) has wrong teamid ({}) in DBC: wrong DBC files?", uint32(race), rEntry->TeamID);
    }
    else
        LOG_ERROR("entities.player", "Race ({}) not found in DBC: wrong DBC files?", uint32(race));

    return TEAM_ALLIANCE;
}

void Player::SetFactionForRace(uint8 race)
{
    m_team = TeamIdForRace(race);

    sScriptMgr->OnPlayerUpdateFaction(this);

    if (GetTeamId(true) != GetTeamId())
        return;

    ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(race);
    SetFaction(rEntry ? rEntry->FactionID : 0);
}

ReputationRank Player::GetReputationRank(uint32 faction) const
{
    FactionEntry const* factionEntry = sFactionStore.LookupEntry(faction);
    return GetReputationMgr().GetRank(factionEntry);
}

// Calculate total reputation percent player gain with quest/creature level
float Player::CalculateReputationGain(ReputationSource source, uint32 creatureOrQuestLevel, float rep, int32 faction, bool noQuestBonus)
{
    float percent = 100.0f;

    float repMod = noQuestBonus ? 0.0f : float(GetTotalAuraModifier(SPELL_AURA_MOD_REPUTATION_GAIN));

    // faction specific auras only seem to apply to kills
    if (source == REPUTATION_SOURCE_KILL)
        repMod += GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_FACTION_REPUTATION_GAIN, faction);

    percent += rep > 0.f ? repMod : -repMod;

    float rate;
    switch (source)
    {
        case REPUTATION_SOURCE_KILL:
            rate = sWorld->getRate(RATE_REPUTATION_LOWLEVEL_KILL);
            break;
        case REPUTATION_SOURCE_QUEST:
        case REPUTATION_SOURCE_DAILY_QUEST:
        case REPUTATION_SOURCE_WEEKLY_QUEST:
        case REPUTATION_SOURCE_MONTHLY_QUEST:
        case REPUTATION_SOURCE_REPEATABLE_QUEST:
            rate = sWorld->getRate(RATE_REPUTATION_LOWLEVEL_QUEST);
            break;
        case REPUTATION_SOURCE_SPELL:
        default:
            rate = 1.0f;
            break;
    }

    if (rate != 1.0f && creatureOrQuestLevel <= Acore::XP::GetGrayLevel(GetLevel()))
        percent *= rate;

    if (percent <= 0.0f)
        return 0;

    // Multiply result with the faction specific rate
    if (RepRewardRate const* repData = sObjectMgr->GetRepRewardRate(faction))
    {
        float repRate = 0.0f;
        switch (source)
        {
            case REPUTATION_SOURCE_KILL:
                repRate = repData->creatureRate;
                break;
            case REPUTATION_SOURCE_QUEST:
                repRate = repData->questRate;
                break;
            case REPUTATION_SOURCE_DAILY_QUEST:
                repRate = repData->questDailyRate;
                break;
            case REPUTATION_SOURCE_WEEKLY_QUEST:
                repRate = repData->questWeeklyRate;
                break;
            case REPUTATION_SOURCE_MONTHLY_QUEST:
                repRate = repData->questMonthlyRate;
                break;
            case REPUTATION_SOURCE_REPEATABLE_QUEST:
                repRate = repData->questRepeatableRate;
                break;
            case REPUTATION_SOURCE_SPELL:
                repRate = repData->spellRate;
                break;
        }

        // for custom, a rate of 0.0 will totally disable reputation gain for this faction/type
        if (repRate <= 0.0f)
            return 0;

        percent *= repRate;
    }

    if (source != REPUTATION_SOURCE_SPELL && GetsRecruitAFriendBonus(false))
        percent *= 1.0f + sWorld->getRate(RATE_REPUTATION_RECRUIT_A_FRIEND_BONUS);

    return CalculatePct(rep, percent);
}

// Calculates how many reputation points player gains in victim's enemy factions
void Player::RewardReputation(Unit* victim)
{
    if (!victim || victim->IsPlayer())
        return;

    if (victim->ToCreature()->IsReputationGainDisabled())
        return;

    ReputationOnKillEntry const* Rep = sObjectMgr->GetReputationOnKilEntry(victim->ToCreature()->GetCreatureTemplate()->Entry);
    if (!Rep)
        return;

    uint32 ChampioningFaction = 0;

    if (GetChampioningFaction())
    {
        // support for: Championing - http://www.wowwiki.com/Championing
        Map const* map = GetMap();
        if (map->IsNonRaidDungeon())
            if (LFGDungeonEntry const* dungeon = GetLFGDungeon(map->GetId(), map->GetDifficulty()))
                if (dungeon->TargetLevel == 80)
                    ChampioningFaction = GetChampioningFaction();
    }

    TeamId teamId = GetTeamId(true); // Always check player original reputation when rewarding

    if (Rep->RepFaction1 && (!Rep->TeamDependent || teamId == TEAM_ALLIANCE))
    {
        float donerep1 = CalculateReputationGain(REPUTATION_SOURCE_KILL, victim->GetLevel(), static_cast<float>(Rep->RepValue1), ChampioningFaction ? ChampioningFaction : Rep->RepFaction1);

        FactionEntry const* factionEntry1 = sFactionStore.LookupEntry(ChampioningFaction ? ChampioningFaction : Rep->RepFaction1);
        if (factionEntry1)
        {
            GetReputationMgr().ModifyReputation(factionEntry1, donerep1, false, static_cast<ReputationRank>(Rep->ReputationMaxCap1));
        }
    }

    if (Rep->RepFaction2 && (!Rep->TeamDependent || teamId == TEAM_HORDE))
    {
        float donerep2 = CalculateReputationGain(REPUTATION_SOURCE_KILL, victim->GetLevel(), static_cast<float>(Rep->RepValue2), ChampioningFaction ? ChampioningFaction : Rep->RepFaction2);

        FactionEntry const* factionEntry2 = sFactionStore.LookupEntry(ChampioningFaction ? ChampioningFaction : Rep->RepFaction2);
        if (factionEntry2)
        {
            GetReputationMgr().ModifyReputation(factionEntry2, donerep2, false, static_cast<ReputationRank>(Rep->ReputationMaxCap2));
        }
    }
}

// Calculate how many reputation points player gain with the quest
void Player::RewardReputation(Quest const* quest)
{
    for (uint8 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
    {
        if (!quest->RewardFactionId[i])
            continue;

        float rep = 0.f;

        if (quest->RewardFactionValueIdOverride[i])
        {
            rep = quest->RewardFactionValueIdOverride[i] / 100.f;
        }
        else
        {
            uint32 row = ((quest->RewardFactionValueId[i] < 0) ? 1 : 0) + 1;
            if (QuestFactionRewEntry const* questFactionRewEntry = sQuestFactionRewardStore.LookupEntry(row))
            {
                uint32 field = std::abs(quest->RewardFactionValueId[i]);
                rep = static_cast<float>(questFactionRewEntry->QuestRewFactionValue[field]);
            }
        }

        if (rep == 0.f)
            continue;

        if (quest->IsDaily())
        {
            rep = CalculateReputationGain(REPUTATION_SOURCE_DAILY_QUEST, GetQuestLevel(quest), rep, quest->RewardFactionId[i], false);
        }
        else if (quest->IsWeekly())
        {
            rep = CalculateReputationGain(REPUTATION_SOURCE_WEEKLY_QUEST, GetQuestLevel(quest), rep, quest->RewardFactionId[i], false);
        }
        else if (quest->IsMonthly())
        {
            rep = CalculateReputationGain(REPUTATION_SOURCE_MONTHLY_QUEST, GetQuestLevel(quest), rep, quest->RewardFactionId[i], false);
        }
        else if (quest->IsRepeatable())
        {
            rep = CalculateReputationGain(REPUTATION_SOURCE_REPEATABLE_QUEST, GetQuestLevel(quest), rep, quest->RewardFactionId[i], false);
        }
        else
        {
            rep = CalculateReputationGain(REPUTATION_SOURCE_QUEST, GetQuestLevel(quest), rep, quest->RewardFactionId[i], false);
        }

        if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(quest->RewardFactionId[i]))
        {
            GetReputationMgr().ModifyReputation(factionEntry, rep, quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_NO_REP_SPILLOVER));
        }
    }
}

void Player::RewardExtraBonusTalentPoints(uint32 bonusTalentPoints)
{
    if (bonusTalentPoints)
    {
        m_extraBonusTalentCount += bonusTalentPoints;
    }
}

///Calculate the amount of honor gained based on the victim
///and the size of the group for which the honor is divided
///An exact honor value can also be given (overriding the calcs)
bool Player::RewardHonor(Unit* uVictim, uint32 groupsize, int32 honor, bool awardXP)
{
    // do not reward honor in arenas, but enable onkill spellproc
    if (InArena())
    {
        if (!uVictim || uVictim == this || !uVictim->IsPlayer())
            return false;

        if (GetBgTeamId() == uVictim->ToPlayer()->GetBgTeamId())
            return false;

        return true;
    }

    // 'Inactive' this aura prevents the player from gaining honor points and battleground tokens
    if (HasAura(SPELL_AURA_PLAYER_INACTIVE))
        return false;

    /* check if player has same IP
    if (uVictim && uVictim->IsPlayer())
    {
        if (GetSession()->GetRemoteAddress() == uVictim->ToPlayer()->GetSession()->GetRemoteAddress())
            return false;
    }
    */

    ObjectGuid victim_guid;
    uint32 victim_rank = 0;

    // need call before fields update to have chance move yesterday data to appropriate fields before today data change.
    UpdateHonorFields();

    // do not reward honor in arenas, but return true to enable onkill spellproc
    if (InArena())
        return true;

    // Promote to float for calculations
    float honor_f = (float)honor;

    if (honor_f <= 0)
    {
        if (!uVictim || uVictim == this || uVictim->HasAuraType(SPELL_AURA_NO_PVP_CREDIT))
            return false;

        victim_guid = uVictim->GetGUID();

        if (uVictim->IsPlayer())
        {
            Player* victim = uVictim->ToPlayer();

            if (GetTeamId() == victim->GetTeamId() && !sWorld->IsFFAPvPRealm())
                return false;

            uint8 k_level = GetLevel();
            uint8 k_grey = Acore::XP::GetGrayLevel(k_level);
            uint8 v_level = victim->GetLevel();

            if (v_level <= k_grey)
                return false;

            // PLAYER_CHOSEN_TITLE VALUES DESCRIPTION
            //  [0]      Just name
            //  [1..14]  Alliance honor titles and player name
            //  [15..28] Horde honor titles and player name
            //  [29..38] Other title and player name
            //  [39+]    Nothing
            uint32 victim_title = victim->GetUInt32Value(PLAYER_CHOSEN_TITLE);
            uint32 killer_title = 0;
            sScriptMgr->OnVictimRewardBefore(this, victim, killer_title, victim_title);
            // Get Killer titles, CharTitlesEntry::bit_index
            // Ranks:
            //  title[1..14]  -> rank[5..18]
            //  title[15..28] -> rank[5..18]
            //  title[other]  -> 0
            if (victim_title == 0)
                victim_guid.Clear();                        // Don't show HK: <rank> message, only log.
            else if (victim_title < 15)
                victim_rank = victim_title + 4;
            else if (victim_title < 29)
                victim_rank = victim_title - 14 + 4;
            else
                victim_guid.Clear();                        // Don't show HK: <rank> message, only log.

            honor_f = std::ceil(Acore::Honor::hk_honor_at_level_f(k_level) * (v_level - k_grey) / (k_level - k_grey));

            // count the number of playerkills in one day
            ApplyModUInt32Value(PLAYER_FIELD_KILLS, 1, true);
            // and those in a lifetime
            ApplyModUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 1, true);
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EARN_HONORABLE_KILL);
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HK_CLASS, victim->getClass());
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HK_RACE, victim->getRace(true));
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL_AT_AREA, GetAreaId());
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL, 1, 0, victim);
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_SPECIAL_PVP_KILL, 1, 0, victim);
            sScriptMgr->OnVictimRewardAfter(this, victim, killer_title, victim_rank, honor_f);
        }
        else
        {
            if (!uVictim->ToCreature()->IsRacialLeader())
                return false;

            honor_f = 100.0f;                               // ??? need more info
            victim_rank = 19;                               // HK: Leader
        }
    }

    if (uVictim)
    {
        if (groupsize > 1)
            honor_f /= groupsize;

        // apply honor multiplier from aura (not stacking-get highest)
        AddPct(honor_f, GetMaxPositiveAuraModifier(SPELL_AURA_MOD_HONOR_GAIN_PCT));
    }

    honor_f *= sWorld->getRate(RATE_HONOR);
    // Back to int now
    honor = int32(honor_f);
    // honor - for show honor points in log
    // victim_guid - for show victim name in log
    // victim_rank [1..4]  HK: <dishonored rank>
    // victim_rank [5..19] HK: <alliance\horde rank>
    // victim_rank [0, 20+] HK: <>
    WorldPacket data(SMSG_PVP_CREDIT, 4 + 8 + 4);
    data << honor;
    data << victim_guid;
    data << victim_rank;

    // Xinef: non quest case, quest honor obtain is send in quest reward packet
    if (uVictim || groupsize > 0)
        GetSession()->SendPacket(&data);

    // add honor points
    ModifyHonorPoints(honor);

    ApplyModUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, honor, true);

    // Xinef: Battleground experience
    if (awardXP)
        if (Battleground* bg = GetBattleground())
        {
            bg->UpdatePlayerScore(this, SCORE_BONUS_HONOR, honor, false); //false: prevent looping
            // Xinef: Only for BG activities
            if (!uVictim)
            {
                uint32 xp = uint32(honor * (3 + GetLevel() * 0.30f));
                sScriptMgr->OnGivePlayerXP(this, xp, nullptr, PlayerXPSource::XPSOURCE_BATTLEGROUND);
                GiveXP(xp, nullptr);
            }
        }

    if (sWorld->getBoolConfig(CONFIG_PVP_TOKEN_ENABLE))
    {
        if (!uVictim || uVictim == this || uVictim->HasAuraType(SPELL_AURA_NO_PVP_CREDIT))
            return true;

        if (uVictim->IsPlayer())
        {
            // Check if allowed to receive it in current map
            uint8 MapType = sWorld->getIntConfig(CONFIG_PVP_TOKEN_MAP_TYPE);
            if ((MapType == 1 && !InBattleground() && !IsFFAPvP())
                    || (MapType == 2 && !IsFFAPvP())
                    || (MapType == 3 && !InBattleground()))
                return true;

            uint32 itemID = sWorld->getIntConfig(CONFIG_PVP_TOKEN_ID);
            int32 count = sWorld->getIntConfig(CONFIG_PVP_TOKEN_COUNT);

            if (AddItem(itemID, count))
                ChatHandler(GetSession()).PSendSysMessage("You have been awarded a token for slaying another player.");
        }
    }

    return true;
}

void Player::SetHonorPoints(uint32 value)
{
    if (value > sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS))
    {
        if (int32 copperPerPoint = sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS_MONEY_PER_POINT))
        {
            // Only convert points on login, not when awarded honor points.
            if (isBeingLoaded())
            {
                int32 excessPoints = value - sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS);
                ModifyMoney(excessPoints * copperPerPoint);
            }
        }

        value = sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS);
    }
    SetUInt32Value(PLAYER_FIELD_HONOR_CURRENCY, value);
    if (value)
        AddKnownCurrency(ITEM_HONOR_POINTS_ID);
}

void Player::SetArenaPoints(uint32 value)
{
    if (value > sWorld->getIntConfig(CONFIG_MAX_ARENA_POINTS))
        value = sWorld->getIntConfig(CONFIG_MAX_ARENA_POINTS);
    SetUInt32Value(PLAYER_FIELD_ARENA_CURRENCY, value);
    if (value)
        AddKnownCurrency(ITEM_ARENA_POINTS_ID);
}

void Player::ModifyHonorPoints(int32 value, CharacterDatabaseTransaction trans)
{
    int32 newValue = int32(GetHonorPoints()) + value;
    if (newValue < 0)
        newValue = 0;
    SetHonorPoints(uint32(newValue));

    if (trans)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_HONOR_POINTS);
        stmt->SetData(0, newValue);
        stmt->SetData(1, GetGUID().GetCounter());
        trans->Append(stmt);
    }
}

void Player::ModifyArenaPoints(int32 value, CharacterDatabaseTransaction trans)
{
    int32 newValue = int32(GetArenaPoints()) + value;
    if (newValue < 0)
        newValue = 0;
    SetArenaPoints(uint32(newValue));

    if (trans)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_ARENA_POINTS);
        stmt->SetData(0, newValue);
        stmt->SetData(1, GetGUID().GetCounter());
        trans->Append(stmt);
    }
}

uint32 Player::GetArenaTeamIdFromDB(ObjectGuid guid, uint8 type)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ARENA_TEAM_ID_BY_PLAYER_GUID);
    stmt->SetData(0, guid.GetCounter());
    stmt->SetData(1, type);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
        return 0;

    uint32 id = (*result)[0].Get<uint32>();
    return id;
}

uint32 Player::GetZoneIdFromDB(ObjectGuid guid)
{
    ObjectGuid::LowType guidLow = guid.GetCounter();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_ZONE);
    stmt->SetData(0, guidLow);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
        return 0;

    Field* fields = result->Fetch();
    uint32 zone = fields[0].Get<uint16>();

    if (!zone)
    {
        // stored zone is zero, use generic and slow zone detection
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_POSITION_XYZ);
        stmt->SetData(0, guidLow);
        PreparedQueryResult posResult = CharacterDatabase.Query(stmt);

        if (!posResult)
        {
            return 0;
        }

        fields = posResult->Fetch();
        uint32 map = fields[0].Get<uint16>();
        float posx = fields[1].Get<float>();
        float posy = fields[2].Get<float>();
        float posz = fields[3].Get<float>();

        if (!sMapStore.LookupEntry(map))
            return 0;

        zone = sMapMgr->GetZoneId(PHASEMASK_NORMAL, map, posx, posy, posz);

        if (zone > 0)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ZONE);

            stmt->SetData(0, uint16(zone));
            stmt->SetData(1, guidLow);

            CharacterDatabase.Execute(stmt);
        }
    }

    return zone;
}

//If players are too far away from the duel flag... they lose the duel
void Player::CheckDuelDistance(time_t currTime)
{
    if (!duel)
    {
        return;
    }

    ObjectGuid duelFlagGUID = GetGuidValue(PLAYER_DUEL_ARBITER);
    GameObject* obj = GetMap()->GetGameObject(duelFlagGUID);
    if (!obj)
        return;

    if (!duel->OutOfBoundsTime)
    {
        if (!IsWithinDistInMap(obj, 50))
        {
            duel->OutOfBoundsTime = currTime + 10;

            WorldPacket data(SMSG_DUEL_OUTOFBOUNDS, 0);
            GetSession()->SendPacket(&data);
        }
    }
    else
    {
        if (IsWithinDistInMap(obj, 40))
        {
            duel->OutOfBoundsTime = 0;

            WorldPacket data(SMSG_DUEL_INBOUNDS, 0);
            GetSession()->SendPacket(&data);
        }
        else if (currTime >= duel->OutOfBoundsTime)
            DuelComplete(DUEL_FLED);
    }
}

bool Player::IsOutdoorPvPActive()
{
    return IsAlive() && !HasInvisibilityAura() && !HasStealthAura() && IsPvP() && !HasUnitMovementFlag(MOVEMENTFLAG_FLYING) && !IsInFlight();
}

void Player::DuelComplete(DuelCompleteType type)
{
    // duel not requested
    if (!duel)
        return;

    // Check if DuelComplete() has been called already up in the stack and in that case don't do anything else here
    if (duel->State == DUEL_STATE_COMPLETED)
        return;

    Player* opponent      = duel->Opponent;
    duel->State           = DUEL_STATE_COMPLETED;
    opponent->duel->State = DUEL_STATE_COMPLETED;

    LOG_DEBUG("entities.unit", "Player::DuelComplete: Player '{}' ({}), Opponent: '{}' ({})", GetName(), GetGUID().ToString(), opponent->GetName(), opponent->GetGUID().ToString());

    WorldPacket data(SMSG_DUEL_COMPLETE, (1));
    data << uint8((type != DUEL_INTERRUPTED) ? 1 : 0);
    SendDirectMessage(&data);
    if (opponent->GetSession())
    {
        opponent->SendDirectMessage(&data);
    }

    if (type != DUEL_INTERRUPTED)
    {
        data.Initialize(SMSG_DUEL_WINNER, (1 + 20)); // we guess size
        data << uint8(type == DUEL_WON ? 0 : 1);     // 0 = just won; 1 = fled
        data << opponent->GetName();
        data << GetName();
        SendMessageToSet(&data, true);
    }

    sScriptMgr->OnPlayerDuelEnd(opponent, this, type);

    switch (type)
    {
    case DUEL_FLED:
        // if initiator and opponent are on the same team
        // or initiator and opponent are not PvP enabled, forcibly stop attacking
        if (GetTeamId() == opponent->GetTeamId())
        {
            AttackStop();
            opponent->AttackStop();
        }
        else
        {
            if (!IsPvP())
            {
                AttackStop();
            }
            if (!opponent->IsPvP())
            {
                opponent->AttackStop();
            }
        }
        break;
    case DUEL_WON:
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LOSE_DUEL, 1);
        opponent->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WIN_DUEL, 1);

        // Credit for quest Death's Challenge
        if (IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_QUEST) && opponent->GetQuestStatus(12733) == QUEST_STATUS_INCOMPLETE)
        {
            opponent->CastSpell(opponent, 52994, true);
        }

        // Honor points after duel (the winner) - ImpConfig
        if (uint32 amount = sWorld->getIntConfig(CONFIG_HONOR_AFTER_DUEL))
        {
            opponent->RewardHonor(nullptr, 1, amount);
        }

        break;
    default:
        break;
    }

    // Victory emote spell
    if (type != DUEL_INTERRUPTED)
    {
        opponent->CastSpell(opponent, 52852, true);
    }

    // Remove Duel Flag object
    GameObject* obj = GetMap()->GetGameObject(GetGuidValue(PLAYER_DUEL_ARBITER));
    if (obj)
    {
        duel->Initiator->RemoveGameObject(obj, true);
    }

    /* remove auras */
    AuraApplicationMap& itsAuras = opponent->GetAppliedAuras();
    for (AuraApplicationMap::iterator i = itsAuras.begin(); i != itsAuras.end();)
    {
        Aura const* aura = i->second->GetBase();
        if (!i->second->IsPositive() && aura->GetCasterGUID() == GetGUID() && aura->GetApplyTime() >= duel->StartTime)
        {
            opponent->RemoveAura(i);
        }
        else
        {
            ++i;
        }
    }

    AuraApplicationMap& myAuras = GetAppliedAuras();
    for (AuraApplicationMap::iterator i = myAuras.begin(); i != myAuras.end();)
    {
        Aura const* aura = i->second->GetBase();
        if (!i->second->IsPositive() && aura->GetCasterGUID() == opponent->GetGUID() && aura->GetApplyTime() >= duel->StartTime)
            RemoveAura(i);
        else
            ++i;
    }

    // cleanup combo points
    if (GetComboTarget() == duel->Opponent)
    {
        ClearComboPoints();
    }
    else if (GetComboTargetGUID() == duel->Opponent->GetPetGUID())
    {
        ClearComboPoints();
    }

    if (duel->Opponent->GetComboTarget() == this)
    {
        duel->Opponent->ClearComboPoints();
    }
    else if (duel->Opponent->GetComboTargetGUID() == GetPetGUID())
    {
        duel->Opponent->ClearComboPoints();
    }

    //cleanups
    SetGuidValue(PLAYER_DUEL_ARBITER, ObjectGuid::Empty);
    SetUInt32Value(PLAYER_DUEL_TEAM, 0);
    opponent->SetGuidValue(PLAYER_DUEL_ARBITER, ObjectGuid::Empty);
    opponent->SetUInt32Value(PLAYER_DUEL_TEAM, 0);

    opponent->duel.reset(nullptr);
    duel.reset(nullptr);
}

//---------------------------------------------------------//

void Player::_ApplyItemMods(Item* item, uint8 slot, bool apply)
{
    if (slot >= INVENTORY_SLOT_BAG_END || !item)
        return;

    ItemTemplate const* proto = item->GetTemplate();

    if (!proto)
        return;

    // not apply/remove mods for broken item
    if (item->IsBroken())
        return;

    LOG_DEBUG("entities.player", "applying mods for item {} ", item->GetGUID().ToString());

    uint8 attacktype = Player::GetAttackBySlot(slot);

    if (item->HasSocket())                              //only (un)equipping of items with sockets can influence metagems, so no need to waste time with normal items
        CorrectMetaGemEnchants(slot, apply);

    if (attacktype < MAX_ATTACK)
        _ApplyWeaponDependentAuraMods(item, WeaponAttackType(attacktype), apply);

    _ApplyItemBonuses(proto, slot, apply);

    if (slot == EQUIPMENT_SLOT_RANGED)
        _ApplyAmmoBonuses();

    ApplyItemEquipSpell(item, apply);
    ApplyEnchantment(item, apply);

    LOG_DEBUG("entities.player.items", "_ApplyItemMods complete.");
}

void Player::_ApplyItemBonuses(ItemTemplate const* proto, uint8 slot, bool apply, bool only_level_scale /*= false*/)
{
    if (slot >= INVENTORY_SLOT_BAG_END || !proto)
        return;

    ScalingStatDistributionEntry const* ssd = proto->ScalingStatDistribution ? sScalingStatDistributionStore.LookupEntry(proto->ScalingStatDistribution) : nullptr;
    if (only_level_scale && !ssd)
        return;

    // req. check at equip, but allow use for extended range if range limit max level, set proper level
    uint32 ssd_level = GetLevel();
    uint32 CustomScalingStatValue = 0;

    sScriptMgr->OnCustomScalingStatValueBefore(this, proto, slot, apply, CustomScalingStatValue);

    uint32 ScalingStatValue = proto->ScalingStatValue > 0 ? proto->ScalingStatValue : CustomScalingStatValue;

    if (ssd && ssd_level > ssd->MaxLevel)
        ssd_level = ssd->MaxLevel;

    ScalingStatValuesEntry const* ssv = proto->ScalingStatValue ? sScalingStatValuesStore.LookupEntry(ssd_level) : nullptr;
    if (only_level_scale && !ssv)
        return;

    for (uint8 i = 0; i < MAX_ITEM_PROTO_STATS; ++i)
    {
        uint32 statType = 0;
        int32  val = 0;
        // If set ScalingStatDistribution need get stats and values from it
        if (ssv)
        {
            if (ssd)
            {
                if (ssd->StatMod[i] < 0)
                    continue;

                statType = ssd->StatMod[i];
                val = (ssv->getssdMultiplier(ScalingStatValue) * ssd->Modifier[i]) / 10000;
            }
            else
            {
                if (i >= proto->StatsCount)
                    continue;

                // OnCustomScalingStatValue(Player* player, ItemTemplate const* proto, uint32& statType, int32& val, uint8 itemProtoStatNumber, uint32 ScalingStatValue, ScalingStatValuesEntry const* ssv)
                sScriptMgr->OnCustomScalingStatValue(this, proto, statType, val, i, ScalingStatValue, ssv);
            }
        }
        else
        {
            if (i >= proto->StatsCount)
                continue;

            statType = proto->ItemStat[i].ItemStatType;
            val = proto->ItemStat[i].ItemStatValue;

            sScriptMgr->OnApplyItemModsBefore(this, slot, apply, i, statType, val);
        }

        if (val == 0)
            continue;

        switch (statType)
        {
            case ITEM_MOD_MANA:
                HandleStatModifier(UNIT_MOD_MANA, BASE_VALUE, float(val), apply);
                break;
            case ITEM_MOD_HEALTH:                           // modify HP
                HandleStatModifier(UNIT_MOD_HEALTH, BASE_VALUE, float(val), apply);
                break;
            case ITEM_MOD_AGILITY:                          // modify agility
                HandleStatModifier(UNIT_MOD_STAT_AGILITY, BASE_VALUE, float(val), apply);
                ApplyStatBuffMod(STAT_AGILITY, float(val), apply);
                break;
            case ITEM_MOD_STRENGTH:                         //modify strength
                HandleStatModifier(UNIT_MOD_STAT_STRENGTH, BASE_VALUE, float(val), apply);
                ApplyStatBuffMod(STAT_STRENGTH, float(val), apply);
                break;
            case ITEM_MOD_INTELLECT:                        //modify intellect
                HandleStatModifier(UNIT_MOD_STAT_INTELLECT, BASE_VALUE, float(val), apply);
                ApplyStatBuffMod(STAT_INTELLECT, float(val), apply);
                break;
            case ITEM_MOD_SPIRIT:                           //modify spirit
                HandleStatModifier(UNIT_MOD_STAT_SPIRIT, BASE_VALUE, float(val), apply);
                ApplyStatBuffMod(STAT_SPIRIT, float(val), apply);
                break;
            case ITEM_MOD_STAMINA:                          //modify stamina
                HandleStatModifier(UNIT_MOD_STAT_STAMINA, BASE_VALUE, float(val), apply);
                ApplyStatBuffMod(STAT_STAMINA, float(val), apply);
                break;
            case ITEM_MOD_DEFENSE_SKILL_RATING:
                ApplyRatingMod(CR_DEFENSE_SKILL, int32(val), apply);
                break;
            case ITEM_MOD_DODGE_RATING:
                ApplyRatingMod(CR_DODGE, int32(val), apply);
                break;
            case ITEM_MOD_PARRY_RATING:
                ApplyRatingMod(CR_PARRY, int32(val), apply);
                break;
            case ITEM_MOD_BLOCK_RATING:
                ApplyRatingMod(CR_BLOCK, int32(val), apply);
                break;
            case ITEM_MOD_HIT_MELEE_RATING:
                ApplyRatingMod(CR_HIT_MELEE, int32(val), apply);
                break;
            case ITEM_MOD_HIT_RANGED_RATING:
                ApplyRatingMod(CR_HIT_RANGED, int32(val), apply);
                break;
            case ITEM_MOD_HIT_SPELL_RATING:
                ApplyRatingMod(CR_HIT_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_MELEE_RATING:
                ApplyRatingMod(CR_CRIT_MELEE, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_RANGED_RATING:
                ApplyRatingMod(CR_CRIT_RANGED, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_SPELL_RATING:
                ApplyRatingMod(CR_CRIT_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_HIT_TAKEN_MELEE_RATING:
                ApplyRatingMod(CR_HIT_TAKEN_MELEE, int32(val), apply);
                break;
            case ITEM_MOD_HIT_TAKEN_RANGED_RATING:
                ApplyRatingMod(CR_HIT_TAKEN_RANGED, int32(val), apply);
                break;
            case ITEM_MOD_HIT_TAKEN_SPELL_RATING:
                ApplyRatingMod(CR_HIT_TAKEN_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_TAKEN_MELEE_RATING:
                ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_TAKEN_RANGED_RATING:
                ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_TAKEN_SPELL_RATING:
                ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_HASTE_MELEE_RATING:
                ApplyRatingMod(CR_HASTE_MELEE, int32(val), apply);
                break;
            case ITEM_MOD_HASTE_RANGED_RATING:
                ApplyRatingMod(CR_HASTE_RANGED, int32(val), apply);
                break;
            case ITEM_MOD_HASTE_SPELL_RATING:
                ApplyRatingMod(CR_HASTE_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_HIT_RATING:
                ApplyRatingMod(CR_HIT_MELEE, int32(val), apply);
                ApplyRatingMod(CR_HIT_RANGED, int32(val), apply);
                ApplyRatingMod(CR_HIT_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_RATING:
                ApplyRatingMod(CR_CRIT_MELEE, int32(val), apply);
                ApplyRatingMod(CR_CRIT_RANGED, int32(val), apply);
                ApplyRatingMod(CR_CRIT_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_HIT_TAKEN_RATING:
                ApplyRatingMod(CR_HIT_TAKEN_MELEE, int32(val), apply);
                ApplyRatingMod(CR_HIT_TAKEN_RANGED, int32(val), apply);
                ApplyRatingMod(CR_HIT_TAKEN_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_TAKEN_RATING:
            case ITEM_MOD_RESILIENCE_RATING:
                ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
                ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
                ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_HASTE_RATING:
                ApplyRatingMod(CR_HASTE_MELEE, int32(val), apply);
                ApplyRatingMod(CR_HASTE_RANGED, int32(val), apply);
                ApplyRatingMod(CR_HASTE_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_EXPERTISE_RATING:
                ApplyRatingMod(CR_EXPERTISE, int32(val), apply);
                break;
            case ITEM_MOD_ATTACK_POWER:
                HandleStatModifier(UNIT_MOD_ATTACK_POWER, TOTAL_VALUE, float(val), apply);
                HandleStatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(val), apply);
                break;
            case ITEM_MOD_RANGED_ATTACK_POWER:
                HandleStatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(val), apply);
                break;
            //            case ITEM_MOD_FERAL_ATTACK_POWER:
            //                ApplyFeralAPBonus(int32(val), apply);
            //                break;
            case ITEM_MOD_MANA_REGENERATION:
                ApplyManaRegenBonus(int32(val), apply);
                break;
            case ITEM_MOD_ARMOR_PENETRATION_RATING:
                ApplyRatingMod(CR_ARMOR_PENETRATION, int32(val), apply);
                break;
            case ITEM_MOD_SPELL_POWER:
                ApplySpellPowerBonus(int32(val), apply);
                break;
            case ITEM_MOD_HEALTH_REGEN:
                ApplyHealthRegenBonus(int32(val), apply);
                break;
            case ITEM_MOD_SPELL_PENETRATION:
                ApplySpellPenetrationBonus(val, apply);
                break;
            case ITEM_MOD_BLOCK_VALUE:
                HandleBaseModValue(SHIELD_BLOCK_VALUE, FLAT_MOD, float(val), apply);
                break;
            /// @deprecated item mods
            case ITEM_MOD_SPELL_HEALING_DONE:
            case ITEM_MOD_SPELL_DAMAGE_DONE:
                break;
        }
    }

    // Apply Spell Power from ScalingStatValue if set
    if (ssv)
        if (int32 spellbonus = ssv->getSpellBonus(ScalingStatValue))
            ApplySpellPowerBonus(spellbonus, apply);

    // If set ScalingStatValue armor get it or use item armor
    uint32 armor = proto->Armor;
    if (ssv)
    {
        if (uint32 ssvarmor = ssv->getArmorMod(ScalingStatValue))
            if (proto->ScalingStatValue > 0 || ssvarmor < proto->Armor) //Check to avoid higher values than stat itself (heirloom OR items with correct armor value)
                armor = ssvarmor;
    }
    else if (armor && proto->ArmorDamageModifier)
        armor -= uint32(proto->ArmorDamageModifier);

    if (armor)
    {
        UnitModifierType modType = TOTAL_VALUE;
        if (proto->Class == ITEM_CLASS_ARMOR)
        {
            switch (proto->SubClass)
            {
                case ITEM_SUBCLASS_ARMOR_CLOTH:
                case ITEM_SUBCLASS_ARMOR_LEATHER:
                case ITEM_SUBCLASS_ARMOR_MAIL:
                case ITEM_SUBCLASS_ARMOR_PLATE:
                case ITEM_SUBCLASS_ARMOR_SHIELD:
                    modType = BASE_VALUE;
                    break;
            }
        }
        HandleStatModifier(UNIT_MOD_ARMOR, modType, float(armor), apply);
    }

    // Add armor bonus from ArmorDamageModifier if > 0
    if (proto->ArmorDamageModifier > 0 && sScriptMgr->CanArmorDamageModifier(this))
        HandleStatModifier(UNIT_MOD_ARMOR, TOTAL_VALUE, float(proto->ArmorDamageModifier), apply);

    if (proto->Block)
        HandleBaseModValue(SHIELD_BLOCK_VALUE, FLAT_MOD, float(proto->Block), apply);

    if (proto->HolyRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_HOLY, BASE_VALUE, float(proto->HolyRes), apply);

    if (proto->FireRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_FIRE, BASE_VALUE, float(proto->FireRes), apply);

    if (proto->NatureRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_NATURE, BASE_VALUE, float(proto->NatureRes), apply);

    if (proto->FrostRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_FROST, BASE_VALUE, float(proto->FrostRes), apply);

    if (proto->ShadowRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_SHADOW, BASE_VALUE, float(proto->ShadowRes), apply);

    if (proto->ArcaneRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_ARCANE, BASE_VALUE, float(proto->ArcaneRes), apply);

    uint8 attType = Player::GetAttackBySlot(slot);
    if (attType != MAX_ATTACK)
    {
        _ApplyWeaponDamage(slot, proto, ssv, apply);
    }

    // Druids get feral AP bonus from weapon dps (also use DPS from ScalingStatValue)
    if (IsClass(CLASS_DRUID, CLASS_CONTEXT_STATS))
    {
        int32 dpsMod = 0;
        int32 feral_bonus = 0;
        if (ssv)
        {
            dpsMod = ssv->getDPSMod(ScalingStatValue);
            feral_bonus += ssv->getFeralBonus(ScalingStatValue);
        }

        feral_bonus += proto->getFeralBonus(dpsMod);
        sScriptMgr->OnGetFeralApBonus(this, feral_bonus, dpsMod, proto, ssv);
        if (feral_bonus)
            ApplyFeralAPBonus(feral_bonus, apply);
    }
}

void Player::_ApplyWeaponDamage(uint8 slot, ItemTemplate const* proto, ScalingStatValuesEntry const* ssv, bool apply)
{
    uint32 CustomScalingStatValue = 0;

    sScriptMgr->OnCustomScalingStatValueBefore(this, proto, slot, apply, CustomScalingStatValue);

    uint32 ScalingStatValue = proto->ScalingStatValue > 0 ? proto->ScalingStatValue : CustomScalingStatValue;

    // following part fix disarm issue
    // that doesn't apply the scaling after disarmed
    if (!ssv)
    {
        ScalingStatDistributionEntry const* ssd = proto->ScalingStatDistribution ? sScalingStatDistributionStore.LookupEntry(proto->ScalingStatDistribution) : nullptr;

        // req. check at equip, but allow use for extended range if range limit max level, set proper level
        uint32 ssd_level = GetLevel();

        if (ssd && ssd_level > ssd->MaxLevel)
            ssd_level = ssd->MaxLevel;

        ssv = ScalingStatValue ? sScalingStatValuesStore.LookupEntry(ssd_level) : nullptr;
    }

    uint8 attType = Player::GetAttackBySlot(slot);
    if (!IsInFeralForm() && apply && !CanUseAttackType(attType))
    {
        return;
    }

    for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
    {
        float minDamage = proto->Damage[i].DamageMin;
        float maxDamage = proto->Damage[i].DamageMax;

        // If set dpsMod in ScalingStatValue use it for min (70% from average), max (130% from average) damage
        if (ssv)
        {
            int32 extraDPS = ssv->getDPSMod(ScalingStatValue);
            if (extraDPS)
            {
                float average = extraDPS * proto->Delay / 1000.0f;
                float mod = ssv->IsTwoHand(proto->ScalingStatValue) ? 0.2f : 0.3f;

                minDamage = (1.0f - mod) * average;
                maxDamage = (1.0f + mod) * average;
            }
        }

        if (apply)
        {
            if (minDamage > 0.f)
            {
                SetBaseWeaponDamage(WeaponAttackType(attType), MINDAMAGE, minDamage, i);
            }

            if (maxDamage > 0.f)
            {
                SetBaseWeaponDamage(WeaponAttackType(attType), MAXDAMAGE, maxDamage, i);
            }
        }
    }

    if (!apply)
    {
        for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
        {
            SetBaseWeaponDamage(WeaponAttackType(attType), MINDAMAGE, 0.f, i);
            SetBaseWeaponDamage(WeaponAttackType(attType), MAXDAMAGE, 0.f, i);
        }

        if (attType == BASE_ATTACK)
        {
            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, BASE_MINDAMAGE);
            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, BASE_MAXDAMAGE);
        }
    }

    if (proto->Delay && !IsInFeralForm())
    {
        if (slot == EQUIPMENT_SLOT_RANGED)
            SetAttackTime(RANGED_ATTACK, apply ? proto->Delay : BASE_ATTACK_TIME);
        else if (slot == EQUIPMENT_SLOT_MAINHAND)
            SetAttackTime(BASE_ATTACK, apply ? proto->Delay : BASE_ATTACK_TIME);
        else if (slot == EQUIPMENT_SLOT_OFFHAND)
            SetAttackTime(OFF_ATTACK, apply ? proto->Delay : BASE_ATTACK_TIME);
    }

    // No need to modify any physical damage for ferals as it is calculated from stats only
    if (IsInFeralForm())
        return;

    if (CanModifyStats() && (GetWeaponDamageRange(WeaponAttackType(attType), MAXDAMAGE) || proto->Delay))
        UpdateDamagePhysical(WeaponAttackType(attType));
}

SpellSchoolMask Player::GetMeleeDamageSchoolMask(WeaponAttackType attackType /*= BASE_ATTACK*/, uint8 damageIndex /*= 0*/) const
{
    if (Item const* weapon = GetWeaponForAttack(attackType, true))
    {
        return SpellSchoolMask(1 << weapon->GetTemplate()->Damage[damageIndex].DamageType);
    }

    return SPELL_SCHOOL_MASK_NORMAL;
}

void Player::_ApplyWeaponDependentAuraMods(Item* item, WeaponAttackType attackType, bool apply)
{
    AuraEffectList const& auraCritList = GetAuraEffectsByType(SPELL_AURA_MOD_WEAPON_CRIT_PERCENT);
    for (AuraEffectList::const_iterator itr = auraCritList.begin(); itr != auraCritList.end(); ++itr)
        _ApplyWeaponDependentAuraCritMod(item, attackType, *itr, apply);

    AuraEffectList const& auraDamageFlatList = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_DONE);
    for (AuraEffectList::const_iterator itr = auraDamageFlatList.begin(); itr != auraDamageFlatList.end(); ++itr)
        _ApplyWeaponDependentAuraDamageMod(item, attackType, *itr, apply);

    AuraEffectList const& auraDamagePctList = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
    for (AuraEffectList::const_iterator itr = auraDamagePctList.begin(); itr != auraDamagePctList.end(); ++itr)
        _ApplyWeaponDependentAuraDamageMod(item, attackType, *itr, apply);
}

void Player::_ApplyWeaponDependentAuraCritMod(Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply)
{
    // don't apply mod if item is broken or cannot be used
    if (item->IsBroken() || !CanUseAttackType(attackType))
        return;

    // generic not weapon specific case processes in aura code
    if (aura->GetSpellInfo()->EquippedItemClass == -1)
        return;

    if (!sScriptMgr->CanApplyWeaponDependentAuraDamageMod(this, item, attackType, aura, apply))
        return;

    BaseModGroup mod = BASEMOD_END;
    switch (attackType)
    {
        case BASE_ATTACK:
            mod = CRIT_PERCENTAGE;
            break;
        case OFF_ATTACK:
            mod = OFFHAND_CRIT_PERCENTAGE;
            break;
        case RANGED_ATTACK:
            mod = RANGED_CRIT_PERCENTAGE;
            break;
        default:
            return;
    }

    if (item->IsFitToSpellRequirements(aura->GetSpellInfo()))
        HandleBaseModValue(mod, FLAT_MOD, float (aura->GetAmount()), apply);
}

void Player::_ApplyWeaponDependentAuraDamageMod(Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply)
{
    // don't apply mod if item is broken or cannot be used
    if (item->IsBroken() || !CanUseAttackType(attackType))
        return;

    // ignore spell mods for not wands
    if ((aura->GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL) == 0 && (getClassMask() & CLASSMASK_WAND_USERS) == 0)
        return;

    // generic not weapon specific case processes in aura code
    if (aura->GetSpellInfo()->EquippedItemClass == -1)
        return;

    UnitMods unitMod = UNIT_MOD_END;
    switch (attackType)
    {
        case BASE_ATTACK:
            unitMod = UNIT_MOD_DAMAGE_MAINHAND;
            break;
        case OFF_ATTACK:
            unitMod = UNIT_MOD_DAMAGE_OFFHAND;
            break;
        case RANGED_ATTACK:
            unitMod = UNIT_MOD_DAMAGE_RANGED;
            break;
        default:
            return;
    }

    UnitModifierType unitModType = TOTAL_VALUE;
    switch (aura->GetAuraType())
    {
        case SPELL_AURA_MOD_DAMAGE_DONE:
            unitModType = TOTAL_VALUE;
            break;
        case SPELL_AURA_MOD_DAMAGE_PERCENT_DONE:
            unitModType = TOTAL_PCT;
            break;
        default:
            return;
    }

    if (item->IsFitToSpellRequirements(aura->GetSpellInfo()))
    {
        HandleStatModifier(unitMod, unitModType, float(aura->GetAmount()), apply);
        if (unitModType == TOTAL_VALUE)
        {
            if (aura->GetAmount() > 0)
                ApplyModUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS, aura->GetAmount(), apply);
            else
                ApplyModUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG, aura->GetAmount(), apply);
        }
    }
}

void Player::ApplyItemEquipSpell(Item* item, bool apply, bool form_change)
{
    if (!item)
        return;

    ItemTemplate const* proto = item->GetTemplate();
    if (!proto)
        return;

    for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
    {
        _Spell const& spellData = proto->Spells[i];

        // no spell
        if (!spellData.SpellId)
            continue;

        // Spells that should stay on the caster after removing the item.
        constexpr std::array<int32, 2> spellExceptions =
        {
            11826,  //Electromagnetic Gigaflux Reactivator
            17490   //Book of the Dead - Summon Skeleton
        };
        const auto found = std::find(std::begin(spellExceptions), std::end(spellExceptions), spellData.SpellId);

        // wrong triggering type
        if (apply)
        {
            if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_EQUIP)
            {
                continue;
            }
        }
        else
        {
            // If the spell is an exception do not remove it.
            if (found != std::end(spellExceptions))
            {
                continue;
            }
        }

        // check if it is valid spell
        SpellInfo const* spellproto = sSpellMgr->GetSpellInfo(spellData.SpellId);
        if (!spellproto)
            continue;

        ApplyEquipSpell(spellproto, item, apply, form_change);
    }
}

void Player::ApplyEquipSpell(SpellInfo const* spellInfo, Item* item, bool apply, bool form_change)
{
    if (apply)
    {
        if (!sScriptMgr->CanApplyEquipSpell(this, spellInfo, item, apply, form_change))
            return;

        // Cannot be used in this stance/form
        if (spellInfo->CheckShapeshift(GetShapeshiftForm()) != SPELL_CAST_OK)
            return;

        if (form_change)                                    // check aura active state from other form
        {
            AuraApplicationMapBounds range = GetAppliedAuras().equal_range(spellInfo->Id);
            for (AuraApplicationMap::const_iterator itr = range.first; itr != range.second; ++itr)
                if (!item || itr->second->GetBase()->GetCastItemGUID() == item->GetGUID())
                    return;
        }

        LOG_DEBUG("entities.player", "WORLD: cast {} Equip spellId - {}", (item ? "item" : "itemset"), spellInfo->Id);

        //Ignore spellInfo->DurationEntry, cast with -1 duration
        CastCustomSpell(spellInfo->Id, SPELLVALUE_AURA_DURATION, -1, this, true, item);
    }
    else
    {
        if (form_change)                                     // check aura compatibility
        {
            // Cannot be used in this stance/form
            if (spellInfo->CheckShapeshift(GetShapeshiftForm()) == SPELL_CAST_OK)
                return;                                     // and remove only not compatible at form change
        }

        if (item)
            RemoveAurasDueToItemSpell(spellInfo->Id, item->GetGUID());  // un-apply all spells, not only at-equipped
        else
            RemoveAurasDueToSpell(spellInfo->Id);           // un-apply spell (item set case)

        // Xinef: Remove Proc Spells and Summons
        for (uint8 i = EFFECT_0; i < MAX_SPELL_EFFECTS; ++i)
        {
            // Xinef: Remove procs
            if (spellInfo->Effects[i].TriggerSpell)
                RemoveAurasDueToSpell(spellInfo->Effects[i].TriggerSpell);

            // Xinef: remove minions summoned by item
            if (spellInfo->Effects[i].Effect == SPELL_EFFECT_SUMMON)
                RemoveAllMinionsByEntry(spellInfo->Effects[i].MiscValue);
        }
    }
}

void Player::CastItemCombatSpell(Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx)
{
    if (!target || !target->IsAlive() || target == this)
        return;

    // Xinef: do not use disarmed weapons, special exception - shaman ghost wolf form
    // Xinef: normal forms proc on hit enchants / built in item bonuses
    if (!CanUseAttackType(attType) || GetShapeshiftForm() == FORM_GHOSTWOLF)
        return;

    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        // If usable, try to cast item spell
        if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (!item->IsBroken())
                if (ItemTemplate const* proto = item->GetTemplate())
                {
                    // Additional check for weapons
                    if (proto->Class == ITEM_CLASS_WEAPON)
                    {
                        // offhand item cannot proc from main hand hit etc
                        EquipmentSlots slot;
                        switch (attType)
                        {
                            case BASE_ATTACK:
                                slot = EQUIPMENT_SLOT_MAINHAND;
                                break;
                            case OFF_ATTACK:
                                slot = EQUIPMENT_SLOT_OFFHAND;
                                break;
                            case RANGED_ATTACK:
                                slot = EQUIPMENT_SLOT_RANGED;
                                break;
                            default:
                                slot = EQUIPMENT_SLOT_END;
                                break;
                        }
                        if (slot != i)
                            continue;
                    }

                    CastItemCombatSpell(target, attType, procVictim, procEx, item, proto);
                }
    }
}

void Player::CastItemCombatSpell(Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item* item, ItemTemplate const* proto)
{
    if (!sScriptMgr->CanCastItemCombatSpell(this, target, attType, procVictim, procEx, item, proto))
        return;

    // Can do effect if any damage done to target
    if (procVictim & PROC_FLAG_TAKEN_DAMAGE)
        //if (damageInfo->procVictim & PROC_FLAG_TAKEN_ANY_DAMAGE)
    {
        for (uint8 i = 0; i < MAX_ITEM_SPELLS; ++i)
        {
            _Spell const& spellData = proto->Spells[i];

            // no spell
            if (!spellData.SpellId)
                continue;

            // wrong triggering type
            if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_CHANCE_ON_HIT)
                continue;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellData.SpellId);
            if (!spellInfo)
            {
                LOG_ERROR("entities.player", "WORLD: unknown Item spellid {}", spellData.SpellId);
                continue;
            }

            float chance = (float)spellInfo->ProcChance;

            if (spellData.SpellPPMRate)
            {
                uint32 WeaponSpeed = GetAttackTime(attType);
                chance = GetPPMProcChance(WeaponSpeed, spellData.SpellPPMRate, spellInfo);
            }
            else if (chance > 100.0f)
            {
                chance = GetWeaponProcChance();
            }

            if (roll_chance_f(chance) && sScriptMgr->OnCastItemCombatSpell(this, target, spellInfo, item))
                CastSpell(target, spellInfo->Id, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD), item);
        }
    }

    // item combat enchantments
    for (uint8 e_slot = 0; e_slot < MAX_ENCHANTMENT_SLOT; ++e_slot)
    {
        uint32 enchant_id = item->GetEnchantmentId(EnchantmentSlot(e_slot));
        SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
        if (!pEnchant)
            continue;

        for (uint8 s = 0; s < MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS; ++s)
        {
            if (pEnchant->type[s] != ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL)
                continue;

            SpellEnchantProcEntry const* entry = sSpellMgr->GetSpellEnchantProcEvent(enchant_id);

            if (entry && entry->procEx)
            {
                // Check hit/crit/dodge/parry requirement
                if ((entry->procEx & procEx) == 0)
                    continue;
            }
            else
            {
                // Can do effect if any damage done to target
                if (!(procVictim & PROC_FLAG_TAKEN_DAMAGE))
                    //if (!(damageInfo->procVictim & PROC_FLAG_TAKEN_ANY_DAMAGE))
                    continue;
            }

            if (entry && (entry->attributeMask & ENCHANT_PROC_ATTR_WHITE_HIT) && (procVictim & SPELL_PROC_FLAG_MASK))
                continue;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(pEnchant->spellid[s]);
            if (!spellInfo)
            {
                LOG_ERROR("entities.player", "Player::CastItemCombatSpell({}, name: {}, enchant: {}): unknown spell {} is casted, ignoring...",
                               GetGUID().ToString(), GetName(), pEnchant->ID, pEnchant->spellid[s]);
                continue;
            }

            if (entry && (entry->attributeMask & ENCHANT_PROC_ATTR_EXCLUSIVE) != 0)
            {
                Unit* checkTarget = spellInfo->IsPositive() ? this : target;
                if (checkTarget->HasAura(spellInfo->Id, GetGUID()))
                {
                    continue;
                }
            }

            float chance = pEnchant->amount[s] != 0 ? float(pEnchant->amount[s]) : GetWeaponProcChance();

            if (entry)
            {
                if (entry->PPMChance)
                    chance = GetPPMProcChance(proto->Delay, entry->PPMChance, spellInfo);
                else if (entry->customChance)
                    chance = (float)entry->customChance;
            }

            // Apply spell mods
            ApplySpellMod(pEnchant->spellid[s], SPELLMOD_CHANCE_OF_SUCCESS, chance);

            // Shiv has 100% chance to apply the poison
            if (FindCurrentSpellBySpellId(5938) && e_slot == TEMP_ENCHANTMENT_SLOT)
                chance = 100.0f;

            if (roll_chance_f(chance))
            {
                // Xinef: implement enchant charges
                if (uint32 charges = item->GetEnchantmentCharges(EnchantmentSlot(e_slot)))
                {
                    if (!--charges)
                    {
                        ApplyEnchantment(item, EnchantmentSlot(e_slot), false);
                        item->ClearEnchantment(EnchantmentSlot(e_slot));
                    }
                    else
                        item->SetEnchantmentCharges(EnchantmentSlot(e_slot), charges);
                }

                Unit* unitTarget = spellInfo->IsPositive() ? this : target;
                CastSpell(unitTarget, spellInfo, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD), item);
            }
        }
    }
}

void Player::CastItemUseSpell(Item* item, SpellCastTargets const& targets, uint8 cast_count, uint32 glyphIndex)
{
    if (!sScriptMgr->CanCastItemUseSpell(this, item, targets, cast_count, glyphIndex))
        return;

    ItemTemplate const* proto = item->GetTemplate();
    // special learning case
    if (proto->Spells[0].SpellId == 483 || proto->Spells[0].SpellId == 55884)
    {
        uint32 learn_spell_id = proto->Spells[0].SpellId;
        uint32 learning_spell_id = proto->Spells[1].SpellId;

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(learn_spell_id);
        if (!spellInfo)
        {
            LOG_ERROR("entities.player", "Player::CastItemUseSpell: Item (Entry: {}) in have wrong spell id {}, ignoring ", proto->ItemId, learn_spell_id);
            SendEquipError(EQUIP_ERR_NONE, item, nullptr);
            return;
        }

        Spell* spell = new Spell(this, spellInfo, TRIGGERED_NONE);
        spell->m_CastItem = item;
        spell->m_cast_count = cast_count;                   //set count of casts
        spell->SetSpellValue(SPELLVALUE_BASE_POINT0, learning_spell_id);
        spell->prepare(&targets);
        return;
    }

    // use triggered flag only for items with many spell casts and for not first cast
    uint8 count = 0;

    std::list<Spell*> pushSpells;
    // item spells casted at use
    for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
    {
        _Spell const& spellData = proto->Spells[i];

        // no spell
        if (!spellData.SpellId)
            continue;

        // wrong triggering type
        if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
            continue;

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellData.SpellId);
        if (!spellInfo)
        {
            LOG_ERROR("entities.player", "Player::CastItemUseSpell: Item (Entry: {}) in have wrong spell id {}, ignoring", proto->ItemId, spellData.SpellId);
            continue;
        }

        if (HasSpellCooldown(spellInfo->Id))
        {
            continue;
        }

        if (!spellInfo->CheckElixirStacking(this))
        {
            Spell::SendCastResult(this, spellInfo, cast_count, SPELL_FAILED_AURA_BOUNCED);
            continue;
        }

        Spell* spell = new Spell(this, spellInfo, (count > 0) ? TRIGGERED_FULL_MASK : TRIGGERED_NONE);
        spell->m_CastItem = item;
        spell->m_cast_count = cast_count;                   // set count of casts
        spell->m_glyphIndex = glyphIndex;                   // glyph index
        spell->InitExplicitTargets(targets);

        // Xinef: dont allow to cast such spells, it may happen that spell possess 2 spells, one for players and one for items / gameobjects
        // Xinef: if first one is cast on player, it may be deleted thus resulting in crash because second spell has saved pointer to the item
        // Xinef: there is one problem with scripts which wont be loaded at the moment of call
        SpellCastResult result = spell->CheckCast(true);
        if (result != SPELL_CAST_OK)
        {
            spell->SendCastResult(result);
            delete spell;
            continue;
        }

        pushSpells.push_back(spell);
        //spell->prepare(&targets);

        ++count;
    }

    // Item enchantments spells casted at use
    for (uint8 e_slot = 0; e_slot < MAX_ENCHANTMENT_SLOT; ++e_slot)
    {
        uint32 enchant_id = item->GetEnchantmentId(EnchantmentSlot(e_slot));
        SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
        if (!pEnchant)
            continue;
        for (uint8 s = 0; s < MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS; ++s)
        {
            if (pEnchant->type[s] != ITEM_ENCHANTMENT_TYPE_USE_SPELL)
                continue;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(pEnchant->spellid[s]);
            if (!spellInfo)
            {
                LOG_ERROR("entities.player", "Player::CastItemUseSpell Enchant {}, cast unknown spell {}", pEnchant->ID, pEnchant->spellid[s]);
                continue;
            }

            if (HasSpellCooldown(spellInfo->Id))
                continue;

            Spell* spell = new Spell(this, spellInfo, (count > 0) ? TRIGGERED_FULL_MASK : TRIGGERED_NONE);
            spell->m_CastItem = item;
            spell->m_cast_count = cast_count;               // set count of casts
            spell->m_glyphIndex = glyphIndex;               // glyph index
            spell->InitExplicitTargets(targets);

            // Xinef: dont allow to cast such spells, it may happen that spell possess 2 spells, one for players and one for items / gameobjects
            // Xinef: if first one is cast on player, it may be deleted thus resulting in crash because second spell has saved pointer to the item
            // Xinef: there is one problem with scripts which wont be loaded at the moment of call
            SpellCastResult result = spell->CheckCast(true);
            if (result != SPELL_CAST_OK)
            {
                spell->SendCastResult(result);
                delete spell;
                continue;
            }

            pushSpells.push_back(spell);
            //spell->prepare(&targets);

            ++count;
        }
    }

    // xinef: send all spells in one go, prevents crash because container is not set
    for (std::list<Spell*>::const_iterator itr = pushSpells.begin(); itr != pushSpells.end(); ++itr)
        (*itr)->prepare(&targets);
}

void Player::_RemoveAllItemMods()
{
    LOG_DEBUG("entities.player.items", "_RemoveAllItemMods start.");

    for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
    {
        if (m_items[i])
        {
            ItemTemplate const* proto = m_items[i]->GetTemplate();
            if (!proto)
                continue;

            // item set bonuses not dependent from item broken state
            if (proto->ItemSet)
                RemoveItemsSetItem(this, proto);

            if (m_items[i]->IsBroken() || !CanUseAttackType(GetAttackBySlot(i)))
                continue;

            ApplyItemEquipSpell(m_items[i], false);
            ApplyEnchantment(m_items[i], false);
        }
    }

    for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
    {
        if (m_items[i])
        {
            if (m_items[i]->IsBroken() || !CanUseAttackType(GetAttackBySlot(i)))
                continue;
            ItemTemplate const* proto = m_items[i]->GetTemplate();
            if (!proto)
                continue;

            uint32 attacktype = Player::GetAttackBySlot(i);
            if (attacktype < MAX_ATTACK)
                _ApplyWeaponDependentAuraMods(m_items[i], WeaponAttackType(attacktype), false);

            _ApplyItemBonuses(proto, i, false);

            if (i == EQUIPMENT_SLOT_RANGED)
                _ApplyAmmoBonuses();
        }
    }

    LOG_DEBUG("entities.player.items", "_RemoveAllItemMods complete.");
}

void Player::_ApplyAllItemMods()
{
    LOG_DEBUG("entities.player.items", "_ApplyAllItemMods start.");

    for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
    {
        if (m_items[i])
        {
            if (m_items[i]->IsBroken() || !CanUseAttackType(GetAttackBySlot(i)))
                continue;

            ItemTemplate const* proto = m_items[i]->GetTemplate();
            if (!proto)
                continue;

            uint32 attacktype = Player::GetAttackBySlot(i);
            if (attacktype < MAX_ATTACK)
                _ApplyWeaponDependentAuraMods(m_items[i], WeaponAttackType(attacktype), true);

            _ApplyItemBonuses(proto, i, true);

            if (i == EQUIPMENT_SLOT_RANGED)
                _ApplyAmmoBonuses();
        }
    }

    for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
    {
        if (m_items[i])
        {
            ItemTemplate const* proto = m_items[i]->GetTemplate();
            if (!proto)
                continue;

            // item set bonuses not dependent from item broken state
            if (proto->ItemSet)
                AddItemsSetItem(this, m_items[i]);

            if (m_items[i]->IsBroken() || !CanUseAttackType(GetAttackBySlot(i)))
                continue;

            ApplyItemEquipSpell(m_items[i], true);
            ApplyEnchantment(m_items[i], true);
        }
    }

    LOG_DEBUG("entities.player.items", "_ApplyAllItemMods complete.");
}

void Player::_ApplyAllLevelScaleItemMods(bool apply)
{
    for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
    {
        if (m_items[i])
        {
            if (m_items[i]->IsBroken() || !CanUseAttackType(GetAttackBySlot(i)))
                continue;

            ItemTemplate const* proto = m_items[i]->GetTemplate();
            if (!proto)
                continue;

            _ApplyItemMods(m_items[i], i, apply);
        }
    }
}

void Player::_ApplyAmmoBonuses()
{
    // check ammo
    uint32 ammo_id = GetUInt32Value(PLAYER_AMMO_ID);
    if (!ammo_id)
        return;

    float currentAmmoDPS;

    ItemTemplate const* ammo_proto = sObjectMgr->GetItemTemplate(ammo_id);
    if (!ammo_proto || ammo_proto->Class != ITEM_CLASS_PROJECTILE || !CheckAmmoCompatibility(ammo_proto))
        currentAmmoDPS = 0.0f;
    else
        currentAmmoDPS = (ammo_proto->Damage[0].DamageMin + ammo_proto->Damage[0].DamageMax) / 2;

    sScriptMgr->OnApplyAmmoBonuses(this, ammo_proto, currentAmmoDPS);

    if (currentAmmoDPS == GetAmmoDPS())
        return;

    m_ammoDPS = currentAmmoDPS;

    if (CanModifyStats())
        UpdateDamagePhysical(RANGED_ATTACK);
}

bool Player::CheckAmmoCompatibility(ItemTemplate const* ammo_proto) const
{
    if (!ammo_proto)
        return false;

    // check ranged weapon
    Item* weapon = GetWeaponForAttack(RANGED_ATTACK);
    if (!weapon  || weapon->IsBroken())
        return false;

    ItemTemplate const* weapon_proto = weapon->GetTemplate();
    if (!weapon_proto || weapon_proto->Class != ITEM_CLASS_WEAPON)
        return false;

    // check ammo ws. weapon compatibility
    switch (weapon_proto->SubClass)
    {
        case ITEM_SUBCLASS_WEAPON_BOW:
        case ITEM_SUBCLASS_WEAPON_CROSSBOW:
            if (ammo_proto->SubClass != ITEM_SUBCLASS_ARROW)
                return false;
            break;
        case ITEM_SUBCLASS_WEAPON_GUN:
            if (ammo_proto->SubClass != ITEM_SUBCLASS_BULLET)
                return false;
            break;
        default:
            return false;
    }

    return true;
}

void Player::SendQuestGiverStatusMultiple()
{
    uint32 count = 0;

    WorldPacket data(SMSG_QUESTGIVER_STATUS_MULTIPLE, 4);
    data << uint32(count); // placeholder

    for (GuidUnorderedSet::const_iterator itr = m_clientGUIDs.begin(); itr != m_clientGUIDs.end(); ++itr)
    {
        uint32 questStatus = DIALOG_STATUS_NONE;

        if ((*itr).IsAnyTypeCreature())
        {
            // need also pet quests case support
            Creature* questgiver = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, *itr);
            if (!questgiver || questgiver->IsHostileTo(this))
                continue;
            if (!questgiver->HasNpcFlag(UNIT_NPC_FLAG_QUESTGIVER))
                continue;

            questStatus = GetQuestDialogStatus(questgiver);

            data << questgiver->GetGUID();
            data << uint8(questStatus);
            ++count;
        }
        else if ((*itr).IsGameObject())
        {
            GameObject* questgiver = GetMap()->GetGameObject(*itr);
            if (!questgiver || questgiver->GetGoType() != GAMEOBJECT_TYPE_QUESTGIVER)
                continue;

            questStatus = GetQuestDialogStatus(questgiver);

            data << questgiver->GetGUID();
            data << uint8(questStatus);
            ++count;
        }
    }

    data.put<uint32>(0, count); // write real count
    GetSession()->SendPacket(&data);
}

/*  If in a battleground a player dies, and an enemy removes the insignia, the player's bones is lootable
    Called by remove insignia spell effect    */
void Player::RemovedInsignia(Player* looterPlr)
{
    // Xinef: If player is not in battleground and not in wintergrasp
    if (!GetBattlegroundId() && GetZoneId() != AREA_WINTERGRASP)
        return;

    // If not released spirit, do it !
    if (m_deathTimer > 0)
    {
        m_deathTimer = 0;
        BuildPlayerRepop();
        RepopAtGraveyard();
    }

    _corpseLocation.WorldRelocate();

    // We have to convert player corpse to bones, not to be able to resurrect there
    // SpawnCorpseBones isn't handy, 'cos it saves player while he in BG
    Corpse* bones = GetMap()->ConvertCorpseToBones(GetGUID(), true);
    if (!bones)
        return;

    // Now we must make bones lootable, and send player loot
    bones->SetFlag(CORPSE_FIELD_DYNAMIC_FLAGS, CORPSE_DYNFLAG_LOOTABLE);

    // We store the level of our player in the gold field
    // We retrieve this information at Player::SendLoot()
    bones->loot.gold = GetLevel();
    bones->lootRecipient = looterPlr;
    looterPlr->SendLoot(bones->GetGUID(), LOOT_INSIGNIA);
}

void Player::SendLootRelease(ObjectGuid guid)
{
    WorldPacket data(SMSG_LOOT_RELEASE_RESPONSE, (8 + 1));
    data << guid << uint8(1);
    SendDirectMessage(&data);
}

void Player::SendLoot(ObjectGuid guid, LootType loot_type)
{
    if (ObjectGuid lguid = GetLootGUID())
        m_session->DoLootRelease(lguid);

    Loot* loot = 0;
    PermissionTypes permission = ALL_PERMISSION;

    LOG_DEBUG("loot", "Player::SendLoot");

    // remove FD and invisibility at all loots
    constexpr std::array<AuraType, 2> toRemove = {SPELL_AURA_MOD_INVISIBILITY, SPELL_AURA_FEIGN_DEATH};
    for (auto const& aura : toRemove)
    {
        RemoveAurasByType(aura);
    }
    // remove stealth only if looting a corpse
    if (loot_type == LOOT_CORPSE && !guid.IsItem())
    {
        RemoveAurasByType(SPELL_AURA_MOD_STEALTH);
    }

    if (guid.IsGameObject())
    {
        LOG_DEBUG("loot", "guid.IsGameObject");
        GameObject* go = GetMap()->GetGameObject(guid);

        // not check distance for GO in case owned GO (fishing bobber case, for example)
        // And permit out of range GO with no owner in case fishing hole
        if (!go || (loot_type != LOOT_FISHINGHOLE && ((loot_type != LOOT_FISHING && loot_type != LOOT_FISHING_JUNK) || go->GetOwnerGUID() != GetGUID()) && !go->IsWithinDistInMap(this)) || (loot_type == LOOT_CORPSE && go->GetRespawnTime() && go->isSpawnedByDefault()))
        {
            go->ForceValuesUpdateAtIndex(GAMEOBJECT_BYTES_1);
            SendLootRelease(guid);
            return;
        }

        loot = &go->loot;

        // Xinef: loot was generated and respawntime has passed since then, allow to recreate loot
        // Xinef: to avoid bugs, this rule covers spawned gameobjects only
        if (go->isSpawnedByDefault() && go->getLootState() == GO_ACTIVATED && !go->loot.isLooted() && go->GetLootGenerationTime() + go->GetRespawnDelay() < GameTime::GetGameTime().count())
            go->SetLootState(GO_READY);

        if (go->getLootState() == GO_READY)
        {
            uint32 lootid = go->GetGOInfo()->GetLootId();

            //TODO: fix this big hack
            if ((go->GetEntry() == BG_AV_OBJECTID_MINE_N || go->GetEntry() == BG_AV_OBJECTID_MINE_S))
                if (Battleground* bg = GetBattleground())
                    if (bg->GetBgTypeID(true) == BATTLEGROUND_AV)
                        if (!bg->ToBattlegroundAV()->PlayerCanDoMineQuest(go->GetEntry(), GetTeamId()))
                        {
                            go->ForceValuesUpdateAtIndex(GAMEOBJECT_BYTES_1);
                            SendLootRelease(guid);
                            return;
                        }

            if (lootid)
            {
                loot->clear();

                Group* group = GetGroup();
                bool groupRules = (group && go->GetGOInfo()->type == GAMEOBJECT_TYPE_CHEST && go->GetGOInfo()->chest.groupLootRules);

                // check current RR player and get next if necessary
                if (groupRules)
                    group->UpdateLooterGuid(go, true);

                loot->FillLoot(lootid, LootTemplates_Gameobject, this, !groupRules, false, go->GetLootMode(), go);
                go->SetLootGenerationTime();

                // get next RR player (for next loot)
                if (groupRules && !go->loot.empty())
                    group->UpdateLooterGuid(go);
            }
            if (GameObjectTemplateAddon const* addon = go->GetTemplateAddon())
                loot->generateMoneyLoot(addon->mingold, addon->maxgold);

            if (loot_type == LOOT_FISHING)
                go->GetFishLoot(loot, this);
            else if (loot_type == LOOT_FISHING_JUNK)
                go->GetFishLootJunk(loot, this);

            if (go->GetGOInfo()->type == GAMEOBJECT_TYPE_CHEST && go->GetGOInfo()->chest.groupLootRules)
            {
                if (Group* group = GetGroup())
                {
                    switch (group->GetLootMethod())
                    {
                        case GROUP_LOOT:
                            // GroupLoot: rolls items over threshold. Items with quality < threshold, round robin
                            group->GroupLoot(loot, go);
                            break;
                        case NEED_BEFORE_GREED:
                            group->NeedBeforeGreed(loot, go);
                            break;
                        case MASTER_LOOT:
                            group->MasterLoot(loot, go);
                            break;
                        default:
                            break;
                    }
                }
            }

            go->SetLootState(GO_ACTIVATED, this);
        }

        if (go->getLootState() == GO_ACTIVATED)
        {
            if (Group* group = GetGroup())
            {
                switch (group->GetLootMethod())
                {
                    case MASTER_LOOT:
                        permission = group->GetMasterLooterGuid() == GetGUID() ? MASTER_PERMISSION : RESTRICTED_PERMISSION;
                        break;
                    case FREE_FOR_ALL:
                        permission = ALL_PERMISSION;
                        break;
                    case ROUND_ROBIN:
                        permission = ROUND_ROBIN_PERMISSION;
                        break;
                    default:
                        permission = GROUP_PERMISSION;
                        break;
                }
            }
            else
                permission = ALL_PERMISSION;
        }
    }
    else if (guid.IsItem())
    {
        Item* item = GetItemByGuid(guid);

        if (!item)
        {
            SendLootRelease(guid);
            return;
        }

        permission = OWNER_PERMISSION;

        loot = &item->loot;

        // Xinef: Store container id
        loot->containerGUID = item->GetGUID();

        if (!item->m_lootGenerated && !sLootItemStorage->LoadStoredLoot(item, this))
        {
            item->m_lootGenerated = true;
            loot->clear();

            switch (loot_type)
            {
                case LOOT_DISENCHANTING:
                    loot->FillLoot(item->GetTemplate()->DisenchantID, LootTemplates_Disenchant, this, true);
                    break;
                case LOOT_PROSPECTING:
                    loot->FillLoot(item->GetEntry(), LootTemplates_Prospecting, this, true);
                    break;
                case LOOT_MILLING:
                    loot->FillLoot(item->GetEntry(), LootTemplates_Milling, this, true);
                    break;
                default:
                    loot->generateMoneyLoot(item->GetTemplate()->MinMoneyLoot, item->GetTemplate()->MaxMoneyLoot);
                    loot->FillLoot(item->GetEntry(), LootTemplates_Item, this, true, loot->gold != 0);

                    // Xinef: Add to storage
                    if (loot->gold > 0 || loot->unlootedCount > 0)
                        sLootItemStorage->AddNewStoredLoot(loot, this);

                    break;
            }
        }
    }
    else if (guid.IsCorpse())                          // remove insignia
    {
        Corpse* bones = ObjectAccessor::GetCorpse(*this, guid);

        if (!bones || !(loot_type == LOOT_CORPSE || loot_type == LOOT_INSIGNIA) || bones->GetType() != CORPSE_BONES || !bones->HasFlag(CORPSE_FIELD_DYNAMIC_FLAGS, CORPSE_DYNFLAG_LOOTABLE))
        {
            SendLootRelease(guid);
            return;
        }

        loot = &bones->loot;

        if (loot->loot_type == LOOT_NONE)
        {
            uint32 pLevel = bones->loot.gold;
            bones->loot.clear();

            loot->FillLoot(GetTeamId(), LootTemplates_Player, this, true);

            // It may need a better formula
            // Now it works like this: lvl10: ~6copper, lvl70: ~9silver
            bones->loot.gold = uint32(urand(50, 150) * 0.016f * pow(float(pLevel) / 5.76f, 2.5f) * sWorld->getRate(RATE_DROP_MONEY));
        }

        if (bones->lootRecipient != this)
            permission = NONE_PERMISSION;
        else
            permission = OWNER_PERMISSION;
    }
    else
    {
        Creature* creature = GetMap()->GetCreature(guid);

        // must be in range and creature must be alive for pickpocket and must be dead for another loot
        if (!creature || creature->IsAlive() != (loot_type == LOOT_PICKPOCKETING) || !creature->IsWithinDistInMap(this, INTERACTION_DISTANCE))
        {
            SendLootRelease(guid);
            return;
        }

        if (loot_type == LOOT_PICKPOCKETING && IsFriendlyTo(creature))
        {
            SendLootRelease(guid);
            return;
        }

        loot = &creature->loot;

        if (loot_type == LOOT_PICKPOCKETING)
        {
            if (!loot || loot->loot_type != LOOT_PICKPOCKETING)
            {
                if (creature->CanGeneratePickPocketLoot())
                {
                    creature->SetPickPocketLootTime();
                    loot->clear();

                    if (uint32 lootid = creature->GetCreatureTemplate()->pickpocketLootId)
                        loot->FillLoot(lootid, LootTemplates_Pickpocketing, this, true);

                    // Generate extra money for pick pocket loot
                    const uint32 a = urand(0, creature->GetLevel() / 2);
                    const uint32 b = urand(0, GetLevel() / 2);
                    loot->gold = uint32(10 * (a + b) * sWorld->getRate(RATE_DROP_MONEY));
                    permission = OWNER_PERMISSION;
                }
                else
                {
                    permission = NONE_PERMISSION;
                    SendLootError(guid, LOOT_ERROR_ALREADY_PICKPOCKETED);
                    return;
                }
            }
        }
        else
        {
            // Xinef: Exploit fix
            if (!creature->HasDynamicFlag(UNIT_DYNFLAG_LOOTABLE))
            {
                SendLootError(guid, LOOT_ERROR_DIDNT_KILL);
                return;
            }

            // the player whose group may loot the corpse
            Player* recipient = creature->GetLootRecipient();
            Group* recipientGroup = creature->GetLootRecipientGroup();
            if (!recipient && !recipientGroup)
                return;

            if (loot->loot_type == LOOT_NONE)
            {
                // for creature, loot is filled when creature is killed.
                if (recipientGroup)
                {
                    switch (recipientGroup->GetLootMethod())
                    {
                        case GROUP_LOOT:
                            // GroupLoot: rolls items over threshold. Items with quality < threshold, round robin
                            recipientGroup->GroupLoot(loot, creature);
                            break;
                        case NEED_BEFORE_GREED:
                            recipientGroup->NeedBeforeGreed(loot, creature);
                            break;
                        case MASTER_LOOT:
                            recipientGroup->MasterLoot(loot, creature);
                            break;
                        default:
                            break;
                    }
                }
            }

            // if loot is already skinning loot then don't do anything else
            if (loot->loot_type == LOOT_SKINNING)
            {
                loot_type = LOOT_SKINNING;
                permission = creature->GetLootRecipientGUID() == GetGUID() ? OWNER_PERMISSION : NONE_PERMISSION;
            }
            else if (loot_type == LOOT_SKINNING)
            {
                loot->clear();
                loot->FillLoot(creature->GetCreatureTemplate()->SkinLootId, LootTemplates_Skinning, this, true);
                permission = OWNER_PERMISSION;

                //Inform instance if creature is skinned.
                if (InstanceScript* mapInstance = creature->GetInstanceScript())
                {
                    mapInstance->CreatureLooted(creature, LOOT_SKINNING);
                }

                // Xinef: Set new loot recipient
                creature->SetLootRecipient(this, false);
            }
            // set group rights only for loot_type != LOOT_SKINNING
            else
            {
                if (recipientGroup)
                {
                    if (GetGroup() == recipientGroup)
                    {
                        switch (recipientGroup->GetLootMethod())
                        {
                            case MASTER_LOOT:
                                permission = recipientGroup->GetMasterLooterGuid() == GetGUID() ? MASTER_PERMISSION : RESTRICTED_PERMISSION;
                                break;
                            case FREE_FOR_ALL:
                                permission = ALL_PERMISSION;
                                break;
                            case ROUND_ROBIN:
                                permission = ROUND_ROBIN_PERMISSION;
                                break;
                            default:
                                permission = GROUP_PERMISSION;
                                break;
                        }
                    }
                    else
                        permission = NONE_PERMISSION;
                }
                else if (recipient == this)
                    permission = OWNER_PERMISSION;
                else
                    permission = NONE_PERMISSION;
            }
        }
    }

    // LOOT_INSIGNIA and LOOT_FISHINGHOLE unsupported by client
    switch (loot_type)
    {
        case LOOT_INSIGNIA:
            loot_type = LOOT_SKINNING;
            break;
        case LOOT_FISHINGHOLE:
            loot_type = LOOT_FISHING;
            break;
        case LOOT_FISHING_JUNK:
            loot_type = LOOT_FISHING;
            break;
        default:
            break;
    }

    // need know merged fishing/corpse loot type for achievements
    loot->loot_type = loot_type;

    if (!sScriptMgr->OnAllowedToLootContainerCheck(this, guid))
    {
        SendLootError(guid, LOOT_ERROR_DIDNT_KILL);
        return;
    }

    if (permission != NONE_PERMISSION)
    {
        SetLootGUID(guid);

        WorldPacket data(SMSG_LOOT_RESPONSE, (9 + 50));         // we guess size
        data << guid;
        data << uint8(loot_type);
        data << LootView(*loot, this, permission);

        SendDirectMessage(&data);

        // add 'this' player as one of the players that are looting 'loot'
        loot->AddLooter(GetGUID());

        if (loot_type == LOOT_CORPSE && !guid.IsItem())
            SetUnitFlag(UNIT_FLAG_LOOTING);
    }
    else
        SendLootError(guid, LOOT_ERROR_DIDNT_KILL);
}

void Player::SendLootError(ObjectGuid guid, LootError error)
{
    WorldPacket data(SMSG_LOOT_RESPONSE, 10);
    data << guid;
    data << uint8(LOOT_NONE);
    data << uint8(error);
    SendDirectMessage(&data);
}

void Player::SendNotifyLootMoneyRemoved()
{
    WorldPacket data(SMSG_LOOT_CLEAR_MONEY, 0);
    GetSession()->SendPacket(&data);
}

void Player::SendNotifyLootItemRemoved(uint8 lootSlot)
{
    WorldPacket data(SMSG_LOOT_REMOVED, 1);
    data << uint8(lootSlot);
    GetSession()->SendPacket(&data);
}

void Player::SendInitWorldStates(uint32 zoneid, uint32 areaid)
{
    // data depends on zoneid/mapid...
    Battleground* bg = GetBattleground();
    uint32 mapid = GetMapId();
    OutdoorPvP* pvp = sOutdoorPvPMgr->GetOutdoorPvPToZoneId(zoneid);
    InstanceScript* instance = GetInstanceScript();
    Battlefield* bf = sBattlefieldMgr->GetBattlefieldToZoneId(zoneid);

    LOG_DEBUG("network", "Sending SMSG_INIT_WORLD_STATES to Map: {}, Zone: {}", mapid, zoneid);

    WorldPacket data(SMSG_INIT_WORLD_STATES, (4 + 4 + 4 + 2 + (12 * 8)));
    data << uint32(mapid);                                  // mapid
    data << uint32(zoneid);                                 // zone id
    data << uint32(areaid);                                 // area id, new 2.1.0
    std::size_t countPos = data.wpos();
    data << uint16(0);                                      // count of uint64 blocks
    data << uint32(0x8d8) << uint32(0x0);                   // 1
    data << uint32(0x8d7) << uint32(0x0);                   // 2
    data << uint32(0x8d6) << uint32(0x0);                   // 3
    data << uint32(0x8d5) << uint32(0x0);                   // 4
    data << uint32(0x8d4) << uint32(0x0);                   // 5
    data << uint32(0x8d3) << uint32(0x0);                   // 6
    // 7 1 - Arena season in progress, 0 - end of season
    data << uint32(0xC77) << uint32(sWorld->getBoolConfig(CONFIG_ARENA_SEASON_IN_PROGRESS));
    // 8 Arena season id
    data << uint32(0xF3D) << uint32(sWorld->getIntConfig(CONFIG_ARENA_SEASON_ID));

    if (mapid == 530)                                       // Outland
    {
        data << uint32(0x9bf) << uint32(0x0);               // 7
        data << uint32(0x9bd) << uint32(0xF);               // 8
        data << uint32(0x9bb) << uint32(0xF);               // 9
    }

    if (Player::bgZoneIdToFillWorldStates.find(zoneid) != Player::bgZoneIdToFillWorldStates.end())
    {
        Player::bgZoneIdToFillWorldStates[zoneid](bg, data);
    }
    else
    {
        // insert <field> <value>
        switch (zoneid)
        {
            case 1:                                             // Dun Morogh
            case 11:                                            // Wetlands
            case 12:                                            // Elwynn Forest
            case 38:                                            // Loch Modan
            case 40:                                            // Westfall
            case 51:                                            // Searing Gorge
            case 1519:                                          // Stormwind City
            case 1537:                                          // Ironforge
            case 2257:                                          // Deeprun Tram
            case 3703:                                          // Shattrath City
                break;
            case 139:                                           // Eastern Plaguelands
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_EP)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0x97a) << uint32(0x0); // 10 2426
                    data << uint32(0x917) << uint32(0x0); // 11 2327
                    data << uint32(0x918) << uint32(0x0); // 12 2328
                    data << uint32(0x97b) << uint32(0x32); // 13 2427
                    data << uint32(0x97c) << uint32(0x32); // 14 2428
                    data << uint32(0x933) << uint32(0x1); // 15 2355
                    data << uint32(0x946) << uint32(0x0); // 16 2374
                    data << uint32(0x947) << uint32(0x0); // 17 2375
                    data << uint32(0x948) << uint32(0x0); // 18 2376
                    data << uint32(0x949) << uint32(0x0); // 19 2377
                    data << uint32(0x94a) << uint32(0x0); // 20 2378
                    data << uint32(0x94b) << uint32(0x0); // 21 2379
                    data << uint32(0x932) << uint32(0x0); // 22 2354
                    data << uint32(0x934) << uint32(0x0); // 23 2356
                    data << uint32(0x935) << uint32(0x0); // 24 2357
                    data << uint32(0x936) << uint32(0x0); // 25 2358
                    data << uint32(0x937) << uint32(0x0); // 26 2359
                    data << uint32(0x938) << uint32(0x0); // 27 2360
                    data << uint32(0x939) << uint32(0x1); // 28 2361
                    data << uint32(0x930) << uint32(0x1); // 29 2352
                    data << uint32(0x93a) << uint32(0x0); // 30 2362
                    data << uint32(0x93b) << uint32(0x0); // 31 2363
                    data << uint32(0x93c) << uint32(0x0); // 32 2364
                    data << uint32(0x93d) << uint32(0x0); // 33 2365
                    data << uint32(0x944) << uint32(0x0); // 34 2372
                    data << uint32(0x945) << uint32(0x0); // 35 2373
                    data << uint32(0x931) << uint32(0x1); // 36 2353
                    data << uint32(0x93e) << uint32(0x0); // 37 2366
                    data << uint32(0x931) << uint32(0x1); // 38 2367 ??  grey horde not in dbc! send for consistency's sake, and to match field count
                    data << uint32(0x940) << uint32(0x0); // 39 2368
                    data << uint32(0x941) << uint32(0x0); // 7 2369
                    data << uint32(0x942) << uint32(0x0); // 8 2370
                    data << uint32(0x943) << uint32(0x0); // 9 2371
                }
                break;
            case 1377:                                          // Silithus
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_SI)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    // states are always shown
                    data << uint32(2313) << uint32(0x0); // 7 ally silityst gathered
                    data << uint32(2314) << uint32(0x0); // 8 horde silityst gathered
                    data << uint32(2317) << uint32(0x0); // 9 max silithyst
                }
                // dunno about these... aq opening event maybe?
                data << uint32(2322) << uint32(0x0); // 10 sandworm N
                data << uint32(2323) << uint32(0x0); // 11 sandworm S
                data << uint32(2324) << uint32(0x0); // 12 sandworm SW
                data << uint32(2325) << uint32(0x0); // 13 sandworm E
                break;
            case 2597:                                          // Alterac Valley
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_AV)
                    bg->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0x7ae) << uint32(0x1);           // 7 snowfall n
                    data << uint32(0x532) << uint32(0x1);           // 8 frostwolfhut hc
                    data << uint32(0x531) << uint32(0x0);           // 9 frostwolfhut ac
                    data << uint32(0x52e) << uint32(0x0);           // 10 stormpike firstaid a_a
                    data << uint32(0x571) << uint32(0x0);           // 11 east frostwolf tower horde assaulted -unused
                    data << uint32(0x570) << uint32(0x0);           // 12 west frostwolf tower horde assaulted - unused
                    data << uint32(0x567) << uint32(0x1);           // 13 frostwolfe c
                    data << uint32(0x566) << uint32(0x1);           // 14 frostwolfw c
                    data << uint32(0x550) << uint32(0x1);           // 15 irondeep (N) ally
                    data << uint32(0x544) << uint32(0x0);           // 16 ice grave a_a
                    data << uint32(0x536) << uint32(0x0);           // 17 stormpike grave h_c
                    data << uint32(0x535) << uint32(0x1);           // 18 stormpike grave a_c
                    data << uint32(0x518) << uint32(0x0);           // 19 stoneheart grave a_a
                    data << uint32(0x517) << uint32(0x0);           // 20 stoneheart grave h_a
                    data << uint32(0x574) << uint32(0x0);           // 21 1396 unk
                    data << uint32(0x573) << uint32(0x0);           // 22 iceblood tower horde assaulted -unused
                    data << uint32(0x572) << uint32(0x0);           // 23 towerpoint horde assaulted - unused
                    data << uint32(0x56f) << uint32(0x0);           // 24 1391 unk
                    data << uint32(0x56e) << uint32(0x0);           // 25 iceblood a
                    data << uint32(0x56d) << uint32(0x0);           // 26 towerp a
                    data << uint32(0x56c) << uint32(0x0);           // 27 frostwolfe a
                    data << uint32(0x56b) << uint32(0x0);           // 28 froswolfw a
                    data << uint32(0x56a) << uint32(0x1);           // 29 1386 unk
                    data << uint32(0x569) << uint32(0x1);           // 30 iceblood c
                    data << uint32(0x568) << uint32(0x1);           // 31 towerp c
                    data << uint32(0x565) << uint32(0x0);           // 32 stoneh tower a
                    data << uint32(0x564) << uint32(0x0);           // 33 icewing tower a
                    data << uint32(0x563) << uint32(0x0);           // 34 dunn a
                    data << uint32(0x562) << uint32(0x0);           // 35 duns a
                    data << uint32(0x561) << uint32(0x0);           // 36 stoneheart bunker alliance assaulted - unused
                    data << uint32(0x560) << uint32(0x0);           // 37 icewing bunker alliance assaulted - unused
                    data << uint32(0x55f) << uint32(0x0);           // 38 dunbaldar south alliance assaulted - unused
                    data << uint32(0x55e) << uint32(0x0);           // 39 dunbaldar north alliance assaulted - unused
                    data << uint32(0x55d) << uint32(0x0);           // 40 stone tower d
                    data << uint32(0x3c6) << uint32(0x0);           // 41 966 unk
                    data << uint32(0x3c4) << uint32(0x0);           // 42 964 unk
                    data << uint32(0x3c2) << uint32(0x0);           // 43 962 unk
                    data << uint32(0x516) << uint32(0x1);           // 44 stoneheart grave a_c
                    data << uint32(0x515) << uint32(0x0);           // 45 stonheart grave h_c
                    data << uint32(0x3b6) << uint32(0x0);           // 46 950 unk
                    data << uint32(0x55c) << uint32(0x0);           // 47 icewing tower d
                    data << uint32(0x55b) << uint32(0x0);           // 48 dunn d
                    data << uint32(0x55a) << uint32(0x0);           // 49 duns d
                    data << uint32(0x559) << uint32(0x0);           // 50 1369 unk
                    data << uint32(0x558) << uint32(0x0);           // 51 iceblood d
                    data << uint32(0x557) << uint32(0x0);           // 52 towerp d
                    data << uint32(0x556) << uint32(0x0);           // 53 frostwolfe d
                    data << uint32(0x555) << uint32(0x0);           // 54 frostwolfw d
                    data << uint32(0x554) << uint32(0x1);           // 55 stoneh tower c
                    data << uint32(0x553) << uint32(0x1);           // 56 icewing tower c
                    data << uint32(0x552) << uint32(0x1);           // 57 dunn c
                    data << uint32(0x551) << uint32(0x1);           // 58 duns c
                    data << uint32(0x54f) << uint32(0x0);           // 59 irondeep (N) horde
                    data << uint32(0x54e) << uint32(0x0);           // 60 irondeep (N) ally
                    data << uint32(0x54d) << uint32(0x1);           // 61 mine (S) neutral
                    data << uint32(0x54c) << uint32(0x0);           // 62 mine (S) horde
                    data << uint32(0x54b) << uint32(0x0);           // 63 mine (S) ally
                    data << uint32(0x545) << uint32(0x0);           // 64 iceblood h_a
                    data << uint32(0x543) << uint32(0x1);           // 65 iceblod h_c
                    data << uint32(0x542) << uint32(0x0);           // 66 iceblood a_c
                    data << uint32(0x540) << uint32(0x0);           // 67 snowfall h_a
                    data << uint32(0x53f) << uint32(0x0);           // 68 snowfall a_a
                    data << uint32(0x53e) << uint32(0x0);           // 69 snowfall h_c
                    data << uint32(0x53d) << uint32(0x0);           // 70 snowfall a_c
                    data << uint32(0x53c) << uint32(0x0);           // 71 frostwolf g h_a
                    data << uint32(0x53b) << uint32(0x0);           // 72 frostwolf g a_a
                    data << uint32(0x53a) << uint32(0x1);           // 73 frostwolf g h_c
                    data << uint32(0x539) << uint32(0x0);           // 74 frostwolf g a_c
                    data << uint32(0x538) << uint32(0x0);           // 75 stormpike grave h_a
                    data << uint32(0x537) << uint32(0x0);           // 76 stormpike grave a_a
                    data << uint32(0x534) << uint32(0x0);           // 77 frostwolf hut h_a
                    data << uint32(0x533) << uint32(0x0);           // 78 frostwolf hut a_a
                    data << uint32(0x530) << uint32(0x0);           // 79 stormpike first aid h_a
                    data << uint32(0x52f) << uint32(0x0);           // 80 stormpike first aid h_c
                    data << uint32(0x52d) << uint32(0x1);           // 81 stormpike first aid a_c
                }
                break;
            case 3277:                                          // Warsong Gulch
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_WS)
                    bg->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0x62d) << uint32(0x0);       // 7 1581 alliance flag captures
                    data << uint32(0x62e) << uint32(0x0);       // 8 1582 horde flag captures
                    data << uint32(0x609) << uint32(0x0);       // 9 1545 unk, set to 1 on alliance flag pickup...
                    data << uint32(0x60a) << uint32(0x0);       // 10 1546 unk, set to 1 on horde flag pickup, after drop it's -1
                    data << uint32(0x60b) << uint32(0x2);       // 11 1547 unk
                    data << uint32(0x641) << uint32(0x3);       // 12 1601 unk (max flag captures?)
                    data << uint32(0x922) << uint32(0x1);       // 13 2338 horde (0 - hide, 1 - flag ok, 2 - flag picked up (flashing), 3 - flag picked up (not flashing)
                    data << uint32(0x923) << uint32(0x1);       // 14 2339 alliance (0 - hide, 1 - flag ok, 2 - flag picked up (flashing), 3 - flag picked up (not flashing)
                }
                break;
            case 3358:                                          // Arathi Basin
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_AB)
                    bg->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0x6e7) << uint32(0x0);       // 7 1767 stables alliance
                    data << uint32(0x6e8) << uint32(0x0);       // 8 1768 stables horde
                    data << uint32(0x6e9) << uint32(0x0);       // 9 1769 unk, ST?
                    data << uint32(0x6ea) << uint32(0x0);       // 10 1770 stables (show/hide)
                    data << uint32(0x6ec) << uint32(0x0);       // 11 1772 farm (0 - horde controlled, 1 - alliance controlled)
                    data << uint32(0x6ed) << uint32(0x0);       // 12 1773 farm (show/hide)
                    data << uint32(0x6ee) << uint32(0x0);       // 13 1774 farm color
                    data << uint32(0x6ef) << uint32(0x0);       // 14 1775 gold mine color, may be FM?
                    data << uint32(0x6f0) << uint32(0x0);       // 15 1776 alliance resources
                    data << uint32(0x6f1) << uint32(0x0);       // 16 1777 horde resources
                    data << uint32(0x6f2) << uint32(0x0);       // 17 1778 horde bases
                    data << uint32(0x6f3) << uint32(0x0);       // 18 1779 alliance bases
                    data << uint32(0x6f4) << uint32(0x640);     // 19 1780 max resources (1600)
                    data << uint32(0x6f6) << uint32(0x0);       // 20 1782 blacksmith color
                    data << uint32(0x6f7) << uint32(0x0);       // 21 1783 blacksmith (show/hide)
                    data << uint32(0x6f8) << uint32(0x0);       // 22 1784 unk, bs?
                    data << uint32(0x6f9) << uint32(0x0);       // 23 1785 unk, bs?
                    data << uint32(0x6fb) << uint32(0x0);       // 24 1787 gold mine (0 - horde contr, 1 - alliance contr)
                    data << uint32(0x6fc) << uint32(0x0);       // 25 1788 gold mine (0 - conflict, 1 - horde)
                    data << uint32(0x6fd) << uint32(0x0);       // 26 1789 gold mine (1 - show/0 - hide)
                    data << uint32(0x6fe) << uint32(0x0);       // 27 1790 gold mine color
                    data << uint32(0x700) << uint32(0x0);       // 28 1792 gold mine color, may be LM?
                    data << uint32(0x701) << uint32(0x0);       // 29 1793 lumber mill color (0 - conflict, 1 - horde contr)
                    data << uint32(0x702) << uint32(0x0);       // 30 1794 lumber mill (show/hide)
                    data << uint32(0x703) << uint32(0x0);       // 31 1795 lumber mill color color
                    data << uint32(0x732) << uint32(0x1);       // 32 1842 stables (1 - uncontrolled)
                    data << uint32(0x733) << uint32(0x1);       // 33 1843 gold mine (1 - uncontrolled)
                    data << uint32(0x734) << uint32(0x1);       // 34 1844 lumber mill (1 - uncontrolled)
                    data << uint32(0x735) << uint32(0x1);       // 35 1845 farm (1 - uncontrolled)
                    data << uint32(0x736) << uint32(0x1);       // 36 1846 blacksmith (1 - uncontrolled)
                    data << uint32(0x745) << uint32(0x2);       // 37 1861 unk
                    data << uint32(0x7a3) << uint32(0x578);     // 38 1955 warning limit (1400)
                }
                break;
            case 3820:                                          // Eye of the Storm
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_EY)
                    bg->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0xac1) << uint32(0x0);       // 7  2753 Horde Bases
                    data << uint32(0xac0) << uint32(0x0);       // 8  2752 Alliance Bases
                    data << uint32(0xab6) << uint32(0x0);       // 9  2742 Mage Tower - Horde conflict
                    data << uint32(0xab5) << uint32(0x0);       // 10 2741 Mage Tower - Alliance conflict
                    data << uint32(0xab4) << uint32(0x0);       // 11 2740 Fel Reaver - Horde conflict
                    data << uint32(0xab3) << uint32(0x0);       // 12 2739 Fel Reaver - Alliance conflict
                    data << uint32(0xab2) << uint32(0x0);       // 13 2738 Draenei - Alliance conflict
                    data << uint32(0xab1) << uint32(0x0);       // 14 2737 Draenei - Horde conflict
                    data << uint32(0xab0) << uint32(0x0);       // 15 2736 unk // 0 at start
                    data << uint32(0xaaf) << uint32(0x0);       // 16 2735 unk // 0 at start
                    data << uint32(0xaad) << uint32(0x0);       // 17 2733 Draenei - Horde control
                    data << uint32(0xaac) << uint32(0x0);       // 18 2732 Draenei - Alliance control
                    data << uint32(0xaab) << uint32(0x1);       // 19 2731 Draenei uncontrolled (1 - yes, 0 - no)
                    data << uint32(0xaaa) << uint32(0x0);       // 20 2730 Mage Tower - Alliance control
                    data << uint32(0xaa9) << uint32(0x0);       // 21 2729 Mage Tower - Horde control
                    data << uint32(0xaa8) << uint32(0x1);       // 22 2728 Mage Tower uncontrolled (1 - yes, 0 - no)
                    data << uint32(0xaa7) << uint32(0x0);       // 23 2727 Fel Reaver - Horde control
                    data << uint32(0xaa6) << uint32(0x0);       // 24 2726 Fel Reaver - Alliance control
                    data << uint32(0xaa5) << uint32(0x1);       // 25 2725 Fel Reaver uncontrolled (1 - yes, 0 - no)
                    data << uint32(0xaa4) << uint32(0x0);       // 26 2724 Boold Elf - Horde control
                    data << uint32(0xaa3) << uint32(0x0);       // 27 2723 Boold Elf - Alliance control
                    data << uint32(0xaa2) << uint32(0x1);       // 28 2722 Boold Elf uncontrolled (1 - yes, 0 - no)
                    data << uint32(0xac5) << uint32(0x1);       // 29 2757 Flag (1 - show, 0 - hide) - doesn't work exactly this way!
                    data << uint32(0xad2) << uint32(0x1);       // 30 2770 Horde top-stats (1 - show, 0 - hide) // 02 -> horde picked up the flag
                    data << uint32(0xad1) << uint32(0x1);       // 31 2769 Alliance top-stats (1 - show, 0 - hide) // 02 -> alliance picked up the flag
                    data << uint32(0xabe) << uint32(0x0);       // 32 2750 Horde resources
                    data << uint32(0xabd) << uint32(0x0);       // 33 2749 Alliance resources
                    data << uint32(0xa05) << uint32(0x8e);      // 34 2565 unk, constant?
                    data << uint32(0xaa0) << uint32(0x0);       // 35 2720 Capturing progress-bar (100 -> empty (only grey), 0 -> blue|red (no grey), default 0)
                    data << uint32(0xa9f) << uint32(0x0);       // 36 2719 Capturing progress-bar (0 - left, 100 - right)
                    data << uint32(0xa9e) << uint32(0x0);       // 37 2718 Capturing progress-bar (1 - show, 0 - hide)
                    data << uint32(0xc0d) << uint32(0x17b);     // 38 3085 unk
                    // and some more ... unknown
                }
                break;
            // any of these needs change! the client remembers the prev setting!
            // ON EVERY ZONE LEAVE, RESET THE OLD ZONE'S WORLD STATE, BUT AT LEAST THE UI STUFF!
            case 3483:                                          // Hellfire Peninsula
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_HP)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0x9ba) << uint32(0x1);           // 10 // add ally tower main gui icon       // maybe should be sent only on login?
                    data << uint32(0x9b9) << uint32(0x1);           // 11 // add horde tower main gui icon      // maybe should be sent only on login?
                    data << uint32(0x9b5) << uint32(0x0);           // 12 // show neutral broken hill icon      // 2485
                    data << uint32(0x9b4) << uint32(0x1);           // 13 // show icon above broken hill        // 2484
                    data << uint32(0x9b3) << uint32(0x0);           // 14 // show ally broken hill icon         // 2483
                    data << uint32(0x9b2) << uint32(0x0);           // 15 // show neutral overlook icon         // 2482
                    data << uint32(0x9b1) << uint32(0x1);           // 16 // show the overlook arrow            // 2481
                    data << uint32(0x9b0) << uint32(0x0);           // 17 // show ally overlook icon            // 2480
                    data << uint32(0x9ae) << uint32(0x0);           // 18 // horde pvp objectives captured      // 2478
                    data << uint32(0x9ac) << uint32(0x0);           // 19 // ally pvp objectives captured       // 2476
                    data << uint32(2475)  << uint32(100);           //: ally / horde slider grey area                              // show only in direct vicinity!
                    data << uint32(2474)  << uint32(50);            //: ally / horde slider percentage, 100 for ally, 0 for horde  // show only in direct vicinity!
                    data << uint32(2473)  << uint32(0);             //: ally / horde slider display                                // show only in direct vicinity!
                    data << uint32(0x9a8) << uint32(0x0);           // 20 // show the neutral stadium icon      // 2472
                    data << uint32(0x9a7) << uint32(0x0);           // 21 // show the ally stadium icon         // 2471
                    data << uint32(0x9a6) << uint32(0x1);           // 22 // show the horde stadium icon        // 2470
                }
                break;
            case 3518:                                          // Nagrand
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_NA)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    data << uint32(2503) << uint32(0x0);    // 10
                    data << uint32(2502) << uint32(0x0);    // 11
                    data << uint32(2493) << uint32(0x0);    // 12
                    data << uint32(2491) << uint32(0x0);    // 13

                    data << uint32(2495) << uint32(0x0);    // 14
                    data << uint32(2494) << uint32(0x0);    // 15
                    data << uint32(2497) << uint32(0x0);    // 16

                    data << uint32(2762) << uint32(0x0);    // 17
                    data << uint32(2662) << uint32(0x0);    // 18
                    data << uint32(2663) << uint32(0x0);    // 19
                    data << uint32(2664) << uint32(0x0);    // 20

                    data << uint32(2760) << uint32(0x0);    // 21
                    data << uint32(2670) << uint32(0x0);    // 22
                    data << uint32(2668) << uint32(0x0);    // 23
                    data << uint32(2669) << uint32(0x0);    // 24

                    data << uint32(2761) << uint32(0x0);    // 25
                    data << uint32(2667) << uint32(0x0);    // 26
                    data << uint32(2665) << uint32(0x0);    // 27
                    data << uint32(2666) << uint32(0x0);    // 28

                    data << uint32(2763) << uint32(0x0);    // 29
                    data << uint32(2659) << uint32(0x0);    // 30
                    data << uint32(2660) << uint32(0x0);    // 31
                    data << uint32(2661) << uint32(0x0);    // 32

                    data << uint32(2671) << uint32(0x0);    // 33
                    data << uint32(2676) << uint32(0x0);    // 34
                    data << uint32(2677) << uint32(0x0);    // 35
                    data << uint32(2672) << uint32(0x0);    // 36
                    data << uint32(2673) << uint32(0x0);    // 37
                }
                break;
            case 3519:                                          // Terokkar Forest
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_TF)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0xa41) << uint32(0x0);           // 10 // 2625 capture bar pos
                    data << uint32(0xa40) << uint32(0x14);          // 11 // 2624 capture bar neutral
                    data << uint32(0xa3f) << uint32(0x0);           // 12 // 2623 show capture bar
                    data << uint32(0xa3e) << uint32(0x0);           // 13 // 2622 horde towers controlled
                    data << uint32(0xa3d) << uint32(0x5);           // 14 // 2621 ally towers controlled
                    data << uint32(0xa3c) << uint32(0x0);           // 15 // 2620 show towers controlled
                    data << uint32(0xa88) << uint32(0x0);           // 16 // 2696 SE Neu
                    data << uint32(0xa87) << uint32(0x0);           // 17 // SE Horde
                    data << uint32(0xa86) << uint32(0x0);           // 18 // SE Ally
                    data << uint32(0xa85) << uint32(0x0);           // 19 //S Neu
                    data << uint32(0xa84) << uint32(0x0);           // 20 S Horde
                    data << uint32(0xa83) << uint32(0x0);           // 21 S Ally
                    data << uint32(0xa82) << uint32(0x0);           // 22 NE Neu
                    data << uint32(0xa81) << uint32(0x0);           // 23 NE Horde
                    data << uint32(0xa80) << uint32(0x0);           // 24 NE Ally
                    data << uint32(0xa7e) << uint32(0x0);           // 25 // 2686 N Neu
                    data << uint32(0xa7d) << uint32(0x0);           // 26 N Horde
                    data << uint32(0xa7c) << uint32(0x0);           // 27 N Ally
                    data << uint32(0xa7b) << uint32(0x0);           // 28 NW Ally
                    data << uint32(0xa7a) << uint32(0x0);           // 29 NW Horde
                    data << uint32(0xa79) << uint32(0x0);           // 30 NW Neutral
                    data << uint32(0x9d0) << uint32(0x5);           // 31 // 2512 locked time remaining seconds first digit
                    data << uint32(0x9ce) << uint32(0x0);           // 32 // 2510 locked time remaining seconds second digit
                    data << uint32(0x9cd) << uint32(0x0);           // 33 // 2509 locked time remaining minutes
                    data << uint32(0x9cc) << uint32(0x0);           // 34 // 2508 neutral locked time show
                    data << uint32(0xad0) << uint32(0x0);           // 35 // 2768 horde locked time show
                    data << uint32(0xacf) << uint32(0x1);           // 36 // 2767 ally locked time show
                }
                break;
            case 3521:                                          // Zangarmarsh
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_ZM)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0x9e1) << uint32(0x0);           // 10 //2529
                    data << uint32(0x9e0) << uint32(0x0);           // 11
                    data << uint32(0x9df) << uint32(0x0);           // 12
                    data << uint32(0xa5d) << uint32(0x1);           // 13 //2653
                    data << uint32(0xa5c) << uint32(0x0);           // 14 //2652 east beacon neutral
                    data << uint32(0xa5b) << uint32(0x1);           // 15 horde
                    data << uint32(0xa5a) << uint32(0x0);           // 16 ally
                    data << uint32(0xa59) << uint32(0x1);           // 17 // 2649 Twin spire graveyard horde  12???
                    data << uint32(0xa58) << uint32(0x0);           // 18 ally     14 ???
                    data << uint32(0xa57) << uint32(0x0);           // 19 neutral  7???
                    data << uint32(0xa56) << uint32(0x0);           // 20 // 2646 west beacon neutral
                    data << uint32(0xa55) << uint32(0x1);           // 21 horde
                    data << uint32(0xa54) << uint32(0x0);           // 22 ally
                    data << uint32(0x9e7) << uint32(0x0);           // 23 // 2535
                    data << uint32(0x9e6) << uint32(0x0);           // 24
                    data << uint32(0x9e5) << uint32(0x0);           // 25
                    data << uint32(0xa00) << uint32(0x0);           // 26 // 2560
                    data << uint32(0x9ff) << uint32(0x1);           // 27
                    data << uint32(0x9fe) << uint32(0x0);           // 28
                    data << uint32(0x9fd) << uint32(0x0);           // 29
                    data << uint32(0x9fc) << uint32(0x1);           // 30
                    data << uint32(0x9fb) << uint32(0x0);           // 31
                    data << uint32(0xa62) << uint32(0x0);           // 32 // 2658
                    data << uint32(0xa61) << uint32(0x1);           // 33
                    data << uint32(0xa60) << uint32(0x1);           // 34
                    data << uint32(0xa5f) << uint32(0x0);           // 35
                }
                break;
            case 3698:                                          // Nagrand Arena
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_NA)
                    bg->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0xa0f) << uint32(0x0);           // 7
                    data << uint32(0xa10) << uint32(0x0);           // 8
                    data << uint32(0xa11) << uint32(0x0);           // 9 show
                }
                break;
            case 3702:                                          // Blade's Edge Arena
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_BE)
                    bg->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0x9f0) << uint32(0x0);           // 7 gold
                    data << uint32(0x9f1) << uint32(0x0);           // 8 green
                    data << uint32(0x9f3) << uint32(0x0);           // 9 show
                }
                break;
            case 3968:                                          // Ruins of Lordaeron
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_RL)
                    bg->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0xbb8) << uint32(0x0);           // 7 gold
                    data << uint32(0xbb9) << uint32(0x0);           // 8 green
                    data << uint32(0xbba) << uint32(0x0);           // 9 show
                }
                break;
            case 4378:                                          // Dalaran Sewers
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_DS)
                    bg->FillInitialWorldStates(data);
                else
                {
                    data << uint32(3601) << uint32(0x0);           // 7 gold
                    data << uint32(3600) << uint32(0x0);           // 8 green
                    data << uint32(3610) << uint32(0x0);           // 9 show
                }
                break;
            case 4384:                                          // Strand of the Ancients
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_SA)
                    bg->FillInitialWorldStates(data);
                else
                {
                    // 1-3 A defend, 4-6 H defend, 7-9 unk defend, 1 - ok, 2 - half destroyed, 3 - destroyed
                    data << uint32(0xf09) << uint32(0x0);       // 7  3849 Gate of Temple
                    data << uint32(0xe36) << uint32(0x0);       // 8  3638 Gate of Yellow Moon
                    data << uint32(0xe27) << uint32(0x0);       // 9  3623 Gate of Green Emerald
                    data << uint32(0xe24) << uint32(0x0);       // 10 3620 Gate of Blue Sapphire
                    data << uint32(0xe21) << uint32(0x0);       // 11 3617 Gate of Red Sun
                    data << uint32(0xe1e) << uint32(0x0);       // 12 3614 Gate of Purple Ametyst

                    data << uint32(0xdf3) << uint32(0x0);       // 13 3571 bonus timer (1 - on, 0 - off)
                    data << uint32(0xded) << uint32(0x0);       // 14 3565 Horde Attacker
                    data << uint32(0xdec) << uint32(0x0);       // 15 3564 Alliance Attacker
                    // End Round (timer), better explain this by example, eg. ends in 19:59 -> A:BC
                    data << uint32(0xde9) << uint32(0x0);       // 16 3561 C
                    data << uint32(0xde8) << uint32(0x0);       // 17 3560 B
                    data << uint32(0xde7) << uint32(0x0);       // 18 3559 A
                    data << uint32(0xe35) << uint32(0x0);       // 19 3637 East g - Horde control
                    data << uint32(0xe34) << uint32(0x0);       // 20 3636 West g - Horde control
                    data << uint32(0xe33) << uint32(0x0);       // 21 3635 South g - Horde control
                    data << uint32(0xe32) << uint32(0x0);       // 22 3634 East g - Alliance control
                    data << uint32(0xe31) << uint32(0x0);       // 23 3633 West g - Alliance control
                    data << uint32(0xe30) << uint32(0x0);       // 24 3632 South g - Alliance control
                    data << uint32(0xe2f) << uint32(0x0);       // 25 3631 Chamber of Ancients - Horde control
                    data << uint32(0xe2e) << uint32(0x0);       // 26 3630 Chamber of Ancients - Alliance control
                    data << uint32(0xe2d) << uint32(0x0);       // 27 3629 Beach1 - Horde control
                    data << uint32(0xe2c) << uint32(0x0);       // 28 3628 Beach2 - Horde control
                    data << uint32(0xe2b) << uint32(0x0);       // 29 3627 Beach1 - Alliance control
                    data << uint32(0xe2a) << uint32(0x0);       // 30 3626 Beach2 - Alliance control
                    // and many unks...
                }
                break;
            case 4406:                                          // Ring of Valor
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_RV)
                    bg->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0xe10) << uint32(0x0);           // 7 gold
                    data << uint32(0xe11) << uint32(0x0);           // 8 green
                    data << uint32(0xe1a) << uint32(0x0);           // 9 show
                }
                break;
            case 4710:                                          // Isle of Conquest
                if (bg && bg->GetBgTypeID(true) == BATTLEGROUND_IC)
                    bg->FillInitialWorldStates(data);
                else
                {
                    data << uint32(4221) << uint32(1); // 7 BG_IC_ALLIANCE_RENFORT_SET
                    data << uint32(4222) << uint32(1); // 8 BG_IC_HORDE_RENFORT_SET
                    data << uint32(4226) << uint32(300); // 9 BG_IC_ALLIANCE_RENFORT
                    data << uint32(4227) << uint32(300); // 10 BG_IC_HORDE_RENFORT
                    data << uint32(4322) << uint32(1); // 11 BG_IC_GATE_FRONT_H_WS_OPEN
                    data << uint32(4321) << uint32(1); // 12 BG_IC_GATE_WEST_H_WS_OPEN
                    data << uint32(4320) << uint32(1); // 13 BG_IC_GATE_EAST_H_WS_OPEN
                    data << uint32(4323) << uint32(1); // 14 BG_IC_GATE_FRONT_A_WS_OPEN
                    data << uint32(4324) << uint32(1); // 15 BG_IC_GATE_WEST_A_WS_OPEN
                    data << uint32(4325) << uint32(1); // 16 BG_IC_GATE_EAST_A_WS_OPEN
                    data << uint32(4317) << uint32(1); // 17 unknown

                    data << uint32(4301) << uint32(1); // 18 BG_IC_DOCKS_UNCONTROLLED
                    data << uint32(4296) << uint32(1); // 19 BG_IC_HANGAR_UNCONTROLLED
                    data << uint32(4306) << uint32(1); // 20 BG_IC_QUARRY_UNCONTROLLED
                    data << uint32(4311) << uint32(1); // 21 BG_IC_REFINERY_UNCONTROLLED
                    data << uint32(4294) << uint32(1); // 22 BG_IC_WORKSHOP_UNCONTROLLED
                    data << uint32(4243) << uint32(1); // 23 unknown
                    data << uint32(4345) << uint32(1); // 24 unknown
                }
                break;
            // The Ruby Sanctum
            case 4987:
                if (instance && mapid == 724)
                    instance->FillInitialWorldStates(data);
                else
                {
                    data << uint32(5049) << uint32(50);             // 9  WORLDSTATE_CORPOREALITY_MATERIAL
                    data << uint32(5050) << uint32(50);             // 10 WORLDSTATE_CORPOREALITY_TWILIGHT
                    data << uint32(5051) << uint32(0);              // 11 WORLDSTATE_CORPOREALITY_TOGGLE
                }
                break;
            // Icecrown Citadel
            case 4812:
                if (instance && mapid == 631)
                    instance->FillInitialWorldStates(data);
                else
                {
                    data << uint32(4903) << uint32(0);              // 9  WORLDSTATE_SHOW_TIMER (Blood Quickening weekly)
                    data << uint32(4904) << uint32(30);             // 10 WORLDSTATE_EXECUTION_TIME
                    data << uint32(4940) << uint32(0);              // 11 WORLDSTATE_SHOW_ATTEMPTS
                    data << uint32(4941) << uint32(50);             // 12 WORLDSTATE_ATTEMPTS_REMAINING
                    data << uint32(4942) << uint32(50);             // 13 WORLDSTATE_ATTEMPTS_MAX
                }
                break;
            // The Culling of Stratholme
            case 4100:
                if (instance && mapid == 595)
                    instance->FillInitialWorldStates(data);
                else
                {
                    data << uint32(3479) << uint32(0);              // 9  WORLDSTATE_SHOW_CRATES
                    data << uint32(3480) << uint32(0);              // 10 WORLDSTATE_CRATES_REVEALED
                    data << uint32(3504) << uint32(0);              // 11 WORLDSTATE_WAVE_COUNT
                    data << uint32(3931) << uint32(25);             // 12 WORLDSTATE_TIME_GUARDIAN
                    data << uint32(3932) << uint32(0);              // 13 WORLDSTATE_TIME_GUARDIAN_SHOW
                }
                break;
            // The Oculus
            case 4228:
                if (instance && mapid == 578)
                    instance->FillInitialWorldStates(data);
                else
                {
                    data << uint32(3524) << uint32(0);              // 9  WORLD_STATE_CENTRIFUGE_CONSTRUCT_SHOW
                    data << uint32(3486) << uint32(0);              // 10 WORLD_STATE_CENTRIFUGE_CONSTRUCT_AMOUNT
                }
                break;
            // Ulduar
            case 4273:
                if (instance && mapid == 603)
                    instance->FillInitialWorldStates(data);
                else
                {
                    data << uint32(4132) << uint32(0);              // 9  WORLDSTATE_ALGALON_TIMER_ENABLED
                    data << uint32(4131) << uint32(0);              // 10 WORLDSTATE_ALGALON_DESPAWN_TIMER
                }
                break;
            // Halls of Refection
            case 4820:
                if (instance && mapid == 668)
                    instance->FillInitialWorldStates(data);
                else
                {
                    data << uint32(4884) << uint32(0);              // 9  WORLD_STATE_HOR_WAVES_ENABLED
                    data << uint32(4882) << uint32(0);              // 10 WORLD_STATE_HOR_WAVE_COUNT
                }
                break;
            // Scarlet Enclave (DK starting zone)
            case 4298:
                // Get Mograine, GUID and ENTRY should NEVER change
                if (Creature* mograine = ObjectAccessor::GetCreature(*this, ObjectGuid::Create<HighGuid::Unit>(29173, 130956)))
                {
                    if (CreatureAI* mograineAI = mograine->AI())
                    {
                        data << uint32(3590) << uint32(mograineAI->GetData(3590));
                        data << uint32(3591) << uint32(mograineAI->GetData(3591));
                        data << uint32(3592) << uint32(mograineAI->GetData(3592));
                        data << uint32(3603) << uint32(mograineAI->GetData(3603));
                        data << uint32(3604) << uint32(mograineAI->GetData(3604));
                        data << uint32(3605) << uint32(mograineAI->GetData(3605));
                    }
                }
                break;
            // Wintergrasp
            case 4197:
                if (bf && bf->GetTypeId() == BATTLEFIELD_WG)
                {
                    bf->FillInitialWorldStates(data);
                    break;
                }
                [[fallthrough]];
            default:
                data << uint32(0x914) << uint32(0x0);           // 7
                data << uint32(0x913) << uint32(0x0);           // 8
                data << uint32(0x912) << uint32(0x0);           // 9
                data << uint32(0x915) << uint32(0x0);           // 10
                break;
        }
    }

    uint16 length = (data.wpos() - countPos) / 8;
    data.put<uint16>(countPos, length);

    GetSession()->SendPacket(&data);
    SendBGWeekendWorldStates();
    SendBattlefieldWorldStates();
}

void Player::SendBGWeekendWorldStates()
{
    for (uint32 i = 1; i < sBattlemasterListStore.GetNumRows(); ++i)
    {
        BattlemasterListEntry const* bl = sBattlemasterListStore.LookupEntry(i);
        if (bl && bl->HolidayWorldStateId)
        {
            if (BattlegroundMgr::IsBGWeekend((BattlegroundTypeId)bl->id))
                SendUpdateWorldState(bl->HolidayWorldStateId, 1);
            else
                SendUpdateWorldState(bl->HolidayWorldStateId, 0);
        }
    }
}

void Player::SendBattlefieldWorldStates()
{
    /// Send misc stuff that needs to be sent on every login, like the battle timers.
    if (sWorld->getIntConfig(CONFIG_WINTERGRASP_ENABLE) == 1)
    {
        if (BattlefieldWG* wg = (BattlefieldWG*)sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG))
        {
            SendUpdateWorldState(BATTLEFIELD_WG_WORLD_STATE_ATTACKER, wg->GetAttackerTeam());
            SendUpdateWorldState(BATTLEFIELD_WG_WORLD_STATE_DEFENDER, wg->GetDefenderTeam());
            SendUpdateWorldState(BATTLEFIELD_WG_WORLD_STATE_ACTIVE, wg->IsWarTime() ? 0 : 1); // Note: cleanup these two, their names look awkward
            SendUpdateWorldState(BATTLEFIELD_WG_WORLD_STATE_SHOW_WORLDSTATE, wg->IsWarTime() ? 1 : 0);

            for (uint32 i = 0; i < 2; ++i)
                SendUpdateWorldState(ClockWorldState[i], uint32(GameTime::GetGameTime().count() + (wg->GetTimer() / 1000)));
        }
    }
}

uint32 Player::GetXPRestBonus(uint32 xp)
{
    uint32 rested_bonus = (uint32)GetRestBonus();           // xp for each rested bonus

    if (rested_bonus > xp)                                   // max rested_bonus == xp or (r+x) = 200% xp
        rested_bonus = xp;

    SetRestBonus(GetRestBonus() - rested_bonus);

    LOG_DEBUG("entities.player", "Player gain {} xp (+ {} Rested Bonus). Rested points={}", xp + rested_bonus, rested_bonus, GetRestBonus());
    return rested_bonus;
}

void Player::SetBindPoint(ObjectGuid guid)
{
    WorldPacket data(SMSG_BINDER_CONFIRM, 8);
    data << guid;
    GetSession()->SendPacket(&data);
}

void Player::SendTalentWipeConfirm(ObjectGuid guid)
{
    WorldPacket data(MSG_TALENT_WIPE_CONFIRM, (8 + 4));
    data << guid;
    uint32 cost = sWorld->getBoolConfig(CONFIG_NO_RESET_TALENT_COST) ? 0 : resetTalentsCost();
    data << cost;
    GetSession()->SendPacket(&data);
}

void Player::ResetPetTalents()
{
    // This needs another gossip option + NPC text as a confirmation.
    // The confirmation gossip listid has the text: "Yes, please do."
    Pet* pet = GetPet();

    if (!pet || pet->getPetType() != HUNTER_PET || pet->m_usedTalentCount == 0)
        return;

    CharmInfo* charmInfo = pet->GetCharmInfo();
    if (!charmInfo)
    {
        LOG_ERROR("entities.player", "Object ({}) is considered pet-like but doesn't have a charminfo!", pet->GetGUID().ToString());
        return;
    }
    pet->resetTalents();
    SendTalentsInfoData(true);
}

Pet* Player::GetPet() const
{
    if (ObjectGuid pet_guid = GetPetGUID())
    {
        if (!pet_guid.IsPet())
            return nullptr;

        Pet* pet = ObjectAccessor::GetPet(*this, pet_guid);

        if (!pet)
            return nullptr;

        if (IsInWorld())
            return pet;

        //there may be a guardian in slot
        //LOG_ERROR("entities.player", "Player::GetPet: Pet {} not exist.", pet_guid.ToString());
        //const_cast<Player*>(this)->SetPetGUID(0);
    }

    return nullptr;
}

Pet* Player::SummonPet(uint32 entry, float x, float y, float z, float ang, PetType petType, Milliseconds duration /*= 0s*/, uint32 healthPct /*= 0*/)
{
    PetStable& petStable = GetOrInitPetStable();

    Pet* pet = new Pet(this, petType);

    if (petType == SUMMON_PET && pet->LoadPetFromDB(this, entry, 0, false, healthPct))
    {
        // Remove Demonic Sacrifice auras (known pet)
        Unit::AuraEffectList const& auraClassScripts = GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
        for (Unit::AuraEffectList::const_iterator itr = auraClassScripts.begin(); itr != auraClassScripts.end();)
        {
            if ((*itr)->GetMiscValue() == 2228)
            {
                RemoveAurasDueToSpell((*itr)->GetId());
                itr = auraClassScripts.begin();
            }
            else
                ++itr;
        }

        if (duration > 0s)
            pet->SetDuration(duration);

        // Generate a new name for the newly summoned ghoul
        if (pet->IsPetGhoul())
        {
            std::string new_name = sObjectMgr->GeneratePetNameLocale(entry, GetSession()->GetSessionDbLocaleIndex());
            if (!new_name.empty())
                pet->SetName(new_name);
        }

        return nullptr;
    }

    // petentry == 0 for hunter "call pet" (current pet summoned if any)
    if (!entry)
    {
        delete pet;
        return nullptr;
    }

    pet->Relocate(x, y, z, ang);
    if (!pet->IsPositionValid())
    {
        LOG_ERROR("misc", "Player::SummonPet: Pet ({}, Entry: {}) not summoned. Suggested coordinates aren't valid (X: {} Y: {})", pet->GetGUID().ToString(), pet->GetEntry(), pet->GetPositionX(), pet->GetPositionY());
        delete pet;
        return nullptr;
    }

    Map* map = GetMap();
    uint32 pet_number = sObjectMgr->GeneratePetNumber();
    if (!pet->Create(map->GenerateLowGuid<HighGuid::Pet>(), map, GetPhaseMask(), entry, pet_number))
    {
        LOG_ERROR("misc", "Player::SummonPet: No such creature entry {}", entry);
        delete pet;
        return nullptr;
    }

    if (petType == SUMMON_PET && petStable.CurrentPet)
        RemovePet(nullptr, PET_SAVE_NOT_IN_SLOT);

    pet->SetCreatorGUID(GetGUID());
    pet->SetFaction(GetFaction());
    pet->setPowerType(POWER_MANA);
    pet->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
    pet->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
    pet->InitStatsForLevel(GetLevel());

    SetMinion(pet, true);

    if (petType == SUMMON_PET)
    {
        if (pet->GetCreatureTemplate()->type == CREATURE_TYPE_DEMON || pet->GetCreatureTemplate()->type == CREATURE_TYPE_UNDEAD)
        {
            pet->GetCharmInfo()->SetPetNumber(pet_number, true); // Show pet details tab (Shift+P) only for demons & undead
        }
        else
        {
            pet->GetCharmInfo()->SetPetNumber(pet_number, false);
        }

        pet->SetUInt32Value(UNIT_FIELD_BYTES_0, 2048);
        pet->SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, 0);
        pet->SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, 1000);
        pet->SetFullHealth();
        pet->SetPower(POWER_MANA, pet->GetMaxPower(POWER_MANA));
        pet->SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, uint32(GameTime::GetGameTime().count())); // cast can't be helped in this case
    }

    map->AddToMap(pet->ToCreature(), true);

    ASSERT(!petStable.CurrentPet && (petType != HUNTER_PET || !petStable.GetUnslottedHunterPet()));
    pet->FillPetInfo(&petStable.CurrentPet.emplace());

    if (petType == SUMMON_PET)
    {
        pet->InitPetCreateSpells();
        pet->InitTalentForLevel();
        pet->SavePetToDB(PET_SAVE_AS_CURRENT);
        PetSpellInitialize();

        // Remove Demonic Sacrifice auras (known pet)
        Unit::AuraEffectList const& auraClassScripts = GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
        for (Unit::AuraEffectList::const_iterator itr = auraClassScripts.begin(); itr != auraClassScripts.end();)
        {
            if ((*itr)->GetMiscValue() == 2228)
            {
                RemoveAurasDueToSpell((*itr)->GetId());
                itr = auraClassScripts.begin();
            }
            else
                ++itr;
        }
    }

    if (duration > 0s)
        pet->SetDuration(duration);

    if (NeedSendSpectatorData() && pet->GetCreatureTemplate()->family)
    {
        ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "PHP", (uint32)pet->GetHealthPct());
        ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "PET", pet->GetCreatureTemplate()->family);
    }

    return pet;
}

void Player::RemovePet(Pet* pet, PetSaveMode mode, bool returnreagent)
{
    if (!pet)
        pet = GetPet();

    if (pet)
    {
        // xinef: dont save dead pet as current, save him not in slot
        if (!pet->IsAlive() && mode == PET_SAVE_AS_CURRENT && pet->getPetType() == HUNTER_PET)
        {
            mode = PET_SAVE_NOT_IN_SLOT;
            m_temporaryUnsummonedPetNumber = 0;
        }

        LOG_DEBUG("entities.pet", "RemovePet {}, {}, {}", pet->GetEntry(), mode, returnreagent);
        if (pet->m_removed)
            return;
    }

    if (returnreagent && (pet || (m_temporaryUnsummonedPetNumber && (!m_session || !m_session->PlayerLogout()))) && !InBattleground())
    {
        //returning of reagents only for players, so best done here
        uint32 spellId = pet ? pet->GetUInt32Value(UNIT_CREATED_BY_SPELL) : m_oldpetspell;
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);

        if (spellInfo)
        {
            for (uint32 i = 0; i < MAX_SPELL_REAGENTS; ++i)
            {
                if (spellInfo->Reagent[i] > 0)
                {
                    ItemPosCountVec dest;                   //for succubus, voidwalker, felhunter and felguard credit soulshard when despawn reason other than death (out of range, logout)
                    InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, spellInfo->Reagent[i], spellInfo->ReagentCount[i]);
                    if (msg == EQUIP_ERR_OK)
                    {
                        Item* item = StoreNewItem(dest, spellInfo->Reagent[i], true);
                        if (IsInWorld())
                            SendNewItem(item, spellInfo->ReagentCount[i], true, false);
                    }
                }
            }
        }
        m_temporaryUnsummonedPetNumber = 0;
    }

    if (!pet)
    {
        if (mode == PET_SAVE_NOT_IN_SLOT && m_petStable && m_petStable->CurrentPet)
        {
            // Handle removing pet while it is in "temporarily unsummoned" state, for example on mount
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_SLOT_BY_ID);
            stmt->SetData(0, PET_SAVE_NOT_IN_SLOT);
            stmt->SetData(1, GetGUID().GetCounter());
            stmt->SetData(2, m_petStable->CurrentPet->PetNumber);
            CharacterDatabase.Execute(stmt);

            m_petStable->UnslottedPets.push_back(std::move(*m_petStable->CurrentPet));
            m_petStable->CurrentPet.reset();
        }

        return;
    }
    else
    {
        pet->CombatStop();

        // only if current pet in slot
        pet->SavePetToDB(mode);

        if (m_petStable->CurrentPet && m_petStable->CurrentPet->PetNumber == pet->GetCharmInfo()->GetPetNumber())
        {
            if (mode == PET_SAVE_NOT_IN_SLOT)
            {
                m_petStable->UnslottedPets.push_back(std::move(*m_petStable->CurrentPet));
                m_petStable->CurrentPet.reset();
            }
            else if (mode == PET_SAVE_AS_DELETED)
                m_petStable->CurrentPet.reset();
            // else if (stable slots) handled in opcode handlers due to required swaps
            // else (current pet) doesnt need to do anything
        }

        SetMinion(pet, false);

        pet->AddObjectToRemoveList();
        pet->m_removed = true;

        if (pet->isControlled())
        {
            WorldPacket data(SMSG_PET_SPELLS, 8);
            data << uint64(0);
            GetSession()->SendPacket(&data);

            if (GetGroup())
                SetGroupUpdateFlag(GROUP_UPDATE_PET);
        }

        if (NeedSendSpectatorData() && pet->GetCreatureTemplate()->family)
        {
            ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "PHP", 0);
            ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "PET", 0);
        }
    }
}

bool Player::CanPetResurrect()
{
    PetStable* const petStable = GetPetStable();
    if (!petStable)
    {
        // No pets
        return false;
    }

    auto const& currectPet = petStable->CurrentPet;
    auto const& unslottedHunterPet = petStable->GetUnslottedHunterPet();

    if (!currectPet && !unslottedHunterPet)
    {
        // No pets
        return false;
    }

    // Check current pet
    if (currectPet && !currectPet->Health)
    {
        return true;
    }

    // Check dismiss/unslotted hunter pet
    if (unslottedHunterPet && !unslottedHunterPet->Health)
    {
        return true;
    }

    return false;
}

bool Player::IsExistPet()
{
    PetStable* const petStable = GetPetStable();
    return petStable && (petStable->CurrentPet || petStable->GetUnslottedHunterPet());
}

Pet* Player::CreatePet(Creature* creatureTarget, uint32 spellID /*= 0*/)
{
    if (IsExistPet())
    {
        return nullptr;
    }

    if (!creatureTarget || creatureTarget->IsPet() || creatureTarget->IsPlayer())
    {
        return nullptr;
    }

    CreatureTemplate const* creatrueTemplate = sObjectMgr->GetCreatureTemplate(creatureTarget->GetEntry());
    if (!creatrueTemplate->family)
    {
        // Creatures with family 0 crashes the server
        return nullptr;
    }

    // Everything looks OK, create new pet
    Pet* pet = CreateTamedPetFrom(creatureTarget, spellID);
    if (!pet)
    {
        return nullptr;
    }

    // "kill" original creature
    creatureTarget->DespawnOrUnsummon();

    // calculate proper level
    uint8 level = (creatureTarget->GetLevel() < (GetLevel() - 5)) ? (GetLevel() - 5) : GetLevel();

    // prepare visual effect for levelup
    pet->SetUInt32Value(UNIT_FIELD_LEVEL, level - 1);

    // add to world
    pet->GetMap()->AddToMap(pet->ToCreature());

    // visual effect for levelup
    pet->SetUInt32Value(UNIT_FIELD_LEVEL, level);

    // caster have pet now
    SetMinion(pet, true);

    pet->InitTalentForLevel();

    pet->SavePetToDB(PET_SAVE_AS_CURRENT);
    PetSpellInitialize();

    return pet;
}

Pet* Player::CreatePet(uint32 creatureEntry, uint32 spellID /*= 0*/)
{
    if (IsExistPet())
    {
        return nullptr;
    }

    CreatureTemplate const* creatrueTemplate = sObjectMgr->GetCreatureTemplate(creatureEntry);
    if (!creatrueTemplate->family)
    {
        // Creatures with family 0 crashes the server
        return nullptr;
    }

    // Everything looks OK, create new pet
    Pet* pet = CreateTamedPetFrom(creatureEntry, spellID);
    if (!pet)
    {
        return nullptr;
    }

    // prepare visual effect for levelup
    pet->SetUInt32Value(UNIT_FIELD_LEVEL, GetLevel() - 1);

    // add to world
    pet->GetMap()->AddToMap(pet->ToCreature());

    // visual effect for levelup
    pet->SetUInt32Value(UNIT_FIELD_LEVEL, GetLevel());

    // caster have pet now
    SetMinion(pet, true);

    pet->InitTalentForLevel();

    pet->SavePetToDB(PET_SAVE_AS_CURRENT);
    PetSpellInitialize();

    return pet;
}

void Player::StopCastingCharm(Aura* except /*= nullptr*/)
{
    Unit* charm = GetCharm();
    if (!charm)
    {
        return;
    }

    if (charm->IsCreature())
    {
        if (charm->ToCreature()->HasUnitTypeMask(UNIT_MASK_PUPPET))
        {
            ((Puppet*)charm)->UnSummon();
        }
        else if (charm->IsVehicle())
        {
            ExitVehicle();
        }
    }

    if (GetCharmGUID())
    {
        charm->RemoveAurasByType(SPELL_AURA_MOD_CHARM, ObjectGuid::Empty, except);
        charm->RemoveAurasByType(SPELL_AURA_MOD_POSSESS_PET, ObjectGuid::Empty, except);
        charm->RemoveAurasByType(SPELL_AURA_MOD_POSSESS, ObjectGuid::Empty, except);
        charm->RemoveAurasByType(SPELL_AURA_AOE_CHARM, ObjectGuid::Empty, except);
    }

    if (GetCharmGUID())
    {
        LOG_FATAL("entities.player", "Player {} ({} is not able to uncharm unit ({})", GetName(), GetGUID().ToString(), GetCharmGUID().ToString());

        if (charm->GetCharmerGUID())
        {
            LOG_FATAL("entities.player", "Charmed unit has charmer {}", charm->GetCharmerGUID().ToString());
            ABORT();
        }
        else
        {
            SetCharm(charm, false);
        }
    }
}

void Player::Say(std::string_view text, Language language, WorldObject const* /*= nullptr*/)
{
    std::string _text(text);
    if (!sScriptMgr->CanPlayerUseChat(this, CHAT_MSG_SAY, language, _text))
    {
        return;
    }

    sScriptMgr->OnPlayerChat(this, CHAT_MSG_SAY, language, _text);

    WorldPacket data;
    ChatHandler::BuildChatPacket(data, CHAT_MSG_SAY, language, this, this, _text);
    SendMessageToSetInRange(&data, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY), true, false, false, true);
}

void Player::Say(uint32 textId, WorldObject const* target /*= nullptr*/)
{
    Talk(textId, CHAT_MSG_SAY, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY), target);
}

void Player::Yell(std::string_view text, Language language, WorldObject const* /*= nullptr*/)
{
    std::string _text(text);

    if (!sScriptMgr->CanPlayerUseChat(this, CHAT_MSG_YELL, language, _text))
    {
        return;
    }

    sScriptMgr->OnPlayerChat(this, CHAT_MSG_YELL, language, _text);

    WorldPacket data;
    ChatHandler::BuildChatPacket(data, CHAT_MSG_YELL, language, this, this, _text);
    SendMessageToSetInRange(&data, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_YELL), true, false, false, true);
}

void Player::Yell(uint32 textId, WorldObject const* target /*= nullptr*/)
{
    Talk(textId, CHAT_MSG_YELL, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_YELL), target);
}

void Player::TextEmote(std::string_view text, WorldObject const* /*= nullptr*/, bool /*= false*/)
{
    std::string _text(text);

    if (!sScriptMgr->CanPlayerUseChat(this, CHAT_MSG_EMOTE, LANG_UNIVERSAL, _text))
    {
        return;
    }

    sScriptMgr->OnPlayerChat(this, CHAT_MSG_EMOTE, LANG_UNIVERSAL, _text);

    WorldPacket data;
    ChatHandler::BuildChatPacket(data, CHAT_MSG_EMOTE, LANG_UNIVERSAL, this, this, _text);

    SendMessageToSetInRange(&data, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_TEXTEMOTE), true, false, !sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_EMOTE), true);
}

void Player::TextEmote(uint32 textId, WorldObject const* target /*= nullptr*/, bool /*isBossEmote = false*/)
{
    Talk(textId, CHAT_MSG_EMOTE, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_TEXTEMOTE), target);
}

void Player::Whisper(std::string_view text, Language language, Player* target, bool /*= false*/)
{
    ASSERT(target);

    bool isAddonMessage = language == LANG_ADDON;

    if (!isAddonMessage)                                    // if not addon data
        language = LANG_UNIVERSAL;                          // whispers should always be readable

    std::string _text(text);

    if (!sScriptMgr->CanPlayerUseChat(this, CHAT_MSG_WHISPER, language, _text, target))
    {
        return;
    }

    sScriptMgr->OnPlayerChat(this, CHAT_MSG_WHISPER, language, _text, target);

    WorldPacket data;
    ChatHandler::BuildChatPacket(data, CHAT_MSG_WHISPER, language, this, this, _text);
    target->GetSession()->SendPacket(&data);

    // rest stuff shouldn't happen in case of addon message
    if (isAddonMessage)
        return;

    ChatHandler::BuildChatPacket(data, CHAT_MSG_WHISPER_INFORM, Language(language), target, target, _text);
    GetSession()->SendPacket(&data);

    if (!isAcceptWhispers() && !IsGameMaster() && !target->IsGameMaster())
    {
        SetAcceptWhispers(true);
        ChatHandler(GetSession()).SendSysMessage(LANG_COMMAND_WHISPERON);
    }

    // announce afk or dnd message
    if (target->isAFK())
    {
        ChatHandler(GetSession()).PSendSysMessage(LANG_PLAYER_AFK, target->GetName(), target->autoReplyMsg);
    }
    else if (target->isDND())
    {
        ChatHandler(GetSession()).PSendSysMessage(LANG_PLAYER_DND, target->GetName(), target->autoReplyMsg);
    }
}

void Player::Whisper(uint32 textId, Player* target, bool isBossWhisper)
{
    if (!target)
        return;

    BroadcastText const* bct = sObjectMgr->GetBroadcastText(textId);
    if (!bct)
    {
        LOG_ERROR("entities.unit", "Player::Whisper: `broadcast_text` was not {} found", textId);
        return;
    }

    LocaleConstant locale = target->GetSession()->GetSessionDbLocaleIndex();
    WorldPacket data;
    if (isBossWhisper)
        ChatHandler::BuildChatPacket(data, CHAT_MSG_RAID_BOSS_WHISPER, LANG_UNIVERSAL, this, target, bct->GetText(locale, getGender()), 0, "", locale);
    else
        ChatHandler::BuildChatPacket(data, CHAT_MSG_WHISPER, LANG_UNIVERSAL, this, target, bct->GetText(locale, getGender()), 0, "", locale);
    target->SendDirectMessage(&data);
}

void Player::PetSpellInitialize()
{
    Pet* pet = GetPet();

    if (!pet)
        return;

    LOG_DEBUG("entities.pet", "Pet Spells Groups");

    CharmInfo* charmInfo = pet->GetCharmInfo();

    WorldPacket data(SMSG_PET_SPELLS, 8 + 2 + 4 + 4 + 4 * MAX_UNIT_ACTION_BAR_INDEX + 1 + 1);
    data << pet->GetGUID();
    data << uint16(pet->GetCreatureTemplate()->family);         // creature family (required for pet talents)
    data << uint32(pet->GetDuration().count());
    data << uint8(pet->GetReactState());
    data << uint8(charmInfo->GetCommandState());
    data << uint16(0); // Flags, mostly unknown

    // action bar loop
    charmInfo->BuildActionBar(&data);

    std::size_t spellsCountPos = data.wpos();

    // spells count
    uint8 addlist = 0;
    data << uint8(addlist);                                 // placeholder

    if (pet->IsPermanentPetFor(this))
    {
        // spells loop
        for (PetSpellMap::iterator itr = pet->m_spells.begin(); itr != pet->m_spells.end(); ++itr)
        {
            if (itr->second.state == PETSPELL_REMOVED)
                continue;

            data << uint32(MAKE_UNIT_ACTION_BUTTON(itr->first, itr->second.active));
            ++addlist;
        }
    }

    data.put<uint8>(spellsCountPos, addlist);

    uint8 cooldownsCount = pet->m_CreatureSpellCooldowns.size();
    data << uint8(cooldownsCount);

    uint32 curTime = GameTime::GetGameTimeMS().count();
    uint32 infTime = GameTime::GetGameTimeMS().count() + infinityCooldownDelayCheck;

    for (CreatureSpellCooldowns::const_iterator itr = pet->m_CreatureSpellCooldowns.begin(); itr != pet->m_CreatureSpellCooldowns.end(); ++itr)
    {
        uint16 category = itr->second.category;
        uint32 cooldown = (itr->second.end > curTime) ? itr->second.end - curTime : 0;

        data << uint32(itr->first);                         // spellid
        data << uint16(itr->second.category);               // spell category

        // send infinity cooldown in special format
        if (itr->second.end >= infTime)
        {
            data << uint32(1);                              // cooldown
            data << uint32(0x80000000);                     // category cooldown
            continue;
        }

        data << uint32(category ? 0 : cooldown);            // cooldown
        data << uint32(category ? cooldown : 0);            // category cooldown
    }

    GetSession()->SendPacket(&data);
}

void Player::PossessSpellInitialize()
{
    Unit* charm = GetCharm();
    if (!charm)
        return;

    CharmInfo* charmInfo = charm->GetCharmInfo();

    if (!charmInfo)
    {
        LOG_ERROR("entities.player", "Player::PossessSpellInitialize(): charm ({}) has no charminfo!", charm->GetGUID().ToString());
        return;
    }

    WorldPacket data(SMSG_PET_SPELLS, 8 + 2 + 4 + 4 + 4 * MAX_UNIT_ACTION_BAR_INDEX + 1 + 1);
    data << charm->GetGUID();
    data << uint16(0);
    data << uint32(0);
    data << uint32(0);

    charmInfo->BuildActionBar(&data);

    data << uint8(0);                                       // spells count
    data << uint8(0);                                       // cooldowns count

    GetSession()->SendPacket(&data);
}

void Player::VehicleSpellInitialize()
{
    Creature* vehicle = GetVehicleCreatureBase();
    if (!vehicle)
        return;

    uint8 cooldownCount = vehicle->m_CreatureSpellCooldowns.size();

    WorldPacket data(SMSG_PET_SPELLS, 8 + 2 + 4 + 4 + 4 * 10 + 1 + 1 + cooldownCount * (4 + 2 + 4 + 4));
    data << vehicle->GetGUID();                             // Guid
    data << uint16(0);                                      // Pet Family (0 for all vehicles)
    data << uint32(vehicle->IsSummon() ? vehicle->ToTempSummon()->GetTimer() : 0); // Duration
    // The following three segments are read by the client as one uint32
    data << uint8(vehicle->GetReactState());                // React State
    data << uint8(0);                                       // Command State
    data << uint16(0x800);                                  // DisableActions (set for all vehicles)

    for (uint32 i = 0; i < MAX_CREATURE_SPELLS; ++i)
    {
        uint32 spellId = vehicle->m_spells[i];
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
        if (!spellInfo)
        {
            data << uint16(0) << uint8(0) << uint8(i + 8);
            continue;
        }

        ConditionList conditions = sConditionMgr->GetConditionsForVehicleSpell(vehicle->GetEntry(), spellId);
        if (!sConditionMgr->IsObjectMeetToConditions(this, vehicle, conditions))
        {
            LOG_DEBUG("condition", "VehicleSpellInitialize: conditions not met for Vehicle entry {} spell {}", vehicle->ToCreature()->GetEntry(), spellId);
            data << uint16(0) << uint8(0) << uint8(i + 8);
            continue;
        }

        if (spellInfo->IsPassive())
            vehicle->CastSpell(vehicle, spellId, true);

        data << uint32(MAKE_UNIT_ACTION_BUTTON(spellId, i + 8));
    }

    for (uint32 i = MAX_CREATURE_SPELLS; i < MAX_SPELL_CONTROL_BAR; ++i)
        data << uint32(0);

    data << uint8(0); // Auras?

    // Cooldowns
    data << uint8(cooldownCount);

    uint32 curTime = GameTime::GetGameTimeMS().count();
    uint32 infTime = GameTime::GetGameTimeMS().count() + infinityCooldownDelayCheck;

    for (CreatureSpellCooldowns::const_iterator itr = vehicle->m_CreatureSpellCooldowns.begin(); itr != vehicle->m_CreatureSpellCooldowns.end(); ++itr)
    {
        uint16 category = itr->second.category;
        uint32 cooldown = (itr->second.end > curTime) ? itr->second.end - curTime : 0;

        data << uint32(itr->first);              // spellid
        data << uint16(itr->second.category);    // spell category

        // send infinity cooldown in special format
        if (itr->second.end >= infTime)
        {
            data << uint32(1);                  // cooldown
            data << uint32(0x80000000);         // category cooldown
            continue;
        }

        data << uint32(category ? 0 : cooldown); // cooldown
        data << uint32(category ? cooldown : 0); // category cooldown
    }

    GetSession()->SendPacket(&data);
}

void Player::CharmSpellInitialize()
{
    Unit* charm = GetFirstControlled();
    if (!charm)
        return;

    CharmInfo* charmInfo = charm->GetCharmInfo();
    if (!charmInfo)
    {
        LOG_ERROR("entities.player", "Player::CharmSpellInitialize(): the player's charm ({}) has no charminfo!", charm->GetGUID().ToString());
        return;
    }

    uint8 addlist = 0;
    if (!charm->IsPlayer())
    {
        //CreatureInfo const* cinfo = charm->ToCreature()->GetCreatureTemplate();
        //if (cinfo && cinfo->type == CREATURE_TYPE_DEMON && getClass() == CLASS_WARLOCK)
        {
            for (uint32 i = 0; i < MAX_SPELL_CHARM; ++i)
                if (charmInfo->GetCharmSpell(i)->GetAction())
                    ++addlist;
        }
    }

    WorldPacket data(SMSG_PET_SPELLS, 8 + 2 + 4 + 4 + 4 * MAX_UNIT_ACTION_BAR_INDEX + 1 + 4 * addlist + 1);
    data << charm->GetGUID();
    data << uint16(0);
    data << uint32(0);

    if (!charm->IsPlayer())
        data << uint8(charm->ToCreature()->GetReactState()) << uint8(charmInfo->GetCommandState()) << uint16(0);
    else
        data << uint32(0);

    charmInfo->BuildActionBar(&data);

    data << uint8(addlist);

    if (addlist)
    {
        for (uint32 i = 0; i < MAX_SPELL_CHARM; ++i)
        {
            CharmSpellInfo* cspell = charmInfo->GetCharmSpell(i);
            if (cspell->GetAction())
                data << uint32(cspell->packedData);
        }
    }

    data << uint8(0);                                       // cooldowns count

    GetSession()->SendPacket(&data);
}

void Player::SendRemoveControlBar()
{
    WorldPacket data(SMSG_PET_SPELLS, 8);
    data << uint64(0);
    GetSession()->SendPacket(&data);
}

bool Player::HasSpellMod(SpellModifier* mod, Spell* spell)
{
    if (!mod || !spell)
        return false;

    return spell->m_appliedMods.find(mod->ownerAura) != spell->m_appliedMods.end();
}

bool Player::IsAffectedBySpellmod(SpellInfo const* spellInfo, SpellModifier* mod, Spell* spell)
{
    if (!mod || !spellInfo)
        return false;

    // Mod out of charges
    if (spell && mod->charges == -1 && spell->m_appliedMods.find(mod->ownerAura) == spell->m_appliedMods.end())
        return false;

    // +duration to infinite duration spells making them limited
    if (mod->op == SPELLMOD_DURATION && spellInfo->GetDuration() == -1)
        return false;

    return spellInfo->IsAffectedBySpellMod(mod);
}

template <class T>
void Player::ApplySpellMod(uint32 spellId, SpellModOp op, T& basevalue, Spell* spell, bool temporaryPet)
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
    {
        return;
    }

    float totalmul = 1.0f;
    int32 totalflat = 0;

    auto calculateSpellMod = [&](SpellModifier* mod)
    {
        // xinef: temporary pets cannot use charged mods of owner, needed for mirror image QQ they should use their own auras
        if (temporaryPet && mod->charges != 0)
        {
            return;
        }

        if (mod->type == SPELLMOD_FLAT)
        {
            // xinef: do not allow to consume more than one 100% crit increasing spell
            if (mod->op == SPELLMOD_CRITICAL_CHANCE && totalflat >= 100)
            {
                return;
            }

            int32 flatValue = mod->value;

            // SPELL_MOD_THREAT - divide by 100 (in packets we send threat * 100)
            if (mod->op == SPELLMOD_THREAT)
            {
                flatValue /= 100;
            }

            totalflat += flatValue;
        }
        else if (mod->type == SPELLMOD_PCT)
        {
            // skip percent mods for null basevalue (most important for spell mods with charges)
            if (basevalue == T(0) || totalmul == 0.0f)
            {
                return;
            }

            // special case (skip > 10sec spell casts for instant cast setting)
            if (mod->op == SPELLMOD_CASTING_TIME && basevalue >= T(10000) && mod->value <= -100)
            {
                return;
            }
            // xinef: special exception for surge of light, dont affect crit chance if previous mods were not applied
            else if (mod->op == SPELLMOD_CRITICAL_CHANCE && spell && !HasSpellMod(mod, spell))
            {
                return;
            }
            // xinef: special case for backdraft gcd reduce with backlast time reduction, dont affect gcd if cast time was not applied
            else if (mod->op == SPELLMOD_GLOBAL_COOLDOWN && spell && !HasSpellMod(mod, spell))
            {
                return;
            }

            // xinef: those two mods should be multiplicative (Glyph of Renew)
            if (mod->op == SPELLMOD_DAMAGE || mod->op == SPELLMOD_DOT)
            {
                totalmul *= CalculatePct(1.0f, 100.0f + mod->value);
            }
            else
            {
                totalmul += CalculatePct(1.0f, mod->value);
            }
        }

        DropModCharge(mod, spell);
    };

    // Drop charges for triggering spells instead of triggered ones
    if (m_spellModTakingSpell)
    {
        spell = m_spellModTakingSpell;
    }

    SpellModifier* chargedMod = nullptr;
    for (auto mod : m_spellMods[op])
    {
        // Charges can be set only for mods with auras
        if (!mod->ownerAura)
        {
            ASSERT(!mod->charges);
        }

        if (!IsAffectedBySpellmod(spellInfo, mod, spell))
        {
            continue;
        }

        if (mod->ownerAura->IsUsingCharges())
        {
            if (!chargedMod || (chargedMod->ownerAura->GetSpellInfo()->SpellPriority < mod->ownerAura->GetSpellInfo()->SpellPriority))
            {
                chargedMod = mod;
            }

            continue;
        }

        calculateSpellMod(mod);
    }

    if (chargedMod)
    {
        calculateSpellMod(chargedMod);
    }

    float diff = 0.0f;
    if (op == SPELLMOD_CASTING_TIME || op == SPELLMOD_DURATION)
    {
        diff = ((float)basevalue + totalflat) * (totalmul - 1.0f) + (float)totalflat;
    }
    else
    {
        diff = (float)basevalue * (totalmul - 1.0f) + (float)totalflat;
    }

    basevalue = T((float)basevalue + diff);
}

template AC_GAME_API void Player::ApplySpellMod(uint32 spellId, SpellModOp op, int32& basevalue, Spell* spell, bool temporaryPet);
template AC_GAME_API void Player::ApplySpellMod(uint32 spellId, SpellModOp op, uint32& basevalue, Spell* spell, bool temporaryPet);
template AC_GAME_API void Player::ApplySpellMod(uint32 spellId, SpellModOp op, float& basevalue, Spell* spell, bool temporaryPet);

// Binary predicate for sorting SpellModifiers
class SpellModPred
{
public:
    SpellModPred() {}
    bool operator() (SpellModifier const* a, SpellModifier const* b) const
    {
        if (a->type != b->type)
            return a->type == SPELLMOD_FLAT;
        return a->value < b->value;
    }
};
class MageSpellModPred
{
public:
    MageSpellModPred() {}
    bool operator() (SpellModifier const* a, SpellModifier const* b) const
    {
        if (a->type != b->type)
            return a->type == SPELLMOD_FLAT;
        if (a->spellId == 44401)
            return true;
        if (b->spellId == 44401)
            return false;
        return a->value < b->value;
    }
};

void Player::AddSpellMod(SpellModifier* mod, bool apply)
{
    LOG_DEBUG("spells.aura", "Player::AddSpellMod {}", mod->spellId);
    uint16 Opcode = (mod->type == SPELLMOD_FLAT) ? SMSG_SET_FLAT_SPELL_MODIFIER : SMSG_SET_PCT_SPELL_MODIFIER;

    int i = 0;
    flag96 _mask = 0;
    for (int eff = 0; eff < 96; ++eff)
    {
        if (eff != 0 && eff % 32 == 0)
            _mask[i++] = 0;

        _mask[i] = uint32(1) << (eff - (32 * i));
        if (mod->mask & _mask)
        {
            int32 val = 0;
            for (SpellModList::iterator itr = m_spellMods[mod->op].begin(); itr != m_spellMods[mod->op].end(); ++itr)
            {
                if ((*itr)->type == mod->type && (*itr)->mask & _mask)
                    val += (*itr)->value;
            }
            val += apply ? mod->value : -(mod->value);
            WorldPacket data(Opcode, (1 + 1 + 4));
            data << uint8(eff);
            data << uint8(mod->op);
            data << int32(val);
            SendDirectMessage(&data);
        }
    }

    if (apply)
    {
        m_spellMods[mod->op].push_back(mod);
        if (IsClass(CLASS_MAGE, CLASS_CONTEXT_ABILITY))
            m_spellMods[mod->op].sort(MageSpellModPred());
        else
            m_spellMods[mod->op].sort(SpellModPred());
    }
    else
    {
        m_spellMods[mod->op].remove(mod);
        // mods bound to aura will be removed in AuraEffect::~AuraEffect
        if (!mod->ownerAura)
            delete mod;
    }
}

// Restore spellmods in case of failed cast
void Player::RestoreSpellMods(Spell* spell, uint32 ownerAuraId, Aura* aura)
{
    if (!spell || spell->m_appliedMods.empty())
        return;

    std::list<Aura*> aurasQueue;

    for (uint8 i = 0; i < MAX_SPELLMOD; ++i)
    {
        for (SpellModList::iterator itr = m_spellMods[i].begin(); itr != m_spellMods[i].end(); ++itr)
        {
            SpellModifier* mod = *itr;

            // Spellmods without aura set cannot be charged
            if (!mod->ownerAura || !mod->ownerAura->IsUsingCharges())
                continue;

            // Restore only specific owner aura mods
            if (ownerAuraId && (ownerAuraId != mod->ownerAura->GetSpellInfo()->Id))
                continue;

            if (aura && mod->ownerAura != aura)
                continue;

            // Check if mod affected this spell
            // First, check if the mod aura applied at least one spellmod to this spell
            Spell::UsedSpellMods::iterator iterMod = spell->m_appliedMods.find(mod->ownerAura);
            if (iterMod == spell->m_appliedMods.end())
                continue;
            // Second, check if the current mod is one of those applied by the mod aura
            if (!(mod->mask & spell->m_spellInfo->SpellFamilyFlags))
                continue;

            // remove from list - This will be done after all mods have been gone through
            // to ensure we iterate over all mods of an aura before removing said aura
            // from applied mods (Else, an aura with two mods on the current spell would
            // only see the first of its modifier restored)
            aurasQueue.push_back(mod->ownerAura);

            // add mod charges back to mod
            if (mod->charges == -1)
                mod->charges = 1;
            else
                mod->charges++;

            // Do not set more spellmods than available
            if (mod->ownerAura->GetCharges() < mod->charges)
                mod->charges = mod->ownerAura->GetCharges();

            // Skip this check for now - aura charges may change due to various reason
            /// @todo track these changes correctly
            //ASSERT (mod->ownerAura->GetCharges() <= mod->charges);
        }
    }

    for (std::list<Aura*>::iterator itr = aurasQueue.begin(); itr != aurasQueue.end(); ++itr)
    {
        Spell::UsedSpellMods::iterator iterMod = spell->m_appliedMods.find(*itr);
        if (iterMod != spell->m_appliedMods.end())
            spell->m_appliedMods.erase(iterMod);
    }

    // Xinef: clear the list just do be sure
    if (!ownerAuraId && !aura)
        spell->m_appliedMods.clear();
}

void Player::RestoreAllSpellMods(uint32 ownerAuraId, Aura* aura)
{
    for (uint32 i = 0; i < CURRENT_MAX_SPELL; ++i)
        if (m_currentSpells[i])
            RestoreSpellMods(m_currentSpells[i], ownerAuraId, aura);
}

void Player::RemoveSpellMods(Spell* spell)
{
    if (!spell)
        return;

    if (spell->m_appliedMods.empty())
        return;

    SpellInfo const* const spellInfo = spell->m_spellInfo;

    for (uint8 i = 0; i < MAX_SPELLMOD; ++i)
    {
        for (SpellModList::const_iterator itr = m_spellMods[i].begin(); itr != m_spellMods[i].end();)
        {
            SpellModifier* mod = *itr;
            ++itr;

            // don't handle spells with proc_event entry defined
            // this is a temporary workaround, because all spellmods should be handled like that
            if (sSpellMgr->GetSpellProcEvent(mod->spellId))
            {
                continue;
            }

            // spellmods without aura set cannot be charged
            if (!mod->ownerAura || !mod->ownerAura->IsUsingCharges())
                continue;

            // check if mod affected this spell
            Spell::UsedSpellMods::iterator iterMod = spell->m_appliedMods.find(mod->ownerAura);
            if (iterMod == spell->m_appliedMods.end())
                continue;

            // remove from list
            // leave this here, if spell have two mods it will remove 2 charges - wrong
            spell->m_appliedMods.erase(iterMod);

            // MAGE T8P4 BONUS
            if (spellInfo->SpellFamilyName == SPELLFAMILY_MAGE)
            {
                SpellInfo const* sp = mod->ownerAura->GetSpellInfo();
                // Missile Barrage, Hot Streak, Brain Freeze (trigger spell - Fireball!)
                if (sp->SpellIconID == 3261 || sp->SpellIconID == 2999 || sp->SpellIconID == 2938)
                    if (AuraEffect* aurEff = GetAuraEffectDummy(64869))
                        if (roll_chance_i(aurEff->GetAmount()))
                        {
                            mod->charges = 1;
                            continue;
                        }
            }

            if (mod->ownerAura->DropCharge(AURA_REMOVE_BY_EXPIRE))
                itr = m_spellMods[i].begin();
        }
    }
}

void Player::DropModCharge(SpellModifier* mod, Spell* spell)
{
    if (spell && mod->ownerAura && mod->charges > 0)
    {
        if (--mod->charges == 0)
            mod->charges = -1;

        spell->m_appliedMods.insert(mod->ownerAura);
    }
}

void Player::SetSpellModTakingSpell(Spell* spell, bool apply)
{
    if (apply && m_spellModTakingSpell)
    {
        LOG_INFO("misc", "Player::SetSpellModTakingSpell (A1) - {}, {}", spell->m_spellInfo->Id, m_spellModTakingSpell->m_spellInfo->Id);
        return;
        //ASSERT(m_spellModTakingSpell == nullptr);
    }
    else if (!apply)
    {
        if (!m_spellModTakingSpell)
            LOG_INFO("misc", "Player::SetSpellModTakingSpell (B1) - {}", spell->m_spellInfo->Id);
        else if (m_spellModTakingSpell != spell)
        {
            LOG_INFO("misc", "Player::SetSpellModTakingSpell (C1) - {}, {}", spell->m_spellInfo->Id, m_spellModTakingSpell->m_spellInfo->Id);
            return;
        }
        //ASSERT(m_spellModTakingSpell && m_spellModTakingSpell == spell);
    }

    m_spellModTakingSpell = apply ? spell : nullptr;
}

// send Proficiency
void Player::SendProficiency(ItemClass itemClass, uint32 itemSubclassMask)
{
    WorldPacket data(SMSG_SET_PROFICIENCY, 1 + 4);
    data << uint8(itemClass) << uint32(itemSubclassMask);
    GetSession()->SendPacket(&data);
}

void Player::RemovePetitionsAndSigns(ObjectGuid guid, uint32 type)
{
    SignatureContainer* signatureStore = sPetitionMgr->GetSignatureStore();
    for (SignatureContainer::iterator itr = signatureStore->begin(); itr != signatureStore->end(); ++itr)
    {
        SignatureMap::iterator signItr = itr->second.signatureMap.find(guid);
        if (signItr != itr->second.signatureMap.end())
        {
            Petition const* petition = sPetitionMgr->GetPetition(itr->first);
            if (!petition || (type != 10 && type != petition->petitionType))
                continue;

            // erase this
            itr->second.signatureMap.erase(signItr);

            // send update if charter owner in game
            Player* owner = ObjectAccessor::FindConnectedPlayer(petition->ownerGuid);
            if (owner)
                owner->GetSession()->SendPetitionQueryOpcode(petition->petitionGuid);
        }
    }

    if (type == 10)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ALL_PETITION_SIGNATURES);
        stmt->SetData(0, guid.GetCounter());
        CharacterDatabase.Execute(stmt);
    }
    else
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_SIGNATURE);
        stmt->SetData(0, guid.GetCounter());
        stmt->SetData(1, uint8(type));
        CharacterDatabase.Execute(stmt);
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    if (type == 10)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_BY_OWNER);
        stmt->SetData(0, guid.GetCounter());
        trans->Append(stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_SIGNATURE_BY_OWNER);
        stmt->SetData(0, guid.GetCounter());
        trans->Append(stmt);

        // xinef: clear petition store
        sPetitionMgr->RemovePetitionByOwnerAndType(guid, 0);
    }
    else
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_BY_OWNER_AND_TYPE);
        stmt->SetData(0, guid.GetCounter());
        stmt->SetData(1, uint8(type));
        trans->Append(stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_SIGNATURE_BY_OWNER_AND_TYPE);
        stmt->SetData(0, guid.GetCounter());
        stmt->SetData(1, uint8(type));
        trans->Append(stmt);

        // xinef: clear petition store
        sPetitionMgr->RemovePetitionByOwnerAndType(guid, uint8(type));
    }
    CharacterDatabase.CommitTransaction(trans);
}

void Player::LeaveAllArenaTeams(ObjectGuid guid)
{
    // xinef: sync query
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_ARENA_TEAMS);
    stmt->SetData(0, guid.GetCounter());
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();
        uint32 arenaTeamId = fields[0].Get<uint32>();
        if (arenaTeamId != 0)
        {
            ArenaTeam* arenaTeam = sArenaTeamMgr->GetArenaTeamById(arenaTeamId);
            if (arenaTeam)
                arenaTeam->DelMember(guid, true);
        }
    } while (result->NextRow());
}

void Player::SetRestBonus(float rest_bonus_new)
{
    // Prevent resting on max level
    if (GetLevel() >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        rest_bonus_new = 0;

    if (rest_bonus_new < 0)
        rest_bonus_new = 0;

    float rest_bonus_max = (float)GetUInt32Value(PLAYER_NEXT_LEVEL_XP) * 1.5f / 2;

    if (rest_bonus_new > rest_bonus_max)
        _restBonus = rest_bonus_max;
    else
        _restBonus = rest_bonus_new;

    // update data for client
    if ((GetsRecruitAFriendBonus(true) && (GetSession()->IsARecruiter() || GetSession()->GetRecruiterId() != 0)))
        SetByteValue(PLAYER_BYTES_2, 3, REST_STATE_RAF_LINKED);
    else
    {
        if (_restBonus > 10)
            SetByteValue(PLAYER_BYTES_2, 3, REST_STATE_RESTED);
        else if (_restBonus <= 1)
            SetByteValue(PLAYER_BYTES_2, 3, REST_STATE_NOT_RAF_LINKED);
    }

    //RestTickUpdate
    SetUInt32Value(PLAYER_REST_STATE_EXPERIENCE, uint32(_restBonus));
}

bool Player::ActivateTaxiPathTo(std::vector<uint32> const& nodes, Creature* npc /*= nullptr*/, uint32 spellid /*= 1*/)
{
    if (nodes.size() < 2)
        return false;

    // not let cheating with start flight in time of logout process || while in combat || has type state: stunned || has type state: root
    if (GetSession()->isLogingOut() || IsInCombat() || HasUnitState(UNIT_STATE_STUNNED) || HasUnitState(UNIT_STATE_ROOT))
    {
        GetSession()->SendActivateTaxiReply(ERR_TAXIPLAYERBUSY);
        return false;
    }

    if (HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return false;

    // taximaster case
    if (npc)
    {
        // not let cheating with start flight mounted
        if (IsMounted())
        {
            GetSession()->SendActivateTaxiReply(ERR_TAXIPLAYERALREADYMOUNTED);
            return false;
        }

        if (IsInDisallowedMountForm())
        {
            GetSession()->SendActivateTaxiReply(ERR_TAXIPLAYERSHAPESHIFTED);
            return false;
        }

        // not let cheating with start flight in time of logout process || if casting not finished || while in combat || if not use Spell's with EffectSendTaxi
        if (IsNonMeleeSpellCast(false))
        {
            GetSession()->SendActivateTaxiReply(ERR_TAXIPLAYERBUSY);
            return false;
        }
    }
    // cast case or scripted call case
    else
    {
        RemoveAurasByType(SPELL_AURA_MOUNTED);

        if (IsInDisallowedMountForm())
            RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);

        if (Spell* spell = GetCurrentSpell(CURRENT_GENERIC_SPELL))
            if (spell->m_spellInfo->Id != spellid)
                InterruptSpell(CURRENT_GENERIC_SPELL, false);

        InterruptSpell(CURRENT_AUTOREPEAT_SPELL, false);

        if (Spell* spell = GetCurrentSpell(CURRENT_CHANNELED_SPELL))
            if (spell->m_spellInfo->Id != spellid)
                InterruptSpell(CURRENT_CHANNELED_SPELL, true);
    }

    uint32 sourcenode = nodes[0];

    // starting node too far away (cheat?)
    TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(sourcenode);
    if (!node)
    {
        GetSession()->SendActivateTaxiReply(ERR_TAXINOSUCHPATH);
        return false;
    }

    // Prepare to flight start now

    // stop combat at start taxi flight if any
    CombatStop();

    StopCastingCharm();
    StopCastingBindSight();
    ExitVehicle();

    // stop trade (client cancel trade at taxi map open but cheating tools can be used for reopen it)
    TradeCancel(true);

    // clean not finished taxi path if any
    m_taxi.ClearTaxiDestinations();

    // 0 element current node
    m_taxi.AddTaxiDestination(sourcenode);

    // fill destinations path tail
    uint32 sourcepath = 0;
    uint32 totalcost = 0;
    uint32 firstcost = 0;

    uint32 prevnode = sourcenode;
    uint32 lastnode = 0;

    for (uint32 i = 1; i < nodes.size(); ++i)
    {
        uint32 path, cost;

        lastnode = nodes[i];
        sObjectMgr->GetTaxiPath(prevnode, lastnode, path, cost);

        if (!path)
        {
            m_taxi.ClearTaxiDestinations();
            return false;
        }

        totalcost += cost;
        if (i == 1)
            firstcost = cost;

        if (prevnode == sourcenode)
            sourcepath = path;

        m_taxi.AddTaxiDestination(lastnode);

        prevnode = lastnode;
    }

    // get mount model (in case non taximaster (npc == nullptr) allow more wide lookup)
    //
    // Hack-Fix for Alliance not being able to use Acherus taxi. There is
    // only one mount ID for both sides. Probably not good to use 315 in case DBC nodes
    // change but I couldn't find a suitable alternative. OK to use class because only DK
    // can use this taxi.
    uint32 mount_display_id = sObjectMgr->GetTaxiMountDisplayId(sourcenode, GetTeamId(true), npc == nullptr || (sourcenode == 315 && IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_TAXI)));

    // in spell case allow 0 model
    if ((mount_display_id == 0 && spellid == 0) || sourcepath == 0)
    {
        GetSession()->SendActivateTaxiReply(ERR_TAXIUNSPECIFIEDSERVERERROR);
        m_taxi.ClearTaxiDestinations();
        return false;
    }

    uint32 money = GetMoney();

    if (npc)
    {
        float discount = GetReputationPriceDiscount(npc);
        totalcost = uint32(ceil(totalcost * discount));
        firstcost = uint32(ceil(firstcost * discount));
        m_taxi.SetFlightMasterFactionTemplateId(npc->GetFaction());
    }
    else
    {
        m_taxi.SetFlightMasterFactionTemplateId(0);
    }

    if (money < totalcost)
    {
        GetSession()->SendActivateTaxiReply(ERR_TAXINOTENOUGHMONEY);
        m_taxi.ClearTaxiDestinations();
        return false;
    }

    //Checks and preparations done, DO FLIGHT
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_FLIGHT_PATHS_TAKEN, 1);

    // prevent stealth flight
    //RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TALK);

    // Xinef: dont use instant flight paths if spellid is present (custom calls use spellid = 1)
    if ((sWorld->getIntConfig(CONFIG_INSTANT_TAXI) == 1 || (sWorld->getIntConfig(CONFIG_INSTANT_TAXI) == 2 && m_isInstantFlightOn)) && !spellid)
    {
        TaxiNodesEntry const* lastPathNode = sTaxiNodesStore.LookupEntry(nodes[nodes.size() - 1]);
        m_taxi.ClearTaxiDestinations();
        ModifyMoney(-(int32)totalcost);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_TRAVELLING, totalcost);
        TeleportTo(lastPathNode->map_id, lastPathNode->x, lastPathNode->y, lastPathNode->z, GetOrientation());
        return false;
    }
    else
    {
        m_flightSpellActivated = spellid;
        ModifyMoney(-(int32)firstcost);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_TRAVELLING, firstcost);
        GetSession()->SendActivateTaxiReply(ERR_TAXIOK);
        GetSession()->SendDoFlight(mount_display_id, sourcepath);
    }
    return true;
}

bool Player::ActivateTaxiPathTo(uint32 taxi_path_id, uint32 spellid /*= 1*/)
{
    TaxiPathEntry const* entry = sTaxiPathStore.LookupEntry(taxi_path_id);
    if (!entry)
        return false;

    std::vector<uint32> nodes;

    nodes.resize(2);
    nodes[0] = entry->from;
    nodes[1] = entry->to;

    return ActivateTaxiPathTo(nodes, nullptr, spellid);
}

void Player::CleanupAfterTaxiFlight()
{
    // For spells that trigger flying paths remove them at arrival
    if (m_flightSpellActivated)
    {
        this->RemoveAurasDueToSpell(m_flightSpellActivated);
        m_flightSpellActivated = 0;
    }
    m_taxi.ClearTaxiDestinations();        // not destinations, clear source node
    Dismount();
    RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_TAXI_FLIGHT);
    getHostileRefMgr().setOnlineOfflineState(true);
}

void Player::ContinueTaxiFlight()
{
    uint32 sourceNode = m_taxi.GetTaxiSource();
    if (!sourceNode)
        return;

    LOG_DEBUG("entities.unit", "WORLD: Restart character {} taxi flight", GetGUID().ToString());

    uint32 mountDisplayId = sObjectMgr->GetTaxiMountDisplayId(sourceNode, GetTeamId(true), true);
    if (!mountDisplayId)
        return;

    uint32 path = m_taxi.GetCurrentTaxiPath();

    // search appropriate start path node
    uint32 startNode = 0;

    TaxiPathNodeList const& nodeList = sTaxiPathNodesByPath[path];

    float bestDist = SIZE_OF_GRIDS * SIZE_OF_GRIDS; // xinef: large value
    float currDist = 0.0f;

    // xinef: changed to -1, we dont want to catch last node
    for (uint32 i = 0; i < nodeList.size() - 1; ++i)
    {
        TaxiPathNodeEntry const* node = nodeList[i];
        TaxiPathNodeEntry const* nextNode = nodeList[i + 1];

        // xinef: skip nodes at another map, get last valid node on current map
        if (nextNode->mapid != GetMapId() || node->mapid != GetMapId())
            continue;

        currDist = (node->x - GetPositionX()) * (node->x - GetPositionX()) + (node->y - GetPositionY()) * (node->y - GetPositionY()) + (node->z - GetPositionZ()) * (node->z - GetPositionZ());
        if (currDist < bestDist)
        {
            startNode = i;
            bestDist = currDist;
        }
    }

    // xinef: no proper node was found
    if (startNode == 0)
    {
        m_taxi.ClearTaxiDestinations();
        return;
    }

    if (IsInDisallowedMountForm())
    {
        RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);
    }

    if (IsMounted())
    {
        RemoveAurasByType(SPELL_AURA_MOUNTED);
    }

    SetCanTeleport(true);

    GetSession()->SendDoFlight(mountDisplayId, path, startNode);
}

void Player::SendTaxiNodeStatusMultiple()
{
    for (auto itr = m_clientGUIDs.begin(); itr != m_clientGUIDs.end(); ++itr)
    {
        if (!itr->IsCreature())
        {
            continue;
        }

        Creature* creature = ObjectAccessor::GetCreature(*this, *itr);
        if (!creature || creature->IsHostileTo(this))
        {
            continue;
        }

        if (!creature->HasNpcFlag(UNIT_NPC_FLAG_FLIGHTMASTER))
        {
            continue;
        }

        uint32 nearestNode = sObjectMgr->GetNearestTaxiNode(creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), creature->GetMapId(), GetTeamId());
        if (!nearestNode)
        {
            continue;
        }

        WorldPacket data(SMSG_TAXINODE_STATUS, 9);
        data << *itr;
        data << uint8(m_taxi.IsTaximaskNodeKnown(nearestNode) ? 1 : 0);
        SendDirectMessage(&data);
    }
}

void Player::ProhibitSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs)
{
    PacketCooldowns cooldowns;
    WorldPacket data;

    for (PlayerSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
    {
        if (itr->second->State == PLAYERSPELL_REMOVED)
            continue;
        uint32 unSpellId = itr->first;
        SpellInfo const* spellInfo = sSpellMgr->AssertSpellInfo(unSpellId);

        // Not send cooldown for this spells
        if (spellInfo->IsCooldownStartedOnEvent())
            continue;

        if (spellInfo->PreventionType != SPELL_PREVENTION_TYPE_SILENCE)
            continue;

        if ((idSchoolMask & spellInfo->GetSchoolMask()) && GetSpellCooldownDelay(unSpellId) < unTimeMs)
        {
            cooldowns[unSpellId] = unTimeMs;
            AddSpellCooldown(unSpellId, 0, unTimeMs, true);
        }
    }

    if (!cooldowns.empty())
    {
        BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, cooldowns);
        GetSession()->SendPacket(&data);
    }
}

void Player::InitDataForForm(bool reapplyMods)
{
    ShapeshiftForm form = GetShapeshiftForm();

    SpellShapeshiftFormEntry const* ssEntry = sSpellShapeshiftFormStore.LookupEntry(form);
    if (ssEntry && ssEntry->attackSpeed)
    {
        SetAttackTime(BASE_ATTACK, ssEntry->attackSpeed);
        SetAttackTime(OFF_ATTACK, ssEntry->attackSpeed);
        SetAttackTime(RANGED_ATTACK, BASE_ATTACK_TIME);
    }
    else
        SetRegularAttackTime();

    switch (form)
    {
        case FORM_GHOUL:
        case FORM_CAT:
            {
                if (getPowerType() != POWER_ENERGY)
                    setPowerType(POWER_ENERGY);
                break;
            }
        case FORM_BEAR:
        case FORM_DIREBEAR:
            {
                if (getPowerType() != POWER_RAGE)
                    setPowerType(POWER_RAGE);
                break;
            }
        default:                                            // 0, for example
            {
                ChrClassesEntry const* cEntry = sChrClassesStore.LookupEntry(getClass());
                if (cEntry && cEntry->powerType < MAX_POWERS && uint32(getPowerType()) != cEntry->powerType)
                    setPowerType(Powers(cEntry->powerType));
                break;
            }
    }

    // update auras at form change, ignore this at mods reapply (.reset stats/etc) when form not change.
    if (!reapplyMods)
        UpdateEquipSpellsAtFormChange();

    UpdateAttackPowerAndDamage();
    UpdateAttackPowerAndDamage(true);
}

void Player::InitDisplayIds()
{
    PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(true), getClass());
    if (!info)
    {
        LOG_ERROR("entities.player", "Player {} has incorrect race/class pair. Can't init display ids.", GetGUID().ToString());
        return;
    }

    uint8 gender = getGender();
    switch (gender)
    {
        case GENDER_FEMALE:
            SetDisplayId(info->displayId_f);
            SetNativeDisplayId(info->displayId_f);
            break;
        case GENDER_MALE:
            SetDisplayId(info->displayId_m);
            SetNativeDisplayId(info->displayId_m);
            break;
        default:
            LOG_ERROR("entities.player", "Invalid gender {} for player", gender);
            return;
    }
}

inline bool Player::_StoreOrEquipNewItem(uint32 vendorslot, uint32 item, uint8 count, uint8 bag, uint8 slot, int32 price, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore)
{
    ItemPosCountVec vDest;
    uint16 uiDest = 0;
    InventoryResult msg = bStore ?
                          CanStoreNewItem(bag, slot, vDest, item, pProto->BuyCount * count) :
                          CanEquipNewItem(slot, uiDest, item, false);
    if (msg != EQUIP_ERR_OK)
    {
        SendEquipError(msg, nullptr, nullptr, item);
        return false;
    }

    ModifyMoney(-price);

    if (crItem->ExtendedCost)                            // case for new honor system
    {
        ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(crItem->ExtendedCost);
        if (iece->reqhonorpoints)
            ModifyHonorPoints(- int32(iece->reqhonorpoints * count));

        if (iece->reqarenapoints)
            ModifyArenaPoints(- int32(iece->reqarenapoints * count));

        for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i)
        {
            if (iece->reqitem[i])
                DestroyItemCount(iece->reqitem[i], (iece->reqitemcount[i] * count), true);
        }
    }

    sScriptMgr->OnBeforeStoreOrEquipNewItem(this, vendorslot, item, count, bag, slot, pProto, pVendor, crItem, bStore);

    Item* it = bStore ? StoreNewItem(vDest, item, true) : EquipNewItem(uiDest, item, true);
    if (it)
    {
        uint32 new_count = pVendor->UpdateVendorItemCurrentCount(crItem, pProto->BuyCount * count);

        WorldPacket data(SMSG_BUY_ITEM, (8 + 4 + 4 + 4));
        data << pVendor->GetGUID();
        data << uint32(vendorslot + 1);                   // numbered from 1 at client
        data << int32(crItem->maxcount > 0 ? new_count : 0xFFFFFFFF);
        data << uint32(count);
        GetSession()->SendPacket(&data);
        SendNewItem(it, pProto->BuyCount * count, true, false, false);

        if (!bStore)
            AutoUnequipOffhandIfNeed();

        if (pProto->HasFlag(ITEM_FLAG_ITEM_PURCHASE_RECORD) && crItem->ExtendedCost && pProto->GetMaxStackSize() == 1)
        {
            it->SetFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_REFUNDABLE);
            it->SetRefundRecipient(GetGUID().GetCounter());
            it->SetPaidMoney(price);
            it->SetPaidExtendedCost(crItem->ExtendedCost);
            it->SaveRefundDataToDB();
            AddRefundReference(it->GetGUID());
        }
    }

    sScriptMgr->OnAfterStoreOrEquipNewItem(this, vendorslot, it, count, bag, slot, pProto, pVendor, crItem, bStore);

    return true;
}

// Return true is the bought item has a max count to force refresh of window by caller
bool Player::BuyItemFromVendorSlot(ObjectGuid vendorguid, uint32 vendorslot, uint32 item, uint8 count, uint8 bag, uint8 slot)
{
    sScriptMgr->OnBeforeBuyItemFromVendor(this, vendorguid, vendorslot, item, count, bag, slot);

    // this check can be used from the hook to implement a custom vendor process
    if (item == 0)
        return true;

    // cheating attempt
    if (count < 1) count = 1;

    // cheating attempt
    if (slot > MAX_BAG_SIZE && slot != NULL_SLOT)
        return false;

    if (!IsAlive())
        return false;

    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item);
    if (!pProto)
    {
        SendBuyError(BUY_ERR_CANT_FIND_ITEM, nullptr, item, 0);
        return false;
    }

    if (!(pProto->AllowableClass & getClassMask()) && pProto->Bonding == BIND_WHEN_PICKED_UP && !IsGameMaster())
    {
        SendBuyError(BUY_ERR_CANT_FIND_ITEM, nullptr, item, 0);
        return false;
    }

    if (!IsGameMaster() && ((pProto->HasFlag2(ITEM_FLAG2_FACTION_HORDE) && GetTeamId(true) == TEAM_ALLIANCE) || (pProto->HasFlag2(ITEM_FLAG2_FACTION_ALLIANCE) && GetTeamId(true) == TEAM_HORDE)))
    {
        return false;
    }

    Creature* creature = GetNPCIfCanInteractWith(vendorguid, UNIT_NPC_FLAG_VENDOR);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: BuyItemFromVendor - Unit ({}) not found or you can't interact with him.", vendorguid.ToString());
        SendBuyError(BUY_ERR_DISTANCE_TOO_FAR, nullptr, item, 0);
        return false;
    }

    ConditionList conditions = sConditionMgr->GetConditionsForNpcVendorEvent(creature->GetEntry(), item);
    if (!sConditionMgr->IsObjectMeetToConditions(this, creature, conditions))
    {
        //LOG_DEBUG("condition", "BuyItemFromVendor: conditions not met for creature entry {} item {}", creature->GetEntry(), item);
        SendBuyError(BUY_ERR_CANT_FIND_ITEM, creature, item, 0);
        return false;
    }

    VendorItemData const* vItems = GetSession()->GetCurrentVendor() ? sObjectMgr->GetNpcVendorItemList(GetSession()->GetCurrentVendor()) : creature->GetVendorItems();
    if (!vItems || vItems->Empty())
    {
        SendBuyError(BUY_ERR_CANT_FIND_ITEM, creature, item, 0);
        return false;
    }

    if (vendorslot >= vItems->GetItemCount())
    {
        SendBuyError(BUY_ERR_CANT_FIND_ITEM, creature, item, 0);
        return false;
    }

    VendorItem const* crItem = vItems->GetItem(vendorslot);
    // store diff item (cheating)
    if (!crItem || crItem->item != item)
    {
        SendBuyError(BUY_ERR_CANT_FIND_ITEM, creature, item, 0);
        return false;
    }

    // check current item amount if it limited
    if (crItem->maxcount != 0)
    {
        if (creature->GetVendorItemCurrentCount(crItem) < pProto->BuyCount * count)
        {
            SendBuyError(BUY_ERR_ITEM_ALREADY_SOLD, creature, item, 0);
            return false;
        }
    }

    if (pProto->RequiredReputationFaction && (uint32(GetReputationRank(pProto->RequiredReputationFaction)) < pProto->RequiredReputationRank))
    {
        SendBuyError(BUY_ERR_REPUTATION_REQUIRE, creature, item, 0);
        return false;
    }

    if (crItem->ExtendedCost)
    {
        ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(crItem->ExtendedCost);
        if (!iece)
        {
            LOG_ERROR("entities.player", "Item {} have wrong ExtendedCost field value {}", pProto->ItemId, crItem->ExtendedCost);
            return false;
        }

        // honor points price
        if (GetHonorPoints() < (iece->reqhonorpoints * count))
        {
            SendEquipError(EQUIP_ERR_NOT_ENOUGH_HONOR_POINTS, nullptr, nullptr);
            return false;
        }

        // arena points price
        if (GetArenaPoints() < (iece->reqarenapoints * count))
        {
            SendEquipError(EQUIP_ERR_NOT_ENOUGH_ARENA_POINTS, nullptr, nullptr);
            return false;
        }

        // item base price
        for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i)
        {
            if (iece->reqitem[i] && !HasItemCount(iece->reqitem[i], (iece->reqitemcount[i] * count)))
            {
                SendEquipError(EQUIP_ERR_VENDOR_MISSING_TURNINS, nullptr, nullptr);
                return false;
            }
        }

        // check for personal arena rating requirement
        if (GetMaxPersonalArenaRatingRequirement(iece->reqarenaslot) < iece->reqpersonalarenarating)
        {
            // probably not the proper equip err
            SendEquipError(EQUIP_ERR_CANT_EQUIP_RANK, nullptr, nullptr);
            return false;
        }
    }

    uint32 price = 0;
    if (crItem->IsGoldRequired(pProto) && pProto->BuyPrice > 0) //Assume price cannot be negative (do not know why it is int32)
    {
        uint32 maxCount = MAX_MONEY_AMOUNT / pProto->BuyPrice;
        if ((uint32)count > maxCount)
        {
            LOG_ERROR("entities.player", "Player {} tried to buy {} item id {}, causing overflow", GetName(), (uint32)count, pProto->ItemId);
            count = (uint8)maxCount;
        }
        price = pProto->BuyPrice * count; //it should not exceed MAX_MONEY_AMOUNT

        // reputation discount
        price = uint32(std::floor(price * GetReputationPriceDiscount(creature)));

        if (!HasEnoughMoney(price))
        {
            SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, creature, item, 0);
            return false;
        }
    }

    if ((bag == NULL_BAG && slot == NULL_SLOT) || IsInventoryPos(bag, slot))
    {
        if (!_StoreOrEquipNewItem(vendorslot, item, count, bag, slot, price, pProto, creature, crItem, true))
            return false;
    }
    else if (IsEquipmentPos(bag, slot))
    {
        if (pProto->BuyCount * count != 1)
        {
            SendEquipError(EQUIP_ERR_ITEM_CANT_BE_EQUIPPED, nullptr, nullptr);
            return false;
        }
        if (!_StoreOrEquipNewItem(vendorslot, item, count, bag, slot, price, pProto, creature, crItem, false))
            return false;
    }
    else
    {
        SendEquipError(EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT, nullptr, nullptr);
        return false;
    }

    return crItem->maxcount != 0;
}

uint32 Player::GetMaxPersonalArenaRatingRequirement(uint32 minarenaslot) const
{
    // returns the maximal personal arena rating that can be used to purchase items requiring this condition
    // the personal rating of the arena team must match the required limit as well
    // so return max[in arenateams](min(personalrating[teamtype], teamrating[teamtype]))
    uint32 max_personal_rating = 0;
    for (uint8 i = minarenaslot; i < MAX_ARENA_SLOT; ++i)
    {
        if (ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(GetArenaTeamId(i)))
        {
            uint32 p_rating = GetArenaPersonalRating(i);
            uint32 t_rating = at->GetRating();
            p_rating = p_rating < t_rating ? p_rating : t_rating;
            if (max_personal_rating < p_rating)
                max_personal_rating = p_rating;
        }
    }

    sScriptMgr->OnGetMaxPersonalArenaRatingRequirement(this, minarenaslot, max_personal_rating);

    return max_personal_rating;
}

void Player::AddSpellAndCategoryCooldowns(SpellInfo const* spellInfo, uint32 itemId, Spell* spell, bool infinityCooldown)
{
    // init cooldown values
    uint32 cat   = 0;
    int32 rec    = -1;
    int32 catrec = -1;

    // some special item spells without correct cooldown in SpellInfo
    // cooldown information stored in item prototype
    // This used in same way in WorldSession::HandleItemQuerySingleOpcode data sending to client.

    if (itemId)
    {
        if (ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId))
        {
            for (uint8 idx = 0; idx < MAX_ITEM_SPELLS; ++idx)
            {
                if (uint32(proto->Spells[idx].SpellId) == spellInfo->Id)
                {
                    cat    = proto->Spells[idx].SpellCategory;
                    rec    = proto->Spells[idx].SpellCooldown;
                    catrec = proto->Spells[idx].SpellCategoryCooldown;
                    break;
                }
            }
        }
    }

    // if no cooldown found above then base at DBC data
    if (rec < 0 && catrec < 0)
    {
        cat = spellInfo->GetCategory();
        rec = spellInfo->RecoveryTime;
        catrec = spellInfo->CategoryRecoveryTime;
    }

    time_t catrecTime;
    time_t recTime;

    bool needsCooldownPacket = false;

    // overwrite time for selected category
    if (infinityCooldown)
    {
        // use +MONTH as infinity mark for spell cooldown (will checked as MONTH/2 at save ans skipped)
        // but not allow ignore until reset or re-login
        catrecTime = catrec > 0 ? infinityCooldownDelay : 0;
        recTime    = rec    > 0 ? infinityCooldownDelay : catrecTime;
    }
    else
    {
        // shoot spells used equipped item cooldown values already assigned in GetAttackTime(RANGED_ATTACK)
        // prevent 0 cooldowns set by another way
        if (rec <= 0 && catrec <= 0 && (cat == 76 || (spellInfo->IsAutoRepeatRangedSpell() && spellInfo->Id != 75)))
            rec = GetAttackTime(RANGED_ATTACK);

        // Now we have cooldown data (if found any), time to apply mods
        if (rec > 0)
            ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, rec, spell);

        if (catrec > 0 && !spellInfo->HasAttribute(SPELL_ATTR6_NO_CATEGORY_COOLDOWN_MODS))
        {
            ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, catrec, spell);
        }

        if (int32 cooldownMod = GetTotalAuraModifier(SPELL_AURA_MOD_COOLDOWN))
        {
            // Apply SPELL_AURA_MOD_COOLDOWN only to own spells
            if (HasSpell(spellInfo->Id))
            {
                needsCooldownPacket = true;
                rec += cooldownMod * IN_MILLISECONDS;   // SPELL_AURA_MOD_COOLDOWN does not affect category cooldows, verified with shaman shocks
            }
        }

        // replace negative cooldowns by 0
        if (rec < 0) rec = 0;
        if (catrec < 0) catrec = 0;

        // no cooldown after applying spell mods
        if (rec == 0 && catrec == 0)
            return;

        catrecTime = catrec ? catrec : 0;
        recTime    = rec ? rec : catrecTime;
    }

    // category spells
    if (cat && catrec > 0)
    {
        _AddSpellCooldown(spellInfo->Id, 0, itemId, recTime, true, true);
        if (needsCooldownPacket)
        {
            WorldPacket data;
            BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, spellInfo->Id, recTime);
            SendDirectMessage(&data);
        }

        PacketCooldowns forcedCategoryCooldowns;

        SpellCategoryStore::const_iterator i_scstore = sSpellsByCategoryStore.find(cat);
        if (i_scstore != sSpellsByCategoryStore.end())
        {
            for (SpellCategorySet::const_iterator i_scset = i_scstore->second.begin(); i_scset != i_scstore->second.end(); ++i_scset)
            {
                if (i_scset->second == spellInfo->Id) // skip main spell, already handled above
                {
                    continue;
                }

                // If spell category is applied by item, then other spells should be exists in item templates
                if ((itemId > 0) != i_scset->first)
                {
                    continue;
                }

                // Only within the same spellfamily
                SpellInfo const* categorySpellInfo = sSpellMgr->GetSpellInfo(i_scset->second);
                if (!categorySpellInfo || categorySpellInfo->SpellFamilyName != spellInfo->SpellFamilyName)
                {
                    continue;
                }

                _AddSpellCooldown(i_scset->second, cat, itemId, catrecTime, !spellInfo->IsCooldownStartedOnEvent() && catrec && rec && catrec != rec);

                if (spellInfo->HasAttribute(SPELL_ATTR0_CU_FORCE_SEND_CATEGORY_COOLDOWNS))
                {
                    forcedCategoryCooldowns[i_scset->second] = catrecTime;
                }
            }
        }

        if (!forcedCategoryCooldowns.empty())
        {
            WorldPacket data;
            BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, forcedCategoryCooldowns);
            SendDirectMessage(&data);
        }
    }
    else
    {
        // self spell cooldown
        if (recTime > 0)
        {
            _AddSpellCooldown(spellInfo->Id, 0, itemId, recTime, true, true);

            if (needsCooldownPacket)
            {
                WorldPacket data;
                BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, spellInfo->Id, rec);
                SendDirectMessage(&data);
            }
        }
    }
}

void Player::_AddSpellCooldown(uint32 spellid, uint16 categoryId, uint32 itemid, uint32 end_time, bool needSendToClient, bool forceSendToSpectator)
{
    SpellCooldown sc;
    sc.end = GameTime::GetGameTimeMS().count() + end_time;
    sc.category = categoryId;
    sc.itemid = itemid;
    sc.maxduration = end_time;
    sc.sendToSpectator = false;
    sc.needSendToClient = needSendToClient;

    if (end_time >= SPECTATOR_COOLDOWN_MIN * IN_MILLISECONDS && end_time <= SPECTATOR_COOLDOWN_MAX * IN_MILLISECONDS)
    {
        if (NeedSendSpectatorData() && forceSendToSpectator && (itemid || HasActiveSpell(spellid)))
        {
            sc.sendToSpectator = true;
            ArenaSpectator::SendCommand_Cooldown(FindMap(), GetGUID(), "ACD", spellid, end_time / IN_MILLISECONDS, end_time / IN_MILLISECONDS);
        }
    }

    m_spellCooldowns[spellid] = std::move(sc);
}

void Player::AddSpellCooldown(uint32 spellid, uint32 itemid, uint32 end_time, bool needSendToClient, bool forceSendToSpectator)
{
    _AddSpellCooldown(spellid, 0, itemid, end_time, needSendToClient, forceSendToSpectator);
}

void Player::ModifySpellCooldown(uint32 spellId, int32 cooldown)
{
    SpellCooldowns::iterator itr = m_spellCooldowns.find(spellId);
    if (itr == m_spellCooldowns.end())
        return;

    itr->second.end += cooldown;

    WorldPacket data(SMSG_MODIFY_COOLDOWN, 4 + 8 + 4);
    data << uint32(spellId);            // Spell ID
    data << GetGUID();                  // Player GUID
    data << int32(cooldown);            // Cooldown mod in milliseconds
    GetSession()->SendPacket(&data);
}

void Player::SendCooldownEvent(SpellInfo const* spellInfo, uint32 itemId /*= 0*/, Spell* spell /*= nullptr*/, bool setCooldown /*= true*/)
{
    // start cooldowns at server side, if any
    if (setCooldown)
        AddSpellAndCategoryCooldowns(spellInfo, itemId, spell);

    // Send activate cooldown timer (possible 0) at client side
    WorldPacket data(SMSG_COOLDOWN_EVENT, 4 + 8);
    data << uint32(spellInfo->Id);
    data << GetGUID();
    SendDirectMessage(&data);
}

//slot to be excluded while counting
bool Player::EnchantmentFitsRequirements(uint32 enchantmentcondition, int8 slot)
{
    if (!enchantmentcondition)
        return true;

    SpellItemEnchantmentConditionEntry const* Condition = sSpellItemEnchantmentConditionStore.LookupEntry(enchantmentcondition);

    if (!Condition)
        return true;

    uint8 curcount[4] = {0, 0, 0, 0};

    //counting current equipped gem colors
    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        if (i == slot)
            continue;
        Item* pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem2 && !pItem2->IsBroken() && pItem2->HasSocket())
        {
            for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot <= PRISMATIC_ENCHANTMENT_SLOT; ++enchant_slot)
            {
                if (enchant_slot == BONUS_ENCHANTMENT_SLOT)
                    continue;

                uint32 enchant_id = pItem2->GetEnchantmentId(EnchantmentSlot(enchant_slot));
                if (!enchant_id)
                    continue;

                SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
                if (!enchantEntry)
                    continue;

                uint32 gemid = enchantEntry->GemID;
                if (!gemid)
                    continue;

                ItemTemplate const* gemProto = sObjectMgr->GetItemTemplate(gemid);
                if (!gemProto)
                    continue;

                GemPropertiesEntry const* gemProperty = sGemPropertiesStore.LookupEntry(gemProto->GemProperties);
                if (!gemProperty)
                    continue;

                uint8 GemColor = gemProperty->color;

                for (uint8 b = 0, tmpcolormask = 1; b < 4; b++, tmpcolormask <<= 1)
                {
                    if (tmpcolormask & GemColor)
                        ++curcount[b];
                }
            }
        }
    }

    bool activate = true;

    for (uint8 i = 0; i < 5; i++)
    {
        if (!Condition->Color[i])
            continue;

        uint32 _cur_gem = curcount[Condition->Color[i] - 1];

        // if have <CompareColor> use them as count, else use <value> from Condition
        uint32 _cmp_gem = Condition->CompareColor[i] ? curcount[Condition->CompareColor[i] - 1] : Condition->Value[i];

        switch (Condition->Comparator[i])
        {
            case 2:                                         // requires less <color> than (<value> || <comparecolor>) gems
                activate &= (_cur_gem < _cmp_gem);
                break;
            case 3:                                         // requires more <color> than (<value> || <comparecolor>) gems
                activate &= (_cur_gem > _cmp_gem);
                break;
            case 5:                                         // requires at least <color> than (<value> || <comparecolor>) gems
                activate &= (_cur_gem >= _cmp_gem);
                break;
        }
    }

    LOG_DEBUG("entities.player.items", "Checking Condition {}, there are {} Meta Gems, {} Red Gems, {} Yellow Gems and {} Blue Gems, Activate:{}", enchantmentcondition, curcount[0], curcount[1], curcount[2], curcount[3], activate ? "yes" : "no");

    return activate;
}

void Player::CorrectMetaGemEnchants(uint8 exceptslot, bool apply)
{
    //cycle all equipped items
    for (uint32 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        //enchants for the slot being socketed are handled by Player::ApplyItemMods
        if (slot == exceptslot)
            continue;

        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);

        if (!pItem || !pItem->HasSocket())
            continue;

        for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT + 3; ++enchant_slot)
        {
            uint32 enchant_id = pItem->GetEnchantmentId(EnchantmentSlot(enchant_slot));
            if (!enchant_id)
                continue;

            SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
            if (!enchantEntry)
                continue;

            uint32 condition = enchantEntry->EnchantmentCondition;
            if (condition)
            {
                //was enchant active with/without item?
                bool wasactive = EnchantmentFitsRequirements(condition, apply ? exceptslot : -1);
                //should it now be?
                if (wasactive ^ EnchantmentFitsRequirements(condition, apply ? -1 : exceptslot))
                {
                    // ignore item gem conditions
                    //if state changed, (dis)apply enchant
                    ApplyEnchantment(pItem, EnchantmentSlot(enchant_slot), !wasactive, true, true);
                }
            }
        }
    }
}

//if false -> then toggled off if was on| if true -> toggled on if was off AND meets requirements
void Player::ToggleMetaGemsActive(uint8 exceptslot, bool apply)
{
    //cycle all equipped items
    for (int slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        //enchants for the slot being socketed are handled by WorldSession::HandleSocketOpcode(WorldPacket& recvData)
        if (slot == exceptslot)
            continue;

        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);

        if (!pItem || !pItem->GetTemplate()->Socket[0].Color)   //if item has no sockets or no item is equipped go to next item
            continue;

        //cycle all (gem)enchants
        for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT + 3; ++enchant_slot)
        {
            uint32 enchant_id = pItem->GetEnchantmentId(EnchantmentSlot(enchant_slot));
            if (!enchant_id)                                 //if no enchant go to next enchant(slot)
                continue;

            SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
            if (!enchantEntry)
                continue;

            //only metagems to be (de)activated, so only enchants with condition
            uint32 condition = enchantEntry->EnchantmentCondition;
            if (condition)
                ApplyEnchantment(pItem, EnchantmentSlot(enchant_slot), apply);
        }
    }
}

void Player::SetEntryPoint()
{
    m_entryPointData.joinPos.m_mapId = MAPID_INVALID;
    m_entryPointData.ClearTaxiPath();

    if (!m_taxi.empty())
    {
        m_entryPointData.mountSpell  = 0;
        m_entryPointData.joinPos = WorldLocation(GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());

        m_entryPointData.taxiPath[0] = m_taxi.GetTaxiSource();
        m_entryPointData.taxiPath[1] = m_taxi.GetTaxiDestination();
    }
    else
    {
        if (IsMounted())
        {
            AuraEffectList const& auras = GetAuraEffectsByType(SPELL_AURA_MOUNTED);
            if (!auras.empty())
                m_entryPointData.mountSpell = (*auras.begin())->GetId();
        }
        else
            m_entryPointData.mountSpell = 0;

        if (GetMap()->IsDungeon())
        {
            if (const GraveyardStruct* entry = sGraveyard->GetClosestGraveyard(this, GetTeamId()))
                m_entryPointData.joinPos = WorldLocation(entry->Map, entry->x, entry->y, entry->z, 0.0f);
        }
        else if (!GetMap()->IsBattlegroundOrArena())
            m_entryPointData.joinPos = WorldLocation(GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
    }

    if (m_entryPointData.joinPos.m_mapId == MAPID_INVALID)
        m_entryPointData.joinPos = WorldLocation(m_homebindMapId, m_homebindX, m_homebindY, m_homebindZ, 0.0f);
}

void Player::LeaveBattleground(Battleground* bg)
{
    if (!bg)
        bg = GetBattleground();

    if (!bg)
        return;

    // Deserter tracker - leave BG
    if (bg->isBattleground() && (bg->GetStatus() == STATUS_IN_PROGRESS || bg->GetStatus() == STATUS_WAIT_JOIN))
    {
        if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_TRACK_DESERTERS))
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_DESERTER_TRACK);
            stmt->SetData(0, GetGUID().GetCounter());
            stmt->SetData(1, BG_DESERTION_TYPE_LEAVE_BG);
            CharacterDatabase.Execute(stmt);
        }
        sScriptMgr->OnBattlegroundDesertion(this, BG_DESERTION_TYPE_LEAVE_BG);
    }

    if (bg->isArena() && (bg->GetStatus() == STATUS_IN_PROGRESS || bg->GetStatus() == STATUS_WAIT_JOIN))
        sScriptMgr->OnBattlegroundDesertion(this, ARENA_DESERTION_TYPE_LEAVE_BG);

    bg->RemovePlayerAtLeave(this);

    // xinef: reset corpse reclaim time
    m_deathExpireTime = GameTime::GetGameTime().count();

    // Remove all dots
    RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
    RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE_PERCENT);
    RemoveAurasByType(SPELL_AURA_PERIODIC_LEECH);

    // pussywizard: clear movement, because after porting player will move to arena cords
    GetMotionMaster()->MovementExpired();
    StopMoving();
    TeleportToEntryPoint();
}

bool Player::CanJoinToBattleground() const
{
    // check Deserter debuff
    if (HasAura(26013))
        return false;

    return true;
}

bool Player::CanReportAfkDueToLimit()
{
    // a player can complain about 15 people per 5 minutes
    if (m_bgData.bgAfkReportedCount++ >= 15)
        return false;

    return true;
}

///This player has been blamed to be inactive in a battleground
void Player::ReportedAfkBy(Player* reporter)
{
    Battleground* bg = GetBattleground();
    // Battleground also must be in progress!
    if (!bg || bg != reporter->GetBattleground() || GetTeamId() != reporter->GetTeamId() || bg->GetStatus() != STATUS_IN_PROGRESS)
        return;

    // Xinef: 2 minutes startup + 2 minute of match
    if (bg->GetStartTime() < sWorld->getIntConfig(CONFIG_BATTLEGROUND_REPORT_AFK_TIMER) * MINUTE * IN_MILLISECONDS)
        return;

    // check if player has 'Idle' or 'Inactive' debuff
    if (m_bgData.bgAfkReporter.find(reporter->GetGUID()) == m_bgData.bgAfkReporter.end() && !HasAura(43680) && !HasAura(43681) && reporter->CanReportAfkDueToLimit())
    {
        m_bgData.bgAfkReporter.insert(reporter->GetGUID());
        // by default 3 players have to complain to apply debuff
        if (m_bgData.bgAfkReporter.size() >= sWorld->getIntConfig(CONFIG_BATTLEGROUND_REPORT_AFK))
        {
            // cast 'Idle' spell
            CastSpell(this, 43680, true);
            m_bgData.bgAfkReporter.clear();
        }
    }
}

WorldLocation Player::GetStartPosition() const
{
    PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(true), getClass());
    uint32 mapId = info->mapId;
    if (IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT) && HasSpell(50977))
        return WorldLocation(0, 2352.0f, -5709.0f, 154.5f, 0.0f);
    return WorldLocation(mapId, info->positionX, info->positionY, info->positionZ, 0);
}

bool Player::HaveAtClient(WorldObject const* u) const
{
    if (u == this)
    {
        return true;
    }

    // Motion Transports are always present in player's client
    if (GameObject const* gameobject = u->ToGameObject())
    {
        if (gameobject->IsMotionTransport())
        {
            return true;
        }
    }

    return m_clientGUIDs.find(u->GetGUID()) != m_clientGUIDs.end();
}

bool Player::HaveAtClient(ObjectGuid guid) const
{
    if (guid == GetGUID())
    {
        return true;
    }

    return m_clientGUIDs.find(guid) != m_clientGUIDs.end();
}

bool Player::IsNeverVisible() const
{
    if (Unit::IsNeverVisible())
        return true;

    if (GetSession()->PlayerLogout() || GetSession()->PlayerLoading())
        return true;

    return false;
}

bool Player::CanAlwaysSee(WorldObject const* obj) const
{
    // Always can see self
    if (m_mover == obj)
        return true;

    if (ObjectGuid guid = GetGuidValue(PLAYER_FARSIGHT))
        if (obj->GetGUID() == guid)
            return true;

    return false;
}

bool Player::IsAlwaysDetectableFor(WorldObject const* seer) const
{
    if (Unit::IsAlwaysDetectableFor(seer))
        return true;

    if (duel && duel->State != DUEL_STATE_CHALLENGED && duel->Opponent == seer)
    {
        return false;
    }

    if (Player const* seerPlayer = seer->ToPlayer())
    {
        if (IsGroupVisibleFor(seerPlayer))
        {
            return true;
        }
    }

    return false;
}

bool Player::IsVisibleGloballyFor(Player const* u) const
{
    if (!u)
        return false;

    // Always can see self
    if (u == this)
        return true;

    // Visible units, always are visible for all players
    if (IsVisible())
        return true;

    // GMs are visible for higher gms (or players are visible for gms)
    if (!AccountMgr::IsPlayerAccount(u->GetSession()->GetSecurity()))
        return GetSession()->GetSecurity() <= u->GetSession()->GetSecurity();

    if (!sScriptMgr->NotVisibleGloballyFor(const_cast<Player*>(this), u))
        return true;

    // non faction visibility non-breakable for non-GMs
    return false;
}

void Player::InitPrimaryProfessions()
{
    SetFreePrimaryProfessions(sWorld->getIntConfig(CONFIG_MAX_PRIMARY_TRADE_SKILL));
}

bool Player::ModifyMoney(int32 amount, bool sendError /*= true*/)
{
    if (!amount)
        return true;

    sScriptMgr->OnPlayerMoneyChanged(this, amount);

    if (amount < 0)
        SetMoney (GetMoney() > uint32(-amount) ? GetMoney() + amount : 0);
    else
    {
        if (GetMoney() < uint32(MAX_MONEY_AMOUNT - amount))
            SetMoney(GetMoney() + amount);
        else
        {
            if (sendError)
                SendEquipError(EQUIP_ERR_TOO_MUCH_GOLD, nullptr, nullptr);
            return false;
        }
    }

    return true;
}

Unit* Player::GetSelectedUnit() const
{
    if (ObjectGuid selectionGUID = GetGuidValue(UNIT_FIELD_TARGET))
        return ObjectAccessor::GetUnit(*this, selectionGUID);

    return nullptr;
}

Player* Player::GetSelectedPlayer() const
{
    if (ObjectGuid selectionGUID = GetGuidValue(UNIT_FIELD_TARGET))
        return ObjectAccessor::GetPlayer(*this, selectionGUID);

    return nullptr;
}

void Player::SetSelection(ObjectGuid guid)
{
    SetGuidValue(UNIT_FIELD_TARGET, guid);

    if (NeedSendSpectatorData())
        ArenaSpectator::SendCommand_GUID(FindMap(), GetGUID(), "TRG", guid);
}

void Player::SetGroup(Group* group, int8 subgroup)
{
    if (!group)
        m_group.unlink();
    else
    {
        // never use SetGroup without a subgroup unless you specify nullptr for group
        ASSERT(subgroup >= 0);
        m_group.link(group, this);
        m_group.setSubGroup((uint8)subgroup);
    }

    UpdateObjectVisibility(false);
}

void Player::SendInitialPacketsBeforeAddToMap()
{
    /// Pass 'this' as argument because we're not stored in ObjectAccessor yet
    GetSocial()->SendSocialList(this, SOCIAL_FLAG_ALL);

    // guild bank list?

    // Homebind
    WorldPacket data(SMSG_BINDPOINTUPDATE, 5 * 4);
    data << m_homebindX << m_homebindY << m_homebindZ;
    data << (uint32) m_homebindMapId;
    data << (uint32) m_homebindAreaId;
    GetSession()->SendPacket(&data);

    // SMSG_SET_PROFICIENCY
    // SMSG_SET_PCT_SPELL_MODIFIER
    // SMSG_SET_FLAT_SPELL_MODIFIER
    // SMSG_UPDATE_AURA_DURATION

    SendTalentsInfoData(false);

    // SMSG_INSTANCE_DIFFICULTY
    data.Initialize(SMSG_INSTANCE_DIFFICULTY, 4 + 4);
    data << uint32(GetMap()->GetDifficulty());
    data << uint32(GetMap()->GetEntry()->IsDynamicDifficultyMap() && GetMap()->IsHeroic()); // Raid dynamic difficulty
    GetSession()->SendPacket(&data);

    SendInitialSpells();

    data.Initialize(SMSG_SEND_UNLEARN_SPELLS, 4);
    data << uint32(0);                                      // count, for (count) uint32;
    GetSession()->SendPacket(&data);

    SendInitialActionButtons();
    m_reputationMgr->SendInitialReputations();
    m_achievementMgr->SendAllAchievementData();

    SendEquipmentSetList();

    data.Initialize(SMSG_LOGIN_SETTIMESPEED, 4 + 4 + 4);
    data.AppendPackedTime(GameTime::GetGameTime().count());
    data << float(0.01666667f);                             // game speed
    data << uint32(0);                                      // added in 3.1.2
    GetSession()->SendPacket(&data);

    GetReputationMgr().SendForceReactions();                // SMSG_SET_FORCED_REACTIONS

    // SMSG_TALENTS_INFO x 2 for pet (unspent points and talents in separate packets...)
    // SMSG_PET_GUIDS
    // SMSG_UPDATE_WORLD_STATE
    // SMSG_POWER_UPDATE

    SetMover(this);

    sScriptMgr->OnSendInitialPacketsBeforeAddToMap(this, data);
}

void Player::SendInitialPacketsAfterAddToMap()
{
    UpdateVisibilityForPlayer(true);

    GetSession()->ResetTimeSync();
    GetSession()->SendTimeSync();

    CastSpell(this, 836, true);                             // LOGINEFFECT

    // set some aura effects that send packet to player client after add player to map
    // SendMessageToSet not send it to player not it map, only for aura that not changed anything at re-apply
    // same auras state lost at far teleport, send it one more time in this case also
    static const AuraType auratypes[] =
    {
        SPELL_AURA_MOD_FEAR,     SPELL_AURA_TRANSFORM,                 SPELL_AURA_WATER_WALK,
        SPELL_AURA_FEATHER_FALL, SPELL_AURA_HOVER,                     SPELL_AURA_SAFE_FALL,
        SPELL_AURA_FLY,          SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED, SPELL_AURA_NONE
    };
    for (AuraType const* itr = &auratypes[0]; itr && itr[0] != SPELL_AURA_NONE; ++itr)
    {
        Unit::AuraEffectList const& auraList = GetAuraEffectsByType(*itr);
        if (!auraList.empty())
            auraList.front()->HandleEffect(this, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT, true);
    }

    // Fix mount, update block gets messed somewhere
    {
        if (!isBeingLoaded() && GetMountBlockId() && !HasAuraType(SPELL_AURA_MOUNTED))
        {
            AddAura(GetMountBlockId(), this);
            SetMountBlockId(0);
        }
    }

    // update zone
    uint32 newzone, newarea;
    GetZoneAndAreaId(newzone, newarea);
    UpdateZone(newzone, newarea);                            // also call SendInitWorldStates();

    if (HasAuraType(SPELL_AURA_MOD_STUN))
        SetMovement(MOVE_ROOT);

    // manual send package (have code in HandleEffect(this, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT, true); that must not be re-applied.
    if (HasAuraType(SPELL_AURA_MOD_ROOT))
    {
        WorldPacket data2(SMSG_FORCE_MOVE_ROOT, 10);
        data2 << GetPackGUID();
        data2 << (uint32)2;
        SendMessageToSet(&data2, true);
    }

    SendEnchantmentDurations();                             // must be after add to map
    SendItemDurations();                                    // must be after add to map
    SendQuestGiverStatusMultiple();
    SendTaxiNodeStatusMultiple();

    // raid downscaling - send difficulty to player
    if (GetMap()->IsRaid())
    {
        if (GetMap()->GetDifficulty() != GetRaidDifficulty())
        {
            StoreRaidMapDifficulty();
            SendRaidDifficulty(GetGroup() != nullptr, GetStoredRaidDifficulty());
        }
    }
    else if (GetRaidDifficulty() != GetStoredRaidDifficulty())
        SendRaidDifficulty(GetGroup() != nullptr);
}

void Player::SendUpdateToOutOfRangeGroupMembers()
{
    if (m_groupUpdateMask == GROUP_UPDATE_FLAG_NONE)
        return;
    if (Group* group = GetGroup())
        group->UpdatePlayerOutOfRange(this);

    m_groupUpdateMask = GROUP_UPDATE_FLAG_NONE;
    m_auraRaidUpdateMask = 0;
    if (Pet* pet = GetPet())
        pet->ResetAuraUpdateMaskForRaid();
}

void Player::SendTransferAborted(uint32 mapid, TransferAbortReason reason, uint8 arg)
{
    WorldPacket data(SMSG_TRANSFER_ABORTED, 4 + 2);
    data << uint32(mapid);
    data << uint8(reason);                                 // transfer abort reason
    switch (reason)
    {
        case TRANSFER_ABORT_INSUF_EXPAN_LVL:
        case TRANSFER_ABORT_DIFFICULTY:
        case TRANSFER_ABORT_UNIQUE_MESSAGE:
            // these are the ONLY cases that have an extra argument in the packet!!!
            data << uint8(arg);
            break;
        default:
            break;
    }
    GetSession()->SendPacket(&data);
}

void Player::SendInstanceResetWarning(uint32 mapid, Difficulty difficulty, uint32 time, bool onEnterMap)
{
    // pussywizard:
    InstancePlayerBind* bind = sInstanceSaveMgr->PlayerGetBoundInstance(GetGUID(), mapid, difficulty);
    if (bind && bind->extended)
    {
        if (!onEnterMap) // extended id player shouldn't be warned about lock expiration
            return;
        time += (bind->save->GetExtendedResetTime() - bind->save->GetResetTime()); // add lockout period to the time left
    }

    // type of warning, based on the time remaining until reset
    uint32 type;
    if (time > 3600)
        type = RAID_INSTANCE_WELCOME;
    else if (time > 900)
        type = RAID_INSTANCE_WARNING_HOURS;
    else if (time > 300)
        type = RAID_INSTANCE_WARNING_MIN;
    else
        type = RAID_INSTANCE_WARNING_MIN_SOON;

    WorldPacket data(SMSG_RAID_INSTANCE_MESSAGE, 4 + 4 + 4 + 4);
    data << uint32(type);
    data << uint32(mapid);
    data << uint32(difficulty);                             // difficulty
    data << uint32(time);
    if (type == RAID_INSTANCE_WELCOME)
    {
        data << uint8(bind && bind->perm);                  // is locked
        data << uint8(bind && bind->extended);              // is extended, ignored if prev field is 0
    }
    GetSession()->SendPacket(&data);
}

void Player::ApplyEquipCooldown(Item* pItem)
{
    if (pItem->GetTemplate()->HasFlag(ITEM_FLAG_NO_EQUIP_COOLDOWN))
        return;

    for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
    {
        _Spell const& spellData = pItem->GetTemplate()->Spells[i];

        // no spell
        if (!spellData.SpellId)
            continue;

        // xinef: apply hidden cooldown for procs
        if (spellData.SpellTrigger == ITEM_SPELLTRIGGER_ON_EQUIP)
        {
            // xinef: uint32(-1) special marker for proc cooldowns
            AddSpellCooldown(spellData.SpellId, uint32(-1), 30 * IN_MILLISECONDS);
            continue;
        }

        // wrong triggering type (note: ITEM_SPELLTRIGGER_ON_NO_DELAY_USE not have cooldown)
        if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
            continue;

        // xinef: dont apply equip cooldown if spell on item has insignificant cooldown
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellData.SpellId);
        if (spellData.SpellCooldown <= 3000 && spellData.SpellCategoryCooldown <= 3000 && (!spellInfo || (spellInfo->RecoveryTime <= 3000 && spellInfo->CategoryRecoveryTime <= 3000)))
            continue;

        // Don't replace longer cooldowns by equip cooldown if we have any.
        SpellCooldowns::iterator itr = m_spellCooldowns.find(spellData.SpellId);
        if (itr != m_spellCooldowns.end() && itr->second.itemid == pItem->GetEntry() && itr->second.end > GameTime::GetGameTimeMS().count() + 30 * IN_MILLISECONDS)
            continue;

        // xinef: dont apply eqiup cooldown for spells with this attribute
        if (spellInfo && spellInfo->HasAttribute(SPELL_ATTR0_NOT_IN_COMBAT_ONLY_PEACEFUL))
            continue;

        AddSpellCooldown(spellData.SpellId, pItem->GetEntry(), 30 * IN_MILLISECONDS, true, true);

        WorldPacket data(SMSG_ITEM_COOLDOWN, 12);
        data << pItem->GetGUID();
        data << uint32(spellData.SpellId);
        GetSession()->SendPacket(&data);
    }
}

void Player::resetSpells()
{
    // not need after this call
    if (HasAtLoginFlag(AT_LOGIN_RESET_SPELLS))
        RemoveAtLoginFlag(AT_LOGIN_RESET_SPELLS, true);

    // make full copy of map (spells removed and marked as deleted at another spell remove
    // and we can't use original map for safe iterative with visit each spell at loop end
    PlayerSpellMap spellMap = GetSpellMap();

    for (PlayerSpellMap::const_iterator iter = spellMap.begin(); iter != spellMap.end(); ++iter)
        removeSpell(iter->first, SPEC_MASK_ALL, false);

    LearnDefaultSkills();
    LearnCustomSpells();
    learnQuestRewardedSpells();
}

void Player::LearnCustomSpells()
{
    if (!sWorld->getBoolConfig(CONFIG_START_CUSTOM_SPELLS))
    {
        return;
    }

    // learn default race/class spells
    PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(), getClass());
    ASSERT(info);
    for (PlayerCreateInfoSpells::const_iterator itr = info->customSpells.begin(); itr != info->customSpells.end(); ++itr)
    {
        uint32 tspell = *itr;
        LOG_DEBUG("entities.player.loading", "Player::LearnCustomSpells: Player '{}' ({}, Class: {} Race: {}): Adding initial spell (SpellID: {})",
            GetName(), GetGUID().ToString(), uint32(getClass()), uint32(getRace()), tspell);
        if (!IsInWorld())                                   // will send in INITIAL_SPELLS in list anyway at map add
        {
            addSpell(tspell, SPEC_MASK_ALL, true);
        }
        else                                               // but send in normal spell in game learn case
        {
            learnSpell(tspell);
        }
    }
}

void Player::LearnDefaultSkills()
{
    // learn default race/class skills
    PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(), getClass());
    for (PlayerCreateInfoSkills::const_iterator itr = info->skills.begin(); itr != info->skills.end(); ++itr)
    {
        uint32 skillId = itr->SkillId;
        if (HasSkill(skillId))
            continue;

        LearnDefaultSkill(skillId, itr->Rank);
    }
}

void Player::LearnDefaultSkill(uint32 skillId, uint16 rank)
{
    SkillRaceClassInfoEntry const* rcInfo = GetSkillRaceClassInfo(skillId, getRace(), getClass());
    if (!rcInfo)
        return;

    LOG_DEBUG("entities.player.loading", "PLAYER (Class: {} Race: {}): Adding initial skill, id = {}", uint32(getClass()), uint32(getRace()), skillId);
    switch (GetSkillRangeType(rcInfo))
    {
        case SKILL_RANGE_LANGUAGE:
            SetSkill(skillId, 0, 300, 300);
            break;
        case SKILL_RANGE_LEVEL:
        {
            uint16 skillValue = 1;
            uint16 maxValue = GetMaxSkillValueForLevel();
            if (sWorld->getBoolConfig(CONFIG_ALWAYS_MAXSKILL) && !IsProfessionOrRidingSkill(skillId))
            {
                skillValue = maxValue;
            }
            else if (rcInfo->Flags & SKILL_FLAG_ALWAYS_MAX_VALUE)
            {
                skillValue = maxValue;
            }
            else if (IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_SKILL))
            {
                skillValue = std::min(std::max<uint16>({ 1, uint16((GetLevel() - 1) * 5) }), maxValue);
            }
            else if (skillId == SKILL_FIST_WEAPONS)
            {
                skillValue = std::max<uint16>(1, GetSkillValue(SKILL_UNARMED));
            }
            else if (skillId == SKILL_LOCKPICKING)
            {
                skillValue = std::max<uint16>(1, GetSkillValue(SKILL_LOCKPICKING));
            }

            SetSkill(skillId, 0, skillValue, maxValue);
            break;
        }
        case SKILL_RANGE_MONO:
            SetSkill(skillId, 0, 1, 1);
            break;
        case SKILL_RANGE_RANK:
        {
            if (!rank)
            {
                break;
            }

            SkillTiersEntry const* tier = sSkillTiersStore.LookupEntry(rcInfo->SkillTierID);
            uint16 maxValue = tier->Value[std::max<int32>(rank - 1, 0)];
            uint16 skillValue = 1;
            if (rcInfo->Flags & SKILL_FLAG_ALWAYS_MAX_VALUE)
            {
                skillValue = maxValue;
            }
            else if (IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_SKILL))
            {
                skillValue = std::min(std::max<uint16>({ uint16(1), uint16((GetLevel() - 1) * 5) }), maxValue);
            }

            SetSkill(skillId, rank, skillValue, maxValue);
            break;
        }
        default:
            break;
    }
}

void Player::learnQuestRewardedSpells(Quest const* quest)
{
    // xinef: quest does not learn anything
    int32 spellId = quest->GetRewSpellCast();
    if (!spellId)
        return;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
        return;

    // xinef: find effect with learn spell and check if we have this spell
    bool found = false;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL && spellInfo->Effects[i].TriggerSpell && !HasSpell(spellInfo->Effects[i].TriggerSpell))
        {
            // pusywizard: don't re-add profession specialties!
            if (SpellInfo const* triggeredInfo = sSpellMgr->GetSpellInfo(spellInfo->Effects[i].TriggerSpell))
                if (triggeredInfo->Effects[0].Effect == SPELL_EFFECT_TRADE_SKILL)
                    break; // pussywizard: break and not cast the spell (found is false)

            found = true;
            break;
        }

    // xinef: we know the spell, return
    if (!found)
        return;

    CastSpell(this, spellId, true);
}

void Player::learnQuestRewardedSpells()
{
    // learn spells received from quest completing
    for (RewardedQuestSet::const_iterator itr = m_RewardedQuests.begin(); itr != m_RewardedQuests.end(); ++itr)
    {
        Quest const* quest = sObjectMgr->GetQuestTemplate(*itr);
        if (!quest)
            continue;

        learnQuestRewardedSpells(quest);
    }
}

void Player::learnSkillRewardedSpells(uint32 skill_id, uint32 skill_value)
{
    uint32 raceMask  = getRaceMask();
    uint32 classMask = getClassMask();
    for (SkillLineAbilityEntry const* pAbility : GetSkillLineAbilitiesBySkillLine(skill_id))
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(pAbility->Spell);
        if (!spellInfo)
        {
            continue;
        }

        if (pAbility->AcquireMethod != SKILL_LINE_ABILITY_LEARNED_ON_SKILL_VALUE && pAbility->AcquireMethod != SKILL_LINE_ABILITY_LEARNED_ON_SKILL_LEARN)
        {
            continue;
        }

        // Check race if set
        if (pAbility->RaceMask && !(pAbility->RaceMask & raceMask))
        {
            continue;
        }

        // Check class if set
        if (pAbility->ClassMask && !(pAbility->ClassMask & classMask))
        {
            continue;
        }

        // need unlearn spell
        if (skill_value < pAbility->MinSkillLineRank && pAbility->AcquireMethod == SKILL_LINE_ABILITY_LEARNED_ON_SKILL_VALUE)
        {
            removeSpell(pAbility->Spell, GetActiveSpec(), true);
        }
        // need learn
        else
        {
            //used to avoid double Seal of Righteousness on paladins, it's the only player spell which has both spell and forward spell in auto learn
            if (pAbility->AcquireMethod == SKILL_LINE_ABILITY_LEARNED_ON_SKILL_LEARN && pAbility->SupercededBySpell)
            {
                bool skipCurrent = false;
                auto bounds = sSpellMgr->GetSkillLineAbilityMapBounds(pAbility->SupercededBySpell);
                for (auto itr = bounds.first; itr != bounds.second; ++itr)
                {
                    if (itr->second->AcquireMethod == SKILL_LINE_ABILITY_LEARNED_ON_SKILL_LEARN && skill_value >= itr->second->MinSkillLineRank)
                    {
                        skipCurrent = true;
                        break;
                    }
                }
                if (skipCurrent)
                {
                    continue;
                }
            }

            if (!IsInWorld())
            {
                addSpell(pAbility->Spell, SPEC_MASK_ALL, true, true);
            }
            else
            {
                learnSpell(pAbility->Spell, true, true);
            }
        }
    }
}

void Player::GetAurasForTarget(Unit* target, bool force /*= false*/)
{
    if (!target || (!force && target->GetVisibleAuras()->empty()))    // speedup things
        return;

    /*! Blizz sends certain movement packets sometimes even before CreateObject
        These movement packets are usually found in SMSG_COMPRESSED_MOVES
    */
    if (target->HasAuraType(SPELL_AURA_FEATHER_FALL))
        target->SendMovementFeatherFall(this);

    if (target->HasAuraType(SPELL_AURA_WATER_WALK))
        target->SendMovementWaterWalking(this);

    if (target->HasAuraType(SPELL_AURA_HOVER))
        target->SendMovementHover(this);

    WorldPacket data(SMSG_AURA_UPDATE_ALL);
    data<< target->GetPackGUID();

    Unit::VisibleAuraMap const* visibleAuras = target->GetVisibleAuras();
    for (Unit::VisibleAuraMap::const_iterator itr = visibleAuras->begin(); itr != visibleAuras->end(); ++itr)
    {
        AuraApplication* auraApp = itr->second;
        auraApp->BuildUpdatePacket(data, false);
    }

    GetSession()->SendPacket(&data);
}

void Player::SetDailyQuestStatus(uint32 quest_id)
{
    if (Quest const* qQuest = sObjectMgr->GetQuestTemplate(quest_id))
    {
        if (!qQuest->IsDFQuest())
        {
            for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
            {
                if (!GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx))
                {
                    SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx, quest_id);
                    m_lastDailyQuestTime = GameTime::GetGameTime().count();              // last daily quest time
                    m_DailyQuestChanged = true;
                    break;
                }
            }
        }
        else
        {
            m_DFQuests.insert(quest_id);
            m_lastDailyQuestTime = GameTime::GetGameTime().count();
            m_DailyQuestChanged = true;
        }
    }
}

bool Player::IsDailyQuestDone(uint32 quest_id)
{
    if (sObjectMgr->GetQuestTemplate(quest_id))
    {
        for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
        {
            if (GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx) == quest_id)
            {
                return true;
            }
        }
    }

    return false;
}

void Player::SetWeeklyQuestStatus(uint32 quest_id)
{
    m_weeklyquests.insert(quest_id);
    m_WeeklyQuestChanged = true;
}

void Player::SetSeasonalQuestStatus(uint32 quest_id)
{
    Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
    if (!quest)
        return;

    m_seasonalquests[quest->GetEventIdForQuest()].insert(quest_id);
    m_SeasonalQuestChanged = true;
}

void Player::SetMonthlyQuestStatus(uint32 quest_id)
{
    m_monthlyquests.insert(quest_id);
    m_MonthlyQuestChanged = true;
}

void Player::ResetDailyQuestStatus()
{
    for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
        SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx, 0);

    m_DFQuests.clear(); // Dungeon Finder Quests.

    // DB data deleted in caller
    m_DailyQuestChanged = false;
    m_lastDailyQuestTime = 0;
}

void Player::ResetWeeklyQuestStatus()
{
    if (m_weeklyquests.empty())
        return;

    m_weeklyquests.clear();
    // DB data deleted in caller
    m_WeeklyQuestChanged = false;
}

void Player::ResetSeasonalQuestStatus(uint16 event_id)
{
    if (m_seasonalquests.empty() || m_seasonalquests[event_id].empty())
        return;

    m_seasonalquests.erase(event_id);
    // DB data deleted in caller
    m_SeasonalQuestChanged = false;
}

void Player::ResetMonthlyQuestStatus()
{
    if (m_monthlyquests.empty())
        return;

    m_monthlyquests.clear();
    // DB data deleted in caller
    m_MonthlyQuestChanged = false;
}

Battleground* Player::GetBattleground(bool create) const
{
    if (GetBattlegroundId() == 0)
        return nullptr;

    Battleground* bg = sBattlegroundMgr->GetBattleground(GetBattlegroundId(), GetBattlegroundTypeId());
    return (create || (bg && bg->FindBgMap()) ? bg : nullptr);
}

bool Player::InBattlegroundQueue(bool ignoreArena) const
{
    for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
        if (_BgBattlegroundQueueID[i].bgQueueTypeId != BATTLEGROUND_QUEUE_NONE &&
            (!ignoreArena || (_BgBattlegroundQueueID[i].bgQueueTypeId != BATTLEGROUND_QUEUE_2v2 &&
                _BgBattlegroundQueueID[i].bgQueueTypeId != BATTLEGROUND_QUEUE_3v3 &&
                _BgBattlegroundQueueID[i].bgQueueTypeId != BATTLEGROUND_QUEUE_5v5)))
            return true;
    return false;
}

BattlegroundQueueTypeId Player::GetBattlegroundQueueTypeId(uint32 index) const
{
    return _BgBattlegroundQueueID[index].bgQueueTypeId;
}

uint32 Player::GetBattlegroundQueueIndex(BattlegroundQueueTypeId bgQueueTypeId) const
{
    for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
        if (_BgBattlegroundQueueID[i].bgQueueTypeId == bgQueueTypeId)
            return i;

    return PLAYER_MAX_BATTLEGROUND_QUEUES;
}

bool Player::IsInvitedForBattlegroundQueueType(BattlegroundQueueTypeId bgQueueTypeId) const
{
    for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
        if (_BgBattlegroundQueueID[i].bgQueueTypeId == bgQueueTypeId)
            return _BgBattlegroundQueueID[i].invitedToInstance != 0;

    return false;
}

bool Player::InBattlegroundQueueForBattlegroundQueueType(BattlegroundQueueTypeId bgQueueTypeId) const
{
    return GetBattlegroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES;
}

uint32 Player::AddBattlegroundQueueId(BattlegroundQueueTypeId val)
{
    for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
    {
        if (_BgBattlegroundQueueID[i].bgQueueTypeId == BATTLEGROUND_QUEUE_NONE || _BgBattlegroundQueueID[i].bgQueueTypeId == val)
        {
            _BgBattlegroundQueueID[i].bgQueueTypeId = val;
            _BgBattlegroundQueueID[i].invitedToInstance = 0;
            return i;
        }
    }

    return PLAYER_MAX_BATTLEGROUND_QUEUES;
}

bool Player::HasFreeBattlegroundQueueId() const
{
    for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
        if (_BgBattlegroundQueueID[i].bgQueueTypeId == BATTLEGROUND_QUEUE_NONE)
            return true;

    return false;
}

void Player::RemoveBattlegroundQueueId(BattlegroundQueueTypeId val)
{
    for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
    {
        if (_BgBattlegroundQueueID[i].bgQueueTypeId == val)
        {
            _BgBattlegroundQueueID[i].bgQueueTypeId = BATTLEGROUND_QUEUE_NONE;
            _BgBattlegroundQueueID[i].invitedToInstance = 0;
            return;
        }
    }
}

void Player::SetInviteForBattlegroundQueueType(BattlegroundQueueTypeId bgQueueTypeId, uint32 instanceId)
{
    for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
        if (_BgBattlegroundQueueID[i].bgQueueTypeId == bgQueueTypeId)
            _BgBattlegroundQueueID[i].invitedToInstance = instanceId;
}

bool Player::IsInvitedForBattlegroundInstance(uint32 instanceId) const
{
    for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
        if (_BgBattlegroundQueueID[i].invitedToInstance == instanceId)
            return true;

    return false;
}

bool Player::InArena() const
{
    Battleground* bg = GetBattleground();
    if (!bg || !bg->isArena())
        return false;

    return true;
}

void Player::SetBattlegroundId(uint32 id, BattlegroundTypeId bgTypeId, uint32 queueSlot, bool invited, bool isRandom, TeamId teamId)
{
    m_bgData.bgInstanceID = id;
    m_bgData.bgTypeID = bgTypeId;
    m_bgData.bgQueueSlot = queueSlot;
    m_bgData.isInvited = invited;
    m_bgData.bgIsRandom = isRandom;

    m_bgData.bgTeamId = teamId;
    SetByteValue(PLAYER_BYTES_3, 3, uint8(teamId == TEAM_ALLIANCE ? 1 : 0));
}

bool Player::GetBGAccessByLevel(BattlegroundTypeId bgTypeId) const
{
    // get a template bg instead of running one
    Battleground* bgt = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);
    if (!bgt)
        return false;

    // limit check leel to dbc compatible level range
    uint32 level = GetLevel();
    if (level > DEFAULT_MAX_LEVEL)
        level = DEFAULT_MAX_LEVEL;

    if (level < bgt->GetMinLevel() || level > bgt->GetMaxLevel())
        return false;

    return true;
}

float Player::GetReputationPriceDiscount(Creature const* creature) const
{
    return GetReputationPriceDiscount(creature->GetFactionTemplateEntry());
}

float Player::GetReputationPriceDiscount(FactionTemplateEntry const* factionTemplate) const
{
    if (!factionTemplate || !factionTemplate->faction)
    {
        return 1.0f;
    }

    ReputationRank rank = GetReputationRank(factionTemplate->faction);
    if (rank <= REP_NEUTRAL)
    {
        return 1.0f;
    }

    return 1.0f - 0.05f * (rank - REP_NEUTRAL);
}

bool Player::IsSpellFitByClassAndRace(uint32 spell_id) const
{
    uint32 racemask  = getRaceMask();
    uint32 classmask = getClassMask();

    SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spell_id);
    if (bounds.first == bounds.second)
        return true;

    for (SkillLineAbilityMap::const_iterator _spell_idx = bounds.first; _spell_idx != bounds.second; ++_spell_idx)
    {
        // skip wrong race skills
        if (_spell_idx->second->RaceMask && (_spell_idx->second->RaceMask & racemask) == 0)
            continue;

        // skip wrong class skills
        if (_spell_idx->second->ClassMask && (_spell_idx->second->ClassMask & classmask) == 0)
            continue;

        return true;
    }

    return false;
}

bool Player::HasQuestForGO(int32 GOId) const
{
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (questid == 0)
            continue;

        QuestStatusMap::const_iterator qs_itr = m_QuestStatus.find(questid);
        if (qs_itr == m_QuestStatus.end())
            continue;

        QuestStatusData const& qs = qs_itr->second;

        if (qs.Status == QUEST_STATUS_INCOMPLETE)
        {
            Quest const* qinfo = sObjectMgr->GetQuestTemplate(questid);
            if (!qinfo)
                continue;

            if (GetGroup() && GetGroup()->isRaidGroup() && !qinfo->IsAllowedInRaid(GetMap()->GetDifficulty()))
                continue;

            for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
            {
                if (qinfo->RequiredNpcOrGo[j] >= 0)       //skip non GO case
                    continue;

                if ((-1)*GOId == qinfo->RequiredNpcOrGo[j] && qs.CreatureOrGOCount[j] < qinfo->RequiredNpcOrGoCount[j])
                    return true;
            }
        }
    }
    return false;
}

void Player::SummonIfPossible(bool agree, ObjectGuid summoner_guid)
{
    if (!agree)
    {
        m_summon_expire = 0;
        return;
    }

    // expire and auto declined
    if (m_summon_expire < GameTime::GetGameTime().count())
        return;

    // drop flag at summon
    // this code can be reached only when GM is summoning player who carries flag, because player should be immune to summoning spells when he carries flag
    if (Battleground* bg = GetBattleground())
        bg->EventPlayerDroppedFlag(this);

    m_summon_expire = 0;

    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_ACCEPTED_SUMMONINGS, 1);

    TeleportTo(m_summon_mapid, m_summon_x, m_summon_y, m_summon_z, GetOrientation(), 0, ObjectAccessor::FindPlayer(summoner_guid));
}

void Player::RemoveItemDurations(Item* item)
{
    for (ItemDurationList::iterator itr = m_itemDuration.begin(); itr != m_itemDuration.end(); ++itr)
    {
        if (*itr == item)
        {
            m_itemDuration.erase(itr);
            break;
        }
    }
}

void Player::AddItemDurations(Item* item)
{
    if (item->GetUInt32Value(ITEM_FIELD_DURATION))
    {
        m_itemDuration.push_back(item);
        item->SendTimeUpdate(this);
    }
}

void Player::AutoUnequipOffhandIfNeed(bool force /*= false*/)
{
    Item* offItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
    if (!offItem)
    {
        UpdateTitansGrip();
        return;
    }

    // unequip offhand weapon if player doesn't have dual wield anymore
    if (!CanDualWield() && (offItem->GetTemplate()->InventoryType == INVTYPE_WEAPONOFFHAND || offItem->GetTemplate()->InventoryType == INVTYPE_WEAPON))
        force = true;

    // unequip offhand weapon if player main hand weapon is a polearm or staff or fishing pole
    if (Item* mhWeapon = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND))
        if (ItemTemplate const* mhWeaponProto = mhWeapon->GetTemplate())
            if (mhWeaponProto->SubClass == ITEM_SUBCLASS_WEAPON_POLEARM ||
                mhWeaponProto->SubClass == ITEM_SUBCLASS_WEAPON_STAFF ||
                mhWeaponProto->SubClass == ITEM_SUBCLASS_WEAPON_FISHING_POLE)
                force = true;

    // need unequip offhand for 2h-weapon without TitanGrip (in any from hands)
    if (!force && (CanTitanGrip() || (offItem->GetTemplate()->InventoryType != INVTYPE_2HWEAPON && !IsTwoHandUsed())))
    {
        UpdateTitansGrip();
        return;
    }

    ItemPosCountVec off_dest;
    uint8 off_msg = CanStoreItem(NULL_BAG, NULL_SLOT, off_dest, offItem, false);
    if (off_msg == EQUIP_ERR_OK)
    {
        RemoveItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
        StoreItem(off_dest, offItem, true);
    }
    else
    {
        MoveItemFromInventory(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        offItem->DeleteFromInventoryDB(trans);                   // deletes item from character's inventory
        offItem->SaveToDB(trans);                                // recursive and not have transaction guard into self, item not in inventory and can be save standalone

        std::string subject = GetSession()->GetAcoreString(LANG_NOT_EQUIPPED_ITEM);
        MailDraft(subject, "There were problems with equipping one or several items").AddItem(offItem).SendMailTo(trans, this, MailSender(this, MAIL_STATIONERY_GM), MAIL_CHECK_MASK_COPIED);

        CharacterDatabase.CommitTransaction(trans);
    }
    UpdateTitansGrip();
}

OutdoorPvP* Player::GetOutdoorPvP() const
{
    return sOutdoorPvPMgr->GetOutdoorPvPToZoneId(GetZoneId());
}

bool Player::HasItemFitToSpellRequirements(SpellInfo const* spellInfo, Item const* ignoreItem) const
{
    if (spellInfo->EquippedItemClass < 0)
        return true;

    // scan other equipped items for same requirements (mostly 2 daggers/etc)
    // for optimize check 2 used cases only
    switch (spellInfo->EquippedItemClass)
    {
        case ITEM_CLASS_WEAPON:
            {
                for (uint8 i = EQUIPMENT_SLOT_MAINHAND; i < EQUIPMENT_SLOT_TABARD; ++i)
                    if (Item* item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, i))
                        if (item != ignoreItem && item->IsFitToSpellRequirements(spellInfo))
                            return true;
                break;
            }
        case ITEM_CLASS_ARMOR:
            {
                // tabard not have dependent spells
                for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_MAINHAND; ++i)
                    if (Item* item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, i))
                        if (item != ignoreItem && item->IsFitToSpellRequirements(spellInfo))
                            return true;

                // shields can be equipped to offhand slot
                if (Item* item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND))
                    if (item != ignoreItem && item->IsFitToSpellRequirements(spellInfo))
                        return true;

                // ranged slot can have some armor subclasses
                if (Item* item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED))
                    if (item != ignoreItem && item->IsFitToSpellRequirements(spellInfo))
                        return true;

                break;
            }
        default:
            LOG_ERROR("entities.player", "HasItemFitToSpellRequirements: Not handled spell requirement for item class {}", spellInfo->EquippedItemClass);
            break;
    }

    return false;
}

bool Player::CanNoReagentCast(SpellInfo const* spellInfo) const
{
    // don't take reagents for spells with SPELL_ATTR5_NO_REAGENT_COST_WITH_AURA
    if (spellInfo->HasAttribute(SPELL_ATTR5_NO_REAGENT_COST_WITH_AURA) && HasUnitFlag(UNIT_FLAG_PREPARATION))
        return true;

    // Check no reagent use mask
    flag96 noReagentMask;
    noReagentMask[0] = GetUInt32Value(PLAYER_NO_REAGENT_COST_1);
    noReagentMask[1] = GetUInt32Value(PLAYER_NO_REAGENT_COST_1 + 1);
    noReagentMask[2] = GetUInt32Value(PLAYER_NO_REAGENT_COST_1 + 2);
    if (spellInfo->SpellFamilyFlags  & noReagentMask)
        return true;

    return false;
}

void Player::RemoveItemDependentAurasAndCasts(Item* pItem)
{
    for (AuraMap::iterator itr = m_ownedAuras.begin(); itr != m_ownedAuras.end();)
    {
        Aura* aura = itr->second;

        // skip passive (passive item dependent spells work in another way) and not self applied auras
        SpellInfo const* spellInfo = aura->GetSpellInfo();
        if (aura->IsPassive() ||  aura->GetCasterGUID() != GetGUID())
        {
            ++itr;
            continue;
        }

        // skip if not item dependent or have alternative item
        if (HasItemFitToSpellRequirements(spellInfo, pItem))
        {
            ++itr;
            continue;
        }

        // no alt item, remove aura, restart check
        RemoveOwnedAura(itr);
    }

    // currently casted spells can be dependent from item
    for (uint32 i = 0; i < CURRENT_MAX_SPELL; ++i)
        if (Spell* spell = GetCurrentSpell(CurrentSpellTypes(i)))
            if (spell->getState() != SPELL_STATE_DELAYED && !HasItemFitToSpellRequirements(spell->m_spellInfo, pItem))
                InterruptSpell(CurrentSpellTypes(i));
}

uint32 Player::GetResurrectionSpellId()
{
    // search priceless resurrection possibilities
    uint32 prio = 0;
    uint32 spell_id = 0;
    AuraEffectList const& dummyAuras = GetAuraEffectsByType(SPELL_AURA_DUMMY);
    for (AuraEffectList::const_iterator itr = dummyAuras.begin(); itr != dummyAuras.end(); ++itr)
    {
        // Soulstone Resurrection                           // prio: 3 (max, non death persistent)
        if (prio < 2 && (*itr)->GetSpellInfo()->SpellVisual[0] == 99 && (*itr)->GetSpellInfo()->SpellIconID == 92)
        {
            switch ((*itr)->GetId())
            {
                case 20707:
                    spell_id =  3026;
                    break;        // rank 1
                case 20762:
                    spell_id = 20758;
                    break;        // rank 2
                case 20763:
                    spell_id = 20759;
                    break;        // rank 3
                case 20764:
                    spell_id = 20760;
                    break;        // rank 4
                case 20765:
                    spell_id = 20761;
                    break;        // rank 5
                case 27239:
                    spell_id = 27240;
                    break;        // rank 6
                case 47883:
                    spell_id = 47882;
                    break;        // rank 7
                default:
                    LOG_ERROR("entities.player", "Unhandled spell {}: S.Resurrection", (*itr)->GetId());
                    continue;
            }

            prio = 3;
        }
        // Twisting Nether                                  // prio: 2 (max)
        else if ((*itr)->GetId() == 23701 && roll_chance_i(10))
        {
            prio = 2;
            spell_id = 23700;
        }
    }

    // Reincarnation (passive spell)  // prio: 1                  // Glyph of Renewed Life
    if (prio < 1 && HasSpell(20608) && !HasSpellCooldown(21169) && (HasAura(58059) || HasItemCount(17030)))
        spell_id = 21169;

    return spell_id;
}

// Used in triggers for check "Only to targets that grant experience or honor" req
bool Player::isHonorOrXPTarget(Unit* victim) const
{
    uint8 v_level = victim->GetLevel();
    uint8 k_grey  = Acore::XP::GetGrayLevel(GetLevel());

    // Victim level less gray level
    if (v_level <= k_grey)
    {
        return false;
    }

    if (victim->IsCreature())
    {
        if (victim->IsTotem() || victim->IsCritter() || victim->IsPet() || (victim->ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_XP))
        {
            return false;
        }
    }

    return true;
}

bool Player::GetsRecruitAFriendBonus(bool forXP)
{
    bool recruitAFriend = false;
    if (GetLevel() <= sWorld->getIntConfig(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL) || !forXP)
    {
        if (Group* group = this->GetGroup())
        {
            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                Player* player = itr->GetSource();
                if (!player || !player->IsInMap(this))
                    continue;

                if (!player->IsAtRecruitAFriendDistance(this))
                    continue;                               // member (alive or dead) or his corpse at req. distance

                if (forXP)
                {
                    // level must be allowed to get RaF bonus
                    if (player->GetLevel() > sWorld->getIntConfig(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL))
                        continue;

                    // level difference must be small enough to get RaF bonus, UNLESS we are lower level
                    if (player->GetLevel() < GetLevel())
                        if (uint8(GetLevel() - player->GetLevel()) > sWorld->getIntConfig(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL_DIFFERENCE))
                            continue;
                }

                bool ARecruitedB = (player->GetSession()->GetRecruiterId() == GetSession()->GetAccountId());
                bool BRecruitedA = (GetSession()->GetRecruiterId() == player->GetSession()->GetAccountId());
                if (ARecruitedB || BRecruitedA)
                {
                    recruitAFriend = true;
                    break;
                }
            }
        }
    }
    return recruitAFriend;
}

void Player::RewardPlayerAndGroupAtKill(Unit* victim, bool isBattleGround)
{
    KillRewarder(this, victim, isBattleGround).Reward();
}

void Player::RewardPlayerAndGroupAtEvent(uint32 creature_id, WorldObject* pRewardSource)
{
    if (!pRewardSource)
        return;

    ObjectGuid creature_guid = (pRewardSource->IsCreature()) ? pRewardSource->GetGUID() : ObjectGuid::Empty;

    // prepare data for near group iteration
    if (Group* group = GetGroup())
    {
        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* player = itr->GetSource();
            if (!player)
                continue;

            if (!player->IsAtGroupRewardDistance(pRewardSource))
                continue;                               // member (alive or dead) or his corpse at req. distance

            // quest objectives updated only for alive group member or dead but with not released body
            if (player->IsAlive() || !player->GetCorpse())
                player->KilledMonsterCredit(creature_id, creature_guid);
        }
    }
    else                                                    // if (!group)
        KilledMonsterCredit(creature_id, creature_guid);
}

bool Player::IsAtGroupRewardDistance(WorldObject const* pRewardSource) const
{
    WorldObject const* player = GetCorpse();
    if (!player || IsAlive())
    {
        player = this;
    }

    if (!pRewardSource || !player->IsInMap(pRewardSource))
    {
        return false;
    }

    if (pRewardSource->GetMap()->IsDungeon())
    {
        return true;
    }

    return pRewardSource->GetDistance(player) <= sWorld->getFloatConfig(CONFIG_GROUP_XP_DISTANCE);
}

bool Player::IsAtLootRewardDistance(WorldObject const* pRewardSource) const
{
    if (!IsAtGroupRewardDistance(pRewardSource))
    {
        return false;
    }

    if (HasPendingBind())
    {
        return false;
    }

    return pRewardSource->HasAllowedLooter(GetGUID());
}

bool Player::IsAtRecruitAFriendDistance(WorldObject const* pOther) const
{
    if (!pOther)
        return false;
    WorldObject const* player = GetCorpse();
    if (!player || IsAlive())
        player = this;

    if (player->GetMapId() != pOther->GetMapId() || player->GetInstanceId() != pOther->GetInstanceId())
        return false;

    return pOther->GetDistance(player) <= sWorld->getFloatConfig(CONFIG_MAX_RECRUIT_A_FRIEND_DISTANCE);
}

uint32 Player::GetBaseWeaponSkillValue(WeaponAttackType attType) const
{
    Item* item = GetWeaponForAttack(attType, true);

    // unarmed only with base attack
    if (attType != BASE_ATTACK && !item)
        return 0;

    // weapon skill or (unarmed for base attack)
    uint32  skill = item ? item->GetSkill() : uint32(SKILL_UNARMED);
    return GetBaseSkillValue(skill);
}

void Player::ResurectUsingRequestData()
{
    /// Teleport before resurrecting by player, otherwise the player might get attacked from creatures near his corpse
    TeleportTo(m_resurrectMap, m_resurrectX, m_resurrectY, m_resurrectZ, GetOrientation());

    if (IsBeingTeleported())
    {
        ScheduleDelayedOperation(DELAYED_RESURRECT_PLAYER);
        return;
    }

    ResurrectPlayer(0.0f, false);

    if (GetMaxHealth() > m_resurrectHealth)
        SetHealth(m_resurrectHealth);
    else
        SetFullHealth();

    if (GetMaxPower(POWER_MANA) > m_resurrectMana)
        SetPower(POWER_MANA, m_resurrectMana);
    else
        SetPower(POWER_MANA, GetMaxPower(POWER_MANA));

    SetPower(POWER_RAGE, 0);

    SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));

    SpawnCorpseBones();
}

void Player::SetClientControl(Unit* target, bool allowMove, bool packetOnly /*= false*/)
{
    WorldPacket data(SMSG_CLIENT_CONTROL_UPDATE, target->GetPackGUID().size() + 1);
    data << target->GetPackGUID();
    data << uint8((allowMove && !target->HasUnitState(UNIT_STATE_FLEEING | UNIT_STATE_CONFUSED)) ? 1 : 0);
    GetSession()->SendPacket(&data);

    // We want to set the packet only
    if (packetOnly)
        return;

    if (this != target)
        SetViewpoint(target, allowMove);

    if (allowMove)
        SetMover(target);

    // Xinef: disable moving if target has disable move flag
    if (!target->IsCreature())
        return;

    if (allowMove && target->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
    {
        target->ClearUnitState(UNIT_STATE_ROOT);
        target->SetControlled(true, UNIT_STATE_ROOT);
    }
    else if (!allowMove && target->HasUnitState(UNIT_STATE_ROOT) && !target->HasUnitTypeMask(UNIT_MASK_ACCESSORY))
    {
        if (target->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        {
            // Xinef: restore original orientation, important for shooting vehicles!
            Position pos = target->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && target->GetTransGUID() && target->GetTransGUID().IsMOTransport() ? target->ToCreature()->GetTransportHomePosition() : target->ToCreature()->GetHomePosition();
            target->SetOrientation(pos.GetOrientation());
            target->SetFacingTo(pos.GetOrientation());
            target->DisableSpline();
        }
        else
            target->SetControlled(false, UNIT_STATE_ROOT);
    }
}

void Player::SetMover(Unit* target)
{
    if (this != target && target->m_movedByPlayer && target->m_movedByPlayer != target && target->m_movedByPlayer != this)
    {
        LOG_INFO("misc", "Player::SetMover (A1) - {}, {}, {}, {}, {}, {}, {}, {}", GetGUID().ToString(), GetMapId(), GetInstanceId(), FindMap()->GetId(), IsInWorld() ? 1 : 0, IsDuringRemoveFromWorld() ? 1 : 0, IsBeingTeleported() ? 1 : 0, isBeingLoaded() ? 1 : 0);
        LOG_INFO("misc", "Player::SetMover (A2) - {}, {}, {}, {}, {}, {}, {}, {}", target->GetGUID().ToString(), target->GetMapId(), target->GetInstanceId(), target->FindMap()->GetId(), target->IsInWorld() ? 1 : 0, target->IsDuringRemoveFromWorld() ? 1 : 0, (target->ToPlayer() && target->ToPlayer()->IsBeingTeleported() ? 1 : 0), target->isBeingLoaded() ? 1 : 0);
        LOG_INFO("misc", "Player::SetMover (A3) - {}, {}, {}, {}, {}, {}, {}, {}", target->m_movedByPlayer->GetGUID().ToString(), target->m_movedByPlayer->GetMapId(), target->m_movedByPlayer->GetInstanceId(), target->m_movedByPlayer->FindMap()->GetId(), target->m_movedByPlayer->IsInWorld() ? 1 : 0, target->m_movedByPlayer->IsDuringRemoveFromWorld() ? 1 : 0, target->m_movedByPlayer->ToPlayer()->IsBeingTeleported() ? 1 : 0, target->m_movedByPlayer->isBeingLoaded() ? 1 : 0);
    }
    if (this != target && (!target->IsInWorld() || target->IsDuringRemoveFromWorld() || GetMapId() != target->GetMapId() || GetInstanceId() != target->GetInstanceId()))
    {
        LOG_INFO("misc", "Player::SetMover (B1) - {}, {}, {}, {}, {}, {}, {}, {}", GetGUID().ToString(), GetMapId(), GetInstanceId(), FindMap()->GetId(), IsInWorld() ? 1 : 0, IsDuringRemoveFromWorld() ? 1 : 0, IsBeingTeleported() ? 1 : 0, isBeingLoaded() ? 1 : 0);
        LOG_INFO("misc", "Player::SetMover (B2) - {}, {}, {}, {}, {}, {}, {}, {}", target->GetGUID().ToString(), target->GetMapId(), target->GetInstanceId(), target->FindMap()->GetId(), target->IsInWorld() ? 1 : 0, target->IsDuringRemoveFromWorld() ? 1 : 0, (target->ToPlayer() && target->ToPlayer()->IsBeingTeleported() ? 1 : 0), target->isBeingLoaded() ? 1 : 0);
    }
    m_mover->m_movedByPlayer = nullptr;
    if (m_mover->IsCreature())
        m_mover->GetMotionMaster()->Initialize();

    m_mover = target;
    m_mover->m_movedByPlayer = this;
    if (m_mover->IsCreature())
        m_mover->GetMotionMaster()->Initialize();
}

uint32 Player::GetCorpseReclaimDelay(bool pvp) const
{
    if (pvp)
    {
        if (!sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP))
            return copseReclaimDelay[0];
    }
    else if (!sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE))
        return 0;

    time_t now = GameTime::GetGameTime().count();
    // 0..2 full period
    // should be std::ceil(x)-1 but not floor(x)
    uint64 count = (now < m_deathExpireTime - 1) ? (m_deathExpireTime - 1 - now) / DEATH_EXPIRE_STEP : 0;
    return copseReclaimDelay[count];
}

int32 Player::CalculateCorpseReclaimDelay(bool load)
{
    Corpse* corpse = GetCorpse();

    if (load && !corpse)
        return -1;

    bool pvp = corpse ? corpse->GetType() == CORPSE_RESURRECTABLE_PVP : m_ExtraFlags & PLAYER_EXTRA_PVP_DEATH;

    uint32 delay;

    if (load)
    {
        if (corpse->GetGhostTime() > m_deathExpireTime)
            return -1;

        uint64 count = 0;

        if ((pvp && sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP)) ||
                (!pvp && sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE)))
        {
            count = (m_deathExpireTime - corpse->GetGhostTime()) / DEATH_EXPIRE_STEP;

            if (count >= MAX_DEATH_COUNT)
                count = MAX_DEATH_COUNT - 1;
        }

        time_t expected_time = corpse->GetGhostTime() + copseReclaimDelay[count];
        time_t now = GameTime::GetGameTime().count();

        if (now >= expected_time)
            return -1;

        delay = expected_time - now;
    }
    else
        delay = GetCorpseReclaimDelay(pvp);

    return delay * IN_MILLISECONDS;
}

void Player::SendCorpseReclaimDelay(uint32 delay)
{
    WorldPacket data(SMSG_CORPSE_RECLAIM_DELAY, 4);
    data << uint32(delay);
    GetSession()->SendPacket(&data);
}

Player* Player::GetNextRandomRaidMember(float radius)
{
    Group* group = GetGroup();
    if (!group)
        return nullptr;

    std::vector<Player*> nearMembers;
    nearMembers.reserve(group->GetMembersCount());

    for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
    {
        Player* Target = itr->GetSource();

        // IsHostileTo check duel and controlled by enemy
        if (Target && Target != this && IsWithinDistInMap(Target, radius) &&
                !Target->HasInvisibilityAura() && !IsHostileTo(Target))
            nearMembers.push_back(Target);
    }

    if (nearMembers.empty())
        return nullptr;

    uint32 randTarget = urand(0, nearMembers.size() - 1);
    return nearMembers[randTarget];
}

PartyResult Player::CanUninviteFromGroup(ObjectGuid targetPlayerGUID) const
{
    Group const* grp = GetGroup();
    if (!grp)
        return ERR_NOT_IN_GROUP;

    if (grp->isLFGGroup(true))
    {
        ObjectGuid gguid = grp->GetGUID();
        if (!sLFGMgr->GetKicksLeft(gguid))
            return ERR_PARTY_LFG_BOOT_LIMIT;

        lfg::LfgState state = sLFGMgr->GetState(gguid);
        if (state == lfg::LFG_STATE_BOOT)
            return ERR_PARTY_LFG_BOOT_IN_PROGRESS;

        if (grp->GetMembersCount() <= lfg::LFG_GROUP_KICK_VOTES_NEEDED)
            return ERR_PARTY_LFG_BOOT_TOO_FEW_PLAYERS;

        if (state == lfg::LFG_STATE_FINISHED_DUNGEON)
            return ERR_PARTY_LFG_BOOT_DUNGEON_COMPLETE;

        if (grp->isRollLootActive())
            return ERR_PARTY_LFG_BOOT_LOOT_ROLLS;

        /// @todo: Should also be sent when anyone has recently left combat, with an aprox ~5 seconds timer.
        for (GroupReference const* itr = grp->GetFirstMember(); itr != nullptr; itr = itr->next())
            if (itr->GetSource() && itr->GetSource()->IsInMap(this) && itr->GetSource()->IsInCombat())
                return ERR_PARTY_LFG_BOOT_IN_COMBAT;

        if (Player* target = ObjectAccessor::FindConnectedPlayer(targetPlayerGUID))
        {
            if (Aura* dungeonCooldownAura = target->GetAura(lfg::LFG_SPELL_DUNGEON_COOLDOWN))
            {
                int32 elapsedTime = dungeonCooldownAura->GetMaxDuration() - dungeonCooldownAura->GetDuration();
                if (static_cast<int32>(sWorld->getIntConfig(CONFIG_LFG_KICK_PREVENTION_TIMER)) > elapsedTime)
                {
                    return ERR_PARTY_LFG_BOOT_NOT_ELIGIBLE_S;
                }
            }
        }

        /* Missing support for these types
            return ERR_PARTY_LFG_BOOT_COOLDOWN_S;
        */
    }
    else
    {
        if (!grp->IsLeader(GetGUID()) && !grp->IsAssistant(GetGUID()))
            return ERR_NOT_LEADER;

        if (InBattleground())
            return ERR_INVITE_RESTRICTED;
    }

    return ERR_PARTY_RESULT_OK;
}

bool Player::isUsingLfg()
{
    return sLFGMgr->GetState(GetGUID()) != lfg::LFG_STATE_NONE;
}

bool Player::inRandomLfgDungeon()
{
    if (sLFGMgr->selectedRandomLfgDungeon(GetGUID()))
    {
        Map const* map = GetMap();
        return sLFGMgr->inLfgDungeonMap(GetGUID(), map->GetId(), map->GetDifficulty());
    }

    return false;
}

void Player::SetBattlegroundOrBattlefieldRaid(Group* group, int8 subgroup)
{
    //we must move references from m_group to m_originalGroup
    if (GetGroup() && (GetGroup()->isBGGroup() || GetGroup()->isBFGroup()))
    {
        LOG_INFO("misc", "Player::SetBattlegroundOrBattlefieldRaid - current group is {} group!", (GetGroup()->isBGGroup() ? "BG" : "BF"));
        //ABORT(); // pussywizard: origanal group can never be bf/bg group
    }

    SetOriginalGroup(GetGroup(), GetSubGroup());

    m_group.unlink();
    m_group.link(group, this);
    m_group.setSubGroup((uint8)subgroup);
}

void Player::RemoveFromBattlegroundOrBattlefieldRaid()
{
    //remove existing reference
    m_group.unlink();
    if (Group* group = GetOriginalGroup())
    {
        m_group.link(group, this);
        m_group.setSubGroup(GetOriginalSubGroup());
    }
    SetOriginalGroup(nullptr);
}

void Player::SetOriginalGroup(Group* group, int8 subgroup)
{
    if (!group)
        m_originalGroup.unlink();
    else
    {
        // never use SetOriginalGroup without a subgroup unless you specify nullptr for group
        ASSERT(subgroup >= 0);
        m_originalGroup.link(group, this);
        m_originalGroup.setSubGroup((uint8)subgroup);
    }
}

void Player::SetCanParry(bool value)
{
    if (m_canParry == value)
        return;

    m_canParry = value;
    UpdateParryPercentage();
}

void Player::SetCanBlock(bool value)
{
    if (m_canBlock == value)
        return;

    m_canBlock = value;
    UpdateBlockPercentage();
}

void Player::SetCanTitanGrip(bool value)
{
    m_canTitanGrip = value;
}

bool ItemPosCount::isContainedIn(ItemPosCountVec const& vec) const
{
    for (ItemPosCountVec::const_iterator itr = vec.begin(); itr != vec.end(); ++itr)
        if (itr->pos == pos)
            return true;
    return false;
}

void Player::StopCastingBindSight(Aura* except /*= nullptr*/)
{
    if (WorldObject* target = GetViewpoint())
    {
        if (target->IsUnit())
        {
            ((Unit*)target)->RemoveAurasByType(SPELL_AURA_BIND_SIGHT, GetGUID(), except);
            ((Unit*)target)->RemoveAurasByType(SPELL_AURA_MOD_POSSESS, GetGUID(), except);
            ((Unit*)target)->RemoveAurasByType(SPELL_AURA_MOD_POSSESS_PET, GetGUID(), except);
        }
    }
}

void Player::SetViewpoint(WorldObject* target, bool apply)
{
    if (apply)
    {
        LOG_DEBUG("maps", "Player::CreateViewpoint: Player {} create seer {} (TypeId: {}).", GetName(), target->GetEntry(), target->GetTypeId());

        if (!AddGuidValue(PLAYER_FARSIGHT, target->GetGUID()))
        {
            LOG_DEBUG("entities.player", "Player::CreateViewpoint: Player {} cannot add new viewpoint!", GetName());
            return;
        }

        // farsight dynobj or puppet may be very far away
        UpdateVisibilityOf(target);

        if (target->IsUnit() && !GetVehicle())
            ((Unit*)target)->AddPlayerToVision(this);
        SetSeer(target);
    }
    else
    {
        //must immediately set seer back otherwise may crash
        m_seer = this;

        LOG_DEBUG("maps", "Player::CreateViewpoint: Player {} remove seer", GetName());

        if (!RemoveGuidValue(PLAYER_FARSIGHT, target->GetGUID()))
        {
            LOG_DEBUG("entities.player", "Player::CreateViewpoint: Player {} cannot remove current viewpoint!", GetName());
            return;
        }

        if (target->IsUnit() && !GetVehicle())
            static_cast<Unit*>(target)->RemovePlayerFromVision(this);

        // must immediately set seer back otherwise may crash
        SetSeer(this);

        //WorldPacket data(SMSG_CLEAR_FAR_SIGHT_IMMEDIATE, 0);
        //GetSession()->SendPacket(&data);
    }
}

WorldObject* Player::GetViewpoint() const
{
    if (ObjectGuid guid = GetGuidValue(PLAYER_FARSIGHT))
        return static_cast<WorldObject*>(ObjectAccessor::GetObjectByTypeMask(*this, guid, TYPEMASK_SEER));
    return nullptr;
}

bool Player::CanUseBattlegroundObject(GameObject* gameobject) const
{
    // It is possible to call this method will a nullptr pointer, only skipping faction check.
    if (gameobject)
    {
        FactionTemplateEntry const* playerFaction = GetFactionTemplateEntry();
        FactionTemplateEntry const* faction = sFactionTemplateStore.LookupEntry(gameobject->GetUInt32Value(GAMEOBJECT_FACTION));

        if (playerFaction && faction && !playerFaction->IsFriendlyTo(*faction))
            return false;
    }

    /**
     * @bug
     * sometimes when player clicks on flag in AB - client won't send gameobject_use, only gameobject_report_use packet
     * Note: Mount, stealth and invisibility will be removed when used
     */
    return (!isTotalImmune() &&                            // Damage immune
            !HasAura(SPELL_RECENTLY_DROPPED_FLAG) &&       // Still has recently held flag debuff
            IsAlive());                                    // Alive
}

bool Player::CanCaptureTowerPoint() const
{
    return (!HasStealthAura() &&                            // not stealthed
            !HasInvisibilityAura() &&                      // not invisible
            IsAlive()                                      // live player
           );
}

uint32 Player::GetBarberShopCost(uint8 newhairstyle, uint8 newhaircolor, uint8 newfacialhair, BarberShopStyleEntry const* newSkin)
{
    uint8 level = GetLevel();

    if (level > GT_MAX_LEVEL)
        level = GT_MAX_LEVEL;                               // max level in this dbc

    uint8 hairstyle = GetByteValue(PLAYER_BYTES, 2);
    uint8 haircolor = GetByteValue(PLAYER_BYTES, 3);
    uint8 facialhair = GetByteValue(PLAYER_BYTES_2, 0);
    uint8 skincolor = GetByteValue(PLAYER_BYTES, 0);

    if ((hairstyle == newhairstyle) && (haircolor == newhaircolor) && (facialhair == newfacialhair) && (!newSkin || (newSkin->hair_id == skincolor)))
        return 0;

    GtBarberShopCostBaseEntry const* bsc = sGtBarberShopCostBaseStore.LookupEntry(level - 1);

    if (!bsc)                                                // shouldn't happen
        return 0xFFFFFFFF;

    float cost = 0;

    if (hairstyle != newhairstyle)
        cost += bsc->cost;                                  // full price

    if ((haircolor != newhaircolor) && (hairstyle == newhairstyle))
        cost += bsc->cost * 0.5f;                           // +1/2 of price

    if (facialhair != newfacialhair)
        cost += bsc->cost * 0.75f;                          // +3/4 of price

    if (newSkin && skincolor != newSkin->hair_id)
        cost += bsc->cost * 0.75f;                          // +5/6 of price

    return uint32(cost);
}

void Player::InitGlyphsForLevel()
{
    for (uint32 i = 0; i < sGlyphSlotStore.GetNumRows(); ++i)
        if (GlyphSlotEntry const* gs = sGlyphSlotStore.LookupEntry(i))
            if (gs->Order)
                SetGlyphSlot(gs->Order - 1, gs->Id);

    uint8 level = GetLevel();
    uint32 value = 0;

    // 0x3F = 0x01 | 0x02 | 0x04 | 0x08 | 0x10 | 0x20 for 80 level
    if (level >= 15)
        value |= (0x01 | 0x02);
    if (level >= 30)
        value |= 0x08;
    if (level >= 50)
        value |= 0x04;
    if (level >= 70)
        value |= 0x10;
    if (level >= 80)
        value |= 0x20;

    SetUInt32Value(PLAYER_GLYPHS_ENABLED, value);
}

bool Player::isTotalImmune() const
{
    AuraEffectList const& immune = GetAuraEffectsByType(SPELL_AURA_SCHOOL_IMMUNITY);

    uint32 immuneMask = 0;
    for (AuraEffectList::const_iterator itr = immune.begin(); itr != immune.end(); ++itr)
    {
        immuneMask |= (*itr)->GetMiscValue();
        if (immuneMask & SPELL_SCHOOL_MASK_ALL)            // total immunity
            return true;
    }
    return false;
}

bool Player::HasTitle(uint32 bitIndex) const
{
    if (bitIndex > MAX_TITLE_INDEX)
        return false;

    uint32 fieldIndexOffset = bitIndex / 32;
    uint32 flag = 1 << (bitIndex % 32);
    return HasFlag(PLAYER__FIELD_KNOWN_TITLES + fieldIndexOffset, flag);
}

void Player::SetTitle(CharTitlesEntry const* title, bool lost)
{
    uint32 fieldIndexOffset = title->bit_index / 32;
    uint32 flag = 1 << (title->bit_index % 32);

    if (lost)
    {
        if (!HasFlag(PLAYER__FIELD_KNOWN_TITLES + fieldIndexOffset, flag))
            return;

        // Clear the current title if it is the one being removed.
        if (title->bit_index == GetUInt32Value(PLAYER_CHOSEN_TITLE))
        {
            SetCurrentTitle(nullptr, true);
        }

        RemoveFlag(PLAYER__FIELD_KNOWN_TITLES + fieldIndexOffset, flag);
    }
    else
    {
        if (HasFlag(PLAYER__FIELD_KNOWN_TITLES + fieldIndexOffset, flag))
            return;

        SetFlag(PLAYER__FIELD_KNOWN_TITLES + fieldIndexOffset, flag);
    }

    WorldPacket data(SMSG_TITLE_EARNED, 4 + 4);
    data << uint32(title->bit_index);
    data << uint32(lost ? 0 : 1);                           // 1 - earned, 0 - lost
    GetSession()->SendPacket(&data);

    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_OWN_RANK);
}

uint32 Player::GetRuneBaseCooldown(uint8 index, bool skipGrace)
{
    uint8 rune = GetBaseRune(index);
    uint32 cooldown = RUNE_BASE_COOLDOWN;
    if (!skipGrace)
        cooldown -= GetGracePeriod(index) < 250 ? 0 : GetGracePeriod(index) - 250;  // xinef: reduce by grace period, treat first 250ms as instant use of rune

    AuraEffectList const& regenAura = GetAuraEffectsByType(SPELL_AURA_MOD_POWER_REGEN_PERCENT);
    for (AuraEffectList::const_iterator i = regenAura.begin(); i != regenAura.end(); ++i)
    {
        if ((*i)->GetMiscValue() == POWER_RUNE && (*i)->GetMiscValueB() == rune)
            cooldown = cooldown * (100 - (*i)->GetAmount()) / 100;
    }

    return cooldown;
}

void Player::RemoveRunesByAuraEffect(AuraEffect const* aura)
{
    for (uint8 i = 0; i < MAX_RUNES; ++i)
    {
        if (m_runes->runes[i].ConvertAura == aura)
        {
            ConvertRune(i, GetBaseRune(i));
            SetRuneConvertAura(i, nullptr);
        }
    }
}

void Player::RestoreBaseRune(uint8 index)
{
    AuraEffect const* aura = m_runes->runes[index].ConvertAura;
    // If rune was converted by a non-pasive aura that still active we should keep it converted
    if (aura && !aura->GetSpellInfo()->HasAttribute(SPELL_ATTR0_PASSIVE))
        return;
    ConvertRune(index, GetBaseRune(index));
    SetRuneConvertAura(index, nullptr);
    // Don't drop passive talents providing rune convertion
    if (!aura || aura->GetAuraType() != SPELL_AURA_CONVERT_RUNE)
        return;
    for (uint8 i = 0; i < MAX_RUNES; ++i)
    {
        if (aura == m_runes->runes[i].ConvertAura)
            return;
    }
    aura->GetBase()->Remove();
}

void Player::ConvertRune(uint8 index, RuneType newType)
{
    SetCurrentRune(index, newType);

    WorldPacket data(SMSG_CONVERT_RUNE, 2);
    data << uint8(index);
    data << uint8(newType);
    GetSession()->SendPacket(&data);
}

void Player::ResyncRunes(uint8 count)
{
    WorldPacket data(SMSG_RESYNC_RUNES, 4 + count * 2);
    data << uint32(count);
    for (uint32 i = 0; i < count; ++i)
    {
        data << uint8(GetCurrentRune(i));                   // rune type
        data << uint8(255 - (GetRuneCooldown(i) * 51));     // passed cooldown time (0-255)
    }
    GetSession()->SendPacket(&data);
}

void Player::AddRunePower(uint8 index)
{
    WorldPacket data(SMSG_ADD_RUNE_POWER, 4);
    data << uint32(1 << index);                             // mask (0x00-0x3F probably)
    GetSession()->SendPacket(&data);
}

static RuneType runeSlotTypes[MAX_RUNES] =
{
    /*0*/ RUNE_BLOOD,
    /*1*/ RUNE_BLOOD,
    /*2*/ RUNE_UNHOLY,
    /*3*/ RUNE_UNHOLY,
    /*4*/ RUNE_FROST,
    /*5*/ RUNE_FROST
};

void Player::InitRunes()
{
    if (!IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
        return;

    m_runes = new Runes;

    m_runes->runeState = 0;
    m_runes->lastUsedRune = RUNE_BLOOD;

    for (uint8 i = 0; i < MAX_RUNES; ++i)
    {
        SetBaseRune(i, runeSlotTypes[i]);                              // init base types
        SetCurrentRune(i, runeSlotTypes[i]);                           // init current types
        SetRuneCooldown(i, 0);                                         // reset cooldowns
        SetGracePeriod(i, 0);                                          // xinef: reset grace period
        SetRuneConvertAura(i, nullptr);
        m_runes->SetRuneState(i);
    }

    for (uint8 i = 0; i < NUM_RUNE_TYPES; ++i)
        SetFloatValue(PLAYER_RUNE_REGEN_1 + i, 0.1f);
}

bool Player::IsBaseRuneSlotsOnCooldown(RuneType runeType) const
{
    for (uint8 i = 0; i < MAX_RUNES; ++i)
        if (GetBaseRune(i) == runeType && GetRuneCooldown(i) == 0)
            return false;

    return true;
}

void Player::AutoStoreLoot(uint8 bag, uint8 slot, uint32 loot_id, LootStore const& store, bool broadcast)
{
    Loot loot;
    loot.FillLoot (loot_id, store, this, true);

    uint32 max_slot = loot.GetMaxSlotInLootFor(this);
    for (uint32 i = 0; i < max_slot; ++i)
    {
        LootItem* lootItem = loot.LootItemInSlot(i, this);

        ItemPosCountVec dest;
        InventoryResult msg = CanStoreNewItem(bag, slot, dest, lootItem->itemid, lootItem->count);
        if (msg != EQUIP_ERR_OK && slot != NULL_SLOT)
            msg = CanStoreNewItem(bag, NULL_SLOT, dest, lootItem->itemid, lootItem->count);
        if (msg != EQUIP_ERR_OK && bag != NULL_BAG)
            msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, lootItem->itemid, lootItem->count);
        if (msg != EQUIP_ERR_OK)
        {
            SendEquipError(msg, nullptr, nullptr, lootItem->itemid);
            continue;
        }

        Item* pItem = StoreNewItem(dest, lootItem->itemid, true, lootItem->randomPropertyId);
        SendNewItem(pItem, lootItem->count, false, false, broadcast);
    }
}

LootItem* Player::StoreLootItem(uint8 lootSlot, Loot* loot, InventoryResult& msg)
{
    QuestItem* qitem = nullptr;
    QuestItem* ffaitem = nullptr;
    QuestItem* conditem = nullptr;

    msg = EQUIP_ERR_OK;

    LootItem* item = loot->LootItemInSlot(lootSlot, this, &qitem, &ffaitem, &conditem);
    if (!item || item->is_looted)
    {
        if (!sScriptMgr->CanSendErrorAlreadyLooted(this))
        {
            SendEquipError(EQUIP_ERR_ALREADY_LOOTED, nullptr, nullptr);
        }
        return nullptr;
    }

    // Xinef: exploit protection, dont allow to loot normal items if player is not master loot and not below loot threshold
    // Xinef: only quest, ffa and conditioned items
    if (!item->is_underthreshold && loot->roundRobinPlayer && !GetLootGUID().IsItem() && GetGroup() && GetGroup()->GetLootMethod() == MASTER_LOOT && GetGUID() != GetGroup()->GetMasterLooterGuid())
        if (!qitem && !ffaitem && !conditem)
        {
            SendLootRelease(GetLootGUID());
            return nullptr;
        }

    if (!item->AllowedForPlayer(this, loot->sourceWorldObjectGUID))
    {
        SendLootRelease(GetLootGUID());
        return nullptr;
    }

    // questitems use the blocked field for other purposes
    if (!qitem && item->is_blocked)
    {
        SendLootRelease(GetLootGUID());
        return nullptr;
    }

    // xinef: dont allow protected item to be looted by someone else
    if (item->rollWinnerGUID && item->rollWinnerGUID != GetGUID())
    {
        SendLootRelease(GetLootGUID());
        return nullptr;
    }

    ItemPosCountVec dest;
    msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, item->itemid, item->count);
    if (msg == EQUIP_ERR_OK)
    {
        AllowedLooterSet looters = item->GetAllowedLooters();
        Item* newitem = StoreNewItem(dest, item->itemid, true, item->randomPropertyId, looters);

        if (qitem)
        {
            qitem->is_looted = true;
            //freeforall is 1 if everyone's supposed to get the quest item.
            if (item->freeforall || loot->GetPlayerQuestItems().size() == 1)
                SendNotifyLootItemRemoved(lootSlot);
            else
                loot->NotifyQuestItemRemoved(qitem->index);
        }
        else
        {
            if (ffaitem)
            {
                //freeforall case, notify only one player of the removal
                ffaitem->is_looted = true;
                SendNotifyLootItemRemoved(lootSlot);
            }
            else
            {
                //not freeforall, notify everyone
                if (conditem)
                    conditem->is_looted = true;
                loot->NotifyItemRemoved(lootSlot);
            }
        }

        //if only one person is supposed to loot the item, then set it to looted
        if (!item->freeforall)
            item->is_looted = true;

        --loot->unlootedCount;

        SendNewItem(newitem, uint32(item->count), false, false, true);
        UpdateLootAchievements(item, loot);

        // LootItem is being removed (looted) from the container, delete it from the DB.
        if (loot->containerGUID)
            sLootItemStorage->RemoveStoredLootItem(loot->containerGUID, item->itemid, item->count, loot, item->itemIndex);

        sScriptMgr->OnLootItem(this, newitem, item->count, this->GetLootGUID());
    }
    else
    {
        SendEquipError(msg, nullptr, nullptr, item->itemid);
    }

    return item;
}

uint32 Player::CalculateTalentsPoints() const
{
    uint32 base_talent = GetLevel() < 10 ? 0 : GetLevel() - 9;

    uint32 talentPointsForLevel = 0;
    if (!IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_TALENT_POINT_CALC) || GetMapId() != 609)
    {
        talentPointsForLevel = base_talent;
    }
    else
    {
        talentPointsForLevel = GetLevel() < 56 ? 0 : GetLevel() - 55;
        talentPointsForLevel += m_questRewardTalentCount;

        if (talentPointsForLevel > base_talent)
        {
            talentPointsForLevel = base_talent;
        }
    }

    talentPointsForLevel += m_extraBonusTalentCount;
    sScriptMgr->OnCalculateTalentsPoints(this, talentPointsForLevel);
    return uint32(talentPointsForLevel * sWorld->getRate(RATE_TALENT));
}

bool Player::canFlyInZone(uint32 mapid, uint32 zone, SpellInfo const* bySpell)
{
    if (!sScriptMgr->OnCanPlayerFlyInZone(this, mapid,zone,bySpell))
    {
        return false;
    }

    // continent checked in SpellInfo::CheckLocation at cast and area update
    uint32 v_map = GetVirtualMapForMapAndZone(mapid, zone);
    if (v_map == 571 && !bySpell->HasAttribute(SPELL_ATTR7_IGNORES_COLD_WEATHER_FLYING_REQUIREMENT))
    {
        if (!HasSpell(54197)) // 54197 = Cold Weather Flying
        {
            return false;
        }
    }

    return true;
}

void Player::learnSpellHighRank(uint32 spellid)
{
    learnSpell(spellid);

    if (uint32 next = sSpellMgr->GetNextSpellInChain(spellid))
        learnSpellHighRank(next);
}

void Player::_LoadSkills(PreparedQueryResult result)
{
    //                                                           0      1      2
    // SetQuery(PLAYER_LOGIN_QUERY_LOADSKILLS,          "SELECT skill, value, max FROM character_skills WHERE guid = '{}'", m_guid.GetCounter());

    uint32 count = 0;
    std::unordered_map<uint32, uint32> loadedSkillValues;
    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            uint16 skill    = fields[0].Get<uint16>();
            uint16 value    = fields[1].Get<uint16>();
            uint16 max      = fields[2].Get<uint16>();

            SkillRaceClassInfoEntry const* rcEntry = GetSkillRaceClassInfo(skill, getRace(), getClass());
            if (!rcEntry)
            {
                LOG_ERROR("entities.player", "Character {} has skill {} that does not exist.", GetGUID().ToString(), skill);
                continue;
            }

            // set fixed skill ranges
            switch (GetSkillRangeType(rcEntry))
            {
                case SKILL_RANGE_LANGUAGE:                      // 300..300
                    value = max = 300;
                    break;
                case SKILL_RANGE_MONO:                          // 1..1, grey monolite bar
                    value = max = 1;
                    break;
                case SKILL_RANGE_LEVEL:
                    max = GetMaxSkillValueForLevel();
                default:
                    break;
            }

            if (value == 0)
            {
                LOG_ERROR("entities.player", "Character {} has skill {} with value 0. Will be deleted.", GetGUID().ToString(), skill);

                CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHARACTER_SKILL);

                stmt->SetData(0, GetGUID().GetCounter());
                stmt->SetData(1, skill);

                CharacterDatabase.Execute(stmt);

                continue;
            }

            uint16 skillStep = 0;
            if (SkillTiersEntry const* skillTier = sSkillTiersStore.LookupEntry(rcEntry->SkillTierID))
            {
                for (uint32 i = 0; i < MAX_SKILL_STEP; ++i)
                {
                    if (skillTier->Value[skillStep] == max)
                    {
                        skillStep = i + 1;
                        break;
                    }
                }
            }

            SetUInt32Value(PLAYER_SKILL_INDEX(count), MAKE_PAIR32(skill, skillStep));

            SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(count), MAKE_SKILL_VALUE(value, max));
            SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(count), 0);

            mSkillStatus.insert(SkillStatusMap::value_type(skill, SkillStatusData(count, SKILL_UNCHANGED)));

            loadedSkillValues[skill] = value;

            ++count;

            if (count >= PLAYER_MAX_SKILLS)                      // client limit
            {
                LOG_ERROR("entities.player", "Character {} has more than {} skills.", GetGUID().ToString(), PLAYER_MAX_SKILLS);
                break;
            }
        } while (result->NextRow());
    }

    // Learn skill rewarded spells after all skills have been loaded to prevent learning a skill from them before its loaded with proper value from DB
    for (auto& skill : loadedSkillValues)
    {
        learnSkillRewardedSpells(skill.first, skill.second);
    }

    for (; count < PLAYER_MAX_SKILLS; ++count)
    {
        SetUInt32Value(PLAYER_SKILL_INDEX(count), 0);
        SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(count), 0);
        SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(count), 0);
    }
}

uint32 Player::GetPhaseMaskForSpawn() const
{
    uint32 phase = IsGameMaster() ? GetPhaseByAuras() : GetPhaseMask();

    if (!phase)
        phase = PHASEMASK_NORMAL;

    // some aura phases include 1 normal map in addition to phase itself
    uint32 n_phase = phase & ~PHASEMASK_NORMAL;
    if (n_phase > 0)
        return n_phase;

    return phase;
}

InventoryResult Player::CanEquipUniqueItem(Item* pItem, uint8 eslot, uint32 limit_count) const
{
    ItemTemplate const* pProto = pItem->GetTemplate();

    // proto based limitations
    if (InventoryResult res = CanEquipUniqueItem(pProto, eslot, limit_count))
        return res;

    // check unique-equipped on gems
    for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT + 3; ++enchant_slot)
    {
        uint32 enchant_id = pItem->GetEnchantmentId(EnchantmentSlot(enchant_slot));
        if (!enchant_id)
            continue;
        SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
        if (!enchantEntry)
            continue;

        ItemTemplate const* pGem = sObjectMgr->GetItemTemplate(enchantEntry->GemID);
        if (!pGem)
            continue;

        // include for check equip another gems with same limit category for not equipped item (and then not counted)
        uint32 gem_limit_count = !pItem->IsEquipped() && pGem->ItemLimitCategory
                                 ? pItem->GetGemCountWithLimitCategory(pGem->ItemLimitCategory) : 1;

        if (InventoryResult res = CanEquipUniqueItem(pGem, eslot, gem_limit_count))
            return res;
    }

    return EQUIP_ERR_OK;
}

InventoryResult Player::CanEquipUniqueItem(ItemTemplate const* itemProto, uint8 except_slot, uint32 limit_count) const
{
    // check unique-equipped on item
    if (itemProto->HasFlag(ITEM_FLAG_UNIQUE_EQUIPPABLE))
    {
        // there is an equip limit on this item
        if (HasItemOrGemWithIdEquipped(itemProto->ItemId, 1, except_slot))
            return EQUIP_ERR_ITEM_UNIQUE_EQUIPABLE;
    }

    // check unique-equipped limit
    if (itemProto->ItemLimitCategory)
    {
        ItemLimitCategoryEntry const* limitEntry = sItemLimitCategoryStore.LookupEntry(itemProto->ItemLimitCategory);
        if (!limitEntry)
            return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;

        // NOTE: limitEntry->mode not checked because if item have have-limit then it applied and to equip case

        if (limit_count > limitEntry->maxCount)
            return EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_EQUIPPED_EXCEEDED;

        // there is an equip limit on this item
        if (HasItemOrGemWithLimitCategoryEquipped(itemProto->ItemLimitCategory, limitEntry->maxCount - limit_count + 1, except_slot))
            return EQUIP_ERR_ITEM_MAX_COUNT_EQUIPPED_SOCKETED;
    }

    return EQUIP_ERR_OK;
}

void Player::HandleFall(MovementInfo const& movementInfo)
{
    // calculate total z distance of the fall
    float z_diff = m_lastFallZ - movementInfo.pos.GetPositionZ();

    //Players with low fall distance, Feather Fall or physical immunity (charges used) are ignored
    // 14.57 can be calculated by resolving damageperc formula below to 0
    if (z_diff >= 14.57f && !isDead() && !IsGameMaster() && !GetCommandStatus(CHEAT_GOD) &&
            !HasAuraType(SPELL_AURA_HOVER) && !HasAuraType(SPELL_AURA_FEATHER_FALL) &&
            !HasAuraType(SPELL_AURA_FLY))
    {
        //Safe fall, fall height reduction
        int32 safe_fall = GetTotalAuraModifier(SPELL_AURA_SAFE_FALL);

        float damageperc = 0.018f * (z_diff - safe_fall) - 0.2426f;
        uint32 original_health = GetHealth(), final_damage = 0;

        if (damageperc > 0 && !IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_NORMAL))
        {
            uint32 damage = (uint32)(damageperc * GetMaxHealth() * sWorld->getRate(RATE_DAMAGE_FALL));

            //float height = movementInfo.pos.m_positionZ;
            //UpdateGroundPositionZ(movementInfo.pos.m_positionX, movementInfo.pos.m_positionY, height);

            if (damage > 0)
            {
                //Prevent fall damage from being more than the player maximum health
                if (damage > GetMaxHealth())
                    damage = GetMaxHealth();

                // Gust of Wind
                if (HasAura(43621))
                    damage = GetMaxHealth() / 2;

                // Divine Protection
                if (HasAura(498))
                {
                    damage /= 2;
                }

                final_damage = EnvironmentalDamage(DAMAGE_FALL, damage);
            }

            //Z given by moveinfo, LastZ, FallTime, WaterZ, MapZ, Damage, Safefall reduction
            LOG_DEBUG("entities.player", "FALLDAMAGE mZ={} z={} fallTime={} damage={} SF={}", movementInfo.pos.GetPositionZ(), GetPositionZ(), movementInfo.fallTime, damage, safe_fall);
        }

        // recheck alive, might have died of EnvironmentalDamage, avoid cases when player die in fact like Spirit of Redemption case
        if (IsAlive() && final_damage < original_health)
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_FALL_WITHOUT_DYING, uint32(z_diff * 100));
    }
}

void Player::CheckAllAchievementCriteria()
{
    m_achievementMgr->CheckAllAchievementCriteria();
}

void Player::ResetAchievements()
{
    m_achievementMgr->Reset();
}

void Player::SendRespondInspectAchievements(Player* player) const
{
    m_achievementMgr->SendRespondInspectAchievements(player);
}

bool Player::HasAchieved(uint32 achievementId) const
{
    return m_achievementMgr->HasAchieved(achievementId);
}

void Player::StartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry, uint32 timeLost/* = 0*/)
{
    m_achievementMgr->StartTimedAchievement(type, entry, timeLost);
}

void Player::RemoveTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry)
{
    m_achievementMgr->RemoveTimedAchievement(type, entry);
}

void Player::ResetAchievementCriteria(AchievementCriteriaCondition condition, uint32 value, bool evenIfCriteriaComplete /* = false*/)
{
    m_achievementMgr->ResetAchievementCriteria(condition, value, evenIfCriteriaComplete);
}

void Player::CompletedAchievement(AchievementEntry const* entry)
{
    m_achievementMgr->CompletedAchievement(entry);
}

void Player::LearnTalent(uint32 talentId, uint32 talentRank, bool command /*= false*/)
{
    uint32 CurTalentPoints = GetFreeTalentPoints();

    if (!command)
    {
        // xinef: check basic data
        if (!CurTalentPoints)
        {
            return;
        }

        if (talentRank >= MAX_TALENT_RANK)
        {
            return;
        }
    }

    TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentId);
    if (!talentInfo)
        return;

    TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);
    if (!talentTabInfo)
        return;

    // xinef: prevent learn talent for different class (cheating)
    if ((getClassMask() & talentTabInfo->ClassMask) == 0)
        return;

    // xinef: find current talent rank
    uint32 currentTalentRank = 0;
    for (uint8 rank = 0; rank < MAX_TALENT_RANK; ++rank)
    {
        if (talentInfo->RankID[rank] && HasTalent(talentInfo->RankID[rank], GetActiveSpec()))
        {
            currentTalentRank = rank + 1;
            break;
        }
    }

    // xinef: we already have same or higher rank talent learned
    if (currentTalentRank >= talentRank + 1)
        return;

    uint32 talentPointsChange = (talentRank - currentTalentRank + 1);
    if (!command)
    {
        // xinef: check if we have enough free talent points
        if (CurTalentPoints < talentPointsChange)
        {
            return;
        }
    }

    // xinef: check if talent deponds on another talent
    if (talentInfo->DependsOn > 0)
        if (TalentEntry const* depTalentInfo = sTalentStore.LookupEntry(talentInfo->DependsOn))
        {
            bool hasEnoughRank = false;
            for (uint8 rank = talentInfo->DependsOnRank; rank < MAX_TALENT_RANK; rank++)
            {
                if (depTalentInfo->RankID[rank] != 0)
                    if (HasTalent(depTalentInfo->RankID[rank], GetActiveSpec()))
                    {
                        hasEnoughRank = true;
                        break;
                    }
            }

            // xinef: does not have enough talent points spend in required talent
            if (!hasEnoughRank)
                return;
        }

    if (!command)
    {
        // xinef: check amount of points spent in current talent tree
        // xinef: be smart and quick
        uint32 spentPoints = 0;
        if (talentInfo->Row > 0)
        {
            const PlayerTalentMap& talentMap = GetTalentMap();
            for (PlayerTalentMap::const_iterator itr = talentMap.begin(); itr != talentMap.end(); ++itr)
                if (TalentSpellPos const* talentPos = GetTalentSpellPos(itr->first))
                    if (TalentEntry const* itrTalentInfo = sTalentStore.LookupEntry(talentPos->talent_id))
                        if (itrTalentInfo->TalentTab == talentInfo->TalentTab)
                            if (itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(GetActiveSpec())) // pussywizard
                                spentPoints += talentPos->rank + 1;
        }

        // xinef: we do not have enough talent points to add talent of this tier
        if (spentPoints < (talentInfo->Row * MAX_TALENT_RANK))
            return;
    }

    // xinef: hacking attempt, tries to learn unknown rank
    uint32 spellId = talentInfo->RankID[talentRank];
    if (spellId == 0)
        return;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
        return;

    bool learned = false;

    // xinef: if talent info has special marker in dbc - add to spell book
    if (talentInfo->addToSpellBook)
        if (!spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
        {
            learnSpell(spellId);
            learned = true;
        }

    if (!learned)
        SendLearnPacket(spellId, true);

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL)
            if (sSpellMgr->IsAdditionalTalentSpell(spellInfo->Effects[i].TriggerSpell))
                learnSpell(spellInfo->Effects[i].TriggerSpell);

    addTalent(spellId, GetActiveSpecMask(), currentTalentRank);

    // xinef: update free talent points count
    m_usedTalentCount += talentPointsChange;

    if (!command)
    {
        SetFreeTalentPoints(CurTalentPoints - talentPointsChange);
    }

    sScriptMgr->OnPlayerLearnTalents(this, talentId, talentRank, spellId);
}

void Player::LearnPetTalent(ObjectGuid petGuid, uint32 talentId, uint32 talentRank)
{
    Pet* pet = GetPet();

    if (!pet)
        return;

    if (petGuid != pet->GetGUID())
        return;

    uint32 CurTalentPoints = pet->GetFreeTalentPoints();

    if (CurTalentPoints == 0)
        return;

    if (talentRank >= MAX_PET_TALENT_RANK)
        return;

    TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentId);

    if (!talentInfo)
        return;

    TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);

    if (!talentTabInfo)
        return;

    CreatureTemplate const* ci = pet->GetCreatureTemplate();

    if (!ci)
        return;

    CreatureFamilyEntry const* pet_family = sCreatureFamilyStore.LookupEntry(ci->family);

    if (!pet_family)
        return;

    if (pet_family->petTalentType < 0)                       // not hunter pet
        return;

    // prevent learn talent for different family (cheating)
    if (!((1 << pet_family->petTalentType) & talentTabInfo->petTalentMask))
        return;

    // find current max talent rank (0~5)
    uint8 curtalent_maxrank = 0; // 0 = not learned any rank
    for (int8 rank = MAX_TALENT_RANK - 1; rank >= 0; --rank)
    {
        if (talentInfo->RankID[rank] && pet->HasSpell(talentInfo->RankID[rank]))
        {
            curtalent_maxrank = (rank + 1);
            break;
        }
    }

    // we already have same or higher talent rank learned
    if (curtalent_maxrank >= (talentRank + 1))
        return;

    // check if we have enough talent points
    if (CurTalentPoints < (talentRank - curtalent_maxrank + 1))
        return;

    // Check if it requires another talent
    if (talentInfo->DependsOn > 0)
    {
        if (TalentEntry const* depTalentInfo = sTalentStore.LookupEntry(talentInfo->DependsOn))
        {
            bool hasEnoughRank = false;
            for (uint8 rank = talentInfo->DependsOnRank; rank < MAX_TALENT_RANK; rank++)
            {
                if (depTalentInfo->RankID[rank] != 0)
                    if (pet->HasSpell(depTalentInfo->RankID[rank]))
                        hasEnoughRank = true;
            }
            if (!hasEnoughRank)
                return;
        }
    }

    // Find out how many points we have in this field
    uint32 spentPoints = 0;

    uint32 tTab = talentInfo->TalentTab;
    if (talentInfo->Row > 0)
    {
        uint32 numRows = sTalentStore.GetNumRows();
        for (uint32 i = 0; i < numRows; ++i)          // Loop through all talents.
        {
            // Someday, someone needs to revamp
            const TalentEntry* tmpTalent = sTalentStore.LookupEntry(i);
            if (tmpTalent)                                  // the way talents are tracked
            {
                if (tmpTalent->TalentTab == tTab)
                {
                    for (uint8 rank = 0; rank < MAX_TALENT_RANK; rank++)
                    {
                        if (tmpTalent->RankID[rank] != 0)
                        {
                            if (pet->HasSpell(tmpTalent->RankID[rank]))
                            {
                                spentPoints += (rank + 1);
                            }
                        }
                    }
                }
            }
        }
    }

    // not have required min points spent in talent tree
    if (spentPoints < (talentInfo->Row * MAX_PET_TALENT_RANK))
        return;

    // spell not set in talent.dbc
    uint32 spellid = talentInfo->RankID[talentRank];
    if (spellid == 0)
    {
        LOG_ERROR("entities.player", "Talent.dbc have for talent: {} Rank: {} spell id = 0", talentId, talentRank);
        return;
    }

    // already known
    if (pet->HasSpell(spellid))
        return;

    // learn! (other talent ranks will unlearned at learning)
    pet->learnSpell(spellid);
    LOG_DEBUG("entities.player", "PetTalentID: {} Rank: {} Spell: {}\n", talentId, talentRank, spellid);

    // update free talent points
    pet->SetFreeTalentPoints(CurTalentPoints - (talentRank - curtalent_maxrank + 1));
}

void Player::AddKnownCurrency(uint32 itemId)
{
    if (CurrencyTypesEntry const* ctEntry = sCurrencyTypesStore.LookupEntry(itemId))
        SetFlag64(PLAYER_FIELD_KNOWN_CURRENCIES, (1LL << (ctEntry->BitIndex - 1)));
}

void Player::UnsummonPetTemporaryIfAny()
{
    Pet* pet = GetPet();
    if (!pet)
        return;

    if (!m_temporaryUnsummonedPetNumber && pet->isControlled() && !pet->isTemporarySummoned())
    {
        m_temporaryUnsummonedPetNumber = pet->GetCharmInfo()->GetPetNumber();
        SetLastPetSpell(pet->GetUInt32Value(UNIT_CREATED_BY_SPELL));
    }

    RemovePet(pet, PET_SAVE_AS_CURRENT);
}

void Player::ResummonPetTemporaryUnSummonedIfAny()
{
    if (!m_temporaryUnsummonedPetNumber || IsSpectator())
        return;

    // not resummon in not appropriate state
    if (IsPetNeedBeTemporaryUnsummoned())
        return;

    if (GetPetGUID())
        return;

    if (!CanResummonPet(GetLastPetSpell()))
        return;

    Pet* newPet = new Pet(this);
    if (!newPet->LoadPetFromDB(this, 0, m_temporaryUnsummonedPetNumber, true))
        delete newPet;

    m_temporaryUnsummonedPetNumber = 0;
}

bool Player::CanResummonPet(uint32 spellid)
{
    if (IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_PET))
    {
        if (CanSeeDKPet())
            return true;
        else if (spellid == 52150) // Raise Dead
            return false;
    }

    if (IsClass(CLASS_MAGE, CLASS_CONTEXT_PET))
    {
        if (HasSpell(31687) && HasAura(70937))  //Has [Summon Water Elemental] spell and [Glyph of Eternal Water].
            return true;
    }

    if (IsClass(CLASS_HUNTER, CLASS_CONTEXT_PET))
    {
        return true;
    }

    return HasSpell(spellid);
}

bool Player::CanSeeSpellClickOn(Creature const* c) const
{
    if (!c->HasNpcFlag(UNIT_NPC_FLAG_SPELLCLICK))
        return false;

    SpellClickInfoMapBounds clickPair = sObjectMgr->GetSpellClickInfoMapBounds(c->GetEntry());
    if (clickPair.first == clickPair.second)
        return true;

    for (SpellClickInfoContainer::const_iterator itr = clickPair.first; itr != clickPair.second; ++itr)
    {
        if (!itr->second.IsFitToRequirements(this, c))
            return false;

        ConditionList conds = sConditionMgr->GetConditionsForSpellClickEvent(c->GetEntry(), itr->second.spellId);
        ConditionSourceInfo info = ConditionSourceInfo(const_cast<Player*>(this), const_cast<Creature*>(c));
        if (sConditionMgr->IsObjectMeetToConditions(info, conds))
            return true;
    }

    return false;
}

bool Player::CanSeeVendor(Creature const* creature) const
{
    if (!creature->HasNpcFlag(UNIT_NPC_FLAG_VENDOR))
        return true;

    ConditionList conditions = sConditionMgr->GetConditionsForNpcVendorEvent(creature->GetEntry(), 0);
    if (!sConditionMgr->IsObjectMeetToConditions(const_cast<Player*>(this), const_cast<Creature*>(creature), conditions))
    {
        return false;
    }

    return true;
}

void Player::BuildPlayerTalentsInfoData(WorldPacket* data)
{
    *data << uint32(GetFreeTalentPoints());                 // unspentTalentPoints
    *data << uint8(m_specsCount);                           // talent group count (0, 1 or 2)
    *data << uint8(m_activeSpec);                           // talent group index (0 or 1)

    if (m_specsCount > MAX_TALENT_SPECS)
        m_specsCount = MAX_TALENT_SPECS;

    for (uint32 specIdx = 0; specIdx < m_specsCount; ++specIdx)
    {
        uint8 talentIdCount = 0;
        std::size_t pos = data->wpos();
        *data << uint8(talentIdCount);                      // [PH], talentIdCount

        const PlayerTalentMap& talentMap = GetTalentMap();
        for (PlayerTalentMap::const_iterator itr = talentMap.begin(); itr != talentMap.end(); ++itr)
            if (TalentSpellPos const* talentPos = GetTalentSpellPos(itr->first))
                if (itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(specIdx)) // pussywizard
                {
                    *data << uint32(talentPos->talent_id);  // Talent.dbc
                    *data << uint8(talentPos->rank);        // talentMaxRank (0-4)
                    ++talentIdCount;
                }

        data->put<uint8>(pos, talentIdCount);               // put real count

        *data << uint8(MAX_GLYPH_SLOT_INDEX);               // glyphs count

        for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
            *data << uint16(m_Glyphs[specIdx][i]);          // GlyphProperties.dbc
    }
}

void Player::BuildPetTalentsInfoData(WorldPacket* data)
{
    uint32 unspentTalentPoints = 0;
    std::size_t pointsPos = data->wpos();
    *data << uint32(unspentTalentPoints);                   // [PH], unspentTalentPoints

    uint8 talentIdCount = 0;
    std::size_t countPos = data->wpos();
    *data << uint8(talentIdCount);                          // [PH], talentIdCount

    Pet* pet = GetPet();
    if (!pet)
        return;

    unspentTalentPoints = pet->GetFreeTalentPoints();

    data->put<uint32>(pointsPos, unspentTalentPoints);      // put real points

    CreatureTemplate const* ci = pet->GetCreatureTemplate();
    if (!ci)
        return;

    CreatureFamilyEntry const* pet_family = sCreatureFamilyStore.LookupEntry(ci->family);
    if (!pet_family || pet_family->petTalentType < 0)
        return;

    for (uint32 talentTabId = 1; talentTabId < sTalentTabStore.GetNumRows(); ++talentTabId)
    {
        TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentTabId);
        if (!talentTabInfo)
            continue;

        if (!((1 << pet_family->petTalentType) & talentTabInfo->petTalentMask))
            continue;

        for (uint32 talentId = 0; talentId < sTalentStore.GetNumRows(); ++talentId)
        {
            TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentId);
            if (!talentInfo)
                continue;

            // skip another tab talents
            if (talentInfo->TalentTab != talentTabId)
                continue;

            // find max talent rank (0~4)
            int8 curtalent_maxrank = -1;
            for (int8 rank = MAX_TALENT_RANK - 1; rank >= 0; --rank)
            {
                if (talentInfo->RankID[rank] && pet->HasSpell(talentInfo->RankID[rank]))
                {
                    curtalent_maxrank = rank;
                    break;
                }
            }

            // not learned talent
            if (curtalent_maxrank < 0)
                continue;

            *data << uint32(talentInfo->TalentID);          // Talent.dbc
            *data << uint8(curtalent_maxrank);              // talentMaxRank (0-4)

            ++talentIdCount;
        }

        data->put<uint8>(countPos, talentIdCount);          // put real count

        break;
    }
}

void Player::SendTalentsInfoData(bool pet)
{
    WorldPacket data(SMSG_TALENTS_INFO, 50);
    data << uint8(pet ? 1 : 0);
    if (pet)
        BuildPetTalentsInfoData(&data);
    else
        BuildPlayerTalentsInfoData(&data);
    GetSession()->SendPacket(&data);
}

void Player::BuildEnchantmentsInfoData(WorldPacket* data)
{
    uint32 slotUsedMask = 0;
    std::size_t slotUsedMaskPos = data->wpos();
    *data << uint32(slotUsedMask);                          // slotUsedMask < 0x80000

    for (uint32 i = 0; i < EQUIPMENT_SLOT_END; ++i)
    {
        Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i);

        if (!item)
            continue;

        slotUsedMask |= (1 << i);

        *data << uint32(item->GetEntry());                  // item entry

        uint16 enchantmentMask = 0;
        std::size_t enchantmentMaskPos = data->wpos();
        *data << uint16(enchantmentMask);                   // enchantmentMask < 0x1000

        for (uint32 j = 0; j < MAX_ENCHANTMENT_SLOT; ++j)
        {
            uint32 enchId = item->GetEnchantmentId(EnchantmentSlot(j));

            if (!enchId)
                continue;

            enchantmentMask |= (1 << j);

            *data << uint16(enchId);                        // enchantmentId?
        }

        data->put<uint16>(enchantmentMaskPos, enchantmentMask);

        *data << int16(item->GetItemRandomPropertyId());                    // item random property id
        *data << item->GetGuidValue(ITEM_FIELD_CREATOR).WriteAsPacked();    // item creator
        *data << uint32(item->GetItemSuffixFactor());                       // item suffix factor
    }

    data->put<uint32>(slotUsedMaskPos, slotUsedMask);
}

void Player::SendEquipmentSetList()
{
    uint32 count = 0;
    WorldPacket data(SMSG_EQUIPMENT_SET_LIST, 4);
    std::size_t count_pos = data.wpos();
    data << uint32(count);                                  // count placeholder
    for (EquipmentSets::iterator itr = m_EquipmentSets.begin(); itr != m_EquipmentSets.end(); ++itr)
    {
        if (itr->second.state == EQUIPMENT_SET_DELETED)
            continue;

        data.appendPackGUID(itr->second.Guid);
        data << uint32(itr->first);
        data << itr->second.Name;
        data << itr->second.IconName;
        for (uint32 i = 0; i < EQUIPMENT_SLOT_END; ++i)
        {
            // ignored slots stored in IgnoreMask, client wants "1" as raw GUID, so no HighGuid::Item
            if (itr->second.IgnoreMask & (1 << i))
                data.appendPackGUID(uint64(1));
            else // xinef: send proper data (do not append 0 with high guid)
                data.appendPackGUID(itr->second.Items[i] ? itr->second.Items[i].GetRawValue() : uint64(0));
        }

        ++count;                                            // client have limit but it checked at loading and set
    }
    data.put<uint32>(count_pos, count);
    GetSession()->SendPacket(&data);
}

void Player::SetEquipmentSet(uint32 index, EquipmentSet eqset)
{
    if (eqset.Guid != 0)
    {
        bool found = false;

        for (EquipmentSets::iterator itr = m_EquipmentSets.begin(); itr != m_EquipmentSets.end(); ++itr)
        {
            if ((itr->second.Guid == eqset.Guid) && (itr->first == index))
            {
                found = true;
                break;
            }
        }

        if (!found)                                          // something wrong...
        {
            LOG_ERROR("entities.player", "Player {} tried to save equipment set {} (index {}), but that equipment set not found!", GetName(), eqset.Guid, index);
            return;
        }
    }

    EquipmentSet& eqslot = m_EquipmentSets[index];

    EquipmentSetUpdateState old_state = eqslot.state;

    eqslot = eqset;

    if (eqset.Guid == 0)
    {
        eqslot.Guid = sObjectMgr->GenerateEquipmentSetGuid();

        WorldPacket data(SMSG_EQUIPMENT_SET_SAVED, 4 + 1);
        data << uint32(index);
        data.appendPackGUID(eqslot.Guid);
        GetSession()->SendPacket(&data);
    }

    eqslot.state = old_state == EQUIPMENT_SET_NEW ? EQUIPMENT_SET_NEW : EQUIPMENT_SET_CHANGED;
}

void Player::_SaveEquipmentSets(CharacterDatabaseTransaction trans)
{
    for (EquipmentSets::iterator itr = m_EquipmentSets.begin(); itr != m_EquipmentSets.end();)
    {
        uint32 index = itr->first;
        EquipmentSet& eqset = itr->second;
        CharacterDatabasePreparedStatement* stmt = nullptr;
        uint8 j = 0;
        switch (eqset.state)
        {
            case EQUIPMENT_SET_UNCHANGED:
                ++itr;
                break;                                      // nothing do
            case EQUIPMENT_SET_CHANGED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_EQUIP_SET);
                stmt->SetData(j++, eqset.Name.c_str());
                stmt->SetData(j++, eqset.IconName.c_str());
                stmt->SetData(j++, eqset.IgnoreMask);
                for (uint8 i = 0; i < EQUIPMENT_SLOT_END; ++i)
                    stmt->SetData(j++, eqset.Items[i].GetCounter());
                stmt->SetData(j++, GetGUID().GetCounter());
                stmt->SetData(j++, eqset.Guid);
                stmt->SetData(j, index);
                trans->Append(stmt);
                eqset.state = EQUIPMENT_SET_UNCHANGED;
                ++itr;
                break;
            case EQUIPMENT_SET_NEW:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_EQUIP_SET);
                stmt->SetData(j++, GetGUID().GetCounter());
                stmt->SetData(j++, eqset.Guid);
                stmt->SetData(j++, index);
                stmt->SetData(j++, eqset.Name.c_str());
                stmt->SetData(j++, eqset.IconName.c_str());
                stmt->SetData(j++, eqset.IgnoreMask);
                for (uint8 i = 0; i < EQUIPMENT_SLOT_END; ++i)
                    stmt->SetData(j++, eqset.Items[i].GetCounter());
                trans->Append(stmt);
                eqset.state = EQUIPMENT_SET_UNCHANGED;
                ++itr;
                break;
            case EQUIPMENT_SET_DELETED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_EQUIP_SET);
                stmt->SetData(0, eqset.Guid);
                trans->Append(stmt);
                m_EquipmentSets.erase(itr++);
                break;
        }
    }
}

void Player::_SaveEntryPoint(CharacterDatabaseTransaction trans)
{
    // xinef: dont save joinpos with invalid mapid
    MapEntry const* mEntry = sMapStore.LookupEntry(m_entryPointData.joinPos.GetMapId());
    if (!mEntry)
        return;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_ENTRY_POINT);
    stmt->SetData(0, GetGUID().GetCounter());
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PLAYER_ENTRY_POINT);
    stmt->SetData(0, GetGUID().GetCounter());
    stmt->SetData (1, m_entryPointData.joinPos.GetPositionX());
    stmt->SetData (2, m_entryPointData.joinPos.GetPositionY());
    stmt->SetData (3, m_entryPointData.joinPos.GetPositionZ());
    stmt->SetData (4, m_entryPointData.joinPos.GetOrientation());
    stmt->SetData(5, m_entryPointData.joinPos.GetMapId());
    stmt->SetData(6, m_entryPointData.taxiPath[0]);
    stmt->SetData(7, m_entryPointData.taxiPath[1]);
    stmt->SetData(8, m_entryPointData.mountSpell);
    trans->Append(stmt);
}

void Player::DeleteEquipmentSet(uint64 setGuid)
{
    for (EquipmentSets::iterator itr = m_EquipmentSets.begin(); itr != m_EquipmentSets.end(); ++itr)
    {
        if (itr->second.Guid == setGuid)
        {
            if (itr->second.state == EQUIPMENT_SET_NEW)
                m_EquipmentSets.erase(itr);
            else
                itr->second.state = EQUIPMENT_SET_DELETED;
            break;
        }
    }
}

void Player::RemoveAtLoginFlag(AtLoginFlags flags, bool persist /*= false*/)
{
    m_atLoginFlags &= ~flags;

    if (persist)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_REM_AT_LOGIN_FLAG);

        stmt->SetData(0, uint16(flags));
        stmt->SetData(1, GetGUID().GetCounter());

        CharacterDatabase.Execute(stmt);
    }
}

void Player::SendClearCooldown(uint32 spell_id, Unit* target)
{
    WorldPacket data(SMSG_CLEAR_COOLDOWN, 4 + 8);
    data << uint32(spell_id);
    data << target->GetGUID();
    SendDirectMessage(&data);

    if (target == this && NeedSendSpectatorData())
        ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "RCD", spell_id);
}

void Player::ResetMap()
{
    // this may be called during Map::Update
    // after decrement+unlink, ++m_mapRefIter will continue correctly
    // when the first element of the list is being removed
    // nocheck_prev will return the padding element of the RefMgr
    // instead of nullptr in the case of prev
    GetMap()->UpdateIteratorBack(this);
    Unit::ResetMap();
    GetMapRef().unlink();
}

void Player::SetMap(Map* map)
{
    Unit::SetMap(map);
    m_mapRef.link(map, this);
}

void Player::_SaveCharacter(bool create, CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = nullptr;
    uint8 index = 0;

    auto finiteAlways = [](float f) { return std::isfinite(f) ? f : 0.0f; };

    if (create)
    {
        //! Insert query
        //! TO DO: Filter out more redundant fields that can take their default value at player create
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER);
        stmt->SetData(index++, GetGUID().GetCounter());
        stmt->SetData(index++, GetSession()->GetAccountId());
        stmt->SetData(index++, GetName());
        stmt->SetData(index++, getRace(true));
        stmt->SetData(index++, getClass());
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES_3, 0));   // save gender from PLAYER_BYTES_3, UNIT_BYTES_0 changes with every transform effect
        stmt->SetData(index++, GetLevel());
        stmt->SetData(index++, GetUInt32Value(PLAYER_XP));
        stmt->SetData(index++, GetMoney());
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES, 0));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES, 1));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES, 2));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES, 3));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES_2, 0));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES_2, 2));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES_2, 3));
        stmt->SetData(index++, (uint32)GetPlayerFlags());
        stmt->SetData(index++, (uint16)GetMapId());
        stmt->SetData(index++, (uint32)GetInstanceId());
        stmt->SetData(index++, (uint8(GetDungeonDifficulty()) | uint8(GetRaidDifficulty()) << 4));
        stmt->SetData(index++, finiteAlways(GetPositionX()));
        stmt->SetData(index++, finiteAlways(GetPositionY()));
        stmt->SetData(index++, finiteAlways(GetPositionZ()));
        stmt->SetData(index++, finiteAlways(GetOrientation()));
        stmt->SetData(index++, finiteAlways(GetTransOffsetX()));
        stmt->SetData(index++, finiteAlways(GetTransOffsetY()));
        stmt->SetData(index++, finiteAlways(GetTransOffsetZ()));
        stmt->SetData(index++, finiteAlways(GetTransOffsetO()));

        int32 lowGuidOrSpawnId = 0;
        if (Transport* transport = GetTransport())
        {
            if (transport->IsMotionTransport())
                lowGuidOrSpawnId = static_cast<int32>(transport->GetGUID().GetCounter());
            else if (transport->IsStaticTransport())
                lowGuidOrSpawnId = -static_cast<int32>(transport->GetSpawnId());
        }
        stmt->SetData(index++, lowGuidOrSpawnId);

        std::ostringstream ss;
        ss << m_taxi;
        stmt->SetData(index++, ss.str());
        stmt->SetData(index++, m_cinematic);
        stmt->SetData(index++, m_Played_time[PLAYED_TIME_TOTAL]);
        stmt->SetData(index++, m_Played_time[PLAYED_TIME_LEVEL]);
        stmt->SetData(index++, finiteAlways(_restBonus));
        stmt->SetData(index++, uint32(GameTime::GetGameTime().count()));
        stmt->SetData(index++,  (HasPlayerFlag(PLAYER_FLAGS_RESTING) ? 1 : 0));
        //save, far from tavern/city
        //save, but in tavern/city
        stmt->SetData(index++, m_resetTalentsCost);
        stmt->SetData(index++, uint32(m_resetTalentsTime));
        stmt->SetData(index++, (uint16)m_ExtraFlags);
        stmt->SetData(index++, m_petStable ? m_petStable->MaxStabledPets : 0);
        stmt->SetData(index++, (uint16)m_atLoginFlags);
        stmt->SetData(index++, GetZoneId());
        stmt->SetData(index++, uint32(m_deathExpireTime));

        ss.str("");
        ss << m_taxi.SaveTaxiDestinationsToString();

        stmt->SetData(index++, ss.str());
        stmt->SetData(index++, GetArenaPoints());
        stmt->SetData(index++, GetHonorPoints());
        stmt->SetData(index++, GetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION));
        stmt->SetData(index++, GetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION));
        stmt->SetData(index++, GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS));
        stmt->SetData(index++, GetUInt16Value(PLAYER_FIELD_KILLS, 0));
        stmt->SetData(index++, GetUInt16Value(PLAYER_FIELD_KILLS, 1));
        stmt->SetData(index++, GetUInt32Value(PLAYER_CHOSEN_TITLE));
        stmt->SetData(index++, GetUInt64Value(PLAYER_FIELD_KNOWN_CURRENCIES));
        stmt->SetData(index++, GetUInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX));
        stmt->SetData(index++, GetDrunkValue());
        stmt->SetData(index++, GetHealth());

        for (uint32 i = 0; i < MAX_POWERS; ++i)
            stmt->SetData(index++, GetPower(Powers(i)));

        stmt->SetData(index++, GetSession()->GetLatency());

        stmt->SetData(index++, m_specsCount);
        stmt->SetData(index++, m_activeSpec);

        ss.str("");
        for (uint32 i = 0; i < PLAYER_EXPLORED_ZONES_SIZE; ++i)
            ss << GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + i) << ' ';
        stmt->SetData(index++, ss.str());

        ss.str("");
        // cache equipment...
        for (uint32 i = 0; i < EQUIPMENT_SLOT_END * 2; ++i)
            ss << GetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + i) << ' ';

        // ...and bags for enum opcode
        for (uint32 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        {
            if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                ss << item->GetEntry();
            else
                ss << '0';
            ss << " 0 ";
        }

        stmt->SetData(index++, ss.str());
        stmt->SetData(index++, GetUInt32Value(PLAYER_AMMO_ID));

        ss.str("");
        for (uint32 i = 0; i < KNOWN_TITLES_SIZE * 2; ++i)
            ss << GetUInt32Value(PLAYER__FIELD_KNOWN_TITLES + i) << ' ';

        stmt->SetData(index++, ss.str());
        stmt->SetData(index++, GetByteValue(PLAYER_FIELD_BYTES, 2));
        stmt->SetData(index++, m_grantableLevels);
        stmt->SetData(index++, _innTriggerId);
        stmt->SetData(index++, m_extraBonusTalentCount);
    }
    else
    {
        // Update query
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER);
        stmt->SetData(index++, GetName());
        stmt->SetData(index++, getRace(true));
        stmt->SetData(index++, getClass());
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES_3, 0));   // save gender from PLAYER_BYTES_3, UNIT_BYTES_0 changes with every transform effect
        stmt->SetData(index++, GetLevel());
        stmt->SetData(index++, GetUInt32Value(PLAYER_XP));
        stmt->SetData(index++, GetMoney());
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES, 0));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES, 1));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES, 2));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES, 3));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES_2, 0));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES_2, 2));
        stmt->SetData(index++, GetByteValue(PLAYER_BYTES_2, 3));
        stmt->SetData(index++, GetPlayerFlags());

        if (!IsBeingTeleported())
        {
            Difficulty dd = GetDungeonDifficulty(), rd = GetRaidDifficulty();
            if (Map* m = FindMap())
                if (m->IsDungeon())
                {
                    if (m->IsNonRaidDungeon()) dd = m->GetDifficulty();
                    else rd = m->GetDifficulty();
                }
            stmt->SetData(index++, (uint16)GetMapId());
            stmt->SetData(index++, (uint32)GetInstanceId());
            stmt->SetData(index++, (uint8(dd) | uint8(rd) << 4));
            stmt->SetData(index++, finiteAlways(GetPositionX()));
            stmt->SetData(index++, finiteAlways(GetPositionY()));
            stmt->SetData(index++, finiteAlways(GetPositionZ()));
            stmt->SetData(index++, finiteAlways(GetOrientation()));
        }
        else
        {
            stmt->SetData(index++, (uint16)GetTeleportDest().GetMapId());
            stmt->SetData(index++, (uint32)0);
            stmt->SetData(index++, (uint8(GetDungeonDifficulty()) | uint8(GetRaidDifficulty()) << 4));
            stmt->SetData(index++, finiteAlways(GetTeleportDest().GetPositionX()));
            stmt->SetData(index++, finiteAlways(GetTeleportDest().GetPositionY()));
            stmt->SetData(index++, finiteAlways(GetTeleportDest().GetPositionZ()));
            stmt->SetData(index++, finiteAlways(GetTeleportDest().GetOrientation()));
        }

        stmt->SetData(index++, finiteAlways(GetTransOffsetX()));
        stmt->SetData(index++, finiteAlways(GetTransOffsetY()));
        stmt->SetData(index++, finiteAlways(GetTransOffsetZ()));
        stmt->SetData(index++, finiteAlways(GetTransOffsetO()));

        int32 lowGuidOrSpawnId = 0;
        if (Transport* transport = GetTransport())
        {
            if (transport->IsMotionTransport())
                lowGuidOrSpawnId = static_cast<int32>(transport->GetGUID().GetCounter());
            else if (transport->IsStaticTransport())
                lowGuidOrSpawnId = -static_cast<int32>(transport->GetSpawnId());
        }
        stmt->SetData(index++, lowGuidOrSpawnId);

        std::ostringstream ss;
        ss << m_taxi;
        stmt->SetData(index++, ss.str());
        stmt->SetData(index++, m_cinematic);
        stmt->SetData(index++, m_Played_time[PLAYED_TIME_TOTAL]);
        stmt->SetData(index++, m_Played_time[PLAYED_TIME_LEVEL]);
        stmt->SetData(index++, finiteAlways(_restBonus));
        stmt->SetData(index++, uint32(GameTime::GetGameTime().count()));
        stmt->SetData(index++,  (HasPlayerFlag(PLAYER_FLAGS_RESTING) ? 1 : 0));
        //save, far from tavern/city
        //save, but in tavern/city
        stmt->SetData(index++, m_resetTalentsCost);
        stmt->SetData(index++, uint32(m_resetTalentsTime));
        stmt->SetData(index++, (uint16)m_ExtraFlags);
        stmt->SetData(index++, m_petStable ? m_petStable->MaxStabledPets : 0);
        stmt->SetData(index++, (uint16)m_atLoginFlags);
        stmt->SetData(index++, GetZoneId());
        stmt->SetData(index++, uint32(m_deathExpireTime));

        ss.str("");
        ss << m_taxi.SaveTaxiDestinationsToString();

        stmt->SetData(index++, ss.str());
        stmt->SetData(index++, GetArenaPoints());
        stmt->SetData(index++, GetHonorPoints());
        stmt->SetData(index++, GetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION));
        stmt->SetData(index++, GetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION));
        stmt->SetData(index++, GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS));
        stmt->SetData(index++, GetUInt16Value(PLAYER_FIELD_KILLS, 0));
        stmt->SetData(index++, GetUInt16Value(PLAYER_FIELD_KILLS, 1));
        stmt->SetData(index++, GetUInt32Value(PLAYER_CHOSEN_TITLE));
        stmt->SetData(index++, GetUInt64Value(PLAYER_FIELD_KNOWN_CURRENCIES));
        stmt->SetData(index++, GetUInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX));
        stmt->SetData(index++, GetDrunkValue());
        stmt->SetData(index++, GetHealth());

        for (uint32 i = 0; i < MAX_POWERS; ++i)
            stmt->SetData(index++, GetPower(Powers(i)));

        stmt->SetData(index++, GetSession()->GetLatency());

        stmt->SetData(index++, m_specsCount);
        stmt->SetData(index++, m_activeSpec);

        ss.str("");
        for (uint32 i = 0; i < PLAYER_EXPLORED_ZONES_SIZE; ++i)
            ss << GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + i) << ' ';
        stmt->SetData(index++, ss.str());

        ss.str("");
        // cache equipment...
        for (uint32 i = 0; i < EQUIPMENT_SLOT_END * 2; ++i)
            ss << GetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + i) << ' ';

        // ...and bags for enum opcode
        for (uint32 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        {
            if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                ss << item->GetEntry();
            else
                ss << '0';
            ss << " 0 ";
        }

        stmt->SetData(index++, ss.str());
        stmt->SetData(index++, GetUInt32Value(PLAYER_AMMO_ID));

        ss.str("");
        for (uint32 i = 0; i < KNOWN_TITLES_SIZE * 2; ++i)
            ss << GetUInt32Value(PLAYER__FIELD_KNOWN_TITLES + i) << ' ';

        stmt->SetData(index++, ss.str());
        stmt->SetData(index++, GetByteValue(PLAYER_FIELD_BYTES, 2));
        stmt->SetData(index++, m_grantableLevels);
        stmt->SetData(index++, _innTriggerId);
        stmt->SetData(index++, m_extraBonusTalentCount);

        stmt->SetData(index++, IsInWorld() && !GetSession()->PlayerLogout() ? 1 : 0);
        // Index
        stmt->SetData(index++, GetGUID().GetCounter());
    }

    trans->Append(stmt);
}

void Player::_LoadGlyphs(PreparedQueryResult result)
{
    // SELECT talentGroup, glyph1, glyph2, glyph3, glyph4, glyph5, glyph6 from character_glyphs WHERE guid = '%u'
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint8 spec = fields[0].Get<uint8>();
        if (spec >= m_specsCount)
            continue;

        m_Glyphs[spec][0] = fields[1].Get<uint16>();
        m_Glyphs[spec][1] = fields[2].Get<uint16>();
        m_Glyphs[spec][2] = fields[3].Get<uint16>();
        m_Glyphs[spec][3] = fields[4].Get<uint16>();
        m_Glyphs[spec][4] = fields[5].Get<uint16>();
        m_Glyphs[spec][5] = fields[6].Get<uint16>();
    } while (result->NextRow());
}

void Player::_SaveGlyphs(CharacterDatabaseTransaction trans)
{
    if (!NeedToSaveGlyphs())
        return;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_GLYPHS);
    stmt->SetData(0, GetGUID().GetCounter());
    trans->Append(stmt);

    for (uint8 spec = 0; spec < m_specsCount; ++spec)
    {
        uint8 index = 0;

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_GLYPHS);
        stmt->SetData(index++, GetGUID().GetCounter());
        stmt->SetData(index++, spec);

        for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
            stmt->SetData(index++, uint16(m_Glyphs[spec][i]));

        trans->Append(stmt);
    }

    SetNeedToSaveGlyphs(false);
}

void Player::_LoadTalents(PreparedQueryResult result)
{
    // SetQuery(PLAYER_LOGIN_QUERY_LOADTALENTS, "SELECT spell, specMask FROM character_talent WHERE guid = '{}'", m_guid.GetCounter());
    if (result)
    {
        do
        {
            // xinef: checked
            uint32 spellId = (*result)[0].Get<uint32>();
            uint8 specMask = (*result)[1].Get<uint8>();
            addTalent(spellId, specMask, 0);
            TalentSpellPos const* talentPos = GetTalentSpellPos(spellId);
            ASSERT(talentPos);

            // xinef: increase used talent points count
            if (GetActiveSpecMask() & specMask)
                m_usedTalentCount += talentPos->rank + 1;
        } while (result->NextRow());
    }
}

void Player::_SaveTalents(CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = nullptr;

    for (PlayerTalentMap::iterator itr = m_talents.begin(); itr != m_talents.end();)
    {
        // xinef: skip temporary spells
        if (itr->second->State == PLAYERSPELL_TEMPORARY)
        {
            ++itr;
            continue;
        }

        // xinef: delete statement for removed / updated talent
        if (itr->second->State == PLAYERSPELL_REMOVED || itr->second->State == PLAYERSPELL_CHANGED)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_TALENT_BY_SPELL);
            stmt->SetData(0, GetGUID().GetCounter());
            stmt->SetData(1, itr->first);
            trans->Append(stmt);
        }

        // xinef: insert statement for new / updated spell
        if (itr->second->State == PLAYERSPELL_NEW || itr->second->State == PLAYERSPELL_CHANGED)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_TALENT);
            stmt->SetData(0, GetGUID().GetCounter());
            stmt->SetData(1, itr->first);
            stmt->SetData(2, itr->second->specMask);
            trans->Append(stmt);
        }

        if (itr->second->State == PLAYERSPELL_REMOVED)
        {
            delete itr->second;
            m_talents.erase(itr++);
        }
        else
        {
            itr->second->State = PLAYERSPELL_UNCHANGED;
            ++itr;
        }
    }
}

void Player::ActivateSpec(uint8 spec)
{
    // xinef: some basic checks
    if (GetActiveSpec() == spec)
        return;

    if (spec > GetSpecsCount())
        return;

    // xinef: interrupt currently casted spell just in case
    if (IsNonMeleeSpellCast(false))
        InterruptNonMeleeSpells(false);

    // xinef: save current actions order
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    _SaveActions(trans);
    CharacterDatabase.CommitTransaction(trans);

    // xinef: remove pet, it will be resummoned later
    if (Pet* pet = GetPet())
        RemovePet(pet, PET_SAVE_NOT_IN_SLOT);

    // xinef: remove other summoned units and clear reactives
    ClearAllReactives();
    UnsummonAllTotems();
    RemoveAllControlled();

    // xinef: let client clear his current Actions
    SendActionButtons(2);
    uint8 oldSpec = GetActiveSpec();

    std::unordered_set<uint32> removedSpecAuras;

    // xinef: reset talent auras
    for (PlayerTalentMap::iterator itr = m_talents.begin(); itr != m_talents.end(); ++itr)
    {
        if (itr->second->State == PLAYERSPELL_REMOVED)
            continue;

        // xinef: remove all active talent auras
        if (!(itr->second->specMask & GetActiveSpecMask()))
            continue;

        _removeTalentAurasAndSpells(itr->first);

        // pussywizard: was => isn't
        if (!itr->second->IsInSpec(spec) && !itr->second->inSpellBook)
            SendLearnPacket(itr->first, false);

        removedSpecAuras.insert(itr->first);
    }

    // xinef: remove glyph auras
    for (uint8 slot = 0; slot < MAX_GLYPH_SLOT_INDEX; ++slot)
        if (uint32 glyphId = m_Glyphs[GetActiveSpec()][slot])
            if (GlyphPropertiesEntry const* glyphEntry = sGlyphPropertiesStore.LookupEntry(glyphId))
            {
                RemoveAurasDueToSpell(glyphEntry->SpellId);
                removedSpecAuras.insert(glyphEntry->SpellId);
            }

    // xinef: set active spec as new one
    SetActiveSpec(spec);
    uint32 spentTalents = 0;

    // xinef: add talent auras
    for (PlayerTalentMap::iterator itr = m_talents.begin(); itr != m_talents.end(); ++itr)
    {
        if (itr->second->State == PLAYERSPELL_REMOVED)
            continue;

        // xinef: talent not in new spec
        if (!(itr->second->specMask & GetActiveSpecMask()))
            continue;

        // pussywizard: wasn't => is
        if (!itr->second->IsInSpec(oldSpec) && !itr->second->inSpellBook)
            SendLearnPacket(itr->first, true);

        _addTalentAurasAndSpells(itr->first);
        TalentSpellPos const* talentPos = GetTalentSpellPos(itr->first);
        spentTalents += talentPos->rank + 1;

        removedSpecAuras.erase(itr->first);
    }

    // pussywizard: remove spells that are in previous spec, but are not present in new one (or are in new spec, but not in the old one)
    for (PlayerSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
    {
        if (!itr->second->Active || itr->second->State == PLAYERSPELL_REMOVED)
            continue;

        // pussywizard: was => isn't
        if (itr->second->IsInSpec(oldSpec) && !itr->second->IsInSpec(spec))
        {
            SendLearnPacket(itr->first, false);
            // We want to remove all auras of the unlearned spell
            _removeTalentAurasAndSpells(itr->first);

            removedSpecAuras.insert(itr->first);
        }
        // pussywizard: wasn't => is
        else if (!itr->second->IsInSpec(oldSpec) && itr->second->IsInSpec(spec))
        {
            SendLearnPacket(itr->first, true);

            removedSpecAuras.erase(itr->first);
        }
    }

    // xinef: apply glyphs from second spec
    if (GetActiveSpec() != oldSpec)
    {
        for (uint8 slot = 0; slot < MAX_GLYPH_SLOT_INDEX; ++slot)
        {
            uint32 glyphId = m_Glyphs[GetActiveSpec()][slot];
            if (glyphId)
            {
                if (GlyphPropertiesEntry const* glyphEntry = sGlyphPropertiesStore.LookupEntry(glyphId))
                {
                    CastSpell(this, glyphEntry->SpellId, TriggerCastFlags(TRIGGERED_FULL_MASK & ~(TRIGGERED_IGNORE_SHAPESHIFT | TRIGGERED_IGNORE_CASTER_AURASTATE)));
                    removedSpecAuras.erase(glyphEntry->SpellId);
                }
            }

            SetGlyph(slot, glyphId, true);
        }
    }

    // Remove auras triggered/activated by talents/glyphs
    // Mostly explicit casts in dummy aura scripts
    if (!removedSpecAuras.empty())
    {
        for (AuraMap::iterator iter = m_ownedAuras.begin(); iter != m_ownedAuras.end();)
        {
            Aura* aura = iter->second;
            if (SpellInfo const* triggeredByAuraSpellInfo = aura->GetTriggeredByAuraSpellInfo())
            {
                if (removedSpecAuras.find(triggeredByAuraSpellInfo->Id) != removedSpecAuras.end())
                {
                    RemoveOwnedAura(iter);
                    continue;
                }
            }
            ++iter;
        }
    }

    m_usedTalentCount = spentTalents;
    InitTalentForLevel();

    // load them asynchronously
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_ACTIONS_SPEC);
        stmt->SetData(0, GetGUID().GetCounter());
        stmt->SetData(1, m_activeSpec);

        WorldSession* mySess = GetSession();
        mySess->GetQueryProcessor().AddCallback(CharacterDatabase.AsyncQuery(stmt)
        .WithPreparedCallback([mySess](PreparedQueryResult result)
        {
            // safe callback, we can't pass this pointer directly
            // in case player logs out before db response (player would be deleted in that case)
            if (Player* thisPlayer = mySess->GetPlayer())
                thisPlayer->LoadActions(result);
        }));
    }

    // xinef: reset power
    Powers pw = getPowerType();
    if (pw != POWER_MANA)
        SetPower(POWER_MANA, 0); // Mana must be 0 even if it isn't the active power type.
    SetPower(pw, 0);

    // xinef: remove titan grip if player had it set and does not have appropriate talent
    if (!HasTalent(46917, GetActiveSpec()) && m_canTitanGrip)
        SetCanTitanGrip(false);
    // xinef: remove dual wield if player does not have dual wield spell (shamans)
    if (!HasSpell(674) && m_canDualWield)
        SetCanDualWield(false);

    AutoUnequipOffhandIfNeed();

    // Xinef: Patch 3.2.0: Switching spec removes paladins spell Righteous Fury (25780)
    if (IsClass(CLASS_PALADIN, CLASS_CONTEXT_ABILITY))
        RemoveAurasDueToSpell(25780);

    // Xinef: Remove talented single target auras at other targets
    AuraList& scAuras = GetSingleCastAuras();
    for (AuraList::iterator iter = scAuras.begin(); iter != scAuras.end();)
    {
        Aura* aura = *iter;
        if (!HasActiveSpell(aura->GetId()) && !HasTalent(aura->GetId(), GetActiveSpec()) && !aura->GetCastItemGUID())
        {
            aura->Remove();
            iter = scAuras.begin();
        }
        else
            ++iter;
    }

    sScriptMgr->OnAfterSpecSlotChanged(this, GetActiveSpec());
}

void Player::LoadActions(PreparedQueryResult result)
{
    if (result)
        _LoadActions(result);

    SendActionButtons(1);
}

void Player::GetTalentTreePoints(uint8 (&specPoints)[3]) const
{
    const PlayerTalentMap& talentMap = GetTalentMap();
    for (PlayerTalentMap::const_iterator itr = talentMap.begin(); itr != talentMap.end(); ++itr)
        if (itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(GetActiveSpec()))
            if (TalentEntry const* talentInfo = sTalentStore.LookupEntry(itr->second->talentID))
                if (TalentTabEntry const* tab = sTalentTabStore.LookupEntry(talentInfo->TalentTab))
                    if (tab->tabpage < 3)
                    {
                        // find current talent rank
                        uint8 currentTalentRank = 0;
                        for (uint8 rank = 0; rank < MAX_TALENT_RANK; ++rank)
                            if (talentInfo->RankID[rank] && itr->first == talentInfo->RankID[rank])
                            {
                                currentTalentRank = rank + 1;
                                break;
                            }
                        specPoints[tab->tabpage] += currentTalentRank;
                    }
}

uint8 Player::GetMostPointsTalentTree() const
{
    uint32 specPoints[3] = {0, 0, 0};
    const PlayerTalentMap& talentMap = GetTalentMap();
    for (PlayerTalentMap::const_iterator itr = talentMap.begin(); itr != talentMap.end(); ++itr)
        if (itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(GetActiveSpec()))
            if (TalentEntry const* talentInfo = sTalentStore.LookupEntry(itr->second->talentID))
                if (TalentTabEntry const* tab = sTalentTabStore.LookupEntry(talentInfo->TalentTab))
                    if (tab->tabpage < 3)
                    {
                        // find current talent rank
                        uint8 currentTalentRank = 0;
                        for (uint8 rank = 0; rank < MAX_TALENT_RANK; ++rank)
                            if (talentInfo->RankID[rank] && itr->first == talentInfo->RankID[rank])
                            {
                                currentTalentRank = rank + 1;
                                break;
                            }
                        specPoints[tab->tabpage] += currentTalentRank;
                    }
    uint8 maxIndex = 0;
    uint8 maxCount = specPoints[0];
    for (uint8 i = 1; i < 3; ++i)
        if (specPoints[i] > maxCount)
        {
            maxIndex = i;
            maxCount = specPoints[i];
        }
    return maxIndex;
}

void Player::SetReputation(uint32 factionentry, float value)
{
    GetReputationMgr().SetReputation(sFactionStore.LookupEntry(factionentry), value);
}

uint32 Player::GetReputation(uint32 factionentry) const
{
    return GetReputationMgr().GetReputation(sFactionStore.LookupEntry(factionentry));
}

std::string const& Player::GetGuildName()
{
    return sGuildMgr->GetGuildById(GetGuildId())->GetName();
}

void Player::SendDuelCountdown(uint32 counter)
{
    WorldPacket data(SMSG_DUEL_COUNTDOWN, 4);
    data << uint32(counter);                                // seconds
    GetSession()->SendPacket(&data);
}

void Player::SetIsSpectator(bool on)
{
    if (on)
    {
        AddAura(SPECTATOR_SPELL_SPEED, this);
        m_ExtraFlags |= PLAYER_EXTRA_SPECTATOR_ON;
        AddUnitState(UNIT_STATE_ISOLATED);
        //SetFaction(1100);
        SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        if (HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP))
        {
            RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
            sScriptMgr->OnFfaPvpStateUpdate(this, false);
        }
        ResetContestedPvP();
        SetDisplayId(23691);
    }
    else
    {
        RemoveAurasDueToSpell(SPECTATOR_SPELL_SPEED);
        if (IsSpectator())
            ClearUnitState(UNIT_STATE_ISOLATED);
        m_ExtraFlags &= ~PLAYER_EXTRA_SPECTATOR_ON;
        RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        RestoreDisplayId();

        if (!IsGameMaster())
        {
            //SetFactionForRace(getRace());

            // restore FFA PvP Server state
            // Xinef: it will be removed if necessery in UpdateArea called in WorldPortOpcode
            if (sWorld->IsFFAPvPRealm())
            {
                if (!HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP))
                {
                    SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
                    sScriptMgr->OnFfaPvpStateUpdate(this, true);

                }
            }
        }
    }
}

bool Player::NeedSendSpectatorData() const
{
    if (FindMap() && FindMap()->IsBattleArena() && !IsSpectator())
    {
        Battleground* bg = ((BattlegroundMap*)FindMap())->GetBG();
        if (bg && bg->HaveSpectators() && bg->GetStatus() == STATUS_IN_PROGRESS && !bg->GetPlayers().empty())
            if (bg->GetPlayers().find(GetGUID()) != bg->GetPlayers().end())
                return true;
    }
    return false;
}

void Player::PrepareCharmAISpells()
{
    for (int i = 0; i < NUM_CAI_SPELLS; ++i)
        m_charmAISpells[i] = 0;

    uint32 damage_type[4] = {0, 0, 0, 0};
    uint32 periodic_damage = 0;

    for (PlayerSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
    {
        if (itr->second->State == PLAYERSPELL_REMOVED || !itr->second->Active || !itr->second->IsInSpec(GetActiveSpec()))
            continue;

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);
        if (!spellInfo)
            continue;

        if (!spellInfo->SpellFamilyName || spellInfo->IsPassive() || spellInfo->NeedsComboPoints() || (spellInfo->Stances && !spellInfo->HasAttribute(SPELL_ATTR2_ALLOW_WHILE_NOT_SHAPESHIFTED)))
            continue;

        float cast = spellInfo->CalcCastTime() / 1000.0f;
        if (cast > 3.0f)
            continue;

        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (spellInfo->Effects[i].Effect == SPELL_EFFECT_SCHOOL_DAMAGE)
            {
                int32 dmg = CalculateSpellDamage(this, spellInfo, i);
                uint8 offset = 0;
                if (cast)
                {
                    dmg = dmg / cast;
                    offset = 2;
                }

                if ((int32)damage_type[offset] < dmg)
                {
                    if (!m_charmAISpells[SPELL_INSTANT_DAMAGE + offset] || !spellInfo->IsHighRankOf(sSpellMgr->GetSpellInfo(m_charmAISpells[SPELL_INSTANT_DAMAGE + offset])) || urand(0, 1))
                        if (damage_type[1 + offset] < damage_type[offset])
                        {
                            m_charmAISpells[SPELL_INSTANT_DAMAGE2 + offset] = m_charmAISpells[SPELL_INSTANT_DAMAGE + offset];
                            damage_type[1 + offset] = damage_type[offset];
                        }

                    m_charmAISpells[SPELL_INSTANT_DAMAGE + offset] = spellInfo->Id;
                    damage_type[offset] = dmg;
                }
                else if ((int32)damage_type[1 + offset] < dmg)
                {
                    if (m_charmAISpells[SPELL_INSTANT_DAMAGE + offset] && sSpellMgr->GetSpellInfo(m_charmAISpells[SPELL_INSTANT_DAMAGE + offset])->IsHighRankOf(spellInfo) && urand(0, 1))
                        continue;

                    m_charmAISpells[SPELL_INSTANT_DAMAGE2 + offset] = spellInfo->Id;
                    damage_type[1 + offset] = dmg;
                }
                break;
            }
            else if (spellInfo->HasAttribute(SPELL_ATTR7_ATTACK_ON_CHARGE_TO_UNIT))
            {
                m_charmAISpells[SPELL_T_CHARGE] = spellInfo->Id;
                break;
            }
            else if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_SPEED)
            {
                m_charmAISpells[SPELL_FAST_RUN] = spellInfo->Id;
                break;
            }
            else if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_SCHOOL_IMMUNITY)
            {
                m_charmAISpells[SPELL_IMMUNITY] = spellInfo->Id;
                break;
            }
            else if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_PERIODIC_DAMAGE)
            {
                if ((int32)periodic_damage < CalculateSpellDamage(this, spellInfo, i))
                {
                    m_charmAISpells[SPELL_DOT_DAMAGE] = spellInfo->Id;
                    break;
                }
            }
            else if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_STUN)
            {
                m_charmAISpells[SPELL_T_STUN] = spellInfo->Id;
                break;
            }
            else if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_ROOT || spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_FEAR)
            {
                m_charmAISpells[SPELL_ROOT_OR_FEAR] = spellInfo->Id;
                break;
            }
        }
    }
}

void Player::AddRefundReference(ObjectGuid itemGUID)
{
    m_refundableItems.insert(itemGUID);
}

void Player::DeleteRefundReference(ObjectGuid itemGUID)
{
    RefundableItemsSet::iterator itr = m_refundableItems.find(itemGUID);
    if (itr != m_refundableItems.end())
        m_refundableItems.erase(itr);
}

void Player::SendRefundInfo(Item* item)
{
    // This function call unsets ITEM_FLAGS_REFUNDABLE if played time is over 2 hours.
    item->UpdatePlayedTime(this);

    if (!item->IsRefundable())
    {
        LOG_DEBUG("entities.player.items", "Item refund: item not refundable!");
        return;
    }

    if (GetGUID().GetCounter() != item->GetRefundRecipient()) // Formerly refundable item got traded
    {
        LOG_DEBUG("entities.player.items", "Item refund: item was traded!");
        item->SetNotRefundable(this);
        return;
    }

    ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(item->GetPaidExtendedCost());
    if (!iece)
    {
        LOG_DEBUG("entities.player.items", "Item refund: cannot find extendedcost data.");
        return;
    }

    WorldPacket data(SMSG_ITEM_REFUND_INFO_RESPONSE, 8 + 4 + 4 + 4 + 4 * 4 + 4 * 4 + 4 + 4);
    data << item->GetGUID();                            // item guid
    data << uint32(item->GetPaidMoney());               // money cost
    data << uint32(iece->reqhonorpoints);               // honor point cost
    data << uint32(iece->reqarenapoints);               // arena point cost
    for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i)                       // item cost data
    {
        data << uint32(iece->reqitem[i]);
        data << uint32(iece->reqitemcount[i]);
    }
    data << uint32(0);
    data << uint32(GetTotalPlayedTime() - item->GetPlayedTime());
    GetSession()->SendPacket(&data);
}

bool Player::AddItem(uint32 itemId, uint32 count)
{
    uint32 noSpaceForCount = 0;
    ItemPosCountVec dest;
    InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, count, &noSpaceForCount);
    if (msg != EQUIP_ERR_OK)
        count -= noSpaceForCount;

    if (count == 0 || dest.empty())
    {
        // -- TODO: Send to mailbox if no space
        ChatHandler(GetSession()).PSendSysMessage("You don't have any space in your bags.");
        return false;
    }

    Item* item = StoreNewItem(dest, itemId, true);
    if (item)
        SendNewItem(item, count, true, false);
    else
        return false;
    return true;
}

PetStable& Player::GetOrInitPetStable()
{
    if (!m_petStable)
        m_petStable = std::make_unique<PetStable>();

    return *m_petStable;
}

void Player::RefundItem(Item* item)
{
    if (!item->IsRefundable())
    {
        LOG_DEBUG("entities.player.items", "Item refund: item not refundable!");
        return;
    }

    if (item->IsRefundExpired())    // item refund has expired
    {
        item->SetNotRefundable(this);
        WorldPacket data(SMSG_ITEM_REFUND_RESULT, 8 + 4);
        data << item->GetGUID();                     // Guid
        data << uint32(10);                          // Error!
        GetSession()->SendPacket(&data);
        return;
    }

    if (GetGUID().GetCounter() != item->GetRefundRecipient()) // Formerly refundable item got traded
    {
        LOG_DEBUG("entities.player.items", "Item refund: item was traded!");
        item->SetNotRefundable(this);
        return;
    }

    ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(item->GetPaidExtendedCost());
    if (!iece)
    {
        LOG_DEBUG("entities.player.items", "Item refund: cannot find extendedcost data.");
        return;
    }

    bool store_error = false;
    for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i)
    {
        uint32 count = iece->reqitemcount[i];
        uint32 itemid = iece->reqitem[i];

        if (count && itemid)
        {
            ItemPosCountVec dest;
            InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemid, count);
            if (msg != EQUIP_ERR_OK)
            {
                store_error = true;
                break;
            }
        }
    }

    if (store_error)
    {
        WorldPacket data(SMSG_ITEM_REFUND_RESULT, 8 + 4);
        data << item->GetGUID();                         // Guid
        data << uint32(10);                              // Error!
        GetSession()->SendPacket(&data);
        return;
    }

    WorldPacket data(SMSG_ITEM_REFUND_RESULT, 8 + 4 + 4 + 4 + 4 + 4 * 4 + 4 * 4);
    data << item->GetGUID();                            // item guid
    data << uint32(0);                                  // 0, or error code
    data << uint32(item->GetPaidMoney());               // money cost
    data << uint32(iece->reqhonorpoints);               // honor point cost
    data << uint32(iece->reqarenapoints);               // arena point cost
    for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i) // item cost data
    {
        data << uint32(iece->reqitem[i]);
        data << uint32(iece->reqitemcount[i]);
    }
    GetSession()->SendPacket(&data);

    uint32 moneyRefund = item->GetPaidMoney();  // item-> will be invalidated in DestroyItem

    // Save all relevant data to DB to prevent desynchronisation exploits
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    // Delete any references to the refund data
    item->SetNotRefundable(this, true, &trans);

    // Destroy item
    DestroyItem(item->GetBagSlot(), item->GetSlot(), true);

    // Grant back extendedcost items
    for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i)
    {
        uint32 count = iece->reqitemcount[i];
        uint32 itemid = iece->reqitem[i];
        if (count && itemid)
        {
            ItemPosCountVec dest;
            InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemid, count);
            ASSERT(msg == EQUIP_ERR_OK); /// Already checked before
            Item* it = StoreNewItem(dest, itemid, true);
            SendNewItem(it, count, true, false, true);
        }
    }

    // Grant back money
    if (moneyRefund)
        ModifyMoney(moneyRefund); // Saved in SaveInventoryAndGoldToDB

    // Grant back Honor points
    if (uint32 honorRefund = iece->reqhonorpoints)
        ModifyHonorPoints(honorRefund, trans);

    // Grant back Arena points
    if (uint32 arenaRefund = iece->reqarenapoints)
        ModifyArenaPoints(arenaRefund, trans);

    SaveInventoryAndGoldToDB(trans);

    CharacterDatabase.CommitTransaction(trans);
}

void Player::SetRandomWinner(bool isWinner)
{
    m_IsBGRandomWinner = isWinner;
    if (m_IsBGRandomWinner)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_BATTLEGROUND_RANDOM);
        stmt->SetData(0, GetGUID().GetCounter());
        CharacterDatabase.Execute(stmt);
    }
}

void Player::_LoadRandomBGStatus(PreparedQueryResult result)
{
    if (result)
        m_IsBGRandomWinner = true;
}

float Player::GetAverageItemLevel()
{
    float sum = 0;
    uint32 count = 0;
    uint8 level = GetLevel();

    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        // don't check tabard, ranged, offhand or shirt
        if (i == EQUIPMENT_SLOT_TABARD || i == EQUIPMENT_SLOT_RANGED || i == EQUIPMENT_SLOT_OFFHAND || i == EQUIPMENT_SLOT_BODY)
            continue;

        if (m_items[i] && m_items[i]->GetTemplate())
            sum += m_items[i]->GetTemplate()->GetItemLevelIncludingQuality(level);

        ++count;
    }

    return std::max<float>(0.0f, sum / (float)count);
}

float Player::GetAverageItemLevelForDF()
{
    float sum = 0;
    uint32 count = 0;
    uint8 level = GetLevel();

    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        // don't check tabard, ranged, offhand or shirt
        if (i == EQUIPMENT_SLOT_TABARD || i == EQUIPMENT_SLOT_RANGED || i == EQUIPMENT_SLOT_OFFHAND || i == EQUIPMENT_SLOT_BODY)
            continue;

        if (m_items[i] && m_items[i]->GetTemplate())
        {
            if (m_items[i]->GetTemplate()->Quality == ITEM_QUALITY_HEIRLOOM)
                sum += level * 2.33f;
            else
                sum += m_items[i]->GetTemplate()->ItemLevel;
        }

        ++count;
    }

    return std::max(0.0f, sum / (float)count);
}

void Player::_LoadInstanceTimeRestrictions(PreparedQueryResult result)
{
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();
        _instanceResetTimes.insert(InstanceTimeMap::value_type(fields[0].Get<uint32>(), fields[1].Get<uint64>()));
    } while (result->NextRow());
}

void Player::_LoadBrewOfTheMonth(PreparedQueryResult result)
{
    uint32 lastEventId = 0;
    if (result)
    {
        Field* fields = result->Fetch();
        lastEventId = fields[0].Get<uint32>();
    }

    uint16 month = static_cast<uint16>(Acore::Time::GetMonth());
    uint16 eventId = month;
    if (eventId < 9)
        eventId += 3;
    else
        eventId -= 9;

    // Brew of the Month October (first in list)
    eventId += 34;

    if (lastEventId != eventId && IsEventActive(eventId) && HasAchieved(2796 /* Brew of the Month*/))
    {
        // Send Mail
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        MailSender sender(MAIL_CREATURE, 27487 /*NPC_BREW_OF_THE_MONTH_CLUB*/);
        MailDraft draft(uint16(212 + month)); // 212 is starting template id
        draft.SendMailTo(trans, MailReceiver(this, GetGUID().GetCounter()), sender);

        // Update Event Id
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_BREW_OF_THE_MONTH);
        stmt->SetData(0, GetGUID().GetCounter());
        stmt->SetData(1, uint32(eventId));
        trans->Append(stmt);

        CharacterDatabase.CommitTransaction(trans);
    }
}

void Player::_LoadPetStable(uint8 petStableSlots, PreparedQueryResult result)
{
    if (!petStableSlots && !result)
        return;

    m_petStable = std::make_unique<PetStable>();
    m_petStable->MaxStabledPets = petStableSlots;

    if (m_petStable->MaxStabledPets > MAX_PET_STABLES)
    {
        LOG_ERROR("entities.player", "Player::LoadFromDB: Player ({}) can't have more stable slots than {}, but has {} in DB",
            GetGUID().ToString(), MAX_PET_STABLES, m_petStable->MaxStabledPets);

        m_petStable->MaxStabledPets = MAX_PET_STABLES;
    }

    //         0      1        2      3    4           5     6     7        8          9       10            11      12        13              14       15
    // SELECT id, entry, modelid, level, exp, Reactstate, slot, name, renamed, curhealth, curmana, curhappiness, abdata, savetime, CreatedBySpell, PetType FROM character_pet WHERE owner = ?
    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            PetStable::PetInfo petInfo;
            petInfo.PetNumber = fields[0].Get<uint32>();
            petInfo.CreatureId = fields[1].Get<uint32>();
            petInfo.DisplayId = fields[2].Get<uint32>();
            petInfo.Level = fields[3].Get<uint16>();
            petInfo.Experience = fields[4].Get<uint32>();
            petInfo.ReactState = ReactStates(fields[5].Get<uint8>());
            PetSaveMode slot = PetSaveMode(fields[6].Get<uint8>());
            petInfo.Name = fields[7].Get<std::string>();
            petInfo.WasRenamed = fields[8].Get<bool>();
            petInfo.Health = fields[9].Get<uint32>();
            petInfo.Mana = fields[10].Get<uint32>();
            petInfo.Happiness = fields[11].Get<uint32>();
            petInfo.ActionBar = fields[12].Get<std::string>();
            petInfo.LastSaveTime = fields[13].Get<uint32>();
            petInfo.CreatedBySpellId = fields[14].Get<uint32>();
            petInfo.Type = PetType(fields[15].Get<uint8>());

            if (slot == PET_SAVE_AS_CURRENT)
                m_petStable->CurrentPet = std::move(petInfo);
            else if (slot >= PET_SAVE_FIRST_STABLE_SLOT && slot <= PET_SAVE_LAST_STABLE_SLOT)
                m_petStable->StabledPets[slot - 1] = std::move(petInfo);
            else if (slot == PET_SAVE_NOT_IN_SLOT)
                m_petStable->UnslottedPets.push_back(std::move(petInfo));

        } while (result->NextRow());
    }
}

void Player::_SaveInstanceTimeRestrictions(CharacterDatabaseTransaction trans)
{
    if (_instanceResetTimes.empty())
        return;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ACCOUNT_INSTANCE_LOCK_TIMES);
    stmt->SetData(0, GetSession()->GetAccountId());
    trans->Append(stmt);

    for (InstanceTimeMap::const_iterator itr = _instanceResetTimes.begin(); itr != _instanceResetTimes.end(); ++itr)
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ACCOUNT_INSTANCE_LOCK_TIMES);
        stmt->SetData(0, GetSession()->GetAccountId());
        stmt->SetData(1, itr->first);
        stmt->SetData(2, (int64)itr->second);
        trans->Append(stmt);
    }
}

bool Player::IsInWhisperWhiteList(ObjectGuid guid)
{
    for (auto const& itr : WhisperList)
    {
        if (itr == guid)
        {
            return true;
        }
    }

    return false;
}

bool Player::SetDisableGravity(bool disable, bool packetOnly /*= false*/, bool /*updateAnimationTier = true*/)
{
    if (!packetOnly && !Unit::SetDisableGravity(disable))
        return false;

    WorldPacket data(disable ? SMSG_MOVE_GRAVITY_DISABLE : SMSG_MOVE_GRAVITY_ENABLE, 12);
    data << GetPackGUID();
    data << uint32(0);          //! movement counter
    SendDirectMessage(&data);

    data.Initialize(MSG_MOVE_GRAVITY_CHNG, 64);
    data << GetPackGUID();
    BuildMovementPacket(&data);
    SendMessageToSet(&data, false);
    return true;
}

bool Player::SetCanFly(bool apply, bool packetOnly /*= false*/)
{
    sScriptMgr->AnticheatSetCanFlybyServer(this, apply);

    if (!packetOnly && !Unit::SetCanFly(apply))
        return false;

    if (!apply)
        SetFallInformation(GameTime::GetGameTime().count(), GetPositionZ());

    WorldPacket data(apply ? SMSG_MOVE_SET_CAN_FLY : SMSG_MOVE_UNSET_CAN_FLY, 12);
    data << GetPackGUID();
    data << uint32(0);          //! movement counter
    SendDirectMessage(&data);

    data.Initialize(MSG_MOVE_UPDATE_CAN_FLY, 64);
    data << GetPackGUID();
    BuildMovementPacket(&data);
    SendMessageToSet(&data, false);
    return true;
}

bool Player::SetHover(bool apply, bool packetOnly /*= false*/, bool /*updateAnimationTier = true*/)
{
    // moved inside, flag can be removed on landing and wont send appropriate packet to client when aura is removed
    if (!packetOnly /* && !Unit::SetHover(apply)*/)
    {
        Unit::SetHover(apply);
        // return false;
    }

    WorldPacket data(apply ? SMSG_MOVE_SET_HOVER : SMSG_MOVE_UNSET_HOVER, 12);
    data << GetPackGUID();
    data << uint32(0);          //! movement counter
    SendDirectMessage(&data);

    data.Initialize(MSG_MOVE_HOVER, 64);
    data << GetPackGUID();
    BuildMovementPacket(&data);
    SendMessageToSet(&data, false);
    return true;
}

bool Player::SetWaterWalking(bool apply, bool packetOnly /*= false*/)
{
    // moved inside, flag can be removed on landing and wont send appropriate packet to client when aura is removed
    if (!packetOnly /* && !Unit::SetWaterWalking(apply)*/)
    {
        Unit::SetWaterWalking(apply);
        // return false;
    }

    WorldPacket data(apply ? SMSG_MOVE_WATER_WALK : SMSG_MOVE_LAND_WALK, 12);
    data << GetPackGUID();
    data << uint32(0);          //! movement counter
    SendDirectMessage(&data);

    data.Initialize(MSG_MOVE_WATER_WALK, 64);
    data << GetPackGUID();
    BuildMovementPacket(&data);
    SendMessageToSet(&data, false);
    return true;
}

bool Player::SetFeatherFall(bool apply, bool packetOnly /*= false*/)
{
    // Xinef: moved inside, flag can be removed on landing and wont send appropriate packet to client when aura is removed
    if (!packetOnly/* && !Unit::SetFeatherFall(apply)*/)
    {
        Unit::SetFeatherFall(apply);
        //return false;
    }

    WorldPacket data(apply ? SMSG_MOVE_FEATHER_FALL : SMSG_MOVE_NORMAL_FALL, 12);
    data << GetPackGUID();
    data << uint32(0);          //! movement counter
    SendDirectMessage(&data);

    data.Initialize(MSG_MOVE_FEATHER_FALL, 64);
    data << GetPackGUID();
    BuildMovementPacket(&data);
    SendMessageToSet(&data, false);
    return true;
}

Guild* Player::GetGuild() const
{
    uint32 guildId = GetGuildId();
    return guildId ? sGuildMgr->GetGuildById(guildId) : nullptr;
}

uint32 Player::GetSpec(int8 spec)
{
    uint32 mostTalentTabId = 0;
    uint32 mostTalentCount = 0;
    uint32 specIdx = 0;

    if (m_specsCount) // not all instances of Player have a spec for some reason
    {
        if (spec < 0)
            specIdx = m_activeSpec;
        else
            specIdx = spec;
        // find class talent tabs (all players have 3 talent tabs)
        uint32 const* talentTabIds = GetTalentTabPages(getClass());

        for (uint8 i = 0; i < MAX_TALENT_TABS; ++i)
        {
            uint32 talentCount = 0;
            uint32 talentTabId = talentTabIds[i];
            for (uint32 talentId = 0; talentId < sTalentStore.GetNumRows(); ++talentId)
            {
                TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentId);
                if (!talentInfo)
                    continue;

                // skip another tab talents
                if (talentInfo->TalentTab != talentTabId)
                    continue;

                // find max talent rank (0~4)
                int8 curtalent_maxrank = -1;
                for (int8 rank = MAX_TALENT_RANK - 1; rank >= 0; --rank)
                {
                    if (talentInfo->RankID[rank] && HasTalent(talentInfo->RankID[rank], specIdx))
                    {
                        curtalent_maxrank = rank;
                        break;
                    }
                }

                // not learned talent
                if (curtalent_maxrank < 0)
                    continue;

                talentCount += curtalent_maxrank + 1;
            }

            if (mostTalentCount < talentCount)
            {
                mostTalentCount = talentCount;
                mostTalentTabId = talentTabId;
            }
        }
    }
    return mostTalentTabId;
}

bool Player::HasTankSpec()
{
    switch (GetSpec())
    {
        case TALENT_TREE_WARRIOR_PROTECTION:
        case TALENT_TREE_PALADIN_PROTECTION:
        case TALENT_TREE_DEATH_KNIGHT_BLOOD:
            return true;
        case TALENT_TREE_DRUID_FERAL_COMBAT:
            if (GetShapeshiftForm() == FORM_BEAR || GetShapeshiftForm() == FORM_DIREBEAR)
                return true;
            break;
        default:
            break;
    }
    return false;
}

bool Player::HasMeleeSpec()
{
    switch (GetSpec(GetActiveSpec()))
    {
        case TALENT_TREE_WARRIOR_ARMS:
        case TALENT_TREE_WARRIOR_FURY:
        case TALENT_TREE_PALADIN_RETRIBUTION:
        case TALENT_TREE_ROGUE_ASSASSINATION:
        case TALENT_TREE_ROGUE_COMBAT:
        case TALENT_TREE_ROGUE_SUBTLETY:
        case TALENT_TREE_DEATH_KNIGHT_FROST:
        case TALENT_TREE_DEATH_KNIGHT_UNHOLY:
        case TALENT_TREE_SHAMAN_ENHANCEMENT:
            return true;
        case TALENT_TREE_DRUID_FERAL_COMBAT:
            if (GetShapeshiftForm() == FORM_CAT)
                return true;
        default:
            break;
    }
    return false;
}

bool Player::HasCasterSpec()
{
    switch (GetSpec(GetActiveSpec()))
    {
        case TALENT_TREE_PRIEST_SHADOW:
        case TALENT_TREE_SHAMAN_ELEMENTAL:
        case TALENT_TREE_MAGE_ARCANE:
        case TALENT_TREE_MAGE_FIRE:
        case TALENT_TREE_MAGE_FROST:
        case TALENT_TREE_WARLOCK_AFFLICTION:
        case TALENT_TREE_WARLOCK_DEMONOLOGY:
        case TALENT_TREE_WARLOCK_DESTRUCTION:
        case TALENT_TREE_DRUID_BALANCE:
        case TALENT_TREE_HUNTER_BEAST_MASTERY:
        case TALENT_TREE_HUNTER_MARKSMANSHIP:
        case TALENT_TREE_HUNTER_SURVIVAL:
            return true;
        default:
            break;
    }
    return false;
}

bool Player::HasHealSpec()
{
    switch (GetSpec(GetActiveSpec()))
    {
        case TALENT_TREE_PALADIN_HOLY:
        case TALENT_TREE_PRIEST_DISCIPLINE:
        case TALENT_TREE_PRIEST_HOLY:
        case TALENT_TREE_SHAMAN_RESTORATION:
        case TALENT_TREE_DRUID_RESTORATION:
            return true;
        default:
            break;
    }
    return false;
}

std::unordered_map<int, bgZoneRef> Player::bgZoneIdToFillWorldStates = {};

void Player::SetRestFlag(RestFlag restFlag, uint32 triggerId /*= 0*/)
{
    uint32 oldRestMask = _restFlagMask;
    _restFlagMask |= restFlag;

    if (!oldRestMask && _restFlagMask) // only set flag/time on the first rest state
    {
        _restTime = GameTime::GetGameTime().count();
        SetPlayerFlag(PLAYER_FLAGS_RESTING);
    }

    if (triggerId)
        _innTriggerId = triggerId;
}

void Player::RemoveRestFlag(RestFlag restFlag)
{
    uint32 oldRestMask = _restFlagMask;
    _restFlagMask &= ~restFlag;

    if (oldRestMask && !_restFlagMask) // only remove flag/time on the last rest state remove
    {
        _restTime = 0;
        RemovePlayerFlag(PLAYER_FLAGS_RESTING);
    }
}

uint32 Player::DoRandomRoll(uint32 minimum, uint32 maximum)
{
    ASSERT(minimum <= maximum);

    uint32 roll = urand(minimum, maximum);

    WorldPackets::Misc::RandomRoll randomRoll;
    randomRoll.Min = minimum;
    randomRoll.Max = maximum;
    randomRoll.Result = roll;
    randomRoll.Roller = GetGUID();
    if (Group* group = GetGroup())
        group->BroadcastPacket(randomRoll.Write(), false);
    else
        SendDirectMessage(randomRoll.Write());

    return roll;
}

void Player::SetArenaTeamInfoField(uint8 slot, ArenaTeamInfoType type, uint32 value)
{
    if (sScriptMgr->NotSetArenaTeamInfoField(this, slot, type, value))
        SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (slot * ARENA_TEAM_END) + type, value);
}

uint32 Player::GetArenaPersonalRating(uint8 slot) const
{
    uint32 result = GetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (slot * ARENA_TEAM_END) + ARENA_TEAM_PERSONAL_RATING);

    sScriptMgr->OnGetArenaPersonalRating(const_cast<Player*>(this), slot, result);

    return result;
}

uint32 Player::GetArenaTeamId(uint8 slot) const
{
    uint32 result = GetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (slot * ARENA_TEAM_END) + ARENA_TEAM_ID);

    sScriptMgr->OnGetArenaTeamId(const_cast<Player*>(this), slot, result);

    return result;
}

bool Player::IsFFAPvP()
{
    bool result = Unit::IsFFAPvP();

    sScriptMgr->OnIsFFAPvP(this, result);

    return result;
}

bool Player::IsPvP()
{
    bool result = Unit::IsPvP();

    sScriptMgr->OnIsPvP(this, result);

    return result;
}

uint16 Player::GetMaxSkillValueForLevel() const
{
    uint16 result = Unit::GetMaxSkillValueForLevel();

    sScriptMgr->OnGetMaxSkillValueForLevel(const_cast<Player*>(this), result);

    return result;
}

float Player::GetQuestRate(bool isDFQuest)
{
    float result = isDFQuest ? sWorld->getRate(RATE_XP_QUEST_DF) : sWorld->getRate(RATE_XP_QUEST);

    sScriptMgr->OnGetQuestRate(this, result);

    return result;
}

void Player::SetServerSideVisibility(ServerSideVisibilityType type, AccountTypes sec)
{
    sScriptMgr->OnSetServerSideVisibility(this, type, sec);

    m_serverSideVisibility.SetValue(type, sec);
}

void Player::SetServerSideVisibilityDetect(ServerSideVisibilityType type, AccountTypes sec)
{
    sScriptMgr->OnSetServerSideVisibilityDetect(this, type, sec);

    m_serverSideVisibilityDetect.SetValue(type, sec);
}

void Player::SetFarSightDistance(float radius)
{
    _farSightDistance = radius;
}

void Player::ResetFarSightDistance()
{
    _farSightDistance.reset();
}

Optional<float> Player::GetFarSightDistance() const
{
    return _farSightDistance;
}

float Player::GetSightRange(WorldObject const* target) const
{
    float sightRange = WorldObject::GetSightRange(target);
    if (_farSightDistance)
    {
        sightRange += *_farSightDistance;
    }

    return sightRange;
}

std::string Player::GetPlayerName()
{
    std::string name = GetName();
    std::string color = "";

    switch (getClass())
    {
        case CLASS_DEATH_KNIGHT: color = "|cffC41F3B"; break;
        case CLASS_DRUID:        color = "|cffFF7D0A"; break;
        case CLASS_HUNTER:       color = "|cffABD473"; break;
        case CLASS_MAGE:         color = "|cff69CCF0"; break;
        case CLASS_PALADIN:      color = "|cffF58CBA"; break;
        case CLASS_PRIEST:       color = "|cffFFFFFF"; break;
        case CLASS_ROGUE:        color = "|cffFFF569"; break;
        case CLASS_SHAMAN:       color = "|cff0070DE"; break;
        case CLASS_WARLOCK:      color = "|cff9482C9"; break;
        case CLASS_WARRIOR:      color = "|cffC79C6E"; break;
    }

    return "|Hplayer:" + name + "|h" + color + name + "|h|r";
}

void Player::SetSummonPoint(uint32 mapid, float x, float y, float z, uint32 delay /*= 0*/, bool asSpectator /*= false*/)
{
    m_summon_expire = GameTime::GetGameTime().count() + (delay ? delay : MAX_PLAYER_SUMMON_DELAY);
    m_summon_mapid = mapid;
    m_summon_x = x;
    m_summon_y = y;
    m_summon_z = z;
    m_summon_asSpectator = asSpectator;
}

bool Player::IsSummonAsSpectator() const
{
    return m_summon_asSpectator && m_summon_expire >= GameTime::GetGameTime().count();
}

bool Player::HasSpellCooldown(uint32 spell_id) const
{
    SpellCooldowns::const_iterator itr = m_spellCooldowns.find(spell_id);
    return itr != m_spellCooldowns.end() && itr->second.end > getMSTime();
}

bool Player::HasSpellItemCooldown(uint32 spell_id, uint32 itemid) const
{
    SpellCooldowns::const_iterator itr = m_spellCooldowns.find(spell_id);
    return itr != m_spellCooldowns.end() && itr->second.end > getMSTime() && itr->second.itemid == itemid;
}

uint32 Player::GetSpellCooldownDelay(uint32 spell_id) const
{
    SpellCooldowns::const_iterator itr = m_spellCooldowns.find(spell_id);
    return uint32(itr != m_spellCooldowns.end() && itr->second.end > getMSTime() ? itr->second.end - getMSTime() : 0);
}

std::string Player::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << Unit::GetDebugInfo();
    return sstr.str();
}

void Player::SendSystemMessage(std::string_view msg, bool escapeCharacters)
{
    ChatHandler(GetSession()).SendSysMessage(msg, escapeCharacters);
}
