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

#include "Creature.h"
#include "BattlegroundMgr.h"
#include "CellImpl.h"
#include "Common.h"
#include "CreatureAI.h"
#include "CreatureAISelector.h"
#include "CreatureGroups.h"
#include "DatabaseEnv.h"
#include "Formulas.h"
#include "GameEventMgr.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "GroupMgr.h"
#include "Log.h"
#include "LootMgr.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "OutdoorPvPMgr.h"
#include "Pet.h"
#include "Player.h"
#include "PoolMgr.h"
#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "TemporarySummon.h"
#include "Transport.h"
#include "Util.h"
#include "Vehicle.h"
#include "WaypointMovementGenerator.h"
#include "World.h"
#include "WorldPacket.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

CreatureMovementData::CreatureMovementData() : Ground(CreatureGroundMovementType::Run), Flight(CreatureFlightMovementType::None),
                                               Swim(true), Rooted(false), Chase(CreatureChaseMovementType::Run),
                                               Random(CreatureRandomMovementType::Walk), InteractionPauseTimer(sWorld->getIntConfig(CONFIG_CREATURE_STOP_FOR_PLAYER)) {}

//npcbot
#include "bot_ai.h"
#include "botmgr.h"
#include "bpet_ai.h"
//end npcbot

std::string CreatureMovementData::ToString() const
{
    constexpr std::array<char const*, 3> GroundStates = {"None", "Run", "Hover"};
    constexpr std::array<char const*, 3> FlightStates = {"None", "DisableGravity", "CanFly"};
    constexpr std::array<char const*, 3> ChaseStates  = {"Run", "CanWalk", "AlwaysWalk"};
    constexpr std::array<char const*, 3> RandomStates = {"Walk", "CanRun", "AlwaysRun"};

    std::ostringstream str;
    str << std::boolalpha
        << "Ground: " << GroundStates[AsUnderlyingType(Ground)]
        << ", Swim: " << Swim
        << ", Flight: " << FlightStates[AsUnderlyingType(Flight)]
        << ", Chase: " << ChaseStates[AsUnderlyingType(Chase)]
        << ", Random: " << RandomStates[AsUnderlyingType(Random)];
    if (Rooted)
        str << ", Rooted";
    str << ", InteractionPauseTimer: " << InteractionPauseTimer;

    return str.str();
}

TrainerSpell const* TrainerSpellData::Find(uint32 spell_id) const
{
    TrainerSpellMap::const_iterator itr = spellList.find(spell_id);
    if (itr != spellList.end())
        return &itr->second;

    return nullptr;
}

bool VendorItemData::RemoveItem(uint32 item_id)
{
    bool found = false;
    for (VendorItemList::iterator i = m_items.begin(); i != m_items.end();)
    {
        if ((*i)->item == item_id)
        {
            i = m_items.erase(i++);
            found = true;
        }
        else
            ++i;
    }
    return found;
}

VendorItemCount::VendorItemCount(uint32 _item, uint32 _count)
    : itemId(_item), count(_count), lastIncrementTime(GameTime::GetGameTime().count()) { }

VendorItem const* VendorItemData::FindItemCostPair(uint32 item_id, uint32 extendedCost) const
{
    for (VendorItemList::const_iterator i = m_items.begin(); i != m_items.end(); ++i)
        if ((*i)->item == item_id && (*i)->ExtendedCost == extendedCost)
            return *i;
    return nullptr;
}

uint32 CreatureTemplate::GetRandomValidModelId() const
{
    uint8 c = 0;
    uint32 modelIDs[4];

    if (Modelid1) modelIDs[c++] = Modelid1;
    if (Modelid2) modelIDs[c++] = Modelid2;
    if (Modelid3) modelIDs[c++] = Modelid3;
    if (Modelid4) modelIDs[c++] = Modelid4;

    return ((c > 0) ? modelIDs[urand(0, c - 1)] : 0);
}

uint32 CreatureTemplate::GetFirstValidModelId() const
{
    if (Modelid1) return Modelid1;
    if (Modelid2) return Modelid2;
    if (Modelid3) return Modelid3;
    if (Modelid4) return Modelid4;
    return 0;
}

void CreatureTemplate::InitializeQueryData()
{
    queryData.Initialize(SMSG_CREATURE_QUERY_RESPONSE, 1);

    queryData << uint32(Entry);                              // creature entry
    queryData << Name;
    queryData << uint8(0) << uint8(0) << uint8(0);           // name2, name3, name4, always empty
    queryData << SubName;
    queryData << IconName;                               // "Directions" for guard, string for Icons 2.3.0
    queryData << uint32(type_flags);                     // flags
    queryData << uint32(type);                           // CreatureType.dbc
    queryData << uint32(family);                         // CreatureFamily.dbc
    queryData << uint32(rank);                           // Creature Rank (elite, boss, etc)
    queryData << uint32(KillCredit[0]);                  // new in 3.1, kill credit
    queryData << uint32(KillCredit[1]);                  // new in 3.1, kill credit
    queryData << uint32(Modelid1);                       // Modelid1
    queryData << uint32(Modelid2);                       // Modelid2
    queryData << uint32(Modelid3);                       // Modelid3
    queryData << uint32(Modelid4);                       // Modelid4
    queryData << float(ModHealth);                       // dmg/hp modifier
    queryData << float(ModMana);                         // dmg/mana modifier
    queryData << uint8(RacialLeader);
    queryData << uint32(movementId);                     // CreatureMovementInfo.dbc
}

bool AssistDelayEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    if (Unit* victim = ObjectAccessor::GetUnit(*m_owner, m_victim))
    {
        // Initialize last damage timer if it doesn't exist
        m_owner->SetLastDamagedTime(GameTime::GetGameTime().count() + MAX_AGGRO_RESET_TIME);

        while (!m_assistants.empty())
        {
            Creature* assistant = ObjectAccessor::GetCreature(*m_owner, *m_assistants.begin());
            m_assistants.pop_front();

            if (assistant && assistant->CanAssistTo(m_owner, victim))
            {
                assistant->SetNoCallAssistance(true);
                assistant->CombatStart(victim);
                if (assistant->IsAIEnabled)
                    assistant->AI()->AttackStart(victim);

                assistant->SetLastDamagedTimePtr(m_owner->GetLastDamagedTimePtr());
            }
        }
    }
    return true;
}

CreatureBaseStats const* CreatureBaseStats::GetBaseStats(uint8 level, uint8 unitClass)
{
    return sObjectMgr->GetCreatureBaseStats(level, unitClass);
}

bool ForcedDespawnDelayEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    m_owner.DespawnOrUnsummon(0s, m_respawnTimer);    // since we are here, we are not TempSummon as object type cannot change during runtime
    return true;
}

bool TemporaryThreatModifierEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    if (Unit* victim = ObjectAccessor::GetUnit(m_owner, m_threatVictimGUID))
    {
        if (m_owner.IsInCombatWith(victim))
        {
            m_owner.GetThreatMgr().ModifyThreatByPercent(victim, -100); // Reset threat to zero.
            m_owner.GetThreatMgr().AddThreat(victim, m_threatValue);  // Set to the previous value it had, first before modification.
        }
    }

    return true;
}

Creature::Creature(bool isWorldObject): Unit(isWorldObject), MovableMapObject(), m_groupLootTimer(0), lootingGroupLowGUID(0), m_lootRecipientGroup(0),
    m_corpseRemoveTime(0), m_respawnTime(0), m_respawnDelay(300), m_corpseDelay(60), m_wanderDistance(0.0f), m_boundaryCheckTime(2500),
    m_transportCheckTimer(1000), lootPickPocketRestoreTime(0), m_combatPulseTime(0), m_combatPulseDelay(0), m_reactState(REACT_AGGRESSIVE), m_defaultMovementType(IDLE_MOTION_TYPE),
    m_spawnId(0), m_equipmentId(0), m_originalEquipmentId(0), m_AlreadyCallAssistance(false),
    m_AlreadySearchedAssistance(false), m_regenHealth(true), m_regenPower(true), m_AI_locked(false), m_meleeDamageSchoolMask(SPELL_SCHOOL_MASK_NORMAL), m_originalEntry(0), m_moveInLineOfSightDisabled(false), m_moveInLineOfSightStrictlyDisabled(false),
    m_homePosition(), m_transportHomePosition(), m_creatureInfo(nullptr), m_creatureData(nullptr), m_detectionDistance(20.0f), m_waypointID(0), m_path_id(0), m_formation(nullptr), _lastDamagedTime(nullptr), m_cannotReachTimer(0),
    _isMissingSwimmingFlagOutOfCombat(false), m_assistanceTimer(0), _playerDamageReq(0), _damagedByPlayer(false)
{
    m_regenTimer = CREATURE_REGEN_INTERVAL;
    m_valuesCount = UNIT_END;

    for (uint8 i = 0; i < MAX_CREATURE_SPELLS; ++i)
        m_spells[i] = 0;

    for (uint8 i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; ++i)
        m_ProhibitSchoolTime[i] = 0;

    m_CreatureSpellCooldowns.clear();
    DisableReputationGain = false;

    m_SightDistance = sWorld->getFloatConfig(CONFIG_SIGHT_MONSTER);
    m_CombatDistance = 0.0f;

    ResetLootMode(); // restore default loot mode
    TriggerJustRespawned = false;
    m_isTempWorldObject = false;
    _focusSpell = nullptr;

    m_respawnedTime = time_t(0);

    //npcbot
    bot_AI = nullptr;
    bot_pet_AI = nullptr;
    //end npcbot
}

Creature::~Creature()
{
    m_vendorItemCounts.clear();

    delete i_AI;
    i_AI = nullptr;
}

void Creature::AddToWorld()
{
    ///- Register the creature for guid lookup
    if (!IsInWorld())
    {
        // pussywizard: motion master needs to be initialized before OnCreatureCreate, which may set death state to JUST_DIED, to prevent crash
        // it's also initialized in AIM_Initialize(), few lines below, but it's not a problem
        Motion_Initialize();

        GetMap()->GetObjectsStore().Insert<Creature>(GetGUID(), this);
        if (m_spawnId)
        {
            GetMap()->GetCreatureBySpawnIdStore().insert(std::make_pair(m_spawnId, this));
        }
        Unit::AddToWorld();

        SearchFormation();

        AIM_Initialize();

        if (IsVehicle())
        {
            GetVehicleKit()->Install();
        }

        if (GetZoneScript())
        {
            GetZoneScript()->OnCreatureCreate(this);
        }

        loot.sourceWorldObjectGUID = GetGUID();

        sScriptMgr->OnCreatureAddWorld(this);
    }
}

void Creature::RemoveFromWorld()
{
    if (IsInWorld())
    {
        sScriptMgr->OnCreatureRemoveWorld(this);

        if (GetZoneScript())
            GetZoneScript()->OnCreatureRemove(this);

        if (m_formation)
            sFormationMgr->RemoveCreatureFromGroup(m_formation, this);

        if (Transport* transport = GetTransport())
            transport->RemovePassenger(this, true);

        Unit::RemoveFromWorld();

        if (m_spawnId)
            Acore::Containers::MultimapErasePair(GetMap()->GetCreatureBySpawnIdStore(), m_spawnId, this);

        GetMap()->GetObjectsStore().Remove<Creature>(GetGUID());
    }
}

void Creature::DisappearAndDie()
{
    DestroyForNearbyPlayers();
    //SetVisibility(VISIBILITY_OFF);
    //ObjectAccessor::UpdateObjectVisibility(this);
    if (IsAlive())
        setDeathState(DeathState::JustDied, true);
    RemoveCorpse(false, true);
}

void Creature::SearchFormation()
{
    if (IsSummon())
    {
        return;
    }

    ObjectGuid::LowType spawnId = GetSpawnId();
    if (!spawnId)
    {
        return;
    }

    CreatureGroupInfoType::const_iterator frmdata = sFormationMgr->CreatureGroupMap.find(spawnId);
    if (frmdata != sFormationMgr->CreatureGroupMap.end())
    {
        sFormationMgr->AddCreatureToGroup(frmdata->second.leaderGUID, this);
    }
}

void Creature::RemoveCorpse(bool setSpawnTime, bool skipVisibility)
{
    //npcbot
    if (IsNPCBotOrPet())
        return;
    //end npcbot

    if (getDeathState() != DeathState::Corpse)
        return;

    m_corpseRemoveTime = GameTime::GetGameTime().count();
    setDeathState(DeathState::Dead);
    RemoveAllAuras();
    if (!skipVisibility) // pussywizard
        DestroyForNearbyPlayers(); // pussywizard: previous UpdateObjectVisibility()
    loot.clear();
    uint32 respawnDelay = m_respawnDelay;
    if (IsAIEnabled)
        AI()->CorpseRemoved(respawnDelay);

    // Should get removed later, just keep "compatibility" with scripts
    if (setSpawnTime)
    {
        m_respawnTime = GameTime::GetGameTime().count() + respawnDelay;
        //SaveRespawnTime();
    }

    float x, y, z, o;
    GetRespawnPosition(x, y, z, &o);
    SetHomePosition(x, y, z, o);
    SetPosition(x, y, z, o);

    // xinef: relocate notifier
    m_last_notify_position.Relocate(-5000.0f, -5000.0f, -5000.0f, 0.0f);

    // pussywizard: if corpse was removed during falling then the falling will continue after respawn, so stop falling is such case
    if (IsFalling())
        StopMoving();
}

/**
 * change the entry of creature until respawn
 */
bool Creature::InitEntry(uint32 Entry, const CreatureData* data)
{
    CreatureTemplate const* normalInfo = sObjectMgr->GetCreatureTemplate(Entry);
    if (!normalInfo)
    {
        LOG_ERROR("sql.sql", "Creature::InitEntry creature entry {} does not exist.", Entry);
        return false;
    }

    // get difficulty 1 mode entry
    // Xinef: Skip for pets!
    CreatureTemplate const* cinfo = normalInfo;
    for (uint8 diff = uint8(GetMap()->GetSpawnMode()); diff > 0 && !IsPet();)
    {
        // we already have valid Map pointer for current creature!
        if (normalInfo->DifficultyEntry[diff - 1])
        {
            cinfo = sObjectMgr->GetCreatureTemplate(normalInfo->DifficultyEntry[diff - 1]);
            if (cinfo)
                break;                                      // template found

            // check and reported at startup, so just ignore (restore normalInfo)
            cinfo = normalInfo;
        }

        // for instances heroic to normal, other cases attempt to retrieve previous difficulty
        if (diff >= RAID_DIFFICULTY_10MAN_HEROIC && GetMap()->IsRaid())
            diff -= 2;                                      // to normal raid difficulty cases
        else
            --diff;
    }

    SetEntry(Entry);                                        // normal entry always
    m_creatureInfo = cinfo;                                 // map mode related always

    // equal to player Race field, but creature does not have race
    SetByteValue(UNIT_FIELD_BYTES_0, 0, 0);

    // known valid are: CLASS_WARRIOR, CLASS_PALADIN, CLASS_ROGUE, CLASS_MAGE
    SetByteValue(UNIT_FIELD_BYTES_0, 1, uint8(cinfo->unit_class));

    // Cancel load if no model defined
    if (!(cinfo->GetFirstValidModelId()))
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has no model defined in table `creature_template`, can't load. ", Entry);
        return false;
    }

    uint32 displayID = ObjectMgr::ChooseDisplayId(GetCreatureTemplate(), data);
    if (!sObjectMgr->GetCreatureModelRandomGender(&displayID))                                             // Cancel load if no model defined
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has no model defined in table `creature_template`, can't load. ", Entry);
        return false;
    }

    SetDisplayId(displayID);
    SetNativeDisplayId(displayID);

    // Load creature equipment
    if (!data)
    {
        LoadEquipment();             // use default from the template
    }
    else if (data->equipmentId == 0)
    {
        LoadEquipment(0);            // 0 means no equipment for creature table
    }
    else
    {
        m_originalEquipmentId = data->equipmentId;
        LoadEquipment(data->equipmentId);
    }

    SetName(normalInfo->Name);                              // at normal entry always

    SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);

    SetSpeed(MOVE_WALK, cinfo->speed_walk);
    SetSpeed(MOVE_RUN, cinfo->speed_run);
    SetSpeed(MOVE_SWIM, cinfo->speed_swim);
    SetSpeed(MOVE_FLIGHT, cinfo->speed_flight);

    // Will set UNIT_FIELD_BOUNDINGRADIUS and UNIT_FIELD_COMBATREACH
    SetObjectScale(GetNativeObjectScale());

    SetFloatValue(UNIT_FIELD_HOVERHEIGHT, cinfo->HoverHeight);

    // checked at loading
    m_defaultMovementType = MovementGeneratorType(cinfo->MovementType);
    if (!m_wanderDistance && m_defaultMovementType == RANDOM_MOTION_TYPE)
        m_defaultMovementType = IDLE_MOTION_TYPE;

    for (uint8 i = 0; i < MAX_CREATURE_SPELLS; ++i)
        m_spells[i] = GetCreatureTemplate()->spells[i];

    return true;
}

bool Creature::UpdateEntry(uint32 Entry, const CreatureData* data, bool changelevel, bool updateAI)
{
    if (!InitEntry(Entry, data))
        return false;

    CreatureTemplate const* cInfo = GetCreatureTemplate();

    m_regenHealth = cInfo->RegenHealth;

    // creatures always have melee weapon ready if any unless specified otherwise
    if (!GetCreatureAddon())
        SetSheath(SHEATH_STATE_MELEE);

    SetFaction(cInfo->faction);

    uint32 npcflag, unit_flags, dynamicflags;
    ObjectMgr::ChooseCreatureFlags(cInfo, npcflag, unit_flags, dynamicflags, data);

    if (cInfo->flags_extra & CREATURE_FLAG_EXTRA_WORLDEVENT)
        ReplaceAllNpcFlags(NPCFlags(npcflag | sGameEventMgr->GetNPCFlag(this)));
    else
        ReplaceAllNpcFlags(NPCFlags(npcflag));

    // Xinef: NPC is in combat, keep this flag!
    unit_flags &= ~UNIT_FLAG_IN_COMBAT;
    if (IsInCombat())
        unit_flags |= UNIT_FLAG_IN_COMBAT;

    ReplaceAllUnitFlags(UnitFlags(unit_flags));
    ReplaceAllUnitFlags2(UnitFlags2(cInfo->unit_flags2));

    ReplaceAllDynamicFlags(dynamicflags);

    SetAttackTime(BASE_ATTACK,   cInfo->BaseAttackTime);
    SetAttackTime(OFF_ATTACK,    cInfo->BaseAttackTime);
    SetAttackTime(RANGED_ATTACK, cInfo->RangeAttackTime);

    uint32 previousHealth = GetHealth();
    uint32 previousMaxHealth = GetMaxHealth();
    uint32 previousPlayerDamageReq = _playerDamageReq;

    SelectLevel(changelevel);
    if (previousHealth > 0)
    {
        SetHealth(previousHealth);

        if (previousMaxHealth && previousMaxHealth > GetMaxHealth())
        {
            _playerDamageReq = (uint32)(previousPlayerDamageReq * GetMaxHealth() / previousMaxHealth);
        }
        else
        {
            _playerDamageReq = previousPlayerDamageReq;
        }
    }

    SetMeleeDamageSchool(SpellSchools(cInfo->dmgschool));
    CreatureBaseStats const* stats = sObjectMgr->GetCreatureBaseStats(GetLevel(), cInfo->unit_class);
    float armor = stats->GenerateArmor(cInfo);
    SetModifierValue(UNIT_MOD_ARMOR,             BASE_VALUE, armor);
    SetModifierValue(UNIT_MOD_RESISTANCE_HOLY,   BASE_VALUE, float(cInfo->resistance[SPELL_SCHOOL_HOLY]));
    SetModifierValue(UNIT_MOD_RESISTANCE_FIRE,   BASE_VALUE, float(cInfo->resistance[SPELL_SCHOOL_FIRE]));
    SetModifierValue(UNIT_MOD_RESISTANCE_NATURE, BASE_VALUE, float(cInfo->resistance[SPELL_SCHOOL_NATURE]));
    SetModifierValue(UNIT_MOD_RESISTANCE_FROST,  BASE_VALUE, float(cInfo->resistance[SPELL_SCHOOL_FROST]));
    SetModifierValue(UNIT_MOD_RESISTANCE_SHADOW, BASE_VALUE, float(cInfo->resistance[SPELL_SCHOOL_SHADOW]));
    SetModifierValue(UNIT_MOD_RESISTANCE_ARCANE, BASE_VALUE, float(cInfo->resistance[SPELL_SCHOOL_ARCANE]));

    SetCanModifyStats(true);
    UpdateAllStats();

    // checked and error show at loading templates
    if (FactionTemplateEntry const* factionTemplate = sFactionTemplateStore.LookupEntry(cInfo->faction))
    {
        if (factionTemplate->factionFlags & FACTION_TEMPLATE_FLAG_ASSIST_PLAYERS)
            SetPvP(true);
        else
            SetPvP(false);
    }

    // updates spell bars for vehicles and set player's faction - should be called here, to overwrite faction that is set from the new template
    if (IsVehicle())
    {
        if (Player* owner = Creature::GetCharmerOrOwnerPlayerOrPlayerItself()) // this check comes in case we don't have a player
        {
            SetFaction(owner->GetFaction()); // vehicles should have same as owner faction
            owner->VehicleSpellInitialize();
        }
    }

    // trigger creature is always not selectable and can not be attacked
    if (IsTrigger())
        SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

    InitializeReactState();

    if (!IsPet() && cInfo->flags_extra & CREATURE_FLAG_EXTRA_NO_TAUNT)
    {
        ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
        ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);
    }

    SetDetectionDistance(cInfo->detection_range);

    // Update movement
    if (IsRooted())
        SetControlled(true, UNIT_STATE_ROOT);
    UpdateMovementFlags();

    LoadSpellTemplateImmunity();

    if (updateAI)
    {
        AIM_Initialize();
    }

    return true;
}

void Creature::Update(uint32 diff)
{
    //npcbot: update helper
    if (bot_AI)
    {
        if (!bot_AI->canUpdate)
        {
            return;
        }

        bot_AI->CommonTimers(diff);
    }
    else if (bot_pet_AI)
    {
        if (!bot_pet_AI->canUpdate)
        {
            //needed for delayed unsummon
            m_Events.Update(diff);
            return;
        }

        bot_pet_AI->CommonTimers(diff);
    }
    //end npcbot

    if (IsAIEnabled && TriggerJustRespawned)
    {
        TriggerJustRespawned = false;
        AI()->JustRespawned();
        if (m_vehicleKit)
            m_vehicleKit->Reset();
    }

    switch (m_deathState)
    {
        case DeathState::JustRespawned:
            // Must not be called, see Creature::setDeathState JUST_RESPAWNED -> ALIVE promoting.
            LOG_ERROR("entities.unit", "Creature ({}) in wrong state: DeathState::JustRespawned (4)", GetGUID().ToString());
            break;
        case DeathState::JustDied:
            // Must not be called, see Creature::setDeathState JUST_DIED -> CORPSE promoting.
            LOG_ERROR("entities.unit", "Creature ({}) in wrong state: DeathState::JustDead (1)", GetGUID().ToString());
            break;
        case DeathState::Dead:
        {
            //npcbot
            if (bot_AI || bot_pet_AI)
                break;
            //end npcbot
            time_t now = GameTime::GetGameTime().count();
            if (m_respawnTime <= now)
            {
                Respawn();
            }
            break;
        }
        case DeathState::Corpse:
        {
            Unit::Update(diff);
            // deathstate changed on spells update, prevent problems
            if (m_deathState != DeathState::Corpse)
                break;

            if (m_groupLootTimer && lootingGroupLowGUID)
            {
                if (m_groupLootTimer <= diff)
                {
                    Group* group = sGroupMgr->GetGroupByGUID(lootingGroupLowGUID);
                    if (group)
                        group->EndRoll(&loot, GetMap());
                    m_groupLootTimer = 0;
                    lootingGroupLowGUID = 0;
                }
                else
                {
                    m_groupLootTimer -= diff;
                }
            }
            //npcbot: update dead bots
            else if (bot_AI)
            {
                bot_AI->UpdateDeadAI(diff);
                break;
            }
            else if (bot_pet_AI)
                break;
            //end npcbot
            else if (m_corpseRemoveTime <= GameTime::GetGameTime().count())
            {
                //npcbot: do not remove corpse
                if (IsNPCBotOrPet())
                    break;
                //end npcbot
                RemoveCorpse(false);
                LOG_DEBUG("entities.unit", "Removing corpse... {} ", GetUInt32Value(OBJECT_FIELD_ENTRY));
            }
            break;
        }
        case DeathState::Alive:
        {
            Unit::Update(diff);

            // creature can be dead after Unit::Update call
            // CORPSE/DEAD state will processed at next tick (in other case death timer will be updated unexpectedly)
            //npcbot - skip dead state for bots (handled by AI)
            if (!bot_AI && !bot_pet_AI)
            //end npcbot
            if (!IsAlive())
                break;

            // if creature is charmed, switch to charmed AI
            if (NeedChangeAI)
            {
                UpdateCharmAI();
                NeedChangeAI = false;
                IsAIEnabled = true;

                // xinef: update combat state, if npc is not in combat - return to spawn correctly by calling EnterEvadeMode
                SelectVictim();
            }

            // if periodic combat pulse is enabled and we are both in combat and in a dungeon, do this now
            if (m_combatPulseDelay > 0 && IsInCombat() && GetMap()->IsDungeon())
            {
                if (diff > m_combatPulseTime)
                    m_combatPulseTime = 0;
                else
                    m_combatPulseTime -= diff;

                if (m_combatPulseTime == 0)
                {
                    if (AI())
                        AI()->DoZoneInCombat();
                    else
                        SetInCombatWithZone();
                    m_combatPulseTime = m_combatPulseDelay * IN_MILLISECONDS;
                }
            }

            // periodic check to see if the creature has passed an evade boundary
            if (IsAIEnabled && !IsInEvadeMode() && IsEngaged())
            {
                if (diff >= m_boundaryCheckTime)
                {
                    AI()->CheckInRoom();
                    m_boundaryCheckTime = 2500;
                }
                else
                    m_boundaryCheckTime -= diff;
            }

            Unit* owner = GetCharmerOrOwner();
            if (IsCharmed() && !IsWithinDistInMap(owner, GetMap()->GetVisibilityRange(), true, false))
            {
                RemoveCharmAuras();
            }

            if (Unit* victim = GetVictim())
            {
                // If we are closer than 50% of the combat reach we are going to reposition the victim
                if (diff >= m_moveBackwardsMovementTime)
                {
                    float MaxRange = GetCollisionRadius() + GetVictim()->GetCollisionRadius();

                    if (IsInDist(victim, MaxRange))
                        AI()->MoveBackwardsChecks();

                    m_moveBackwardsMovementTime = urand(MOVE_BACKWARDS_CHECK_INTERVAL, MOVE_BACKWARDS_CHECK_INTERVAL * 3);
                }
                else
                {
                    m_moveBackwardsMovementTime -= diff;
                }

                // Circling the target
                if (diff >= m_moveCircleMovementTime)
                {
                    AI()->MoveCircleChecks();
                    m_moveCircleMovementTime = urand(MOVE_CIRCLE_CHECK_INTERVAL, MOVE_CIRCLE_CHECK_INTERVAL * 2);
                }
                else
                {
                    m_moveCircleMovementTime -= diff;
                }
            }

            // Call for assistance if not disabled
            if (m_assistanceTimer)
            {
                if (m_assistanceTimer <= diff)
                {
                    if (CanPeriodicallyCallForAssistance())
                    {
                        SetNoCallAssistance(false);
                        CallAssistance();
                    }
                    m_assistanceTimer = sWorld->getIntConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_PERIOD);
                }
                else
                {
                    m_assistanceTimer -= diff;
                }
            }

            if (!IsInEvadeMode() && IsAIEnabled)
            {
                // do not allow the AI to be changed during update
                m_AI_locked = true;
                i_AI->UpdateAI(diff);
                m_AI_locked = false;
            }

            //npcbot: skip regeneration
            if (bot_AI || bot_pet_AI)
                break;
            //end npcbot

            // creature can be dead after UpdateAI call
            // CORPSE/DEAD state will processed at next tick (in other case death timer will be updated unexpectedly)
            if (!IsAlive())
                break;

            m_regenTimer -= diff;
            if (m_regenTimer <= 0)
            {
                if (!IsInEvadeMode())
                {
                    // regenerate health if not in combat or if polymorphed)
                    if (!IsInCombat() || IsPolymorphed())
                        RegenerateHealth();
                    else if (IsNotReachableAndNeedRegen())
                    {
                        // regenerate health if cannot reach the target and the setting is set to do so.
                        // this allows to disable the health regen of raid bosses if pathfinding has issues for whatever reason
                        if (sWorld->getBoolConfig(CONFIG_REGEN_HP_CANNOT_REACH_TARGET_IN_RAID) || !GetMap()->IsRaid())
                        {
                            RegenerateHealth();
                            LOG_DEBUG("entities.unit", "RegenerateHealth() enabled because Creature cannot reach the target. Detail: {}", GetDebugInfo());
                        }
                        else
                            LOG_DEBUG("entities.unit", "RegenerateHealth() disabled even if the Creature cannot reach the target. Detail: {}", GetDebugInfo());
                    }
                }

                if (getPowerType() == POWER_ENERGY)
                    Regenerate(POWER_ENERGY);
                else
                    Regenerate(POWER_MANA);

                m_regenTimer += CREATURE_REGEN_INTERVAL;
            }

            if (CanNotReachTarget() && !IsInEvadeMode())
            {
                m_cannotReachTimer += diff;
                if (m_cannotReachTimer >= (sWorld->getIntConfig(CONFIG_NPC_EVADE_IF_NOT_REACHABLE) * IN_MILLISECONDS))
                {
                    Player* cannotReachPlayer = ObjectAccessor::GetPlayer(*this, m_cannotReachTarget);
                    if (cannotReachPlayer && IsEngagedBy(cannotReachPlayer) && IsAIEnabled && AI()->OnTeleportUnreacheablePlayer(cannotReachPlayer))
                    {
                        SetCannotReachTarget();
                    }
                    else if (!GetMap()->IsRaid())
                    {
                        auto EnterEvade = [&]()
                        {
                            if (CreatureAI* ai = AI())
                            {
                                ai->EnterEvadeMode(CreatureAI::EvadeReason::EVADE_REASON_NO_PATH);
                            }
                        };

                        if (GetThreatMgr().GetThreatListSize() <= 1)
                        {
                            EnterEvade();
                        }
                        else
                        {
                            if (HostileReference* ref = GetThreatMgr().GetOnlineContainer().getReferenceByTarget(m_cannotReachTarget))
                            {
                                ref->removeReference();
                                SetCannotReachTarget();
                            }
                            else
                            {
                                EnterEvade();
                            }
                        }
                    }
                }
            }
            break;
        }
        default:
            break;
    }

    if (IsInWorld() && !IsDuringRemoveFromWorld())
    {
        // pussywizard:
        if (GetOwnerGUID().IsPlayer())
        //npcbot: do not add bots to transport (handled inside AI)
        if (!IsNPCBotOrPet())
        //end npcbot
        {
            if (m_transportCheckTimer <= diff)
            {
                m_transportCheckTimer = 1000;
                Transport* newTransport = GetMap()->GetTransportForPos(GetPhaseMask(), GetPositionX(), GetPositionY(), GetPositionZ(), this);
                if (newTransport != GetTransport())
                {
                    if (GetTransport())
                        GetTransport()->RemovePassenger(this, true);
                    if (newTransport)
                        newTransport->AddPassenger(this, true);
                    this->StopMovingOnCurrentPos();
                    //SendMovementFlagUpdate();
                }
            }
            else
                m_transportCheckTimer -= diff;
        }

        sScriptMgr->OnCreatureUpdate(this, diff);
    }
}

bool Creature::IsFreeToMove()
{
    uint32 moveFlags = m_movementInfo.GetMovementFlags();
    // Do not reposition ourself when we are not allowed to move
    if ((IsMovementPreventedByCasting() || isMoving() || !CanFreeMove()) &&
        (GetMotionMaster()->GetCurrentMovementGeneratorType() != CHASE_MOTION_TYPE ||
        moveFlags & MOVEMENTFLAG_SPLINE_ENABLED))
    {
        return false;
    }

    return true;
}

void Creature::Regenerate(Powers power)
{
    uint32 curValue = GetPower(power);
    uint32 maxValue = GetMaxPower(power);

    // Xinef: implement power regeneration flag
    if (!HasUnitFlag2(UNIT_FLAG2_REGENERATE_POWER) && !GetOwnerGUID().IsPlayer())
        return;

    if (!m_regenPower)
    {
        return;
    }

    if (curValue >= maxValue)
        return;

    float addvalue = 0.0f;

    switch (power)
    {
        case POWER_FOCUS:
            {
                // For hunter pets.
                addvalue = 24 * sWorld->getRate(RATE_POWER_FOCUS);
                break;
            }
        case POWER_ENERGY:
            {
                // For deathknight's ghoul.
                addvalue = 20;
                break;
            }
        case POWER_MANA:
            {
                // Combat and any controlled creature
                if (IsInCombat() || GetCharmerOrOwnerGUID())
                {
                    if (GetEntry() == NPC_IMP || GetEntry() == NPC_WATER_ELEMENTAL_TEMP || GetEntry() == NPC_WATER_ELEMENTAL_PERM)
                    {
                        addvalue = uint32((GetStat(STAT_SPIRIT) / (IsUnderLastManaUseEffect() ? 8.0f : 5.0f) + 17.0f));
                    }
                    else if (!IsUnderLastManaUseEffect())
                    {
                        float ManaIncreaseRate = sWorld->getRate(RATE_POWER_MANA);
                        float Spirit = GetStat(STAT_SPIRIT);

                        addvalue = uint32((Spirit / 5.0f + 17.0f) * ManaIncreaseRate);
                    }
                }
                else
                    addvalue = maxValue / 3;
                break;
            }
        default:
            return;
    }

    // Apply modifiers (if any).
    AuraEffectList const& ModPowerRegenPCTAuras = GetAuraEffectsByType(SPELL_AURA_MOD_POWER_REGEN_PERCENT);
    for (AuraEffectList::const_iterator i = ModPowerRegenPCTAuras.begin(); i != ModPowerRegenPCTAuras.end(); ++i)
        if (Powers((*i)->GetMiscValue()) == power)
            AddPct(addvalue, (*i)->GetAmount());

    addvalue += GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_POWER_REGEN, power) * (power == POWER_FOCUS ? PET_FOCUS_REGEN_INTERVAL.count() : CREATURE_REGEN_INTERVAL) / (5 * IN_MILLISECONDS);

    ModifyPower(power, int32(addvalue));
}

void Creature::RegenerateHealth()
{
    if (!isRegeneratingHealth())
        return;

    uint32 curValue = GetHealth();
    uint32 maxValue = GetMaxHealth();

    if (curValue >= maxValue)
        return;

    uint32 addvalue = 0;

    // Not only pet, but any controlled creature
    // Xinef: fix polymorph rapid regen
    if (!GetCharmerOrOwnerGUID() || IsPolymorphed())
        addvalue = maxValue / 3;
    else //if (GetCharmerOrOwnerGUID())
    {
        float HealthIncreaseRate = sWorld->getRate(RATE_HEALTH);
        float Spirit = GetStat(STAT_SPIRIT);

        if (GetPower(POWER_MANA) > 0)
            addvalue = uint32(Spirit * 0.25 * HealthIncreaseRate);
        else
            addvalue = uint32(Spirit * 0.80 * HealthIncreaseRate);
    }

    // Apply modifiers (if any).
    AuraEffectList const& ModPowerRegenPCTAuras = GetAuraEffectsByType(SPELL_AURA_MOD_HEALTH_REGEN_PERCENT);
    for (AuraEffectList::const_iterator i = ModPowerRegenPCTAuras.begin(); i != ModPowerRegenPCTAuras.end(); ++i)
        AddPct(addvalue, (*i)->GetAmount());

    addvalue += GetTotalAuraModifier(SPELL_AURA_MOD_REGEN) * CREATURE_REGEN_INTERVAL  / (5 * IN_MILLISECONDS);

    ModifyHealth(addvalue);
}

void Creature::DoFleeToGetAssistance()
{
    if (!GetVictim())
        return;

    if (HasAuraType(SPELL_AURA_PREVENTS_FLEEING))
        return;

    float radius = sWorld->getFloatConfig(CONFIG_CREATURE_FAMILY_FLEE_ASSISTANCE_RADIUS);
    if (radius > 0)
    {
        Creature* creature = nullptr;

        Acore::NearestAssistCreatureInCreatureRangeCheck u_check(this, GetVictim(), radius);
        Acore::CreatureLastSearcher<Acore::NearestAssistCreatureInCreatureRangeCheck> searcher(this, creature, u_check);

        Cell::VisitGridObjects(this, searcher, radius);

        SetNoSearchAssistance(true);
        UpdateSpeed(MOVE_RUN, false);

        if (!creature)
            //SetFeared(true, GetVictim()->GetGUID(), 0, sWorld->getIntConfig(CONFIG_CREATURE_FAMILY_FLEE_DELAY));
            //TODO: use 31365
            SetControlled(true, UNIT_STATE_FLEEING, GetVictim());
        else
            GetMotionMaster()->MoveSeekAssistance(creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ());
    }
}

bool Creature::AIM_Initialize(CreatureAI* ai)
{
    // make sure nothing can change the AI during AI update
    if (m_AI_locked)
    {
        LOG_DEBUG("scripts.ai", "AIM_Initialize: failed to init, locked.");
        return false;
    }

    UnitAI* oldAI = i_AI;

    // Xinef: called in add to world
    //Motion_Initialize();

    //npcbot: prevent overriding bot_AI
    if (bot_AI || bot_pet_AI)
        return false;
    //end npcbot

    i_AI = ai ? ai : FactorySelector::SelectAI(this);
    delete oldAI;
    IsAIEnabled = true;
    i_AI->InitializeAI();

    // Xinef: Initialize vehicle if it is not summoned!
    if (GetVehicleKit() && m_spawnId)
        GetVehicleKit()->Reset();
    return true;
}

void Creature::Motion_Initialize()
{
    if (!m_formation)
        GetMotionMaster()->Initialize();
    else if (m_formation->GetLeader() == this)
    {
        m_formation->FormationReset(false, true);
        GetMotionMaster()->Initialize();
    }
    else if (m_formation->IsFormed())
        GetMotionMaster()->MoveIdle(); //wait the order of leader
    else
        GetMotionMaster()->Initialize();
}

bool Creature::Create(ObjectGuid::LowType guidlow, Map* map, uint32 phaseMask, uint32 Entry, uint32 vehId, float x, float y, float z, float ang, const CreatureData* data)
{
    ASSERT(map);
    SetMap(map);
    SetPhaseMask(phaseMask, false);

    CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(Entry);
    if (!cinfo)
    {
        LOG_ERROR("sql.sql", "Creature::Create(): creature template (guidlow: {}, entry: {}) does not exist.", guidlow, Entry);
        return false;
    }

    //! Relocate before CreateFromProto, to initialize coords and allow
    //! returning correct zone id for selecting OutdoorPvP/Battlefield script
    Relocate(x, y, z, ang);

    if (!IsPositionValid())
    {
        LOG_ERROR("entities.unit", "Creature::Create(): given coordinates for creature (guidlow {}, entry {}) are not valid (X: {}, Y: {}, Z: {}, O: {})", guidlow, Entry, x, y, z, ang);
        return false;
    }

    // area/zone id is needed immediately for ZoneScript::GetCreatureEntry hook before it is known which creature template to load (no model/scale available yet)
    PositionFullTerrainStatus terrainData;
    GetMap()->GetFullTerrainStatusForPosition(GetPhaseMask(), GetPositionX(), GetPositionY(), GetPositionZ(), DEFAULT_COLLISION_HEIGHT, terrainData);
    ProcessPositionDataChanged(terrainData);

    //oX = x;     oY = y;    dX = x;    dY = y;    m_moveTime = 0;    m_startMove = 0;
    if (!CreateFromProto(guidlow, Entry, vehId, data))
        return false;

    UpdateMovementFlags();

    switch (GetCreatureTemplate()->rank)
    {
        case CREATURE_ELITE_RARE:
            m_corpseDelay = sWorld->getIntConfig(CONFIG_CORPSE_DECAY_RARE);
            break;
        case CREATURE_ELITE_ELITE:
            m_corpseDelay = sWorld->getIntConfig(CONFIG_CORPSE_DECAY_ELITE);
            break;
        case CREATURE_ELITE_RAREELITE:
            m_corpseDelay = sWorld->getIntConfig(CONFIG_CORPSE_DECAY_RAREELITE);
            break;
        case CREATURE_ELITE_WORLDBOSS:
            // Xinef: Reduce corpse delay for bossess outside of instance
            if (!GetInstanceId())
                m_corpseDelay = sWorld->getIntConfig(CONFIG_CORPSE_DECAY_ELITE) * 2;
            else
                m_corpseDelay = sWorld->getIntConfig(CONFIG_CORPSE_DECAY_WORLDBOSS);
            break;
        default:
            m_corpseDelay = sWorld->getIntConfig(CONFIG_CORPSE_DECAY_NORMAL);
            break;
    }

    uint32 displayID = GetNativeDisplayId();
    if (sObjectMgr->GetCreatureModelRandomGender(&displayID) && !IsTotem())                               // Cancel load if no model defined or if totem
    {
        SetDisplayId(displayID);
        SetNativeDisplayId(displayID);
    }

    LoadCreaturesAddon();

    //! Need to be called after LoadCreaturesAddon - MOVEMENTFLAG_HOVER is set there
    m_positionZ += GetHoverHeight();

    LastUsedScriptID = GetScriptId();

    if (IsSpiritHealer() || IsSpiritGuide() || (GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_GHOST_VISIBILITY))
    {
        m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_GHOST);
        m_serverSideVisibilityDetect.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_GHOST);
    }
    else if (cinfo->type_flags & CREATURE_TYPE_FLAG_VISIBLE_TO_GHOSTS) // Xinef: Add ghost visibility for ghost units
        m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_ALIVE | GHOST_VISIBILITY_GHOST);

    if (Entry == VISUAL_WAYPOINT)
        SetVisible(false);

    if (GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_IGNORE_PATHFINDING)
        AddUnitState(UNIT_STATE_IGNORE_PATHFINDING);

    return true;
}

bool Creature::isCanInteractWithBattleMaster(Player* player, bool msg) const
{
    if (!IsBattleMaster())
        return false;

    BattlegroundTypeId bgTypeId = sBattlegroundMgr->GetBattleMasterBG(GetEntry());
    if (!msg)
        return player->GetBGAccessByLevel(bgTypeId);

    if (!player->GetBGAccessByLevel(bgTypeId))
    {
        ClearGossipMenuFor(player);
        switch (bgTypeId)
        {
            case BATTLEGROUND_AV:
                SendGossipMenuFor(player, 7616, this);
                break;
            case BATTLEGROUND_WS:
                SendGossipMenuFor(player, 7599, this);
                break;
            case BATTLEGROUND_AB:
                SendGossipMenuFor(player, 7642, this);
                break;
            case BATTLEGROUND_EY:
            case BATTLEGROUND_NA:
            case BATTLEGROUND_BE:
            case BATTLEGROUND_AA:
            case BATTLEGROUND_RL:
            case BATTLEGROUND_SA:
            case BATTLEGROUND_DS:
            case BATTLEGROUND_RV:
                SendGossipMenuFor(player, 10024, this);
                break;
            default:
                break;
        }
        return false;
    }
    return true;
}

bool Creature::isCanTrainingAndResetTalentsOf(Player* player) const
{
    return player->GetLevel() >= 10
           && GetCreatureTemplate()->trainer_type == TRAINER_TYPE_CLASS
           && player->getClass() == GetCreatureTemplate()->trainer_class;
}

bool Creature::IsValidTrainerForPlayer(Player* player, uint32* npcFlags /*= nullptr*/) const
{
    if (!IsTrainer())
    {
        return false;
    }

    switch (m_creatureInfo->trainer_type)
    {
        case TRAINER_TYPE_CLASS:
        case TRAINER_TYPE_PETS:
            if (m_creatureInfo->trainer_class && m_creatureInfo->trainer_class != player->getClass())
            {
                if (npcFlags)
                    *npcFlags &= ~UNIT_NPC_FLAG_TRAINER_CLASS;

                return false;
            }
            break;
        case TRAINER_TYPE_MOUNTS:
            if (m_creatureInfo->trainer_race && m_creatureInfo->trainer_race != player->getRace())
            {
                return false;
            }
            break;
        case TRAINER_TYPE_TRADESKILLS:
            if (m_creatureInfo->trainer_spell && !player->HasSpell(m_creatureInfo->trainer_spell))
            {
                if (npcFlags)
                    *npcFlags &= ~UNIT_NPC_FLAG_TRAINER_PROFESSION;

                return false;
            }
            break;
        default:
            break;
    }

    return true;
}

Player* Creature::GetLootRecipient() const
{
    if (!m_lootRecipient)
        return nullptr;
    return ObjectAccessor::FindConnectedPlayer(m_lootRecipient);
}

Group* Creature::GetLootRecipientGroup() const
{
    if (!m_lootRecipientGroup)
        return nullptr;
    return sGroupMgr->GetGroupByGUID(m_lootRecipientGroup);
}

void Creature::SetLootRecipient(Unit* unit, bool withGroup)
{
    // set the player whose group should receive the right
    // to loot the creature after it dies
    // should be set to nullptr after the loot disappears

    if (!unit)
    {
        m_lootRecipient.Clear();
        m_lootRecipientGroup = 0;
        RemoveDynamicFlag(UNIT_DYNFLAG_LOOTABLE | UNIT_DYNFLAG_TAPPED);
        ResetAllowedLooters();
        return;
    }

    /*
    Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself();
    */
    //npcbot - loot recipient of bot's vehicle is owner
    Player* player = nullptr;
    if (unit->IsVehicle() && unit->GetCharmerGUID().IsCreature() && unit->GetCreator() && unit->GetCreator()->IsPlayer())
        player = unit->GetCreator()->ToPlayer();
    else
        player = unit->GetCharmerOrOwnerPlayerOrPlayerItself();
    //end npcbot
    if (!player)                                             // normal creature, no player involved
        return;

    m_lootRecipient = player->GetGUID();

    Map* map = GetMap();
    if (map && map->IsDungeon() && (isWorldBoss() || IsDungeonBoss()))
    {
        AddAllowedLooter(m_lootRecipient);
    }

    if (withGroup)
    {
        if (Group* group = player->GetGroup())
        {
            m_lootRecipientGroup = group->GetGUID().GetCounter();

            if (map && map->IsDungeon() && (isWorldBoss() || IsDungeonBoss()))
            {
                Map::PlayerList const& PlayerList = map->GetPlayers();
                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                {
                    if (Player* groupMember = i->GetSource())
                    {
                        if (groupMember->IsGameMaster() || groupMember->IsSpectator())
                        {
                            continue;
                        }

                        if (groupMember->GetGroup() == group)
                        {
                            AddAllowedLooter(groupMember->GetGUID());
                        }
                    }
                }
            }
        }
    }
    else
        m_lootRecipientGroup = 0;

    SetDynamicFlag(UNIT_DYNFLAG_TAPPED);
}

// return true if this creature is tapped by the player or by a member of his group.
bool Creature::isTappedBy(Player const* player) const
{
    if (player->GetGUID() == m_lootRecipient)
        return true;

    Group const* playerGroup = player->GetGroup();
    if (!playerGroup || playerGroup != GetLootRecipientGroup()) // if we dont have a group we arent the recipient
        return false;                                           // if creature doesnt have group bound it means it was solo killed by someone else

    return true;
}

void Creature::SaveToDB()
{
    //npcbot: disallow saving generated bots
    if (IsNPCBot() && GetBotAI() && GetBotAI()->IsWanderer())
        return;
    //end npcbot

    // this should only be used when the creature has already been loaded
    // preferably after adding to map, because mapid may not be valid otherwise
    CreatureData const* data = sObjectMgr->GetCreatureData(m_spawnId);
    if (!data)
    {
        LOG_ERROR("entities.unit", "Creature::SaveToDB failed, cannot get creature data!");
        return;
    }

    uint32 mapId = GetTransport() && GetTransport()->ToMotionTransport() ? GetTransport()->GetGOInfo()->moTransport.mapID : GetMapId();
    SaveToDB(mapId, data->spawnMask, GetPhaseMask());
}

void Creature::SaveToDB(uint32 mapid, uint8 spawnMask, uint32 phaseMask)
{
    //npcbot: disallow saving generated bots
    if (IsNPCBot() && GetBotAI() && GetBotAI()->IsWanderer())
        return;
    //end npcbot

    // update in loaded data
    if (!m_spawnId)
        m_spawnId = sObjectMgr->GenerateCreatureSpawnId();

    CreatureData& data = sObjectMgr->NewOrExistCreatureData(m_spawnId);

    uint32 displayId = GetNativeDisplayId();
    uint32 npcflag = GetNpcFlags();
    uint32 unit_flags = GetUnitFlags();
    uint32 dynamicflags = GetDynamicFlags();

    // check if it's a custom model and if not, use 0 for displayId
    CreatureTemplate const* cinfo = GetCreatureTemplate();
    if (cinfo)
    {
        if (displayId == cinfo->Modelid1 || displayId == cinfo->Modelid2 ||
                displayId == cinfo->Modelid3 || displayId == cinfo->Modelid4)
            displayId = 0;

        if (npcflag == cinfo->npcflag)
            npcflag = 0;

        if (unit_flags == cinfo->unit_flags)
            unit_flags = 0;

        if (dynamicflags == cinfo->dynamicflags)
            dynamicflags = 0;
    }

    data.id1 = GetEntry();
    data.mapid = mapid;
    data.phaseMask = phaseMask;
    data.displayid = displayId;
    data.equipmentId = GetCurrentEquipmentId();
    if (!GetTransport())
    {
        data.posX = GetPositionX();
        data.posY = GetPositionY();
        data.posZ = GetPositionZ();
        data.orientation = GetOrientation();
    }
    else
    {
        data.posX = GetTransOffsetX();
        data.posY = GetTransOffsetY();
        data.posZ = GetTransOffsetZ();
        data.orientation = GetTransOffsetO();
    }

    data.spawntimesecs = m_respawnDelay;
    // prevent add data integrity problems
    data.wander_distance = GetDefaultMovementType() == IDLE_MOTION_TYPE ? 0.0f : m_wanderDistance;
    data.currentwaypoint = 0;
    data.curhealth = GetHealth();
    data.curmana = GetPower(POWER_MANA);
    // prevent add data integrity problems
    data.movementType = !m_wanderDistance && GetDefaultMovementType() == RANDOM_MOTION_TYPE
                        ? IDLE_MOTION_TYPE : GetDefaultMovementType();
    data.spawnMask = spawnMask;
    data.npcflag = npcflag;
    data.unit_flags = unit_flags;
    data.dynamicflags = dynamicflags;

    // update in DB
    WorldDatabaseTransaction trans = WorldDatabase.BeginTransaction();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_CREATURE);
    stmt->SetData(0, m_spawnId);
    trans->Append(stmt);

    uint8 index = 0;

    stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_CREATURE);
    stmt->SetData(index++, m_spawnId);
    stmt->SetData(index++, GetEntry());
    stmt->SetData(index++, 0);
    stmt->SetData(index++, 0);
    stmt->SetData(index++, uint16(mapid));
    stmt->SetData(index++, spawnMask);
    stmt->SetData(index++, GetPhaseMask());
    stmt->SetData(index++, int32(GetCurrentEquipmentId()));
    stmt->SetData(index++, GetPositionX());
    stmt->SetData(index++, GetPositionY());
    stmt->SetData(index++, GetPositionZ());
    stmt->SetData(index++, GetOrientation());
    stmt->SetData(index++, m_respawnDelay);
    stmt->SetData(index++, m_wanderDistance);
    stmt->SetData(index++, 0);
    stmt->SetData(index++, GetHealth());
    stmt->SetData(index++, GetPower(POWER_MANA));
    stmt->SetData(index++, uint8(GetDefaultMovementType()));
    stmt->SetData(index++, npcflag);
    stmt->SetData(index++, unit_flags);
    stmt->SetData(index++, dynamicflags);
    trans->Append(stmt);

    WorldDatabase.CommitTransaction(trans);
    sScriptMgr->OnCreatureSaveToDB(this);
}

void Creature::SelectLevel(bool changelevel)
{
    CreatureTemplate const* cInfo = GetCreatureTemplate();

    uint32 rank = IsPet() ? 0 : cInfo->rank;

    // level
    uint8 minlevel = std::min(cInfo->maxlevel, cInfo->minlevel);
    uint8 maxlevel = std::max(cInfo->maxlevel, cInfo->minlevel);
    uint8 level = minlevel == maxlevel ? minlevel : urand(minlevel, maxlevel);

    sScriptMgr->OnBeforeCreatureSelectLevel(cInfo, this, level);

    if (changelevel)
        SetLevel(level);

    CreatureBaseStats const* stats = sObjectMgr->GetCreatureBaseStats(level, cInfo->unit_class);

    // health
    float healthmod = _GetHealthMod(rank);

    uint32 basehp = std::max<uint32>(1, stats->GenerateHealth(cInfo));
    uint32 health = uint32(basehp * healthmod);

    SetCreateHealth(health);
    SetMaxHealth(health);
    SetHealth(health);
    ResetPlayerDamageReq();

    // mana
    uint32 mana = stats->GenerateMana(cInfo);

    SetCreateMana(mana);
    SetMaxPower(POWER_MANA, mana);                          //MAX Mana
    SetPower(POWER_MANA, mana);

    /// @todo: set UNIT_FIELD_POWER*, for some creature class case (energy, etc)

    SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, (float)health);
    SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, (float)mana);

    // damage

    float basedamage = stats->GenerateBaseDamage(cInfo);

    float weaponBaseMinDamage = basedamage;
    float weaponBaseMaxDamage = basedamage * 1.5;

    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, weaponBaseMinDamage);
    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, weaponBaseMaxDamage);

    SetBaseWeaponDamage(OFF_ATTACK, MINDAMAGE, weaponBaseMinDamage);
    SetBaseWeaponDamage(OFF_ATTACK, MAXDAMAGE, weaponBaseMaxDamage);

    SetBaseWeaponDamage(RANGED_ATTACK, MINDAMAGE, weaponBaseMinDamage);
    SetBaseWeaponDamage(RANGED_ATTACK, MAXDAMAGE, weaponBaseMaxDamage);

    SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, stats->AttackPower);
    SetModifierValue(UNIT_MOD_ATTACK_POWER_RANGED, BASE_VALUE, stats->RangedAttackPower);

    sScriptMgr->Creature_SelectLevel(cInfo, this);
}

float Creature::_GetHealthMod(int32 Rank)
{
    switch (Rank)                                           // define rates for each elite rank
    {
        case CREATURE_ELITE_NORMAL:
            return sWorld->getRate(RATE_CREATURE_NORMAL_HP);
        case CREATURE_ELITE_ELITE:
            return sWorld->getRate(RATE_CREATURE_ELITE_ELITE_HP);
        case CREATURE_ELITE_RAREELITE:
            return sWorld->getRate(RATE_CREATURE_ELITE_RAREELITE_HP);
        case CREATURE_ELITE_WORLDBOSS:
            return sWorld->getRate(RATE_CREATURE_ELITE_WORLDBOSS_HP);
        case CREATURE_ELITE_RARE:
            return sWorld->getRate(RATE_CREATURE_ELITE_RARE_HP);
        default:
            return sWorld->getRate(RATE_CREATURE_ELITE_ELITE_HP);
    }
}

float Creature::_GetDamageMod(int32 Rank)
{
    switch (Rank)                                           // define rates for each elite rank
    {
        case CREATURE_ELITE_NORMAL:
            return sWorld->getRate(RATE_CREATURE_NORMAL_DAMAGE);
        case CREATURE_ELITE_ELITE:
            return sWorld->getRate(RATE_CREATURE_ELITE_ELITE_DAMAGE);
        case CREATURE_ELITE_RAREELITE:
            return sWorld->getRate(RATE_CREATURE_ELITE_RAREELITE_DAMAGE);
        case CREATURE_ELITE_WORLDBOSS:
            return sWorld->getRate(RATE_CREATURE_ELITE_WORLDBOSS_DAMAGE);
        case CREATURE_ELITE_RARE:
            return sWorld->getRate(RATE_CREATURE_ELITE_RARE_DAMAGE);
        default:
            return sWorld->getRate(RATE_CREATURE_ELITE_ELITE_DAMAGE);
    }
}

float Creature::GetSpellDamageMod(int32 Rank)
{
    switch (Rank)                                           // define rates for each elite rank
    {
        case CREATURE_ELITE_NORMAL:
            return sWorld->getRate(RATE_CREATURE_NORMAL_SPELLDAMAGE);
        case CREATURE_ELITE_ELITE:
            return sWorld->getRate(RATE_CREATURE_ELITE_ELITE_SPELLDAMAGE);
        case CREATURE_ELITE_RAREELITE:
            return sWorld->getRate(RATE_CREATURE_ELITE_RAREELITE_SPELLDAMAGE);
        case CREATURE_ELITE_WORLDBOSS:
            return sWorld->getRate(RATE_CREATURE_ELITE_WORLDBOSS_SPELLDAMAGE);
        case CREATURE_ELITE_RARE:
            return sWorld->getRate(RATE_CREATURE_ELITE_RARE_SPELLDAMAGE);
        default:
            return sWorld->getRate(RATE_CREATURE_ELITE_ELITE_SPELLDAMAGE);
    }
}

bool Creature::CreateFromProto(ObjectGuid::LowType guidlow, uint32 Entry, uint32 vehId, const CreatureData* data)
{
    SetZoneScript();
    if (GetZoneScript() && data)
    {
        uint32 FirstEntry = GetZoneScript()->GetCreatureEntry(guidlow, data);
        if (!FirstEntry)
            return false;
    }

    CreatureTemplate const* normalInfo = sObjectMgr->GetCreatureTemplate(Entry);
    if (!normalInfo)
    {
        LOG_ERROR("sql.sql", "Creature::CreateFromProto(): creature template (guidlow: {}, entry: {}) does not exist.", guidlow, Entry);
        return false;
    }

    SetOriginalEntry(Entry);

    Object::_Create(guidlow, Entry, (vehId || normalInfo->VehicleId) ? HighGuid::Vehicle : HighGuid::Unit);

    // Xinef: select proper vehicle id
    if (!vehId)
    {
        CreatureTemplate const* cinfo = normalInfo;
        for (uint8 diff = uint8(GetMap()->GetSpawnMode()); diff > 0 && !IsPet();)
        {
            // we already have valid Map pointer for current creature!
            if (cinfo->DifficultyEntry[diff - 1])
            {
                cinfo = sObjectMgr->GetCreatureTemplate(normalInfo->DifficultyEntry[diff - 1]);
                if (cinfo && cinfo->VehicleId)
                    break;                                      // template found

                // check and reported at startup, so just ignore (restore normalInfo)
                cinfo = normalInfo;
            }

            // for instances heroic to normal, other cases attempt to retrieve previous difficulty
            if (diff >= RAID_DIFFICULTY_10MAN_HEROIC && GetMap()->IsRaid())
                diff -= 2;                                      // to normal raid difficulty cases
            else
                --diff;
        }

        if (cinfo->VehicleId)
            CreateVehicleKit(cinfo->VehicleId, (cinfo->VehicleId != normalInfo->VehicleId ? cinfo->Entry : normalInfo->Entry));
    }
    else
        CreateVehicleKit(vehId, Entry);

    if (!UpdateEntry(Entry, data))
        return false;

    return true;
}

bool Creature::isVendorWithIconSpeak() const
{
    return m_creatureInfo->IconName == "Speak" && m_creatureData->npcflag & UNIT_NPC_FLAG_VENDOR;
}

bool Creature::LoadCreatureFromDB(ObjectGuid::LowType spawnId, Map* map, bool addToMap, bool gridLoad, bool allowDuplicate /*= false*/)
{
    if (!allowDuplicate)
    {
        // If an alive instance of this spawnId is already found, skip creation
        // If only dead instance(s) exist, despawn them and spawn a new (maybe also dead) version
        const auto creatureBounds = map->GetCreatureBySpawnIdStore().equal_range(spawnId);
        std::vector <Creature*> despawnList;

        if (creatureBounds.first != creatureBounds.second)
        {
            for (auto itr = creatureBounds.first; itr != creatureBounds.second; ++itr)
            {
                if (itr->second->IsAlive())
                {
                    LOG_DEBUG("maps", "Would have spawned {} but {} already exists", spawnId, creatureBounds.first->second->GetGUID().ToString());
                    return false;
                }
                else
                {
                    despawnList.push_back(itr->second);
                    LOG_DEBUG("maps", "Despawned dead instance of spawn {} ({})", spawnId, itr->second->GetGUID().ToString());
                }
            }

            for (Creature* despawnCreature : despawnList)
            {
                despawnCreature->AddObjectToRemoveList();
            }
        }
    }

    CreatureData const* data = sObjectMgr->GetCreatureData(spawnId);
    if (!data)
    {
        LOG_ERROR("sql.sql", "Creature (SpawnId: {}) not found in table `creature`, can't load. ", spawnId);
        return false;
    }

    // xinef: fix from db
    if ((addToMap || gridLoad) && !data->overwrittenZ)
    {
        float tz = map->GetHeight(data->posX, data->posY, data->posZ + 0.42f, true);
        if (tz >= data->posZ && tz - data->posZ <= 0.42f)
            const_cast<CreatureData*>(data)->posZ = tz + 0.1f;

        const_cast<CreatureData*>(data)->overwrittenZ = true;
    }

    // xinef: this has to be assigned before Create function, properly loads equipment id from DB
    m_creatureData = data;
    m_spawnId = spawnId;

    // Add to world
    uint32 entry = GetRandomId(data->id1, data->id2, data->id3);

    if (!Create(map->GenerateLowGuid<HighGuid::Unit>(), map, data->phaseMask, entry, 0, data->posX, data->posY, data->posZ, data->orientation, data))
        return false;

    //We should set first home position, because then AI calls home movement
    SetHomePosition(data->posX, data->posY, data->posZ, data->orientation);

    m_wanderDistance = data->wander_distance;

    m_respawnDelay = data->spawntimesecs;
    m_deathState = DeathState::Alive;

    //npcbot: remove respawn time if any
    if (IsNPCBotOrPet())
        map->RemoveCreatureRespawnTime(spawnId);
    //end npcbot

    m_respawnTime  = GetMap()->GetCreatureRespawnTime(m_spawnId);
    if (m_respawnTime)                          // respawn on Update
    {
        m_deathState = DeathState::Dead;
        if (CanFly())
        {
            float tz = map->GetHeight(GetPhaseMask(), data->posX, data->posY, data->posZ, true, MAX_FALL_DISTANCE);
            if (data->posZ - tz > 0.1f && Acore::IsValidMapCoord(tz))
            {
                Relocate(data->posX, data->posY, tz);
            }
        }
    }

    uint32 curhealth;

    if (!m_regenHealth)
    {
        curhealth = data->curhealth;
        if (curhealth)
        {
            curhealth = uint32(curhealth * _GetHealthMod(GetCreatureTemplate()->rank));
            if (curhealth < 1)
                curhealth = 1;
        }
        SetPower(POWER_MANA, data->curmana);
    }
    else
    {
        curhealth = GetMaxHealth();
        SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
    }

    SetHealth(m_deathState == DeathState::Alive ? curhealth : 0);

    // checked at creature_template loading
    m_defaultMovementType = MovementGeneratorType(data->movementType);

    //npcbot
    if (IsNPCBot())
    {
        //prevent loading npcbot twice (grid unload/load case)
        if (sWorld->GetMaxPlayerCount() > 0)
            return false;

        LOG_INFO("entities.unit", "Creature: loading npcbot {} (id: {})", GetName(), GetEntry());
        ASSERT(!IsInWorld());

        //don't allow removing dead bot's corpse
        m_corpseDelay = 0;
        m_respawnDelay = 0;
        setActive(true);
    }
    //end npcbot

    if (addToMap && !GetMap()->AddToMap(this))
        return false;
    return true;
}

void Creature::SetCanDualWield(bool value)
{
    Unit::SetCanDualWield(value);
    UpdateDamagePhysical(OFF_ATTACK);
}

void Creature::LoadEquipment(int8 id, bool force /*= false*/)
{
    //npcbot: prevent loading equipment for bots
    if (IsNPCBot())
        return;
    //end npcbot

    if (id == 0)
    {
        if (force)
        {
            for (uint8 i = 0; i < MAX_EQUIPMENT_ITEMS; ++i)
                SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + i, 0);
            m_equipmentId = 0;
        }
        return;
    }

    EquipmentInfo const* einfo = sObjectMgr->GetEquipmentInfo(GetEntry(), id);
    if (!einfo)
        return;

    m_equipmentId = id;
    for (uint8 i = 0; i < 3; ++i)
        SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + i, einfo->ItemEntry[i]);
}

bool Creature::hasQuest(uint32 quest_id) const
{
    QuestRelationBounds qr = sObjectMgr->GetCreatureQuestRelationBounds(GetEntry());
    for (QuestRelations::const_iterator itr = qr.first; itr != qr.second; ++itr)
    {
        if (itr->second == quest_id)
            return true;
    }
    return false;
}

bool Creature::hasInvolvedQuest(uint32 quest_id) const
{
    QuestRelationBounds qir = sObjectMgr->GetCreatureQuestInvolvedRelationBounds(GetEntry());
    for (QuestRelations::const_iterator itr = qir.first; itr != qir.second; ++itr)
    {
        if (itr->second == quest_id)
            return true;
    }
    return false;
}

void Creature::DeleteFromDB()
{
    if (!m_spawnId)
    {
        LOG_ERROR("entities.unit", "Trying to delete not saved creature: {}", GetGUID().ToString());
        return;
    }

    GetMap()->RemoveCreatureRespawnTime(m_spawnId);
    sObjectMgr->DeleteCreatureData(m_spawnId);

    WorldDatabaseTransaction trans = WorldDatabase.BeginTransaction();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_CREATURE);
    stmt->SetData(0, m_spawnId);
    trans->Append(stmt);

    stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_CREATURE_ADDON);
    stmt->SetData(0, m_spawnId);
    trans->Append(stmt);

    stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_GAME_EVENT_CREATURE);
    stmt->SetData(0, m_spawnId);
    trans->Append(stmt);

    stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_GAME_EVENT_MODEL_EQUIP);
    stmt->SetData(0, m_spawnId);
    trans->Append(stmt);

    WorldDatabase.CommitTransaction(trans);
}

bool Creature::IsInvisibleDueToDespawn() const
{
    if (Unit::IsInvisibleDueToDespawn())
        return true;

    if (IsAlive() || m_corpseRemoveTime > GameTime::GetGameTime().count())
        return false;

    //npcbot
    if (bot_AI || bot_pet_AI)
        return false;
    //end npcbot

    return true;
}

bool Creature::CanAlwaysSee(WorldObject const* obj) const
{
    if (IsAIEnabled && AI()->CanSeeAlways(obj))
        return true;

    return false;
}

bool Creature::IsAlwaysDetectableFor(WorldObject const* seer) const
{
    if (Unit::IsAlwaysDetectableFor(seer))
    {
        return true;
    }

    if (IsAIEnabled && AI()->CanAlwaysBeDetectable(seer))
    {
        return true;
    }

    return false;
}

bool Creature::CanStartAttack(Unit const* who) const
{
    if (IsCivilian())
        return false;

    // This set of checks is should be done only for creatures
    if ((IsImmuneToNPC() && who->GetTypeId() != TYPEID_PLAYER) ||      // flag is valid only for non player characters
        (IsImmuneToPC() && who->GetTypeId() == TYPEID_PLAYER))         // immune to PC and target is a player, return false
    {
        //npcbot: allow attacking PvP free bots
        /*
        return false;
        */
        Unit const* bot = (who->IsNPCBotOrPet() && who->ToCreature()->IsFreeBot()) ? who->IsNPCBotPet() ? who->GetCreator() : who : nullptr;
        if (!(bot && bot->ToCreature()->GetBotAI()->IsContestedPvP() && IsContestedGuard()))
            return false;
        //end npcbot
    }

    if (Unit* owner = who->GetOwner())
        if (owner->GetTypeId() == TYPEID_PLAYER && IsImmuneToPC())     // immune to PC and target has player owner
            return false;

    // Do not attack non-combat pets
    if (who->GetTypeId() == TYPEID_UNIT && who->GetCreatureType() == CREATURE_TYPE_NON_COMBAT_PET)
        return false;

    if (!CanFly() && (GetDistanceZ(who) > CREATURE_Z_ATTACK_RANGE + m_CombatDistance))                    // too much Z difference, skip very costy vmap calculations here
        return false;

    if (!_IsTargetAcceptable(who))
        return false;

    // pussywizard: at this point we are either hostile to who or friendly to who->getAttackerForHelper()
    // pussywizard: if who is in combat and has an attacker, help him if the distance is right (help because who is hostile or help because attacker is friendly)
    bool assist = false;
    if (who->IsEngaged() && IsWithinDist(who, ATTACK_DISTANCE))
        if (Unit* victim = who->getAttackerForHelper())
            if (IsWithinDistInMap(victim, sWorld->getFloatConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_RADIUS)))
                assist = true;

    if (!assist)
        if (IsNeutralToAll() || !IsWithinDistInMap(who, GetAggroRange(who) + m_CombatDistance, true, false)) // pussywizard: +m_combatDistance for turrets and similar
            return false;

    if (!CanCreatureAttack(who))
        return false;

    if (HasUnitState(UNIT_STATE_STUNNED))
        return false;

    return IsWithinLOSInMap(who);
}

void Creature::setDeathState(DeathState s, bool despawn)
{
    Unit::setDeathState(s, despawn);

    if (s == DeathState::JustDied)
    {
        _lastDamagedTime.reset();

        m_corpseRemoveTime = GameTime::GetGameTime().count() + m_corpseDelay;
        m_respawnTime = GameTime::GetGameTime().count() + m_respawnDelay + m_corpseDelay;

        // always save boss respawn time at death to prevent crash cheating
        if (GetMap()->IsDungeon() || isWorldBoss() || GetCreatureTemplate()->rank >= CREATURE_ELITE_ELITE)
            SaveRespawnTime();

        SetTarget();                // remove target selection in any cases (can be set at aura remove in Unit::setDeathState)
        ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);

        Dismount(); // if creature is mounted on a virtual mount, remove it at death

        setActive(false);

        if (HasSearchedAssistance())
        {
            SetNoSearchAssistance(false);
        }

        //Dismiss group if is leader
        if (m_formation && m_formation->GetLeader() == this)
            m_formation->FormationReset(true, false);

        bool needsFalling = !despawn && (IsFlying() || IsHovering()) && !IsUnderWater();
        SetHover(false, false, false);
        SetDisableGravity(false, false, false);

        if (needsFalling)
            GetMotionMaster()->MoveFall(0, true);

        Unit::setDeathState(DeathState::Corpse, despawn);
    }
    else if (s == DeathState::JustRespawned)
    {
        //if (IsPet())
        //    setActive(true);
        SetFullHealth();
        SetLootRecipient(nullptr);
        ResetPlayerDamageReq();
        SetCannotReachTarget();
        CreatureTemplate const* cinfo = GetCreatureTemplate();
        // Xinef: npc run by default
        //SetWalk(true);

        // pussywizard:
        if (HasUnitMovementFlag(MOVEMENTFLAG_FALLING))
            RemoveUnitMovementFlag(MOVEMENTFLAG_FALLING);

        UpdateMovementFlags();

        ReplaceAllNpcFlags(NPCFlags(cinfo->npcflag));
        ClearUnitState(uint32(UNIT_STATE_ALL_STATE & ~(UNIT_STATE_IGNORE_PATHFINDING | UNIT_STATE_NO_ENVIRONMENT_UPD)));
        SetMeleeDamageSchool(SpellSchools(cinfo->dmgschool));

        Unit::setDeathState(DeathState::Alive, despawn);

        Motion_Initialize();
        LoadCreaturesAddon(true);
        if (GetCreatureData() && GetPhaseMask() != GetCreatureData()->phaseMask)
            SetPhaseMask(GetCreatureData()->phaseMask, false);
    }
}

void Creature::Respawn(bool force)
{
    //npcbot
    if (IsNPCBotOrPet())
        return;
    //end npcbot

    if (force)
    {
        if (IsAlive())
        {
            setDeathState(DeathState::JustDied);
        }
        else if (getDeathState() != DeathState::Corpse)
        {
            setDeathState(DeathState::Corpse);
        }
    }

    ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_CREATURE_RESPAWN, GetEntry());

    if (!sConditionMgr->IsObjectMeetToConditions(this, conditions) && !force)
    {
        // Creature should not respawn, reset respawn timer. Conditions will be checked again the next time it tries to respawn.
        m_respawnTime = GameTime::GetGameTime().count() + m_respawnDelay;
        return;
    }

    bool allowed = !IsAIEnabled || AI()->CanRespawn(); // First check if there are any scripts that prevent us respawning
    if (!allowed && !force)                                               // Will be rechecked on next Update call
        return;

    ObjectGuid dbtableHighGuid = ObjectGuid::Create<HighGuid::Unit>(m_creatureData ? m_creatureData->id1 : GetEntry(), m_spawnId);
    time_t linkedRespawntime = GetMap()->GetLinkedRespawnTime(dbtableHighGuid);

    CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(GetEntry());

    if (!linkedRespawntime || (cInfo && cInfo->HasFlagsExtra(CREATURE_FLAG_EXTRA_HARD_RESET)) || force)          // Should respawn
    {
        RemoveCorpse(false, false);

        if (getDeathState() == DeathState::Dead)
        {
            if (m_spawnId)
            {
                GetMap()->RemoveCreatureRespawnTime(m_spawnId);
                CreatureData const* data = sObjectMgr->GetCreatureData(m_spawnId);
                // Respawn check if spawn has 2 entries
                if (data->id2)
                {
                    uint32 entry = GetRandomId(data->id1, data->id2, data->id3);
                    UpdateEntry(entry, data, true);  // Select Random Entry
                    m_defaultMovementType = MovementGeneratorType(data->movementType);                    // Reload Movement Type
                    LoadEquipment(data->equipmentId);                                                     // Reload Equipment
                    AIM_Initialize();                                                                     // Reload AI
                }
                else
                {
                    if (m_originalEntry != GetEntry())
                        UpdateEntry(m_originalEntry);
                }
            }

            LOG_DEBUG("entities.unit", "Respawning creature {} (SpawnId: {}, {})", GetName(), GetSpawnId(), GetGUID().ToString());
            m_respawnTime = 0;
            ResetPickPocketLootTime();
            loot.clear();
            SelectLevel();

            setDeathState(DeathState::JustRespawned);

            // MDic - Acidmanifesto
            // Do not override transform auras
            if (GetAuraEffectsByType(SPELL_AURA_TRANSFORM).empty())
            {
                uint32 displayID = GetNativeDisplayId();
                if (sObjectMgr->GetCreatureModelRandomGender(&displayID))                                             // Cancel load if no model defined
                {
                    SetDisplayId(displayID);
                    SetNativeDisplayId(displayID);
                }
            }

            GetMotionMaster()->InitDefault();

            //Call AI respawn virtual function
            if (IsAIEnabled)
            {
                //reset the AI to be sure no dirty or uninitialized values will be used till next tick
                AI()->Reset();
                TriggerJustRespawned = true;//delay event to next tick so all creatures are created on the map before processing
            }

            uint32 poolid = m_spawnId ? sPoolMgr->IsPartOfAPool<Creature>(m_spawnId) : 0;
            if (poolid)
                sPoolMgr->UpdatePool<Creature>(poolid, m_spawnId);

            //Re-initialize reactstate that could be altered by movementgenerators
            InitializeReactState();

            m_respawnedTime = GameTime::GetGameTime().count();
        }
        m_respawnedTime = GameTime::GetGameTime().count();
        // xinef: relocate notifier, fixes npc appearing in corpse position after forced respawn (instead of spawn)
        m_last_notify_position.Relocate(-5000.0f, -5000.0f, -5000.0f, 0.0f);
        UpdateObjectVisibility(false);

    }
    else                                // the master is dead
    {
        ObjectGuid targetGuid = sObjectMgr->GetLinkedRespawnGuid(dbtableHighGuid);
        if (targetGuid == dbtableHighGuid) // if linking self, never respawn (check delayed to next day)
        {
            SetRespawnTime(DAY);
        }
        else
        {
            time_t now = GameTime::GetGameTime().count();
            m_respawnTime = (now > linkedRespawntime ? now : linkedRespawntime) + urand(5, MINUTE); // else copy time from master and add a little
        }
        SaveRespawnTime(); // also save to DB immediately
    }
}

void Creature::ForcedDespawn(uint32 timeMSToDespawn, Seconds forceRespawnTimer)
{
    //npcbot
    if (IsNPCBotOrPet())
        return;
    //end npcbot

    if (timeMSToDespawn)
    {
        ForcedDespawnDelayEvent* pEvent = new ForcedDespawnDelayEvent(*this, forceRespawnTimer);
        m_Events.AddEvent(pEvent, m_Events.CalculateTime(timeMSToDespawn));
        return;
    }

    if (IsAlive())
        setDeathState(DeathState::JustDied, true);

    // Xinef: set new respawn time, ignore corpse decay time...
    RemoveCorpse(true);

    if (forceRespawnTimer > Seconds::zero())
    {
        if (GetMap())
        {
            GetMap()->ScheduleCreatureRespawn(GetGUID(), forceRespawnTimer);
        }
    }
}

void Creature::DespawnOrUnsummon(Milliseconds msTimeToDespawn /*= 0*/, Seconds forcedRespawnTimer)
{
    if (TempSummon* summon = this->ToTempSummon())
        summon->UnSummon(msTimeToDespawn.count());
    else
        ForcedDespawn(msTimeToDespawn.count(), forcedRespawnTimer);
}

void Creature::DespawnOnEvade(Seconds respawnDelay)
{
    AI()->SummonedCreatureDespawnAll();

    if (respawnDelay < 2s)
    {
        LOG_WARN("entities.unit", "DespawnOnEvade called with delay of {} seconds, defaulting to 2.", respawnDelay.count());
        respawnDelay = 2s;
    }

    if (TempSummon* whoSummon = ToTempSummon())
    {
        LOG_WARN("entities.unit", "DespawnOnEvade called on a temporary summon.");
        whoSummon->UnSummon();
        return;
    }

    DespawnOrUnsummon(Milliseconds(0), respawnDelay);
}

void Creature::InitializeReactState()
{
    if ((IsTotem() || IsTrigger() || IsCritter() || IsSpiritService()) && GetAIName() != "SmartAI" && !GetScriptId())
        SetReactState(REACT_PASSIVE);
    else
        SetReactState(REACT_AGGRESSIVE);
    /*else if (IsCivilian())
    SetReactState(REACT_DEFENSIVE);*/
}

bool Creature::HasMechanicTemplateImmunity(uint32 mask) const
{
    return !GetOwnerGUID().IsPlayer() && (GetCreatureTemplate()->MechanicImmuneMask & mask);
}

void Creature::LoadSpellTemplateImmunity()
{
    // uint32 max used for "spell id", the immunity system will not perform SpellInfo checks against invalid spells
    // used so we know which immunities were loaded from template
    static uint32 const placeholderSpellId = std::numeric_limits<uint32>::max();

    // unapply template immunities (in case we're updating entry)
    for (uint8 i = SPELL_SCHOOL_NORMAL; i <= SPELL_SCHOOL_ARCANE; ++i)
    {
        ApplySpellImmune(placeholderSpellId, IMMUNITY_SCHOOL, i, false);
    }

    // don't inherit immunities for hunter pets
    if (GetOwnerGUID().IsPlayer() && IsHunterPet())
    {
        return;
    }

    if (uint8 mask = GetCreatureTemplate()->SpellSchoolImmuneMask)
    {
        for (uint8 i = SPELL_SCHOOL_NORMAL; i <= SPELL_SCHOOL_ARCANE; ++i)
        {
            if (mask & (1 << i))
            {
                ApplySpellImmune(placeholderSpellId, IMMUNITY_SCHOOL, 1 << i, true);
            }
        }
    }
}

bool Creature::IsImmunedToSpell(SpellInfo const* spellInfo, Spell const* spell)
//npcbot
const
//end npcbot
{
    if (!spellInfo)
        return false;

    if (spellInfo->HasAttribute(SPELL_ATTR0_CU_BYPASS_MECHANIC_IMMUNITY))
    {
        return false;
    }

    // Xinef: this should exclude self casts...
    // Spells that don't have effectMechanics.
    if (spellInfo->Mechanic > MECHANIC_NONE && HasMechanicTemplateImmunity(1 << (spellInfo->Mechanic - 1)))
        return true;

    // This check must be done instead of 'if (GetCreatureTemplate()->MechanicImmuneMask & (1 << (spellInfo->Mechanic - 1)))' for not break
    // the check of mechanic immunity on DB (tested) because GetCreatureTemplate()->MechanicImmuneMask and m_spellImmune[IMMUNITY_MECHANIC] don't have same data.
    bool immunedToAllEffects = true;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (spellInfo->Effects[i].IsEffect() && !IsImmunedToSpellEffect(spellInfo, i))
        {
            immunedToAllEffects = false;
            break;
        }
    if (immunedToAllEffects)
        return true;

    return Unit::IsImmunedToSpell(spellInfo, spell);
}

bool Creature::IsImmunedToSpellEffect(SpellInfo const* spellInfo, uint32 index) const
{
    // Xinef: this should exclude self casts...
    if (spellInfo->Effects[index].Mechanic > MECHANIC_NONE && HasMechanicTemplateImmunity(1 << (spellInfo->Effects[index].Mechanic - 1)))
        return true;

    if (GetCreatureTemplate()->type == CREATURE_TYPE_MECHANICAL && spellInfo->Effects[index].Effect == SPELL_EFFECT_HEAL)
        return true;

    return Unit::IsImmunedToSpellEffect(spellInfo, index);
}

SpellInfo const* Creature::reachWithSpellAttack(Unit* victim)
{
    if (!victim)
        return nullptr;

    for (uint32 i = 0; i < MAX_CREATURE_SPELLS; ++i)
    {
        if (!m_spells[i])
            continue;
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(m_spells[i]);
        if (!spellInfo)
        {
            LOG_ERROR("entities.unit", "WORLD: unknown spell id {}", m_spells[i]);
            continue;
        }

        bool bcontinue = true;
        for (uint32 j = 0; j < MAX_SPELL_EFFECTS; j++)
        {
            if ((spellInfo->Effects[j].Effect == SPELL_EFFECT_SCHOOL_DAMAGE)       ||
                    (spellInfo->Effects[j].Effect == SPELL_EFFECT_INSTAKILL)            ||
                    (spellInfo->Effects[j].Effect == SPELL_EFFECT_ENVIRONMENTAL_DAMAGE) ||
                    (spellInfo->Effects[j].Effect == SPELL_EFFECT_HEALTH_LEECH)
               )
            {
                bcontinue = false;
                break;
            }
        }
        if (bcontinue)
            continue;

        if (spellInfo->ManaCost > GetPower(POWER_MANA))
            continue;
        float range = spellInfo->GetMaxRange(false);
        float minrange = spellInfo->GetMinRange(false);
        float dist = GetDistance(victim);
        if (dist > range || dist < minrange)
            continue;
        if (spellInfo->PreventionType == SPELL_PREVENTION_TYPE_SILENCE && HasUnitFlag(UNIT_FLAG_SILENCED))
            continue;
        if (spellInfo->PreventionType == SPELL_PREVENTION_TYPE_PACIFY && HasUnitFlag(UNIT_FLAG_PACIFIED))
            continue;
        return spellInfo;
    }
    return nullptr;
}

SpellInfo const* Creature::reachWithSpellCure(Unit* victim)
{
    if (!victim)
        return nullptr;

    for (uint32 i = 0; i < MAX_CREATURE_SPELLS; ++i)
    {
        if (!m_spells[i])
            continue;
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(m_spells[i]);
        if (!spellInfo)
        {
            LOG_ERROR("entities.unit", "WORLD: unknown spell id {}", m_spells[i]);
            continue;
        }

        bool bcontinue = true;
        for (uint32 j = 0; j < MAX_SPELL_EFFECTS; j++)
        {
            if ((spellInfo->Effects[j].Effect == SPELL_EFFECT_HEAL))
            {
                bcontinue = false;
                break;
            }
        }
        if (bcontinue)
            continue;

        if (spellInfo->ManaCost > GetPower(POWER_MANA))
            continue;

        float range = spellInfo->GetMaxRange(true);
        float minrange = spellInfo->GetMinRange(true);
        float dist = GetDistance(victim);
        //if (!isInFront(victim, range) && spellInfo->AttributesEx)
        //    continue;
        if (dist > range || dist < minrange)
            continue;
        if (spellInfo->PreventionType == SPELL_PREVENTION_TYPE_SILENCE && HasUnitFlag(UNIT_FLAG_SILENCED))
            continue;
        if (spellInfo->PreventionType == SPELL_PREVENTION_TYPE_PACIFY && HasUnitFlag(UNIT_FLAG_PACIFIED))
            continue;
        return spellInfo;
    }
    return nullptr;
}

// select nearest hostile unit within the given distance (regardless of threat list).
Unit* Creature::SelectNearestTarget(float dist, bool playerOnly /* = false */) const
{
    if (dist == 0.0f)
    {
        dist = MAX_VISIBILITY_DISTANCE;
    }

    Unit* target = nullptr;

    Acore::NearestHostileUnitCheck u_check(this, dist, playerOnly);
    Acore::UnitLastSearcher<Acore::NearestHostileUnitCheck> searcher(this, target, u_check);
    Cell::VisitAllObjects(this, searcher, dist);
    return target;
}

// select nearest hostile unit within the given attack distance (i.e. distance is ignored if > than ATTACK_DISTANCE), regardless of threat list.
Unit* Creature::SelectNearestTargetInAttackDistance(float dist) const
{
    if (dist < ATTACK_DISTANCE)
        dist = ATTACK_DISTANCE;
    if (dist > MAX_SEARCHER_DISTANCE)
        dist = MAX_SEARCHER_DISTANCE;

    Unit* target = nullptr;
    Acore::NearestHostileUnitInAttackDistanceCheck u_check(this, dist);
    Acore::UnitLastSearcher<Acore::NearestHostileUnitInAttackDistanceCheck> searcher(this, target, u_check);
    Cell::VisitAllObjects(this, searcher, std::max(dist, ATTACK_DISTANCE));

    return target;
}

void Creature::SendAIReaction(AiReaction reactionType)
{
    WorldPacket data(SMSG_AI_REACTION, 12);

    data << GetGUID();
    data << uint32(reactionType);

    ((WorldObject*)this)->SendMessageToSet(&data, true);

    LOG_DEBUG("network", "WORLD: Sent SMSG_AI_REACTION, type {}.", reactionType);
}

void Creature::CallAssistance(Unit* target /*= nullptr*/)
{
    if (!target)
    {
        target = GetVictim();
    }

    if (!m_AlreadyCallAssistance && target && !IsPet() && !IsCharmed())
    {
        SetNoCallAssistance(true);

        float radius = sWorld->getFloatConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_RADIUS);

        if (radius > 0)
        {
            std::list<Creature*> assistList;

            Acore::AnyAssistCreatureInRangeCheck u_check(this, target, radius);
            Acore::CreatureListSearcher<Acore::AnyAssistCreatureInRangeCheck> searcher(this, assistList, u_check);
            Cell::VisitGridObjects(this, searcher, radius);

            if (!assistList.empty())
            {
                AssistDelayEvent* e = new AssistDelayEvent(target->GetGUID(), this);
                while (!assistList.empty())
                {
                    // Pushing guids because in delay can happen some creature gets despawned => invalid pointer
                    e->AddAssistant((*assistList.begin())->GetGUID());
                    assistList.pop_front();
                }
                m_Events.AddEvent(e, m_Events.CalculateTime(sWorld->getIntConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_DELAY)));
            }
        }
    }
}

void Creature::CallForHelp(float radius, Unit* target /*= nullptr*/)
{
    if (radius <= 0.0f || IsPet() || IsCharmed())
    {
        return;
    }

    if (!target)
    {
        target = GetVictim();
    }

    if (!target)
    {
        return;
    }

    Acore::CallOfHelpCreatureInRangeDo u_do(this, target, radius);
    Acore::CreatureWorker<Acore::CallOfHelpCreatureInRangeDo> worker(this, u_do);
    Cell::VisitGridObjects(this, worker, radius);
}

bool Creature::CanAssistTo(Unit const* u, Unit const* enemy, bool checkfaction /*= true*/) const
{
    // is it true?
    if (!HasReactState(REACT_AGGRESSIVE))
        return false;

    // we don't need help from zombies :)
    if (!IsAlive())
        return false;

    // Xinef: we cannot assist in evade mode
    if (IsInEvadeMode())
        return false;

    // pussywizard: or if enemy is in evade mode
    if (enemy && enemy->GetTypeId() == TYPEID_UNIT && enemy->ToCreature()->IsInEvadeMode())
        return false;

    // we don't need help from non-combatant ;)
    if (IsCivilian())
        return false;

    if (HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE) || IsImmuneToNPC())
        return false;

    // skip fighting creature
    if (IsEngaged())
        return false;

    // only free creature
    if (GetCharmerOrOwnerGUID())
        return false;

    //npcbot
    if (IsNPCBotOrPet())
        return false;
    //end npcbot

    /// @todo: Implement aggro range, detection range and assistance range templates
    if (m_creatureInfo->HasFlagsExtra(CREATURE_FLAG_EXTRA_IGNORE_ALL_ASSISTANCE_CALLS))
    {
        return false;
    }

    // only from same creature faction
    if (checkfaction)
    {
        if (GetFaction() != u->GetFaction())
            return false;
    }
    else
    {
        if (!IsFriendlyTo(u))
            return false;
    }

    // skip non hostile to caster enemy creatures
    if (!IsHostileTo(enemy))
        return false;

    // Check if can see the enemy
    if (!CanSeeOrDetect(enemy))
    {
        return false;
    }

    return true;
}

// use this function to avoid having hostile creatures attack
// friendlies and other mobs they shouldn't attack
bool Creature::_IsTargetAcceptable(Unit const* target) const
{
    ASSERT(target);

    // if the target cannot be attacked, the target is not acceptable
    if (IsFriendlyTo(target) || !target->isTargetableForAttack(false, this) || (m_vehicle && (IsOnVehicle(target) || m_vehicle->GetBase()->IsOnVehicle(target))))
        return false;

    if (target->HasUnitState(UNIT_STATE_DIED))
    {
        // some creatures can detect fake death
        if (CanIgnoreFeignDeath() && target->HasUnitFlag2(UNIT_FLAG2_FEIGN_DEATH))
            return true;
        else
            return false;
    }

    Unit const* targetVictim = target->getAttackerForHelper();

    // if I'm already fighting target, or I'm hostile towards the target, the target is acceptable
    if (IsEngagedBy(target) || IsHostileTo(target))
        return true;

    // if the target's victim is friendly, and the target is neutral, the target is acceptable
    if (targetVictim && !IsNeutralToAll() && IsFriendlyTo(targetVictim))
        return true;

    // if the target's victim is not friendly, or the target is friendly, the target is not acceptable
    return false;
}

void Creature::UpdateMoveInLineOfSightState()
{
    // xinef: pets, guardians and units with scripts / smartAI should be skipped
    if (IsPet() || HasUnitTypeMask(UNIT_MASK_MINION | UNIT_MASK_SUMMON | UNIT_MASK_GUARDIAN | UNIT_MASK_CONTROLABLE_GUARDIAN) ||
            GetScriptId() || GetAIName() == "SmartAI")
    {
        m_moveInLineOfSightStrictlyDisabled = false;
        m_moveInLineOfSightDisabled = false;
        return;
    }

    if (IsTrigger() || IsCivilian() || GetCreatureType() == CREATURE_TYPE_NON_COMBAT_PET || IsCritter() || GetAIName() == "NullCreatureAI")
    {
        m_moveInLineOfSightDisabled = true;
        m_moveInLineOfSightStrictlyDisabled = true;
        return;
    }

    bool nonHostile = true;
    if (FactionTemplateEntry const* factionTemplate = sFactionTemplateStore.LookupEntry(GetFaction()))
        if (factionTemplate->hostileMask || factionTemplate->enemyFaction[0] || factionTemplate->enemyFaction[1] || factionTemplate->enemyFaction[2] || factionTemplate->enemyFaction[3])
            nonHostile = false;

    if (nonHostile)
        m_moveInLineOfSightDisabled = true;
    else
        m_moveInLineOfSightDisabled = false;
}

void Creature::SaveRespawnTime()
{
    if (IsSummon() || !m_spawnId || (m_creatureData && !m_creatureData->dbData))
        return;

    //npcbot: DO NOT save npcbots respawn time
    if (IsNPCBot())
        return;
    //end npcbot

    GetMap()->SaveCreatureRespawnTime(m_spawnId, m_respawnTime);
}

bool Creature::CanCreatureAttack(Unit const* victim, bool skipDistCheck) const
{
    if (!victim->IsInMap(this))
        return false;

    if (!IsValidAttackTarget(victim))
        return false;

    if (!victim->isInAccessiblePlaceFor(this))
        return false;

    if (IsAIEnabled && !AI()->CanAIAttack(victim))
        return false;

    // pussywizard: we cannot attack in evade mode
    if (IsInEvadeMode())
        return false;

    // pussywizard: or if enemy is in evade mode
    if (victim->GetTypeId() == TYPEID_UNIT && victim->ToCreature()->IsInEvadeMode())
        return false;

    // cannot attack if is during 5 second grace period, unless being attacked
    if (m_respawnedTime && (GameTime::GetGameTime().count() - m_respawnedTime) < 5 && victim->getAttackers().empty())
    {
        return false;
    }

    // if victim is in FD and we can't see that
    if (victim->HasUnitFlag2(UNIT_FLAG2_FEIGN_DEATH) && !CanIgnoreFeignDeath())
    {
        return false;
    }

    if (!GetCharmerOrOwnerGUID().IsPlayer())
    {
        if (GetMap()->IsDungeon())
            return true;

        // pussywizard: don't check distance to home position if recently damaged (allow kiting away from spawnpoint!)
        // xinef: this should include taunt auras
        if (!isWorldBoss() && (GetLastDamagedTime() > GameTime::GetGameTime().count() || HasAuraType(SPELL_AURA_MOD_TAUNT)))
            return true;
    }

    if (skipDistCheck)
        return true;

    // xinef: added size factor for huge npcs
    float dist = std::min<float>(GetMap()->GetVisibilityRange() + GetObjectSize() * 2, 150.0f);

    if (Unit* unit = GetCharmerOrOwner())
        return victim->IsWithinDist(unit, dist);
    else
    {
        // to prevent creatures in air ignore attacks because distance is already too high...
        if (GetMovementTemplate().IsFlightAllowed())
            return victim->IsInDist2d(&m_homePosition, dist);
        else
            return victim->IsInDist(&m_homePosition, dist);
    }
}

CreatureAddon const* Creature::GetCreatureAddon() const
{
    if (m_spawnId)
    {
        if (CreatureAddon const* addon = sObjectMgr->GetCreatureAddon(m_spawnId))
            return addon;
    }

    // dependent from difficulty mode entry
    return sObjectMgr->GetCreatureTemplateAddon(GetCreatureTemplate()->Entry);
}

//creature_addon table
bool Creature::LoadCreaturesAddon(bool reload)
{
    CreatureAddon const* cainfo = GetCreatureAddon();
    if (!cainfo)
        return false;

    if (cainfo->mount != 0)
        Mount(cainfo->mount);

    if (cainfo->bytes1 != 0)
    {
        // 0 StandState
        // 1 FreeTalentPoints   Pet only, so always 0 for default creature
        // 2 StandFlags
        // 3 StandMiscFlags

        SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_STAND_STATE, uint8(cainfo->bytes1 & 0xFF));
        //SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_PET_TALENTS, uint8((cainfo->bytes1 >> 8) & 0xFF));
        SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_PET_TALENTS, 0);
        SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_VIS_FLAG, uint8((cainfo->bytes1 >> 16) & 0xFF));
        SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, uint8((cainfo->bytes1 >> 24) & 0xFF));

        //! Suspected correlation between UNIT_FIELD_BYTES_1, offset 3, value 0x2:
        //! If no inhabittype_fly (if no MovementFlag_DisableGravity or MovementFlag_CanFly flag found in sniffs)
        //! Check using InhabitType as movement flags are assigned dynamically
        //! basing on whether the creature is in air or not
        //! Set MovementFlag_Hover. Otherwise do nothing.
        if (CanHover())
            AddUnitMovementFlag(MOVEMENTFLAG_HOVER);
    }

    if (cainfo->bytes2 != 0)
    {
        // 0 SheathState
        // 1 Bytes2Flags
        // 2 UnitRename         Pet only, so always 0 for default creature
        // 3 ShapeshiftForm     Must be determined/set by shapeshift spell/aura

        SetByteValue(UNIT_FIELD_BYTES_2, 0, uint8(cainfo->bytes2 & 0xFF));
        //SetByteValue(UNIT_FIELD_BYTES_2, 1, uint8((cainfo->bytes2 >> 8) & 0xFF));
        //SetByteValue(UNIT_FIELD_BYTES_2, 2, uint8((cainfo->bytes2 >> 16) & 0xFF));
        SetByteValue(UNIT_FIELD_BYTES_2, 2, 0);
        //SetByteValue(UNIT_FIELD_BYTES_2, 3, uint8((cainfo->bytes2 >> 24) & 0xFF));
        SetByteValue(UNIT_FIELD_BYTES_2, 3, 0);
    }

    SetUInt32Value(UNIT_NPC_EMOTESTATE, cainfo->emote);

    // Check if visibility distance different
    if (cainfo->visibilityDistanceType != VisibilityDistanceType::Normal)
    {
        SetVisibilityDistanceOverride(cainfo->visibilityDistanceType);
    }

    //Load Path
    if (cainfo->path_id != 0)
    {
        if (sWorld->getBoolConfig(CONFIG_SET_ALL_CREATURES_WITH_WAYPOINT_MOVEMENT_ACTIVE))
            setActive(true);
        m_path_id = cainfo->path_id;
    }

    if (!cainfo->auras.empty())
    {
        for (std::vector<uint32>::const_iterator itr = cainfo->auras.begin(); itr != cainfo->auras.end(); ++itr)
        {
            SpellInfo const* AdditionalSpellInfo = sSpellMgr->GetSpellInfo(*itr);
            if (!AdditionalSpellInfo)
            {
                LOG_ERROR("sql.sql", "Creature ({}) has wrong spell {} defined in `auras` field.", GetGUID().ToString(), *itr);
                continue;
            }

            // skip already applied aura
            if (HasAura(*itr))
            {
                if (!reload)
                    LOG_ERROR("sql.sql", "Creature ({}) has duplicate aura (spell {}) in `auras` field.", GetGUID().ToString(), *itr);

                continue;
            }

            AddAura(*itr, this);
            LOG_DEBUG("entities.unit", "Spell: {} added to creature ({})", *itr, GetGUID().ToString());
        }
    }

    return true;
}

/// Send a message to LocalDefense channel for players opposition team in the zone
void Creature::SendZoneUnderAttackMessage(Player* attacker)
{
    WorldPacket data(SMSG_ZONE_UNDER_ATTACK, 4);
    data << (uint32)GetAreaId();
    sWorld->SendGlobalMessage(&data, nullptr, (attacker->GetTeamId() == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE));
}

uint32 Creature::GetShieldBlockValue() const
{
    //npcbot - bot block value is fully calculated inside botAI
    if (bot_AI)
    {
        uint32 blockValue = bot_AI->GetShieldBlockValue();
        blockValue += GetTotalAuraModifier(SPELL_AURA_MOD_SHIELD_BLOCKVALUE);
        blockValue *= GetTotalAuraMultiplier(SPELL_AURA_MOD_SHIELD_BLOCKVALUE_PCT);
        return uint32(blockValue);
    }
    //end npcbot

    return (getLevel() / 2 + uint32(GetStat(STAT_STRENGTH) / 20));
}

void Creature::SetInCombatWithZone()
{
    if (IsAIEnabled)
        AI()->DoZoneInCombat();
}

void Creature::ProhibitSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs)
{
    for (uint8 i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; ++i)
    {
        if (idSchoolMask & (1 << i))
        {
            m_ProhibitSchoolTime[i] = GameTime::GetGameTimeMS().count() + unTimeMs;
        }
    }
}

bool Creature::IsSpellProhibited(SpellSchoolMask idSchoolMask) const
{
    for (uint8 i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; ++i)
    {
        if (idSchoolMask & (1 << i))
        {
            if (m_ProhibitSchoolTime[i] >= GameTime::GetGameTimeMS().count())
            {
                return true;
            }
        }
    }

    return false;
}

void Creature::ClearProhibitedSpellTimers()
{
    for (uint8 i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; ++i)
    {
        m_ProhibitSchoolTime[i] = 0;
    }
}

void Creature::_AddCreatureSpellCooldown(uint32 spell_id, uint16 categoryId, uint32 end_time)
{
    CreatureSpellCooldown spellCooldown;
    spellCooldown.category = categoryId;
    spellCooldown.end = GameTime::GetGameTimeMS().count() + end_time;
    m_CreatureSpellCooldowns[spell_id] = std::move(spellCooldown);
}

void Creature::AddSpellCooldown(uint32 spell_id, uint32 /*itemid*/, uint32 end_time, bool /*needSendToClient*/, bool /*forceSendToSpectator*/)
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell_id);
    if (!spellInfo)
        return;

    // used in proc system, otherwise normal creature cooldown
    if (end_time)
    {
        _AddCreatureSpellCooldown(spellInfo->Id, 0, end_time);
        return;
    }

    uint32 spellcooldown = spellInfo->RecoveryTime;
    uint32 categoryId = spellInfo->GetCategory();
    uint32 categorycooldown = categoryId ? spellInfo->CategoryRecoveryTime : 0;
    if (Player* modOwner = GetSpellModOwner())
    {
        modOwner->ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, spellcooldown);
        modOwner->ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, categorycooldown);
    }

    SpellCategoryStore::const_iterator i_scstore = sSpellsByCategoryStore.find(categoryId);
    if (categorycooldown && i_scstore != sSpellsByCategoryStore.end())
    {
        for (SpellCategorySet::const_iterator i_scset = i_scstore->second.begin(); i_scset != i_scstore->second.end(); ++i_scset)
        {
            _AddCreatureSpellCooldown(i_scset->second, categoryId, categorycooldown);
        }
    }
    else if (spellcooldown)
    {
        _AddCreatureSpellCooldown(spellInfo->Id, 0, spellcooldown);
    }

    if (sSpellMgr->HasSpellCooldownOverride(spellInfo->Id))
    {
        if (IsCharmed() && GetCharmer()->IsPlayer())
        {
            WorldPacket data;
            BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, spellInfo->Id, spellcooldown);
            GetCharmer()->ToPlayer()->SendDirectMessage(&data);
        }
    }
}

uint32 Creature::GetSpellCooldown(uint32 spell_id) const
{
    CreatureSpellCooldowns::const_iterator itr = m_CreatureSpellCooldowns.find(spell_id);
    if (itr == m_CreatureSpellCooldowns.end())
        return 0;

    return itr->second.end > GameTime::GetGameTimeMS().count() ? itr->second.end - GameTime::GetGameTimeMS().count() : 0;
}

bool Creature::HasSpellCooldown(uint32 spell_id) const
{
    //npcbot
    if (bot_AI)
        return !bot_AI->IsSpellReady(sSpellMgr->GetSpellInfo(spell_id)->GetFirstRankSpell()->Id, bot_AI->GetLastDiff(), false);
    else if (bot_pet_AI)
        return !bot_pet_AI->IsSpellReady(sSpellMgr->GetSpellInfo(spell_id)->GetFirstRankSpell()->Id, bot_pet_AI->GetLastDiff(), false);
    //end npcbot

    CreatureSpellCooldowns::const_iterator itr = m_CreatureSpellCooldowns.find(spell_id);
    return (itr != m_CreatureSpellCooldowns.end() && itr->second.end > GameTime::GetGameTimeMS().count());
}

bool Creature::HasSpell(uint32 spellID) const
{
    uint8 i;
    for (i = 0; i < MAX_CREATURE_SPELLS; ++i)
        if (spellID == m_spells[i])
            break;
    return i < MAX_CREATURE_SPELLS;                         //broke before end of iteration of known spells
}

time_t Creature::GetRespawnTimeEx() const
{
    time_t now = GameTime::GetGameTime().count();

    if (m_respawnTime > now)
        return m_respawnTime;
    else
        return now;
}

void Creature::GetRespawnPosition(float& x, float& y, float& z, float* ori, float* dist) const
{
    if (m_spawnId)
    {
        if (CreatureData const* data = sObjectMgr->GetCreatureData(m_spawnId))
        {
            x = data->posX;
            y = data->posY;
            z = data->posZ;
            if (ori)
                *ori = data->orientation;
            if (dist)
                *dist = data->wander_distance;

            return;
        }
    }

    // xinef: changed this from current position to home position, fixes world summons with infinite duration
    if (GetTransport())
    {
        x = GetPositionX();
        y = GetPositionY();
        z = GetPositionZ();
        if (ori)
            *ori = GetOrientation();
    }
    else
    {
        Position homePos = GetHomePosition();
        x = homePos.GetPositionX();
        y = homePos.GetPositionY();
        z = homePos.GetPositionZ();
        if (ori)
            *ori = homePos.GetOrientation();
    }
    if (dist)
        *dist = 0;
}

CreatureMovementData const& Creature::GetMovementTemplate() const
{
    if (CreatureMovementData const* movementOverride = sObjectMgr->GetCreatureMovementOverride(m_spawnId))
        return *movementOverride;

    return GetCreatureTemplate()->Movement;
}

void Creature::AllLootRemovedFromCorpse()
{
    //npcbot
    if (IsNPCBotOrPet())
        return;
    //end npcbot

    if (loot.loot_type != LOOT_SKINNING && !IsPet() && GetCreatureTemplate()->SkinLootId && hasLootRecipient())
    {
        if (LootTemplates_Skinning.HaveLootFor(GetCreatureTemplate()->SkinLootId))
        {
            SetUnitFlag(UNIT_FLAG_SKINNABLE);
        }
    }

    time_t now = GameTime::GetGameTime().count();
    if (m_corpseRemoveTime <= now)
    {
        return;
    }

    float decayRate = sWorld->getRate(RATE_CORPSE_DECAY_LOOTED);
    uint32 diff = uint32((m_corpseRemoveTime - now) * decayRate);

    m_respawnTime -= diff;

    // corpse skinnable, but without skinning flag, and then skinned, corpse will despawn next update
    if (loot.loot_type == LOOT_SKINNING)
    {
        m_corpseRemoveTime = GameTime::GetGameTime().count();
    }
    else
    {
        m_corpseRemoveTime -= diff;
    }
}

uint8 Creature::getLevelForTarget(WorldObject const* target) const
{
    if (!isWorldBoss() || !target->ToUnit())
        return Unit::getLevelForTarget(target);

    uint16 level = target->ToUnit()->GetLevel() + sWorld->getIntConfig(CONFIG_WORLD_BOSS_LEVEL_DIFF);
    if (level < 1)
        return 1;
    if (level > 255)
        return 255;
    return uint8(level);
}

std::string const& Creature::GetAIName() const
{
    return sObjectMgr->GetCreatureTemplate(GetEntry())->AIName;
}

std::string Creature::GetScriptName() const
{
    return sObjectMgr->GetScriptName(GetScriptId());
}

uint32 Creature::GetScriptId() const
{
    if (CreatureData const* creatureData = GetCreatureData())
        if (uint32 scriptId = creatureData->ScriptId)
            return scriptId;

    return sObjectMgr->GetCreatureTemplate(GetEntry())->ScriptID;
}

VendorItemData const* Creature::GetVendorItems() const
{
    return sObjectMgr->GetNpcVendorItemList(GetEntry());
}

uint32 Creature::GetVendorItemCurrentCount(VendorItem const* vItem)
{
    if (!vItem->maxcount)
        return vItem->maxcount;

    VendorItemCounts::iterator itr = m_vendorItemCounts.begin();
    for (; itr != m_vendorItemCounts.end(); ++itr)
        if (itr->itemId == vItem->item)
            break;

    if (itr == m_vendorItemCounts.end())
        return vItem->maxcount;

    VendorItemCount* vCount = &*itr;

    time_t ptime = GameTime::GetGameTime().count();

    if (time_t(vCount->lastIncrementTime + vItem->incrtime) <= ptime)
    {
        ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(vItem->item);

        uint32 diff = uint32((ptime - vCount->lastIncrementTime) / vItem->incrtime);
        if ((vCount->count + diff * pProto->BuyCount) >= vItem->maxcount)
        {
            m_vendorItemCounts.erase(itr);
            return vItem->maxcount;
        }

        vCount->count += diff * pProto->BuyCount;
        vCount->lastIncrementTime = ptime;
    }

    return vCount->count;
}

uint32 Creature::UpdateVendorItemCurrentCount(VendorItem const* vItem, uint32 used_count)
{
    if (!vItem->maxcount)
        return 0;

    VendorItemCounts::iterator itr = m_vendorItemCounts.begin();
    for (; itr != m_vendorItemCounts.end(); ++itr)
        if (itr->itemId == vItem->item)
            break;

    if (itr == m_vendorItemCounts.end())
    {
        uint32 new_count = vItem->maxcount > used_count ? vItem->maxcount - used_count : 0;
        m_vendorItemCounts.push_back(VendorItemCount(vItem->item, new_count));
        return new_count;
    }

    VendorItemCount* vCount = &*itr;

    time_t ptime = GameTime::GetGameTime().count();

    if (time_t(vCount->lastIncrementTime + vItem->incrtime) <= ptime)
    {
        ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(vItem->item);

        uint32 diff = uint32((ptime - vCount->lastIncrementTime) / vItem->incrtime);
        if ((vCount->count + diff * pProto->BuyCount) < vItem->maxcount)
            vCount->count += diff * pProto->BuyCount;
        else
            vCount->count = vItem->maxcount;
    }

    vCount->count = vCount->count > used_count ? vCount->count - used_count : 0;
    vCount->lastIncrementTime = ptime;
    return vCount->count;
}

TrainerSpellData const* Creature::GetTrainerSpells() const
{
    return sObjectMgr->GetNpcTrainerSpells(GetEntry());
}

// overwrite WorldObject function for proper name localization
std::string const& Creature::GetNameForLocaleIdx(LocaleConstant loc_idx) const
{
    if (loc_idx != DEFAULT_LOCALE)
    {
        uint8 uloc_idx = uint8(loc_idx);
        CreatureLocale const* cl = sObjectMgr->GetCreatureLocale(GetEntry());
        if (cl)
        {
            if (cl->Name.size() > uloc_idx && !cl->Name[uloc_idx].empty())
                return cl->Name[uloc_idx];
        }
    }

    return GetName();
}

void Creature::SetPosition(float x, float y, float z, float o)
{
    if (!Acore::IsValidMapCoord(x, y, z, o))
        return;

    //npcbot: send bot group update
    if (IsNPCBot())
        BotMgr::SetBotGroupUpdateFlag(ToCreature(), GROUP_UPDATE_FLAG_POSITION);
    //end npcbot

    GetMap()->CreatureRelocation(this, x, y, z, o);
}

bool Creature::IsDungeonBoss() const
{
    if (GetOwnerGUID().IsPlayer())
        return false;

    CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(GetEntry());
    return cinfo && (cinfo->flags_extra & CREATURE_FLAG_EXTRA_DUNGEON_BOSS);
}

bool Creature::IsImmuneToKnockback() const
{
    if (GetOwnerGUID().IsPlayer())
        return false;

    CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(GetEntry());
    return cinfo && (cinfo->flags_extra & CREATURE_FLAG_EXTRA_IMMUNITY_KNOCKBACK);
}

bool Creature::SetWalk(bool enable)
{
    if (!Unit::SetWalk(enable))
        return false;

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_SET_WALK_MODE : SMSG_SPLINE_MOVE_SET_RUN_MODE, 9);
    data << GetPackGUID();
    SendMessageToSet(&data, false);
    return true;
}

bool Creature::SetDisableGravity(bool disable, bool packetOnly /*= false*/, bool updateAnimationTier /*= true*/)
{
    //! It's possible only a packet is sent but moveflags are not updated
    //! Need more research on this
    if (!packetOnly && !Unit::SetDisableGravity(disable))
        return false;

    if (m_movedByPlayer)
    {
        WorldPacket data(disable ? SMSG_MOVE_GRAVITY_DISABLE : SMSG_MOVE_GRAVITY_ENABLE, 12);
        data << GetPackGUID();
        data << uint32(0); //! movement counter
        m_movedByPlayer->ToPlayer()->SendDirectMessage(&data);

        data.Initialize(MSG_MOVE_GRAVITY_CHNG, 64);
        data << GetPackGUID();
        BuildMovementPacket(&data);
        m_movedByPlayer->ToPlayer()->SendMessageToSet(&data, false);
        return true;
    }

    if (updateAnimationTier && IsAlive() && !HasUnitState(UNIT_STATE_ROOT) && !IsRooted())
    {
        if (IsLevitating())
            SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, UNIT_BYTE1_FLAG_FLY);
        else if (IsHovering())
            SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, UNIT_BYTE1_FLAG_HOVER);
        else
            SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, UNIT_BYTE1_FLAG_GROUND);
    }

    WorldPacket data(disable ? SMSG_SPLINE_MOVE_GRAVITY_DISABLE : SMSG_SPLINE_MOVE_GRAVITY_ENABLE, 9);
    data << GetPackGUID();
    SendMessageToSet(&data, false);
    return true;
}

bool Creature::SetSwim(bool enable)
{
    if (!Unit::SetSwim(enable))
        return false;

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_START_SWIM : SMSG_SPLINE_MOVE_STOP_SWIM);
    data << GetPackGUID();
    SendMessageToSet(&data, true);
    return true;
}

/**
 * @brief This method check the current flag/status of a creature and its inhabit type
 *
 * Pets should swim by default to properly follow the player
 * NOTE: You can set the UNIT_FLAG_CANNOT_SWIM temporary to deny a creature to swim
 *
 */
bool Creature::CanSwim() const
{
    if (Unit::CanSwim() || (!Unit::CanSwim() && !CanFly()))
        return true;

    if (IsPet())
        return true;

    return false;
}

bool Creature::CanEnterWater() const
{
    if (CanSwim())
        return true;

    return GetMovementTemplate().IsSwimAllowed();
}

void Creature::RefreshSwimmingFlag(bool recheck)
{
    if (!_isMissingSwimmingFlagOutOfCombat || recheck)
        _isMissingSwimmingFlagOutOfCombat = !HasUnitFlag(UNIT_FLAG_SWIMMING);

    // Check if the creature has UNIT_FLAG_SWIMMING and add it if it's missing
    // Creatures must be able to chase a target in water if they can enter water
    if (_isMissingSwimmingFlagOutOfCombat && CanEnterWater())
        SetUnitFlag(UNIT_FLAG_SWIMMING);
}

bool Creature::SetCanFly(bool enable, bool  /*packetOnly*/ /* = false */)
{
    if (!Unit::SetCanFly(enable))
        return false;

    if (m_movedByPlayer)
    {
        sScriptMgr->AnticheatSetCanFlybyServer(m_movedByPlayer->ToPlayer(), enable);

        if (!enable)
            m_movedByPlayer->ToPlayer()->SetFallInformation(GameTime::GetGameTime().count(), m_movedByPlayer->ToPlayer()->GetPositionZ());

        WorldPacket data(enable ? SMSG_MOVE_SET_CAN_FLY : SMSG_MOVE_UNSET_CAN_FLY, 12);
        data << GetPackGUID();
        data << uint32(0); //! movement counter
        m_movedByPlayer->ToPlayer()->SendDirectMessage(&data);

        data.Initialize(MSG_MOVE_UPDATE_CAN_FLY, 64);
        data << GetPackGUID();
        BuildMovementPacket(&data);
        m_movedByPlayer->ToPlayer()->SendMessageToSet(&data, false);
        return true;
    }

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_SET_FLYING : SMSG_SPLINE_MOVE_UNSET_FLYING, 9);
    data << GetPackGUID();
    SendMessageToSet(&data, false);
    return true;
}

bool Creature::SetWaterWalking(bool enable, bool packetOnly /* = false */)
{
    if (!packetOnly && !Unit::SetWaterWalking(enable))
        return false;

    if (m_movedByPlayer)
    {
        WorldPacket data(enable ? SMSG_MOVE_WATER_WALK : SMSG_MOVE_LAND_WALK, 12);
        data << GetPackGUID();
        data << uint32(0); //! movement counter
        m_movedByPlayer->ToPlayer()->SendDirectMessage(&data);

        data.Initialize(MSG_MOVE_WATER_WALK, 64);
        data << GetPackGUID();
        BuildMovementPacket(&data);
        m_movedByPlayer->ToPlayer()->SendMessageToSet(&data, false);
        return true;
    }

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_WATER_WALK : SMSG_SPLINE_MOVE_LAND_WALK, 9);
    data << GetPackGUID();
    SendMessageToSet(&data, true);
    return true;
}

bool Creature::SetFeatherFall(bool enable, bool packetOnly /* = false */)
{
    if (!packetOnly && !Unit::SetFeatherFall(enable))
        return false;

    if (m_movedByPlayer)
    {
        WorldPacket data(enable ? SMSG_MOVE_FEATHER_FALL : SMSG_MOVE_NORMAL_FALL, 12);
        data << GetPackGUID();
        data << uint32(0); //! movement counter
        m_movedByPlayer->ToPlayer()->SendDirectMessage(&data);

        data.Initialize(MSG_MOVE_FEATHER_FALL, 64);
        data << GetPackGUID();
        BuildMovementPacket(&data);
        m_movedByPlayer->ToPlayer()->SendMessageToSet(&data, false);
        return true;
    }

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_FEATHER_FALL : SMSG_SPLINE_MOVE_NORMAL_FALL, 9);
    data << GetPackGUID();
    SendMessageToSet(&data, true);
    return true;
}

bool Creature::SetHover(bool enable, bool packetOnly /*= false*/, bool updateAnimationTier /*= true*/)
{
    if (!packetOnly && !Unit::SetHover(enable))
        return false;

    if (updateAnimationTier && IsAlive() && !HasUnitState(UNIT_STATE_ROOT) && !IsRooted())
    {
        if (IsLevitating())
            SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, UNIT_BYTE1_FLAG_FLY);
        else if (IsHovering())
            SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, UNIT_BYTE1_FLAG_HOVER);
        else
            SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, UNIT_BYTE1_FLAG_GROUND);
    }

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_SET_HOVER : SMSG_SPLINE_MOVE_UNSET_HOVER, 9);
    data << GetPackGUID();
    SendMessageToSet(&data, false);
    return true;
}

float Creature::GetAggroRange(Unit const* target) const
{
    // Determines the aggro range for creatures
    // Based on data from wowwiki due to lack of 3.3.5a data

    float aggroRate = sWorld->getRate(RATE_CREATURE_AGGRO);
    if (aggroRate == 0)
        return 0.0f;

    auto creatureLevel = target->getLevelForTarget(this);
    auto playerLevel  = getLevelForTarget(target);
    int32 levelDiff = int32(creatureLevel) - int32(playerLevel);

    // The maximum Aggro Radius is capped at 45 yards (25 level difference)
    if (levelDiff < -25)
        levelDiff = -25;

    // The base aggro radius for mob of same level
    auto aggroRadius = GetDetectionRange();
    if (aggroRadius < 1)
    {
        return 0.0f;
    }
    // Aggro Radius varies with level difference at a rate of roughly 1 yard/level
    aggroRadius -= (float)levelDiff;

    // detect range auras
    aggroRadius += GetTotalAuraModifier(SPELL_AURA_MOD_DETECT_RANGE);

    // detected range auras
    aggroRadius += target->GetTotalAuraModifier(SPELL_AURA_MOD_DETECTED_RANGE);

    // Just in case, we don't want pets running all over the map
    if (aggroRadius > MAX_AGGRO_RADIUS)
        aggroRadius = MAX_AGGRO_RADIUS;

    // Minimum Aggro Radius for a mob seems to be combat range (5 yards)
    // hunter pets seem to ignore minimum aggro radius so we'll default it a little higher
    float minRange = IsPet() ? 10.0f : 5.0f;
    if (aggroRadius < minRange)
        aggroRadius = minRange;

    return (aggroRadius * aggroRate);
}

void Creature::UpdateMovementFlags()
{
    // Do not update movement flags if creature is controlled by a player (charm/vehicle)
    if (m_movedByPlayer)
        return;

    CreatureTemplate const* info = GetCreatureTemplate();
    if (!info)
        return;

    //npcbot: do not update movement flags for vehicles controlled by npcbots
    if (GetCharmerGUID().IsCreature())
    {
        if (CreatureTemplate const* bot_template = sObjectMgr->GetCreatureTemplate(GetCharmerGUID().GetEntry()))
        {
            if (bot_template->IsNPCBot())
                return;
        }
    }
    //end npcbot

    // Creatures with CREATURE_FLAG_EXTRA_NO_MOVE_FLAGS_UPDATE should control MovementFlags in your own scripts
    if (info->flags_extra & CREATURE_FLAG_EXTRA_NO_MOVE_FLAGS_UPDATE)
        return;

    float ground = GetFloorZ();

    bool canHover = CanHover();
    bool isInAir  = (G3D::fuzzyGt(GetPositionZ(), ground + (canHover ? GetFloatValue(UNIT_FIELD_HOVERHEIGHT) : 0.0f) + GROUND_HEIGHT_TOLERANCE) || G3D::fuzzyLt(GetPositionZ(), ground - GROUND_HEIGHT_TOLERANCE)); // Can be underground too, prevent the falling

    if (GetMovementTemplate().IsFlightAllowed() && isInAir && !IsFalling())
    {
        if (GetMovementTemplate().Flight == CreatureFlightMovementType::CanFly)
            SetCanFly(true);
        else
            SetDisableGravity(true);

        if (!HasAuraType(SPELL_AURA_HOVER))
            SetHover(false);
    }
    else
    {
        SetCanFly(false);
        SetDisableGravity(false);
        if (IsAlive() && (CanHover() || HasAuraType(SPELL_AURA_HOVER)))
            SetHover(true);
    }

    if (!isInAir)
        RemoveUnitMovementFlag(MOVEMENTFLAG_FALLING);

    bool Swim = false;
    LiquidData const& liquidData = GetLiquidData();
    switch (liquidData.Status)
    {
        case LIQUID_MAP_WATER_WALK:
        case LIQUID_MAP_IN_WATER:
            Swim = GetPositionZ() - liquidData.DepthLevel > GetCollisionHeight() * 0.75f; // Shallow water at ~75% of collision height
            break;
        case LIQUID_MAP_UNDER_WATER:
            Swim = true;
            break;
        default:
            break;
    }

    SetSwim(CanSwim() && Swim);
}

float Creature::GetNativeObjectScale() const
{
    return GetCreatureTemplate()->scale;
}

void Creature::SetObjectScale(float scale)
{
    Unit::SetObjectScale(scale);

    float combatReach = DEFAULT_WORLD_OBJECT_SIZE;

    if (CreatureModelInfo const* minfo = sObjectMgr->GetCreatureModelInfo(GetDisplayId()))
    {
        SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, (IsPet() ? 1.0f : minfo->bounding_radius) * scale);
        if (minfo->combat_reach > 0)
            combatReach = minfo->combat_reach;
    }

    if (IsPet())
        combatReach = DEFAULT_COMBAT_REACH;

    SetFloatValue(UNIT_FIELD_COMBATREACH, combatReach * scale);
}

void Creature::SetDisplayId(uint32 modelId)
{
    Unit::SetDisplayId(modelId);

    float combatReach = DEFAULT_WORLD_OBJECT_SIZE;

    if (CreatureModelInfo const* minfo = sObjectMgr->GetCreatureModelInfo(modelId))
    {
        SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, (IsPet() ? 1.0f : minfo->bounding_radius) * GetObjectScale());
        if (minfo->combat_reach > 0)
            combatReach = minfo->combat_reach;
    }

    if (IsPet())
        combatReach = DEFAULT_COMBAT_REACH;

    SetFloatValue(UNIT_FIELD_COMBATREACH, combatReach * GetObjectScale());

    //npcbot: send group update for bot pet
    if (IsNPCBotPet())
    {
        if (Creature const* botPetOwner = GetBotPetAI() ? GetBotPetAI()->GetPetsOwner() : nullptr)
            if (botPetOwner->GetBotAI()->GetGroup())
                BotMgr::SetBotGroupUpdateFlag(botPetOwner, GROUP_UPDATE_FLAG_PET_MODEL_ID);
    }
    //end npcbot
}

void Creature::SetTarget(ObjectGuid guid)
{
    if (!_focusSpell)
        SetGuidValue(UNIT_FIELD_TARGET, guid);
}

void Creature::FocusTarget(Spell const* focusSpell, WorldObject const* target)
{
    // already focused
    if (_focusSpell)
        return;

    _focusSpell = focusSpell;

    SetGuidValue(UNIT_FIELD_TARGET, this == target ? ObjectGuid::Empty : target->GetGUID());
    if (focusSpell->GetSpellInfo()->HasAttribute(SPELL_ATTR5_AI_DOESNT_FACE_TARGET))
        AddUnitState(UNIT_STATE_ROTATING);

    // Set serverside orientation if needed (needs to be after attribute check)
    if (this == target && (movespline->Finalized() || GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE))
        SetFacingTo(GetOrientation());
    else
        SetInFront(target);
}

bool Creature::HasSpellFocus(Spell const* focusSpell) const
{
    if (isDead()) // dead creatures cannot focus
    {
        return false;
    }

    return focusSpell ? (focusSpell == _spellFocusInfo.Spell) : (_spellFocusInfo.Spell || _spellFocusInfo.Delay);
}

void Creature::ReleaseFocus(Spell const* focusSpell)
{
    // focused to something else
    if (focusSpell != _focusSpell)
        return;

    _focusSpell = nullptr;
    if (Unit* victim = GetVictim())
        SetGuidValue(UNIT_FIELD_TARGET, victim->GetGUID());
    else
        SetGuidValue(UNIT_FIELD_TARGET, ObjectGuid::Empty);

    if (focusSpell->GetSpellInfo()->HasAttribute(SPELL_ATTR5_AI_DOESNT_FACE_TARGET))
        ClearUnitState(UNIT_STATE_ROTATING);
}

float Creature::GetAttackDistance(Unit const* player) const
{
    float aggroRate = sWorld->getRate(RATE_CREATURE_AGGRO);

    if (aggroRate == 0)
        return 0.0f;

    if (!player)
        return 0.0f;

    uint32 playerLevel = player->getLevelForTarget(this);
    uint32 creatureLevel = getLevelForTarget(player);

    int32 levelDiff = static_cast<int32>(playerLevel) - static_cast<int32>(creatureLevel);

    // "The maximum Aggro Radius has a cap of 25 levels under. Example: A level 30 char has the same Aggro Radius of a level 5 char on a level 60 mob."
    if (levelDiff < -25)
        levelDiff = -25;

    // "The aggro radius of a mob having the same level as the player is roughly 20 yards"
    float retDistance = 20.0f;

    // "Aggro Radius varies with level difference at a rate of roughly 1 yard/level"
    // radius grow if playlevel < creaturelevel
    retDistance -= static_cast<float>(levelDiff);

    if (creatureLevel + 5 <= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
    {
        // detect range auras
        retDistance += static_cast<float>( GetTotalAuraModifier(SPELL_AURA_MOD_DETECT_RANGE) );

        // detected range auras
        retDistance += static_cast<float>( player->GetTotalAuraModifier(SPELL_AURA_MOD_DETECTED_RANGE) );
    }

    // "Minimum Aggro Radius for a mob seems to be combat range (5 yards)"
    if (retDistance < 5.0f)
        retDistance = 5.0f;

    return (retDistance * aggroRate);
}

bool Creature::IsMovementPreventedByCasting() const
{
    Spell* spell = m_currentSpells[CURRENT_CHANNELED_SPELL];
    // first check if currently a movement allowed channel is active and we're not casting
    if (spell && spell->getState() != SPELL_STATE_FINISHED && spell->IsChannelActive() && spell->GetSpellInfo()->IsActionAllowedChannel())
    {
        return false;
    }

    if (HasSpellFocus())
    {
        return true;
    }

    if (HasUnitState(UNIT_STATE_CASTING))
    {
        return true;
    }

    return false;
}

void Creature::SetCannotReachTarget(ObjectGuid const& cannotReach)
{
    if (cannotReach == m_cannotReachTarget)
    {
        return;
    }

    m_cannotReachTarget = cannotReach;
    m_cannotReachTimer = 0;

    if (cannotReach)
    {
        LOG_DEBUG("entities.unit", "Creature::SetCannotReachTarget() called with true. Details: {}", GetDebugInfo());
    }
}

bool Creature::CanNotReachTarget() const
{
    return m_cannotReachTarget;
}

bool Creature::IsNotReachableAndNeedRegen() const
{
    if (CanNotReachTarget())
    {
        return m_cannotReachTimer >= (sWorld->getIntConfig(CONFIG_NPC_REGEN_TIME_IF_NOT_REACHABLE_IN_RAID) * IN_MILLISECONDS);
    }

    return false;
}

time_t Creature::GetLastDamagedTime() const
{
    if (!_lastDamagedTime)
        return time_t(0);

    return *_lastDamagedTime;
}

std::shared_ptr<time_t> const& Creature::GetLastDamagedTimePtr() const
{
    return _lastDamagedTime;
}

void Creature::SetLastDamagedTime(time_t val)
{
    if (val > 0)
    {
        if (_lastDamagedTime)
            *_lastDamagedTime = val;
        else
            _lastDamagedTime = std::make_shared<time_t>(val);
    }
    else
        _lastDamagedTime.reset();
}

void Creature::SetLastDamagedTimePtr(std::shared_ptr<time_t> const& val)
{
    _lastDamagedTime = val;
}

bool Creature::CanPeriodicallyCallForAssistance() const
{
    if (!IsInCombat())
        return false;

    if (HasUnitState(UNIT_STATE_DIED | UNIT_STATE_POSSESSED))
        return false;

    if (!CanHaveThreatList())
        return false;

    if (IsSummon() && GetMap()->Instanceable())
        return false;

    return true;
}

uint32 Creature::GetRandomId(uint32 id1, uint32 id2, uint32 id3)
{
    uint32 id = id1;
    uint8 ids = 0;

    if (id2)
    {
        ++ids;
        if (id3) ++ids;
    }

    if (ids)
    {
        uint8 idNumber = urand(0, ids);
        switch (idNumber)
        {
            case 0:
                id = id1;
                break;
            case 1:
                id = id2;
                break;
            case 2:
                id = id3;
                break;
        }
    }
    return id;
}

void Creature::SetPickPocketLootTime()
{
    lootPickPocketRestoreTime = GameTime::GetGameTime().count() + MINUTE + GetCorpseDelay() + GetRespawnTime();
}

bool Creature::CanGeneratePickPocketLoot() const
{
    return (lootPickPocketRestoreTime == 0 || lootPickPocketRestoreTime < GameTime::GetGameTime().count());
}

void Creature::SetRespawnTime(uint32 respawn)
{
    m_respawnTime = respawn ? GameTime::GetGameTime().count() + respawn : 0;
}

void Creature::SetCorpseRemoveTime(uint32 delay)
{
    m_corpseRemoveTime = GameTime::GetGameTime().count() + delay;
}

void Creature::ModifyThreatPercentTemp(Unit* victim, int32 percent, Milliseconds duration)
{
    if (victim)
    {
        float currentThreat = GetThreatMgr().GetThreat(victim);

        if (percent != 0.0f)
        {
            GetThreatMgr().ModifyThreatByPercent(victim, percent);
        }

        TemporaryThreatModifierEvent* pEvent = new TemporaryThreatModifierEvent(*this, victim->GetGUID(), currentThreat);
        m_Events.AddEvent(pEvent, m_Events.CalculateTime(duration.count()));
    }
}

bool Creature::IsDamageEnoughForLootingAndReward() const
{
    return (m_creatureInfo->flags_extra & CREATURE_FLAG_EXTRA_NO_PLAYER_DAMAGE_REQ) || (_playerDamageReq == 0 && _damagedByPlayer);
}

void Creature::LowerPlayerDamageReq(uint32 unDamage, bool damagedByPlayer /*= true*/)
{
    if (_playerDamageReq)
        _playerDamageReq > unDamage ? _playerDamageReq -= unDamage : _playerDamageReq = 0;

    if (!_damagedByPlayer)
    {
        _damagedByPlayer = damagedByPlayer;
    }
}

void Creature::ResetPlayerDamageReq()
{
    _playerDamageReq = GetHealth() / 2;
    _damagedByPlayer = false;
}

uint32 Creature::GetPlayerDamageReq() const
{
    return _playerDamageReq;
}

bool Creature::CanCastSpell(uint32 spellID) const
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellID);
    int32 currentPower = GetPower(getPowerType());

    if (HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) || IsSpellProhibited(spellInfo->GetSchoolMask()))
    {
        return false;
    }

    if (spellInfo && (currentPower < spellInfo->CalcPowerCost(this, spellInfo->GetSchoolMask())))
    {
        return false;
    }

    return true;
}

ObjectGuid Creature::GetSummonerGUID() const
{
    if (TempSummon const* temp = ToTempSummon())
        return temp->GetSummonerGUID();

    LOG_DEBUG("entities.unit", "Creature::GetSummonerGUID() called by creature that is not a summon. Creature: {} ({})", GetEntry(), GetName());
    return ObjectGuid::Empty;
}

std::string Creature::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << Unit::GetDebugInfo() << "\n"
        << "AIName: " << GetAIName() << " ScriptName: " << GetScriptName()
        << " WaypointPath: " << GetWaypointPath() << " SpawnId: " << GetSpawnId();
    return sstr.str();
}

//NPCBOT
bool Creature::LoadBotCreatureFromDB(ObjectGuid::LowType spawnId, Map* map, bool addToMap, bool generated, uint32 entry, Position const* pos)
{
    CreatureData const* data = generated ? nullptr : sObjectMgr->GetCreatureData(spawnId);
    if (!data)
    {
        if (!generated)
        {
            LOG_ERROR("sql.sql", "Bot creature (GUID: {}) not found in table `creature`, can't load.", spawnId);
            return false;
        }
        else
        {
            ASSERT(entry != 0);
            ASSERT_NOTNULL(pos);
        }
    }

    m_spawnId = spawnId;
    ASSERT(map->GetInstanceId() == 0);

    m_creatureData = data;
    m_wanderDistance = data ? data->wander_distance : 0.f;

    if (!Create(map->GenerateLowGuid<HighGuid::Unit>(), map,
        data ? data->phaseMask : PHASEMASK_NORMAL,
        data ? data->id1 : entry, 0,
        data ? data->posX : pos->m_positionX, data ? data->posY : pos->m_positionY,
        data ? data->posZ : pos->m_positionZ, data ? data->orientation : pos->GetOrientation(),
        data))
        return false;

    //We should set first home position, because then AI calls home movement
    SetHomePosition(*this);

    m_deathState = DeathState::Alive;
    m_respawnTime = 0;

    uint32 curhealth;

    if (data && !m_regenHealth)
    {
        curhealth = data->curhealth;
        if (curhealth)
        {
            curhealth = uint32(curhealth * _GetHealthMod(GetCreatureTemplate()->rank));
            if (curhealth < 1)
                curhealth = 1;
        }
        SetPower(POWER_MANA, data->curmana);
    }
    else
    {
        curhealth = GetMaxHealth();
        SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
    }

    SetHealth(m_deathState == DeathState::Alive ? curhealth : 0);

    // checked at creature_template loading
    m_defaultMovementType = data ? MovementGeneratorType(data->movementType) : IDLE_MOTION_TYPE;

    LOG_INFO("entities.unit", "Creature: loading npcbot {} (id: {}, gen: {})", GetName().c_str(), GetEntry(), uint32(generated));
    ASSERT(!IsInWorld());

    m_corpseDelay = 0;
    m_respawnDelay = 0;
    setActive(true);

    if (addToMap && !GetMap()->AddToMap(this))
        return false;

    return true;
}

uint8 Creature::GetBotClass() const
{
    return bot_AI ? bot_AI->GetBotClass() : GetClass();
}

Player* Creature::GetBotOwner() const
{
    return bot_AI ? bot_AI->GetBotOwner() : bot_pet_AI ? bot_pet_AI->GetPetsOwner()->GetBotOwner() : nullptr;
}
Unit* Creature::GetBotsPet() const
{
    return bot_AI ? bot_AI->GetBotsPet() : nullptr;
}

bool Creature::IsNPCBot() const
{
    return GetCreatureTemplate()->IsNPCBot();
}

bool Creature::IsNPCBotPet() const
{
    return GetCreatureTemplate()->IsNPCBotPet();
}

bool Creature::IsNPCBotOrPet() const
{
    return GetCreatureTemplate()->IsNPCBotOrPet();
}

bool Creature::IsFreeBot() const
{
    return bot_AI ? bot_AI->IAmFree() : bot_pet_AI ? bot_pet_AI->IAmFree() : false;
}

bool Creature::IsWandererBot() const
{
    return bot_AI ? bot_AI->IsWanderer() : bot_pet_AI ? bot_pet_AI->IsWanderer() : false;
}

Group* Creature::GetBotGroup() const
{
    return bot_AI ? bot_AI->GetGroup() : nullptr;
}
void Creature::SetBotGroup(Group* group, int8 subgroup)
{
    if (bot_AI)
        bot_AI->SetGroup(group, subgroup);
}
uint8 Creature::GetSubGroup() const
{
    return bot_AI ? bot_AI->GetSubGroup() : 0;
}
void Creature::SetSubGroup(uint8 subgroup)
{
    if (bot_AI)
        bot_AI->SetSubGroup(subgroup);
}

void Creature::SetBattlegroundOrBattlefieldRaid(Group* group, int8 subgroup)
{
    if (bot_AI)
        bot_AI->SetBattlegroundOrBattlefieldRaid(group, subgroup);
}
void Creature::RemoveFromBattlegroundOrBattlefieldRaid()
{
    if (bot_AI)
        bot_AI->RemoveFromBattlegroundOrBattlefieldRaid();
}
Group* Creature::GetOriginalGroup() const
{
    return bot_AI ? bot_AI->GetOriginalGroup() : nullptr;
}
void Creature::SetOriginalGroup(Group* group, int8 subgroup)
{
    if (bot_AI)
        bot_AI->SetOriginalGroup(group, subgroup);
}
uint8 Creature::GetOriginalSubGroup() const
{
    return bot_AI ? bot_AI->GetOriginalSubGroup() : 0;
}
void Creature::SetOriginalSubGroup(uint8 subgroup)
{
    if (bot_AI)
        bot_AI->SetOriginalSubGroup(subgroup);
}

Battleground* Creature::GetBotBG() const
{
    return bot_AI ? bot_AI->GetBG() : nullptr;
}

uint32 Creature::GetBotRoles() const
{
    return bot_AI ? bot_AI->GetBotRoles() : 0;
}
//Bot damage mods
void Creature::ApplyBotDamageMultiplierMelee(uint32& damage, CalcDamageInfo& damageinfo) const
{
    if (bot_AI)
        bot_AI->ApplyBotDamageMultiplierMelee(damage, damageinfo);
}
void Creature::ApplyBotDamageMultiplierMelee(int32& damage, SpellNonMeleeDamage& damageinfo, SpellInfo const* spellInfo, WeaponAttackType attackType, bool crit) const
{
    if (bot_AI)
        bot_AI->ApplyBotDamageMultiplierMelee(damage, damageinfo, spellInfo, attackType, crit);
}
void Creature::ApplyBotDamageMultiplierSpell(int32& damage, SpellNonMeleeDamage& damageinfo, SpellInfo const* spellInfo, WeaponAttackType attackType, bool crit) const
{
    if (bot_AI)
        bot_AI->ApplyBotDamageMultiplierSpell(damage, damageinfo, spellInfo, attackType, crit);
    else if (bot_pet_AI)
        bot_pet_AI->ApplyBotDamageMultiplierSpell(damage, damageinfo, spellInfo, attackType, crit);
}
void Creature::ApplyBotDamageMultiplierHeal(Unit const* victim, float& heal, SpellInfo const* spellInfo, DamageEffectType damagetype, uint32 stack) const
{
    if (bot_AI)
        bot_AI->ApplyBotDamageMultiplierHeal(victim, heal, spellInfo, damagetype, stack);
}
void Creature::ApplyBotCritMultiplierAll(Unit const* victim, float& crit_chance, SpellInfo const* spellInfo, SpellSchoolMask schoolMask, WeaponAttackType attackType) const
{
    if (bot_AI)
        bot_AI->ApplyBotCritMultiplierAll(victim, crit_chance, spellInfo, schoolMask, attackType);
}
void Creature::ApplyCreatureSpellCostMods(SpellInfo const* spellInfo, int32& cost) const
{
    if (bot_AI)
        bot_AI->ApplyBotSpellCostMods(spellInfo, cost);
}
void Creature::ApplyCreatureSpellCastTimeMods(SpellInfo const* spellInfo, int32& casttime) const
{
    if (bot_AI)
        bot_AI->ApplyBotSpellCastTimeMods(spellInfo, casttime);
}
void Creature::ApplyCreatureSpellRadiusMods(SpellInfo const* spellInfo, float& radius) const
{
    if (bot_AI)
        bot_AI->ApplyBotSpellRadiusMods(spellInfo, radius);
    else if (bot_pet_AI)
        bot_pet_AI->ApplyBotPetSpellRadiusMods(spellInfo, radius);
}
void Creature::ApplyCreatureSpellRangeMods(SpellInfo const* spellInfo, float& maxrange) const
{
    if (bot_AI)
        bot_AI->ApplyBotSpellRangeMods(spellInfo, maxrange);
}
void Creature::ApplyCreatureSpellMaxTargetsMods(SpellInfo const* spellInfo, uint32& targets) const
{
    if (bot_AI)
        bot_AI->ApplyBotSpellMaxTargetsMods(spellInfo, targets);
}
void Creature::ApplyCreatureSpellChanceOfSuccessMods(SpellInfo const* spellInfo, float& chance) const
{
    if (bot_AI)
        bot_AI->ApplyBotSpellChanceOfSuccessMods(spellInfo, chance);
}

void Creature::ApplyCreatureEffectMods(SpellInfo const* spellInfo, uint8 effIndex, float& value) const
{
    if (bot_AI)
        bot_AI->ApplyBotEffectMods(spellInfo, effIndex, value);
}

void Creature::OnBotSummon(Creature* summon)
{
    if (bot_AI)
        bot_AI->OnBotSummon(summon);
}
void Creature::OnBotDespawn(Creature* summon)
{
    if (bot_AI)
        bot_AI->OnBotDespawn(summon);
}

void Creature::BotStopMovement()
{
    if (IsInWorld())
    {
        GetMotionMaster()->Clear();
        GetMotionMaster()->MoveIdle();
    }
    StopMoving();
    DisableSpline();
}

bool Creature::CanParry() const
{
    return bot_AI ? bot_AI->CanParry() : true;
}

bool Creature::CanDodge() const
{
    return bot_AI ? bot_AI->CanDodge() : true;
}
//unused
bool Creature::CanBlock() const
{
    return bot_AI ? bot_AI->CanBlock() : true;
}
//unused
bool Creature::CanCrit() const
{
    return bot_AI ? bot_AI->CanCrit() : true;
}
bool Creature::CanMiss() const
{
    return bot_AI ? bot_AI->CanMiss() : true;
}

float Creature::GetCreatureParryChance() const
{
    return bot_AI ? bot_AI->GetBotParryChance() : 5.0f;
}
float Creature::GetCreatureDodgeChance() const
{
    return bot_AI ? bot_AI->GetBotDodgeChance() : 5.0f;
}
float Creature::GetCreatureBlockChance() const
{
    return bot_AI ? bot_AI->GetBotBlockChance() : 5.0f;
}
float Creature::GetCreatureCritChance() const
{
    return bot_AI ? bot_AI->GetBotCritChance() : 0.0f;
}
float Creature::GetCreatureMissChance() const
{
    return bot_AI ? bot_AI->GetBotMissChance() : 5.0f;
}
float Creature::GetCreatureArmorPenetrationCoef() const
{
    return bot_AI ? bot_AI->GetBotArmorPenetrationCoef() : 0.0f;
}
uint32 Creature::GetCreatureExpertise() const
{
    return bot_AI ? bot_AI->GetBotExpertise() : 0;
}
uint32 Creature::GetCreatureSpellPenetration() const
{
    return bot_AI ? bot_AI->GetBotSpellPenetration() : 0;
}
uint32 Creature::GetCreatureSpellPower() const
{
    return bot_AI ? bot_AI->GetBotSpellPower() : 0;
}
uint32 Creature::GetCreatureDefense() const
{
    return bot_AI ? bot_AI->GetBotDefense() : GetMaxSkillValueForLevel();
}
int32 Creature::GetCreatureResistanceBonus(SpellSchoolMask mask) const
{
    return bot_AI ? bot_AI->GetBotResistanceBonus(mask) : 0;
}

uint8 Creature::GetCreatureComboPoints() const
{
    return bot_AI ? bot_AI->GetBotComboPoints() : 0;
}

float Creature::GetCreatureAmmoDPS() const
{
    return bot_AI ? bot_AI->GetBotAmmoDPS() : 0.0f;
}

bool Creature::IsTempBot() const
{
    return bot_AI && bot_AI->IsTempBot();
}

MeleeHitOutcome Creature::BotRollMeleeOutcomeAgainst(Unit const* victim, WeaponAttackType attType) const
{
    return bot_AI ? bot_AI->BotRollCustomMeleeOutcomeAgainst(victim, attType) : RollMeleeOutcomeAgainst(victim, attType);
}

void Creature::CastCreatureItemCombatSpell(DamageInfo const& damageInfo)
{
    if (bot_AI)
        bot_AI->CastBotItemCombatSpell(damageInfo);
}

//bool Creature::HasSpellCooldown(uint32 spell_id) const
//{
//    if (bot_AI)
//        return !bot_AI->IsSpellReady(sSpellMgr->GetSpellInfo(spell_id)->GetFirstRankSpell()->Id, bot_AI->GetLastDiff(), false);
//    else if (bot_pet_AI)
//        return !bot_pet_AI->IsSpellReady(sSpellMgr->GetSpellInfo(spell_id)->GetFirstRankSpell()->Id, bot_pet_AI->GetLastDiff(), false);
//
//    return false;
//}
void Creature::AddBotSpellCooldown(uint32 spellId, uint32 cooldown)
{
    if (bot_AI)
        bot_AI->SetSpellCooldown(sSpellMgr->GetSpellInfo(spellId)->GetFirstRankSpell()->Id, cooldown);
    else if (bot_pet_AI)
        bot_pet_AI->SetSpellCooldown(sSpellMgr->GetSpellInfo(spellId)->GetFirstRankSpell()->Id, cooldown);
}
void Creature::ReleaseBotSpellCooldown(uint32 spellId)
{
    if (bot_AI)
        bot_AI->ReleaseSpellCooldown(sSpellMgr->GetSpellInfo(spellId)->GetFirstRankSpell()->Id);
    else if (bot_pet_AI)
        bot_pet_AI->ReleaseSpellCooldown(sSpellMgr->GetSpellInfo(spellId)->GetFirstRankSpell()->Id);
}

void Creature::SpendBotRunes(SpellInfo const* spellInfo, bool didHit)
{
    if (bot_AI)
        bot_AI->SpendRunes(spellInfo, didHit);
}

//equips
Item* Creature::GetBotEquips(uint8 slot) const
{
    return bot_AI ? bot_AI->GetEquips(slot) : nullptr;
}
Item* Creature::GetBotEquipsByGuid(ObjectGuid itemGuid) const
{
    return bot_AI ? bot_AI->GetEquipsByGuid(itemGuid) : nullptr;
}
float Creature::GetBotAverageItemLevel() const
{
    return bot_AI ? bot_AI->GetAverageItemLevel() : 0.0f;
}
//END NPCBOT
