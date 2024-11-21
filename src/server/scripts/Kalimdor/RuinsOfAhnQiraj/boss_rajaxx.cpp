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
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SmartAI.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ruins_of_ahnqiraj.h"

enum Yells
{
     // The time of our retribution is at hand! Let darkness reign in the hearts of our enemies! Sound: 8645 Emote: 35
    SAY_DEATH                 = 9,
    SAY_CHANGEAGGRO           = 10,
    SAY_KILLS_ANDOROV         = 11,
    SAY_COMPLETE_QUEST        = 12    // Yell when realm complete quest 8743 for world event
                                      // Warriors, Captains, continue the fight! Sound: 8640
};

enum Spells
{
    SPELL_DISARM              = 6713,
    SPELL_FRENZY              = 8269,
    SPELL_THUNDERCRASH        = 25599,

    // Server-side
    SPELL_CENARION_REPUTATION = 26342
};

enum Events
{
    EVENT_DISARM            = 1,        // 03:58:27, 03:58:49
    EVENT_THUNDERCRASH      = 2,        // 03:58:29, 03:58:50
    EVENT_CHANGE_AGGRO      = 3,
};

struct boss_rajaxx : public BossAI
{
    boss_rajaxx(Creature* creature) : BossAI(creature, DATA_RAJAXX) { }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        _JustDied();

        if (Creature* andorov = instance->instance->GetCreature(instance->GetGuidData(DATA_ANDOROV)))
        {
            andorov->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_VENDOR);
            andorov->ForceValuesUpdateAtIndex(UNIT_NPC_FLAGS);
        }

        std::list<Creature*> creatureList;
        me->GetCreatureListWithEntryInGrid(creatureList, NPC_KALDOREI_ELITE, 200.0f);
        creatureList.remove_if([&](Creature* creature) -> bool { return !creature->IsAlive(); });

        me->GetMap()->DoForAllPlayers([&, creatureList](Player* player)
        {
            for (uint8 i = 0; i < creatureList.size(); ++i)
            {
                player->CastSpell(player, SPELL_CENARION_REPUTATION, true);
            }

            if (Creature* andorov = instance->instance->GetCreature(instance->GetGuidData(DATA_ANDOROV)))
            {
                if (andorov->IsAlive())
                {
                    player->CastSpell(player, SPELL_CENARION_REPUTATION, true);
                }
            }
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        events.ScheduleEvent(EVENT_DISARM, 10s);
        events.ScheduleEvent(EVENT_THUNDERCRASH, 12s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_DISARM:
                    DoCastVictim(SPELL_DISARM);
                    events.ScheduleEvent(EVENT_DISARM, 22s);
                    break;
                case EVENT_THUNDERCRASH:
                    DoCastSelf(SPELL_THUNDERCRASH);
                    me->GetThreatMgr().ResetAllThreat();
                    events.ScheduleEvent(EVENT_THUNDERCRASH, 21s);
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
};

class spell_rajaxx_thundercrash : public SpellScript
{
    PrepareSpellScript(spell_rajaxx_thundercrash);

    void HandleDamageCalc(SpellEffIndex /*effIndex*/)
    {
        int32 damage = GetHitUnit()->GetHealth() / 2;
        if (damage < 100)
        {
            damage = 100;
        }

        SetHitDamage(damage);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_rajaxx_thundercrash::HandleDamageCalc, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

enum AndorovMisc
{
    // Factions
    FACTION_ANDOROV_ESCORT  = 250,

    // Spells
    SPELL_AURA_OF_COMMAND    = 25516,
    SPELL_BASH               = 25515,
    SPELL_STRIKE             = 22591,

    // Texts
    SAY_ANDOROV_INTRO        = 0,   // Before for the first wave
    SAY_ANDOROV_ATTACK       = 1,   // Beginning the event

    // Gossips
    GOSSIP_ANDRNOV           = 7047,

    // Events
    EVENT_BASH               = 1,
    EVENT_COMMAND_AURA,
    EVENT_STRIKE
};

struct npc_general_andorov : public npc_escortAI
{
    npc_general_andorov(Creature* creature) : npc_escortAI(creature), _summons(me)
    {
        instance = creature->GetInstanceScript();
        SetDespawnAtEnd(false);
        SetDespawnAtFar(false);
    }

    void sGossipSelect(Player* player, uint32 /*uiSender*/, uint32 uiAction) override
    {
        if (uiAction)
        {
            CloseGossipMenuFor(player);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            SetEscortPaused(false);
        }
    }

    void InitializeAI() override
    {
        me->SetReactState(REACT_PASSIVE);

        for (uint8 i = 0; i < 4; ++i)
        {
            if (Creature* kaldoreielitist = me->SummonCreature(NPC_KALDOREI_ELITE, *me))
            {
                kaldoreielitist->SetImmuneToNPC(true);
                kaldoreielitist->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                kaldoreielitist->SetReactState(REACT_PASSIVE);
                CAST_AI(SmartAI, kaldoreielitist->AI())->SetFollow(me, 2.5f, 0.f + i * (M_PI / 2));
            }
        }

        me->SetFaction(FACTION_ANDOROV_ESCORT);
        Endwaypoint = false;
        _initialAttackTimer = 5 * IN_MILLISECONDS;
        _paused = false;

        Start(false, true);

        me->SetImmuneToNPC(true);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        events.ScheduleEvent(EVENT_BASH, 8s, 11s);
        events.ScheduleEvent(EVENT_COMMAND_AURA, 1s, 3s);
        events.ScheduleEvent(EVENT_STRIKE, 2s, 5s);
    }

    void WaypointReached(uint32 waypointId) override
    {
        switch (waypointId)
        {
            case 10:
                me->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
                SetEscortPaused(true);
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                _paused = true;
                break;
            case 14:
                SetEscortPaused(true);
                if (!Endwaypoint)
                {
                    Endwaypoint = true;
                    Talk(SAY_ANDOROV_INTRO);

                    me->SetImmuneToNPC(false);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetReactState(REACT_AGGRESSIVE);

                    for (ObjectGuid const& guid : _summons)
                    {
                        if (Creature* kaldoreielitist = ObjectAccessor::GetCreature(*me, guid))
                        {
                            kaldoreielitist->SetImmuneToNPC(false);
                            kaldoreielitist->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            kaldoreielitist->SetReactState(REACT_AGGRESSIVE);
                        }
                    }
                }
                break;
        }
    }

    void JustDied(Unit* killer) override
    {
        _summons.DespawnAll();

        if (killer->GetEntry() == NPC_RAJAXX)
        {
            if (Creature* rajaxx = instance->GetCreature(DATA_RAJAXX))
            {
                rajaxx->AI()->Talk(SAY_KILLS_ANDOROV);
            }
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->GetEntry() == NPC_RAJAXX)
        {
            Talk(SAY_ANDOROV_ATTACK);
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        // If Rajaxx is in range attack him
        if (who->GetEntry() == NPC_RAJAXX && me->IsWithinDistInMap(who, 50.0f))
        {
            AttackStart(who);
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    uint32 GetData(uint32 type) const override
    {
        if (type == DATA_ANDOROV)
        {
            return Endwaypoint;
        }

        return 0;
    }

    void UpdateEscortAI(uint32 diff) override
    {
        if (Endwaypoint && _initialAttackTimer)
        {
            me->SetFacingTo(2.8772139f);

            if (_initialAttackTimer <= diff)
            {
                _initialAttackTimer = 0;

                if (Creature* queez = instance->GetCreature(DATA_QUUEZ))
                {
                    queez->AI()->AttackStart(me);
                }
            }
            else
            {
                _initialAttackTimer -= diff;
            }
        }

        if (_paused)
        {
            _paused = false;
            me->SetFacingTo(5.63741350f);
        }

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
                case EVENT_BASH:
                    DoCastVictim(SPELL_BASH);
                    events.ScheduleEvent(EVENT_BASH, 25s, 38s);
                    break;
                case EVENT_COMMAND_AURA:
                    DoCastSelf(SPELL_AURA_OF_COMMAND, true);
                    events.ScheduleEvent(EVENT_COMMAND_AURA, 10s, 20s);
                    break;
                case EVENT_STRIKE:
                    DoCastVictim(SPELL_STRIKE);
                    events.ScheduleEvent(EVENT_STRIKE, 4s, 6s);
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }

private:
    InstanceScript* instance;
    EventMap events;
    SummonList _summons;
    uint32 _initialAttackTimer;
    bool Endwaypoint;
    bool _paused;
};

void AddSC_boss_rajaxx()
{
    RegisterRuinsOfAhnQirajCreatureAI(boss_rajaxx);
    RegisterSpellScript(spell_rajaxx_thundercrash);
    RegisterRuinsOfAhnQirajCreatureAI(npc_general_andorov);
}
