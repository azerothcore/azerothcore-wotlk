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
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "vault_of_archavon.h"

enum Spells
{
    // Toravon
    SPELL_FREEZING_GROUND              = 72090,
    SPELL_FROZEN_ORB                   = 72091,
    SPELL_WHITEOUT                     = 72034,
    SPELL_WHITEOUT_VISUAL              = 72036,
    SPELL_FROZEN_MALLET                = 71993,

    // Frozen Orb
    SPELL_FROZEN_ORB_DMG                = 72081,    // priodic dmg aura
    SPELL_FROZEN_ORB_AURA               = 72067,    // make visible

    // Frozen Orb Stalker
    SPELL_FROZEN_ORB_STALKER_VISUAL     = 72094,

    // Whiteout GroundEffect NPC
    NPC_WHITEOUT_GROUND_EFFECT          = 38440,
};

enum Events
{
    EVENT_FREEZING_GROUND               = 1,
    EVENT_FROZEN_ORB_STALKER            = 2,
    EVENT_CAST_WHITEOUT                 = 3,
    EVENT_CAST_WHITEOUT_GROUND_EFFECT   = 4,
};

class boss_toravon : public CreatureScript
{
public:
    boss_toravon() : CreatureScript("boss_toravon") { }

    struct boss_toravonAI : public ScriptedAI
    {
        boss_toravonAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;

        EventMap events;
        SummonList summons;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
            if (pInstance)
            {
                if (pInstance->GetData(DATA_STONED))
                {
                    if (Aura* aur = me->AddAura(SPELL_STONED_AURA, me))
                    {
                        aur->SetMaxDuration(60 * MINUTE * IN_MILLISECONDS);
                        aur->SetDuration(60 * MINUTE * IN_MILLISECONDS);
                    }
                }
                pInstance->SetData(EVENT_TORAVON, NOT_STARTED);
            }
        }

        void AttackStart(Unit* who) override
        {
            if (me->HasAura(SPELL_STONED_AURA))
                return;
            ScriptedAI::AttackStart(who);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->CastSpell(me, SPELL_FROZEN_MALLET, true);

            events.ScheduleEvent(EVENT_FROZEN_ORB_STALKER, 12s);
            events.ScheduleEvent(EVENT_FREEZING_GROUND, 7s);
            events.ScheduleEvent(EVENT_CAST_WHITEOUT, 25s); // schedule FIRST whiteout event in 25 seconds -1 for compesate updateai 2seconds check delay

            if (pInstance)
                pInstance->SetData(EVENT_TORAVON, IN_PROGRESS);
        }

        void JustDied(Unit*) override
        {
            if (pInstance)
            {
                pInstance->SetData(EVENT_TORAVON, DONE);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_WHITEOUT);
            }
            summons.DespawnAll();
        }

        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_FREEZING_GROUND:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_FREEZING_GROUND, false);
                    events.Repeat(20s);
                    break;
                case EVENT_FROZEN_ORB_STALKER:
                    me->CastCustomSpell(SPELL_FROZEN_ORB, SPELLVALUE_MAX_TARGETS, RAID_MODE(1, 3), me, false);
                    events.Repeat(30s);
                    break;
                case EVENT_CAST_WHITEOUT:
                    me->CastSpell(me, SPELL_WHITEOUT, false);
                    events.ScheduleEvent(EVENT_CAST_WHITEOUT_GROUND_EFFECT, 1s); // triggers after 1 sec "plus 1 from trigger to cast visual"
                    events.Repeat(40s); // next whiteout instead first 25 SEC is now 45 SEC
                    break;
                case EVENT_CAST_WHITEOUT_GROUND_EFFECT: // Whiteout Ground effect trigger
                    if (Unit* whiteOutGround = me->SummonCreature(NPC_WHITEOUT_GROUND_EFFECT, -43.3316, -288.708, 92.2511, 1.58825, TEMPSUMMON_TIMED_DESPAWN, 4000))
                        whiteOutGround->CastSpell(whiteOutGround, SPELL_WHITEOUT_VISUAL, false); // Cast the spell
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVaultOfArchavonAI<boss_toravonAI>(creature);
    }
};

class npc_frozen_orb : public CreatureScript
{
public:
    npc_frozen_orb() : CreatureScript("npc_frozen_orb") { }

    struct npc_frozen_orbAI : public ScriptedAI
    {
        npc_frozen_orbAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        uint32 switchTimer;

        void Reset() override
        {
            switchTimer = 9000;
            me->CastSpell(me, SPELL_FROZEN_ORB_AURA, true);
            me->CastSpell(me, SPELL_FROZEN_ORB_DMG, true);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->SetInCombatWithZone();
        }

        void UpdateAI(uint32 diff) override
        {
            switchTimer += diff;
            if (switchTimer >= 10000)
            {
                switchTimer = 0;
                me->GetThreatMgr().ResetAllThreat();
                if (Player* player = SelectTargetFromPlayerList(100.0f))
                    me->AddThreat(player, 100000.0f);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVaultOfArchavonAI<npc_frozen_orbAI>(creature);
    }
};

class npc_frozen_orb_stalker : public CreatureScript
{
public:
    npc_frozen_orb_stalker() : CreatureScript("npc_frozen_orb_stalker") { }

    struct npc_frozen_orb_stalkerAI : public NullCreatureAI
    {
        npc_frozen_orb_stalkerAI(Creature* creature) : NullCreatureAI(creature)
        {
        }

        void Reset() override
        {
            me->CastSpell(me, SPELL_FROZEN_ORB_STALKER_VISUAL, true);
        }

        void JustSummoned(Creature* cr) override
        {
            if (InstanceScript* pInstance = me->GetInstanceScript())
                if (Creature* toravon = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(EVENT_TORAVON)))
                    if (toravon->AI())
                        toravon->AI()->JustSummoned(cr);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVaultOfArchavonAI<npc_frozen_orb_stalkerAI>(creature);
    }
};

void AddSC_boss_toravon()
{
    new boss_toravon();
    new npc_frozen_orb();
    new npc_frozen_orb_stalker();
}
