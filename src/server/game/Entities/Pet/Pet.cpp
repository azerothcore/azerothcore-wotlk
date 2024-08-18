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

#include "Pet.h"
#include "ArenaSpectator.h"
#include "CharmInfo.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "PetPackets.h"
#include "Player.h"
#include "QueryHolder.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "Unit.h"
#include "Util.h"
#include "WorldPacket.h"
#include "WorldSession.h"

Pet::Pet(Player* owner, PetType type) : Guardian(nullptr, owner ? owner->GetGUID() : ObjectGuid::Empty, true),
    m_usedTalentCount(0),
    m_removed(false),
    m_owner(owner),
    m_happinessTimer(PET_LOSE_HAPPINES_INTERVAL),
    m_petType(type),
    m_duration(0),
    m_auraRaidUpdateMask(0),
    m_loading(false),
    m_petRegenTimer(PET_FOCUS_REGEN_INTERVAL),
    m_tempspellTarget(nullptr),
    m_tempoldTarget(),
    m_tempspellIsPositive(false),
    m_tempspell(0)
{
    ASSERT(m_owner && m_owner->GetTypeId() == TYPEID_PLAYER);

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
                        if (SpellInfo const* si = sSpellMgr->GetSpellInfo(itr->second->spellId))
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

    if (GetOwnerGUID().IsPlayer())
    {
        if (Player* owner = GetOwner())
        {
            if (getPetType() == SUMMON_PET && owner->IsClass(CLASS_WARLOCK, CLASS_CONTEXT_PET))
            {
                owner->SetLastPetSpell(GetUInt32Value(UNIT_CREATED_BY_SPELL));
            }
        }

        sScriptMgr->OnPetAddToWorld(this);
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

class PetLoadQueryHolder : public CharacterDatabaseQueryHolder
{
public:
    enum
    {
        DECLINED_NAMES,
        AURAS,
        SPELLS,
        COOLDOWNS,

        MAX
    };

    PetLoadQueryHolder(ObjectGuid::LowType ownerGuid, uint32 petNumber)
    {
        SetSize(MAX);

        CharacterDatabasePreparedStatement* stmt = nullptr;

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PET_DECLINED_NAME);
        stmt->SetData(0, ownerGuid);
        stmt->SetData(1, petNumber);
        SetPreparedQuery(DECLINED_NAMES, stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PET_AURA);
        stmt->SetData(0, petNumber);
        SetPreparedQuery(AURAS, stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PET_SPELL);
        stmt->SetData(0, petNumber);
        SetPreparedQuery(SPELLS, stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PET_SPELL_COOLDOWN);
        stmt->SetData(0, petNumber);
        SetPreparedQuery(COOLDOWNS, stmt);
    }
};

std::pair<PetStable::PetInfo const*, PetSaveMode> Pet::GetLoadPetInfo(PetStable const& stable, uint32 petEntry, uint32 petnumber, bool current)
{
    if (petnumber)
    {
        // Known petnumber entry
        if (stable.CurrentPet && stable.CurrentPet->PetNumber == petnumber)
            return { &stable.CurrentPet.value(), PET_SAVE_AS_CURRENT };

        for (std::size_t stableSlot = 0; stableSlot < stable.StabledPets.size(); ++stableSlot)
            if (stable.StabledPets[stableSlot] && stable.StabledPets[stableSlot]->PetNumber == petnumber)
                return { &stable.StabledPets[stableSlot].value(), PetSaveMode(PET_SAVE_FIRST_STABLE_SLOT + stableSlot) };

        for (PetStable::PetInfo const& pet : stable.UnslottedPets)
            if (pet.PetNumber == petnumber)
                return { &pet, PET_SAVE_NOT_IN_SLOT };
    }
    else if (current)
    {
        // Current pet (slot 0)
        if (stable.CurrentPet)
            return { &stable.CurrentPet.value(), PET_SAVE_AS_CURRENT };
    }
    else if (petEntry)
    {
        // known petEntry entry (unique for summoned pet, but non unique for hunter pet (only from current or not stabled pets)
        if (stable.CurrentPet && stable.CurrentPet->CreatureId == petEntry)
            return { &stable.CurrentPet.value(), PET_SAVE_AS_CURRENT };

        for (PetStable::PetInfo const& pet : stable.UnslottedPets)
            if (pet.CreatureId == petEntry)
                return { &pet, PET_SAVE_NOT_IN_SLOT };
    }
    else
    {
        // Any current or other non-stabled pet (for hunter "call pet")
        if (stable.CurrentPet)
            return { &stable.CurrentPet.value(), PET_SAVE_AS_CURRENT };

        if (!stable.UnslottedPets.empty())
            return { &stable.UnslottedPets.front(), PET_SAVE_NOT_IN_SLOT };
    }

    return { nullptr, PET_SAVE_AS_DELETED };
}

bool Pet::LoadPetFromDB(Player* owner, uint32 petEntry, uint32 petnumber, bool current, uint32 healthPct /*= 0*/, bool fullMana /*= false*/)
{
    m_loading = true;

    PetStable* petStable = ASSERT_NOTNULL(owner->GetPetStable());

    ObjectGuid::LowType ownerid = owner->GetGUID().GetCounter();
    std::pair<PetStable::PetInfo const*, PetSaveMode> info = GetLoadPetInfo(*petStable, petEntry, petnumber, current);
    PetStable::PetInfo const* petInfo = info.first;
    PetSaveMode slot = info.second;
    if (!petInfo)
    {
        m_loading = false;
        return false;
    }

    // Don't try to reload the current pet
    if (petStable->CurrentPet && owner->GetPet() && petStable->CurrentPet.value().PetNumber == petInfo->PetNumber)
        return false;

    // we are loading pet at that moment
    if (owner->IsSpectator() || owner->GetPet() || !owner->IsInWorld() || !owner->FindMap())
        return false;

    bool forceLoadFromDB = false;
    sScriptMgr->OnBeforeLoadPetFromDB(owner, petEntry, petnumber, current, forceLoadFromDB);

    if (!forceLoadFromDB && (owner->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_PET) && !owner->CanSeeDKPet())) // DK Pet exception
        return false;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(petInfo->CreatedBySpellId);

    bool isTemporarySummon = spellInfo && spellInfo->GetDuration() > 0;
    if (current && isTemporarySummon)
        return false;

    if (petInfo->Type == HUNTER_PET)
    {
        CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(petInfo->CreatureId);
        if (!creatureInfo || !creatureInfo->IsTameable(owner->CanTameExoticPets()))
            return false;
    }

    if (current && owner->IsPetNeedBeTemporaryUnsummoned())
    {
        owner->SetLastPetSpell(petInfo->CreatedBySpellId);
        owner->SetTemporaryUnsummonedPetNumber(petInfo->PetNumber);
        return false;
    }

    Map* map = owner->GetMap();
    ObjectGuid::LowType guid = map->GenerateLowGuid<HighGuid::Pet>();

    if (!Create(guid, map, owner->GetPhaseMask(), petInfo->CreatureId, petInfo->PetNumber))
        return false;

    setPetType(petInfo->Type);
    SetFaction(owner->GetFaction());
    SetUInt32Value(UNIT_CREATED_BY_SPELL, petInfo->CreatedBySpellId);

    if (IsCritter())
    {
        float px, py, pz;
        owner->GetClosePoint(px, py, pz, GetCombatReach(), PET_FOLLOW_DIST, GetFollowAngle());
        Relocate(px, py, pz, owner->GetOrientation());

        if (!IsPositionValid())
        {
            LOG_ERROR("entities.pet", "Pet{} not loaded. Suggested coordinates isn't valid (X: {} Y: {})",
                GetGUID().ToString(), GetPositionX(), GetPositionY());
            return false;
        }

        UpdatePositionData();
        map->AddToMap(ToCreature(), true);
        return true;
    }

    if (getPetType() == HUNTER_PET || GetCreatureTemplate()->type == CREATURE_TYPE_DEMON || GetCreatureTemplate()->type == CREATURE_TYPE_UNDEAD)
        GetCharmInfo()->SetPetNumber(petInfo->PetNumber, IsPermanentPetFor(owner)); // Show pet details tab (Shift+P) only for hunter pets, demons or undead
    else
        GetCharmInfo()->SetPetNumber(petInfo->PetNumber, false);

    SetDisplayId(petInfo->DisplayId);
    SetNativeDisplayId(petInfo->DisplayId);
    UpdatePositionData();
    uint8 petlevel = petInfo->Level;
    ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
    SetName(petInfo->Name);

    switch (getPetType())
    {
        case SUMMON_PET:
            petlevel = owner->GetLevel();

            if (IsPetGhoul())
                SetUInt32Value(UNIT_FIELD_BYTES_0, 0x400); // class = rogue
            else
                SetUInt32Value(UNIT_FIELD_BYTES_0, 0x800); // class = mage

            ReplaceAllUnitFlags(UNIT_FLAG_PLAYER_CONTROLLED); // this enables popup window (pet dismiss, cancel)
            break;
        case HUNTER_PET:
            SetUInt32Value(UNIT_FIELD_BYTES_0, 0x02020100); // class = warrior, gender = none, power = focus
            SetSheath(SHEATH_STATE_MELEE);
            SetByteFlag(UNIT_FIELD_BYTES_2, 2, petInfo->WasRenamed ? UNIT_CAN_BE_ABANDONED : UNIT_CAN_BE_RENAMED | UNIT_CAN_BE_ABANDONED);

            ReplaceAllUnitFlags(UNIT_FLAG_PLAYER_CONTROLLED);
                                                            // this enables popup window (pet abandon, cancel)
            SetMaxPower(POWER_HAPPINESS, GetCreatePowers(POWER_HAPPINESS));
            SetPower(POWER_HAPPINESS, petInfo->Happiness);
            setPowerType(POWER_FOCUS);
            break;
        default:
            if (!IsPetGhoul())
                LOG_ERROR("entities.pet", "Pet have incorrect type ({}) for pet loading.", getPetType());
            break;
    }

    SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, uint32(GameTime::GetGameTime().count())); // cast can't be helped here
    SetCreatorGUID(owner->GetGUID());

    InitStatsForLevel(petlevel);
    SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, petInfo->Experience);

    SynchronizeLevelWithOwner();

    // Set pet's position after setting level, its size depends on it
    float px, py, pz;
    owner->GetClosePoint(px, py, pz, GetCombatReach(), PET_FOLLOW_DIST, GetFollowAngle());
    Relocate(px, py, pz, owner->GetOrientation());
    if (!IsPositionValid())
    {
        LOG_ERROR("entities.pet", "Pet {} not loaded. Suggested coordinates isn't valid (X: {} Y: {})",
            GetGUID().ToString(), GetPositionX(), GetPositionY());
        return false;
    }

    SetReactState(petInfo->ReactState);
    SetCanModifyStats(true);

    // set current pet as current
    // 0=current
    // 1..MAX_PET_STABLES in stable slot
    // PET_SAVE_NOT_IN_SLOT(100) = not stable slot (summoning))
    if (slot == PET_SAVE_NOT_IN_SLOT)
    {
        uint32 petInfoNumber = petInfo->PetNumber;
        if (petStable->CurrentPet)
            owner->RemovePet(nullptr, PET_SAVE_NOT_IN_SLOT);

        auto unslottedPetItr = std::find_if(petStable->UnslottedPets.begin(), petStable->UnslottedPets.end(), [&](PetStable::PetInfo const& unslottedPet)
        {
            return unslottedPet.PetNumber == petInfoNumber;
        });

        ASSERT(!petStable->CurrentPet);
        ASSERT(unslottedPetItr != petStable->UnslottedPets.end());

        petStable->CurrentPet = std::move(*unslottedPetItr);
        petStable->UnslottedPets.erase(unslottedPetItr);

        // old petInfo pointer is no longer valid, refresh it
        petInfo = &petStable->CurrentPet.value();
    }
    else if (PET_SAVE_FIRST_STABLE_SLOT <= slot && slot <= PET_SAVE_LAST_STABLE_SLOT)
    {
        auto stabledPet = std::find_if(petStable->StabledPets.begin(), petStable->StabledPets.end(), [petnumber](Optional<PetStable::PetInfo> const& pet)
        {
            return pet && pet->PetNumber == petnumber;
        });

        ASSERT(stabledPet != petStable->StabledPets.end());

        std::swap(*stabledPet, petStable->CurrentPet);

        // old petInfo pointer is no longer valid, refresh it
        petInfo = &petStable->CurrentPet.value();
    }

    // Send fake summon spell cast - this is needed for correct cooldown application for spells
    // Example: 46584 - without this cooldown (which should be set always when pet is loaded) isn't set clientside
    /// @todo pets should be summoned from real cast instead of just faking it?
    if (petInfo->CreatedBySpellId && spellInfo && (spellInfo->CategoryRecoveryTime > 0 || spellInfo->RecoveryTime > 0))
    {
        WorldPacket data(SMSG_SPELL_GO, (8 + 8 + 4 + 4 + 2));
        data << owner->GetPackGUID();
        data << owner->GetPackGUID();
        data << uint8(0);
        data << uint32(petInfo->CreatedBySpellId);
        data << uint32(256); // CAST_FLAG_UNKNOWN3
        data << uint32(0);
        owner->SendMessageToSet(&data, true);
    }

    owner->SetMinion(this, true);

    if (!isTemporarySummon)
        m_charmInfo->LoadPetActionBar(petInfo->ActionBar);

    map->AddToMap(ToCreature(), true);

    //set last used pet number (for use in BG's)
    if (owner->GetTypeId() == TYPEID_PLAYER && isControlled() && !isTemporarySummoned() && (getPetType() == SUMMON_PET || getPetType() == HUNTER_PET))
        owner->ToPlayer()->SetLastPetNumber(petInfo->PetNumber);

    owner->GetSession()->AddQueryHolderCallback(CharacterDatabase.DelayQueryHolder(std::make_shared<PetLoadQueryHolder>(ownerid, petInfo->PetNumber)))
        .AfterComplete([this, owner, session = owner->GetSession(), isTemporarySummon, current, lastSaveTime = petInfo->LastSaveTime, savedhealth = petInfo->Health, savedmana = petInfo->Mana, healthPct, fullMana]
        (SQLQueryHolderBase const& holder)
    {
        if (session->GetPlayer() != owner || owner->GetPet() != this)
            return;

        // passing previous checks ensure that 'this' is still valid
        if (m_removed)
            return;

        InitTalentForLevel(); // set original talents points before spell loading

        uint32 timediff = uint32(GameTime::GetGameTime().count() - lastSaveTime);
        _LoadAuras(holder.GetPreparedResult(PetLoadQueryHolder::AURAS), timediff);

        // load action bar, if data broken will fill later by default spells.
        if (!isTemporarySummon)
        {
            _LoadSpells(holder.GetPreparedResult(PetLoadQueryHolder::SPELLS));
            InitTalentForLevel(); // re-init to check talent count
            _LoadSpellCooldowns(holder.GetPreparedResult(PetLoadQueryHolder::COOLDOWNS));
            LearnPetPassives();
            InitLevelupSpellsForLevel();
            if (GetMap()->IsBattleArena())
                RemoveArenaAuras();

            CastPetAuras(current);
        }

        CleanupActionBar();                                     // remove unknown spells from action bar after load

        LOG_DEBUG("entities.pet", "New Pet has {}", GetGUID().ToString());

        owner->PetSpellInitialize();
        owner->SendTalentsInfoData(true);

        if (owner->GetGroup())
            owner->SetGroupUpdateFlag(GROUP_UPDATE_PET);

        if (getPetType() == HUNTER_PET)
        {
            if (PreparedQueryResult result = holder.GetPreparedResult(PetLoadQueryHolder::DECLINED_NAMES))
            {
                m_declinedname = std::make_unique<DeclinedName>();
                Field* fields = result->Fetch();
                for (uint8 i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
                    m_declinedname->name[i] = fields[i].Get<std::string>();
            }
        }

        uint32 curHealth = savedhealth;
        if (healthPct)
        {
            curHealth = CountPctFromMaxHealth(healthPct);
        }

        uint32 curMana = savedmana;
        if (fullMana)
            curMana = GetMaxPower(POWER_MANA);

        if (getPetType() == SUMMON_PET && !current) //all (?) summon pets come with full health when called, but not when they are current
        {
            SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
            SetFullHealth();
        }
        else
        {
            if (!curHealth && getPetType() == HUNTER_PET)
                setDeathState(DeathState::JustDied);
            else
            {
                SetHealth(curHealth > GetMaxHealth() ? GetMaxHealth() : curHealth);
                SetPower(POWER_MANA, curMana > GetMaxPower(POWER_MANA) ? GetMaxPower(POWER_MANA) : curMana);
            }
        }

        // must be after SetMinion (owner guid check)
        //LoadTemplateImmunities();
        //LoadMechanicTemplateImmunity();
        m_loading = false;
    });

    return true;
}

void Pet::SavePetToDB(PetSaveMode mode)
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

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    // save auras before possibly removing them
    _SaveAuras(trans);

    // stable and not in slot saves
    if (mode > PET_SAVE_AS_CURRENT)
        RemoveAllAuras();

    _SaveSpells(trans);
    _SaveSpellCooldowns(trans);
    CharacterDatabase.CommitTransaction(trans);

    // current/stable/not_in_slot
    if (mode >= PET_SAVE_AS_CURRENT)
    {
        ObjectGuid::LowType ownerLowGUID = GetOwnerGUID().GetCounter();
        trans = CharacterDatabase.BeginTransaction();
        // remove current data

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_BY_ID);
        stmt->SetData(0, m_charmInfo->GetPetNumber());
        trans->Append(stmt);

        // prevent existence another hunter pet in PET_SAVE_AS_CURRENT and PET_SAVE_NOT_IN_SLOT
        if (getPetType() == HUNTER_PET && (mode == PET_SAVE_AS_CURRENT || mode > PET_SAVE_LAST_STABLE_SLOT))
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_BY_SLOT);
            stmt->SetData(0, ownerLowGUID);
            stmt->SetData(1, uint8(PET_SAVE_AS_CURRENT));
            stmt->SetData(2, uint8(PET_SAVE_LAST_STABLE_SLOT));
            trans->Append(stmt);
        }

        // save pet
        std::string actionBar = GenerateActionBarData();

        if (owner->GetPetStable()->CurrentPet && owner->GetPetStable()->CurrentPet->PetNumber == m_charmInfo->GetPetNumber())
        {
            FillPetInfo(&owner->GetPetStable()->CurrentPet.value());
        }

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_CHAR_PET);
        stmt->SetData(0, m_charmInfo->GetPetNumber());
        stmt->SetData(1, GetEntry());
        stmt->SetData(2, ownerLowGUID);
        stmt->SetData(3, GetNativeDisplayId());
        stmt->SetData(4, GetUInt32Value(UNIT_CREATED_BY_SPELL));
        stmt->SetData(5, uint8(getPetType()));
        stmt->SetData(6, GetLevel());
        stmt->SetData(7, GetUInt32Value(UNIT_FIELD_PETEXPERIENCE));
        stmt->SetData(8, uint8(GetReactState()));
        stmt->SetData(9, GetName());
        stmt->SetData(10, uint8(HasByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_RENAMED) ? 0 : 1));
        stmt->SetData(11, uint8(mode));
        stmt->SetData(12, curhealth);
        stmt->SetData(13, curmana);
        stmt->SetData(14, GetPower(POWER_HAPPINESS));
        stmt->SetData(15, GameTime::GetGameTime().count());
        stmt->SetData(16, actionBar);

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
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_BY_ID);
    stmt->SetData(0, guidlow);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_DECLINEDNAME);
    stmt->SetData(0, guidlow);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_AURAS);
    stmt->SetData(0, guidlow);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELLS);
    stmt->SetData(0, guidlow);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELL_COOLDOWNS);
    stmt->SetData(0, guidlow);
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);
}

void Pet::setDeathState(DeathState s, bool /*despawn = false*/)                       // overwrite virtual Creature::setDeathState and Unit::setDeathState
{
    Creature::setDeathState(s);
    if (getDeathState() == DeathState::Corpse)
    {
        if (getPetType() == HUNTER_PET)
        {
            // pet corpse non lootable and non skinnable
            ReplaceAllDynamicFlags(UNIT_DYNFLAG_NONE);
            RemoveUnitFlag(UNIT_FLAG_SKINNABLE);

            //lose happiness when died and not in BG/Arena
            MapEntry const* mapEntry = sMapStore.LookupEntry(GetMapId());
            if (!mapEntry || (mapEntry->map_type != MAP_ARENA && mapEntry->map_type != MAP_BATTLEGROUND))
                ModifyPower(POWER_HAPPINESS, -HAPPINESS_LEVEL_SIZE);

            //SetUnitFlag(UNIT_FLAG_STUNNED);
        }
    }
    else if (getDeathState() == DeathState::Alive)
    {
        //RemoveUnitFlag(UNIT_FLAG_STUNNED);
        CastPetAuras(true);
    }
}

void Pet::Update(uint32 diff)
{
    auto _diff = Milliseconds(diff);

    if (m_removed)                                           // pet already removed, just wait in remove queue, no updates
        return;

    if (m_loading)
        return;

    switch (m_deathState)
    {
        case DeathState::Corpse:
            {
                if (getPetType() != HUNTER_PET || m_corpseRemoveTime <= GameTime::GetGameTime().count())
                {
                    Remove(PET_SAVE_NOT_IN_SLOT);               //hunters' pets never get removed because of death, NEVER!
                    return;
                }
                break;
            }
        case DeathState::Alive:
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
                        LOG_ERROR("entities.pet", "Pet {} is not pet of owner {}, removed", GetEntry(), GetOwner()->GetName());
                        ASSERT(getPetType() != HUNTER_PET, "Unexpected unlinked pet found for owner {}", owner->GetSession()->GetPlayerInfo());
                        Remove(PET_SAVE_NOT_IN_SLOT);
                        return;
                    }
                }

                if (m_duration > 0s)
                {
                    if (m_duration > _diff)
                        m_duration -= _diff;
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
                    m_petRegenTimer -= _diff;
                    if (m_petRegenTimer <= 0s)
                    {
                        m_petRegenTimer += PET_FOCUS_REGEN_INTERVAL;
                        Regenerate(POWER_FOCUS);
                    }
                }

                if (m_tempspell)
                {
                    Unit* tempspellTarget = m_tempspellTarget;
                    Unit* tempoldTarget = nullptr;

                    if (!m_tempoldTarget.IsEmpty())
                        tempoldTarget = ObjectAccessor::GetUnit(*this, m_tempoldTarget);

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
                        if (spellInfo->RangeEntry->Flags == SPELL_RANGE_MELEE)
                            max_range -= 2 * MIN_MELEE_REACH;

                        if (IsWithinLOSInMap(tempspellTarget) && GetDistance(tempspellTarget) < max_range)
                        {
                            if (!GetCharmInfo()->GetGlobalCooldownMgr().HasGlobalCooldown(spellInfo) && !HasSpellCooldown(tempspell))
                            {
                                StopMoving();
                                GetMotionMaster()->Clear(false);
                                GetMotionMaster()->MoveIdle();

                                bool oldCmdAttack = GetCharmInfo()->IsCommandAttack();

                                GetCharmInfo()->SetIsCommandAttack(false);
                                GetCharmInfo()->SetIsAtStay(true);
                                GetCharmInfo()->SetIsCommandFollow(false);
                                GetCharmInfo()->SetIsFollowing(false);
                                GetCharmInfo()->SetIsReturning(false);
                                GetCharmInfo()->SaveStayPosition(true);

                                GetCharmInfo()->SetIsCommandAttack(oldCmdAttack);

                                AddSpellCooldown(tempspell, 0, spellInfo->IsCooldownStartedOnEvent() ? infinityCooldownDelay : 0);

                                CastSpell(tempspellTarget, tempspell, false);
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
                                        if (IsAIEnabled)
                                            AI()->PetStopAttack();
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
                                    }

                                    m_tempoldTarget = ObjectGuid::Empty;
                                    m_tempspellIsPositive = false;
                                }
                            }
                        }
                    }
                    else
                    {
                        m_tempspell = 0;
                        m_tempspellTarget = nullptr;
                        m_tempoldTarget = ObjectGuid::Empty;
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
    GetOwner()->RemovePet(this, mode, returnreagent);
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

    uint8 maxlevel = std::min((uint8)sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL), GetOwner()->GetLevel());
    uint8 petlevel = GetLevel();

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
    if (!level || level == GetLevel())
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
        LOG_ERROR("entities.pet", "Pet {} not created base at creature. Suggested coordinates isn't valid (X: {} Y: {})",
                       GetGUID().ToString(), GetPositionX(), GetPositionY());
        return false;
    }

    CreatureTemplate const* cinfo = GetCreatureTemplate();
    if (!cinfo)
    {
        LOG_ERROR("entities.pet", "CreateBaseAtCreature() failed, creatureInfo is missing!");
        return false;
    }

    SetDisplayId(creature->GetDisplayId());

    UpdatePositionData();

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

    UpdatePositionData();

    return true;
}

bool Pet::CreateBaseAtTamed(CreatureTemplate const* cinfo, Map* map, uint32 phaseMask)
{
    LOG_DEBUG("entities.pet", "Pet::CreateBaseForTamed");
    ObjectGuid::LowType guid = map->GenerateLowGuid<HighGuid::Pet>();
    uint32 pet_number = sObjectMgr->GeneratePetNumber();
    if (!Create(guid, map, phaseMask, cinfo->Entry, pet_number))
        return false;

    SetMaxPower(POWER_HAPPINESS, GetCreatePowers(POWER_HAPPINESS));
    SetPower(POWER_HAPPINESS, 166500);
    setPowerType(POWER_FOCUS);
    SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, 0);
    SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, 0);
    SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, uint32(sObjectMgr->GetXPForLevel(GetLevel() + 1)* sWorld->getRate(RATE_XP_PET_NEXT_LEVEL)));
    ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);

    if (cinfo->type == CREATURE_TYPE_BEAST)
    {
        SetUInt32Value(UNIT_FIELD_BYTES_0, 0x02020100);
        SetSheath(SHEATH_STATE_MELEE);
        SetByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_RENAMED | UNIT_CAN_BE_ABANDONED);
    }

    return true;
}

/// @todo: Move stat mods code to pet passive auras
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
                if (owner->IsClass(CLASS_WARLOCK, CLASS_CONTEXT_PET) ||
                        owner->IsClass(CLASS_SHAMAN, CLASS_CONTEXT_PET) ||          // Fire Elemental
                        owner->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_PET) ||    // Risen Ghoul
                        owner->IsClass(CLASS_MAGE, CLASS_CONTEXT_PET))              // Water Elemental with glyph
                    petType = SUMMON_PET;
                else if (owner->IsClass(CLASS_HUNTER, CLASS_CONTEXT_PET))
                {
                    petType = HUNTER_PET;
                }
            }

            if (petType == HUNTER_PET)
                m_unitTypeMask |= UNIT_MASK_HUNTER_PET;
            else if (petType != SUMMON_PET)
                LOG_ERROR("entities.pet", "Unknown type pet {} is summoned by player class {}", GetEntry(), owner->getClass());
        }

        if (petType == HUNTER_PET || petType == SUMMON_PET)
        {
            SetSpeed(MOVE_RUN, 1.15f);
        }
    }

    uint32 creature_ID = (petType == HUNTER_PET) ? 1 : cinfo->Entry;

    if (petType == HUNTER_PET)
    {
        SetMeleeDamageSchool(SPELL_SCHOOL_NORMAL);
    }
    else
    {
        SetMeleeDamageSchool(SpellSchools(cinfo->dmgschool));
    }

    SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, float(petlevel * 50));

    uint32 attackTime = BASE_ATTACK_TIME;
    if (!owner->IsClass(CLASS_HUNTER, CLASS_CONTEXT_PET) && cinfo->BaseAttackTime >= 1000)
        attackTime = cinfo->BaseAttackTime;

    SetAttackTime(BASE_ATTACK, attackTime);
    SetAttackTime(OFF_ATTACK, attackTime);
    SetAttackTime(RANGED_ATTACK, BASE_ATTACK_TIME);

    SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);

    // scale
    SetObjectScale(GetNativeObjectScale());

    // Resistance
    // xinef: hunter pets should not inherit template resistances
    if (!IsHunterPet())
        for (uint8 i = SPELL_SCHOOL_HOLY; i < MAX_SPELL_SCHOOL; ++i)
            SetModifierValue(UnitMods(UNIT_MOD_RESISTANCE_START + i), BASE_VALUE, float(cinfo->resistance[i]));

    //health, mana, armor and resistance
    PetLevelInfo const* pInfo = sObjectMgr->GetPetLevelInfo(creature_ID, petlevel);
    if (pInfo)                                      // exist in DB
    {
        // Default scale value of 1 to use if Pet.RankMod.Health = 0
        float factorHealth = 1;
        // If config is set to allow pets to use health modifiers, apply it to creatures with a DB entry
        // Pet.RankMod.Health = 1 use the factor value based on the rank of the pet, most pets have a rank of 0 and so use
        // the Elite rank which is set as the default in Creature::_GetHealthMod(int32 Rank)
        if (sWorld->getBoolConfig(CONFIG_ALLOWS_RANK_MOD_FOR_PET_HEALTH))
        {
            factorHealth *= _GetHealthMod(cinfo->rank);
        }

        SetCreateHealth(pInfo->health*factorHealth);
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

        if (sWorld->getBoolConfig(CONFIG_ALLOWS_RANK_MOD_FOR_PET_HEALTH))
        {
            factorHealth *= _GetHealthMod(cinfo->rank);
        }

        SetCreateHealth(std::max<uint32>(1, stats->BaseHealth[cinfo->expansion]*factorHealth));
        SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, GetCreateHealth());
        SetCreateMana(stats->BaseMana * factorMana);
        SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, GetCreateMana());

        // xinef: added some multipliers so debuffs can affect pets in any way...
        SetCreateStat(STAT_STRENGTH, 22);
        SetCreateStat(STAT_AGILITY, 22);
        SetCreateStat(STAT_STAMINA, 25);
        SetCreateStat(STAT_INTELLECT, 28);
        SetCreateStat(STAT_SPIRIT, 27);
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
                            {
                                HandleStatModifier(UNIT_MOD_ATTACK_POWER, TOTAL_PCT, aurEff->GetAmount(), true);
                            }

                            break;
                        }
                    case NPC_VOIDWALKER:
                        {
                            if (AuraEffect* aurEff = owner->GetAuraEffectDummy(SPELL_GLYPH_OF_VOIDWALKER))
                            {
                                HandleStatModifier(UNIT_MOD_STAT_STAMINA, TOTAL_PCT, aurEff->GetAmount(), true);
                            }
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
                            if (pInfo)
                            {
                                SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(pInfo->min_dmg));
                                SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(pInfo->max_dmg));
                            }
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

                            if (owner->getRace() == RACE_ORC)
                            {
                                CastSpell(this, SPELL_ORC_RACIAL_COMMAND_SHAMAN, true, nullptr, nullptr, owner->GetGUID());
                            }

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
                    case NPC_VENOMOUS_SNAKE:
                        SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel * 0.7 - 38));
                        SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel * 0.8 - 40));
                        break;
                    case NPC_VIPER:
                        SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(1.3 * petlevel - 64));
                        SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(1.5 * petlevel - 68));
                        break;
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
            CastSpell(this, SPELL_ORC_RACIAL_COMMAND_DK, true, nullptr, nullptr, owner->GetGUID());

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
    if (GetLevel() <= itemlevel + 5)                         //possible to feed level 60 pet with level 55 level food for full effect
        return 35000;
    // -10..-6
    else if (GetLevel() <= itemlevel + 10)                   //pure guess, but sounds good
        return 17000;
    // -14..-11
    else if (GetLevel() <= itemlevel + 14)                   //level 55 food gets green on 70, makes sense to me
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
        time_t curTime = GameTime::GetGameTime().count();

        PacketCooldowns cooldowns;
        WorldPacket data;

        do
        {
            Field* fields = result->Fetch();

            uint32 spell_id = fields[0].Get<uint32>();
            uint16 category = fields[1].Get<uint16>();
            time_t db_time  = time_t(fields[2].Get<uint32>());

            if (!sSpellMgr->GetSpellInfo(spell_id))
            {
                LOG_ERROR("entities.pet", "Pet {} have unknown spell {} in `pet_spell_cooldown`, skipping.", m_charmInfo->GetPetNumber(), spell_id);
                continue;
            }

            // skip outdated cooldown
            if (db_time <= curTime)
                continue;

            uint32 cooldown = (db_time - curTime) * IN_MILLISECONDS;
            cooldowns[spell_id] = cooldown;
            _AddCreatureSpellCooldown(spell_id, category, cooldown);

            LOG_DEBUG("entities.pet", "Pet (Number: {}) spell {} cooldown loaded ({} secs).", m_charmInfo->GetPetNumber(), spell_id, uint32(db_time - curTime));
        } while (result->NextRow());

        if (!cooldowns.empty() && GetOwner())
        {
            BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, cooldowns);
            GetOwner()->GetSession()->SendPacket(&data);
        }
    }
}

void Pet::_SaveSpellCooldowns(CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELL_COOLDOWNS);
    stmt->SetData(0, m_charmInfo->GetPetNumber());
    trans->Append(stmt);

    time_t curTime = GameTime::GetGameTime().count();
    uint32 curMSTime = GameTime::GetGameTimeMS().count();
    uint32 infTime   = curMSTime + infinityCooldownDelayCheck;

    // remove oudated and save active
    CreatureSpellCooldowns::iterator itr, itr2;
    for (itr = m_CreatureSpellCooldowns.begin(); itr != m_CreatureSpellCooldowns.end();)
    {
        itr2 = itr;
        ++itr;

        if (itr2->second.end <= curMSTime + 1000)
        {
            m_CreatureSpellCooldowns.erase(itr2);
        }
        else if (itr2->second.end <= infTime)
        {
            uint32 cooldown = ((itr2->second.end - curMSTime) / IN_MILLISECONDS) + curTime;
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PET_SPELL_COOLDOWN);
            stmt->SetData(0, m_charmInfo->GetPetNumber());
            stmt->SetData(1, itr2->first);
            stmt->SetData(2, itr2->second.category);
            stmt->SetData(3, cooldown);
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

            addSpell(fields[0].Get<uint32>(), ActiveStates(fields[1].Get<uint8>()), PETSPELL_UNCHANGED);
        } while (result->NextRow());
    }
}

void Pet::_SaveSpells(CharacterDatabaseTransaction trans)
{
    for (PetSpellMap::iterator itr = m_spells.begin(), next = m_spells.begin(); itr != m_spells.end(); itr = next)
    {
        ++next;

        // prevent saving family passives to DB
        if (itr->second.type == PETSPELL_FAMILY)
            continue;

        CharacterDatabasePreparedStatement* stmt;

        switch (itr->second.state)
        {
            case PETSPELL_REMOVED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELL_BY_SPELL);
                stmt->SetData(0, m_charmInfo->GetPetNumber());
                stmt->SetData(1, itr->first);
                trans->Append(stmt);

                m_spells.erase(itr);
                continue;
            case PETSPELL_CHANGED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELL_BY_SPELL);
                stmt->SetData(0, m_charmInfo->GetPetNumber());
                stmt->SetData(1, itr->first);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PET_SPELL);
                stmt->SetData(0, m_charmInfo->GetPetNumber());
                stmt->SetData(1, itr->first);
                stmt->SetData(2, itr->second.active);
                trans->Append(stmt);

                break;
            case PETSPELL_NEW:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PET_SPELL);
                stmt->SetData(0, m_charmInfo->GetPetNumber());
                stmt->SetData(1, itr->first);
                stmt->SetData(2, itr->second.active);
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
    LOG_DEBUG("entities.pet", "Loading auras for pet {}", GetGUID().ToString());

    if (result)
    {
        do
        {
            int32 damage[3];
            int32 baseDamage[3];
            Field* fields = result->Fetch();
            ObjectGuid caster_guid = ObjectGuid(fields[0].Get<uint64>());
            // nullptr guid stored - pet is the caster of the spell - see Pet::_SaveAuras
            if (!caster_guid)
                caster_guid = GetGUID();
            uint32 spellid = fields[1].Get<uint32>();
            uint8 effmask = fields[2].Get<uint8>();
            uint8 recalculatemask = fields[3].Get<uint8>();
            uint8 stackcount = fields[4].Get<uint8>();
            damage[0] = fields[5].Get<int32>();
            damage[1] = fields[6].Get<int32>();
            damage[2] = fields[7].Get<int32>();
            baseDamage[0] = fields[8].Get<int32>();
            baseDamage[1] = fields[9].Get<int32>();
            baseDamage[2] = fields[10].Get<int32>();
            int32 maxduration = fields[11].Get<int32>();
            int32 remaintime = fields[12].Get<int32>();
            uint8 remaincharges = fields[13].Get<uint8>();

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellid);
            if (!spellInfo)
            {
                LOG_ERROR("entities.pet", "Unknown aura (spellid {}), ignore.", spellid);
                continue;
            }

            // avoid higher level auras if any, and adjust
            SpellInfo const* scaledSpellInfo = spellInfo->GetAuraRankForLevel(GetLevel());
            if (scaledSpellInfo != spellInfo)
                spellInfo = scaledSpellInfo;

            // again after level check
            if (!spellInfo)
                continue;

            // negative effects should continue counting down after logout
            if (remaintime != -1 && (!spellInfo->IsPositive() || spellInfo->HasAttribute(SPELL_ATTR4_AURA_EXPIRES_OFFLINE)))
            {
                if (remaintime / IN_MILLISECONDS <= int32(timediff))
                {
                    continue;
                }

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
                LOG_DEBUG("entities.pet", "Added aura spellid {}, effectmask {}", spellInfo->Id, effmask);
            }
        } while (result->NextRow());
    }
}

void Pet::_SaveAuras(CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_AURAS);
    stmt->SetData(0, m_charmInfo->GetPetNumber());
    trans->Append(stmt);

    for (AuraMap::const_iterator itr = m_ownedAuras.begin(); itr != m_ownedAuras.end(); ++itr)
    {
        // check if the aura has to be saved
        if (!itr->second->CanBeSaved() || IsPetAura(itr->second))
            continue;

        Aura* aura = itr->second;
        if (aura->GetDuration() < 60 * IN_MILLISECONDS)
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

        CharacterDatabasePreparedStatement* stmt2 = CharacterDatabase.GetPreparedStatement(CHAR_INS_PET_AURA);
        stmt2->SetData(index++, m_charmInfo->GetPetNumber());
        stmt2->SetData(index++, casterGUID.GetRawValue());
        stmt2->SetData(index++, itr->second->GetId());
        stmt2->SetData(index++, effMask);
        stmt2->SetData(index++, recalculateMask);
        stmt2->SetData(index++, itr->second->GetStackAmount());
        stmt2->SetData(index++, damage[0]);
        stmt2->SetData(index++, damage[1]);
        stmt2->SetData(index++, damage[2]);
        stmt2->SetData(index++, baseDamage[0]);
        stmt2->SetData(index++, baseDamage[1]);
        stmt2->SetData(index++, baseDamage[2]);
        stmt2->SetData(index++, itr->second->GetMaxDuration());
        stmt2->SetData(index++, itr->second->GetDuration());
        stmt2->SetData(index++, itr->second->GetCharges());
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
            LOG_ERROR("entities.pet", "Pet::addSpell: Non-existed in SpellStore spell #{} request, deleting for all pets in `pet_spell`.", spellId);

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_PET_SPELL);
            stmt->SetData(0, spellId);
            CharacterDatabase.Execute(stmt);
        }
        else
            LOG_ERROR("entities.pet", "Pet::addSpell: Non-existed in SpellStore spell #{} request.", spellId);

        return false;
    }

    auto const& itr = m_spells.find(spellId);
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
            for (uint32 rankSpellId : talentInfo->RankID)
            {
                // skip learning spell and no rank spell case
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
        for (auto const& [spellID, petSpell] : m_spells)
        {
            if (petSpell.state == PETSPELL_REMOVED)
                continue;

            SpellInfo const* oldRankSpellInfo = sSpellMgr->GetSpellInfo(spellID);

            if (!oldRankSpellInfo)
                continue;

            if (spellInfo->IsDifferentRankOf(oldRankSpellInfo))
            {
                // replace by new high rank
                if (spellInfo->IsHighRankOf(oldRankSpellInfo))
                {
                    newspell.active = petSpell.active;

                    if (newspell.active == ACT_ENABLED)
                        ToggleAutocast(oldRankSpellInfo, false);

                    unlearnSpell(spellID, false, false);
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
    if (Aura* aura = GetAura(spellId))
    {
        if (aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTHLESS_35_PERCENT ||
                aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTH_ABOVE_75_PERCENT ||
                aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTHLESS_20_PERCENT )
            if (!HasAuraState((AuraStateType)aura->GetSpellInfo()->CasterAuraState))
            {
                aura->HandleAllEffects(aura->GetApplicationOfTarget(GetGUID()), AURA_EFFECT_HANDLE_REAL, false);
            }
    }

    ToggleAutocast(spellInfo, (newspell.active == ACT_ENABLED));

    uint32 talentCost = GetTalentSpellCost(spellId);
    if (talentCost)
    {
        int32 free_points = GetMaxTalentPointsForLevel(GetLevel());
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
        WorldPackets::Pet::PetLearnedSpell packet;
        packet.SpellID = spell_id;
        m_owner->SendDirectMessage(packet.Write());
        m_owner->PetSpellInitialize();
    }

    return true;
}

void Pet::InitLevelupSpellsForLevel()
{
    uint8 level = GetLevel();

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
        for (uint32 spellId : defSpells->spellid)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
            if (!spellInfo)
                continue;

            // will called first if level down
            if (spellInfo->SpellLevel > level && sScriptMgr->CanUnlearnSpellDefault(this, spellInfo))
                unlearnSpell(spellInfo->Id, true);
            // will called if level up
            else
                learnSpell(spellInfo->Id);
        }
    }
}

bool Pet::unlearnSpell(uint32 spell_id, bool learn_prev, bool clear_ab)
{
    if (removeSpell(spell_id, learn_prev, clear_ab))
    {
        if (!m_loading)
        {
            WorldPackets::Pet::PetUnlearnedSpell packet;
            packet.SpellID = spell_id;
            m_owner->SendDirectMessage(packet.Write());
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
        int32 free_points = GetMaxTalentPointsForLevel(GetLevel()) - m_usedTalentCount;
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

    uint8 level = GetLevel();
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

        for (uint32 talentSpellId : talentInfo->RankID)
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
                if (itrFirstId == talentSpellId)
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

void Pet::resetTalentsForAllPetsOf(Player* owner, Pet* onlinePet /*= nullptr*/)
{
    // not need after this call
    if (owner->ToPlayer()->HasAtLoginFlag(AT_LOGIN_RESET_PET_TALENTS))
    {
        owner->ToPlayer()->RemoveAtLoginFlag(AT_LOGIN_RESET_PET_TALENTS, true);
    }

    // reset for online
    if (onlinePet)
    {
        onlinePet->resetTalents();
    }

    PetStable* petStable = owner->GetPetStable();
    if (!petStable)
    {
        return;
    }

    std::unordered_set<uint32> petIds;
    if (petStable->CurrentPet)
    {
        petIds.insert(petStable->CurrentPet->PetNumber);
    }

    for (Optional<PetStable::PetInfo> const& stabledPet : petStable->StabledPets)
    {
        if (stabledPet)
        {
            petIds.insert(stabledPet->PetNumber);
        }
    }

    for (PetStable::PetInfo const& unslottedPet : petStable->UnslottedPets)
    {
        petIds.insert(unslottedPet.PetNumber);
    }

    // now need only reset for offline pets (all pets except online case)
    if (onlinePet)
    {
        petIds.erase(onlinePet->GetCharmInfo()->GetPetNumber());
    }

    // no offline pets
    if (petIds.empty())
    {
        return;
    }

    bool need_comma = false;
    std::ostringstream ss;
    ss << "DELETE FROM pet_spell WHERE guid IN (";

    for (uint32 id : petIds)
    {
        if (need_comma)
        {
            ss << ',';
        }

        ss << id;

        need_comma = true;
    }

    ss << ") AND spell IN (";

    need_comma = false;
    for (uint32 spell : sPetTalentSpells)
    {
        if (need_comma)
        {
            ss << ',';
        }

        ss << spell;

        need_comma = true;
    }

    ss << ')';

    CharacterDatabase.Execute(ss.str().c_str());
}

void Pet::InitTalentForLevel()
{
    uint8 level = GetLevel();
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

    return uint8(points * sWorld->getRate(RATE_TALENT_PET));
}

void Pet::ToggleAutocast(SpellInfo const* spellInfo, bool apply)
{
    ASSERT(spellInfo);

    if (!spellInfo->IsAutocastable())
        return;

    PetSpellMap::iterator itr = m_spells.find(spellInfo->Id);
    if (itr == m_spells.end())
        return;

    auto autospellItr = std::find(m_autospells.begin(), m_autospells.end(), spellInfo->Id);

    if (apply)
    {
        if (autospellItr == m_autospells.end())
        {
            m_autospells.push_back(spellInfo->Id);

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
        if (autospellItr != m_autospells.end())
        {
            m_autospells.erase(autospellItr);
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
            if (owner->IsClass(CLASS_WARLOCK, CLASS_CONTEXT_PET))
                return GetCreatureTemplate()->type == CREATURE_TYPE_DEMON;
            else if (owner->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_PET))
                return GetCreatureTemplate()->type == CREATURE_TYPE_UNDEAD;
            else if (owner->IsClass(CLASS_MAGE, CLASS_CONTEXT_PET))
                return GetEntry() == 37994;
            else
                return false;
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

    // Force regen flag for player pets, just like we do for players themselves
    SetUnitFlag2(UNIT_FLAG2_REGENERATE_POWER);
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
        for (uint32 spellId : petStore->second)
            addSpell(spellId, ACT_DECIDE, PETSPELL_NEW, PETSPELL_FAMILY);
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
            GivePetLevel(owner->GetLevel());
            break;
        // can't be greater owner level
        case HUNTER_PET:
            if (GetLevel() > owner->GetLevel())
                GivePetLevel(owner->GetLevel());
            else if (GetLevel() + 5 < owner->GetLevel())
                GivePetLevel(owner->GetLevel() - 5);
            break;
        default:
            break;
    }
}

void Pet::SetDisplayId(uint32 modelId, float displayScale /*= 1.f*/)
{
    Guardian::SetDisplayId(modelId, displayScale);

    if (!isControlled())
        return;

    if (Unit* owner = GetOwner())
        if (Player* player = owner->ToPlayer())
            if (player->GetGroup())
                player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_MODEL_ID);
}

void Pet::CastWhenWillAvailable(uint32 spellid, Unit* spellTarget, ObjectGuid oldTarget, bool spellIsPositive)
{
    if (!spellid)
        return;

    if (!spellTarget)
        return;

    m_tempspellTarget = spellTarget;
    m_tempspell = spellid;
    m_tempspellIsPositive = spellIsPositive;

    if (!oldTarget.IsEmpty())
        m_tempoldTarget = oldTarget;
}

void Pet::ClearCastWhenWillAvailable()
{
    m_tempspellIsPositive = false;
    m_tempspell = 0;
    m_tempspellTarget = nullptr;
    m_tempoldTarget = ObjectGuid::Empty;
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

void Pet::FillPetInfo(PetStable::PetInfo* petInfo) const
{
    petInfo->PetNumber = m_charmInfo->GetPetNumber();
    petInfo->CreatureId = GetEntry();
    petInfo->DisplayId = GetNativeDisplayId();
    petInfo->Level = GetLevel();
    petInfo->Experience = GetUInt32Value(UNIT_FIELD_PETEXPERIENCE);
    petInfo->ReactState = GetReactState();
    petInfo->Name = GetName();
    petInfo->WasRenamed = !HasByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_RENAMED);
    petInfo->Health = GetHealth();
    petInfo->Mana = GetPower(POWER_MANA);
    petInfo->Happiness = GetPower(POWER_HAPPINESS);
    petInfo->ActionBar = GenerateActionBarData();
    petInfo->LastSaveTime = GameTime::GetGameTime().count();
    petInfo->CreatedBySpellId = GetUInt32Value(UNIT_CREATED_BY_SPELL);
    petInfo->Type = getPetType();
}

Player* Pet::GetOwner() const
{
    return m_owner;
}

float Pet::GetNativeObjectScale() const
{
    uint8 ctFamily = GetCreatureTemplate()->family;

    CreatureFamilyEntry const* creatureFamily = sCreatureFamilyStore.LookupEntry(ctFamily);
    if (creatureFamily && creatureFamily->minScale > 0.0f && getPetType() & HUNTER_PET)
    {
        float minScaleLevel = creatureFamily->minScaleLevel;
        uint8 level = GetLevel();

        float minLevelScaleMod = level >= minScaleLevel ? (level / minScaleLevel) : 0.0f;
        float maxScaleMod = creatureFamily->maxScaleLevel - minScaleLevel;

        if (minLevelScaleMod > maxScaleMod)
            minLevelScaleMod = maxScaleMod;

        float scaleMod = creatureFamily->maxScaleLevel != minScaleLevel ? minLevelScaleMod / maxScaleMod : 0.f;

        float maxScale = creatureFamily->maxScale;

        // override maxScale
        switch (ctFamily)
        {
            case CREATURE_FAMILY_CHIMAERA:
            case CREATURE_FAMILY_CORE_HOUND:
            case CREATURE_FAMILY_CRAB:
            case CREATURE_FAMILY_DEVILSAUR:
            case CREATURE_FAMILY_NETHER_RAY:
            case CREATURE_FAMILY_RHINO:
            case CREATURE_FAMILY_SPIDER:
            case CREATURE_FAMILY_TURTLE:
            case CREATURE_FAMILY_WARP_STALKER:
            case CREATURE_FAMILY_WASP:
            case CREATURE_FAMILY_WIND_SERPENT:
                maxScale = 1.0f;
                break;
            default:
                break;
        }

        float scale = (maxScale - creatureFamily->minScale) * scaleMod + creatureFamily->minScale;

        scale = std::min(scale, maxScale);

        return scale;
    }

    // take value for non-hunter pets from DB
    return Guardian::GetNativeObjectScale();
}

std::string Pet::GenerateActionBarData() const
{
    std::ostringstream oss;

    for (uint32 i = ACTION_BAR_INDEX_START; i < ACTION_BAR_INDEX_END; ++i)
    {
        oss << uint32(m_charmInfo->GetActionBarEntry(i)->GetType()) << ' '
            << uint32(m_charmInfo->GetActionBarEntry(i)->GetAction()) << ' ';
    }

    return oss.str();
}

std::string Pet::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << Guardian::GetDebugInfo() << "\n"
        << std::boolalpha
        << "PetType: " << std::to_string(getPetType()) << " "
        << "PetNumber: " << m_charmInfo->GetPetNumber();
    return sstr.str();
}
