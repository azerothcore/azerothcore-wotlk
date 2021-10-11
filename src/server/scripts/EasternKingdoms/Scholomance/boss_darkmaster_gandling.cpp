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

#include "scholomance.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Spells
{
    SPELL_ARCANE_MISSILES = 15790,
    SPELL_CURSE_DARKMASTER = 18702,
    SPELL_SHADOW_SHIELD = 12040,
    SPELL_SHADOW_PORTAL = 17950
};

// official timers
/* enum Timers
{
    TIMER_ARCANE_MIN = 8000,
    TIMER_ARCANE_MAX = 14000,
    TIMER_CURSE_MIN = 20000,
    TIMER_CURSE_MAX = 30000,
    TIMER_SHIELD_MIN = 30000,
    TIMER_SHIELD_MAX = 40000,
    TIMER_PORTAL = 25000
};*/

// temp debug timers
 enum Timers
{
    TIMER_ARCANE_MIN = 80000,
    TIMER_ARCANE_MAX = 1400000,
    TIMER_CURSE_MIN = 100000,
    TIMER_CURSE_MAX = 1500000,
    TIMER_SHIELD_MIN = 200000,
    TIMER_SHIELD_MAX = 2500000,
    TIMER_PORTAL = 10000
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

 // don't change the rooms order, due to the semi-smart way it's designed, the order matters a lot.
 const uint32 GandlingPortalSpells[] = {SPELL_SHADOW_PORTAL_DOWN_NORTH, SPELL_SHADOW_PORTAL_DOWN_EAST, SPELL_SHADOW_PORTAL_DOWN_SOUTH,
                                            SPELL_SHADOW_PORTAL_UP_NORTH, SPELL_SHADOW_PORTAL_UP_EAST, SPELL_SHADOW_PORTAL_UP_SOUTH};

  // don't change the order, due to the semi-smart way it's designed, the order matters a lot.
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
        Player* portedPlayer;

        Creature* Guardians[6][3]; // 6 rooms, 3 mobs, access through GuardiansList[NORTH+EAST][1]

        // Only the 6 gates that gandling plays with.
        void SetGate(uint8 gate, bool open)
        {
            LOG_FATAL("entities:unit", "setting gate %d to %d", gate, open);
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

        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);

            // add mob to the room of the last portal, that's the only place we can have added mobs.
            uint32 room = instance->GetData(GANDLING_PORTAL_TO_CAST);
            if (room < 6)
            {
                for (uint8 i = 0; i < 3; i++)
                {
                    if (Guardians[room][i] == nullptr)
                    {
                        Guardians[room][i] = cr;
                        LOG_FATAL("Entities:Unit", "Summoned a mob to room %d, entry %d at position %f %f %f", room, i, cr->GetPositionX(), cr->GetPositionY(), cr->GetPositionZ());
                        break;
                    }
                }
            }
            // add GUID to list
            LOG_FATAL("Entities:unit", "just summoned someone");
        }

        void EnterCombat(Unit* /*who*/) override
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

        void Reset() override
        {
            _Reset();
            instance->SetData(DATA_DARKMASTER_GANDLING, NOT_STARTED);
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

        uint32 FindRoom()
        {
            uint32 room = urand(0, 5);

            // check if room is available
            do
            {
                room = (room + 1) % 6;
            } while (Guardians[room][0] || Guardians[room][1] || Guardians[room][2]);

            return room;
        }

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
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                        DoCast(target, SPELL_CURSE_DARKMASTER);
                    events.ScheduleEvent(SPELL_ARCANE_MISSILES, urand(TIMER_ARCANE_MIN, TIMER_ARCANE_MAX));
                    break;
                case SPELL_SHADOW_SHIELD:
                    DoCastSelf(SPELL_SHADOW_SHIELD);
                    events.ScheduleEvent(SPELL_ARCANE_MISSILES, urand(TIMER_ARCANE_MIN, TIMER_ARCANE_MAX));
                    break;

                case SPELL_SHADOW_PORTAL:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 15.0, true))
                    {

                        room = FindRoom();
                        instance->SetData(GANDLING_PORTAL_TO_CAST, room);

                        DoCast(target, SPELL_SHADOW_PORTAL);
                        SetGate(room, CLOSED);
                        SpawnMobsInRoom(room);
                        if (target->GetGUID() == me->GetVictim()->GetGUID())
                        {
                            LOG_FATAL("Entities:unit", "need to shift aggro");
                            me->AddThreat(me->GetVictim(), -1000000);
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

class spell_scholomance_shadow_portal : public SpellScriptLoader
{
public:
    spell_scholomance_shadow_portal() : SpellScriptLoader("spell_scholomance_shadow_portal") { }

    class spell_scholomance_shadow_portal_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_scholomance_shadow_portal_SpellScript);

        bool Load() override
        {
            return GetCaster()->GetTypeId() == TYPEID_UNIT;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Creature* caster = GetCaster()->ToCreature();
            uint32 room = 0; // 6 rooms

            if (InstanceScript* instance = caster->GetInstanceScript())
            {
                room = instance->GetData(GANDLING_PORTAL_TO_CAST);
                if (room < 6)
                {
                    caster->CastSpell(GetHitUnit(), GandlingPortalSpells[room], true);
                }
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_scholomance_shadow_portal_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_scholomance_shadow_portal_SpellScript();
    }
};

class spell_scholomance_shadow_portal_rooms : public SpellScriptLoader
{
public:
    spell_scholomance_shadow_portal_rooms() : SpellScriptLoader("spell_scholomance_shadow_portal_rooms") { }

    class spell_scholomance_shadow_portal_rooms_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_scholomance_shadow_portal_rooms_SpellScript);

        bool Load() override
        {
            return GetCaster()->GetTypeId() == TYPEID_UNIT;
        }

        void HandleSendEvent(SpellEffIndex effIndex)
        {
            PreventHitEffect(effIndex);
            // do nothing here either...
        }

        void Register() override
        {
            OnEffectHit += SpellEffectFn(spell_scholomance_shadow_portal_rooms_SpellScript::HandleSendEvent, EFFECT_1, SPELL_EFFECT_SEND_EVENT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_scholomance_shadow_portal_rooms_SpellScript();
    }
};

void AddSC_boss_darkmaster_gandling()
{
    new boss_darkmaster_gandling();
    new spell_scholomance_shadow_portal();
    new spell_scholomance_shadow_portal_rooms();
}
