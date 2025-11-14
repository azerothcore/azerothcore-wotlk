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
#include "ScriptedCreature.h"
#include "auchenai_crypts.h"

enum Text
{
    SAY_INTRO                   = 0,
    SAY_SUMMON                  = 1,
    SAY_AGGRO                   = 2,
    SAY_ROAR                    = 3,
    SAY_SLAY                    = 4,
    SAY_DEATH                   = 5
};

enum Spells
{
    // Exarch Maladaar
    SPELL_RIBBON_OF_SOULS       = 32422,
    SPELL_SOUL_SCREAM           = 32421,
    SPELL_STOLEN_SOUL           = 32346,
    SPELL_STOLEN_SOUL_VISUAL    = 32395,
    SPELL_SUMMON_AVATAR         = 32424,

    // Stolen Soul
    SPELL_MOONFIRE              = 37328,
    SPELL_FIREBALL              = 37329,
    SPELL_MIND_FLAY             = 37330,
    SPELL_HEMORRHAGE            = 37331,
    SPELL_FROSTSHOCK            = 37332,
    SPELL_CURSE_OF_AGONY        = 37334,
    SPELL_MORTAL_STRIKE         = 37335,
    SPELL_FREEZING_TRAP         = 37368,
    SPELL_HAMMER_OF_JUSTICE     = 37369,
    SPELL_PLAGUE_STRIKE         = 58839
};

enum Npc
{
    ENTRY_STOLEN_SOUL           = 18441
};

struct boss_exarch_maladaar : public BossAI
{
    boss_exarch_maladaar(Creature* creature) : BossAI(creature, DATA_EXARCH_MALADAAR)
    {
        _talked = false;
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        ScheduleHealthCheckEvent(25, [&] {
            Talk(SAY_SUMMON);
            scheduler.Schedule(100ms, [this](TaskContext)
            {
                DoCastSelf(SPELL_SUMMON_AVATAR);
            });
        });
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_talked && who->IsPlayer() && me->IsWithinDistInMap(who, 150.0f))
        {
            _talked = true;
            Talk(SAY_INTRO);
        }
        ScriptedAI::MoveInLineOfSight(who);
    }

    void JustEngagedWith(Unit*) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);
        scheduler.Schedule(15s, [this] (TaskContext context)
        {
            DoCastSelf(SPELL_SOUL_SCREAM);
            context.Repeat(15s, 25s);
        }).Schedule(5s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_RIBBON_OF_SOULS);
            context.Repeat(10s, 20s);
        }).Schedule(25s, [this](TaskContext context)
        {
            if (Unit * target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
            {
                Talk(SAY_ROAR);
                DoCast(target, SPELL_STOLEN_SOUL);
                if (Creature* summon = me->SummonCreature(ENTRY_STOLEN_SOUL, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000))
                {
                    summon->CastSpell(summon, SPELL_STOLEN_SOUL_VISUAL, false);
                    summon->SetDisplayId(target->GetDisplayId());
                    summon->AI()->SetGUID(target->GetGUID());
                    summon->AI()->DoAction(target->getClass());
                    summon->AI()->AttackStart(target);
                }
            }
            context.Repeat(25s, 30s);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && urand(0, 1))
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit*) override
    {
        Talk(SAY_DEATH);
        me->SummonCreature(19412, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 600000);
        _JustDied();
    }

    void JustSummoned(Creature* /*creature*/) override
    {
        // Override JustSummoned() so we don't despawn the Avatar.
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }

private:
    bool _talked;
};

struct npc_stolen_soul : public ScriptedAI
{
    npc_stolen_soul(Creature* creature) : ScriptedAI(creature) {}

    void Reset() override
    {
        _myClass = CLASS_WARRIOR;
        _scheduler.Schedule(1s, [this] (TaskContext /*context*/)
        {
            switch (_myClass)
            {
                case CLASS_WARRIOR:
                    _scheduler.Schedule(0ms, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_MORTAL_STRIKE);
                        context.Repeat(6s);
                    });
                    break;
                case CLASS_PALADIN:
                    _scheduler.Schedule(0ms, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_HAMMER_OF_JUSTICE);
                        context.Repeat(6s);
                    });
                    break;
                case CLASS_HUNTER:
                    _scheduler.Schedule(0ms, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_FREEZING_TRAP);
                        context.Repeat(20s);
                    });
                    break;
                case CLASS_ROGUE:
                    _scheduler.Schedule(0ms, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_HEMORRHAGE);
                        context.Repeat(10s);
                    });
                    break;
                case CLASS_PRIEST:
                    _scheduler.Schedule(0ms, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_MIND_FLAY);
                        context.Repeat(5s);
                    });
                    break;
                case CLASS_SHAMAN:
                    _scheduler.Schedule(0ms, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_FROSTSHOCK);
                        context.Repeat(8s);
                    });
                    break;
                case CLASS_MAGE:
                    _scheduler.Schedule(0ms, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_FIREBALL);
                        context.Repeat(5s);
                    });
                    break;
                case CLASS_WARLOCK:
                    _scheduler.Schedule(0ms, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_CURSE_OF_AGONY);
                        context.Repeat(20s);
                    });
                    break;
                case CLASS_DRUID:
                    _scheduler.Schedule(0ms, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_MOONFIRE);
                        context.Repeat(10s);
                    });
                    break;
                case CLASS_DEATH_KNIGHT:
                    _scheduler.Schedule(0ms, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_PLAGUE_STRIKE);
                        context.Repeat(6s);
                    });
                    break;
            }
        });
    }

    void SetGUID(ObjectGuid const& guid, int32 /*id*/) override
    {
        _targetGuid = guid;
    }

    void DoAction(int32 pClass) override
    {
        _myClass = pClass;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);
        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Unit* target = ObjectAccessor::GetUnit(*me, _targetGuid))
            target->RemoveAurasDueToSpell(SPELL_STOLEN_SOUL);
    }

private:
    TaskScheduler _scheduler;
    ObjectGuid _targetGuid;
    uint8 _myClass;
};

void AddSC_boss_exarch_maladaar()
{
    RegisterAuchenaiCryptsCreatureAI(boss_exarch_maladaar);
    RegisterAuchenaiCryptsCreatureAI(npc_stolen_soul);
}
