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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_CARRION_SWARM_N                       = 52720,
    SPELL_CARRION_SWARM_H                       = 58852,
    SPELL_MIND_BLAST_N                          = 52722,
    SPELL_MIND_BLAST_H                          = 58850,
    SPELL_SLEEP_N                               = 52721,
    SPELL_SLEEP_H                               = 58849,
    SPELL_VAMPIRIC_TOUCH                        = 52723,
};

enum Events
{
    EVENT_SPELL_CARRION_SWARM                   = 1,
    EVENT_SPELL_MIND_BLAST                      = 2,
    EVENT_SPELL_SLEEP                           = 3,
    EVENT_SPELL_VAMPIRIC_TOUCH                  = 4,
};

enum Yells
{
    SAY_AGGRO                                   = 2,
    SAY_KILL                                    = 3,
    SAY_SLAY                                    = 4,
    SAY_SLEEP                                   = 5,
    SAY_30HEALTH                                = 6,
    SAY_15HEALTH                                = 7,
    SAY_ESCAPE_SPEECH_1                         = 8,
    SAY_ESCAPE_SPEECH_2                         = 9,
    SAY_OUTRO                                   = 10
};

class boss_mal_ganis : public CreatureScript
{
public:
    boss_mal_ganis() : CreatureScript("boss_mal_ganis") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetCullingOfStratholmeAI<boss_mal_ganisAI>(creature);
    }

    struct boss_mal_ganisAI : public ScriptedAI
    {
        boss_mal_ganisAI(Creature* c) : ScriptedAI(c)
        {
            finished = false;
        }

        EventMap events;
        bool finished;

        void Reset() override
        {
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);
            events.Reset();
            if (finished)
            {
                Talk(SAY_OUTRO);
                me->DespawnOrUnsummon(20000);
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_CARRION_SWARM, 6000);
            events.ScheduleEvent(EVENT_SPELL_MIND_BLAST, 11000);
            events.ScheduleEvent(EVENT_SPELL_SLEEP, 20000);
            events.ScheduleEvent(EVENT_SPELL_VAMPIRIC_TOUCH, 15000);
        }

        void JustDied(Unit* /*killer*/) override
        {
        }

        void KilledUnit(Unit*  /*victim*/) override
        {
            if (!urand(0, 1))
                return;

            Talk(SAY_SLAY);
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!finished && damage >= me->GetHealth())
            {
                damage = 0;
                finished = true;
                me->SetRegeneratingHealth(false);
                me->SetImmuneToAll(true);
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_PASSIVE);
                if (InstanceScript* pInstance = me->GetInstanceScript())
                {
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_ARTHAS)))
                        cr->AI()->DoAction(ACTION_KILLED_MALGANIS);

                    // give credit to players
                    me->CastSpell(me, 58630, true);
                }

                // quest completion
                if (who)
                    if (Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself())
                        player->RewardPlayerAndGroupAtEvent(31006, player); // Royal Escort quest, Mal'ganis bunny

                EnterEvadeMode();
            }
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
                case EVENT_SPELL_CARRION_SWARM:
                    me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_CARRION_SWARM_N, SPELL_CARRION_SWARM_H), false);
                    events.RepeatEvent(7000);
                    break;
                case EVENT_SPELL_MIND_BLAST:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_MIND_BLAST_N, SPELL_MIND_BLAST_H), false);
                    events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_SLEEP:
                    Talk(SAY_SLEEP);
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_SLEEP_N, SPELL_SLEEP_H), false);
                    events.RepeatEvent(17000);
                    break;
                case EVENT_SPELL_VAMPIRIC_TOUCH:
                    me->CastSpell(me, SPELL_VAMPIRIC_TOUCH, true);
                    events.RepeatEvent(30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_mal_ganis()
{
    new boss_mal_ganis();
}
