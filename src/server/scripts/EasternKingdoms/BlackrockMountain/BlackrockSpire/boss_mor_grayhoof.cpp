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
#include "blackrock_spire.h"
#include "TaskScheduler.h"

enum Texts
{
    SAY_AGGRO = 0,
    SAY_DEATH,
};

enum Spells
{
    // Druid spell
    SPELL_HURRICANE          = 27530,
    SPELL_MOONFIRE           = 27737,
    SPELL_SHOCK              = 15605,

    // Healing spell
    SPELL_HEALING_TOUCH      = 27527,
    SPELL_REJUVENATION       = 27532,

    // Bear spell
    SPELL_BEAR_FORM          = 27543,
    SPELL_DEMORALIZING_ROAR  = 27551,
    SPELL_MAUL               = 27553,
    SPELL_SWIPE              = 27554,

    // Cat spell
    SPELL_CAT_FORM           = 27545,
    SPELL_SHRED              = 27555,
    SPELL_RAKE               = 27556,
    SPELL_FEROCIOUS_BITE     = 27557,

    // Dragon form
    SPELL_FAERIE_DRAGON_FORM = 27546,
    SPELL_ARCANE_EXPLOSION   = 22271,
    SPELL_REFLECTION         = 27564,
    SPELL_CHAIN_LIGHTING     = 27567,
    SPELL_SLEEP              = 20663 // Guessed
};

enum Phases
{
    PHASE_HUMAN = 0,
    PHASE_CAT,
    PHASE_BEAR,
    PHASE_FAERIE
};

std::vector<uint32> catSpells = { SPELL_SHRED, SPELL_RAKE, SPELL_FEROCIOUS_BITE };
std::vector<uint32> humanSpells = { SPELL_HURRICANE, SPELL_MOONFIRE, SPELL_SHOCK, SPELL_HEALING_TOUCH, SPELL_REJUVENATION };
std::vector<uint32> bearSpells = { SPELL_DEMORALIZING_ROAR, SPELL_MAUL, SPELL_SWIPE };
std::vector<uint32> faerieSpells = { SPELL_ARCANE_EXPLOSION, SPELL_REFLECTION, SPELL_CHAIN_LIGHTING, SPELL_SLEEP };

struct boss_mor_grayhoof : public BossAI
{
    boss_mor_grayhoof(Creature* creature) : BossAI(creature, DATA_MOR_GRAYHOOF)
    {
        _scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });

        _sleepTargetThreat = 0.f;
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        _phase = PHASE_HUMAN;
    }

    void CastRandomSpell(uint8 phase)
    {
        uint32 spell;
        switch (phase)
        {
            case PHASE_HUMAN:
                spell = Acore::Containers::SelectRandomContainerElement(humanSpells);
                if (spell == SPELL_REJUVENATION || spell == SPELL_HEALING_TOUCH)
                {
                    DoCastSelf(spell);
                }
                else
                {
                    DoCastAOE(spell);
                }
                break;
            case PHASE_BEAR:
                spell = Acore::Containers::SelectRandomContainerElement(bearSpells);
                DoCastVictim(spell);
                break;
            case PHASE_CAT:
                spell = Acore::Containers::SelectRandomContainerElement(catSpells);
                DoCastVictim(spell);
                break;
            case PHASE_FAERIE:
                spell = Acore::Containers::SelectRandomContainerElement(faerieSpells);
                if (spell == SPELL_SLEEP)
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.f, true))
                    {
                        me->CastSpell(target, SPELL_SLEEP);

                        // Sleep can target tank, we need to drop threat temporarily on the target.
                        _sleepTargetGUID = target->GetGUID();
                        _sleepTargetThreat = me->getThreatMgr().getThreat(target);
                        me->getThreatMgr().modifyThreatPercent(target, -100);
                        _scheduler.Schedule(10s, [this](TaskContext /*context*/)
                            {
                                if (Unit* sleepTarget = ObjectAccessor::GetUnit(*me, _sleepTargetGUID))
                                {
                                    me->getThreatMgr().addThreat(sleepTarget, _sleepTargetThreat);
                                }
                            });
                    }
                }
                else
                {
                    DoCastVictim(spell);
                }
                break;
            default:
                break;
        }
    }

    void DamageTaken(Unit* /*attacker*/, uint32& /*damage*/, DamageEffectType /*type*/, SpellSchoolMask /*school*/) override
    {
        if (_phase == PHASE_HUMAN && me->HealthBelowPct(75.f))
        {
            _phase = PHASE_BEAR;
            me->CastStop();
            _scheduler.DelayGroup(PHASE_HUMAN, 10s);
            DoCastSelf(SPELL_BEAR_FORM);
            _scheduler.Schedule(3s, PHASE_BEAR, [this](TaskContext context)
                {
                    CastRandomSpell(PHASE_BEAR);
                    if (context.GetRepeatCounter() <= 3)
                    {
                        context.Repeat();
                    }
                });
        }
        else if (_phase == PHASE_BEAR && me->HealthBelowPct(50.f))
        {
            _phase = PHASE_CAT;
            _scheduler.DelayGroup(PHASE_HUMAN, 10s);
            me->CastStop();
            DoCastSelf(SPELL_CAT_FORM);
            _scheduler.Schedule(3s, PHASE_CAT, [this](TaskContext context)
                {
                    CastRandomSpell(PHASE_CAT);
                    if (context.GetRepeatCounter() <= 3)
                    {
                        context.Repeat();
                    }
                });
        }
        else if (_phase == PHASE_CAT && me->HealthBelowPct(25.f))
        {
            _phase = PHASE_FAERIE;
            _scheduler.CancelGroup(PHASE_HUMAN);
            me->CastStop();
            DoCastSelf(SPELL_FAERIE_DRAGON_FORM);
            _scheduler.Schedule(5s, 10s, PHASE_FAERIE, [this](TaskContext context)
                {
                    CastRandomSpell(PHASE_FAERIE);
                    context.Repeat(5s, 10s);
                });
        }
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        Talk(SAY_AGGRO);
        _scheduler.Schedule(5s, 10s, PHASE_HUMAN, [this](TaskContext context)
            {
                CastRandomSpell(PHASE_HUMAN);
                context.Repeat();
            });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        _scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

protected:
    TaskScheduler _scheduler;
    uint8 _phase;
    ObjectGuid _sleepTargetGUID;
    float _sleepTargetThreat;
};

void AddSC_boss_mor_grayhoof()
{
    RegisterBlackrockSpireCreatureAI(boss_mor_grayhoof);
}
