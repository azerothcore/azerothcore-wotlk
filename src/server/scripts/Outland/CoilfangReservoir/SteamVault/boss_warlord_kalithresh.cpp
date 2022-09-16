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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "steam_vault.h"

enum NagaDistiller
{
    SAY_INTRO                   = 0,
    SAY_REGEN                   = 1,
    SAY_AGGRO                   = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    SPELL_SPELL_REFLECTION      = 31534,
    SPELL_IMPALE                = 39061,
    SPELL_WARLORDS_RAGE         = 37081,
    SPELL_WARLORDS_RAGE_NAGA    = 31543,
    SPELL_WARLORDS_RAGE_PROC    = 36453,

    NPC_NAGA_DISTILLER          = 17954,

    EVENT_SPELL_REFLECTION      = 1,
    EVENT_SPELL_IMPALE          = 2,
    EVENT_SPELL_RAGE            = 3
};

class boss_warlord_kalithresh : public CreatureScript
{
public:
    boss_warlord_kalithresh() : CreatureScript("boss_warlord_kalithresh") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSteamVaultAI<boss_warlord_kalithreshAI>(creature);
    }

    struct boss_warlord_kalithreshAI : public ScriptedAI
    {
        boss_warlord_kalithreshAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            if (instance)
                instance->SetData(TYPE_WARLORD_KALITHRESH, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_REFLECTION, 10000);
            events.ScheduleEvent(EVENT_SPELL_IMPALE, urand(7000, 14000));
            events.ScheduleEvent(EVENT_SPELL_RAGE, 20000);

            if (instance)
                instance->SetData(TYPE_WARLORD_KALITHRESH, IN_PROGRESS);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (instance)
                instance->SetData(TYPE_WARLORD_KALITHRESH, DONE);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_REFLECTION:
                    me->CastSpell(me, SPELL_SPELL_REFLECTION, false);
                    events.RepeatEvent(urand(15000, 20000));
                    break;
                case EVENT_SPELL_IMPALE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 10.0f, true))
                        me->CastSpell(target, SPELL_IMPALE, false);
                    events.RepeatEvent(urand(7500, 12500));
                    break;
                case EVENT_SPELL_RAGE:
                    if (Creature* distiller = me->FindNearestCreature(NPC_NAGA_DISTILLER, 100.0f))
                    {
                        Talk(SAY_REGEN);
                        //me->CastSpell(me, SPELL_WARLORDS_RAGE, false);
                        distiller->AI()->DoAction(1);
                    }
                    events.RepeatEvent(45000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_naga_distiller : public CreatureScript
{
public:
    npc_naga_distiller() : CreatureScript("npc_naga_distiller") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSteamVaultAI<npc_naga_distillerAI>(creature);
    }

    struct npc_naga_distillerAI : public NullCreatureAI
    {
        npc_naga_distillerAI(Creature* creature) : NullCreatureAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        uint32 spellTimer;

        void Reset() override
        {
            spellTimer = 0;
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        }

        void DoAction(int32 param) override
        {
            if (param != 1)
                return;

            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->CastSpell(me, SPELL_WARLORDS_RAGE_NAGA, true);
            spellTimer = 1;
        }

        void UpdateAI(uint32 diff) override
        {
            if (spellTimer)
            {
                spellTimer += diff;
                if (spellTimer >= 12000)
                {
                    if (Creature* kali = me->FindNearestCreature(NPC_WARLORD_KALITHRESH, 100.0f))
                        kali->CastSpell(kali, SPELL_WARLORDS_RAGE_PROC, true);
                    Unit::Kill(me, me);
                }
            }
        }
    };
};

void AddSC_boss_warlord_kalithresh()
{
    new boss_warlord_kalithresh();
    new npc_naga_distiller();
}
