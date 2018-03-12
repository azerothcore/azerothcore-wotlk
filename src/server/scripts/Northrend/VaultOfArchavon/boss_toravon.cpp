/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "vault_of_archavon.h"
#include "SpellAuras.h"
#include "PassiveAI.h"
#include "Player.h"

enum Spells
{
    // Toravon
    SPELL_FREEZING_GROUND               = 72090,
    SPELL_FROZEN_ORB                    = 72091,
    SPELL_WHITEOUT                      = 72034,
    SPELL_FROZEN_MALLET                 = 71993,

    // Frozen Orb
    SPELL_FROZEN_ORB_DMG                = 72081,    // priodic dmg aura
    SPELL_FROZEN_ORB_AURA               = 72067,    // make visible

    // Frozen Orb Stalker
    SPELL_FROZEN_ORB_STALKER_VISUAL     = 72094,
};

enum Events
{
    EVENT_FREEZING_GROUND               = 1,
    EVENT_FROZEN_ORB_STALKER            = 2,
    EVENT_CHECK_SUMMONS                 = 3,
};

enum Misc
{
    NPC_FROZEN_ORB                      = 38456,
    NPC_FROZEN_ORB_STALKER              = 38461,
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

            void Reset()
            {
                events.Reset();
                summons.DespawnAll();
                if (pInstance)
                {
                    if (pInstance->GetData(DATA_STONED))
                    {
                        if (Aura* aur = me->AddAura(SPELL_STONED_AURA, me))
                        {
                            aur->SetMaxDuration(60 * MINUTE* IN_MILLISECONDS);
                            aur->SetDuration(60 * MINUTE* IN_MILLISECONDS);
                        }
                    }
                    pInstance->SetData(EVENT_TORAVON, NOT_STARTED);
                }
            }

            void AttackStart(Unit* who)
            {
                if (me->HasAura(SPELL_STONED_AURA))
                    return;

                ScriptedAI::AttackStart(who);
            }

            void EnterCombat(Unit* /*who*/)
            {
                me->CastSpell(me, SPELL_FROZEN_MALLET, true);

                events.ScheduleEvent(EVENT_FROZEN_ORB_STALKER, 12000);
                events.ScheduleEvent(EVENT_FREEZING_GROUND, 7000);
                if (pInstance)
                    pInstance->SetData(EVENT_TORAVON, IN_PROGRESS);
            }

            void JustDied(Unit* )
            {
                if (pInstance)
                {
                    pInstance->SetData(EVENT_TORAVON, DONE);
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_WHITEOUT);
                }
            }

            void JustSummoned(Creature* cr)
            {
                summons.Summon(cr);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.GetEvent())
                {
                    case EVENT_FREEZING_GROUND:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                            me->CastSpell(target, SPELL_FREEZING_GROUND, false);
                        events.RepeatEvent(20000);
                        break;
                    case EVENT_FROZEN_ORB_STALKER:
                        me->CastCustomSpell(SPELL_FROZEN_ORB, SPELLVALUE_MAX_TARGETS, RAID_MODE(1, 3), me, false);
                        events.RepeatEvent(35000);
                        events.ScheduleEvent(EVENT_CHECK_SUMMONS, 10000);
                        break;
                    case EVENT_CHECK_SUMMONS:
                        for (SummonList::iterator i = summons.begin(); i != summons.end();)
                        {
                            if (Creature* cr = ObjectAccessor::GetCreature(*me, *i))
                            {
                                if (!cr->IsAlive())
                                    summons.erase(i++);
                                else
                                    ++i;
                            }
                            else
                                summons.erase(i++);
                        }
                        if (summons.empty())
                        {
                            events.PopEvent();
                            me->CastSpell(me, SPELL_WHITEOUT, false);
                            break;
                        }
                        events.RepeatEvent(2000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_toravonAI(creature);
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

        void Reset()
        {
            switchTimer = 9000;
            me->CastSpell(me, SPELL_FROZEN_ORB_AURA, true);
            me->CastSpell(me, SPELL_FROZEN_ORB_DMG, true);
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->SetInCombatWithZone();
        }

        void UpdateAI(uint32 diff)
        {
            switchTimer += diff;
            if (switchTimer >= 10000)
            {
                switchTimer = 0;
                me->getThreatManager().resetAllAggro();
                if (Player* player = SelectTargetFromPlayerList(100.0f))
                    me->AddThreat(player, 100000.0f);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_frozen_orbAI(creature);
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

        void Reset()
        {
            me->CastSpell(me, SPELL_FROZEN_ORB_STALKER_VISUAL, true);
        }

        void JustSummoned(Creature* cr)
        {
            if (InstanceScript* pInstance = me->GetInstanceScript())
                if (Creature* toravon = ObjectAccessor::GetCreature(*me, pInstance->GetData64(EVENT_TORAVON)))
                    if (toravon->AI())
                        toravon->AI()->JustSummoned(cr);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_frozen_orb_stalkerAI(creature);
    }
};


void AddSC_boss_toravon()
{
    new boss_toravon();
    new npc_frozen_orb();
    new npc_frozen_orb_stalker();
}
