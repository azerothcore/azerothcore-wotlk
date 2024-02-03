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
#include "SpellInfo.h"
#include "zulaman.h"

enum Spells
{
    SPELL_DUAL_WIELD            = 29651,
    SPELL_SABER_LASH            = 43267,
    SPELL_FRENZY                = 43139,
    SPELL_FLAMESHOCK            = 43303,
    SPELL_EARTHSHOCK            = 43305,
    SPELL_TRANSFORM_SPLIT       = 43142,
    SPELL_TRANSFORM_SPLIT2      = 43573,
    SPELL_TRANSFORM_MERGE       = 43271,
    SPELL_SUMMON_LYNX           = 43143,
    SPELL_SUMMON_TOTEM          = 43302,
    SPELL_BERSERK               = 45078,
    SPELL_LYNX_FRENZY           = 43290, // Used by Spirit Lynx
    SPELL_SHRED_ARMOR           = 43243  // Used by Spirit Lynx
};

enum UniqueEvents
{
    EVENT_BERSERK               = 0
};

enum Hal_CreatureIds
{
    NPC_TOTEM                   = 24224
};

enum PhaseHalazzi
{
    PHASE_NONE                  = 0,
    PHASE_LYNX                  = 1,
    PHASE_SPLIT                 = 2,
    PHASE_HUMAN                 = 3,
    PHASE_MERGE                 = 4,
    PHASE_ENRAGE                = 5
};

enum Yells
{
    SAY_AGGRO                   = 0,
    SAY_KILL                    = 1,
    SAY_SABER                   = 2,
    SAY_SPLIT                   = 3,
    SAY_MERGE                   = 4,
    SAY_DEATH                   = 5
};

struct boss_halazzi : public BossAI
{
    boss_halazzi(Creature* creature) : BossAI(creature, DATA_HALAZZIEVENT)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        _transformCount = 0;
        _phase = PHASE_NONE;
        _lynxFormHealth = me->GetMaxHealth();
        _healthPortion = _lynxFormHealth/4;
        _humanFormHealth = (me->GetMaxHealth())/0.66666666;
        EnterPhase(PHASE_LYNX);
        DoCastSelf(SPELL_DUAL_WIELD, true);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        ScheduleUniqueTimedEvent(10min, [&]
        {
            DoCastSelf(SPELL_BERSERK, true);
        }, EVENT_BERSERK);
        EnterPhase(PHASE_LYNX);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (damage >= me->GetHealth() && _phase != PHASE_ENRAGE)
        {
            damage = 0;
        }
    }

    void SpellHit(Unit*, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_TRANSFORM_SPLIT2)
        {
            EnterPhase(PHASE_HUMAN);
        }
    }

    void AttackStart(Unit* who) override
    {
        if (_phase != PHASE_MERGE)
        {
            BossAI::AttackStart(who);
        }
    }

    void EnterPhase(PhaseHalazzi nextPhase)
    {
        switch (nextPhase)
        {
            case PHASE_LYNX:
            case PHASE_ENRAGE:
                if (_phase == PHASE_MERGE)
                {
                    DoCastSelf(SPELL_TRANSFORM_MERGE, true);
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                }
                summons.DespawnAll();
                me->SetMaxHealth(_lynxFormHealth);
                me->SetHealth(_lynxFormHealth - _healthPortion * _transformCount);
                ScheduleTimedEvent(16s, [&]
                {
                    DoCastSelf(SPELL_FRENZY);
                }, 10s, 15s);
                ScheduleTimedEvent(20s, [&]
                {
                    Talk(SAY_SABER);
                    DoCastVictim(SPELL_SABER_LASH, true);
                }, 30s);
                ScheduleTimedEvent(1s, [&]
                {
                    if (HealthBelowPct(25 * (3 - _transformCount)))
                    {
                        EnterPhase(PHASE_SPLIT);
                    }
                }, 1s);
                break;
            case PHASE_SPLIT:
                Talk(SAY_SPLIT);
                DoCastSelf(SPELL_TRANSFORM_SPLIT, true);
                break;
            case PHASE_HUMAN:
                DoCastSelf(SPELL_SUMMON_LYNX, true);
                me->SetMaxHealth(_humanFormHealth);
                me->SetHealth(_humanFormHealth);
                ScheduleTimedEvent(10s, [&]
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    {
                        if (target->IsNonMeleeSpellCast(false))
                        {
                            DoCast(target, SPELL_EARTHSHOCK);
                        }
                        else
                        {
                            DoCast(target, SPELL_FLAMESHOCK);
                        }
                    }
                }, 10s, 15s);
                ScheduleTimedEvent(12s, [&]
                {
                    DoCastSelf(SPELL_SUMMON_TOTEM);
                }, 20s);
                break;
            case PHASE_MERGE:
                if (Creature* lynx = instance->GetCreature(DATA_SPIRIT_LYNX))
                {
                    Talk(SAY_MERGE);
                    lynx->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    lynx->GetMotionMaster()->Clear();
                    lynx->GetMotionMaster()->MoveFollow(me, 0, 0);
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveFollow(lynx, 0, 0);
                    ++_transformCount;
                    ScheduleTimedEvent(1s, [&]
                    {
                        if (Creature* lynx = instance->GetCreature(DATA_SPIRIT_LYNX))
                        {
                            if (me->IsWithinDistInMap(lynx, 6.0f))
                            {
                                if (_transformCount < 3)
                                {
                                    EnterPhase(PHASE_LYNX);
                                }
                                else
                                {
                                    EnterPhase(PHASE_ENRAGE);
                                }
                            }
                        }
                    }, 1s);
                }
                break;
            default:
                break;
        }
        _phase = nextPhase;
    }

    void KilledUnit(Unit* victim) override
    {
        BossAI::KilledUnit(victim);
        if (victim->IsPlayer())
        {
            Talk(SAY_KILL);
        }
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }
private:
    uint32 _lynxFormHealth;
    uint32 _humanFormHealth;
    uint32 _healthPortion;
    uint8 _transformCount;
    PhaseHalazzi _phase;
};
// Spirits Lynx AI
struct npc_halazzi_lynx : public ScriptedAI
{
    npc_halazzi_lynx(Creature* creature) : ScriptedAI(creature) { }
    
    void Reset() override
    {
        scheduler.CancelAll();
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (damage >= me->GetHealth())
        {
            damage = 0;
        }
    }

    void AttackStart(Unit* who) override
    {
        if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
        {
            ScriptedAI::AttackStart(who);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        ScriptedAI::JustEngagedWith(who);

        ScheduleTimedEvent(30s, 50s, [&]
        {
            DoCastSelf(SPELL_LYNX_FRENZY);
        }, 30s, 50s);
        ScheduleTimedEvent(4s, [&]{
            DoCastVictim(SPELL_SHRED_ARMOR);
        }, 4s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_halazzi()
{
    RegisterZulAmanCreatureAI(boss_halazzi);
    RegisterZulAmanCreatureAI(npc_halazzi_lynx);
}
