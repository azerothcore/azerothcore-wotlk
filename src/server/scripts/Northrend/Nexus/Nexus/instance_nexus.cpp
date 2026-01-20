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

#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"
#include "nexus.h"
#include "Player.h"
#include "Group.h"

DoorData const doorData[] =
{
    { GO_TELESTRA_SPHERE,   DATA_TELESTRA_ORB,  DOOR_TYPE_PASSAGE },
    { GO_ANOMALUS_SPHERE,   DATA_ANOMALUS_ORB,  DOOR_TYPE_PASSAGE },
    { GO_ORMOROK_SPHERE,    DATA_ORMOROK_ORB,   DOOR_TYPE_PASSAGE },
    { 0,                    0,                  DOOR_TYPE_ROOM    }
};

class instance_nexus : public InstanceMapScript
{
public:
    instance_nexus() : InstanceMapScript("instance_nexus", MAP_THE_NEXUS) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_nexus_InstanceMapScript(map);
    }

    struct instance_nexus_InstanceMapScript : public InstanceScript
    {
        instance_nexus_InstanceMapScript(Map* map) : InstanceScript(map) {}

        GuidVector _frayerGUIDs;

        void Initialize() override
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_ALLIANCE_RANGER:
                    creature->SetFaction(FACTION_MONSTER_2);
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_HORDE_RANGER);
                    break;
                case NPC_ALLIANCE_BERSERKER:
                    creature->SetFaction(FACTION_MONSTER_2);
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_HORDE_BERSERKER);
                    break;
                case NPC_ALLIANCE_COMMANDER:
                    creature->SetFaction(FACTION_MONSTER_2);
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_HORDE_COMMANDER);
                    break;
                case NPC_ALLIANCE_CLERIC:
                    creature->SetFaction(FACTION_MONSTER_2);
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_HORDE_CLERIC);
                    break;
                case NPC_COMMANDER_STOUTBEARD:
                    creature->SetFaction(FACTION_MONSTER_2);
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_COMMANDER_KOLURG);
                    break;
                case NPC_CRYSTALLINE_FRAYER:
                    _frayerGUIDs.push_back(creature->GetGUID());
                    break;
            }
        }

        void KillAllFrayers()
        {
            for (ObjectGuid const& guid : _frayerGUIDs)
            {
                if (Creature* frayer = instance->GetCreature(guid))
                {
                    frayer->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    frayer->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
                    frayer->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
                    Unit::Kill(frayer, frayer);
                }
            }
        }

        void OnGameObjectCreate(GameObject* gameObject) override
        {
            switch (gameObject->GetEntry())
            {
                case GO_TELESTRA_SPHERE:
                    if (GetBossState(DATA_TELESTRA_ORB) != DONE && GetBossState(DATA_MAGUS_TELESTRA_EVENT) == DONE)
                        gameObject->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    AddDoor(gameObject);
                    break;
                case GO_ANOMALUS_SPHERE:
                    if (GetBossState(DATA_ANOMALUS_ORB) != DONE && GetBossState(DATA_ANOMALUS_EVENT) == DONE)
                        gameObject->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    AddDoor(gameObject);
                    break;
                case GO_ORMOROK_SPHERE:
                    if (GetBossState(DATA_ORMOROK_ORB) != DONE && GetBossState(DATA_ORMOROK_EVENT) == DONE)
                        gameObject->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    AddDoor(gameObject);
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* gameObject) override
        {
            switch (gameObject->GetEntry())
            {
                case GO_TELESTRA_SPHERE:
                case GO_ANOMALUS_SPHERE:
                case GO_ORMOROK_SPHERE:
                    RemoveDoor(gameObject);
                    break;
            }
        }

        void SetData(uint32 type, uint32) override
        {
            switch (type)
            {
                case GO_TELESTRA_SPHERE:
                    SetBossState(DATA_TELESTRA_ORB, NOT_STARTED);
                    SetBossState(DATA_TELESTRA_ORB, DONE);
                    break;
                case GO_ANOMALUS_SPHERE:
                    SetBossState(DATA_ANOMALUS_ORB, NOT_STARTED);
                    SetBossState(DATA_ANOMALUS_ORB, DONE);
                    break;
                case GO_ORMOROK_SPHERE:
                    SetBossState(DATA_ORMOROK_ORB, NOT_STARTED);
                    SetBossState(DATA_ORMOROK_ORB, DONE);
                    break;
            }
        }

        bool SetBossState(uint32 id, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(id, state))
                return false;

            if (state != DONE)
                return true;

            if (id == DATA_ORMOROK_EVENT)
                KillAllFrayers();

            if (id > DATA_ORMOROK_EVENT)
                return true;

            BossInfo const* bossInfo = GetBossInfo(id + DATA_TELESTRA_ORB);
            for (DoorSet::const_iterator i = bossInfo->door[DOOR_TYPE_PASSAGE].begin(); i != bossInfo->door[DOOR_TYPE_PASSAGE].end(); ++i)
                (*i)->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
            return true;
        }
    };
};

enum eFrayer
{
    SPELL_SUMMON_SEED_POD               = 52796,
    SPELL_SEED_POD                      = 48082,
    SPELL_AURA_OF_REGENERATION          = 57056,
    SPELL_CRYSTAL_BLOOM                 = 48058,
    SPELL_ENSNARE                       = 48053,

    SAY_EMOTE                           = 0
};

enum FrayerGroups
{
    GROUP_COMBAT    = 1,
    GROUP_SEED_POD  = 2
};

struct npc_crystalline_frayer : public ScriptedAI
{
    npc_crystalline_frayer(Creature* creature) : ScriptedAI(creature) { }

    bool _allowDeath;
    bool _inSeedPod;
    TaskScheduler _scheduler;

    void Reset() override
    {
        _allowDeath = false;
        _inSeedPod = false;
        _scheduler.CancelAll();

        me->RemoveAllAuras();
        me->SetObjectScale(1.0f);
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
        me->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
        me->SetRegeneratingHealth(true);
        me->SetReactState(REACT_AGGRESSIVE);
        me->GetMotionMaster()->MoveRandom(10.0f);
    }

    void JustEngagedWith(Unit*) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            _allowDeath = instance->GetBossState(DATA_ORMOROK_EVENT) == DONE;

        _scheduler.Schedule(5s, GROUP_COMBAT, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ENSNARE);
            context.Repeat(5s);
        }).Schedule(0s, GROUP_COMBAT, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CRYSTAL_BLOOM);
            context.Repeat(30s);
        });
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (!_inSeedPod)
            ScriptedAI::EnterEvadeMode(why);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (damage >= me->GetHealth())
        {
            if (!_allowDeath)
            {
                damage = 0;
                EnterSeedPod();
            }
        }
    }

    void EnterSeedPod()
    {
        _inSeedPod = true;
        _scheduler.CancelGroup(GROUP_COMBAT);

        me->AttackStop();
        me->GetThreatMgr().ClearAllThreat();
        me->CombatStop(true);
        me->RemoveAllAuras();

        me->SetReactState(REACT_PASSIVE);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
        me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
        me->SetRegeneratingHealth(false);
        me->SetObjectScale(0.6f);

        DoCastSelf(SPELL_SEED_POD, true);
        DoCastSelf(SPELL_SUMMON_SEED_POD, true);
        DoCastSelf(SPELL_AURA_OF_REGENERATION, true);

        _scheduler.Schedule(90s, GROUP_SEED_POD, [this](TaskContext /*context*/)
        {
            LeaveSeedPod();
        });
    }

    void LeaveSeedPod()
    {
        _inSeedPod = false;

        Talk(SAY_EMOTE);

        me->RemoveAurasDueToSpell(SPELL_SEED_POD);
        me->RemoveAurasDueToSpell(SPELL_AURA_OF_REGENERATION);

        me->SetObjectScale(1.0f);
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
        me->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
        me->SetRegeneratingHealth(true);

        me->SetReactState(REACT_AGGRESSIVE);
        me->GetMotionMaster()->MoveRandom(10.0f);
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);

        if (_inSeedPod)
            return;

        if (!UpdateVictim())
            return;
    }
};

void AddSC_instance_nexus()
{
    new instance_nexus();
    RegisterNexusCreatureAI(npc_crystalline_frayer);
}
