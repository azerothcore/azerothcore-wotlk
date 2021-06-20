/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ArenaSpectator.h"
#include "Battleground.h"
#include "Common.h"
#include "CreatureAI.h"
#include "DatabaseEnv.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "Unit.h"
#include "Util.h"
#include "WorldPacket.h"
#include "WorldSession.h"

Pet::Pet(Player* owner, PetType type) : Guardian(nullptr, owner ? owner->GetGUID() : ObjectGuid::Empty, true),
    m_usedTalentCount(0), m_removed(false), m_owner(owner),
    m_happinessTimer(PET_LOSE_HAPPINES_INTERVAL), m_petType(type), m_duration(0),
    m_auraRaidUpdateMask(0), m_loading(false), m_petRegenTimer(PET_FOCUS_REGEN_INTERVAL), m_declinedname(nullptr), m_tempspellTarget(nullptr), m_tempoldTarget(nullptr), m_tempspellIsPositive(false), m_tempspell(0), asynchLoadType(PET_LOAD_DEFAULT)
{
    m_unitTypeMask |= UNIT_MASK_PET;
    if (type == HUNTER_PET)
        m_unitTypeMask |= UNIT_MASK_HUNTER_PET;

    if (!(m_unitTypeMask & UNIT_MASK_CONTROLABLE_GUARDIAN))
    {
        m_unitTypeMask |= UNIT_MASK_CONTROLABLE_GUARDIAN;
        InitCharmInfo();
    }

    m_name = "Pet";
}

Pet::~Pet()
{
    delete m_declinedname;
}

void Pet::AddToWorld()
{
    ///- Register the pet for guid lookup
    if (!IsInWorld())
    {
        ///- Register the pet for guid lookup
        GetMap()->GetObjectsStore().Insert<Pet>(GetGUID(), this);
        Unit::AddToWorld();
        Motion_Initialize();
        AIM_Initialize();
    }

    // pussywizard: apply ICC buff to pets
    if (GetOwnerGUID().IsPlayer() && GetMapId() == 631 && FindMap() && FindMap()->ToInstanceMap() && FindMap()->ToInstanceMap()->GetInstanceScript() && FindMap()->ToInstanceMap()->GetInstanceScript()->GetData(251 /*DATA_BUFF_AVAILABLE*/))
        if (Unit* owner = GetOwner())
            if (Player* plr = owner->ToPlayer())
            {
                SpellAreaForAreaMapBounds saBounds = sSpellMgr->GetSpellAreaForAreaMapBounds(4812);
                for (SpellAreaForAreaMap::const_iterator itr = saBounds.first; itr != saBounds.second; ++itr)
                    if ((itr->second->raceMask & plr->getRaceMask()) && !HasAura(itr->second->spellId))
                        if (const SpellInfo* si = sSpellMgr->GetSpellInfo(itr->second->spellId))
                            if (si->HasAura(SPELL_AURA_MOD_INCREASE_HEALTH_PERCENT))
                                AddAura(itr->second->spellId, this);
            }

    // Prevent stuck pets when zoning. Pets default to "follow" when added to world
    // so we'll reset flags and let the AI handle things
    if (GetCharmInfo() && GetCharmInfo()->HasCommandState(COMMAND_FOLLOW))
    {
        GetCharmInfo()->SetIsCommandAttack(false);
        GetCharmInfo()->SetIsCommandFollow(false);
        GetCharmInfo()->SetIsAtStay(false);
        GetCharmInfo()->SetIsFollowing(false);
        GetCharmInfo()->SetIsReturning(false);
    }
}

void Pet::RemoveFromWorld()
{
    ///- Remove the pet from the accessor
    if (IsInWorld())
    {
        ///- Don't call the function for Creature, normal mobs + totems go in a different storage
        Unit::RemoveFromWorld();
        GetMap()->GetObjectsStore().Remove<Pet>(GetGUID());
    }
}

SpellCastResult Pet::TryLoadFromDB(Player* owner, bool current /*= false*/, PetType mandatoryPetType /*= MAX_PET_TYPE*/)
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PET_BY_ENTRY_AND_SLOT);
    stmt->setUInt32(0, owner->GetGUID().GetCounter());
    stmt->setUInt8(1, uint8(current ? PET_SAVE_AS_CURRENT : PET_SAVE_NOT_IN_SLOT));

    PreparedQueryResult result = CharacterDatabase.AsyncQuery(stmt);

    if (!result)
        return SPELL_FAILED_NO_PET;

    Field* fields = result->Fetch();

    uint32 petentry = fields[1].GetUInt32();
    uint32 savedHealth = fields[10].GetUInt32();
    uint32 summon_spell_id = fields[15].GetUInt32();
    auto petType = PetType(fields[16].GetUInt8());

    // update for case of current pet "slot = 0"
    if (!petentry)
        return SPELL_FAILED_NO_PET;

    CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(petentry);
    if (!creatureInfo)
    {
        LOG_ERROR("server", "Pet entry %u does not exist but used at pet load (owner: %s).", petentry, owner->GetName().c_str());
        return SPELL_FAILED_NO_PET;
    }

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(summon_spell_id);

    bool isTemporarySummoned = spellInfo && spellInfo->GetDuration() > 0;

    // check temporary summoned pets like mage water elemental
    if (current && isTemporarySummoned)
        return SPELL_FAILED_NO_PET;

    if (!savedHealth)
    {
        owner->ToPlayer()->SendTameFailure(PET_TAME_DEAD);
        return SPELL_FAILED_TARGETS_DEAD;
    }

    if (mandatoryPetType != MAX_PET_TYPE && petType != mandatoryPetType)
        return SPELL_FAILED_BAD_TARGETS;

    return SPELL_CAST_OK;
}

bool Pet::LoadPetFromDB(Player* owner, uint8 asynchLoadType, uint32 petentry, uint32 petnumber, bool current, AsynchPetSummon* info)
{
    // we are loading pet at that moment
    if (owner->IsSpectator() || owner->GetPet() || !owner->IsInWorld() || !owner->FindMap())
        return false;

    bool forceLoadFromDB = false;
    sScriptMgr->OnBeforeLoadPetFromDB(owner, petentry, petnumber, current, forceLoadFromDB);

    if (!forceLoadFromDB)
        if (owner->getClass() == CLASS_DEATH_KNIGHT && !owner->CanSeeDKPet()) // DK Pet exception
            return false;

    ObjectGuid::LowType ownerGuid = owner->GetGUID().GetCounter();
    PreparedStatement* stmt;

    if (petnumber)
    {
        // Known petnumber entry
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PET_BY_ENTRY);
        stmt->setUInt32(0, ownerGuid);
        stmt->setUInt32(1, petnumber);
    }
    else if (current)
    {
        // Current pet (slot 0)
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PET_BY_ENTRY_AND_SLOT);
        stmt->setUInt32(0, ownerGuid);
        stmt->setUInt8(1, uint8(PET_SAVE_AS_CURRENT));
    }
    else if (petentry)
    {
        // known petentry entry (unique for summoned pet, but non unique for hunter pet (only from current or not stabled pets)
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PET_BY_ENTRY_AND_SLOT_2);
        stmt->setUInt32(0, ownerGuid);
        stmt->setUInt32(1, petentry);
        stmt->setUInt8(2, uint8(PET_SAVE_AS_CURRENT));
        stmt->setUInt8(3, uint8(PET_SAVE_LAST_STABLE_SLOT));
    }
    else
    {
        // Any current or other non-stabled pet (for hunter "call pet")
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PET_BY_SLOT);
        stmt->setUInt32(0, ownerGuid);
        stmt->setUInt8(1, uint8(PET_SAVE_AS_CURRENT));
        stmt->setUInt8(2, uint8(PET_SAVE_LAST_STABLE_SLOT));
    }

    if (AsynchPetSummon* infoToDelete = owner->GetSession()->_loadPetFromDBFirstCallback.GetSecondParam())
    {
        delete infoToDelete;
    }

    owner->GetSession()->_loadPetFromDBFirstCallback.Reset();
    owner->GetSession()->_loadPetFromDBFirstCallback.SetFirstParam(asynchLoadType);
    owner->GetSession()->_loadPetFromDBFirstCallback.SetSecondParam(info);
    owner->GetSession()->_loadPetFromDBFirstCallback.SetFutureResult(CharacterDatabase.AsyncQuery(stmt));
    return true;
}

void Pet::SavePetToDB(PetSaveMode mode, bool logout)
{
    // not save not player pets
    if (!GetOwnerGUID().IsPlayer())
        return;

    // dont allow to save pet when it is loaded, possibly bugs action bar!, save only fully controlled creature
    Player* owner = GetOwner()->ToPlayer();
    if (!owner || m_loading || !GetEntry() || !isControlled())
        return;

    // not save pet as current if another pet temporary unsummoned
    if (mode == PET_SAVE_AS_CURRENT && owner->GetTemporaryUnsummonedPetNumber() &&
            owner->GetTemporaryUnsummonedPetNumber() != m_charmInfo->GetPetNumber())
    {
        // pet will lost anyway at restore temporary unsummoned
        if (getPetType() == HUNTER_PET)
            return;

        // for warlock case
        mode = PET_SAVE_NOT_IN_SLOT;
    }

    uint32 curhealth = GetHealth();
    uint32 curmana = GetPower(POWER_MANA);

    SQLTransaction trans = CharacterDatabase.BeginTransaction();
    // save auras before possibly removing them
    _SaveAuras(trans, logout);

    // stable and not in slot saves
    if (mode > PET_SAVE_AS_CURRENT)
        RemoveAllAuras();

    _SaveSpells(trans);
    _SaveSpellCooldowns(trans, logout);
    CharacterDatabase.CommitTransaction(trans);

    // current/stable/not_in_slot
    if (mode >= PET_SAVE_AS_CURRENT)
    {
        ObjectGuid::LowType ownerLowGUID = GetOwnerGUID().GetCounter();
        trans = CharacterDatabase.BeginTransaction();
        // remove current data

        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_BY_ID);
        stmt->setUInt32(0, m_charmInfo->GetPetNumber());
        trans->Append(stmt);

        // prevent duplicate using slot (except PET_SAVE_NOT_IN_SLOT)
        if (mode <= PET_SAVE_LAST_STABLE_SLOT)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_PET_SLOT_BY_SLOT);
            stmt->setUInt8(0, uint8(PET_SAVE_NOT_IN_SLOT));
            stmt->setUInt32(1, ownerLowGUID);
            stmt->setUInt8(2, uint8(mode));
            trans->Append(stmt);
        }

        // prevent existence another hunter pet in PET_SAVE_AS_CURRENT and PET_SAVE_NOT_IN_SLOT
        if (getPetType() == HUNTER_PET && (mode == PET_SAVE_AS_CURRENT || mode > PET_SAVE_LAST_STABLE_SLOT))
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_BY_SLOT);
            stmt->setUInt32(0, ownerLowGUID);
            stmt->setUInt8(1, uint8(PET_SAVE_AS_CURRENT));
            stmt->setUInt8(2, uint8(PET_SAVE_LAST_STABLE_SLOT));
            trans->Append(stmt);
        }

        // save pet
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_CHAR_PET);
        stmt->setUInt32(0, m_charmInfo->GetPetNumber());
        stmt->setUInt32(1, GetEntry());
        stmt->setUInt32(2, ownerLowGUID);
        stmt->setUInt32(3, GetNativeDisplayId());
        stmt->setUInt32(4, GetUInt32Value(UNIT_CREATED_BY_SPELL));
        stmt->setUInt8(5, uint8(getPetType()));
        stmt->setUInt8(6, getLevel());
        stmt->setUInt32(7, GetUInt32Value(UNIT_FIELD_PETEXPERIENCE));
        stmt->setUInt8(8, uint8(GetReactState()));
        stmt->setString(9, GetName());
        stmt->setUInt8(10, uint8(HasByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_RENAMED) ? 0 : 1));
        stmt->setUInt8(11, uint8(mode));
        stmt->setUInt32(12, curhealth);
        stmt->setUInt32(13, curmana);
        stmt->setUInt32(14, GetPower(POWER_HAPPINESS));
        stmt->setUInt32(15, time(nullptr));

        std::ostringstream ss;
        for (uint32 i = ACTION_BAR_INDEX_START; i < ACTION_BAR_INDEX_END; ++i)
            ss << uint32(m_charmInfo->GetActionBarEntry(i)->GetType()) << ' ' << uint32(m_charmInfo->GetActionBarEntry(i)->GetAction()) << ' ';

        stmt->setString(16, ss.str());

        trans->Append(stmt);
        CharacterDatabase.CommitTransaction(trans);
    }
    // delete
    else
    {
        RemoveAllAuras();
        DeleteFromDB(m_charmInfo->GetPetNumber());
    }
}

void Pet::DeleteFromDB(ObjectGuid::LowType guidlow)
{
    SQLTransaction trans = CharacterDatabase.BeginTransaction();

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_BY_ID);
    stmt->setUInt32(0, guidlow);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_DECLINEDNAME);
    stmt->setUInt32(0, guidlow);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_AURAS);
    stmt->setUInt32(0, guidlow);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELLS);
    stmt->setUInt32(0, guidlow);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELL_COOLDOWNS);
    stmt->setUInt32(0, guidlow);
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);
}

void Pet::setDeathState(DeathState s, bool /*despawn = false*/)                       // overwrite virtual Creature::setDeathState and Unit::setDeathState
{
    Creature::setDeathState(s);
    if (getDeathState() == CORPSE)
    {
        if (getPetType() == HUNTER_PET)
        {
            // pet corpse non lootable and non skinnable
            SetUInt32Value(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_NONE);
            RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);

            //lose happiness when died and not in BG/Arena
            MapEntry const* mapEntry = sMapStore.LookupEntry(GetMapId());
            if (!mapEntry || (mapEntry->map_type != MAP_ARENA && mapEntry->map_type != MAP_BATTLEGROUND))
                ModifyPower(POWER_HAPPINESS, -HAPPINESS_LEVEL_SIZE);

            //SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
        }
    }
    else if (getDeathState() == ALIVE)
    {
        //RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
        CastPetAuras(true);
    }
}

void Pet::Update(uint32 diff)
{
    if (m_removed)                                           // pet already removed, just wait in remove queue, no updates
        return;

    if (m_loading)
        return;

    switch (m_deathState)
    {
        case CORPSE:
            {
                if (getPetType() != HUNTER_PET || m_corpseRemoveTime <= time(nullptr))
                {
                    Remove(PET_SAVE_NOT_IN_SLOT);               //hunters' pets never get removed because of death, NEVER!
                    return;
                }
                break;
            }
        case ALIVE:
            {
                // unsummon pet that lost owner
                Player* owner = GetOwner();
                if (!owner || (!IsWithinDistInMap(owner, GetMap()->GetVisibilityRange()) && !isPossessed()) || (isControlled() && !owner->GetPetGUID()))
                    //if (!owner || (!IsWithinDistInMap(owner, GetMap()->GetVisibilityDistance()) && (owner->GetCharmGUID() && (owner->GetCharmGUID() != GetGUID()))) || (isControlled() && !owner->GetPetGUID()))
                {
                    Remove(PET_SAVE_NOT_IN_SLOT, true);
                    return;
                }

                if (isControlled())
                {
                    if (owner->GetPetGUID() != GetGUID())
                    {
                        LOG_ERROR("server", "Pet %u is not pet of owner %s, removed", GetEntry(), m_owner->GetName().c_str());
                        Remove(getPetType() == HUNTER_PET ? PET_SAVE_AS_DELETED : PET_SAVE_NOT_IN_SLOT);
                        return;
                    }
                }

                if (m_duration > 0)
                {
                    if (uint32(m_duration) > diff)
                        m_duration -= diff;
                    else
                    {
                        Remove(getPetType() != SUMMON_PET ? PET_SAVE_AS_DELETED : PET_SAVE_NOT_IN_SLOT);
                        return;
                    }
                }

                // xinef: m_regenTimer is decrased in Creature::Update()
                // xinef: just check if we can update focus in current period
                if (getPowerType() == POWER_FOCUS)
                {
                    m_petRegenTimer -= diff;
                    if (m_petRegenTimer <= int32(0))
                    {
                        m_petRegenTimer += PET_FOCUS_REGEN_INTERVAL;
                        Regenerate(POWER_FOCUS);
                    }
                }

                if (m_tempspell != 0)
                {
                    Unit* tempspellTarget = m_tempspellTarget;
                    Unit* tempoldTarget = m_tempoldTarget;
                    bool tempspellIsPositive = m_tempspellIsPositive;
                    uint32 tempspell = m_tempspell;
                    Unit* charmer = GetCharmerOrOwner();
                    if (!charmer)
                        return;

                    if (!GetCharmInfo())
                        return;

                    if (tempspellTarget && tempspellTarget->IsAlive())
                    {
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(tempspell);
                        if (!spellInfo)
                            return;
                        float max_range = GetSpellMaxRangeForTarget(tempspellTarget, spellInfo);
                        if (spellInfo->RangeEntry->type == SPELL_RANGE_MELEE)
                            max_range -= 2 * MIN_MELEE_REACH;

                        if (IsWithinLOSInMap(tempspellTarget) && GetDistance(tempspellTarget) < max_range)
                        {
                            if (!GetCharmInfo()->GetGlobalCooldownMgr().HasGlobalCooldown(spellInfo) && !HasSpellCooldown(tempspell))
                            {
                                StopMoving();
                                GetMotionMaster()->Clear(false);
                                GetMotionMaster()->MoveIdle();

                                GetCharmInfo()->SetIsCommandAttack(false);
                                GetCharmInfo()->SetIsAtStay(true);
                                GetCharmInfo()->SetIsCommandFollow(false);
                                GetCharmInfo()->SetIsFollowing(false);
                                GetCharmInfo()->SetIsReturning(false);
                                GetCharmInfo()->SaveStayPosition(true);

                                CastSpell(tempspellTarget, tempspell, true);
                                m_tempspell = 0;
                                m_tempspellTarget = nullptr;

                                if (tempspellIsPositive)
                                {
                                    if (tempoldTarget && tempoldTarget->IsAlive())
                                    {
                                        GetCharmInfo()->SetIsCommandAttack(true);
                                        GetCharmInfo()->SetIsAtStay(false);
                                        GetCharmInfo()->SetIsFollowing(false);
                                        GetCharmInfo()->SetIsCommandFollow(false);
                                        GetCharmInfo()->SetIsReturning(false);

                                        if (ToCreature() && ToCreature()->IsAIEnabled)
                                            ToCreature()->AI()->AttackStart(tempoldTarget);
                                    }
                                    else
                                    {
                                        GetCharmInfo()->SetCommandState(COMMAND_FOLLOW);
                                        GetCharmInfo()->SetIsCommandAttack(false);
                                        GetCharmInfo()->SetIsAtStay(false);
                                        GetCharmInfo()->SetIsReturning(true);
                                        GetCharmInfo()->SetIsCommandFollow(true);
                                        GetCharmInfo()->SetIsFollowing(false);
                                        GetMotionMaster()->MoveFollow(charmer, PET_FOLLOW_DIST, GetFollowAngle());
                                    }

                                    m_tempoldTarget = nullptr;
                                    m_tempspellIsPositive = false;
                                }
                            }
                        }
                    }
                    else
                    {
                        m_tempspell = 0;
                        m_tempspellTarget = nullptr;
                        m_tempoldTarget = nullptr;
                        m_tempspellIsPositive = false;

                        Unit* victim = charmer->GetVictim();
                        if (victim && victim->IsAlive())
                        {
                            StopMoving();
                            GetMotionMaster()->Clear(false);
                            GetMotionMaster()->MoveIdle();

                            GetCharmInfo()->SetIsCommandAttack(true);
                            GetCharmInfo()->SetIsAtStay(false);
                            GetCharmInfo()->SetIsFollowing(false);
                            GetCharmInfo()->SetIsCommandFollow(false);
                            GetCharmInfo()->SetIsReturning(false);

                            if (ToCreature() && ToCreature()->IsAIEnabled)
                                ToCreature()->AI()->AttackStart(victim);
                        }
                        else
                        {
                            StopMoving();
                            GetMotionMaster()->Clear(false);
                            GetMotionMaster()->MoveIdle();

                            GetCharmInfo()->SetCommandState(COMMAND_FOLLOW);
                            GetCharmInfo()->SetIsCommandAttack(false);
                            GetCharmInfo()->SetIsAtStay(false);
                            GetCharmInfo()->SetIsReturning(true);
                            GetCharmInfo()->SetIsCommandFollow(true);
                            GetCharmInfo()->SetIsFollowing(false);
                            GetMotionMaster()->MoveFollow(charmer, PET_FOLLOW_DIST, GetFollowAngle());
                        }
                    }
                }

                if (getPetType() == HUNTER_PET)
                {
                    m_happinessTimer -= diff;
                    if (m_happinessTimer <= int32(0))
                    {
                        LoseHappiness();
                        m_happinessTimer += PET_LOSE_HAPPINES_INTERVAL;
                    }
                }

                break;
            }
        default:
            break;
    }

    Creature::Update(diff);
}

void Pet::LoseHappiness()
{
    uint32 curValue = GetPower(POWER_HAPPINESS);
    if (curValue <= 0)
        return;
    int32 addvalue = 670;                                   //value is 70/35/17/8/4 (per min) * 1000 / 8 (timer 7.5 secs)
    if (IsInCombat())                                        //we know in combat happiness fades faster, multiplier guess
        addvalue = int32(addvalue * 1.5f);
    ModifyPower(POWER_HAPPINESS, -addvalue);
}

HappinessState Pet::GetHappinessState()
{
    if (GetPower(POWER_HAPPINESS) < HAPPINESS_LEVEL_SIZE)
        return UNHAPPY;
    else if (GetPower(POWER_HAPPINESS) >= HAPPINESS_LEVEL_SIZE * 2)
        return HAPPY;
    else
        return CONTENT;
}

void Pet::Remove(PetSaveMode mode, bool returnreagent)
{
    m_owner->RemovePet(this, mode, returnreagent);
}

void Pet::GivePetXP(uint32 xp)
{
    if (getPetType() != HUNTER_PET)
        return;

    xp *= sWorld->getRate(RATE_XP_PET);

    if (xp < 1)
        return;

    if (!IsAlive())
        return;

    uint8 maxlevel = std::min((uint8)sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL), GetOwner()->getLevel());
    uint8 petlevel = getLevel();

    // If pet is detected to be at, or above(?) the players level, don't hand out XP
    if (petlevel >= maxlevel)
        return;

    uint32 nextLvlXP = GetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP);
    uint32 curXP = GetUInt32Value(UNIT_FIELD_PETEXPERIENCE);
    uint32 newXP = curXP + xp;

    // Check how much XP the pet should receive, and hand off have any left from previous levelups
    while (newXP >= nextLvlXP && petlevel < maxlevel)
    {
        // Subtract newXP from amount needed for nextlevel, and give pet the level
        newXP -= nextLvlXP;
        ++petlevel;

        GivePetLevel(petlevel);

        nextLvlXP = GetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP);
    }
    // Not affected by special conditions - give it new XP
    SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, petlevel < maxlevel ? newXP : 0);
}

void Pet::GivePetLevel(uint8 level)
{
    if (!level || level == getLevel())
        return;

    if (getPetType() == HUNTER_PET)
    {
        SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, 0);
        SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, uint32(sObjectMgr->GetXPForLevel(level)*sWorld->getRate(RATE_XP_PET_NEXT_LEVEL)));
    }

    InitStatsForLevel(level);
    InitLevelupSpellsForLevel();
    InitTalentForLevel();
}

bool Pet::CreateBaseAtCreature(Creature* creature)
{
    ASSERT(creature);

    if (!CreateBaseAtTamed(creature->GetCreatureTemplate(), creature->GetMap(), creature->GetPhaseMask()))
        return false;

    Relocate(creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), creature->GetOrientation());

    if (!IsPositionValid())
    {
        LOG_ERROR("server", "Pet %s not created base at creature. Suggested coordinates isn't valid (X: %f Y: %f)",
                       GetGUID().ToString().c_str(), GetPositionX(), GetPositionY());
        return false;
    }

    CreatureTemplate const* cinfo = GetCreatureTemplate();
    if (!cinfo)
    {
        LOG_ERROR("server", "CreateBaseAtCreature() failed, creatureInfo is missing!");
        return false;
    }

    SetDisplayId(creature->GetDisplayId());

    if (CreatureFamilyEntry const* cFamily = sCreatureFamilyStore.LookupEntry(cinfo->family))
        SetName(cFamily->Name[sWorld->GetDefaultDbcLocale()]);
    else
        SetName(creature->GetNameForLocaleIdx(sObjectMgr->GetDBCLocaleIndex()));

    return true;
}

bool Pet::CreateBaseAtCreatureInfo(CreatureTemplate const* cinfo, Unit* owner)
{
    if (!CreateBaseAtTamed(cinfo, owner->GetMap(), owner->GetPhaseMask()))
        return false;

    if (CreatureFamilyEntry const* cFamily = sCreatureFamilyStore.LookupEntry(cinfo->family))
        SetName(cFamily->Name[sWorld->GetDefaultDbcLocale()]);

    Relocate(owner->GetPositionX(), owner->GetPositionY(), owner->GetPositionZ(), owner->GetOrientation());

    return true;
}

bool Pet::CreateBaseAtTamed(CreatureTemplate const* cinfo, Map* map, uint32 phaseMask)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("entities.pet", "Pet::CreateBaseForTamed");
#endif
    ObjectGuid::LowType guid = map->GenerateLowGuid<HighGuid::Pet>();
    uint32 pet_number = sObjectMgr->GeneratePetNumber();
    if (!Create(guid, map, phaseMask, cinfo->Entry, pet_number))
        return false;

    SetMaxPower(POWER_HAPPINESS, GetCreatePowers(POWER_HAPPINESS));
    SetPower(POWER_HAPPINESS, 166500);
    setPowerType(POWER_FOCUS);
    SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, 0);
    SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, 0);
    SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, uint32(sObjectMgr->GetXPForLevel(getLevel() + 1)* sWorld->getRate(RATE_XP_PET_NEXT_LEVEL)));
    SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);

    if (cinfo->type == CREATURE_TYPE_BEAST)
    {
        SetUInt32Value(UNIT_FIELD_BYTES_0, 0x02020100);
        SetSheath(SHEATH_STATE_MELEE);
        SetByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_RENAMED | UNIT_CAN_BE_ABANDONED);
    }

    return true;
}

// TODO: Move stat mods code to pet passive auras
bool Guardian::InitStatsForLevel(uint8 petlevel)
{
    CreatureTemplate const* cinfo = GetCreatureTemplate();
    ASSERT(cinfo);

    SetLevel(petlevel);
    SetCanModifyStats(true);

    Unit* owner = GetOwner();
    if (!owner) // just to be sure, asynchronous now
    {
        DespawnOrUnsummon(1000);
        return false;
    }

    //Determine pet type
    PetType petType = MAX_PET_TYPE;
    if (owner->GetTypeId() == TYPEID_PLAYER)
    {
        sScriptMgr->OnBeforeGuardianInitStatsForLevel(owner->ToPlayer(), this, cinfo, petType);

        if (IsPet())
        {
            if (petType == MAX_PET_TYPE)
            {
                // The petType was not overwritten by the hook, continue with default initialization
                if (owner->getClass() == CLASS_WARLOCK ||
                        owner->getClass() == CLASS_SHAMAN ||          // Fire Elemental
                        owner->getClass() == CLASS_DEATH_KNIGHT ||    // Risen Ghoul
                        owner->getClass() == CLASS_MAGE)              // Water Elemental with glyph
                    petType = SUMMON_PET;
                else if (owner->getClass() == CLASS_HUNTER)
                {
                    petType = HUNTER_PET;
                }
            }

            if (petType == HUNTER_PET)
                m_unitTypeMask |= UNIT_MASK_HUNTER_PET;
            else if (petType != SUMMON_PET)
                LOG_ERROR("server", "Unknown type pet %u is summoned by player class %u", GetEntry(), owner->getClass());
        }
    }

    uint32 creature_ID = (petType == HUNTER_PET) ? 1 : cinfo->Entry;

    SetMeleeDamageSchool(SpellSchools(cinfo->dmgschool));

    SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, float(petlevel * 50));

    uint32 attackTime = BASE_ATTACK_TIME;
    if (owner->getClass() != CLASS_HUNTER && cinfo->BaseAttackTime >= 1000)
        attackTime = cinfo->BaseAttackTime;

    SetAttackTime(BASE_ATTACK, attackTime);
    SetAttackTime(OFF_ATTACK, attackTime);
    SetAttackTime(RANGED_ATTACK, BASE_ATTACK_TIME);

    SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);

    //scale
    CreatureFamilyEntry const* cFamily = sCreatureFamilyStore.LookupEntry(cinfo->family);
    if (cFamily && cFamily->minScale > 0.0f && petType == HUNTER_PET)
    {
        float scale;
        if (getLevel() >= cFamily->maxScaleLevel)
            scale = 1.0f;
        else if (getLevel() <= cFamily->minScaleLevel)
            scale = 0.5f;
        else
            scale = 0.5f + 0.5f * float(getLevel() - cFamily->minScaleLevel) / float(cFamily->maxScaleLevel  - cFamily->minScaleLevel);

        SetObjectScale(scale);
    }

    // Resistance
    // xinef: hunter pets should not inherit template resistances
    if (!IsHunterPet())
        for (uint8 i = SPELL_SCHOOL_HOLY; i < MAX_SPELL_SCHOOL; ++i)
            SetModifierValue(UnitMods(UNIT_MOD_RESISTANCE_START + i), BASE_VALUE, float(cinfo->resistance[i]));

    //health, mana, armor and resistance
    PetLevelInfo const* pInfo = sObjectMgr->GetPetLevelInfo(creature_ID, petlevel);
    if (pInfo)                                      // exist in DB
    {
        SetCreateHealth(pInfo->health);
        SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, (float)pInfo->health);
        if (petType != HUNTER_PET) //hunter pet use focus
        {
            SetCreateMana(pInfo->mana);
            SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, (float)pInfo->mana);
        }

        if (pInfo->armor > 0)
            SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, float(pInfo->armor));

        for (uint8 stat = 0; stat < MAX_STATS; ++stat)
            SetCreateStat(Stats(stat), float(pInfo->stats[stat]));
    }
    else                                            // not exist in DB, use some default fake data
    {
        // remove elite bonuses included in DB values
        CreatureBaseStats const* stats = sObjectMgr->GetCreatureBaseStats(petlevel, cinfo->unit_class);
        // xinef: multiply base values by creature_template factors!
        float factorHealth = owner->GetTypeId() == TYPEID_PLAYER ? std::min(1.0f, cinfo->ModHealth) : cinfo->ModHealth;
        float factorMana = owner->GetTypeId() == TYPEID_PLAYER ? std::min(1.0f, cinfo->ModMana) : cinfo->ModMana;

        SetCreateHealth(std::max<uint32>(1, stats->BaseHealth[cinfo->expansion]*factorHealth));
        SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, GetCreateHealth());
        SetCreateMana(stats->BaseMana * factorMana);
        SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, GetCreateMana());

        // xinef: added some multipliers so debuffs can affect pets in any way...
        SetCreateStat(STAT_STRENGTH, 22 + 2 * petlevel);
        SetCreateStat(STAT_AGILITY, 22 + 1.5f * petlevel);
        SetCreateStat(STAT_STAMINA, 25 + 2 * petlevel);
        SetCreateStat(STAT_INTELLECT, 28 + 2 * petlevel);
        SetCreateStat(STAT_SPIRIT, 27 + 1.5f * petlevel);
    }

    switch (petType)
    {
        case HUNTER_PET:
            {
                SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel - (petlevel / 4)));
                SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel + (petlevel / 4)));
                SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, uint32(sObjectMgr->GetXPForLevel(petlevel)* sWorld->getRate(RATE_XP_PET_NEXT_LEVEL)));
                break;
            }
        case SUMMON_PET:
            {
                if (pInfo)
                {
                    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(pInfo->min_dmg));
                    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(pInfo->max_dmg));
                }
                else
                {
                    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel - (petlevel / 4)));
                    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel + (petlevel / 4)));
                }

                switch(GetEntry())
                {
                    case NPC_FELGUARD:
                        {
                            // xinef: Glyph of Felguard, so ugly im crying... no appropriate spell
                            if (AuraEffect* aurEff = owner->GetAuraEffectDummy(SPELL_GLYPH_OF_FELGUARD))
                                SetModifierValue(UNIT_MOD_ATTACK_POWER, TOTAL_PCT, 1.0f + float(aurEff->GetAmount() / 100.0f));

                            break;
                        }
                    case NPC_WATER_ELEMENTAL_PERM:
                        {
                            AddAura(SPELL_PET_AVOIDANCE, this);
                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_MAGE_PET_SCALING_01, this);
                            AddAura(SPELL_MAGE_PET_SCALING_02, this);
                            AddAura(SPELL_MAGE_PET_SCALING_03, this);
                            AddAura(SPELL_MAGE_PET_SCALING_04, this);
                            break;
                        }
                }
                break;
            }
        default:
            {
                switch (GetEntry())
                {
                    case NPC_FIRE_ELEMENTAL:
                        {
                            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel * 3.5f - petlevel));
                            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel * 3.5f + petlevel));
                            AddAura(SPELL_PET_AVOIDANCE, this);
                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_FIRE_ELEMENTAL_SCALING_01, this);
                            AddAura(SPELL_FIRE_ELEMENTAL_SCALING_02, this);
                            AddAura(SPELL_FIRE_ELEMENTAL_SCALING_03, this);
                            AddAura(SPELL_FIRE_ELEMENTAL_SCALING_04, this);
                            break;
                        }
                    case NPC_EARTH_ELEMENTAL:
                        {
                            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel * 2.0f - petlevel));
                            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel * 2.0f + petlevel));
                            AddAura(SPELL_PET_AVOIDANCE, this);
                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_EARTH_ELEMENTAL_SCALING_01, this);
                            AddAura(SPELL_EARTH_ELEMENTAL_SCALING_02, this);
                            AddAura(SPELL_EARTH_ELEMENTAL_SCALING_03, this);
                            AddAura(SPELL_EARTH_ELEMENTAL_SCALING_04, this);
                            break;
                        }
                    case NPC_INFERNAL:
                        {
                            float highAmt = petlevel / 11.0f;
                            float lowAmt = petlevel / 12.0f;
                            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, lowAmt * lowAmt * lowAmt);
                            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, highAmt * highAmt * highAmt);

                            AddAura(SPELL_PET_AVOIDANCE, this);
                            AddAura(SPELL_WARLOCK_PET_SCALING_05, this);
                            AddAura(SPELL_INFERNAL_SCALING_01, this);
                            AddAura(SPELL_INFERNAL_SCALING_02, this);
                            AddAura(SPELL_INFERNAL_SCALING_03, this);
                            AddAura(SPELL_INFERNAL_SCALING_04, this);
                            break;
                        }
                    case NPC_DOOMGUARD:
                        {
                            float highAmt = petlevel / 11.0f;
                            float lowAmt = petlevel / 12.0f;
                            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, lowAmt * lowAmt * lowAmt);
                            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, highAmt * highAmt * highAmt);

                            AddAura(SPELL_PET_AVOIDANCE, this);
                            AddAura(SPELL_WARLOCK_PET_SCALING_01, this);
                            AddAura(SPELL_WARLOCK_PET_SCALING_02, this);
                            AddAura(SPELL_WARLOCK_PET_SCALING_03, this);
                            AddAura(SPELL_WARLOCK_PET_SCALING_04, this);
                            AddAura(SPELL_WARLOCK_PET_SCALING_05, this);
                            break;
                        }
                    case NPC_WATER_ELEMENTAL_TEMP:
                        {
                            AddAura(SPELL_PET_AVOIDANCE, this);
                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_MAGE_PET_SCALING_01, this);
                            AddAura(SPELL_MAGE_PET_SCALING_02, this);
                            AddAura(SPELL_MAGE_PET_SCALING_03, this);
                            AddAura(SPELL_MAGE_PET_SCALING_04, this);
                            break;
                        }
                    case NPC_TREANT: //force of nature
                        {
                            if (!pInfo)
                                SetCreateHealth(30 + 30 * petlevel);

                            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel * 2.5f - petlevel));
                            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel * 2.5f + petlevel));

                            AddAura(SPELL_PET_AVOIDANCE, this);
                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_TREANT_SCALING_01, this);
                            AddAura(SPELL_TREANT_SCALING_02, this);
                            AddAura(SPELL_TREANT_SCALING_03, this);
                            AddAura(SPELL_TREANT_SCALING_04, this);
                            break;
                        }
                    case NPC_SHADOWFIEND:
                        {
                            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel * 2.5f - petlevel));
                            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel * 2.5f + petlevel));

                            AddAura(SPELL_PET_AVOIDANCE, this);
                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_SHADOWFIEND_SCALING_01, this);
                            AddAura(SPELL_SHADOWFIEND_SCALING_02, this);
                            AddAura(SPELL_SHADOWFIEND_SCALING_03, this);
                            AddAura(SPELL_SHADOWFIEND_SCALING_04, this);
                            break;
                        }
                    case NPC_FERAL_SPIRIT:
                        {
                            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel * 4.0f - petlevel));
                            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel * 4.0f + petlevel));

                            AddAura(SPELL_PET_AVOIDANCE, this);
                            AddAura(SPELL_FERAL_SPIRIT_SPIRIT_HUNT, this);
                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_FERAL_SPIRIT_SCALING_01, this);
                            AddAura(SPELL_FERAL_SPIRIT_SCALING_02, this);
                            AddAura(SPELL_FERAL_SPIRIT_SCALING_03, this);
                            break;
                        }
                    case NPC_MIRROR_IMAGE: // Mirror Image
                        {
                            SetDisplayId(owner->GetDisplayId());
                            if (!pInfo)
                            {
                                SetCreateMana(28 + 30 * petlevel);
                                SetCreateHealth(28 + 10 * petlevel);
                            }

                            AddAura(SPELL_PET_AVOIDANCE, this);
                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_MAGE_PET_SCALING_01, this);
                            AddAura(SPELL_MAGE_PET_SCALING_02, this);
                            AddAura(SPELL_MAGE_PET_SCALING_03, this);
                            AddAura(SPELL_MAGE_PET_SCALING_04, this);
                            break;
                        }
                    case NPC_EBON_GARGOYLE: // Ebon Gargoyle
                        {
                            if (!pInfo)
                            {
                                SetCreateMana(28 + 10 * petlevel);
                                SetCreateHealth(28 + 30 * petlevel);
                            }

                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_DK_PET_SCALING_01, this);
                            AddAura(SPELL_DK_PET_SCALING_02, this);
                            AddAura(SPELL_DK_PET_SCALING_03, this);
                            break;
                        }
                    case NPC_BLOODWORM:
                        {
                            // Xinef: Hit / Expertise scaling
                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_PET_AVOIDANCE, this);
                            SetCreateHealth(4 * petlevel);
                            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel - 30 - (petlevel / 4) + owner->GetTotalAttackPowerValue(BASE_ATTACK) * 0.006f));
                            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel - 30 + (petlevel / 4) + owner->GetTotalAttackPowerValue(BASE_ATTACK) * 0.006f));
                            SetReactState(REACT_DEFENSIVE);
                            break;
                        }
                    case NPC_ARMY_OF_THE_DEAD:
                        {
                            AddAura(SPELL_HUNTER_PET_SCALING_04, this);
                            AddAura(SPELL_DK_PET_SCALING_01, this);
                            AddAura(SPELL_DK_PET_SCALING_02, this);
                            AddAura(SPELL_DK_PET_SCALING_03, this);
                            AddAura(SPELL_PET_AVOIDANCE, this);

                            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel - (petlevel / 4)));
                            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel + (petlevel / 4)));
                            break;
                        }
                    case NPC_GENERIC_IMP:
                    case NPC_GENERIC_VOIDWALKER:
                        {
                            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel - (petlevel / 4)));
                            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel + (petlevel / 4)));
                            break;
                        }
                }
                break;
            }
    }

    // Can be summon and guardian
    if (GetEntry() == NPC_RISEN_GHOUL)
    {
        // 100% energy after summon
        SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));

        // xinef: fixes orc death knight command racial
        if (owner->getRace() == RACE_ORC)
            CastSpell(this, SPELL_ORC_RACIAL_COMMAND, true, nullptr, nullptr, owner->GetGUID());

        // Avoidance, Night of the Dead
        if (Aura* aur = AddAura(SPELL_NIGHT_OF_THE_DEAD_AVOIDANCE, this))
            if (AuraEffect* aurEff = owner->GetAuraEffect(SPELL_AURA_ADD_FLAT_MODIFIER, SPELLFAMILY_DEATHKNIGHT, 2718, 0))
                if (aur->GetEffect(0))
                    aur->GetEffect(0)->SetAmount(-aurEff->GetSpellInfo()->Effects[EFFECT_2].CalcValue());

        AddAura(SPELL_HUNTER_PET_SCALING_04, this);
        // Added to perm ghoul by default
        if (!IsPet())
        {
            AddAura(SPELL_DK_PET_SCALING_01, this);
            AddAura(SPELL_DK_PET_SCALING_02, this);
        }
    }

    sScriptMgr->OnInitStatsForLevel(this, petlevel);

    UpdateAllStats();

    SetFullHealth();
    SetPower(POWER_MANA, GetMaxPower(POWER_MANA));

    if (owner->GetTypeId() == TYPEID_PLAYER)
        sScriptMgr->OnAfterGuardianInitStatsForLevel(owner->ToPlayer(), this);

    return true;
}

bool Pet::HaveInDiet(ItemTemplate const* item) const
{
    if (!item->FoodType)
        return false;

    CreatureTemplate const* cInfo = GetCreatureTemplate();
    if (!cInfo)
        return false;

    CreatureFamilyEntry const* cFamily = sCreatureFamilyStore.LookupEntry(cInfo->family);
    if (!cFamily)
        return false;

    uint32 diet = cFamily->petFoodMask;
    uint32 FoodMask = 1 << (item->FoodType - 1);
    return diet & FoodMask;
}

uint32 Pet::GetCurrentFoodBenefitLevel(uint32 itemlevel) const
{
    // -5 or greater food level
    if (getLevel() <= itemlevel + 5)                         //possible to feed level 60 pet with level 55 level food for full effect
        return 35000;
    // -10..-6
    else if (getLevel() <= itemlevel + 10)                   //pure guess, but sounds good
        return 17000;
    // -14..-11
    else if (getLevel() <= itemlevel + 14)                   //level 55 food gets green on 70, makes sense to me
        return 8000;
    // -15 or less
    else
        return 0;                                           //food too low level
}

void Pet::_LoadSpellCooldowns(PreparedQueryResult result)
{
    m_CreatureSpellCooldowns.clear();

    if (result)
    {
        time_t curTime = time(nullptr);

        PacketCooldowns cooldowns;
        WorldPacket data;

        do
        {
            Field* fields = result->Fetch();

            uint32 spell_id = fields[0].GetUInt32();
            time_t db_time  = time_t(fields[1].GetUInt32());

            if (!sSpellMgr->GetSpellInfo(spell_id))
            {
                LOG_ERROR("server", "Pet %u have unknown spell %u in `pet_spell_cooldown`, skipping.", m_charmInfo->GetPetNumber(), spell_id);
                continue;
            }

            // skip outdated cooldown
            if (db_time <= curTime)
                continue;

            uint32 cooldown = (db_time - curTime) * IN_MILLISECONDS;
            cooldowns[spell_id] = cooldown;
            _AddCreatureSpellCooldown(spell_id, cooldown);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            LOG_DEBUG("entities.pet", "Pet (Number: %u) spell %u cooldown loaded (%u secs).", m_charmInfo->GetPetNumber(), spell_id, uint32(db_time - curTime));
#endif
        } while (result->NextRow());

        if (!cooldowns.empty() && GetOwner())
        {
            BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, cooldowns);
            GetOwner()->GetSession()->SendPacket(&data);
        }
    }
}

void Pet::_SaveSpellCooldowns(SQLTransaction& trans, bool logout)
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELL_COOLDOWNS);
    stmt->setUInt32(0, m_charmInfo->GetPetNumber());
    trans->Append(stmt);

    time_t curTime = time(nullptr);
    uint32 checkTime = World::GetGameTimeMS() + 30 * IN_MILLISECONDS;

    // remove oudated and save active
    CreatureSpellCooldowns::iterator itr, itr2;
    for (itr = m_CreatureSpellCooldowns.begin(); itr != m_CreatureSpellCooldowns.end();)
    {
        itr2 = itr;
        ++itr;
        if (itr2->second <= World::GetGameTimeMS() + 1000)
            m_CreatureSpellCooldowns.erase(itr2);
        else if (logout || itr2->second > checkTime)
        {
            uint32 cooldown = ((itr2->second - World::GetGameTimeMS()) / IN_MILLISECONDS) + curTime;
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PET_SPELL_COOLDOWN);
            stmt->setUInt32(0, m_charmInfo->GetPetNumber());
            stmt->setUInt32(1, itr2->first);
            stmt->setUInt32(2, cooldown);
            trans->Append(stmt);
        }
    }
}

void Pet::_LoadSpells(PreparedQueryResult result)
{
    if (result)
    {
        do
        {
            Field* fields = result->Fetch();

            addSpell(fields[0].GetUInt32(), ActiveStates(fields[1].GetUInt8()), PETSPELL_UNCHANGED);
        } while (result->NextRow());
    }
}

void Pet::_SaveSpells(SQLTransaction& trans)
{
    for (PetSpellMap::iterator itr = m_spells.begin(), next = m_spells.begin(); itr != m_spells.end(); itr = next)
    {
        ++next;

        // prevent saving family passives to DB
        if (itr->second.type == PETSPELL_FAMILY)
            continue;

        PreparedStatement* stmt;

        switch (itr->second.state)
        {
            case PETSPELL_REMOVED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELL_BY_SPELL);
                stmt->setUInt32(0, m_charmInfo->GetPetNumber());
                stmt->setUInt32(1, itr->first);
                trans->Append(stmt);

                m_spells.erase(itr);
                continue;
            case PETSPELL_CHANGED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELL_BY_SPELL);
                stmt->setUInt32(0, m_charmInfo->GetPetNumber());
                stmt->setUInt32(1, itr->first);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PET_SPELL);
                stmt->setUInt32(0, m_charmInfo->GetPetNumber());
                stmt->setUInt32(1, itr->first);
                stmt->setUInt8(2, itr->second.active);
                trans->Append(stmt);

                break;
            case PETSPELL_NEW:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PET_SPELL);
                stmt->setUInt32(0, m_charmInfo->GetPetNumber());
                stmt->setUInt32(1, itr->first);
                stmt->setUInt8(2, itr->second.active);
                trans->Append(stmt);
                break;
            case PETSPELL_UNCHANGED:
                continue;
        }
        itr->second.state = PETSPELL_UNCHANGED;
    }
}

void Pet::_LoadAuras(PreparedQueryResult result, uint32 timediff)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("entities.pet", "Loading auras for pet %s", GetGUID().ToString().c_str());
#endif

    if (result)
    {
        do
        {
            int32 damage[3];
            int32 baseDamage[3];
            Field* fields = result->Fetch();
            ObjectGuid caster_guid = ObjectGuid(fields[0].GetUInt64());
            // nullptr guid stored - pet is the caster of the spell - see Pet::_SaveAuras
            if (!caster_guid)
                caster_guid = GetGUID();
            uint32 spellid = fields[1].GetUInt32();
            uint8 effmask = fields[2].GetUInt8();
            uint8 recalculatemask = fields[3].GetUInt8();
            uint8 stackcount = fields[4].GetUInt8();
            damage[0] = fields[5].GetInt32();
            damage[1] = fields[6].GetInt32();
            damage[2] = fields[7].GetInt32();
            baseDamage[0] = fields[8].GetInt32();
            baseDamage[1] = fields[9].GetInt32();
            baseDamage[2] = fields[10].GetInt32();
            int32 maxduration = fields[11].GetInt32();
            int32 remaintime = fields[12].GetInt32();
            uint8 remaincharges = fields[13].GetUInt8();

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellid);
            if (!spellInfo)
            {
                LOG_ERROR("server", "Unknown aura (spellid %u), ignore.", spellid);
                continue;
            }

            // avoid higher level auras if any, and adjust
            SpellInfo const* scaledSpellInfo = spellInfo->GetAuraRankForLevel(getLevel());
            if (scaledSpellInfo != spellInfo)
                spellInfo = scaledSpellInfo;

            // again after level check
            if (!spellInfo)
                continue;

            // negative effects should continue counting down after logout
            if (remaintime != -1 && !spellInfo->IsPositive())
            {
                if (remaintime / IN_MILLISECONDS <= int32(timediff))
                    continue;

                remaintime -= timediff * IN_MILLISECONDS;
            }

            // prevent wrong values of remaincharges
            if (spellInfo->ProcCharges)
            {
                if (remaincharges <= 0 || remaincharges > spellInfo->ProcCharges)
                    remaincharges = spellInfo->ProcCharges;
            }
            else
                remaincharges = 0;

            if (Aura* aura = Aura::TryCreate(spellInfo, effmask, this, nullptr, &baseDamage[0], nullptr, caster_guid))
            {
                if (!aura->CanBeSaved())
                {
                    aura->Remove();
                    continue;
                }
                aura->SetLoadedState(maxduration, remaintime, remaincharges, stackcount, recalculatemask, &damage[0]);
                aura->ApplyForTargets();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                LOG_DEBUG("server", "Added aura spellid %u, effectmask %u", spellInfo->Id, effmask);
#endif
            }
        } while (result->NextRow());
    }
}

void Pet::_SaveAuras(SQLTransaction& trans, bool logout)
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_AURAS);
    stmt->setUInt32(0, m_charmInfo->GetPetNumber());
    trans->Append(stmt);

    for (AuraMap::const_iterator itr = m_ownedAuras.begin(); itr != m_ownedAuras.end(); ++itr)
    {
        // check if the aura has to be saved
        if (!itr->second->CanBeSaved() || IsPetAura(itr->second))
            continue;

        Aura* aura = itr->second;
        if (!logout && aura->GetDuration() < 60 * IN_MILLISECONDS)
            continue;

        // dont save infinite negative auras! (lavas, transformations etc)
        if (aura->IsPermanent() && !aura->GetSpellInfo()->IsPositive())
            continue;

        // pussywizard: don't save auras that cannot be cancelled (needed for ICC buff on pets/summons)
        if (aura->GetSpellInfo()->HasAttribute(SPELL_ATTR0_NO_AURA_CANCEL))
            continue;

        // xinef: don't save hidden auras
        if (aura->GetSpellInfo()->HasAttribute(SPELL_ATTR1_NO_AURA_ICON))
            continue;

        // Xinef: Dont save auras with model change
        if (aura->GetSpellInfo()->HasAura(SPELL_AURA_TRANSFORM))
            continue;

        // xinef: don's save auras with interrupt flags on map change
        if (aura->GetSpellInfo()->AuraInterruptFlags & AURA_INTERRUPT_FLAG_CHANGE_MAP)
            continue;

        int32 damage[MAX_SPELL_EFFECTS];
        int32 baseDamage[MAX_SPELL_EFFECTS];
        uint8 effMask = 0;
        uint8 recalculateMask = 0;
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (aura->GetEffect(i))
            {
                baseDamage[i] = aura->GetEffect(i)->GetBaseAmount();
                damage[i] = aura->GetEffect(i)->GetAmount();
                effMask |= (1 << i);
                if (aura->GetEffect(i)->CanBeRecalculated())
                    recalculateMask |= (1 << i);
            }
            else
            {
                baseDamage[i] = 0;
                damage[i] = 0;
            }
        }

        // don't save guid of caster in case we are caster of the spell - guid for pet is generated every pet load, so it won't match saved guid anyways
        ObjectGuid casterGUID = (itr->second->GetCasterGUID() == GetGUID()) ? ObjectGuid::Empty : itr->second->GetCasterGUID();

        uint8 index = 0;

        PreparedStatement* stmt2 = CharacterDatabase.GetPreparedStatement(CHAR_INS_PET_AURA);
        stmt2->setUInt32(index++, m_charmInfo->GetPetNumber());
        stmt2->setUInt64(index++, casterGUID.GetRawValue());
        stmt2->setUInt32(index++, itr->second->GetId());
        stmt2->setUInt8(index++, effMask);
        stmt2->setUInt8(index++, recalculateMask);
        stmt2->setUInt8(index++, itr->second->GetStackAmount());
        stmt2->setInt32(index++, damage[0]);
        stmt2->setInt32(index++, damage[1]);
        stmt2->setInt32(index++, damage[2]);
        stmt2->setInt32(index++, baseDamage[0]);
        stmt2->setInt32(index++, baseDamage[1]);
        stmt2->setInt32(index++, baseDamage[2]);
        stmt2->setInt32(index++, itr->second->GetMaxDuration());
        stmt2->setInt32(index++, itr->second->GetDuration());
        stmt2->setUInt8(index++, itr->second->GetCharges());

        trans->Append(stmt2);
    }
}

bool Pet::addSpell(uint32 spellId, ActiveStates active /*= ACT_DECIDE*/, PetSpellState state /*= PETSPELL_NEW*/, PetSpellType type /*= PETSPELL_NORMAL*/)
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
    {
        // do pet spell book cleanup
        if (state == PETSPELL_UNCHANGED)                    // spell load case
        {
            LOG_ERROR("server", "Pet::addSpell: Non-existed in SpellStore spell #%u request, deleting for all pets in `pet_spell`.", spellId);

            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_PET_SPELL);

            stmt->setUInt32(0, spellId);

            CharacterDatabase.Execute(stmt);
        }
        else
            LOG_ERROR("server", "Pet::addSpell: Non-existed in SpellStore spell #%u request.", spellId);

        return false;
    }

    PetSpellMap::iterator itr = m_spells.find(spellId);
    if (itr != m_spells.end())
    {
        if (itr->second.state == PETSPELL_REMOVED)
        {
            m_spells.erase(itr);
            state = PETSPELL_CHANGED;
        }
        else if (state == PETSPELL_UNCHANGED && itr->second.state != PETSPELL_UNCHANGED)
        {
            // can be in case spell loading but learned at some previous spell loading
            itr->second.state = PETSPELL_UNCHANGED;

            ToggleAutocast(spellInfo, active == ACT_ENABLED);
            return false;
        }
        else
            return false;
    }

    PetSpell newspell;
    newspell.state = state;
    newspell.type = type;

    if (active == ACT_DECIDE)                               // active was not used before, so we save it's autocast/passive state here
    {
        if (spellInfo->IsAutocastable())
            newspell.active = ACT_DISABLED;
        else
            newspell.active = ACT_PASSIVE;
    }
    else
        newspell.active = active;

    // talent: unlearn all other talent ranks (high and low)
    if (TalentSpellPos const* talentPos = GetTalentSpellPos(spellId))
    {
        if (TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentPos->talent_id))
        {
            for (uint8 i = 0; i < MAX_TALENT_RANK; ++i)
            {
                // skip learning spell and no rank spell case
                uint32 rankSpellId = talentInfo->RankID[i];
                if (!rankSpellId || rankSpellId == spellId)
                    continue;

                // skip unknown ranks
                if (!HasSpell(rankSpellId))
                    continue;
                removeSpell(rankSpellId, false, false);
            }
        }
    }
    else if (spellInfo->IsRanked())
    {
        for (PetSpellMap::const_iterator itr2 = m_spells.begin(); itr2 != m_spells.end(); ++itr2)
        {
            if (itr2->second.state == PETSPELL_REMOVED)
                continue;

            SpellInfo const* oldRankSpellInfo = sSpellMgr->GetSpellInfo(itr2->first);

            if (!oldRankSpellInfo)
                continue;

            if (spellInfo->IsDifferentRankOf(oldRankSpellInfo))
            {
                // replace by new high rank
                if (spellInfo->IsHighRankOf(oldRankSpellInfo))
                {
                    newspell.active = itr2->second.active;

                    if (newspell.active == ACT_ENABLED)
                        ToggleAutocast(oldRankSpellInfo, false);

                    unlearnSpell(itr2->first, false, false);
                    break;
                }
                // ignore new lesser rank
                else
                    return false;
            }
        }
    }

    m_spells[spellId] = newspell;

    if (spellInfo->IsPassive())
        CastSpell(this, spellId, true);
    else
        m_charmInfo->AddSpellToActionBar(spellInfo);

    // unapply aura stats if dont meet requirements
    // handle only if player is not loaded, loading is handled in loadfromdb
    if (!m_loading)
        if (Aura* aura = GetAura(spellId))
        {
            if (aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTHLESS_35_PERCENT ||
                    aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTH_ABOVE_75_PERCENT ||
                    aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTHLESS_20_PERCENT )
                if (!HasAuraState((AuraStateType)aura->GetSpellInfo()->CasterAuraState))
                    aura->HandleAllEffects(aura->GetApplicationOfTarget(GetGUID()), AURA_EFFECT_HANDLE_REAL, false);
        }

    ToggleAutocast(spellInfo, (newspell.active == ACT_ENABLED));

    uint32 talentCost = GetTalentSpellCost(spellId);
    if (talentCost)
    {
        int32 free_points = GetMaxTalentPointsForLevel(getLevel());
        m_usedTalentCount += talentCost;
        // update free talent points
        free_points -= m_usedTalentCount;
        SetFreeTalentPoints(free_points > 0 ? free_points : 0);
    }
    return true;
}

bool Pet::learnSpell(uint32 spell_id)
{
    // prevent duplicated entires in spell book
    if (!addSpell(spell_id))
        return false;

    if (!m_loading)
    {
        WorldPacket data(SMSG_PET_LEARNED_SPELL, 4);
        data << uint32(spell_id);
        m_owner->GetSession()->SendPacket(&data);
        m_owner->PetSpellInitialize();
    }
    return true;
}

void Pet::InitLevelupSpellsForLevel()
{
    uint8 level = getLevel();

    if (PetLevelupSpellSet const* levelupSpells = GetCreatureTemplate()->family ? sSpellMgr->GetPetLevelupSpellList(GetCreatureTemplate()->family) : nullptr)
    {
        // PetLevelupSpellSet ordered by levels, process in reversed order
        for (PetLevelupSpellSet::const_reverse_iterator itr = levelupSpells->rbegin(); itr != levelupSpells->rend(); ++itr)
        {
            // will called first if level down
            if (itr->first > level && sScriptMgr->CanUnlearnSpellSet(this, itr->first, itr->second))
                unlearnSpell(itr->second, true);                 // will learn prev rank if any
            // will called if level up
            else
                learnSpell(itr->second);                        // will unlearn prev rank if any
        }
    }

    int32 petSpellsId = GetCreatureTemplate()->PetSpellDataId ? -(int32)GetCreatureTemplate()->PetSpellDataId : GetEntry();

    // default spells (can be not learned if pet level (as owner level decrease result for example) less first possible in normal game)
    if (PetDefaultSpellsEntry const* defSpells = sSpellMgr->GetPetDefaultSpellsEntry(petSpellsId))
    {
        for (uint8 i = 0; i < MAX_CREATURE_SPELL_DATA_SLOT; ++i)
        {
            SpellInfo const* spellEntry = sSpellMgr->GetSpellInfo(defSpells->spellid[i]);
            if (!spellEntry)
                continue;

            // will called first if level down
            if (spellEntry->SpellLevel > level && sScriptMgr->CanUnlearnSpellDefault(this, spellEntry))
                unlearnSpell(spellEntry->Id, true);
            // will called if level up
            else
                learnSpell(spellEntry->Id);
        }
    }
}

bool Pet::unlearnSpell(uint32 spell_id, bool learn_prev, bool clear_ab)
{
    if (removeSpell(spell_id, learn_prev, clear_ab))
    {
        if (!m_loading)
        {
            WorldPacket data(SMSG_PET_REMOVED_SPELL, 4);
            data << uint32(spell_id);
            m_owner->GetSession()->SendPacket(&data);
        }
        return true;
    }
    return false;
}

bool Pet::removeSpell(uint32 spell_id, bool learn_prev, bool clear_ab)
{
    PetSpellMap::iterator itr = m_spells.find(spell_id);
    if (itr == m_spells.end())
        return false;

    if (itr->second.state == PETSPELL_REMOVED)
        return false;

    if (itr->second.state == PETSPELL_NEW)
        m_spells.erase(itr);
    else
        itr->second.state = PETSPELL_REMOVED;

    RemoveAurasDueToSpell(spell_id);

    uint32 talentCost = GetTalentSpellCost(spell_id);
    if (talentCost > 0)
    {
        if (m_usedTalentCount > talentCost)
            m_usedTalentCount -= talentCost;
        else
            m_usedTalentCount = 0;
        // update free talent points
        int32 free_points = GetMaxTalentPointsForLevel(getLevel()) - m_usedTalentCount;
        SetFreeTalentPoints(free_points > 0 ? free_points : 0);
    }

    if (learn_prev)
    {
        if (uint32 prev_id = sSpellMgr->GetPrevSpellInChain (spell_id))
            learnSpell(prev_id);
        else
            learn_prev = false;
    }

    // if remove last rank or non-ranked then update action bar at server and client if need
    if (clear_ab && !learn_prev && m_charmInfo->RemoveSpellFromActionBar(spell_id))
    {
        if (!m_loading)
        {
            // need update action bar for last removed rank
            if (Unit* owner = GetOwner())
                if (owner->GetTypeId() == TYPEID_PLAYER)
                    owner->ToPlayer()->PetSpellInitialize();
        }
    }

    return true;
}

void Pet::CleanupActionBar()
{
    for (uint8 i = 0; i < MAX_UNIT_ACTION_BAR_INDEX; ++i)
        if (UnitActionBarEntry const* ab = m_charmInfo->GetActionBarEntry(i))
            if (ab->GetAction() && ab->IsActionBarForSpell())
            {
                if (!HasSpell(ab->GetAction()))
                    m_charmInfo->SetActionBar(i, 0, ACT_PASSIVE);
                else if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(ab->GetAction()))
                    ToggleAutocast(spellInfo, ab->GetType() == ACT_ENABLED);
            }
}

void Pet::InitPetCreateSpells()
{
    m_charmInfo->InitPetActionBar();
    m_spells.clear();

    LearnPetPassives();
    InitLevelupSpellsForLevel();

    CastPetAuras(false);
}

bool Pet::resetTalents()
{
    Unit* owner = GetOwner();
    if (!owner || owner->GetTypeId() != TYPEID_PLAYER)
        return false;

    if (!sScriptMgr->CanResetTalents(this))
        return false;

    // not need after this call
    if (owner->ToPlayer()->HasAtLoginFlag(AT_LOGIN_RESET_PET_TALENTS))
        owner->ToPlayer()->RemoveAtLoginFlag(AT_LOGIN_RESET_PET_TALENTS, true);

    CreatureTemplate const* ci = GetCreatureTemplate();
    if (!ci)
        return false;
    // Check pet talent type
    CreatureFamilyEntry const* pet_family = sCreatureFamilyStore.LookupEntry(ci->family);
    if (!pet_family || pet_family->petTalentType < 0)
        return false;

    Player* player = owner->ToPlayer();

    uint8 level = getLevel();
    uint32 talentPointsForLevel = GetMaxTalentPointsForLevel(level);

    if (m_usedTalentCount == 0)
    {
        SetFreeTalentPoints(talentPointsForLevel);
        return false;
    }

    for (uint32 i = 0; i < sTalentStore.GetNumRows(); ++i)
    {
        TalentEntry const* talentInfo = sTalentStore.LookupEntry(i);

        if (!talentInfo)
            continue;

        TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);

        if (!talentTabInfo)
            continue;

        // unlearn only talents for pets family talent type
        if (!((1 << pet_family->petTalentType) & talentTabInfo->petTalentMask))
            continue;

        for (uint8 j = 0; j < MAX_TALENT_RANK; ++j)
        {
            for (PetSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end();)
            {
                if (itr->second.state == PETSPELL_REMOVED)
                {
                    ++itr;
                    continue;
                }
                // remove learned spells (all ranks)
                uint32 itrFirstId = sSpellMgr->GetFirstSpellInChain(itr->first);

                // unlearn if first rank is talent or learned by talent
                if (itrFirstId == talentInfo->RankID[j])
                {
                    unlearnSpell(itr->first, false);
                    itr = m_spells.begin();
                    continue;
                }
                else
                    ++itr;
            }
        }
    }

    SetFreeTalentPoints(talentPointsForLevel);

    if (!m_loading)
        player->PetSpellInitialize();
    return true;
}

void Pet::resetTalentsForAllPetsOf(Player* owner, Pet* online_pet /*= nullptr*/)
{
    // not need after this call
    if (owner->ToPlayer()->HasAtLoginFlag(AT_LOGIN_RESET_PET_TALENTS))
        owner->ToPlayer()->RemoveAtLoginFlag(AT_LOGIN_RESET_PET_TALENTS, true);

    // reset for online
    if (online_pet)
        online_pet->resetTalents();

    // now need only reset for offline pets (all pets except online case)
    uint32 except_petnumber = online_pet ? online_pet->GetCharmInfo()->GetPetNumber() : 0;

    // xinef: zomg! sync query
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PET);
    stmt->setUInt32(0, owner->GetGUID().GetCounter());
    stmt->setUInt32(1, except_petnumber);
    PreparedQueryResult resultPets = CharacterDatabase.Query(stmt);

    // no offline pets
    if (!resultPets)
        return;

    // xinef: zomg! sync query
    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PET_SPELL_LIST);
    stmt->setUInt32(0, owner->GetGUID().GetCounter());
    stmt->setUInt32(1, except_petnumber);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
        return;

    bool need_comma = false;
    std::ostringstream ss;
    ss << "DELETE FROM pet_spell WHERE guid IN (";

    do
    {
        Field* fields = resultPets->Fetch();

        uint32 id = fields[0].GetUInt32();

        if (need_comma)
            ss << ',';

        ss << id;

        need_comma = true;
    } while (resultPets->NextRow());

    ss << ") AND spell IN (";

    bool need_execute = false;
    do
    {
        Field* fields = result->Fetch();

        uint32 spell = fields[0].GetUInt32();

        if (!GetTalentSpellCost(spell))
            continue;

        if (need_execute)
            ss << ',';

        ss << spell;

        need_execute = true;
    } while (result->NextRow());

    if (!need_execute)
        return;

    ss << ')';

    CharacterDatabase.Execute(ss.str().c_str());
}

void Pet::InitTalentForLevel()
{
    uint8 level = getLevel();
    uint32 talentPointsForLevel = GetMaxTalentPointsForLevel(level);

    Unit* owner = GetOwner();
    if (!owner || owner->GetTypeId() != TYPEID_PLAYER)
        return;

    // Reset talents in case low level (on level down) or wrong points for level (hunter can unlearn TP increase talent)
    if (talentPointsForLevel == 0 || m_usedTalentCount > talentPointsForLevel)
        resetTalents(); // Remove all talent points

    SetFreeTalentPoints(talentPointsForLevel - m_usedTalentCount);

    if (!m_loading)
        owner->ToPlayer()->SendTalentsInfoData(true);
}

uint8 Pet::GetMaxTalentPointsForLevel(uint8 level)
{
    uint8 points = (level >= 20) ? ((level - 16) / 4) : 0;
    // Mod points from owner SPELL_AURA_MOD_PET_TALENT_POINTS
    if (Unit* owner = GetOwner())
        points += owner->GetTotalAuraModifier(SPELL_AURA_MOD_PET_TALENT_POINTS);

    sScriptMgr->OnCalculateMaxTalentPointsForLevel(this, level, points);

    return points;
}

void Pet::ToggleAutocast(SpellInfo const* spellInfo, bool apply)
{
    if (!spellInfo->IsAutocastable())
        return;

    uint32 spellid = spellInfo->Id;

    PetSpellMap::iterator itr = m_spells.find(spellid);
    if (itr == m_spells.end())
        return;

    uint32 i;

    if (apply)
    {
        for (i = 0; i < m_autospells.size() && m_autospells[i] != spellid; ++i)
            ;                                               // just search

        if (i == m_autospells.size())
        {
            m_autospells.push_back(spellid);

            if (itr->second.active != ACT_ENABLED)
            {
                itr->second.active = ACT_ENABLED;
                if (itr->second.state != PETSPELL_NEW)
                    itr->second.state = PETSPELL_CHANGED;
            }
        }
    }
    else
    {
        AutoSpellList::iterator itr2 = m_autospells.begin();
        for (i = 0; i < m_autospells.size() && m_autospells[i] != spellid; ++i, ++itr2)
            ;                                               // just search

        if (i < m_autospells.size())
        {
            m_autospells.erase(itr2);
            if (itr->second.active != ACT_DISABLED)
            {
                itr->second.active = ACT_DISABLED;
                if (itr->second.state != PETSPELL_NEW)
                    itr->second.state = PETSPELL_CHANGED;
            }
        }
    }
}

bool Pet::IsPermanentPetFor(Player* owner) const
{
    switch (getPetType())
    {
        case SUMMON_PET:
            switch (owner->getClass())
            {
                case CLASS_WARLOCK:
                    return GetCreatureTemplate()->type == CREATURE_TYPE_DEMON;
                case CLASS_DEATH_KNIGHT:
                    return GetCreatureTemplate()->type == CREATURE_TYPE_UNDEAD;
                case CLASS_MAGE:
                    return GetEntry() == 37994;
                default:
                    return false;
            }
        case HUNTER_PET:
            return true;
        default:
            return false;
    }
}

bool Pet::Create(ObjectGuid::LowType guidlow, Map* map, uint32 phaseMask, uint32 Entry, uint32 pet_number)
{
    ASSERT(map);
    SetMap(map);

    SetPhaseMask(phaseMask, false);

    Object::_Create(guidlow, pet_number, HighGuid::Pet);

    m_spawnId = guidlow;
    m_originalEntry = Entry;

    if (!InitEntry(Entry))
        return false;

    SetSheath(SHEATH_STATE_MELEE);

    return true;
}

bool Pet::HasSpell(uint32 spell) const
{
    PetSpellMap::const_iterator itr = m_spells.find(spell);
    return itr != m_spells.end() && itr->second.state != PETSPELL_REMOVED;
}

// Get all passive spells in our skill line
void Pet::LearnPetPassives()
{
    CreatureTemplate const* cInfo = GetCreatureTemplate();
    if (!cInfo)
        return;

    CreatureFamilyEntry const* cFamily = sCreatureFamilyStore.LookupEntry(cInfo->family);
    if (!cFamily)
        return;

    PetFamilySpellsStore::const_iterator petStore = sPetFamilySpellsStore.find(cFamily->ID);
    if (petStore != sPetFamilySpellsStore.end())
    {
        // For general hunter pets skill 270
        // Passive 01~10, Passive 00 (20782, not used), Ferocious Inspiration (34457)
        // Scale 01~03 (34902~34904, bonus from owner, not used)
        for (PetFamilySpellsSet::const_iterator petSet = petStore->second.begin(); petSet != petStore->second.end(); ++petSet)
            addSpell(*petSet, ACT_DECIDE, PETSPELL_NEW, PETSPELL_FAMILY);
    }
}

void Pet::CastPetAuras(bool current)
{
    Unit* owner = GetOwner();
    if (!owner || owner->GetTypeId() != TYPEID_PLAYER)
        return;

    if (!IsPermanentPetFor(owner->ToPlayer()))
        return;

    for (PetAuraSet::const_iterator itr = owner->m_petAuras.begin(); itr != owner->m_petAuras.end();)
    {
        PetAura const* pa = *itr;
        ++itr;

        if (!current && pa->IsRemovedOnChangePet())
            owner->RemovePetAura(pa);
        else
            CastPetAura(pa);
    }
}

void Pet::learnSpellHighRank(uint32 spellid)
{
    learnSpell(spellid);

    if (uint32 next = sSpellMgr->GetNextSpellInChain(spellid))
        learnSpellHighRank(next);
}

void Pet::SynchronizeLevelWithOwner()
{
    Unit* owner = GetOwner();
    if (!owner || owner->GetTypeId() != TYPEID_PLAYER)
        return;

    switch (getPetType())
    {
        // always same level
        case SUMMON_PET:
            GivePetLevel(owner->getLevel());
            break;
        // can't be greater owner level
        case HUNTER_PET:
            if (getLevel() > owner->getLevel())
                GivePetLevel(owner->getLevel());
            else if (getLevel() + 5 < owner->getLevel())
                GivePetLevel(owner->getLevel() - 5);
            break;
        default:
            break;
    }
}

void Pet::HandleAsynchLoadSucceed()
{
    Player* owner = GetOwner();
    if (!owner)
        return;

    if (GetAsynchLoadType() == PET_LOAD_HANDLE_UNSTABLE_CALLBACK)
    {
        if (Player* player = owner->ToPlayer())
            player->GetSession()->SendStableResult(0x09 /*STABLE_SUCCESS_UNSTABLE*/);
    }
    else// if (GetAsynchLoadType() == PET_LOAD_BG_RESURRECT || GetAsynchLoadType() == PET_LOAD_SUMMON_PET || GetAsynchLoadType() == PET_LOAD_SUMMON_DEAD_PET)
    {
        // Remove Demonic Sacrifice auras (known pet)
        Unit::AuraEffectList const& auraClassScripts = owner->GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
        for (Unit::AuraEffectList::const_iterator itr = auraClassScripts.begin(); itr != auraClassScripts.end();)
        {
            if ((*itr)->GetMiscValue() == 2228)
            {
                owner->RemoveAurasDueToSpell((*itr)->GetId());
                itr = auraClassScripts.begin();
            }
            else
                ++itr;
        }

        SetUInt32Value(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_NONE);
        RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);
        if (GetAsynchLoadType() == PET_LOAD_SUMMON_DEAD_PET)
        {
            setDeathState(ALIVE);
            ClearUnitState(uint32(UNIT_STATE_ALL_STATE & ~(UNIT_STATE_POSSESSED))); // xinef: added just in case... some linked auras and so on
            SetHealth(CountPctFromMaxHealth(15)); // Xinef: well, only two pet reviving spells exist and both revive with 15%
            SavePetToDB(PET_SAVE_AS_CURRENT, false);
        }
    }

    // xinef: resurrect with full health if resurrected by BG / BF spirit
    if (GetAsynchLoadType() == PET_LOAD_BG_RESURRECT)
        SetHealth(GetMaxHealth());

    // xinef: We are summoned in arena / battleground, remove all positive auras
    // xinef: and set health to full if in preparation phase
    if (GetMap()->IsBattlegroundOrArena())
    {
        if (GetMap()->IsBattleArena())
            RemoveArenaAuras();

        if (Player* player = owner->ToPlayer())
            if (Battleground* bg = player->GetBattleground())
                if (bg->GetStatus() == STATUS_WAIT_JOIN)
                {
                    if (IsAlive())
                        SetHealth(GetMaxHealth());

                    if (GetMap()->IsBattleground())
                        CastSpell(this, SPELL_PREPARATION, true);
                }
    }

    // Fix aurastate auras, depending on health!
    // Set aurastate manualy, prevents aura switching
    if (HealthBelowPct(20))
        SetFlag(UNIT_FIELD_AURASTATE, 1 << (AURA_STATE_HEALTHLESS_20_PERCENT - 1));
    if (HealthBelowPct(35))
        SetFlag(UNIT_FIELD_AURASTATE, 1 << (AURA_STATE_HEALTHLESS_35_PERCENT - 1));
    if (HealthAbovePct(75))
        SetFlag(UNIT_FIELD_AURASTATE, 1 << (AURA_STATE_HEALTH_ABOVE_75_PERCENT - 1));

    // unapply aura stats if dont meet requirements
    AuraApplicationMap const& Auras = GetAppliedAuras();
    for (AuraApplicationMap::const_iterator itr = Auras.begin(); itr != Auras.end(); ++itr)
    {
        // we assume that all auras are applied now, aurastate was modfied MANUALY preventing any apply/unapply state switching
        Aura* aura = itr->second->GetBase();
        SpellInfo const* m_spellInfo = aura->GetSpellInfo();
        if (m_spellInfo->CasterAuraState != AURA_STATE_HEALTHLESS_20_PERCENT &&
                m_spellInfo->CasterAuraState != AURA_STATE_HEALTHLESS_35_PERCENT &&
                m_spellInfo->CasterAuraState != AURA_STATE_HEALTH_ABOVE_75_PERCENT)
            continue;

        if (!HasAuraState((AuraStateType)m_spellInfo->CasterAuraState))
            aura->HandleAllEffects(itr->second, AURA_EFFECT_HANDLE_REAL, false);
    }

    SetAsynchLoadType(PET_LOAD_DEFAULT);

    // Warlock pet exception, check if owner is casting new summon spell
    if (Spell* spell = owner->GetCurrentSpell(CURRENT_GENERIC_SPELL))
        if (spell->GetSpellInfo()->HasEffect(SPELL_EFFECT_SUMMON_PET))
            CastSpell(this, 32752, true, nullptr, nullptr, GetGUID());

    if (owner->NeedSendSpectatorData() && GetCreatureTemplate()->family)
    {
        ArenaSpectator::SendCommand_UInt32Value(owner->FindMap(), owner->GetGUID(), "PHP", (uint32)GetHealthPct());
        ArenaSpectator::SendCommand_UInt32Value(owner->FindMap(), owner->GetGUID(), "PET", GetCreatureTemplate()->family);
    }
}

void Pet::HandleAsynchLoadFailed(AsynchPetSummon* info, Player* player, uint8 asynchLoadType, uint8 loadResult)
{
    if (loadResult == PET_LOAD_ERROR && asynchLoadType == PET_LOAD_HANDLE_UNSTABLE_CALLBACK)
    {
        player->GetSession()->SendStableResult(0x06 /*STABLE_ERR_STABLE*/);
    }
    else if (loadResult == PET_LOAD_NO_RESULT && info && (asynchLoadType == PET_LOAD_SUMMON_PET || asynchLoadType == PET_LOAD_SUMMON_DEAD_PET))
    {
        // xinef: petentry == 0 for hunter "call pet" (current pet summoned if any)
        if (!info->m_entry || !player)
            return;

        Pet* pet = new Pet(player, info->m_petType);
        pet->Relocate(info->pos); // already validated (IsPositionValid)

        Map* map = player->GetMap();
        uint32 pet_number = sObjectMgr->GeneratePetNumber();
        if (!pet->Create(map->GenerateLowGuid<HighGuid::Pet>(), map, player->GetPhaseMask(), info->m_entry, pet_number))
        {
            LOG_ERROR("server", "no such creature entry %u", info->m_entry);
            delete pet;
            return;
        }

        if (info->m_createdBySpell)
            pet->SetUInt32Value(UNIT_CREATED_BY_SPELL, info->m_createdBySpell);
        pet->SetCreatorGUID(player->GetGUID());
        pet->SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE, player->getFaction());

        pet->setPowerType(POWER_MANA);
        pet->SetUInt32Value(UNIT_NPC_FLAGS, 0);
        pet->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
        pet->InitStatsForLevel(player->getLevel());

        player->SetMinion(pet, true);

        if (info->m_petType == SUMMON_PET)
        {
            if (pet->GetCreatureTemplate()->type == CREATURE_TYPE_DEMON || pet->GetCreatureTemplate()->type == CREATURE_TYPE_UNDEAD)
                pet->GetCharmInfo()->SetPetNumber(pet_number, true); // Show pet details tab (Shift+P) only for demons & undead
            else
                pet->GetCharmInfo()->SetPetNumber(pet_number, false);

            pet->SetUInt32Value(UNIT_FIELD_BYTES_0, 2048);
            pet->SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, 0);
            pet->SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, 1000);
            pet->SetFullHealth();
            pet->SetPower(POWER_MANA, pet->GetMaxPower(POWER_MANA));
            pet->SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, uint32(time(nullptr))); // cast can't be helped in this case
        }

        map->AddToMap(pet->ToCreature(), true);

        if (info->m_petType == SUMMON_PET)
        {
            pet->InitPetCreateSpells();
            pet->InitTalentForLevel();
            pet->SavePetToDB(PET_SAVE_AS_CURRENT, false);
            player->PetSpellInitialize(); // no need to check, no other possibility

            // Remove Demonic Sacrifice auras (known pet)
            Unit::AuraEffectList const& auraClassScripts = player->GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
            for (Unit::AuraEffectList::const_iterator itr = auraClassScripts.begin(); itr != auraClassScripts.end();)
            {
                if ((*itr)->GetMiscValue() == 2228)
                {
                    player->RemoveAurasDueToSpell((*itr)->GetId());
                    itr = auraClassScripts.begin();
                }
                else
                    ++itr;
            }
        }

        if (info->m_duration > 0)
            pet->SetDuration(info->m_duration);

        // we are almost at home...
        if (asynchLoadType == PET_LOAD_SUMMON_PET)
        {
            Unit* caster = ObjectAccessor::GetUnit(*player, info->m_casterGUID);
            if (!caster)
                caster = player;

            if (caster->GetTypeId() == TYPEID_UNIT)
            {
                if (caster->ToCreature()->IsTotem())
                    pet->SetReactState(REACT_AGGRESSIVE);
                else
                    pet->SetReactState(REACT_DEFENSIVE);
            }

            // Reset cooldowns
            if (player->getClass() != CLASS_HUNTER)
            {
                pet->m_CreatureSpellCooldowns.clear();
                player->ToPlayer()->PetSpellInitialize();
            }

            // Set health to max if new pet is summoned
            // in this function old pet is saved with current health eg. 20% and new one is loaded from db with same amount
            // pet should have full health
            pet->SetHealth(pet->GetMaxHealth());

            // generate new name for summon pet
            std::string new_name = sObjectMgr->GeneratePetName(info->m_entry);
            if (!new_name.empty())
                pet->SetName(new_name);
        }
        else // if GetAsynchLoad() == PET_LOAD_SUMMON_DEAD_PET
        {
            pet->SetUInt32Value(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_NONE);
            pet->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);
            pet->setDeathState(ALIVE);
            pet->ClearUnitState(uint32(UNIT_STATE_ALL_STATE & ~(UNIT_STATE_POSSESSED))); // xinef: just in case
            pet->SetHealth(pet->CountPctFromMaxHealth(uint32(info->m_casterGUID.GetRawValue()))); // damage for this effect is saved in caster guid, dont create next variable...

            //AIM_Initialize();
            //owner->PetSpellInitialize();
            pet->SavePetToDB(PET_SAVE_AS_CURRENT, false);
        }
    }
}

void Pet::SetDisplayId(uint32 modelId)
{
    Guardian::SetDisplayId(modelId);

    if (!isControlled())
        return;

    if (Unit* owner = GetOwner())
        if (Player* player = owner->ToPlayer())
            if (player->GetGroup())
                player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_MODEL_ID);
}

void Pet::CastWhenWillAvailable(uint32 spellid, Unit* spellTarget, Unit* oldTarget, bool spellIsPositive)
{
    if (!spellid)
        return;

    if (!spellTarget)
        return;

    m_tempspellTarget = spellTarget;
    m_tempspell = spellid;
    m_tempspellIsPositive = spellIsPositive;

    if (oldTarget)
        m_tempoldTarget = oldTarget;
}

void Pet::ClearCastWhenWillAvailable()
{
    m_tempspellIsPositive = false;
    m_tempspell = 0;
    m_tempspellTarget = nullptr;
    m_tempoldTarget = nullptr;
}

void Pet::RemoveSpellCooldown(uint32 spell_id, bool update /* = false */)
{
    m_CreatureSpellCooldowns.erase(spell_id);

    if (update)
    {
        if (Player* playerOwner = GetCharmerOrOwnerPlayerOrPlayerItself())
        {
            WorldPacket data(SMSG_CLEAR_COOLDOWN, 4 + 8);
            data << uint32(spell_id);
            data << GetGUID();
            playerOwner->SendDirectMessage(&data);
        }
    }
}
