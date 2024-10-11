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
#include "Map.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "scholomance.h"

enum Spells
{
    SPELL_ARCANE_MISSILES = 15790,
    SPELL_CURSE_DARKMASTER = 18702,
    SPELL_SHADOW_SHIELD = 12040,
    SPELL_SHADOW_PORTAL = 17950
};

enum BossData
{
    DATA_PLAYER_KILLED,
    GANDLING_ROOM_TO_USE
};

enum Timers
{
    TIMER_ARCANE_MIN = 8000,
    TIMER_ARCANE_MAX = 14000,
    TIMER_CURSE_MIN = 20000,
    TIMER_CURSE_MAX = 30000,
    TIMER_SHIELD_MIN = 30000,
    TIMER_SHIELD_MAX = 40000,
    TIMER_PORTAL = 25000
};

 enum IdPortalSpells
 {
     SPELL_SHADOW_PORTAL_UP_NORTH    = 17863,
     SPELL_SHADOW_PORTAL_UP_EAST     = 17939,
     SPELL_SHADOW_PORTAL_UP_SOUTH    = 17943,
     SPELL_SHADOW_PORTAL_DOWN_NORTH  = 17944,
     SPELL_SHADOW_PORTAL_DOWN_EAST   = 17946,
     SPELL_SHADOW_PORTAL_DOWN_SOUTH  = 17948
 };

 // don't change the order of these 3 arrays. The order of the arrays should match and match also with scholomance.cpp
 const uint32 GandlingGateIds[] = {GO_GATE_GANDLING_DOWN_NORTH, GO_GATE_GANDLING_DOWN_EAST, GO_GATE_GANDLING_DOWN_SOUTH,
                                GO_GATE_GANDLING_UP_NORTH, GO_GATE_GANDLING_UP_EAST, GO_GATE_GANDLING_UP_SOUTH, GO_GATE_GANDLING_ENTRANCE};

 const uint32 GandlingPortalSpells[] = {SPELL_SHADOW_PORTAL_DOWN_NORTH, SPELL_SHADOW_PORTAL_DOWN_EAST, SPELL_SHADOW_PORTAL_DOWN_SOUTH,
                                            SPELL_SHADOW_PORTAL_UP_NORTH, SPELL_SHADOW_PORTAL_UP_EAST, SPELL_SHADOW_PORTAL_UP_SOUTH};

 Position const SummonPos[3 * 6] =
{
    // The Shadow Vault // down north
    { 245.3716f, 0.628038f, 72.73877f, 0.01745329f },
    { 240.9920f, 3.405653f, 72.73877f, 6.143559f },
    { 240.9543f, -3.182943f, 72.73877f, 0.2268928f },
    // Barov Family Vault // down east
    { 181.8245f, -42.58117f, 75.4812f, 4.660029f },
    { 177.7456f, -42.74745f, 75.4812f, 4.886922f },
    { 185.6157f, -42.91200f, 75.4812f, 4.45059f },
    // Vault of the Ravenian // down south
    { 136.362f, 6.221f, 75.40f, 3.14f },
    { 130.79f, -0.91f, 75.40f, 3.14f },
    { 136.362f, -8.221f, 75.40f, 3.14f },
     // Hall of Secrets // up north
     {230.80f, 0.138f, 85.23f, 0.0f},
     {241.23f, -6.979f, 85.23f, 0.0f},
     {246.65f, 4.227f, 84.85f, 0.0f},
     // The Hall of the damned // up east
     {177.9624f, -68.23893f, 84.95197f, 3.228859f},
     {183.7705f, -61.43489f, 84.92424f, 5.148721f},
     {184.7035f, -77.74805f, 84.92424f, 4.660029f},
     // The Coven // up south
     {111.7203f, -1.105035f, 85.45985f, 3.961897f},
     {118.0079f, 6.430664f, 85.31169f, 2.408554f},
     {120.0276f, -7.496636f, 85.31169f, 2.984513f}
 };

enum DoorState
{
    OPEN = true,
    CLOSED = false
};

class boss_darkmaster_gandling : public CreatureScript
{
public:
    boss_darkmaster_gandling() : CreatureScript("boss_darkmaster_gandling") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScholomanceAI<boss_darkmaster_gandlingAI>(creature);
    }

    struct boss_darkmaster_gandlingAI : public BossAI
    {
        boss_darkmaster_gandlingAI(Creature* creature) : BossAI(creature, DATA_DARKMASTER_GANDLING), summons(me) { }

        SummonList summons;
        Creature* Guardians[6][3]; // 6 rooms, 3 mobs, access through GuardiansList[NORTH+EAST][1]
        uint32 current_room;

        // Only the 6 gates that gandling plays with.
        void SetGate(uint8 gate, bool open)
        {
            if (gate < 6)
            {
                instance->HandleGameObject(instance->GetGuidData(GandlingGateIds[gate]), open);
            }
        }

        // opens gates directly closed by me. Not the entrance
        void OpenAllGates()
        {
            for (uint8 i = 0; i < 6; i++)
            {
                SetGate(i, OPEN);
            }
        }

        void SummonedCreatureDespawn(Creature* cr) override
        {
            int room = -1;
            // remove the mob from the list and keep track of which room he is in.
            for (uint8 i = 0; i < 6; i++)
            {
                for (uint8 j = 0; j < 3; j++)
                {
                    if (Guardians[i][j] && Guardians[i][j]->GetGUID() == cr->GetGUID())
                    {
                        room = i;
                        Guardians[i][j] = nullptr;
                    }
                }
            }

            // check if the room is now empty
            if (room >= 0)
            {
                for (uint8 i = 0; i < 3; i++)
                {
                    if (Guardians[room][i])
                    {
                        return;
                    }
                }
                // everybody is dead in there, we can open the gate.
                SetGate(room, OPEN);
            }
        }

        // add mob to the room of the last portal, that's the only place we can have added mobs.
        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);
            uint32 room = GetData(GANDLING_ROOM_TO_USE);
            if (room < 6)
            {
                for (uint8 i = 0; i < 3; i++)
                {
                    if (!Guardians[room][i])
                    {
                        Guardians[room][i] = cr;
                        break;
                    }
                }
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            DoZoneInCombat();
            instance->SetData(DATA_DARKMASTER_GANDLING, IN_PROGRESS);
            events.Reset();
            events.ScheduleEvent(SPELL_ARCANE_MISSILES, TIMER_ARCANE_MIN);
            events.ScheduleEvent(SPELL_CURSE_DARKMASTER, TIMER_CURSE_MIN);
            events.ScheduleEvent(SPELL_SHADOW_SHIELD, TIMER_SHIELD_MIN);
            events.ScheduleEvent(SPELL_SHADOW_PORTAL, TIMER_PORTAL);
        }

        void JustDied(Unit* /*killer*/) override
        {
            instance->SetData(DATA_DARKMASTER_GANDLING, DONE);
            OpenAllGates();
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_PLAYER_KILLED:
                    if (data < 6)
                    {
                        SetGate(data, OPEN);
                        for (int i = 0; i < 3; i++)
                        {
                            if (Guardians[data][i])
                            {
                                Guardians[data][i]->SetInCombatWithZone();
                            }
                        }
                    }
                    break;
                case GANDLING_ROOM_TO_USE:
                    if (data < 6)
                    {
                        current_room = data;
                    }
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case GANDLING_ROOM_TO_USE:
                    return current_room;
            }
            return 0;
        }

        void Reset() override
        {
            _Reset();
            instance->SetData(DATA_DARKMASTER_GANDLING, NOT_STARTED);
            if (instance->GetData(DATA_MINI_BOSSES) != 6)
            {
                me->SetVisible(false);
                me->SetFaction(35);
            }
            else
            {
                me->SetVisible(true);
                me->SetFaction(21);
            }
            OpenAllGates();
            summons.DespawnAll();
            for (int i = 0; i < 6; i++)
            {
                for (int j =0; j < 3; j++)
                {
                    Guardians[i][j] = nullptr;
                }
            }
        }

        // Finds a random room that is not in use
        uint32 FindRoom()
        {
            uint32 attempts = 0;
            uint32 room = urand(0, 5);
            do
            {
                room = (room + 1) % 6;
                attempts++;
            } while ((Guardians[room][0] || Guardians[room][1] || Guardians[room][2]) && attempts < 7);

            if (attempts == 7)
            {
                room = 7; // used as error
            }

            return room;
        }

        // spawns the 3 mobs in a given room.
        void SpawnMobsInRoom(uint32 room)
        {
            for (uint8 i = 0; i < 3; ++i)
            {
                if (Creature* summon = me->SummonCreature(NPC_RISEN_GUARDIAN, SummonPos[room*3 + i], TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 120000))
                {
                    summon->GetMotionMaster()->MoveRandom(8.0f);
                }
            }
        }

        // used for shadow portal
        void SpellHitTarget(Unit* target, SpellInfo const* spellinfo) override
        {
            uint32 room = 0;
            if (spellinfo && spellinfo->Id == SPELL_SHADOW_PORTAL && target)
            {
                room = GetData(GANDLING_ROOM_TO_USE);
                SetGate(room, CLOSED);
                SpawnMobsInRoom(room);
                DoCast(target, GandlingPortalSpells[room], true); // needs triggered somehow.

                auto victim = me->GetVictim();
                if (victim && (target->GetGUID() == victim->GetGUID()))
                {
                    me->AddThreat(victim, -1000000); // drop current player, add a ton to second. This should guarantee that we don't end up with both 1 and 2 in a cage...
                    if (Unit* newTarget = SelectTarget(SelectTargetMethod::MaxThreat, 1, 200.0f)) // search in whole room
                    {
                        me->AddThreat(newTarget, 1000000);
                    }
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            uint32 room = 0;
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case SPELL_ARCANE_MISSILES:
                    DoCastVictim(SPELL_ARCANE_MISSILES);
                    events.ScheduleEvent(SPELL_ARCANE_MISSILES, urand(TIMER_ARCANE_MIN, TIMER_ARCANE_MAX));
                    break;
                case SPELL_CURSE_DARKMASTER:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                    {
                        DoCast(target, SPELL_CURSE_DARKMASTER);
                    }
                    events.ScheduleEvent(SPELL_ARCANE_MISSILES, urand(TIMER_ARCANE_MIN, TIMER_ARCANE_MAX));
                    break;
                case SPELL_SHADOW_SHIELD:
                    DoCastSelf(SPELL_SHADOW_SHIELD);
                    events.ScheduleEvent(SPELL_ARCANE_MISSILES, urand(TIMER_ARCANE_MIN, TIMER_ARCANE_MAX));
                    break;

                case SPELL_SHADOW_PORTAL:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 15.0, true))
                    {
                        room = FindRoom();
                        if (room < 6)
                        {
                            SetData(GANDLING_ROOM_TO_USE, room);
                            DoCast(target, SPELL_SHADOW_PORTAL); // don't use triggered here
                        }
                    }
                    events.ScheduleEvent(SPELL_SHADOW_PORTAL, TIMER_PORTAL);
                    break;
                default:
                    break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

class npc_risen_guardian : public CreatureScript
{
public:
    npc_risen_guardian() : CreatureScript("npc_risen_guardian") {}

    struct npc_risen_guardianAI : public ScriptedAI
    {
        npc_risen_guardianAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = me->GetInstanceScript();
            room = -1;
        }

        InstanceScript* instance;
        int room;
        Unit* Gandling;

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner->IsCreature())
            {
                return;
            }

            Gandling = summoner->ToCreature();
            if (instance)
            {
                room = Gandling->GetAI()->GetData(GANDLING_ROOM_TO_USE); // it's set just before my spawn
            }
        }

        void KilledUnit(Unit* /* target */) override
        {
            if (Gandling)
            {
                Gandling->GetAI()->SetData(DATA_PLAYER_KILLED, room);
            }
        }

    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScholomanceAI<npc_risen_guardianAI>(creature);
    }
};

void AddSC_boss_darkmaster_gandling()
{
    new boss_darkmaster_gandling();
    new npc_risen_guardian();
}
