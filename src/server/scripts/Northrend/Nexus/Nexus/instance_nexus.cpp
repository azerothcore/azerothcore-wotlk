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

#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "ScriptedCreature.h"
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
    instance_nexus() : InstanceMapScript("instance_nexus", 576) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_nexus_InstanceMapScript(map);
    }

    struct instance_nexus_InstanceMapScript : public InstanceScript
    {
        instance_nexus_InstanceMapScript(Map* map) : InstanceScript(map) {}

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

            if (state != DONE || id > DATA_ORMOROK_EVENT)
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
    SPELL_AURA_OF_REGENERATION          = 52067,
    SPELL_CRYSTAL_BLOOM                 = 48058,
    SPELL_ENSNARE                       = 48053
};

struct npc_crystalline_frayer : public ScriptedAI
{
    npc_crystalline_frayer(Creature* creature) : ScriptedAI(creature) { }

    bool _allowDeath;
    uint32 restoreTimer;
    uint32 abilityTimer1;
    uint32 abilityTimer2;

    void Reset() override
    {
        restoreTimer = 0;
        abilityTimer1 = 0;
        abilityTimer2 = 30000;
        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
    }

    void JustEngagedWith(Unit*) override
    {
        _allowDeath = me->GetInstanceScript()->GetBossState(DATA_ORMOROK_EVENT) == DONE;
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (me->isRegeneratingHealth())
            ScriptedAI::EnterEvadeMode(why);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (damage >= me->GetHealth())
        {
            if (!_allowDeath)
            {
                me->RemoveAllAuras();
                me->GetThreatMgr().ClearAllThreat();
                me->CombatStop(true);
                damage = 0;

                me->SetReactState(REACT_PASSIVE);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetRegeneratingHealth(false);
                me->CastSpell(me, SPELL_SUMMON_SEED_POD, true);
                me->CastSpell(me, SPELL_SEED_POD, true);
                me->CastSpell(me, SPELL_AURA_OF_REGENERATION, false);
                restoreTimer = 1;
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (restoreTimer)
        {
            restoreTimer += diff;
            if (restoreTimer >= 90 * IN_MILLISECONDS)
            {
                Talk(0);
                me->SetRegeneratingHealth(true);
                restoreTimer = 0;
                me->SetReactState(REACT_AGGRESSIVE);
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            }
            return;
        }

        if (!UpdateVictim())
            return;

        abilityTimer1 += diff;
        abilityTimer2 += diff;

        if (abilityTimer1 >= 5000)
        {
            me->CastSpell(me->GetVictim(), SPELL_ENSNARE, false);
            abilityTimer1 = 0;
        }

        if (abilityTimer2 >= 30000)
        {
            me->CastSpell(me->GetVictim(), SPELL_CRYSTAL_BLOOM, false);
            abilityTimer2 = 0;
        }
    }
};

void AddSC_instance_nexus()
{
    new instance_nexus();
    RegisterNexusCreatureAI(npc_crystalline_frayer);
}
