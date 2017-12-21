/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "BattlegroundMgr.h"
#include "CellImpl.h"
#include "Common.h"
#include "CreatureAI.h"
#include "CreatureAISelector.h"
#include "CreatureGroups.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "Formulas.h"
#include "GameEventMgr.h"
#include "GossipDef.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "GroupMgr.h"
#include "InstanceScript.h"
#include "Log.h"
#include "LootMgr.h"
#include "MapManager.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "OutdoorPvPMgr.h"
#include "Player.h"
#include "PoolMgr.h"
#include "QuestDef.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "TemporarySummon.h"
#include "Util.h"
#include "Vehicle.h"
#include "WaypointMovementGenerator.h"
#include "World.h"
#include "WorldPacket.h"

#include "Transport.h"

TrainerSpell const* TrainerSpellData::Find(uint32 spell_id) const
{
    TrainerSpellMap::const_iterator itr = spellList.find(spell_id);
    if (itr != spellList.end())
        return &itr->second;

    return NULL;
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

VendorItem const* VendorItemData::FindItemCostPair(uint32 item_id, uint32 extendedCost) const
{
    for (VendorItemList::const_iterator i = m_items.begin(); i != m_items.end(); ++i)
        if ((*i)->item == item_id && (*i)->ExtendedCost == extendedCost)
            return *i;
    return NULL;
}

uint32 CreatureTemplate::GetRandomValidModelId() const
{
    uint8 c = 0;
    uint32 modelIDs[4];

    if (Modelid1) modelIDs[c++] = Modelid1;
    if (Modelid2) modelIDs[c++] = Modelid2;
    if (Modelid3) modelIDs[c++] = Modelid3;
    if (Modelid4) modelIDs[c++] = Modelid4;

    return ((c>0) ? modelIDs[urand(0, c-1)] : 0);
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
    if (Unit* victim = ObjectAccessor::GetUnit(m_owner, m_victim))
    {
        while (!m_assistants.empty())
        {
            Creature* assistant = ObjectAccessor::GetCreature(m_owner, *m_assistants.begin());
            m_assistants.pop_front();

            if (assistant && assistant->CanAssistTo(&m_owner, victim))
            {
                assistant->SetNoCallAssistance(true);
                assistant->CombatStart(victim);
                if (assistant->IsAIEnabled)
                    assistant->AI()->AttackStart(victim);
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
    m_owner.DespawnOrUnsummon();    // since we are here, we are not TempSummon as object type cannot change during runtime
    return true;
}

Creature::Creature(bool isWorldObject): Unit(isWorldObject), MovableMapObject(), m_groupLootTimer(0), lootingGroupLowGUID(0), m_PlayerDamageReq(0), m_lootRecipient(0), m_lootRecipientGroup(0),
m_corpseRemoveTime(0), m_respawnTime(0), m_respawnDelay(300), m_corpseDelay(60), m_respawnradius(0.0f),
m_transportCheckTimer(1000), lootPickPocketRestoreTime(0),  m_reactState(REACT_AGGRESSIVE), m_defaultMovementType(IDLE_MOTION_TYPE),
m_DBTableGuid(0), m_equipmentId(0), m_originalEquipmentId(0), m_AlreadyCallAssistance(false),
m_AlreadySearchedAssistance(false), m_regenHealth(true), m_AI_locked(false), m_meleeDamageSchoolMask(SPELL_SCHOOL_MASK_NORMAL), m_originalEntry(0), m_moveInLineOfSightDisabled(false), m_moveInLineOfSightStrictlyDisabled(false),
m_homePosition(), m_transportHomePosition(), m_creatureInfo(NULL), m_creatureData(NULL), m_waypointID(0), m_path_id(0), m_formation(NULL), _lastDamagedTime(0)
{
    m_regenTimer = CREATURE_REGEN_INTERVAL;
    m_valuesCount = UNIT_END;

    for (uint8 i = 0; i < CREATURE_MAX_SPELLS; ++i)
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
    _focusSpell = NULL;
}

Creature::~Creature()
{
    m_vendorItemCounts.clear();

    delete i_AI;
    i_AI = NULL;

    //if (m_uint32Values)
    //    sLog->outError("Deconstruct Creature Entry = %u", GetEntry());
}

void Creature::AddToWorld()
{ 
    ///- Register the creature for guid lookup
    if (!IsInWorld())
    {
        // pussywizard: motion master needs to be initialized before OnCreatureCreate, which may set death state to JUST_DIED, to prevent crash
        // it's also initialized in AIM_Initialize(), few lines below, but it's not a problem
        Motion_Initialize();

        if (GetZoneScript())
            GetZoneScript()->OnCreatureCreate(this);

        sObjectAccessor->AddObject(this);
        Unit::AddToWorld();
        SearchFormation();
        AIM_Initialize();
        if (IsVehicle())
            GetVehicleKit()->Install();
    }
}

void Creature::RemoveFromWorld()
{ 
    if (IsInWorld())
    {
        if (GetZoneScript())
            GetZoneScript()->OnCreatureRemove(this);
        if (m_formation)
            sFormationMgr->RemoveCreatureFromGroup(m_formation, this);
        if (Transport* transport = GetTransport())
            transport->RemovePassenger(this, true);
        Unit::RemoveFromWorld();
        sObjectAccessor->RemoveObject(this);
    }
}

void Creature::DisappearAndDie()
{ 
    DestroyForNearbyPlayers();
    //SetVisibility(VISIBILITY_OFF);
    //ObjectAccessor::UpdateObjectVisibility(this);
    if (IsAlive())
        setDeathState(JUST_DIED, true);
    RemoveCorpse(false, true);
}

void Creature::SearchFormation()
{ 
    if (IsSummon())
        return;

    uint32 lowguid = GetDBTableGUIDLow();
    if (!lowguid)
        return;

    CreatureGroupInfoType::iterator frmdata = sFormationMgr->CreatureGroupMap.find(lowguid);
    if (frmdata != sFormationMgr->CreatureGroupMap.end())
        sFormationMgr->AddCreatureToGroup(frmdata->second->leaderGUID, this);
}

void Creature::RemoveCorpse(bool setSpawnTime, bool skipVisibility)
{ 
    if (getDeathState() != CORPSE)
        return;

    m_corpseRemoveTime = time(NULL);
    setDeathState(DEAD);
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
        m_respawnTime = time(NULL) + respawnDelay;
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
        sLog->outErrorDb("Creature::InitEntry creature entry %u does not exist.", Entry);
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
        sLog->outErrorDb("Creature (Entry: %u) has no model defined in table `creature_template`, can't load. ", Entry);
        return false;
    }

    uint32 displayID = ObjectMgr::ChooseDisplayId(GetCreatureTemplate(), data);
    CreatureModelInfo const* minfo = sObjectMgr->GetCreatureModelRandomGender(&displayID);
    if (!minfo)                                             // Cancel load if no model defined
    {
        sLog->outErrorDb("Creature (Entry: %u) has no model defined in table `creature_template`, can't load. ", Entry);
        return false;
    }

    SetDisplayId(displayID);
    SetNativeDisplayId(displayID);
    SetByteValue(UNIT_FIELD_BYTES_0, 2, minfo->gender);

    // Load creature equipment
    if (!data || data->equipmentId == 0)                    // use default from the template
        LoadEquipment();
    else if (data && data->equipmentId != 0)                // override, 0 means no equipment
    {
        m_originalEquipmentId = data->equipmentId;
        LoadEquipment(data->equipmentId);
    }

    SetName(normalInfo->Name);                              // at normal entry always

    SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);

    SetSpeed(MOVE_WALK,     cinfo->speed_walk);
    SetSpeed(MOVE_RUN,      cinfo->speed_run);
    SetSpeed(MOVE_SWIM, 1.0f);      // using 1.0 rate
    SetSpeed(MOVE_FLIGHT, 1.0f);    // using 1.0 rate

    // Will set UNIT_FIELD_BOUNDINGRADIUS and UNIT_FIELD_COMBATREACH
    SetObjectScale(cinfo->scale);

    SetFloatValue(UNIT_FIELD_HOVERHEIGHT, cinfo->HoverHeight);

    // checked at loading
    m_defaultMovementType = MovementGeneratorType(cinfo->MovementType);
    if (!m_respawnradius && m_defaultMovementType == RANDOM_MOTION_TYPE)
        m_defaultMovementType = IDLE_MOTION_TYPE;

    for (uint8 i=0; i < CREATURE_MAX_SPELLS; ++i)
        m_spells[i] = GetCreatureTemplate()->spells[i];

    return true;
}

bool Creature::UpdateEntry(uint32 Entry, const CreatureData* data, bool changelevel)
{ 
    if (!InitEntry(Entry, data))
        return false;

    CreatureTemplate const* cInfo = GetCreatureTemplate();

    m_regenHealth = cInfo->RegenHealth;

    // creatures always have melee weapon ready if any unless specified otherwise
    if (!GetCreatureAddon())
        SetSheath(SHEATH_STATE_MELEE);

    setFaction(cInfo->faction);

    uint32 npcflag, unit_flags, dynamicflags;
    ObjectMgr::ChooseCreatureFlags(cInfo, npcflag, unit_flags, dynamicflags, data);

    if (cInfo->flags_extra & CREATURE_FLAG_EXTRA_WORLDEVENT)
        SetUInt32Value(UNIT_NPC_FLAGS, npcflag | sGameEventMgr->GetNPCFlag(this));
    else
        SetUInt32Value(UNIT_NPC_FLAGS, npcflag);

    // Xinef: NPC is in combat, keep this flag!
    unit_flags &= ~UNIT_FLAG_IN_COMBAT;
    if (IsInCombat())
        unit_flags |= UNIT_FLAG_IN_COMBAT;

    SetUInt32Value(UNIT_FIELD_FLAGS, unit_flags);
    SetUInt32Value(UNIT_FIELD_FLAGS_2, cInfo->unit_flags2);

    SetUInt32Value(UNIT_DYNAMIC_FLAGS, dynamicflags);

    SetAttackTime(BASE_ATTACK,   cInfo->baseattacktime);
    SetAttackTime(OFF_ATTACK,    cInfo->baseattacktime);
    SetAttackTime(RANGED_ATTACK, cInfo->rangeattacktime);

    SelectLevel(changelevel);

    SetMeleeDamageSchool(SpellSchools(cInfo->dmgschool));
    CreatureBaseStats const* stats = sObjectMgr->GetCreatureBaseStats(getLevel(), cInfo->unit_class);
    float armor = (float)stats->GenerateArmor(cInfo); // TODO: Why is this treated as uint32 when it's a float?
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
        if (factionTemplate->factionFlags & FACTION_TEMPLATE_FLAG_PVP)
            SetPvP(true);
        else
            SetPvP(false);
    }

    // updates spell bars for vehicles and set player's faction - should be called here, to overwrite faction that is set from the new template
    if (IsVehicle())
    {   
        if (Player* owner = Creature::GetCharmerOrOwnerPlayerOrPlayerItself()) // this check comes in case we don't have a player
        { 
            setFaction(owner->getFaction()); // vehicles should have same as owner faction
            owner->VehicleSpellInitialize(); 
        }
    }

    // trigger creature is always not selectable and can not be attacked
    if (IsTrigger())
        SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

    InitializeReactState();

    if (!IsPet() && cInfo->flags_extra & CREATURE_FLAG_EXTRA_NO_TAUNT)
    {
        ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
        ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);
    }

    UpdateEnvironmentIfNeeded(3);

    return true;
}

void Creature::Update(uint32 diff)
{ 
    if (IsAIEnabled && TriggerJustRespawned)
    {
        TriggerJustRespawned = false;
        AI()->JustRespawned();
        if (m_vehicleKit)
            m_vehicleKit->Reset();
    }

    switch (m_deathState)
    {
        case JUST_RESPAWNED:
            // Must not be called, see Creature::setDeathState JUST_RESPAWNED -> ALIVE promoting.
            sLog->outError("Creature (GUID: %u Entry: %u) in wrong state: JUST_RESPAWNED (4)", GetGUIDLow(), GetEntry());
            break;
        case JUST_DIED:
            // Must not be called, see Creature::setDeathState JUST_DIED -> CORPSE promoting.
            sLog->outError("Creature (GUID: %u Entry: %u) in wrong state: JUST_DEAD (1)", GetGUIDLow(), GetEntry());
            break;
        case DEAD:
        {
            time_t now = time(NULL);
            if (m_respawnTime <= now)
            {
                bool allowed = IsAIEnabled ? AI()->CanRespawn() : true;     // First check if there are any scripts that object to us respawning
                if (!allowed)                                               // Will be rechecked on next Update call
                    break;

                uint64 dbtableHighGuid = MAKE_NEW_GUID(m_DBTableGuid, GetEntry(), HIGHGUID_UNIT);
                time_t linkedRespawntime = GetMap()->GetLinkedRespawnTime(dbtableHighGuid);
                if (!linkedRespawntime)             // Can respawn
                    Respawn();
                else                                // the master is dead
                {
                    uint64 targetGuid = sObjectMgr->GetLinkedRespawnGuid(dbtableHighGuid);
                    if (targetGuid == dbtableHighGuid) // if linking self, never respawn (check delayed to next day)
                        SetRespawnTime(DAY);
                    else
                        m_respawnTime = (now > linkedRespawntime ? now : linkedRespawntime)+urand(5, MINUTE); // else copy time from master and add a little
                    SaveRespawnTime(); // also save to DB immediately
                }
            }
            break;
        }
        case CORPSE:
        {
            Unit::Update(diff);
            // deathstate changed on spells update, prevent problems
            if (m_deathState != CORPSE)
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
                else m_groupLootTimer -= diff;
            }
            else if (m_corpseRemoveTime <= time(NULL))
            {
                RemoveCorpse(false);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outStaticDebug("Removing corpse... %u ", GetUInt32Value(OBJECT_FIELD_ENTRY));
#endif
            }
            break;
        }
        case ALIVE:
        {
            Unit::Update(diff);

            // creature can be dead after Unit::Update call
            // CORPSE/DEAD state will processed at next tick (in other case death timer will be updated unexpectedly)
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

            if (!IsInEvadeMode() && IsAIEnabled)
            {
                // do not allow the AI to be changed during update
                m_AI_locked = true;
                i_AI->UpdateAI(diff);
                m_AI_locked = false;
            }

            // creature can be dead after UpdateAI call
            // CORPSE/DEAD state will processed at next tick (in other case death timer will be updated unexpectedly)
            if (!IsAlive())
                break;

            m_regenTimer -= diff;
            if (m_regenTimer <= 0)
            {
                if (!IsInEvadeMode() && (!IsInCombat() || IsPolymorphed())) // regenerate health if not in combat or if polymorphed
                    RegenerateHealth();
 
                if (getPowerType() == POWER_ENERGY)
                    Regenerate(POWER_ENERGY);
                else
                    Regenerate(POWER_MANA);
 
                m_regenTimer += CREATURE_REGEN_INTERVAL;
            }
            break;
        }
        default:
            break;
    }

    if (IsInWorld() && !IsDuringRemoveFromWorld())
    {
        // pussywizard:
        if (IS_PLAYER_GUID(GetOwnerGUID()))
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

void Creature::Regenerate(Powers power)
{ 
    uint32 curValue = GetPower(power);
    uint32 maxValue = GetMaxPower(power);

    // Xinef: implement power regeneration flag
    if (!HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_REGENERATE_POWER) && !IS_PLAYER_GUID(GetOwnerGUID()))
        return;

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

    addvalue += GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_POWER_REGEN, power) * (power == POWER_FOCUS ? PET_FOCUS_REGEN_INTERVAL : CREATURE_REGEN_INTERVAL) / (5 * IN_MILLISECONDS);

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
        addvalue = maxValue/3;
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
    if (radius >0)
    {
        Creature* creature = NULL;

        CellCoord p(Trinity::ComputeCellCoord(GetPositionX(), GetPositionY()));
        Cell cell(p);
        cell.SetNoCreate();
        Trinity::NearestAssistCreatureInCreatureRangeCheck u_check(this, GetVictim(), radius);
        Trinity::CreatureLastSearcher<Trinity::NearestAssistCreatureInCreatureRangeCheck> searcher(this, creature, u_check);

        TypeContainerVisitor<Trinity::CreatureLastSearcher<Trinity::NearestAssistCreatureInCreatureRangeCheck>, GridTypeMapContainer > grid_creature_searcher(searcher);

        cell.Visit(p, grid_creature_searcher, *GetMap(), *this, radius);

        SetNoSearchAssistance(true);
        UpdateSpeed(MOVE_RUN, false);

        if (!creature)
            //SetFeared(true, GetVictim()->GetGUID(), 0, sWorld->getIntConfig(CONFIG_CREATURE_FAMILY_FLEE_DELAY));
            //TODO: use 31365
            SetControlled(true, UNIT_STATE_FLEEING);
        else
            GetMotionMaster()->MoveSeekAssistance(creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ());
    }
}

bool Creature::AIM_Initialize(CreatureAI* ai)
{ 
    // make sure nothing can change the AI during AI update
    if (m_AI_locked)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_TSCR, "AIM_Initialize: failed to init, locked.");
#endif
        return false;
    }

    UnitAI* oldAI = i_AI;

    // Xinef: called in add to world
    //Motion_Initialize();

    i_AI = ai ? ai : FactorySelector::selectAI(this);
    delete oldAI;
    IsAIEnabled = true;
    i_AI->InitializeAI();

    // Xinef: Initialize vehicle if it is not summoned!
    if (GetVehicleKit() && GetDBTableGUIDLow())
        GetVehicleKit()->Reset();
    return true;
}

void Creature::Motion_Initialize()
{ 
    if (!m_formation)
        GetMotionMaster()->Initialize();
    else if (m_formation->getLeader() == this)
    {
        m_formation->FormationReset(false);
        GetMotionMaster()->Initialize();
    }
    else if (m_formation->isFormed())
        GetMotionMaster()->MoveIdle(); //wait the order of leader
    else
        GetMotionMaster()->Initialize();
}

bool Creature::Create(uint32 guidlow, Map* map, uint32 phaseMask, uint32 Entry, uint32 vehId, float x, float y, float z, float ang, const CreatureData* data)
{ 
    ASSERT(map);
    SetMap(map);
    SetPhaseMask(phaseMask, false);

    CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(Entry);
    if (!cinfo)
    {
        sLog->outErrorDb("Creature::Create(): creature template (guidlow: %u, entry: %u) does not exist.", guidlow, Entry);
        return false;
    }

    //! Relocate before CreateFromProto, to initialize coords and allow
    //! returning correct zone id for selecting OutdoorPvP/Battlefield script
    Relocate(x, y, z, ang);

    //oX = x;     oY = y;    dX = x;    dY = y;    m_moveTime = 0;    m_startMove = 0;
    if (!CreateFromProto(guidlow, Entry, vehId, data))
        return false;

    if (!IsPositionValid())
    {
        sLog->outError("Creature::Create(): given coordinates for creature (guidlow %d, entry %d) are not valid (X: %f, Y: %f, Z: %f, O: %f)", guidlow, Entry, x, y, z, ang);
        return false;
    }

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
                m_corpseDelay = sWorld->getIntConfig(CONFIG_CORPSE_DECAY_ELITE)*2;
            else
                m_corpseDelay = sWorld->getIntConfig(CONFIG_CORPSE_DECAY_WORLDBOSS);
            break;
        default:
            m_corpseDelay = sWorld->getIntConfig(CONFIG_CORPSE_DECAY_NORMAL);
            break;
    }

    LoadCreaturesAddon();

    uint32 displayID = GetNativeDisplayId();
    CreatureModelInfo const* minfo = sObjectMgr->GetCreatureModelRandomGender(&displayID);
    if (minfo && !IsTotem())                               // Cancel load if no model defined or if totem
    {
        SetDisplayId(displayID);
        SetNativeDisplayId(displayID);
        SetByteValue(UNIT_FIELD_BYTES_0, 2, minfo->gender);
    }

    LastUsedScriptID = GetCreatureTemplate()->ScriptID;

    // TODO: Replace with spell, handle from DB
    if (IsSpiritHealer() || IsSpiritGuide())
    {
        m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_GHOST);
        m_serverSideVisibilityDetect.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_GHOST);
    }
    else if (cinfo->type_flags & CREATURE_TYPEFLAGS_GHOST) // Xinef: Add ghost visibility for ghost units
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
        player->PlayerTalkClass->ClearMenus();
        switch (bgTypeId)
        {
            case BATTLEGROUND_AV:  player->PlayerTalkClass->SendGossipMenu(7616, GetGUID()); break;
            case BATTLEGROUND_WS:  player->PlayerTalkClass->SendGossipMenu(7599, GetGUID()); break;
            case BATTLEGROUND_AB:  player->PlayerTalkClass->SendGossipMenu(7642, GetGUID()); break;
            case BATTLEGROUND_EY:
            case BATTLEGROUND_NA:
            case BATTLEGROUND_BE:
            case BATTLEGROUND_AA:
            case BATTLEGROUND_RL:
            case BATTLEGROUND_SA:
            case BATTLEGROUND_DS:
            case BATTLEGROUND_RV: player->PlayerTalkClass->SendGossipMenu(10024, GetGUID()); break;
            default: break;
        }
        return false;
    }
    return true;
}

bool Creature::isCanTrainingAndResetTalentsOf(Player* player) const
{ 
    return player->getLevel() >= 10
        && GetCreatureTemplate()->trainer_type == TRAINER_TYPE_CLASS
        && player->getClass() == GetCreatureTemplate()->trainer_class;
}

Player* Creature::GetLootRecipient() const
{ 
    if (!m_lootRecipient)
        return NULL;
    return ObjectAccessor::FindPlayerInOrOutOfWorld(m_lootRecipient);
}

Group* Creature::GetLootRecipientGroup() const
{ 
    if (!m_lootRecipientGroup)
        return NULL;
    return sGroupMgr->GetGroupByGUID(m_lootRecipientGroup);
}

void Creature::SetLootRecipient(Unit* unit, bool withGroup)
{ 
    // set the player whose group should receive the right
    // to loot the creature after it dies
    // should be set to NULL after the loot disappears

    if (!unit)
    {
        m_lootRecipient = 0;
        m_lootRecipientGroup = 0;
        RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE|UNIT_DYNFLAG_TAPPED);
        return;
    }

    //if (unit->GetTypeId() != TYPEID_PLAYER && !unit->IsVehicle())
    //    return;

    Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (!player)                                             // normal creature, no player involved
        return;

    m_lootRecipient = player->GetGUID();

    if (withGroup)
    {
        if (Group* group = player->GetGroup())
            m_lootRecipientGroup = group->GetLowGUID();
    }
    else
        m_lootRecipientGroup = 0;

    SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_TAPPED);
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
    // this should only be used when the creature has already been loaded
    // preferably after adding to map, because mapid may not be valid otherwise
    CreatureData const* data = sObjectMgr->GetCreatureData(m_DBTableGuid);
    if (!data)
    {
        sLog->outError("Creature::SaveToDB failed, cannot get creature data!");
        return;
    }

    uint32 mapId = GetTransport() && GetTransport()->ToMotionTransport() ? GetTransport()->GetGOInfo()->moTransport.mapID : GetMapId();
    SaveToDB(mapId, data->spawnMask, GetPhaseMask());
}

void Creature::SaveToDB(uint32 mapid, uint8 spawnMask, uint32 phaseMask)
{ 
    // update in loaded data
    if (!m_DBTableGuid)
        m_DBTableGuid = GetGUIDLow();
    CreatureData& data = sObjectMgr->NewOrExistCreatureData(m_DBTableGuid);

    uint32 displayId = GetNativeDisplayId();
    uint32 npcflag = GetUInt32Value(UNIT_NPC_FLAGS);
    uint32 unit_flags = GetUInt32Value(UNIT_FIELD_FLAGS);
    uint32 dynamicflags = GetUInt32Value(UNIT_DYNAMIC_FLAGS);

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

    // data->guid = guid must not be updated at save
    data.id = GetEntry();
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
    data.spawndist = GetDefaultMovementType() == IDLE_MOTION_TYPE ? 0.0f : m_respawnradius;
    data.currentwaypoint = 0;
    data.curhealth = GetHealth();
    data.curmana = GetPower(POWER_MANA);
    // prevent add data integrity problems
    data.movementType = !m_respawnradius && GetDefaultMovementType() == RANDOM_MOTION_TYPE
        ? IDLE_MOTION_TYPE : GetDefaultMovementType();
    data.spawnMask = spawnMask;
    data.npcflag = npcflag;
    data.unit_flags = unit_flags;
    data.dynamicflags = dynamicflags;

    // update in DB
    SQLTransaction trans = WorldDatabase.BeginTransaction();

    PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_CREATURE);
    stmt->setUInt32(0, m_DBTableGuid);
    trans->Append(stmt);

    uint8 index = 0;

    stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_CREATURE);
    stmt->setUInt32(index++, m_DBTableGuid);
    stmt->setUInt32(index++, GetEntry());
    stmt->setUInt16(index++, uint16(mapid));
    stmt->setUInt8(index++, spawnMask);
    stmt->setUInt32(index++, GetPhaseMask());
    stmt->setUInt32(index++, displayId);
    stmt->setInt32(index++, int32(GetCurrentEquipmentId()));
    stmt->setFloat(index++, GetPositionX());
    stmt->setFloat(index++, GetPositionY());
    stmt->setFloat(index++, GetPositionZ());
    stmt->setFloat(index++, GetOrientation());
    stmt->setUInt32(index++, m_respawnDelay);
    stmt->setFloat(index++, m_respawnradius);
    stmt->setUInt32(index++, 0);
    stmt->setUInt32(index++, GetHealth());
    stmt->setUInt32(index++, GetPower(POWER_MANA));
    stmt->setUInt8(index++, uint8(GetDefaultMovementType()));
    stmt->setUInt32(index++, npcflag);
    stmt->setUInt32(index++, unit_flags);
    stmt->setUInt32(index++, dynamicflags);
    trans->Append(stmt);

    WorldDatabase.CommitTransaction(trans);
}

void Creature::SelectLevel(bool changelevel)
{ 
    CreatureTemplate const* cInfo = GetCreatureTemplate();

    uint32 rank = IsPet() ? 0 : cInfo->rank;

    // level
    uint8 minlevel = std::min(cInfo->maxlevel, cInfo->minlevel);
    uint8 maxlevel = std::max(cInfo->maxlevel, cInfo->minlevel);
    uint8 level = minlevel == maxlevel ? minlevel : urand(minlevel, maxlevel);
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

    // TODO: set UNIT_FIELD_POWER*, for some creature class case (energy, etc)

    SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, (float)health);
    SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, (float)mana);

    // damage

    // pussywizard: disabled until it's fixed
    /*float basedamage = stats->GenerateBaseDamage(cInfo);

    float weaponBaseMinDamage = basedamage;
    float weaponBaseMaxDamage = basedamage * 1.5;

    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, weaponBaseMinDamage);
    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, weaponBaseMaxDamage);

    SetBaseWeaponDamage(OFF_ATTACK, MINDAMAGE, weaponBaseMinDamage);
    SetBaseWeaponDamage(OFF_ATTACK, MAXDAMAGE, weaponBaseMaxDamage);

    SetBaseWeaponDamage(RANGED_ATTACK, MINDAMAGE, weaponBaseMinDamage);
    SetBaseWeaponDamage(RANGED_ATTACK, MAXDAMAGE, weaponBaseMaxDamage);

    SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, stats->AttackPower);
    SetModifierValue(UNIT_MOD_ATTACK_POWER_RANGED, BASE_VALUE, stats->RangedAttackPower);*/

    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, cInfo->mindmg);
    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, cInfo->maxdmg);

    SetBaseWeaponDamage(OFF_ATTACK, MINDAMAGE, cInfo->mindmg);
    SetBaseWeaponDamage(OFF_ATTACK, MAXDAMAGE, cInfo->maxdmg);

    SetBaseWeaponDamage(RANGED_ATTACK, MINDAMAGE, cInfo->minrangedmg);
    SetBaseWeaponDamage(RANGED_ATTACK, MAXDAMAGE, cInfo->maxrangedmg);

    SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, cInfo->attackpower);
    SetModifierValue(UNIT_MOD_ATTACK_POWER_RANGED, BASE_VALUE, cInfo->rangedattackpower);
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

bool Creature::CreateFromProto(uint32 guidlow, uint32 Entry, uint32 vehId, const CreatureData* data)
{ 
    SetZoneScript();
    if (GetZoneScript() && data)
    {
        Entry = GetZoneScript()->GetCreatureEntry(guidlow, data);
        if (!Entry)
            return false;
    }

    CreatureTemplate const* normalInfo = sObjectMgr->GetCreatureTemplate(Entry);
    if (!normalInfo)
    {
        sLog->outErrorDb("Creature::CreateFromProto(): creature template (guidlow: %u, entry: %u) does not exist.", guidlow, Entry);
        return false;
    }

    SetOriginalEntry(Entry);

    Object::_Create(guidlow, Entry, (vehId || normalInfo->VehicleId) ? HIGHGUID_VEHICLE : HIGHGUID_UNIT);

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

bool Creature::LoadCreatureFromDB(uint32 guid, Map* map, bool addToMap, bool gridLoad)
{ 
    CreatureData const* data = sObjectMgr->GetCreatureData(guid);

    if (!data)
    {
        sLog->outErrorDb("Creature (GUID: %u) not found in table `creature`, can't load. ", guid);
        return false;
    }

    // xinef: fix shitness from db
    if ((addToMap || gridLoad) && !data->overwrittenZ)
    {
        float tz = map->GetHeight(data->posX, data->posY, data->posZ+1.0f, true);
        if (tz >= data->posZ && tz - data->posZ <= 1.0f)
            const_cast<CreatureData*>(data)->posZ = tz+0.1f;

        const_cast<CreatureData*>(data)->overwrittenZ = true;
    }

    // xinef: this has to be assigned before Create function, properly loads equipment id from DB
    m_creatureData = data;
    m_DBTableGuid = guid;

    if (map->GetInstanceId() == 0)
    {
        if (map->GetCreature(MAKE_NEW_GUID(guid, data->id, HIGHGUID_UNIT)))
            return false;
    }
    else
        guid = sObjectMgr->GenerateLowGuid(HIGHGUID_UNIT);

    if (!Create(guid, map, data->phaseMask, data->id, 0, data->posX, data->posY, data->posZ, data->orientation, data))
        return false;

    //We should set first home position, because then AI calls home movement
    SetHomePosition(data->posX, data->posY, data->posZ, data->orientation);

    m_respawnradius = data->spawndist;

    m_respawnDelay = data->spawntimesecs;
    m_deathState = ALIVE;

    m_respawnTime  = GetMap()->GetCreatureRespawnTime(m_DBTableGuid);
    if (m_respawnTime)                          // respawn on Update
    {
        m_deathState = DEAD;
        if (CanFly())
        {
            float tz = map->GetHeight(GetPhaseMask(), data->posX, data->posY, data->posZ, false);
            if (data->posZ - tz > 0.1f)
                Relocate(data->posX, data->posY, tz);
        }
    }

    uint32 curhealth;

    if (!m_regenHealth)
    {
        curhealth = data->curhealth;
        if (curhealth)
        {
            curhealth = uint32(curhealth*_GetHealthMod(GetCreatureTemplate()->rank));
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

    SetHealth(m_deathState == ALIVE ? curhealth : 0);

    // checked at creature_template loading
    m_defaultMovementType = MovementGeneratorType(data->movementType);

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
    if (!m_DBTableGuid)
    {
        sLog->outError("Trying to delete not saved creature! LowGUID: %u, Entry: %u", GetGUIDLow(), GetEntry());
        return;
    }

    GetMap()->RemoveCreatureRespawnTime(m_DBTableGuid);
    sObjectMgr->DeleteCreatureData(m_DBTableGuid);

    SQLTransaction trans = WorldDatabase.BeginTransaction();

    PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_CREATURE);
    stmt->setUInt32(0, m_DBTableGuid);
    trans->Append(stmt);

    stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_CREATURE_ADDON);
    stmt->setUInt32(0, m_DBTableGuid);
    trans->Append(stmt);

    stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_GAME_EVENT_CREATURE);
    stmt->setUInt32(0, m_DBTableGuid);
    trans->Append(stmt);

    stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_GAME_EVENT_MODEL_EQUIP);
    stmt->setUInt32(0, m_DBTableGuid);
    trans->Append(stmt);

    WorldDatabase.CommitTransaction(trans);
}

bool Creature::IsInvisibleDueToDespawn() const
{ 
    if (Unit::IsInvisibleDueToDespawn())
        return true;

    if (IsAlive() || m_corpseRemoveTime > time(NULL))
        return false;

    return true;
}

bool Creature::CanAlwaysSee(WorldObject const* obj) const
{ 
    if (IsAIEnabled && AI()->CanSeeAlways(obj))
        return true;

    return false;
}

bool Creature::CanStartAttack(Unit const* who) const
{ 
    if (IsCivilian())
        return false;

    // This set of checks is should be done only for creatures
    if ((HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC) && who->GetTypeId() != TYPEID_PLAYER) ||      // flag is valid only for non player characters 
        (HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC) && who->GetTypeId() == TYPEID_PLAYER))         // immune to PC and target is a player, return false
        return false;

    if (Unit* owner = who->GetOwner())
        if (owner->GetTypeId() == TYPEID_PLAYER && HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC))     // immune to PC and target has player owner
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
    if (who->IsInCombat() && IsWithinDist(who, ATTACK_DISTANCE))
        if (Unit* victim = who->getAttackerForHelper())
            if (IsWithinDistInMap(victim, sWorld->getFloatConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_RADIUS)))
                assist = true;

    if (!assist)
        if (IsNeutralToAll() || !IsWithinDistInMap(who, GetAggroRange(who) + m_CombatDistance)) // pussywizard: +m_combatDistance for turrets and similar
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

    if (s == JUST_DIED)
    {
        m_corpseRemoveTime = time(NULL) + m_corpseDelay;
        m_respawnTime = time(NULL) + m_respawnDelay + m_corpseDelay;

        // always save boss respawn time at death to prevent crash cheating
        if (GetMap()->IsDungeon() || isWorldBoss() || GetCreatureTemplate()->rank >= CREATURE_ELITE_ELITE)
            SaveRespawnTime();

        SetTarget(0);                // remove target selection in any cases (can be set at aura remove in Unit::setDeathState)
        SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);

        SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0); // if creature is mounted on a virtual mount, remove it at death

        setActive(false);

        if (!IsPet() && GetCreatureTemplate()->SkinLootId)
            if (LootTemplates_Skinning.HaveLootFor(GetCreatureTemplate()->SkinLootId))
                if (hasLootRecipient())
                    SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);

        if (HasSearchedAssistance())
        {
            SetNoSearchAssistance(false);
            UpdateSpeed(MOVE_RUN, false);
        }

        //Dismiss group if is leader
        if (m_formation && m_formation->getLeader() == this)
            m_formation->FormationReset(true);

        if (!despawn && (CanFly() || IsFlying()) && !HasUnitMovementFlag(MOVEMENTFLAG_SWIMMING)) // pussywizard: added MOVEMENTFLAG_SWIMMING check because IsFlying() returns true when swimming creatures have MOVEMENTFLAG_DISABLE_GRAVITY
            GetMotionMaster()->MoveFall(0, true);

        Unit::setDeathState(CORPSE, despawn);
    }
    else if (s == JUST_RESPAWNED)
    {
        //if (IsPet())
        //    setActive(true);
        SetFullHealth();
        SetLootRecipient(NULL);
        ResetPlayerDamageReq();
        CreatureTemplate const* cinfo = GetCreatureTemplate();
        // Xinef: npc run by default
        //SetWalk(true);

        // pussywizard:
        if (HasUnitMovementFlag(MOVEMENTFLAG_FALLING))
            RemoveUnitMovementFlag(MOVEMENTFLAG_FALLING);
        UpdateEnvironmentIfNeeded(3);

        SetUInt32Value(UNIT_NPC_FLAGS, cinfo->npcflag);
        ClearUnitState(uint32(UNIT_STATE_ALL_STATE & ~(UNIT_STATE_IGNORE_PATHFINDING | UNIT_STATE_NO_ENVIRONMENT_UPD)));
        SetMeleeDamageSchool(SpellSchools(cinfo->dmgschool));
        
        Unit::setDeathState(ALIVE, despawn);

        // Xinef: Load auras AFTER setting alive state
        LoadCreaturesAddon(true);
        Motion_Initialize();
        if (GetCreatureData() && GetPhaseMask() != GetCreatureData()->phaseMask)
            SetPhaseMask(GetCreatureData()->phaseMask, false);
    }
}

void Creature::Respawn(bool force)
{ 
    //DestroyForNearbyPlayers(); // pussywizard: not needed

    if (force)
    {
        if (IsAlive())
            setDeathState(JUST_DIED);
        else if (getDeathState() != CORPSE)
            setDeathState(CORPSE);
    }

    RemoveCorpse(false, false);

    if (getDeathState() == DEAD)
    {
        if (m_DBTableGuid)
            GetMap()->RemoveCreatureRespawnTime(m_DBTableGuid);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Respawning creature %s (GuidLow: %u, Full GUID: " UI64FMTD " Entry: %u)", GetName().c_str(), GetGUIDLow(), GetGUID(), GetEntry());
#endif
        m_respawnTime = 0;
        ResetPickPocketLootTime();

        if (m_originalEntry != GetEntry())
            UpdateEntry(m_originalEntry);

        SelectLevel();

        setDeathState(JUST_RESPAWNED);

        uint32 displayID = GetNativeDisplayId();
        CreatureModelInfo const* minfo = sObjectMgr->GetCreatureModelRandomGender(&displayID);
        if (minfo)                                             // Cancel load if no model defined
        {
            SetDisplayId(displayID);
            SetNativeDisplayId(displayID);
            SetByteValue(UNIT_FIELD_BYTES_0, 2, minfo->gender);
        }

        GetMotionMaster()->InitDefault();

        //Call AI respawn virtual function
        if (IsAIEnabled)
        {
            //reset the AI to be sure no dirty or uninitialized values will be used till next tick
            AI()->Reset();
            TriggerJustRespawned = true;//delay event to next tick so all creatures are created on the map before processing
        }

        uint32 poolid = GetDBTableGUIDLow() ? sPoolMgr->IsPartOfAPool<Creature>(GetDBTableGUIDLow()) : 0;
        if (poolid)
            sPoolMgr->UpdatePool<Creature>(poolid, GetDBTableGUIDLow());

        //Re-initialize reactstate that could be altered by movementgenerators
        InitializeReactState();
    }

    // xinef: relocate notifier, fixes npc appearing in corpse position after forced respawn (instead of spawn)
    m_last_notify_position.Relocate(-5000.0f, -5000.0f, -5000.0f, 0.0f);
    UpdateObjectVisibility(false);
}

void Creature::ForcedDespawn(uint32 timeMSToDespawn)
{ 
    if (timeMSToDespawn)
    {
        ForcedDespawnDelayEvent* pEvent = new ForcedDespawnDelayEvent(*this);

        m_Events.AddEvent(pEvent, m_Events.CalculateTime(timeMSToDespawn));
        return;
    }

    if (IsAlive())
        setDeathState(JUST_DIED, true);

    // Xinef: set new respawn time, ignore corpse decay time...
    RemoveCorpse(true);
}

void Creature::DespawnOrUnsummon(uint32 msTimeToDespawn /*= 0*/)
{ 
    if (TempSummon* summon = this->ToTempSummon())
        summon->UnSummon(msTimeToDespawn);
    else
        ForcedDespawn(msTimeToDespawn);
}

void Creature::InitializeReactState()
{
    if ((IsTotem() || IsTrigger() || IsCritter() || IsSpiritService()) && GetAIName() != "SmartAI" && !GetScriptId())
        SetReactState(REACT_PASSIVE);
    else
        SetReactState(REACT_AGGRESSIVE);
    /*else if (IsCivilian())
    SetReactState(REACT_DEFENSIVE);*/;
}

bool Creature::HasMechanicTemplateImmunity(uint32 mask) const
{ 
    return !IS_PLAYER_GUID(GetOwnerGUID()) && (GetCreatureTemplate()->MechanicImmuneMask & mask);
}

bool Creature::IsImmunedToSpell(SpellInfo const* spellInfo)
{
    if (!spellInfo)
        return false;

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

    return Unit::IsImmunedToSpell(spellInfo);
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
        return NULL;

    for (uint32 i=0; i < CREATURE_MAX_SPELLS; ++i)
    {
        if (!m_spells[i])
            continue;
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(m_spells[i]);
        if (!spellInfo)
        {
            sLog->outError("WORLD: unknown spell id %i", m_spells[i]);
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
        if (spellInfo->PreventionType == SPELL_PREVENTION_TYPE_SILENCE && HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED))
            continue;
        if (spellInfo->PreventionType == SPELL_PREVENTION_TYPE_PACIFY && HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED))
            continue;
        return spellInfo;
    }
    return NULL;
}

SpellInfo const* Creature::reachWithSpellCure(Unit* victim)
{ 
    if (!victim)
        return NULL;

    for (uint32 i=0; i < CREATURE_MAX_SPELLS; ++i)
    {
        if (!m_spells[i])
            continue;
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(m_spells[i]);
        if (!spellInfo)
        {
            sLog->outError("WORLD: unknown spell id %i", m_spells[i]);
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
        if (spellInfo->PreventionType == SPELL_PREVENTION_TYPE_SILENCE && HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED))
            continue;
        if (spellInfo->PreventionType == SPELL_PREVENTION_TYPE_PACIFY && HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED))
            continue;
        return spellInfo;
    }
    return NULL;
}

// select nearest hostile unit within the given distance (regardless of threat list).
Unit* Creature::SelectNearestTarget(float dist, bool playerOnly /* = false */) const
{ 
    CellCoord p(Trinity::ComputeCellCoord(GetPositionX(), GetPositionY()));
    Cell cell(p);
    cell.SetNoCreate();

    Unit* target = NULL;

    {
        if (dist == 0.0f)
            dist = MAX_SEARCHER_DISTANCE;

        Trinity::NearestHostileUnitCheck u_check(this, dist, playerOnly);
        Trinity::UnitLastSearcher<Trinity::NearestHostileUnitCheck> searcher(this, target, u_check);

        TypeContainerVisitor<Trinity::UnitLastSearcher<Trinity::NearestHostileUnitCheck>, WorldTypeMapContainer > world_unit_searcher(searcher);
        TypeContainerVisitor<Trinity::UnitLastSearcher<Trinity::NearestHostileUnitCheck>, GridTypeMapContainer >  grid_unit_searcher(searcher);

        cell.Visit(p, world_unit_searcher, *GetMap(), *this, dist);
        cell.Visit(p, grid_unit_searcher, *GetMap(), *this, dist);
    }

    return target;
}

// select nearest hostile unit within the given attack distance (i.e. distance is ignored if > than ATTACK_DISTANCE), regardless of threat list.
Unit* Creature::SelectNearestTargetInAttackDistance(float dist) const
{ 
    CellCoord p(Trinity::ComputeCellCoord(GetPositionX(), GetPositionY()));
    Cell cell(p);
    cell.SetNoCreate();

    Unit* target = NULL;

    if (dist < ATTACK_DISTANCE)
        dist = ATTACK_DISTANCE;
    if (dist > MAX_SEARCHER_DISTANCE)
        dist = MAX_SEARCHER_DISTANCE;

    {
        Trinity::NearestHostileUnitInAttackDistanceCheck u_check(this, dist);
        Trinity::UnitLastSearcher<Trinity::NearestHostileUnitInAttackDistanceCheck> searcher(this, target, u_check);

        TypeContainerVisitor<Trinity::UnitLastSearcher<Trinity::NearestHostileUnitInAttackDistanceCheck>, WorldTypeMapContainer > world_unit_searcher(searcher);
        TypeContainerVisitor<Trinity::UnitLastSearcher<Trinity::NearestHostileUnitInAttackDistanceCheck>, GridTypeMapContainer >  grid_unit_searcher(searcher);

        cell.Visit(p, world_unit_searcher, *GetMap(), *this, dist);
        cell.Visit(p, grid_unit_searcher, *GetMap(), *this, dist);
    }

    return target;
}

void Creature::SendAIReaction(AiReaction reactionType)
{ 
    WorldPacket data(SMSG_AI_REACTION, 12);

    data << uint64(GetGUID());
    data << uint32(reactionType);

    ((WorldObject*)this)->SendMessageToSet(&data, true);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_AI_REACTION, type %u.", reactionType);
#endif
}

void Creature::CallAssistance()
{ 
    if (!m_AlreadyCallAssistance && GetVictim() && !IsPet() && !IsCharmed())
    {
        SetNoCallAssistance(true);

        float radius = sWorld->getFloatConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_RADIUS);

        if (radius > 0)
        {
            std::list<Creature*> assistList;

            {
                CellCoord p(Trinity::ComputeCellCoord(GetPositionX(), GetPositionY()));
                Cell cell(p);
                cell.SetNoCreate();

                Trinity::AnyAssistCreatureInRangeCheck u_check(this, GetVictim(), radius);
                Trinity::CreatureListSearcher<Trinity::AnyAssistCreatureInRangeCheck> searcher(this, assistList, u_check);

                TypeContainerVisitor<Trinity::CreatureListSearcher<Trinity::AnyAssistCreatureInRangeCheck>, GridTypeMapContainer >  grid_creature_searcher(searcher);

                cell.Visit(p, grid_creature_searcher, *GetMap(), *this, radius);
            }

            if (!assistList.empty())
            {
                AssistDelayEvent* e = new AssistDelayEvent(GetVictim()->GetGUID(), *this);
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

void Creature::CallForHelp(float radius)
{
    if (radius <= 0.0f || !GetVictim() || IsPet() || IsCharmed())
        return;

    CellCoord p(Trinity::ComputeCellCoord(GetPositionX(), GetPositionY()));
    Cell cell(p);
    cell.SetNoCreate();

    Trinity::CallOfHelpCreatureInRangeDo u_do(this, GetVictim(), radius);
    Trinity::CreatureWorker<Trinity::CallOfHelpCreatureInRangeDo> worker(this, u_do);

    TypeContainerVisitor<Trinity::CreatureWorker<Trinity::CallOfHelpCreatureInRangeDo>, GridTypeMapContainer >  grid_creature_searcher(worker);

    cell.Visit(p, grid_creature_searcher, *GetMap(), *this, radius);
}

bool Creature::CanAssistTo(const Unit* u, const Unit* enemy, bool checkfaction /*= true*/) const
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
    if (enemy->GetTypeId() == TYPEID_UNIT && enemy->ToCreature()->IsInEvadeMode())
        return false;

    // we don't need help from non-combatant ;)
    if (IsCivilian())
        return false;

    if (HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_NPC))
        return false;

    // skip fighting creature
    if (IsInCombat())
        return false;

    // only free creature
    if (GetCharmerOrOwnerGUID())
        return false;

    // only from same creature faction
    if (checkfaction)
    {
        if (getFaction() != u->getFaction())
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

    return true;
}

// use this function to avoid having hostile creatures attack
// friendlies and other mobs they shouldn't attack
bool Creature::_IsTargetAcceptable(const Unit* target) const
{ 
    ASSERT(target);

    // if the target cannot be attacked, the target is not acceptable
    if (IsFriendlyTo(target) || !target->isTargetableForAttack(false, this) || (m_vehicle && (IsOnVehicle(target) || m_vehicle->GetBase()->IsOnVehicle(target))))
        return false;

    if (target->HasUnitState(UNIT_STATE_DIED))
    {
        // guards can detect fake death
        if (IsGuard() && target->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH))
            return true;
        else
            return false;
    }

    const Unit* myVictim = getAttackerForHelper();
    const Unit* targetVictim = target->getAttackerForHelper();

    // if I'm already fighting target, or I'm hostile towards the target, the target is acceptable
    if (myVictim == target || targetVictim == this || IsHostileTo(target))
        return true;

    // if the target's victim is friendly, and the target is neutral, the target is acceptable
    if (targetVictim && !IsNeutralToAll() && IsFriendlyTo(targetVictim))
        return true;

    // if the target's victim is not friendly, or the target is friendly, the target is not acceptable
    return false;
}

bool Creature::_CanDetectFeignDeathOf(const Unit* target) const
{ 
    if (target->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH))
        return IsGuard();
    return true;
}

void Creature::UpdateMoveInLineOfSightState()
{ 
    // xinef: pets, guardians and units with scripts / smartAI should be skipped
    if (IsPet() || HasUnitTypeMask(UNIT_MASK_MINION|UNIT_MASK_SUMMON|UNIT_MASK_GUARDIAN|UNIT_MASK_CONTROLABLE_GUARDIAN) ||
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
    if (FactionTemplateEntry const* factionTemplate = sFactionTemplateStore.LookupEntry(getFaction()))
        if (factionTemplate->hostileMask || factionTemplate->enemyFaction[0] || factionTemplate->enemyFaction[1] || factionTemplate->enemyFaction[2] || factionTemplate->enemyFaction[3])
            nonHostile = false;

    if (nonHostile)
        m_moveInLineOfSightDisabled = true;
    else
        m_moveInLineOfSightDisabled = false;
}

void Creature::SaveRespawnTime()
{ 
    if (IsSummon() || !GetDBTableGUIDLow() || (m_creatureData && !m_creatureData->dbData))
        return;

    GetMap()->SaveCreatureRespawnTime(GetDBTableGUIDLow(), m_respawnTime);
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

    if (!IS_PLAYER_GUID(GetCharmerOrOwnerGUID()))
    {
        if (GetMap()->IsDungeon())
            return true;

        // pussywizard: don't check distance to home position if recently damaged (allow kiting away from spawnpoint!)
        // xinef: this should include taunt auras
        if (!isWorldBoss() && (GetLastDamagedTime() > sWorld->GetGameTime() || HasAuraType(SPELL_AURA_MOD_TAUNT)))
            return true;
    }

    if (skipDistCheck)
        return true;

    // xinef: added size factor for huge npcs
    float dist = std::min<float>(GetMap()->GetVisibilityRange() + GetObjectSize()*2, 150.0f);

    if (Unit* unit = GetCharmerOrOwner())
        return victim->IsWithinDist(unit, dist);
    else
    {
        // to prevent creatures in air ignore attacks because distance is already too high...
        if (GetCreatureTemplate()->InhabitType & INHABIT_AIR)
            return victim->IsInDist2d(&m_homePosition, dist);
        else
            return victim->IsInDist(&m_homePosition, dist);
    }
}

CreatureAddon const* Creature::GetCreatureAddon() const
{ 
    if (m_DBTableGuid)
    {
        if (CreatureAddon const* addon = sObjectMgr->GetCreatureAddon(m_DBTableGuid))
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

        SetByteValue(UNIT_FIELD_BYTES_1, 0, uint8(cainfo->bytes1 & 0xFF));
        //SetByteValue(UNIT_FIELD_BYTES_1, 1, uint8((cainfo->bytes1 >> 8) & 0xFF));
        SetByteValue(UNIT_FIELD_BYTES_1, 1, 0);
        SetByteValue(UNIT_FIELD_BYTES_1, 2, uint8((cainfo->bytes1 >> 16) & 0xFF));
        SetByteValue(UNIT_FIELD_BYTES_1, 3, uint8((cainfo->bytes1 >> 24) & 0xFF));

        //! Suspected correlation between UNIT_FIELD_BYTES_1, offset 3, value 0x2:
        //! If no inhabittype_fly (if no MovementFlag_DisableGravity or MovementFlag_CanFly flag found in sniffs)
        //! Check using InhabitType as movement flags are assigned dynamically
        //! basing on whether the creature is in air or not
        //! Set MovementFlag_Hover. Otherwise do nothing.
        if (GetByteValue(UNIT_FIELD_BYTES_1, 3) & UNIT_BYTE1_FLAG_HOVER /*&& !(GetCreatureTemplate()->InhabitType & INHABIT_AIR)*/)
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

    if (cainfo->emote != 0)
        SetUInt32Value(UNIT_NPC_EMOTESTATE, cainfo->emote);

    //Load Path
    if (cainfo->path_id != 0)
        m_path_id = cainfo->path_id;

    if (!cainfo->auras.empty())
    {
        for (std::vector<uint32>::const_iterator itr = cainfo->auras.begin(); itr != cainfo->auras.end(); ++itr)
        {
            SpellInfo const* AdditionalSpellInfo = sSpellMgr->GetSpellInfo(*itr);
            if (!AdditionalSpellInfo)
            {
                sLog->outErrorDb("Creature (GUID: %u Entry: %u) has wrong spell %u defined in `auras` field.", GetGUIDLow(), GetEntry(), *itr);
                continue;
            }

            // skip already applied aura
            if (HasAura(*itr))
            {
                if (!reload)
                    sLog->outErrorDb("Creature (GUID: %u Entry: %u) has duplicate aura (spell %u) in `auras` field.", GetGUIDLow(), GetEntry(), *itr);

                continue;
            }

            AddAura(*itr, this);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_UNITS, "Spell: %u added to creature (GUID: %u Entry: %u)", *itr, GetGUIDLow(), GetEntry());
#endif
        }
    }

    return true;
}

/// Send a message to LocalDefense channel for players opposition team in the zone
void Creature::SendZoneUnderAttackMessage(Player* attacker)
{ 
    WorldPacket data(SMSG_ZONE_UNDER_ATTACK, 4);
    data << (uint32)GetAreaId();
    sWorld->SendGlobalMessage(&data, NULL, (attacker->GetTeamId() == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE));
}

void Creature::SetInCombatWithZone()
{ 
    if (!CanHaveThreatList())
    {
        sLog->outError("Creature entry %u call SetInCombatWithZone but creature cannot have threat list.", GetEntry());
        return;
    }

    Map* map = GetMap();

    if (!map->IsDungeon())
    {
        sLog->outError("Creature entry %u call SetInCombatWithZone for map (id: %u) that isn't an instance.", GetEntry(), map->GetId());
        return;
    }

    Map::PlayerList const &PlList = map->GetPlayers();

    if (PlList.isEmpty())
        return;

    for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
    {
        if (Player* player = i->GetSource())
        {
            if (player->IsGameMaster())
                continue;

            if (player->IsAlive())
            {
                this->SetInCombatWith(player);
                player->SetInCombatWith(this);
                AddThreat(player, 0.0f);
            }
        }
    }
}

void Creature::ProhibitSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs)
{
    for (uint8 i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; ++i)
        if (idSchoolMask & (1 << i))
            m_ProhibitSchoolTime[i] = World::GetGameTimeMS() + unTimeMs;
}

bool Creature::IsSpellProhibited(SpellSchoolMask idSchoolMask) const
{ 
    const CreatureTemplate* cinfo = GetCreatureTemplate();
    if (!(cinfo && cinfo->flags_extra & CREATURE_FLAG_EXTRA_ALL_DIMINISH) && (isWorldBoss() || IsDungeonBoss()))
        return false;

    for (uint8 i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; ++i)
        if (idSchoolMask & (1 << i))
            if (m_ProhibitSchoolTime[i] >= World::GetGameTimeMS())
                return true;

    return false;
}

void Creature::_AddCreatureSpellCooldown(uint32 spell_id, uint32 end_time)
{ 
    m_CreatureSpellCooldowns[spell_id] = World::GetGameTimeMS()+end_time;
}

void Creature::AddSpellCooldown(uint32 spell_id, uint32 /*itemid*/, uint32 end_time, bool /*needSendToClient*/, bool /*forceSendToSpectator*/)
{ 
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell_id);
    if (!spellInfo)
        return;

    // used in proc system, otherwise normal creature cooldown
    if (end_time)
    {
        _AddCreatureSpellCooldown(spellInfo->Id, end_time);
        return;
    }

    uint32 spellcooldown = spellInfo->RecoveryTime;
    uint32 categorycooldown = spellInfo->CategoryRecoveryTime;
    if(Player* modOwner = GetSpellModOwner())
    {
        modOwner->ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, spellcooldown);
        modOwner->ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, categorycooldown);
    }

    if (spellcooldown)
        _AddCreatureSpellCooldown(spellInfo->Id, spellcooldown);

    if (categorycooldown)
        if (spellInfo->GetCategory())
        {
            SpellCategoryStore::const_iterator i_scstore = sSpellsByCategoryStore.find(spellInfo->GetCategory());
            if (i_scstore != sSpellsByCategoryStore.end())
            {
                uint32 cattime = categorycooldown;
                for (SpellCategorySet::const_iterator i_scset = i_scstore->second.begin(); i_scset != i_scstore->second.end(); ++i_scset)
                    if (GetSpellCooldown(*i_scset) < cattime)
                        _AddCreatureSpellCooldown(*i_scset, cattime);
            }
        }
}

uint32 Creature::GetSpellCooldown(uint32 spell_id) const
{ 
    CreatureSpellCooldowns::const_iterator itr = m_CreatureSpellCooldowns.find(spell_id);
    if (itr == m_CreatureSpellCooldowns.end())
        return 0;
    
    return itr->second > World::GetGameTimeMS() ? itr->second - World::GetGameTimeMS() : 0;
}

bool Creature::HasSpellCooldown(uint32 spell_id) const
{ 
    CreatureSpellCooldowns::const_iterator itr = m_CreatureSpellCooldowns.find(spell_id);
    return (itr != m_CreatureSpellCooldowns.end() && itr->second > World::GetGameTimeMS());
}

bool Creature::HasSpell(uint32 spellID) const
{ 
    uint8 i;
    for (i = 0; i < CREATURE_MAX_SPELLS; ++i)
        if (spellID == m_spells[i])
            break;
    return i < CREATURE_MAX_SPELLS;                         //broke before end of iteration of known spells
}

time_t Creature::GetRespawnTimeEx() const
{ 
    time_t now = time(NULL);
    if (m_respawnTime > now)
        return m_respawnTime;
    else
        return now;
}

void Creature::GetRespawnPosition(float &x, float &y, float &z, float* ori, float* dist) const
{ 
    if (m_DBTableGuid)
    {
        if (CreatureData const* data = sObjectMgr->GetCreatureData(GetDBTableGUIDLow()))
        {
            x = data->posX;
            y = data->posY;
            z = data->posZ;
            if (ori)
                *ori = data->orientation;
            if (dist)
                *dist = data->spawndist;

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

void Creature::AllLootRemovedFromCorpse()
{ 
    if (!HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE))
    {
        time_t now = time(NULL);
        if (m_corpseRemoveTime <= now)
            return;

        float decayRate;
        CreatureTemplate const* cinfo = GetCreatureTemplate();

        decayRate = sWorld->getRate(RATE_CORPSE_DECAY_LOOTED);
        uint32 diff = uint32((m_corpseRemoveTime - now) * decayRate);

        m_respawnTime -= diff;

        // corpse skinnable, but without skinning flag, and then skinned, corpse will despawn next update
        if (cinfo && cinfo->SkinLootId)
            m_corpseRemoveTime = time(NULL);
        else
            m_corpseRemoveTime -= diff;
    }
}

uint8 Creature::getLevelForTarget(WorldObject const* target) const
{ 
    if (!isWorldBoss() || !target->ToUnit())
        return Unit::getLevelForTarget(target);

    uint16 level = target->ToUnit()->getLevel() + sWorld->getIntConfig(CONFIG_WORLD_BOSS_LEVEL_DIFF);
    if (level < 1)
        return 1;
    if (level > 255)
        return 255;
    return uint8(level);
}

std::string Creature::GetAIName() const
{ 
    return sObjectMgr->GetCreatureTemplate(GetEntry())->AIName;
}

std::string Creature::GetScriptName() const
{ 
    return sObjectMgr->GetScriptName(GetScriptId());
}

uint32 Creature::GetScriptId() const
{ 
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

    time_t ptime = time(NULL);

    if (time_t(vCount->lastIncrementTime + vItem->incrtime) <= ptime)
    {
        ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(vItem->item);

        uint32 diff = uint32((ptime - vCount->lastIncrementTime)/vItem->incrtime);
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
        uint32 new_count = vItem->maxcount > used_count ? vItem->maxcount-used_count : 0;
        m_vendorItemCounts.push_back(VendorItemCount(vItem->item, new_count));
        return new_count;
    }

    VendorItemCount* vCount = &*itr;

    time_t ptime = time(NULL);

    if (time_t(vCount->lastIncrementTime + vItem->incrtime) <= ptime)
    {
        ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(vItem->item);

        uint32 diff = uint32((ptime - vCount->lastIncrementTime)/vItem->incrtime);
        if ((vCount->count + diff * pProto->BuyCount) < vItem->maxcount)
            vCount->count += diff * pProto->BuyCount;
        else
            vCount->count = vItem->maxcount;
    }

    vCount->count = vCount->count > used_count ? vCount->count-used_count : 0;
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
    if (!Trinity::IsValidMapCoord(x, y, z, o))
        return;

    GetMap()->CreatureRelocation(this, x, y, z, o);
}

bool Creature::IsDungeonBoss() const
{ 
    if (IS_PLAYER_GUID(GetOwnerGUID()))
        return false;

    CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(GetEntry());
    return cinfo && (cinfo->flags_extra & CREATURE_FLAG_EXTRA_DUNGEON_BOSS);
}

bool Creature::IsImmuneToKnockback() const
{ 
    if (IS_PLAYER_GUID(GetOwnerGUID()))
        return false;

    CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(GetEntry());
    return cinfo && (cinfo->flags_extra & CREATURE_FLAG_EXTRA_KNOCKBACK_IMMUNE);
}

bool Creature::SetWalk(bool enable)
{ 
    if (!Unit::SetWalk(enable))
        return false;

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_SET_WALK_MODE : SMSG_SPLINE_MOVE_SET_RUN_MODE, 9);
    data.append(GetPackGUID());
    SendMessageToSet(&data, false);
    return true;
}

bool Creature::SetDisableGravity(bool disable, bool packetOnly/*=false*/)
{ 
    //! It's possible only a packet is sent but moveflags are not updated
    //! Need more research on this
    if (!packetOnly && !Unit::SetDisableGravity(disable))
        return false;

    if (!movespline->Initialized())
        return true;

    // pussywizard: artificial disable_gravity to hovering npcs, don't send!
    if (!disable && GetHoverHeight() >= 2.0f)
        return true;

    WorldPacket data(disable ? SMSG_SPLINE_MOVE_GRAVITY_DISABLE : SMSG_SPLINE_MOVE_GRAVITY_ENABLE, 9);
    data.append(GetPackGUID());
    SendMessageToSet(&data, false);
    return true;
}

bool Creature::SetSwim(bool enable)
{ 
    if (!Unit::SetSwim(enable))
        return false;

    if (!movespline->Initialized())
        return true;

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_START_SWIM : SMSG_SPLINE_MOVE_STOP_SWIM);
    data.append(GetPackGUID());
    SendMessageToSet(&data, true);
    return true;
}

bool Creature::SetCanFly(bool enable, bool  /*packetOnly*/ /* = false */)
{
    if (!Unit::SetCanFly(enable))
        return false;

    if (!movespline->Initialized())
        return true;

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_SET_FLYING : SMSG_SPLINE_MOVE_UNSET_FLYING, 9);
    data.append(GetPackGUID());
    SendMessageToSet(&data, false);
    return true;
}

bool Creature::SetWaterWalking(bool enable, bool packetOnly /* = false */)
{ 
    if (!packetOnly && !Unit::SetWaterWalking(enable))
        return false;

    if (!movespline->Initialized())
        return true;

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_WATER_WALK : SMSG_SPLINE_MOVE_LAND_WALK, 9);
    data.append(GetPackGUID());
    SendMessageToSet(&data, true);
    return true;
}

bool Creature::SetFeatherFall(bool enable, bool packetOnly /* = false */)
{ 
    if (!packetOnly && !Unit::SetFeatherFall(enable))
        return false;

    if (!movespline->Initialized())
        return true;

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_FEATHER_FALL : SMSG_SPLINE_MOVE_NORMAL_FALL, 9);
    data.append(GetPackGUID());
    SendMessageToSet(&data, true);
    return true;
}

bool Creature::SetHover(bool enable, bool packetOnly /*= false*/)
{ 
    if (!packetOnly && !Unit::SetHover(enable))
        return false;

    //! Unconfirmed for players:
    if (enable)
        SetByteFlag(UNIT_FIELD_BYTES_1, 3, UNIT_BYTE1_FLAG_HOVER);
    else
        RemoveByteFlag(UNIT_FIELD_BYTES_1, 3, UNIT_BYTE1_FLAG_HOVER);

    if (!movespline->Initialized())
        return true;

    //! Not always a packet is sent
    WorldPacket data(enable ? SMSG_SPLINE_MOVE_SET_HOVER : SMSG_SPLINE_MOVE_UNSET_HOVER, 9);
    data.append(GetPackGUID());
    SendMessageToSet(&data, false);
    return true;
}

float Creature::GetAggroRange(Unit const* target) const
{ 
    // Determines the aggro range for creatures
    // Based on data from wowwiki due to lack of 3.3.5a data

    uint32 targetLevel = target->getLevelForTarget(this);
    uint32 myLevel = getLevelForTarget(target);
    int32 levelDiff = int32(targetLevel) - int32(myLevel);
    
    // The maximum Aggro Radius is capped at 45 yards (25 level difference)
    if (levelDiff < -25)
        levelDiff = -25;

    // The base aggro radius for mob of same level
    float aggroRadius = 20.0f;

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

    return aggroRadius;
}

void Creature::SetObjectScale(float scale)
{ 
    Unit::SetObjectScale(scale);

    if (CreatureModelInfo const* minfo = sObjectMgr->GetCreatureModelInfo(GetDisplayId()))
    {
        SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, (IsPet() ? 1.0f : minfo->bounding_radius) * scale);
        SetFloatValue(UNIT_FIELD_COMBATREACH, (IsPet() ? DEFAULT_COMBAT_REACH : minfo->combat_reach) * scale);
    }
}

void Creature::SetDisplayId(uint32 modelId)
{ 
    Unit::SetDisplayId(modelId);

    if (CreatureModelInfo const* minfo = sObjectMgr->GetCreatureModelInfo(modelId))
    {
        SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, (IsPet() ? 1.0f : minfo->bounding_radius) * GetFloatValue(OBJECT_FIELD_SCALE_X));
        SetFloatValue(UNIT_FIELD_COMBATREACH, (IsPet() ? DEFAULT_COMBAT_REACH : minfo->combat_reach) * GetFloatValue(OBJECT_FIELD_SCALE_X));
    }
}

void Creature::SetTarget(uint64 guid)
{ 
    if (!_focusSpell)
        SetUInt64Value(UNIT_FIELD_TARGET, guid);
}

void Creature::FocusTarget(Spell const* focusSpell, WorldObject const* target)
{ 
    // already focused
    if (_focusSpell)
        return;

    _focusSpell = focusSpell;
    SetUInt64Value(UNIT_FIELD_TARGET, this == target ? 0 : target->GetGUID());
    if (focusSpell->GetSpellInfo()->HasAttribute(SPELL_ATTR5_DONT_TURN_DURING_CAST))
        AddUnitState(UNIT_STATE_ROTATING);

    // Set serverside orientation if needed (needs to be after attribute check)
    if (this == target && (movespline->Finalized() || GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE))
        SetFacingTo(GetOrientation());
    else
        SetInFront(target);
}

void Creature::ReleaseFocus(Spell const* focusSpell)
{ 
    // focused to something else
    if (focusSpell != _focusSpell)
        return;

    _focusSpell = NULL;
    if (Unit* victim = GetVictim())
        SetUInt64Value(UNIT_FIELD_TARGET, victim->GetGUID());
    else
        SetUInt64Value(UNIT_FIELD_TARGET, 0);

    if (focusSpell->GetSpellInfo()->HasAttribute(SPELL_ATTR5_DONT_TURN_DURING_CAST))
        ClearUnitState(UNIT_STATE_ROTATING);
}
