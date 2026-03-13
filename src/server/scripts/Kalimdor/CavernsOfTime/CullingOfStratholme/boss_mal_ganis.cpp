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
#include "Player.h"
#include "ScriptedCreature.h"
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_CARRION_SWARM                         = 52720,
    SPELL_MIND_BLAST                            = 52722,
    SPELL_SLEEP                                 = 52721,
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
                me->DespawnOrUnsummon(20s);
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_CARRION_SWARM, 6s);
            events.ScheduleEvent(EVENT_SPELL_MIND_BLAST, 11s);
            events.ScheduleEvent(EVENT_SPELL_SLEEP, 20s);
            events.ScheduleEvent(EVENT_SPELL_VAMPIRIC_TOUCH, 15s);
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
                if (InstanceScript* instance = me->GetInstanceScript())
                {
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_ARTHAS)))
                        cr->AI()->DoAction(ACTION_KILLED_MALGANIS);

                    // give credit to players
                    me->CastSpell(me, 58630, true);
                    instance->instance->SummonGameObject(DUNGEON_MODE(GO_MALGANIS_CHEST_N, GO_MALGANIS_CHEST_H), 2288.35f, 1498.73f, 128.414f, -0.994837f, 0, 0, 0, 0, 7 * DAY * IN_MILLISECONDS);
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
                    me->CastSpell(me->GetVictim(), SPELL_CARRION_SWARM, false);
                    events.Repeat(7s);
                    break;
                case EVENT_SPELL_MIND_BLAST:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_MIND_BLAST, false);
                    events.Repeat(6s);
                    break;
                case EVENT_SPELL_SLEEP:
                    Talk(SAY_SLEEP);
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_SLEEP, false);
                    events.Repeat(17s);
                    break;
                case EVENT_SPELL_VAMPIRIC_TOUCH:
                    me->CastSpell(me, SPELL_VAMPIRIC_TOUCH, true);
                    events.Repeat(30s);
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
