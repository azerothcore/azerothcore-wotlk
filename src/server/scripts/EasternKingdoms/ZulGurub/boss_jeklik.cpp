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

#include "GameObjectAI.h"
#include "ScriptObject.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "TaskScheduler.h"
#include "zulgurub.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_CALL_RIDERS             = 1,
    SAY_DEATH                   = 2,
    EMOTE_SUMMON_BATS           = 3,
    EMOTE_GREAT_HEAL            = 4
};

enum Spells
{
    // Intro
    SPELL_GREEN_CHANNELING      = 13540,
    SPELL_BAT_FORM              = 23966,

    // Phase one
    SPELL_PIERCE_ARMOR          = 12097,
    SPELL_BLOOD_LEECH           = 22644,
    SPELL_CHARGE                = 22911,
    SPELL_SONIC_BURST           = 23918,
    SPELL_SWOOP                 = 23919,

    // Phase two
    SPELL_CURSE_OF_BLOOD        = 16098,
    SPELL_PSYCHIC_SCREAM        = 22884,
    SPELL_SHADOW_WORD_PAIN      = 23952,
    SPELL_MIND_FLAY             = 23953,
    SPELL_GREATER_HEAL          = 23954,

    // Batriders Spell
    SPELL_THROW_LIQUID_FIRE     = 23970,
    SPELL_SUMMON_LIQUID_FIRE    = 23971
};

enum BatIds
{
    NPC_BLOODSEEKER_BAT         = 11368,
    NPC_FRENZIED_BAT            = 14965
};

enum Events
{
    // Phase one
    EVENT_CHARGE_JEKLIK         = 1,
    EVENT_PIERCE_ARMOR,
    EVENT_BLOOD_LEECH,
    EVENT_SONIC_BURST,
    EVENT_SWOOP,
    EVENT_SPAWN_BATS,

    // Phase two
    EVENT_CURSE_OF_BLOOD,
    EVENT_PSYCHIC_SCREAM,
    EVENT_SHADOW_WORD_PAIN,
    EVENT_MIND_FLAY,
    EVENT_GREATER_HEAL,
    EVENT_SPAWN_FLYING_BATS
};

enum Phase
{
    PHASE_ONE                   = 1,
    PHASE_TWO                   = 2
};

Position const SpawnBat[6] =
{
    { -12291.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12289.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12293.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12291.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12289.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12293.6220f, -1380.2640f, 144.8304f, 5.483f }
};

enum Misc
{
    PATH_JEKLIK_INTRO = 145170
};

Position const homePosition = { -12291.9f, -1380.08f, 144.902f, 2.28638f };

struct boss_jeklik : public BossAI
{
    boss_jeklik(Creature* creature) : BossAI(creature, DATA_JEKLIK) { }

    void Reset() override
    {
        DoCastSelf(SPELL_GREEN_CHANNELING);
        me->SetHover(false);
        me->SetDisableGravity(false);
        me->SetReactState(REACT_PASSIVE);
        _Reset();
        SetCombatMovement(false);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        me->GetMotionMaster()->Clear();
        me->SetHomePosition(homePosition);
        me->NearTeleportTo(homePosition.GetPositionX(), homePosition.GetPositionY(), homePosition.GetPositionZ(), homePosition.GetOrientation());
        BossAI::EnterEvadeMode(why);
    }

    void EnterCombat(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        me->RemoveAurasDueToSpell(SPELL_GREEN_CHANNELING);
        me->SetHover(true);
        me->SetDisableGravity(true);
        DoCastSelf(SPELL_BAT_FORM, true);

        me->GetMotionMaster()->MovePath(PATH_JEKLIK_INTRO, false);
    }

    void PathEndReached(uint32 /*pathId*/) override
    {
        me->SetHover(false);
        me->SetDisableGravity(false);
        _EnterCombat();
        SetCombatMovement(true);
        me->SetReactState(REACT_AGGRESSIVE);
        events.SetPhase(PHASE_ONE);
        events.ScheduleEvent(EVENT_CHARGE_JEKLIK, urand(10000, 20000), PHASE_ONE);
        events.ScheduleEvent(EVENT_PIERCE_ARMOR, urand(5000, 15000), PHASE_ONE);
        events.ScheduleEvent(EVENT_BLOOD_LEECH, urand(5000, 15000), PHASE_ONE);
        events.ScheduleEvent(EVENT_SONIC_BURST, urand(5000, 15000), PHASE_ONE);
        events.ScheduleEvent(EVENT_SWOOP, 20000, PHASE_ONE);
        events.ScheduleEvent(EVENT_SPAWN_BATS, 30000, PHASE_ONE);
    }

    void DamageTaken(Unit* /*who*/, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
    {
        if (events.IsInPhase(PHASE_ONE) && !HealthAbovePct(50))
        {
            me->RemoveAurasDueToSpell(SPELL_BAT_FORM);
            DoResetThreat();
            events.SetPhase(PHASE_TWO);
            events.CancelEventGroup(PHASE_ONE);

            events.ScheduleEvent(EVENT_CURSE_OF_BLOOD, urand(5000, 15000), PHASE_TWO);
            events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, urand(10000, 15000), PHASE_TWO);
            events.ScheduleEvent(EVENT_PSYCHIC_SCREAM, urand(25000, 35000), PHASE_TWO);
            events.ScheduleEvent(EVENT_MIND_FLAY, urand(10000, 30000), PHASE_TWO);
            events.ScheduleEvent(EVENT_GREATER_HEAL, 25000, PHASE_TWO);
            events.ScheduleEvent(EVENT_SPAWN_FLYING_BATS, 10000, PHASE_TWO);

            return;
        }
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
                // Phase one
                case EVENT_CHARGE_JEKLIK:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    {
                        DoCast(target, SPELL_CHARGE);
                        AttackStart(target);
                    }
                    events.ScheduleEvent(EVENT_CHARGE_JEKLIK, urand(15000, 30000), PHASE_ONE);
                    break;
                case EVENT_PIERCE_ARMOR:
                    DoCastVictim(SPELL_PIERCE_ARMOR);
                    events.ScheduleEvent(EVENT_PIERCE_ARMOR, urand(20000, 30000), PHASE_ONE);
                    break;
                case EVENT_BLOOD_LEECH:
                    DoCastVictim(SPELL_BLOOD_LEECH);
                    events.ScheduleEvent(EVENT_BLOOD_LEECH, urand(10000, 20000), PHASE_ONE);
                    break;
                case EVENT_SONIC_BURST:
                    DoCastVictim(SPELL_SONIC_BURST);
                    events.ScheduleEvent(EVENT_SONIC_BURST, urand(20000, 30000), PHASE_ONE);
                    break;
                case EVENT_SWOOP:
                    DoCastVictim(SPELL_SWOOP);
                    events.ScheduleEvent(EVENT_SWOOP, urand(20000, 30000), PHASE_ONE);
                    break;
                case EVENT_SPAWN_BATS:
                    Talk(EMOTE_SUMMON_BATS);
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        for (uint8 i = 0; i < 6; ++i)
                            if (Creature* bat = me->SummonCreature(NPC_BLOODSEEKER_BAT, SpawnBat[i], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                bat->AI()->AttackStart(target);
                    events.ScheduleEvent(EVENT_SPAWN_BATS, 30000, PHASE_ONE);
                    break;
                    //Phase two
                case EVENT_CURSE_OF_BLOOD:
                    DoCastSelf(SPELL_CURSE_OF_BLOOD);
                    events.ScheduleEvent(EVENT_CURSE_OF_BLOOD, urand(25000, 30000), PHASE_TWO);
                    break;
                case EVENT_PSYCHIC_SCREAM:
                    DoCastVictim(SPELL_PSYCHIC_SCREAM);
                    events.ScheduleEvent(EVENT_PSYCHIC_SCREAM, urand(35000, 45000), PHASE_TWO);
                    break;
                case EVENT_SHADOW_WORD_PAIN:
                    DoCastRandomTarget(SPELL_SHADOW_WORD_PAIN, 0, true);
                    events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, urand(12000, 18000), PHASE_TWO);
                    break;
                case EVENT_MIND_FLAY:
                    DoCastVictim(SPELL_MIND_FLAY);
                    events.ScheduleEvent(EVENT_MIND_FLAY, urand(20000, 40000), PHASE_TWO);
                    break;
                case EVENT_GREATER_HEAL:
                    Talk(EMOTE_GREAT_HEAL);
                    me->InterruptNonMeleeSpells(false);
                    DoCastSelf(SPELL_GREATER_HEAL);
                    events.ScheduleEvent(EVENT_GREATER_HEAL, 25000, PHASE_TWO);
                    break;
                case EVENT_SPAWN_FLYING_BATS:
                    Talk(SAY_CALL_RIDERS);
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        if (Creature* flyingBat = me->SummonCreature(NPC_FRENZIED_BAT, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            flyingBat->AI()->DoZoneInCombat();
                    events.ScheduleEvent(EVENT_SPAWN_FLYING_BATS, urand(10000, 15000), PHASE_TWO);
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
};

// Flying Bat
struct npc_batrider : public ScriptedAI
{
    npc_batrider(Creature* creature) : ScriptedAI(creature)
    {
        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetHover(true);
        me->SetDisableGravity(true);
        me->AddUnitState(UNIT_STATE_ROOT);
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _scheduler.Schedule(2s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_THROW_LIQUID_FIRE);
            context.Repeat(7s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);
    }

private:
    TaskScheduler _scheduler;
};

class spell_batrider_bomb : public SpellScript
{
    PrepareSpellScript(spell_batrider_bomb);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_LIQUID_FIRE });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_SUMMON_LIQUID_FIRE, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_batrider_bomb::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_jeklik()
{
    RegisterCreatureAI(boss_jeklik);
    RegisterCreatureAI(npc_batrider);
    RegisterSpellScript(spell_batrider_bomb);
}
