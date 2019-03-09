/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include <G3D/Quat.h>
#include "GameObjectAI.h"
#include "BattlegroundAV.h"
#include "CellImpl.h"
#include "CreatureAISelector.h"
#include "DisableMgr.h"
#include "DynamicTree.h"
#include "GameObjectModel.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "GroupMgr.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "PoolMgr.h"
#include "ScriptMgr.h"
#include "SpellMgr.h"
#include "UpdateFieldFlags.h"
#include "World.h"
#include "Transport.h"
#include "AccountMgr.h"

#ifdef ELUNA
#include "LuaEngine.h"
#endif

GameObject::GameObject() : WorldObject(false), MovableMapObject(),
    m_model(NULL), m_goValue(), m_AI(NULL)
{
    m_objectType |= TYPEMASK_GAMEOBJECT;
    m_objectTypeId = TYPEID_GAMEOBJECT;

    m_updateFlag = (UPDATEFLAG_LOWGUID | UPDATEFLAG_STATIONARY_POSITION | UPDATEFLAG_POSITION | UPDATEFLAG_ROTATION);

    m_valuesCount = GAMEOBJECT_END;
    m_respawnTime = 0;
    m_respawnDelayTime = 300;
    m_lootState = GO_NOT_READY;
    m_spawnedByDefault = true;
    m_allowModifyDestructibleBuilding = true;
    m_usetimes = 0;
    m_spellId = 0;
    m_cooldownTime = 0;
    m_goInfo = NULL;
    m_ritualOwnerGUIDLow = 0;
    m_goData = NULL;
    m_packedRotation = 0;

    m_DBTableGuid = 0;

    m_lootRecipient = 0;
    m_lootRecipientGroup = 0;
    m_groupLootTimer = 0;
    lootingGroupLowGUID = 0;
    m_lootGenerationTime = 0;

    ResetLootMode(); // restore default loot mode
    m_stationaryPosition.Relocate(0.0f, 0.0f, 0.0f, 0.0f);
}

GameObject::~GameObject()
{
    delete m_AI;
    delete m_model;
    //if (m_uint32Values)                                      // field array can be not exist if GameOBject not loaded
    //    CleanupsBeforeDelete();
}

bool GameObject::AIM_Initialize()
{ 
    if (m_AI)
        delete m_AI;

    m_AI = FactorySelector::SelectGameObjectAI(this);

    if (!m_AI)
        return false;

    m_AI->InitializeAI();
    return true;
}

std::string GameObject::GetAIName() const
{ 
    return sObjectMgr->GetGameObjectTemplate(GetEntry())->AIName;
}

void GameObject::CleanupsBeforeDelete(bool /*finalCleanup*/)
{ 
    if (GetTransport() && !ToTransport())
    {
        GetTransport()->RemovePassenger(this);
        SetTransport(NULL);
        m_movementInfo.transport.Reset();
        m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
    }

    if (IsInWorld())
        RemoveFromWorld();

    if (m_uint32Values)                                      // field array can be not exist if GameOBject not loaded
        RemoveFromOwner();
}

void GameObject::RemoveFromOwner()
{ 
    uint64 ownerGUID = GetOwnerGUID();
    if (!ownerGUID)
        return;

    if (Unit* owner = ObjectAccessor::GetUnit(*this, ownerGUID))
    {
        owner->RemoveGameObject(this, false);
        ASSERT(!GetOwnerGUID());
        return;
    }

    // Xinef: not needed
    /*const char * ownerType = "creature";
    if (IS_PLAYER_GUID(ownerGUID))
        ownerType = "player";
    else if (IS_PET_GUID(ownerGUID))
        ownerType = "pet";

    sLog->outCrash("Delete GameObject (GUID: %u Entry: %u SpellId %u LinkedGO %u) that lost references to owner (GUID %u Type '%s') GO list. Crash possible later.",
        GetGUIDLow(), GetGOInfo()->entry, m_spellId, GetGOInfo()->GetLinkedGameObjectEntry(), GUID_LOPART(ownerGUID), ownerType);*/
    SetOwnerGUID(0);
}

void GameObject::AddToWorld()
{ 
    ///- Register the gameobject for guid lookup
    if (!IsInWorld())
    {
        if (m_zoneScript)
            m_zoneScript->OnGameObjectCreate(this);

        sObjectAccessor->AddObject(this);

        if (m_model)
        {
            m_model->UpdatePosition();
            GetMap()->InsertGameObjectModel(*m_model);
        }

        EnableCollision(GetGoState() == GO_STATE_READY || IsTransport()); // pussywizard: this startOpen is unneeded here, collision depends entirely on GOState

        WorldObject::AddToWorld();
#ifdef ELUNA
        sEluna->OnAddToWorld(this);
#endif
    }
}

void GameObject::RemoveFromWorld()
{ 
    ///- Remove the gameobject from the accessor
    if (IsInWorld())
    {
#ifdef ELUNA
        sEluna->OnRemoveFromWorld(this);
#endif
        if (m_zoneScript)
            m_zoneScript->OnGameObjectRemove(this);

        RemoveFromOwner();
        if (m_model)
            if (GetMap()->ContainsGameObjectModel(*m_model))
                GetMap()->RemoveGameObjectModel(*m_model);
        if (Transport* transport = GetTransport())
            transport->RemovePassenger(this, true);
        WorldObject::RemoveFromWorld();
        sObjectAccessor->RemoveObject(this);
    }
}

void GameObject::CheckRitualList()
{ 
    if (m_unique_users.empty())
        return;
    for (std::set<uint64>::iterator itr = m_unique_users.begin(); itr != m_unique_users.end();)
    {
        if (*itr == GetOwnerGUID())
        {
            ++itr;
            continue;
        }
        bool erase = true;
        if (Player* channeler = ObjectAccessor::GetPlayer(*this, *itr))
            if (Spell* spell = channeler->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
                if (spell->m_spellInfo->Id == GetGOInfo()->summoningRitual.animSpell)
                    erase = false;

        if (erase)
            m_unique_users.erase(itr++);
        else
            ++itr;
    }
}

void GameObject::ClearRitualList()
{ 
    uint32 animSpell = GetGOInfo()->summoningRitual.animSpell;
    if (!animSpell || m_unique_users.empty())
        return;
    for (std::set<uint64>::iterator itr = m_unique_users.begin(); itr != m_unique_users.end(); ++itr)
    {
        if (Player* channeler = ObjectAccessor::GetPlayer(*this, *itr))
            if (Spell* spell = channeler->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
                if (spell->m_spellInfo->Id == animSpell)
                {
                    spell->SendChannelUpdate(0);
                    spell->finish();
                }
    }
    m_unique_users.clear();
}

bool GameObject::Create(uint32 guidlow, uint32 name_id, Map* map, uint32 phaseMask, float x, float y, float z, float ang, G3D::Quat const& rotation, uint32 animprogress, GOState go_state, uint32 artKit)
{ 
    ASSERT(map);
    SetMap(map);

    Relocate(x, y, z, ang);
    m_stationaryPosition.Relocate(x, y, z, ang);
    if (!IsPositionValid())
    {
        sLog->outError("Gameobject (GUID: %u Entry: %u) not created. Suggested coordinates isn't valid (X: %f Y: %f)", guidlow, name_id, x, y);
        return false;
    }

    SetPhaseMask(phaseMask, false);

    SetZoneScript();
    if (m_zoneScript)
    {
        name_id = m_zoneScript->GetGameObjectEntry(guidlow, name_id);
        if (!name_id)
            return false;
    }

    GameObjectTemplate const* goinfo = sObjectMgr->GetGameObjectTemplate(name_id);
    if (!goinfo)
    {
        sLog->outErrorDb("Gameobject (GUID: %u Entry: %u) not created: non-existing entry in `gameobject_template`. Map: %u (X: %f Y: %f Z: %f)", guidlow, name_id, map->GetId(), x, y, z);
        return false;
    }

    Object::_Create(guidlow, goinfo->entry, HIGHGUID_GAMEOBJECT);

    m_goInfo = goinfo;

    if (goinfo->type >= MAX_GAMEOBJECT_TYPE)
    {
        sLog->outErrorDb("Gameobject (GUID: %u Entry: %u) not created: non-existing GO type '%u' in `gameobject_template`. It will crash client if created.", guidlow, name_id, goinfo->type);
        return false;
    }

    GameObjectAddon const* addon = sObjectMgr->GetGameObjectAddon(guidlow);

    // hackfix for the hackfix down below
    switch (goinfo->entry)
    {
        // excluded ids from the hackfix below
        // used switch since there should be more
        case 181233: // maexxna portal effect
        case 181575: // maexxna portal
            SetWorldRotation(rotation);
            break;
        default:
            // xinef: hackfix - but make it possible to use original WorldRotation (using special gameobject addon data) 
            // pussywizard: temporarily calculate WorldRotation from orientation, do so until values in db are correct
            if (addon && addon->invisibilityType == INVISIBILITY_GENERAL && addon->InvisibilityValue == 0)
                SetWorldRotation(rotation);
            else
                SetWorldRotationAngles(NormalizeOrientation(GetOrientation()), 0.0f, 0.0f);
            break;
    }

    // pussywizard: no PathRotation for normal gameobjects
    SetTransportPathRotation(0.0f, 0.0f, 0.0f, 1.0f);

    SetObjectScale(goinfo->size);

    if (GameObjectTemplateAddon const* addon = GetTemplateAddon())
    {
        SetUInt32Value(GAMEOBJECT_FACTION, addon->faction);
        SetUInt32Value(GAMEOBJECT_FLAGS, addon->flags);
    }

    SetEntry(goinfo->entry);

    // set name for logs usage, doesn't affect anything ingame
    SetName(goinfo->name);

    SetDisplayId(goinfo->displayId);

    if (!m_model)
        m_model = GameObjectModel::Create(*this);
    // GAMEOBJECT_BYTES_1, index at 0, 1, 2 and 3
    SetGoType(GameobjectTypes(goinfo->type));
    SetGoState(go_state);
    SetGoArtKit(artKit);

    switch (goinfo->type)
    {
        case GAMEOBJECT_TYPE_FISHINGHOLE:
            SetGoAnimProgress(animprogress);
            m_goValue.FishingHole.MaxOpens = urand(GetGOInfo()->fishinghole.minSuccessOpens, GetGOInfo()->fishinghole.maxSuccessOpens);
            break;
        case GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING:
            m_goValue.Building.Health = goinfo->building.intactNumHits + goinfo->building.damagedNumHits;
            m_goValue.Building.MaxHealth = m_goValue.Building.Health;
            SetGoAnimProgress(255);
            break;
        case GAMEOBJECT_TYPE_FISHINGNODE:
            SetGoAnimProgress(0);
            break;
        case GAMEOBJECT_TYPE_TRAP:
            if (GetGOInfo()->trap.stealthed)
            {
                m_stealth.AddFlag(STEALTH_TRAP);
                m_stealth.AddValue(STEALTH_TRAP, 70);
            }

            if (GetGOInfo()->trap.invisible)
            {
                m_invisibility.AddFlag(INVISIBILITY_TRAP);
                m_invisibility.AddValue(INVISIBILITY_TRAP, 300);
            }
            break;
        default:
            SetGoAnimProgress(animprogress);
            break;
    }

    if (addon)
    {
        if (addon->InvisibilityValue)
        {
            m_invisibility.AddFlag(addon->invisibilityType);
            m_invisibility.AddValue(addon->invisibilityType, addon->InvisibilityValue);
        }
    }

    LastUsedScriptID = GetGOInfo()->ScriptId;
    AIM_Initialize();

    return true;
}

void GameObject::Update(uint32 diff)
{
#ifdef ELUNA
    sEluna->UpdateAI(this, diff);
#endif
    if (AI())
        AI()->UpdateAI(diff);
    else if (!AIM_Initialize())
        sLog->outError("Could not initialize GameObjectAI");

    switch (m_lootState)
    {
        case GO_NOT_READY:
        {
            switch (GetGoType())
            {
                case GAMEOBJECT_TYPE_TRAP:
                {
                    // Arming Time for GAMEOBJECT_TYPE_TRAP (6)
                    GameObjectTemplate const* goInfo = GetGOInfo();
                    // Bombs
                    if (goInfo->trap.type == 2)
                        m_cooldownTime = World::GetGameTimeMS()+10*IN_MILLISECONDS;   // Hardcoded tooltip value
                    else if (GetOwner())
                        m_cooldownTime = World::GetGameTimeMS()+goInfo->trap.startDelay*IN_MILLISECONDS;

                    m_lootState = GO_READY;
                    break;
                }
                case GAMEOBJECT_TYPE_FISHINGNODE:
                {
                    // fishing code (bobber ready)
                    if (time(NULL) > m_respawnTime - FISHING_BOBBER_READY_TIME)
                    {
                        // splash bobber (bobber ready now)
                        Unit* caster = GetOwner();
                        if (caster && caster->GetTypeId() == TYPEID_PLAYER)
                        {
                            SetGoState(GO_STATE_ACTIVE);
                            SetUInt32Value(GAMEOBJECT_FLAGS, GO_FLAG_NODESPAWN);

                            UpdateData udata;
                            WorldPacket packet;
                            BuildValuesUpdateBlockForPlayer(&udata, caster->ToPlayer());
                            udata.BuildPacket(&packet);
                            caster->ToPlayer()->GetSession()->SendPacket(&packet);

                            SendCustomAnim(GetGoAnimProgress());
                        }

                        m_lootState = GO_READY;                 // can be successfully open with some chance
                    }
                    return;
                }
                case GAMEOBJECT_TYPE_SUMMONING_RITUAL:
                {
                    if (World::GetGameTimeMS() < m_cooldownTime)
                        return;
                    GameObjectTemplate const* info = GetGOInfo();
                    if (info->summoningRitual.animSpell)
                    {
                        // xinef: if ritual requires animation, ensure that all users performs channel
                        CheckRitualList();
                    }
                    if (GetUniqueUseCount() < info->summoningRitual.reqParticipants)
                    {
                        SetLootState(GO_READY);
                        return;
                    }

                    bool triggered = info->summoningRitual.animSpell;
                    Unit* owner = GetOwner();
                    Unit* spellCaster = owner ? owner : ObjectAccessor::GetPlayer(*this, MAKE_NEW_GUID(m_ritualOwnerGUIDLow, 0, HIGHGUID_PLAYER));
                    if (!spellCaster)
                    {
                        SetLootState(GO_JUST_DEACTIVATED);
                        return;
                    }

                    uint32 spellId = info->summoningRitual.spellId;

                    if (spellId == 62330)                       // GO store nonexistent spell, replace by expected
                    {
                        // spell have reagent and mana cost but it not expected use its
                        // it triggered spell in fact casted at currently channeled GO
                        spellId = 61993;
                        triggered = true;
                    }

                    // Cast casterTargetSpell at a random GO user
                    // on the current DB there is only one gameobject that uses this (Ritual of Doom)
                    // and its required target number is 1 (outter for loop will run once)
                    if (info->summoningRitual.casterTargetSpell && info->summoningRitual.casterTargetSpell != 1) // No idea why this field is a bool in some cases
                        for (uint32 i = 0; i < info->summoningRitual.casterTargetSpellTargets; i++)
                            // m_unique_users can contain only player GUIDs
                            if (Player* target = ObjectAccessor::GetPlayer(*this, Trinity::Containers::SelectRandomContainerElement(m_unique_users)))
                                spellCaster->CastSpell(target, info->summoningRitual.casterTargetSpell, true);

                    // finish owners spell
                    // xinef: properly process event cooldowns
                    if (owner)
                    {
                        if (Spell* spell = owner->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
                        {
                            spell->SendChannelUpdate(0);
                            spell->finish(false);
                        }
                    }

                    // can be deleted now
                    if (!info->summoningRitual.ritualPersistent)
                        SetLootState(GO_JUST_DEACTIVATED);
                    else
                        SetLootState(GO_READY);

                    ClearRitualList();
                    spellCaster->CastSpell(spellCaster, spellId, triggered);
                    return;
                }
                default:
                    m_lootState = GO_READY;                         // for other GOis same switched without delay to GO_READY
                    break;
            }

            // NO BREAK for switch (m_lootState)
        }
        case GO_READY:
        {
            if (m_respawnTime > 0)                          // timer on
            {
                time_t now = time(NULL);
                if (m_respawnTime <= now)            // timer expired
                {
                    uint64 dbtableHighGuid = MAKE_NEW_GUID(m_DBTableGuid, GetEntry(), HIGHGUID_GAMEOBJECT);
                    time_t linkedRespawntime = GetMap()->GetLinkedRespawnTime(dbtableHighGuid);
                    if (linkedRespawntime)             // Can't respawn, the master is dead
                    {
                        uint64 targetGuid = sObjectMgr->GetLinkedRespawnGuid(dbtableHighGuid);
                        if (targetGuid == dbtableHighGuid) // if linking self, never respawn (check delayed to next day)
                            SetRespawnTime(DAY);
                        else
                            m_respawnTime = (now > linkedRespawntime ? now : linkedRespawntime)+urand(5, MINUTE); // else copy time from master and add a little
                        SaveRespawnTime(); // also save to DB immediately
                        return;
                    }

                    m_respawnTime = 0;
                    m_SkillupList.clear();
                    m_usetimes = 0;

                    switch (GetGoType())
                    {
                        case GAMEOBJECT_TYPE_FISHINGNODE:   //  can't fish now
                        {
                            Unit* caster = GetOwner();
                            if (caster && caster->GetTypeId() == TYPEID_PLAYER)
                            {
                                caster->ToPlayer()->RemoveGameObject(this, false);

                                WorldPacket data(SMSG_FISH_ESCAPED, 0);
                                caster->ToPlayer()->GetSession()->SendPacket(&data);
                            }
                            // can be delete
                            m_lootState = GO_JUST_DEACTIVATED;
                            return;
                        }
                        case GAMEOBJECT_TYPE_DOOR:
                        case GAMEOBJECT_TYPE_BUTTON:
                            //we need to open doors if they are closed (add there another condition if this code breaks some usage, but it need to be here for battlegrounds)
                            if (GetGoState() != GO_STATE_READY)
                                ResetDoorOrButton();
                            break;
                        case GAMEOBJECT_TYPE_FISHINGHOLE:
                            // Initialize a new max fish count on respawn
                            m_goValue.FishingHole.MaxOpens = urand(GetGOInfo()->fishinghole.minSuccessOpens, GetGOInfo()->fishinghole.maxSuccessOpens);
                            break;
                        default:
                            break;
                    }

                    if (!m_spawnedByDefault)        // despawn timer
                    {
                                                    // can be despawned or destroyed
                        SetLootState(GO_JUST_DEACTIVATED);
                        return;
                    }

                    // Xinef: Call AI Reset (required for example in SmartAI to clear one time events)
                    if (AI())
                        AI()->Reset();

                                                    // respawn timer
                    uint32 poolid = GetDBTableGUIDLow() ? sPoolMgr->IsPartOfAPool<GameObject>(GetDBTableGUIDLow()) : 0;
                    if (poolid)
                        sPoolMgr->UpdatePool<GameObject>(poolid, GetDBTableGUIDLow());
                    else
                        GetMap()->AddToMap(this);
                }
            }

            if (isSpawned())
            {
                // traps can have time and can not have
                GameObjectTemplate const* goInfo = GetGOInfo();
                if (goInfo->type == GAMEOBJECT_TYPE_TRAP)
                {
                    if (World::GetGameTimeMS() < m_cooldownTime)
                        break;

                    // Type 2 - Bomb (will go away after casting it's spell)
                    if (goInfo->trap.type == 2)
                    {
                        if (goInfo->trap.spellId)
                            CastSpell(NULL, goInfo->trap.spellId);  // FIXME: null target won't work for target type 1
                        SetLootState(GO_JUST_DEACTIVATED);
                        break;
                    }

                    // Type 0 despawns after being triggered, type 1 does not.
                    bool isBattlegroundTrap = false;

                    /// @todo This is activation radius. Casting radius must be selected from spell data.
                    /// @todo Move activated state code to GO_ACTIVATED, in this place just check for activation and set state.
                    float radius = float(goInfo->trap.diameter) * 0.5f;
                    if (!goInfo->trap.diameter)
                    {
                        // Cast in other case (at some triggering/linked go/etc explicit call)
                        if (goInfo->trap.cooldown != 3 || m_respawnTime > 0)
                            break;

                        // Battleground gameobjects have data2 == 0 && data5 == 3
                        isBattlegroundTrap = true;
                        radius = 3.f;
                    }

                    // Type 0 and 1 - trap (type 0 will not get removed after casting a spell)
                    Unit* owner = GetOwner();
                    Unit* target = NULL;                            // pointer to appropriate target if found any

                    // Note: this hack with search required until GO casting not implemented
                    // search unfriendly creature
                    if (owner)                    // hunter trap
                    {
                        Trinity::AnyUnfriendlyNoTotemUnitInObjectRangeCheck checker(this, owner, radius);
                        Trinity::UnitSearcher<Trinity::AnyUnfriendlyNoTotemUnitInObjectRangeCheck> searcher(this, target, checker);
                        VisitNearbyGridObject(radius, searcher);
                        if (!target)
                            VisitNearbyWorldObject(radius, searcher);
                    }
                    else                                        // environmental trap
                    {
                        // environmental damage spells already have around enemies targeting but this not help in case not existed GO casting support
                        // affect only players
                        Player* player = NULL;
                        Trinity::AnyPlayerInObjectRangeCheck checker(this, radius, true, true);
                        Trinity::PlayerSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(this, player, checker);
                        VisitNearbyWorldObject(radius, searcher);
                        target = player;
                    }

                    if (target)
                    {
                        // some traps do not have spell but should be triggered
                        if (goInfo->trap.spellId)
                            CastSpell(target, goInfo->trap.spellId);

                        m_cooldownTime = World::GetGameTimeMS()+(goInfo->trap.cooldown ? goInfo->trap.cooldown :  uint32(4))*IN_MILLISECONDS;   // template or 4 seconds

                        if (goInfo->trap.type == 1)
                            SetLootState(GO_JUST_DEACTIVATED);

                        if (isBattlegroundTrap && target->GetTypeId() == TYPEID_PLAYER)
                        {
                            // battleground gameobjects case
                            if (target->ToPlayer()->InBattleground())
                                if (Battleground* bg = target->ToPlayer()->GetBattleground())
                                    bg->HandleTriggerBuff(this);
                        }
                    }
                }
                else if (uint32 max_charges = goInfo->GetCharges())
                {
                    if (m_usetimes >= max_charges)
                    {
                        m_usetimes = 0;
                        SetLootState(GO_JUST_DEACTIVATED);      // can be despawned or destroyed
                    }
                }
            }

            break;
        }
        case GO_ACTIVATED:
        {
            switch (GetGoType())
            {
                case GAMEOBJECT_TYPE_DOOR:
                case GAMEOBJECT_TYPE_BUTTON:
                    if (GetGOInfo()->GetAutoCloseTime() && World::GetGameTimeMS() >= m_cooldownTime)
                        ResetDoorOrButton();
                    break;
                case GAMEOBJECT_TYPE_GOOBER:
                    if (World::GetGameTimeMS() >= m_cooldownTime)
                    {
                        RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);

                        SetLootState(GO_JUST_DEACTIVATED);
                    }
                    break;
                case GAMEOBJECT_TYPE_CHEST:
                    if (m_groupLootTimer)
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
                default:
                    break;
            }
            break;
        }
        case GO_JUST_DEACTIVATED:
        {
            //if Gameobject should cast spell, then this, but some GOs (type = 10) should be destroyed
            if (GetGoType() == GAMEOBJECT_TYPE_GOOBER)
            {
                SetGoState(GO_STATE_READY);

                //any return here in case battleground traps
                // Xinef: Do not return here for summoned gos that should be deleted few lines below
                // Xinef: Battleground objects are treated as spawned by default
                if (GameObjectTemplateAddon const* addon = GetTemplateAddon())
                    if ((addon->flags & GO_FLAG_NODESPAWN) && isSpawnedByDefault())
                        return;
            }

            loot.clear();

            //! If this is summoned by a spell with ie. SPELL_EFFECT_SUMMON_OBJECT_WILD, with or without owner, we check respawn criteria based on spell
            //! The GetOwnerGUID() check is mostly for compatibility with hacky scripts - 99% of the time summoning should be done trough spells.
            if (GetSpellId() || GetOwnerGUID())
            {
                SetRespawnTime(0);
                Delete();
                return;
            }

            SetLootState(GO_READY);

            //burning flags in some battlegrounds, if you find better condition, just add it
            if (GetGOInfo()->IsDespawnAtAction() || GetGoAnimProgress() > 0)
            {
                SendObjectDeSpawnAnim(GetGUID());
                //reset flags
                if (GameObjectTemplateAddon const* addon = GetTemplateAddon())
                    SetUInt32Value(GAMEOBJECT_FLAGS, addon->flags);
            }

            if (!m_respawnDelayTime)
                return;

            if (!m_spawnedByDefault)
            {
                m_respawnTime = 0;
                DestroyForNearbyPlayers(); // xinef: old UpdateObjectVisibility();
                return;
            }

            m_respawnTime = time(NULL) + m_respawnDelayTime;

            // if option not set then object will be saved at grid unload
            if (GetMap()->IsDungeon())
                SaveRespawnTime();

            DestroyForNearbyPlayers(); // xinef: old UpdateObjectVisibility();
            break;
        }
    }
    sScriptMgr->OnGameObjectUpdate(this, diff);
}

GameObjectTemplateAddon const* GameObject::GetTemplateAddon() const
{
    return sObjectMgr->GetGameObjectTemplateAddon(GetGOInfo()->entry);
}

void GameObject::Refresh()
{ 
    // not refresh despawned not casted GO (despawned casted GO destroyed in all cases anyway)
    if (m_respawnTime > 0 && m_spawnedByDefault)
        return;

    if (isSpawned())
        GetMap()->AddToMap(this);
}

void GameObject::AddUniqueUse(Player* player)
{ 
    AddUse();
    m_unique_users.insert(player->GetGUID());
}

void GameObject::Delete()
{ 
    SetLootState(GO_NOT_READY);
    RemoveFromOwner();

    SendObjectDeSpawnAnim(GetGUID());

    SetGoState(GO_STATE_READY);

    if (GameObjectTemplateAddon const* addon = GetTemplateAddon())
        SetUInt32Value(GAMEOBJECT_FLAGS, addon->flags);

    // Xinef: if ritual gameobject is removed, clear anim spells
    if (GetGOInfo()->type == GAMEOBJECT_TYPE_SUMMONING_RITUAL)
        ClearRitualList();

    uint32 poolid = GetDBTableGUIDLow() ? sPoolMgr->IsPartOfAPool<GameObject>(GetDBTableGUIDLow()) : 0;
    if (poolid)
        sPoolMgr->UpdatePool<GameObject>(poolid, GetDBTableGUIDLow());
    else
        AddObjectToRemoveList();
}

void GameObject::getFishLoot(Loot* fishloot, Player* loot_owner)
{ 
    fishloot->clear();

    uint32 zone, subzone;
    uint32 defaultzone = 1;
    GetZoneAndAreaId(zone, subzone);

    // if subzone loot exist use it
    fishloot->FillLoot(subzone, LootTemplates_Fishing, loot_owner, true, true);
    if (fishloot->empty())  //use this becase if zone or subzone has set LOOT_MODE_JUNK_FISH,Even if no normal drop, fishloot->FillLoot return true. it wrong.
    {
        //subzone no result,use zone loot
        fishloot->FillLoot(zone, LootTemplates_Fishing, loot_owner, true, true);
        //use zone 1 as default, somewhere fishing got nothing,becase subzone and zone not set, like Off the coast of Storm Peaks. 
        if (fishloot->empty())
            fishloot->FillLoot(defaultzone, LootTemplates_Fishing, loot_owner, true, true);
    }
}

void GameObject::getFishLootJunk(Loot* fishloot, Player* loot_owner)
{
    fishloot->clear();

    uint32 zone, subzone;
    uint32 defaultzone = 1;
    GetZoneAndAreaId(zone, subzone);

    // if subzone loot exist use it
    fishloot->FillLoot(subzone, LootTemplates_Fishing, loot_owner, true, true, LOOT_MODE_JUNK_FISH);
    if (fishloot->empty())  //use this becase if zone or subzone has normal mask drop, then fishloot->FillLoot return true.
    {
        //use zone loot
        fishloot->FillLoot(zone, LootTemplates_Fishing, loot_owner, true, true, LOOT_MODE_JUNK_FISH);
        if (fishloot->empty())
            //use zone 1 as default
            fishloot->FillLoot(defaultzone, LootTemplates_Fishing, loot_owner, true, true, LOOT_MODE_JUNK_FISH);
    }
}

void GameObject::SaveToDB()
{ 
    // this should only be used when the gameobject has already been loaded
    // preferably after adding to map, because mapid may not be valid otherwise
    GameObjectData const* data = sObjectMgr->GetGOData(m_DBTableGuid);
    if (!data)
    {
        sLog->outError("GameObject::SaveToDB failed, cannot get gameobject data!");
        return;
    }

    SaveToDB(GetMapId(), data->spawnMask, data->phaseMask);
}

void GameObject::SaveToDB(uint32 mapid, uint8 spawnMask, uint32 phaseMask)
{ 
    const GameObjectTemplate* goI = GetGOInfo();

    if (!goI)
        return;

    if (!m_DBTableGuid)
        m_DBTableGuid = GetGUIDLow();
    // update in loaded data (changing data only in this place)
    GameObjectData& data = sObjectMgr->NewGOData(m_DBTableGuid);

    // data->guid = guid must not be updated at save
    data.id = GetEntry();
    data.mapid = mapid;
    data.phaseMask = phaseMask;
    data.posX = GetPositionX();
    data.posY = GetPositionY();
    data.posZ = GetPositionZ();
    data.orientation = GetOrientation();
    data.rotation = m_worldRotation;
    data.spawntimesecs = m_spawnedByDefault ? m_respawnDelayTime : -(int32)m_respawnDelayTime;
    data.animprogress = GetGoAnimProgress();
    data.go_state = GetGoState();
    data.spawnMask = spawnMask;
    data.artKit = GetGoArtKit();

    // Update in DB
    SQLTransaction trans = WorldDatabase.BeginTransaction();

    uint8 index = 0;

    PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_GAMEOBJECT);
    stmt->setUInt32(0, m_DBTableGuid);
    trans->Append(stmt);

    stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_GAMEOBJECT);
    stmt->setUInt32(index++, m_DBTableGuid);
    stmt->setUInt32(index++, GetEntry());
    stmt->setUInt16(index++, uint16(mapid));
    stmt->setUInt8(index++, spawnMask);
    stmt->setUInt32(index++, GetPhaseMask());
    stmt->setFloat(index++, GetPositionX());
    stmt->setFloat(index++, GetPositionY());
    stmt->setFloat(index++, GetPositionZ());
    stmt->setFloat(index++, GetOrientation());
    stmt->setFloat(index++, m_worldRotation.x);
    stmt->setFloat(index++, m_worldRotation.y);
    stmt->setFloat(index++, m_worldRotation.z);
    stmt->setFloat(index++, m_worldRotation.w);
    stmt->setInt32(index++, int32(m_respawnDelayTime));
    stmt->setUInt8(index++, GetGoAnimProgress());
    stmt->setUInt8(index++, uint8(GetGoState()));
    trans->Append(stmt);

    WorldDatabase.CommitTransaction(trans);
}

bool GameObject::LoadGameObjectFromDB(uint32 guid, Map* map, bool addToMap)
{ 
    GameObjectData const* data = sObjectMgr->GetGOData(guid);

    if (!data)
    {
        sLog->outErrorDb("Gameobject (GUID: %u) not found in table `gameobject`, can't load. ", guid);
        return false;
    }

    uint32 entry = data->id;
    //uint32 map_id = data->mapid;                          // already used before call
    uint32 phaseMask = data->phaseMask;
    float x = data->posX;
    float y = data->posY;
    float z = data->posZ;
    float ang = data->orientation;

    uint32 animprogress = data->animprogress;
    GOState go_state = data->go_state;
    uint32 artKit = data->artKit;

    m_DBTableGuid = guid;
    if (map->GetInstanceId() != 0) guid = sObjectMgr->GenerateLowGuid(HIGHGUID_GAMEOBJECT);

    if (!Create(guid, entry, map, phaseMask, x, y, z, ang, data->rotation, animprogress, go_state, artKit))
        return false;

    if (data->spawntimesecs >= 0)
    {
        m_spawnedByDefault = true;

        if (!GetGOInfo()->GetDespawnPossibility() && !GetGOInfo()->IsDespawnAtAction())
        {
            SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NODESPAWN);
            m_respawnDelayTime = 0;
            m_respawnTime = 0;
        }
        else
        {
            m_respawnDelayTime = data->spawntimesecs;
            m_respawnTime = GetMap()->GetGORespawnTime(m_DBTableGuid);

            // ready to respawn
            if (m_respawnTime && m_respawnTime <= time(NULL))
            {
                m_respawnTime = 0;
                GetMap()->RemoveGORespawnTime(m_DBTableGuid);
            }
        }
    }
    else
    {
        m_spawnedByDefault = false;
        m_respawnDelayTime = -data->spawntimesecs;
        m_respawnTime = 0;
    }

    m_goData = data;

    if (addToMap && !GetMap()->AddToMap(this))
        return false;

    return true;
}

void GameObject::DeleteFromDB()
{ 
    GetMap()->RemoveGORespawnTime(m_DBTableGuid);
    sObjectMgr->DeleteGOData(m_DBTableGuid);

    PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_GAMEOBJECT);

    stmt->setUInt32(0, m_DBTableGuid);

    WorldDatabase.Execute(stmt);

    stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_EVENT_GAMEOBJECT);

    stmt->setUInt32(0, m_DBTableGuid);

    WorldDatabase.Execute(stmt);
}

/*********************************************************/
/***                    QUEST SYSTEM                   ***/
/*********************************************************/
bool GameObject::hasQuest(uint32 quest_id) const
{ 
    QuestRelationBounds qr = sObjectMgr->GetGOQuestRelationBounds(GetEntry());
    for (QuestRelations::const_iterator itr = qr.first; itr != qr.second; ++itr)
    {
        if (itr->second == quest_id)
            return true;
    }
    return false;
}

bool GameObject::hasInvolvedQuest(uint32 quest_id) const
{ 
    QuestRelationBounds qir = sObjectMgr->GetGOQuestInvolvedRelationBounds(GetEntry());
    for (QuestRelations::const_iterator itr = qir.first; itr != qir.second; ++itr)
    {
        if (itr->second == quest_id)
            return true;
    }
    return false;
}

bool GameObject::IsTransport() const
{
    return GetGOInfo() && (GetGOInfo()->type == GAMEOBJECT_TYPE_TRANSPORT || GetGOInfo()->type == GAMEOBJECT_TYPE_MO_TRANSPORT);
}

bool GameObject::IsDestructibleBuilding() const
{ 
    GameObjectTemplate const* gInfo = GetGOInfo();
    if (!gInfo) return false;
    return gInfo->type == GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING;
}

Unit* GameObject::GetOwner() const
{ 
    return ObjectAccessor::GetUnit(*this, GetOwnerGUID());
}

void GameObject::SaveRespawnTime()
{ 
    if (m_goData && m_goData->dbData && m_respawnTime > time(NULL) && m_spawnedByDefault)
        GetMap()->SaveGORespawnTime(m_DBTableGuid, m_respawnTime);
}

bool GameObject::IsNeverVisible() const
{
    if (WorldObject::IsNeverVisible())
        return true;

    if (GetGoType() == GAMEOBJECT_TYPE_SPELL_FOCUS && GetGOInfo()->spellFocus.serverOnly == 1)
        return true;

    return false;
}

bool GameObject::IsAlwaysVisibleFor(WorldObject const* seer) const
{ 
    if (WorldObject::IsAlwaysVisibleFor(seer))
        return true;

    if (IsTransport() || IsDestructibleBuilding())
        return true;

    if (!seer)
        return false;

    // Always seen by owner and friendly units
    if (uint64 guid = GetOwnerGUID())
    {
        if (seer->GetGUID() == guid)
            return true;

        Unit* owner = GetOwner();
        if (owner)
        {
            if (seer->isType(TYPEMASK_UNIT) && owner->IsFriendlyTo(seer->ToUnit()))
                return true;
        }
    }

    return false;
}

bool GameObject::IsInvisibleDueToDespawn() const
{ 
    if (WorldObject::IsInvisibleDueToDespawn())
        return true;

    // Despawned
    if (!isSpawned())
        return true;

    return false;
}

void GameObject::Respawn()
{ 
    if (m_spawnedByDefault && m_respawnTime > 0)
    {
        m_respawnTime = time(NULL);
        GetMap()->RemoveGORespawnTime(m_DBTableGuid);
    }
}

bool GameObject::ActivateToQuest(Player* target) const
{ 
    if (target->HasQuestForGO(GetEntry()))
        return true;

    if (!GetGOInfo()->IsGameObjectForQuests())
        return false;

    switch (GetGoType())
    {
        case GAMEOBJECT_TYPE_QUESTGIVER:
        {
            GameObject* go = const_cast<GameObject*>(this);
            QuestGiverStatus questStatus = target->GetQuestDialogStatus(go);
            if (questStatus > DIALOG_STATUS_UNAVAILABLE)
                return true;
            break;
        }
        case GAMEOBJECT_TYPE_CHEST:
        {
            // scan GO chest with loot including quest items
            if (LootTemplates_Gameobject.HaveQuestLootForPlayer(GetGOInfo()->GetLootId(), target))
            {
                //TODO: fix this hack
                //look for battlegroundAV for some objects which are only activated after mine gots captured by own team
                if (GetEntry() == BG_AV_OBJECTID_MINE_N || GetEntry() == BG_AV_OBJECTID_MINE_S)
                    if (Battleground* bg = target->GetBattleground())
                        if (bg->GetBgTypeID() == BATTLEGROUND_AV && !bg->ToBattlegroundAV()->PlayerCanDoMineQuest(GetEntry(), target->GetTeamId()))
                            return false;
                return true;
            }
            break;
        }
        case GAMEOBJECT_TYPE_GENERIC:
        {
            if (GetGOInfo()->_generic.questID == -1 || target->GetQuestStatus(GetGOInfo()->_generic.questID) == QUEST_STATUS_INCOMPLETE)
                return true;
            break;
        }
        case GAMEOBJECT_TYPE_GOOBER:
        {
            if (GetGOInfo()->goober.questId == -1 || target->GetQuestStatus(GetGOInfo()->goober.questId) == QUEST_STATUS_INCOMPLETE)
                return true;
            break;
        }
        default:
            break;
    }

    return false;
}

void GameObject::TriggeringLinkedGameObject(uint32 trapEntry, Unit* target)
{
    GameObjectTemplate const* trapInfo = sObjectMgr->GetGameObjectTemplate(trapEntry);
    if (!trapInfo || trapInfo->type != GAMEOBJECT_TYPE_TRAP)
        return;

    SpellInfo const* trapSpell = sSpellMgr->GetSpellInfo(trapInfo->trap.spellId);
    if (!trapSpell)                                          // checked at load already
        return;

    // xinef: wtf, many spells have range 0 but radius > 0
    float range = float(target->GetSpellMaxRangeForTarget(GetOwner(), trapSpell));
    if (range < 1.0f)
        range = 5.0f;

    // search nearest linked GO
    GameObject* trapGO = NULL;
    {
        // using original GO distance
        CellCoord p(Trinity::ComputeCellCoord(GetPositionX(), GetPositionY()));
        Cell cell(p);

        Trinity::NearestGameObjectEntryInObjectRangeCheck go_check(*target, trapEntry, range);
        Trinity::GameObjectLastSearcher<Trinity::NearestGameObjectEntryInObjectRangeCheck> checker(this, trapGO, go_check);

        TypeContainerVisitor<Trinity::GameObjectLastSearcher<Trinity::NearestGameObjectEntryInObjectRangeCheck>, GridTypeMapContainer > object_checker(checker);
        cell.Visit(p, object_checker, *GetMap(), *target, range);
    }

    // found correct GO
    // xinef: we should use the trap (checks for despawn type)
    if (trapGO)
        trapGO->Use(target); //trapGO->CastSpell(target, trapInfo->trap.spellId);
}

GameObject* GameObject::LookupFishingHoleAround(float range)
{ 
    GameObject* ok = NULL;

    CellCoord p(Trinity::ComputeCellCoord(GetPositionX(), GetPositionY()));
    Cell cell(p);
    Trinity::NearestGameObjectFishingHole u_check(*this, range);
    Trinity::GameObjectSearcher<Trinity::NearestGameObjectFishingHole> checker(this, ok, u_check);

    TypeContainerVisitor<Trinity::GameObjectSearcher<Trinity::NearestGameObjectFishingHole>, GridTypeMapContainer > grid_object_checker(checker);
    cell.Visit(p, grid_object_checker, *GetMap(), *this, range);

    return ok;
}

void GameObject::ResetDoorOrButton()
{ 
    if (m_lootState == GO_READY || m_lootState == GO_JUST_DEACTIVATED)
        return;

    SwitchDoorOrButton(false);
    SetLootState(GO_JUST_DEACTIVATED);
    m_cooldownTime = 0;
}

void GameObject::UseDoorOrButton(uint32 time_to_restore, bool alternative /* = false */, Unit* user /*=NULL*/)
{ 
    if (m_lootState != GO_READY)
        return;

    if (!time_to_restore)
        time_to_restore = GetGOInfo()->GetAutoCloseTime();

    SwitchDoorOrButton(true, alternative);
    SetLootState(GO_ACTIVATED, user);

    m_cooldownTime = World::GetGameTimeMS()+time_to_restore;
}

void GameObject::SetGoArtKit(uint8 kit)
{ 
    SetByteValue(GAMEOBJECT_BYTES_1, 2, kit);
    GameObjectData* data = const_cast<GameObjectData*>(sObjectMgr->GetGOData(m_DBTableGuid));
    if (data)
        data->artKit = kit;
}

void GameObject::SetGoArtKit(uint8 artkit, GameObject* go, uint32 lowguid)
{
    const GameObjectData* data = NULL;
    if (go)
    {
        go->SetGoArtKit(artkit);
        data = go->GetGOData();
    }
    else if (lowguid)
        data = sObjectMgr->GetGOData(lowguid);

    if (data)
        const_cast<GameObjectData*>(data)->artKit = artkit;
}

void GameObject::SwitchDoorOrButton(bool activate, bool alternative /* = false */)
{ 
    if (activate)
        SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
    else
        RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);

    if (GetGoState() == GO_STATE_READY)                      //if closed -> open
        SetGoState(alternative ? GO_STATE_ACTIVE_ALTERNATIVE : GO_STATE_ACTIVE);
    else                                                    //if open -> close
        SetGoState(GO_STATE_READY);
}

void GameObject::Use(Unit* user)
{
    // Xinef: we cannot use go with not selectable flags
    if (HasFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE))
        return;

    // by default spell caster is user
    Unit* spellCaster = user;
    uint32 spellId = 0;
    bool triggered = false;
    bool tmpfish = false;

    if (Player* playerUser = user->ToPlayer())
    {
#ifdef ELUNA
        if (sEluna->OnGossipHello(playerUser, this))
            return;
#endif
        if (sScriptMgr->OnGossipHello(playerUser, this))
            return;

        if (AI()->GossipHello(playerUser, false))
            return;
    }

    // If cooldown data present in template
    if (uint32 cooldown = GetGOInfo()->GetCooldown())
    {
        if (World::GetGameTimeMS() < m_cooldownTime)
            return;

        m_cooldownTime = World::GetGameTimeMS()+cooldown*IN_MILLISECONDS;
    }

    switch (GetGoType())
    {
        case GAMEOBJECT_TYPE_DOOR:                          //0
            //doors/buttons never really despawn, only reset to default state/flags
            UseDoorOrButton(0, false, user);
            return;
        case GAMEOBJECT_TYPE_BUTTON:                        //1
            //doors/buttons never really despawn, only reset to default state/flags
            UseDoorOrButton(0, false, user);

            // Xinef: properly link possible traps
            if (uint32 trapEntry = GetGOInfo()->button.linkedTrap)
                TriggeringLinkedGameObject(trapEntry, user);
            return;
        case GAMEOBJECT_TYPE_QUESTGIVER:                    //2
        {
            if (user->GetTypeId() != TYPEID_PLAYER)
                return;

            Player* player = user->ToPlayer();

            player->PrepareGossipMenu(this, GetGOInfo()->questgiver.gossipID, true);
            player->SendPreparedGossip(this);
            return;
        }
        case GAMEOBJECT_TYPE_TRAP:                          //6
        {
            GameObjectTemplate const* goInfo = GetGOInfo();
            if (goInfo->trap.spellId)
                CastSpell(user, goInfo->trap.spellId);

            m_cooldownTime = World::GetGameTimeMS()+(goInfo->trap.cooldown ? goInfo->trap.cooldown :  uint32(4))*IN_MILLISECONDS;   // template or 4 seconds

            if (goInfo->trap.type == 1)         // Deactivate after trigger
                SetLootState(GO_JUST_DEACTIVATED);

            return;
        }
        //Sitting: Wooden bench, chairs enzz
        case GAMEOBJECT_TYPE_CHAIR:                         //7
        {
            GameObjectTemplate const* info = GetGOInfo();
            if (!info)
                return;

            if (user->GetTypeId() != TYPEID_PLAYER)
                return;

            if (ChairListSlots.empty())        // this is called once at first chair use to make list of available slots
            {
                if (info->chair.slots > 0)     // sometimes chairs in DB have error in fields and we dont know number of slots
                    for (uint32 i = 0; i < info->chair.slots; ++i)
                        ChairListSlots[i] = 0; // Last user of current slot set to 0 (none sit here yet)
                else
                    ChairListSlots[0] = 0;     // error in DB, make one default slot
            }

            Player* player = user->ToPlayer();

            // a chair may have n slots. we have to calculate their positions and teleport the player to the nearest one

            float lowestDist = DEFAULT_VISIBILITY_DISTANCE;

            uint32 nearest_slot = 0;
            float x_lowest = GetPositionX();
            float y_lowest = GetPositionY();

            // the object orientation + 1/2 pi
            // every slot will be on that straight line
            float orthogonalOrientation = GetOrientation()+M_PI*0.5f;
            // find nearest slot
            bool found_free_slot = false;
            for (ChairSlotAndUser::iterator itr = ChairListSlots.begin(); itr != ChairListSlots.end(); ++itr)
            {
                // the distance between this slot and the center of the go - imagine a 1D space
                float relativeDistance = (info->size*itr->first)-(info->size*(info->chair.slots-1)/2.0f);

                float x_i = GetPositionX() + relativeDistance * cos(orthogonalOrientation);
                float y_i = GetPositionY() + relativeDistance * sin(orthogonalOrientation);

                if (itr->second)
                {
                    if (Player* ChairUser = ObjectAccessor::GetPlayer(*this, itr->second))
                    {
                        if (ChairUser->IsSitState() && ChairUser->getStandState() != UNIT_STAND_STATE_SIT && ChairUser->GetExactDist2d(x_i, y_i) < 0.1f)
                            continue;        // This seat is already occupied by ChairUser. NOTE: Not sure if the ChairUser->getStandState() != UNIT_STAND_STATE_SIT check is required.
                        else
                            itr->second = 0; // This seat is unoccupied.
                    }
                    else
                        itr->second = 0;     // The seat may of had an occupant, but they're offline.
                }

                found_free_slot = true;

                // calculate the distance between the player and this slot
                float thisDistance = player->GetDistance2d(x_i, y_i);

                if (thisDistance <= lowestDist)
                {
                    nearest_slot = itr->first;
                    lowestDist = thisDistance;
                    x_lowest = x_i;
                    y_lowest = y_i;
                }
            }

            if (found_free_slot)
            {
                ChairSlotAndUser::iterator itr = ChairListSlots.find(nearest_slot);
                if (itr != ChairListSlots.end())
                {
                    itr->second = player->GetGUID(); //this slot in now used by player
                    player->TeleportTo(GetMapId(), x_lowest, y_lowest, GetPositionZ(), GetOrientation(), TELE_TO_NOT_LEAVE_TRANSPORT | TELE_TO_NOT_LEAVE_COMBAT | TELE_TO_NOT_UNSUMMON_PET);
                    player->SetStandState(UNIT_STAND_STATE_SIT_LOW_CHAIR+info->chair.height);
                    return;
                }
            }

            return;
        }
        //big gun, its a spell/aura
        case GAMEOBJECT_TYPE_GOOBER:                        //10
        {
            GameObjectTemplate const* info = GetGOInfo();

            // xinef: Goober cannot be used with this flag, skip
            if (HasFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE))
                return;

            if (user->GetTypeId() == TYPEID_PLAYER)
            {
                Player* player = user->ToPlayer();

                if (info->goober.pageId)                    // show page...
                {
                    WorldPacket data(SMSG_GAMEOBJECT_PAGETEXT, 8);
                    data << GetGUID();
                    player->GetSession()->SendPacket(&data);
                }
                else if (info->goober.gossipID)
                {
                    player->PrepareGossipMenu(this, info->goober.gossipID);
                    player->SendPreparedGossip(this);
                }

                if (info->goober.eventId)
                {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_MAPSCRIPTS, "Goober ScriptStart id %u for GO entry %u (GUID %u).", info->goober.eventId, GetEntry(), GetDBTableGUIDLow());
#endif
                    GetMap()->ScriptsStart(sEventScripts, info->goober.eventId, player, this);
                    EventInform(info->goober.eventId);
                }

                // possible quest objective for active quests
                if (info->goober.questId && sObjectMgr->GetQuestTemplate(info->goober.questId))
                {
                    //Quest require to be active for GO using
                    if (player->GetQuestStatus(info->goober.questId) != QUEST_STATUS_INCOMPLETE)
                        break;
                }

                if (Battleground* bg = player->GetBattleground())
                    bg->EventPlayerUsedGO(player, this);

                player->KillCreditGO(info->entry, GetGUID());
            }

            if (uint32 trapEntry = info->goober.linkedTrapId)
                TriggeringLinkedGameObject(trapEntry, user);

            if (info->GetAutoCloseTime())
            {
                SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                SetLootState(GO_ACTIVATED, user);
                if (!info->goober.customAnim)
                    SetGoState(GO_STATE_ACTIVE);
            }

            // this appear to be ok, however others exist in addition to this that should have custom (ex: 190510, 188692, 187389)
            if (info->goober.customAnim)
                SendCustomAnim(GetGoAnimProgress());
                
            m_cooldownTime = World::GetGameTimeMS()+info->GetAutoCloseTime();

            // cast this spell later if provided
            spellId = info->goober.spellId;
            spellCaster = user;
            tmpfish = true;
            
            break;
        }
        case GAMEOBJECT_TYPE_CAMERA:                        //13
        {
            GameObjectTemplate const* info = GetGOInfo();
            if (!info)
                return;

            if (user->GetTypeId() != TYPEID_PLAYER)
                return;

            Player* player = user->ToPlayer();

            if (info->camera.cinematicId)
                player->SendCinematicStart(info->camera.cinematicId);

            if (info->camera.eventID)
                GetMap()->ScriptsStart(sEventScripts, info->camera.eventID, player, this);

            return;
        }
        //fishing bobber
        case GAMEOBJECT_TYPE_FISHINGNODE:                   //17
        {
            Player* player = user->ToPlayer();
            if (!player)
                return;

            if (player->GetGUID() != GetOwnerGUID())
                return;

            switch (getLootState())
            {
                case GO_READY:                              // ready for loot
                {
                    uint32 zone, subzone;
                    GetZoneAndAreaId(zone, subzone);

                    int32 zone_skill = sObjectMgr->GetFishingBaseSkillLevel(subzone);
                    if (!zone_skill)
                        zone_skill = sObjectMgr->GetFishingBaseSkillLevel(zone);

                    //provide error, no fishable zone or area should be 0
                    if (!zone_skill)
                        sLog->outErrorDb("Fishable areaId %u are not properly defined in `skill_fishing_base_level`.", subzone);

                    int32 skill = player->GetSkillValue(SKILL_FISHING);

                    int32 chance;
                    if (skill < zone_skill)
                    {
                        chance = int32(pow((double)skill/zone_skill, 2) * 100);
                        if (chance < 1)
                            chance = 1;
                    }
                    else
                        chance = 100;

                    int32 roll = irand(1, 100);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outStaticDebug("Fishing check (skill: %i zone min skill: %i chance %i roll: %i", skill, zone_skill, chance, roll);
#endif

                    // but you will likely cause junk in areas that require a high fishing skill (not yet implemented)
                    if (chance >= roll)
                    {
                        player->UpdateFishingSkill();

                        //TODO: I do not understand this hack. Need some explanation.
                        // prevent removing GO at spell cancel
                        RemoveFromOwner();
                        SetOwnerGUID(player->GetGUID());
                        SetSpellId(0); // prevent removing unintended auras at Unit::RemoveGameObject

                        //TODO: find reasonable value for fishing hole search
                        GameObject* ok = LookupFishingHoleAround(20.0f + CONTACT_DISTANCE);
                        if (ok)
                        {
                            ok->Use(player);
                            SetLootState(GO_JUST_DEACTIVATED);
                        }
                        else
                            player->SendLoot(GetGUID(), LOOT_FISHING);
                    }
                    else // else: junk
                        player->SendLoot(GetGUID(), LOOT_FISHING_JUNK);
                        
                    tmpfish = true;
                    break;
                }
                case GO_JUST_DEACTIVATED:                   // nothing to do, will be deleted at next update
                    break;
                default:
                {
                    SetLootState(GO_JUST_DEACTIVATED);

                    WorldPacket data(SMSG_FISH_NOT_HOOKED, 0);
                    player->GetSession()->SendPacket(&data);
                    break;
                }
            }

            if(tmpfish)
                player->FinishSpell(CURRENT_CHANNELED_SPELL, true);
            else
                player->InterruptSpell(CURRENT_CHANNELED_SPELL, true, true, true);
            return;
        }

        case GAMEOBJECT_TYPE_SUMMONING_RITUAL:              //18
        {
            if (user->GetTypeId() != TYPEID_PLAYER)
                return;

            Player* player = user->ToPlayer();
            Unit* owner = GetOwner();
            GameObjectTemplate const* info = GetGOInfo();

            // ritual owner is set for GO's without owner (not summoned)
            if (m_ritualOwnerGUIDLow == 0 && !owner)
                m_ritualOwnerGUIDLow = player->GetGUIDLow();

            if (owner)
            {
                if (owner->GetTypeId() != TYPEID_PLAYER)
                    return;

                // accept only use by player from same group as owner, excluding owner itself (unique use already added in spell effect)
                if (player == owner->ToPlayer() || (info->summoningRitual.castersGrouped && !player->IsInSameRaidWith(owner->ToPlayer())))
                    return;

                // expect owner to already be channeling, so if not...
                if (!owner->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
                    return;
            }
            else
            {
                Player* ritualOwner = ObjectAccessor::GetPlayer(*this, MAKE_NEW_GUID(m_ritualOwnerGUIDLow, 0, HIGHGUID_PLAYER));
                if (!ritualOwner)
                    return;
                if (player != ritualOwner && (info->summoningRitual.castersGrouped && !player->IsInSameRaidWith(ritualOwner)))
                    return;
            }

            if (info->summoningRitual.animSpell)
            {
                // xinef: if ritual requires animation, ensure that all users performs channel
                CheckRitualList();

                // xinef: all participants found
                if (GetUniqueUseCount() == info->summoningRitual.reqParticipants)
                    return;

                player->CastSpell(player, info->summoningRitual.animSpell, true);
            }

            AddUniqueUse(player);

            // full amount unique participants including original summoner
            if (GetUniqueUseCount() == info->summoningRitual.reqParticipants)
            {
                SetLootState(GO_NOT_READY);
                // can be deleted now, if
                if (!info->summoningRitual.animSpell)
                    m_cooldownTime = 0;
                else // channel ready, maintain this
                    m_cooldownTime = World::GetGameTimeMS()+5*IN_MILLISECONDS;
            }

            return;
        }
        case GAMEOBJECT_TYPE_SPELLCASTER:                   //22
        {
            GameObjectTemplate const* info = GetGOInfo();
            if (!info)
                return;

            if (info->spellcaster.partyOnly)
            {
                Player const* caster = ObjectAccessor::GetObjectInOrOutOfWorld(GetOwnerGUID(), (Player*)NULL);
                if (!caster || user->GetTypeId() != TYPEID_PLAYER || !user->ToPlayer()->IsInSameRaidWith(caster))
                    return;
            }

            user->RemoveAurasByType(SPELL_AURA_MOUNTED);
            spellId = info->spellcaster.spellId;

            AddUse();
            break;
        }
        case GAMEOBJECT_TYPE_MEETINGSTONE:                  //23
        {
            GameObjectTemplate const* info = GetGOInfo();

            if (user->GetTypeId() != TYPEID_PLAYER)
                return;

            Player* player = user->ToPlayer();

            Player* targetPlayer = ObjectAccessor::FindPlayer(player->GetTarget());

            // accept only use by player from same raid as caster, except caster itself
            if (!targetPlayer || targetPlayer == player || !targetPlayer->IsInSameRaidWith(player))
                return;

            //required lvl checks!
            uint8 level = player->getLevel();
            if (level < info->meetingstone.minLevel)
                return;
            level = targetPlayer->getLevel();
            if (level < info->meetingstone.minLevel)
                return;

            if (info->entry == 194097)
                spellId = 61994;                            // Ritual of Summoning
            else
                spellId = 59782;                            // Summoning Stone Effect

            break;
        }

        case GAMEOBJECT_TYPE_FLAGSTAND:                     // 24
        {
            if (user->GetTypeId() != TYPEID_PLAYER)
                return;

            Player* player = user->ToPlayer();

            if (player->CanUseBattlegroundObject(this))
            {
                // in battleground check
                Battleground* bg = player->GetBattleground();
                if (!bg)
                    return;

                if (player->GetVehicle())
                    return;

                player->RemoveAurasByType(SPELL_AURA_MOD_STEALTH);
                player->RemoveAurasByType(SPELL_AURA_MOD_INVISIBILITY);
                // BG flag click
                // AB:
                // 15001
                // 15002
                // 15003
                // 15004
                // 15005
                bg->EventPlayerClickedOnFlag(player, this);
                return;                                     //we don;t need to delete flag ... it is despawned!
            }
            break;
        }

        case GAMEOBJECT_TYPE_FISHINGHOLE:                   // 25
        {
            if (user->GetTypeId() != TYPEID_PLAYER)
                return;

            Player* player = user->ToPlayer();

            player->SendLoot(GetGUID(), LOOT_FISHINGHOLE);
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_FISH_IN_GAMEOBJECT, GetGOInfo()->entry);
            return;
        }

        case GAMEOBJECT_TYPE_FLAGDROP:                      // 26
        {
            if (user->GetTypeId() != TYPEID_PLAYER)
                return;

            Player* player = user->ToPlayer();

            if (player->CanUseBattlegroundObject(this))
            {
                // in battleground check
                Battleground* bg = player->GetBattleground();
                if (!bg)
                    return;

                if (player->GetVehicle())
                    return;

                player->RemoveAurasByType(SPELL_AURA_MOD_STEALTH);
                player->RemoveAurasByType(SPELL_AURA_MOD_INVISIBILITY);
                // BG flag dropped
                // WS:
                // 179785 - Silverwing Flag
                // 179786 - Warsong Flag
                // EotS:
                // 184142 - Netherstorm Flag
                GameObjectTemplate const* info = GetGOInfo();
                if (info)
                {
                    switch (info->entry)
                    {
                        case 179785:                        // Silverwing Flag
                        case 179786:                        // Warsong Flag
                            if (bg->GetBgTypeID() == BATTLEGROUND_WS)
                                bg->EventPlayerClickedOnFlag(player, this);
                            break;
                        case 184142:                        // Netherstorm Flag
                            if (bg->GetBgTypeID() == BATTLEGROUND_EY)
                                bg->EventPlayerClickedOnFlag(player, this);
                            break;
                    }
                }
                //this cause to call return, all flags must be deleted here!!
                spellId = 0;
                Delete();
            }
            break;
        }
        case GAMEOBJECT_TYPE_BARBER_CHAIR:                  //32
        {
            GameObjectTemplate const* info = GetGOInfo();
            if (!info)
                return;

            if (user->GetTypeId() != TYPEID_PLAYER)
                return;

            Player* player = user->ToPlayer();

            // fallback, will always work
            player->TeleportTo(GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation(), TELE_TO_NOT_LEAVE_TRANSPORT | TELE_TO_NOT_LEAVE_COMBAT | TELE_TO_NOT_UNSUMMON_PET);

            WorldPacket data(SMSG_ENABLE_BARBER_SHOP, 0);
            player->GetSession()->SendPacket(&data);

            player->SetStandState(UNIT_STAND_STATE_SIT_LOW_CHAIR+info->barberChair.chairheight);
            return;
        }
        default:
            if (GetGoType() >= MAX_GAMEOBJECT_TYPE)
                sLog->outError("GameObject::Use(): unit (type: %u, guid: %u, name: %s) tries to use object (guid: %u, entry: %u, name: %s) of unknown type (%u)",
                    user->GetTypeId(), user->GetGUIDLow(), user->GetName().c_str(), GetGUIDLow(), GetEntry(), GetGOInfo()->name.c_str(), GetGoType());
            break;
    }

    if (!spellId)
        return;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
    {
        if (user->GetTypeId() != TYPEID_PLAYER || !sOutdoorPvPMgr->HandleCustomSpell(user->ToPlayer(), spellId, this))
            sLog->outError("WORLD: unknown spell id %u at use action for gameobject (Entry: %u GoType: %u)", spellId, GetEntry(), GetGoType());
        else
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_OUTDOORPVP, "WORLD: %u non-dbc spell was handled by OutdoorPvP", spellId);
#endif
        return;
    }
    
    if (Player* player = user->ToPlayer())
        sOutdoorPvPMgr->HandleCustomSpell(player, spellId, this);

    if (spellCaster)
        spellCaster->CastSpell(user, spellInfo, triggered);
    else
        CastSpell(user, spellId);
}

void GameObject::CastSpell(Unit* target, uint32 spellId)
{ 
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
        return;

    bool self = false;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (spellInfo->Effects[i].TargetA.GetTarget() == TARGET_UNIT_CASTER)
        {
            self = true;
            break;
        }
    }

    if (self)
    {
        if (target)
            target->CastSpell(target, spellInfo, true);
        return;
    }

    //summon world trigger
    Creature* trigger = SummonTrigger(GetPositionX(), GetPositionY(), GetPositionZ(), 0, spellInfo->CalcCastTime() + 2000, true);
    if (!trigger)
        return;

    if (Unit* owner = GetOwner())
    {
        trigger->SetLevel(owner->getLevel(), false);
        trigger->setFaction(owner->getFaction());
        // needed for GO casts for proper target validation checks
        trigger->SetOwnerGUID(owner->GetGUID());
        // xinef: fixes some duel bugs with traps]
        if (owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE))
            trigger->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
        if (owner->IsFFAPvP())
            trigger->SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);

        // xinef: Remove Immunity flags
        trigger->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
        // xinef: set proper orientation, fixes cast against stealthed targets
        if (target)
            trigger->SetInFront(target);
        trigger->CastSpell(target ? target : trigger, spellInfo, true, 0, 0, owner->GetGUID());
    }
    else
    {
        // xinef: set faction of gameobject, if no faction - assume hostile
        trigger->setFaction(GetTemplateAddon() && GetTemplateAddon()->faction ? GetTemplateAddon()->faction : 14);
        // Set owner guid for target if no owner availble - needed by trigger auras
        // - trigger gets despawned and there's no caster avalible (see AuraEffect::TriggerSpell())
        // xinef: set proper orientation, fixes cast against stealthed targets
        if (target)
            trigger->SetInFront(target);
        trigger->CastSpell(target ? target : trigger, spellInfo, true, 0, 0, target ? target->GetGUID() : 0);
    }
}

void GameObject::SendCustomAnim(uint32 anim)
{ 
    WorldPacket data(SMSG_GAMEOBJECT_CUSTOM_ANIM, 8+4);
    data << GetGUID();
    data << uint32(anim);
    SendMessageToSet(&data, true);
}

bool GameObject::IsInRange(float x, float y, float z, float radius) const
{ 
    GameObjectDisplayInfoEntry const* info = sGameObjectDisplayInfoStore.LookupEntry(m_goInfo->displayId);
    if (!info)
        return IsWithinDist3d(x, y, z, radius);

    float sinA = sin(GetOrientation());
    float cosA = cos(GetOrientation());
    float dx = x - GetPositionX();
    float dy = y - GetPositionY();
    float dz = z - GetPositionZ();
    float dist = sqrt(dx*dx + dy*dy);
    //! Check if the distance between the 2 objects is 0, can happen if both objects are on the same position.
    //! The code below this check wont crash if dist is 0 because 0/0 in float operations is valid, and returns infinite
    if (G3D::fuzzyEq(dist, 0.0f))
        return true;

    float scale = GetFloatValue(OBJECT_FIELD_SCALE_X);
    float sinB = dx / dist;
    float cosB = dy / dist;
    dx = dist * (cosA * cosB + sinA * sinB);
    dy = dist * (cosA * sinB - sinA * cosB);
    return dx < (info->maxX*scale) + radius && dx > (info->minX*scale) - radius
        && dy < (info->maxY*scale) + radius && dy > (info->minY*scale) - radius
        && dz < (info->maxZ*scale) + radius && dz > (info->minZ*scale) - radius;
}

// pussywizard!
void GameObject::SendMessageToSetInRange(WorldPacket* data, float dist, bool /*self*/, bool includeMargin, Player const* skipped_rcvr)
{ 
    dist += GetObjectSize();
    if (includeMargin)
        dist += VISIBILITY_COMPENSATION * 2.0f; // pussywizard: to ensure everyone receives all important packets
    Trinity::MessageDistDeliverer notifier(this, data, dist, false, skipped_rcvr);
    VisitNearbyWorldObject(dist, notifier);
}

void GameObject::EventInform(uint32 eventId)
{ 
    if (!eventId)
        return;

    if (AI())
        AI()->EventInform(eventId);

    if (m_zoneScript)
        m_zoneScript->ProcessEvent(this, eventId);
}

// overwrite WorldObject function for proper name localization
std::string const& GameObject::GetNameForLocaleIdx(LocaleConstant loc_idx) const
{
    if (loc_idx != DEFAULT_LOCALE)
    {
        uint8 uloc_idx = uint8(loc_idx);
        if (GameObjectLocale const* cl = sObjectMgr->GetGameObjectLocale(GetEntry()))
            if (cl->Name.size() > uloc_idx && !cl->Name[uloc_idx].empty())
                return cl->Name[uloc_idx];
    }

    return GetName();
}

void GameObject::UpdatePackedRotation()
{
    static const int32 PACK_YZ = 1 << 20;
    static const int32 PACK_X = PACK_YZ << 1;
    static const int32 PACK_YZ_MASK = (PACK_YZ << 1) - 1;
    static const int32 PACK_X_MASK = (PACK_X << 1) - 1;
    int8 w_sign = (m_worldRotation.w >= 0.f ? 1 : -1);
    int64 x = int32(m_worldRotation.x * PACK_X)  * w_sign & PACK_X_MASK;
    int64 y = int32(m_worldRotation.y * PACK_YZ) * w_sign & PACK_YZ_MASK;
    int64 z = int32(m_worldRotation.z * PACK_YZ) * w_sign & PACK_YZ_MASK;
    m_packedRotation = z | (y << 21) | (x << 42);
}

void GameObject::SetWorldRotation(G3D::Quat const& rot)
{
    G3D::Quat rotation;
    // Temporary solution for gameobjects that have no rotation data in DB:
    if (G3D::fuzzyEq(rot.z, 0.f) && G3D::fuzzyEq(rot.w, 0.f))
        rotation = G3D::Quat::fromAxisAngleRotation(G3D::Vector3::unitZ(), GetOrientation());
    else
        rotation = rot;

    rotation.unitize();
    m_worldRotation = rotation;
    UpdatePackedRotation();
}

void GameObject::SetTransportPathRotation(float qx, float qy, float qz, float qw)
{
    SetFloatValue(GAMEOBJECT_PARENTROTATION + 0, qx);
    SetFloatValue(GAMEOBJECT_PARENTROTATION + 1, qy);
    SetFloatValue(GAMEOBJECT_PARENTROTATION + 2, qz);
    SetFloatValue(GAMEOBJECT_PARENTROTATION + 3, qw);
}

void GameObject::SetWorldRotationAngles(float z_rot, float y_rot, float x_rot)
{
    SetWorldRotation(G3D::Quat(G3D::Matrix3::fromEulerAnglesZYX(z_rot, y_rot, x_rot)));
}

void GameObject::ModifyHealth(int32 change, Unit* attackerOrHealer /*= NULL*/, uint32 spellId /*= 0*/)
{ 
    if (!IsDestructibleBuilding())
        return;

    if (!m_goValue.Building.MaxHealth || !change)
        return;

    if (!m_allowModifyDestructibleBuilding)
        change = 0;

    // prevent double destructions of the same object
    if (change < 0 && !m_goValue.Building.Health)
        return;

    if (int32(m_goValue.Building.Health) + change <= 0)
        m_goValue.Building.Health = 0;
    else if (int32(m_goValue.Building.Health) + change >= int32(m_goValue.Building.MaxHealth))
        m_goValue.Building.Health = m_goValue.Building.MaxHealth;
    else
        m_goValue.Building.Health += change;

    // Set the health bar, value = 255 * healthPct;
    SetGoAnimProgress(m_goValue.Building.Health * 255 / m_goValue.Building.MaxHealth);

    Player* player = attackerOrHealer->GetCharmerOrOwnerPlayerOrPlayerItself();

    // dealing damage, send packet
    // TODO: is there any packet for healing?
    if (player)
    {
        WorldPacket data(SMSG_DESTRUCTIBLE_BUILDING_DAMAGE, 8 + 8 + 8 + 4 + 4);
        data.appendPackGUID(GetGUID());
        data.appendPackGUID(attackerOrHealer->GetGUID());
        data.appendPackGUID(player->GetGUID());
        data << uint32(-change);                    // change  < 0 triggers SPELL_BUILDING_HEAL combat log event
                                                    // change >= 0 triggers SPELL_BUILDING_DAMAGE event
        data << uint32(spellId);
        player->GetSession()->SendPacket(&data);
    }

    GameObjectDestructibleState newState = GetDestructibleState();

    if (!m_goValue.Building.Health)
        newState = GO_DESTRUCTIBLE_DESTROYED;
    else if (m_goValue.Building.Health <= GetGOInfo()->building.damagedNumHits)
        newState = GO_DESTRUCTIBLE_DAMAGED;
    else if (m_goValue.Building.Health == m_goValue.Building.MaxHealth)
        newState = GO_DESTRUCTIBLE_INTACT;

    if (newState == GetDestructibleState())
        return;

    SetDestructibleState(newState, player, false);
}

void GameObject::SetDestructibleState(GameObjectDestructibleState state, Player* eventInvoker /*= NULL*/, bool setHealth /*= false*/)
{ 
    // the user calling this must know he is already operating on destructible gameobject
    ASSERT(GetGoType() == GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING);

    switch (state)
    {
        case GO_DESTRUCTIBLE_INTACT:
            RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_DAMAGED | GO_FLAG_DESTROYED);
            SetDisplayId(m_goInfo->displayId);
            if (setHealth)
            {
                m_goValue.Building.Health = m_goValue.Building.MaxHealth;
                SetGoAnimProgress(255);
            }
            EnableCollision(true);
            break;
        case GO_DESTRUCTIBLE_DAMAGED:
        {
#ifdef ELUNA
            sEluna->OnDamaged(this, eventInvoker);
#endif
            EventInform(m_goInfo->building.damagedEvent);
            sScriptMgr->OnGameObjectDamaged(this, eventInvoker);
            if (BattlegroundMap* bgMap = GetMap()->ToBattlegroundMap())
                if (Battleground* bg = bgMap->GetBG())
                    bg->EventPlayerDamagedGO(eventInvoker, this, m_goInfo->building.damagedEvent);

            RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_DESTROYED);
            SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_DAMAGED);

            uint32 modelId = m_goInfo->building.damagedDisplayId;
            if (DestructibleModelDataEntry const* modelData = sDestructibleModelDataStore.LookupEntry(m_goInfo->building.destructibleData))
                if (modelData->DamagedDisplayId)
                    modelId = modelData->DamagedDisplayId;
            SetDisplayId(modelId);

            if (setHealth)
            {
                m_goValue.Building.Health = m_goInfo->building.damagedNumHits;
                uint32 maxHealth = m_goValue.Building.MaxHealth;
                // in this case current health is 0 anyway so just prevent crashing here
                if (!maxHealth)
                    maxHealth = 1;
                SetGoAnimProgress(m_goValue.Building.Health * 255 / maxHealth);
            }
            break;
        }
        case GO_DESTRUCTIBLE_DESTROYED:
        {
#ifdef ELUNA
            sEluna->OnDestroyed(this, eventInvoker);
#endif
            sScriptMgr->OnGameObjectDestroyed(this, eventInvoker);
            EventInform(m_goInfo->building.destroyedEvent);
            if (BattlegroundMap* bgMap = GetMap()->ToBattlegroundMap())
            {
                if (Battleground* bg = bgMap->GetBG())
                {
                    bg->EventPlayerDamagedGO(eventInvoker, this, m_goInfo->building.destroyedEvent);
                    bg->DestroyGate(eventInvoker, this);
                }
            }

            RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_DAMAGED);
            SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_DESTROYED);

            uint32 modelId = m_goInfo->building.destroyedDisplayId;
            if (DestructibleModelDataEntry const* modelData = sDestructibleModelDataStore.LookupEntry(m_goInfo->building.destructibleData))
                if (modelData->DestroyedDisplayId)
                    modelId = modelData->DestroyedDisplayId;
            SetDisplayId(modelId);

            if (setHealth)
            {
                m_goValue.Building.Health = 0;
                SetGoAnimProgress(0);
            }
            EnableCollision(false);
            break;
        }
        case GO_DESTRUCTIBLE_REBUILDING:
        {
            EventInform(m_goInfo->building.rebuildingEvent);
            RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_DAMAGED | GO_FLAG_DESTROYED);

            uint32 modelId = m_goInfo->displayId;
            if (DestructibleModelDataEntry const* modelData = sDestructibleModelDataStore.LookupEntry(m_goInfo->building.destructibleData))
                if (modelData->RebuildingDisplayId)
                    modelId = modelData->RebuildingDisplayId;
            SetDisplayId(modelId);

            // restores to full health
            if (setHealth)
            {
                m_goValue.Building.Health = m_goValue.Building.MaxHealth;
                SetGoAnimProgress(255);
            }
            EnableCollision(true);
            break;
        }
    }
}

void GameObject::SetLootState(LootState state, Unit* unit)
{ 
    m_lootState = state;
#ifdef ELUNA
    sEluna->OnLootStateChanged(this, state);
#endif
    AI()->OnStateChanged(state, unit);
    sScriptMgr->OnGameObjectLootStateChanged(this, state, unit);
    // pussywizard: lootState has nothing to do with collision, it depends entirely on GOState. Loot state is for timed close/open door and respawning, which then sets GOState
    /*if (m_model) 
    {
        // startOpen determines whether we are going to add or remove the LoS on activation
        bool startOpen = (GetGoType() == GAMEOBJECT_TYPE_DOOR || GetGoType() == GAMEOBJECT_TYPE_BUTTON ? GetGOInfo()->door.startOpen : false);

        // Use the current go state
        if (GetGoState() == GO_STATE_ACTIVE)
            startOpen = !startOpen;

        if (state == GO_ACTIVATED || state == GO_JUST_DEACTIVATED)
            EnableCollision(startOpen);
        else if (state == GO_READY)
            EnableCollision(!startOpen);
    }*/
}

void GameObject::SetGoState(GOState state)
{ 
    SetByteValue(GAMEOBJECT_BYTES_1, 0, state);
#ifdef ELUNA
    sEluna->OnGameObjectStateChanged(this, state);
#endif
    sScriptMgr->OnGameObjectStateChanged(this, state);
    if (m_model)
    {
        if (!IsInWorld())
            return;

        // pussywizard: this startOpen is unneeded here, collision depends entirely on current GOState
        EnableCollision(state == GO_STATE_READY || IsTransport());
        // pussywizard: commented out everything below

        // startOpen determines whether we are going to add or remove the LoS on activation
        /*bool startOpen = (GetGoType() == GAMEOBJECT_TYPE_DOOR || GetGoType() == GAMEOBJECT_TYPE_BUTTON ? GetGOInfo()->door.startOpen : false);

        if (GetGOData() && GetGOData()->go_state == GO_STATE_READY)
            startOpen = !startOpen;

        if (state == GO_STATE_ACTIVE || state == GO_STATE_ACTIVE_ALTERNATIVE)
            EnableCollision(startOpen);
        else if (state == GO_STATE_READY)
            EnableCollision(!startOpen);*/
    }
}

void GameObject::SetDisplayId(uint32 displayid)
{ 
    SetUInt32Value(GAMEOBJECT_DISPLAYID, displayid);
    UpdateModel();
}

void GameObject::SetPhaseMask(uint32 newPhaseMask, bool update)
{ 
    WorldObject::SetPhaseMask(newPhaseMask, update);

    if (m_model && m_model->isEnabled())
        EnableCollision(true);
}

void GameObject::EnableCollision(bool enable)
{ 
    if (!m_model)
        return;

    /*if (enable && !GetMap()->ContainsGameObjectModel(*m_model))
        GetMap()->InsertGameObjectModel(*m_model);*/

    uint32 phaseMask = 0;
    if (enable && !DisableMgr::IsDisabledFor(DISABLE_TYPE_GO_LOS, GetEntry(), NULL))
        phaseMask = GetPhaseMask();

    m_model->enable(phaseMask);
}

void GameObject::UpdateModel()
{ 
    if (!IsInWorld())
        return;
    if (m_model)
        if (GetMap()->ContainsGameObjectModel(*m_model))
            GetMap()->RemoveGameObjectModel(*m_model);
    delete m_model;
    m_model = GameObjectModel::Create(*this);
    if (m_model)
        GetMap()->InsertGameObjectModel(*m_model);
}

Player* GameObject::GetLootRecipient() const
{ 
    if (!m_lootRecipient)
        return NULL;
    return ObjectAccessor::FindPlayerInOrOutOfWorld(m_lootRecipient);
}

Group* GameObject::GetLootRecipientGroup() const
{ 
    if (!m_lootRecipientGroup)
        return NULL;
    return sGroupMgr->GetGroupByGUID(m_lootRecipientGroup);
}

void GameObject::SetLootRecipient(Unit* unit)
{ 
    // set the player whose group should receive the right
    // to loot the creature after it dies
    // should be set to NULL after the loot disappears

    if (!unit)
    {
        m_lootRecipient = 0;
        m_lootRecipientGroup = 0;
        return;
    }

    if (unit->GetTypeId() != TYPEID_PLAYER && !unit->IsVehicle())
        return;

    Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (!player)                                             // normal creature, no player involved
        return;

    m_lootRecipient = player->GetGUID();
    if (Group* group = player->GetGroup())
        m_lootRecipientGroup = group->GetLowGUID();
}

bool GameObject::IsLootAllowedFor(Player const* player) const
{ 
    if (!m_lootRecipient && !m_lootRecipientGroup)
        return true;

    if (player->GetGUID() == m_lootRecipient)
        return true;

    if (player->HasPendingBind())
        return false;

    Group const* playerGroup = player->GetGroup();
    if (!playerGroup || playerGroup != GetLootRecipientGroup()) // if we dont have a group we arent the recipient
        return false;                                           // if go doesnt have group bound it means it was solo killed by someone else

    return true;
}

void GameObject::BuildValuesUpdate(uint8 updateType, ByteBuffer* data, Player* target) const
{ 
    if (!target)
        return;

    bool forcedFlags = GetGoType() == GAMEOBJECT_TYPE_CHEST && GetGOInfo()->chest.groupLootRules && HasLootRecipient();
    bool targetIsGM = target->IsGameMaster() && AccountMgr::IsGMAccount(target->GetSession()->GetSecurity());

    ByteBuffer fieldBuffer;

    UpdateMask updateMask;
    updateMask.SetCount(m_valuesCount);

    uint32* flags = GameObjectUpdateFieldFlags;
    uint32 visibleFlag = UF_FLAG_PUBLIC;
    if (GetOwnerGUID() == target->GetGUID())
        visibleFlag |= UF_FLAG_OWNER;

    for (uint16 index = 0; index < m_valuesCount; ++index)
    {
        if (_fieldNotifyFlags & flags[index] ||
            ((updateType == UPDATETYPE_VALUES ? _changesMask.GetBit(index) : m_uint32Values[index]) && (flags[index] & visibleFlag)) ||
            (index == GAMEOBJECT_FLAGS && forcedFlags))
        {
            updateMask.SetBit(index);

            if (index == GAMEOBJECT_DYNAMIC)
            {
                uint16 dynFlags = 0;
                int16 pathProgress = -1;
                switch (GetGoType())
                {
                    case GAMEOBJECT_TYPE_QUESTGIVER:
                        if (ActivateToQuest(target))
                            dynFlags |= GO_DYNFLAG_LO_ACTIVATE;
                        break;
                    case GAMEOBJECT_TYPE_CHEST:
                    case GAMEOBJECT_TYPE_GOOBER:
                        if (ActivateToQuest(target))
                            dynFlags |= GO_DYNFLAG_LO_ACTIVATE | GO_DYNFLAG_LO_SPARKLE;
                        else if (targetIsGM)
                            dynFlags |= GO_DYNFLAG_LO_ACTIVATE;
                        break;
                    case GAMEOBJECT_TYPE_GENERIC:
                        if (ActivateToQuest(target))
                            dynFlags |= GO_DYNFLAG_LO_SPARKLE;
                        break;
                    case GAMEOBJECT_TYPE_TRANSPORT:
                        if (const StaticTransport* t = ToStaticTransport())
                            if (t->GetPauseTime())
                            {
                                if (GetGoState() == GO_STATE_READY)
                                {
                                    if (t->GetPathProgress() >= t->GetPauseTime()) // if not, send 100% progress
                                        pathProgress = int16(float(t->GetPathProgress() - t->GetPauseTime()) / float(t->GetPeriod() - t->GetPauseTime()) * 65535.0f);
                                }
                                else
                                {
                                    if (t->GetPathProgress() <= t->GetPauseTime()) // if not, send 100% progress
                                        pathProgress = int16(float(t->GetPathProgress()) / float(t->GetPauseTime()) * 65535.0f);
                                }
                            }
                            // else it's ignored
                        break;
                    case GAMEOBJECT_TYPE_MO_TRANSPORT:
                        if (const MotionTransport* t = ToMotionTransport())
                            pathProgress = int16(float(t->GetPathProgress()) / float(t->GetPeriod()) * 65535.0f);
                        break;
                    default:
                        break;
                }

                fieldBuffer << uint16(dynFlags);
                fieldBuffer << int16(pathProgress);
            }
            else if (index == GAMEOBJECT_FLAGS)
            {
                uint32 flags = m_uint32Values[GAMEOBJECT_FLAGS];
                if (GetGoType() == GAMEOBJECT_TYPE_CHEST)
                    if (GetGOInfo()->chest.groupLootRules && !IsLootAllowedFor(target))
                        flags |= GO_FLAG_LOCKED | GO_FLAG_NOT_SELECTABLE;

                fieldBuffer << flags;
            }
            else
                fieldBuffer << m_uint32Values[index];                // other cases
        }
    }

    *data << uint8(updateMask.GetBlockCount());
    updateMask.AppendToPacket(data);
    data->append(fieldBuffer);
}

void GameObject::GetRespawnPosition(float &x, float &y, float &z, float* ori /* = NULL*/) const
{ 
    if (m_DBTableGuid)
    {
        if (GameObjectData const* data = sObjectMgr->GetGOData(GetDBTableGUIDLow()))
        {
            x = data->posX;
            y = data->posY;
            z = data->posZ;
            if (ori)
                *ori = data->orientation;
            return;
        }
    }

    x = GetPositionX();
    y = GetPositionY();
    z = GetPositionZ();
    if (ori)
        *ori = GetOrientation();
}

void GameObject::SetPosition(float x, float y, float z, float o)
{ 
    // pussywizard: do not call for MotionTransport and other gobjects not in grid

    if (!Trinity::IsValidMapCoord(x, y, z, o))
        return;

    GetMap()->GameObjectRelocation(this, x, y, z, o);
}

float GameObject::GetInteractionDistance()
{ 
    switch (GetGoType())
    {
        /// @todo find out how the client calculates the maximal usage distance to spellless working
        // gameobjects like guildbanks and mailboxes - 10.0 is a just an abitrary choosen number
        case GAMEOBJECT_TYPE_GUILD_BANK:
        case GAMEOBJECT_TYPE_MAILBOX:
            return 10.0f;
        case GAMEOBJECT_TYPE_FISHINGHOLE:
        case GAMEOBJECT_TYPE_FISHINGNODE:
            return 20.0f + CONTACT_DISTANCE; // max spell range
        default:
            return INTERACTION_DISTANCE;
    }
}

void GameObject::UpdateModelPosition()
{
    if (!m_model)
        return;

    if (GetMap()->ContainsGameObjectModel(*m_model))
    {
        GetMap()->RemoveGameObjectModel(*m_model);
        m_model->UpdatePosition();
        GetMap()->InsertGameObjectModel(*m_model);
    }
}
