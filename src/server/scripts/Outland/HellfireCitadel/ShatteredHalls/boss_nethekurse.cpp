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
#include "shattered_halls.h"

enum Texts
{
    SAY_SKIP_INTRO          = 0,
    SAY_INTRO_2             = 1,
    SAY_PEON_ATTACKED       = 2,
    SAY_PEON_DIES           = 3,
    SAY_SHADOW_SEAR         = 4,
    SAY_SHADOW_FISSURE      = 5,
    SAY_DEATH_COIL          = 6,
    SAY_SLAY                = 7,
    SAY_DIE                 = 8
};

enum Spells
{
    SPELL_DEATH_COIL            = 30500,
    SPELL_DARK_SPIN             = 30502,
    SPELL_SHADOW_FISSURE        = 30496,
    SPELL_SHADOW_CLEAVE         = 30495,

    SPELL_SHADOW_SEAR           = 30735,
    SPELL_DEATH_COIL_RP         = 30741,
    SPELL_SHADOW_FISSURE_RP     = 30745,
    SPELL_LESSER_SHADOW_FISSURE = 30744
};

enum Events
{
    EVENT_INTRO                = 1,
    EVENT_START_ATTACK         = 2,

    EVENT_STAGE_NONE           = 0,
    EVENT_STAGE_INTRO          = 1,
    EVENT_STAGE_TAUNT          = 2,
    EVENT_STAGE_MAIN           = 3
};

enum Data
{
    SETDATA_DATA               = 1,
    SETDATA_PEON_AGGRO         = 1,
    SETDATA_PEON_DEATH         = 2
};

enum Groups
{
    GROUP_RP                   = 0
};

enum Actions
{
    ACTION_START_INTRO         = 0,
    ACTION_CANCEL_INTRO        = 1,
    ACTION_START_COMBAT        = 2,
};

enum Creatures
{
    NPC_PEON                   = 17083
};

struct PeonRoleplay
{
    uint32 spellId;
    uint8 textId;
};

PeonRoleplay PeonRoleplayData[3] =
{
    { SPELL_DEATH_COIL_RP,     SAY_DEATH_COIL     },
    { SPELL_SHADOW_FISSURE_RP, SAY_SHADOW_FISSURE },
    { SPELL_SHADOW_SEAR,       SAY_SHADOW_SEAR    }
};

struct boss_grand_warlock_nethekurse : public BossAI
{
    boss_grand_warlock_nethekurse(Creature* creature) : BossAI(creature, DATA_NETHEKURSE)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        ScheduleHealthCheckEvent(25, [&] {
            DoCastSelf(SPELL_DARK_SPIN);
        });

        instance->SetBossState(DATA_NETHEKURSE, NOT_STARTED);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DIE);
        _JustDied();
    }

    void SetData(uint32 data, uint32 value) override
    {
        if (data != SETDATA_DATA)
            return;

        if (value == SETDATA_PEON_AGGRO && PeonEngagedCount <= 4)
        {
            Talk(SAY_PEON_ATTACKED);
        }
        else if (value == SETDATA_PEON_DEATH && PeonKilledCount <= 4)
        {
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
            me->SetFacingTo(4.572762489318847656f);

            scheduler.Schedule(500ms, GROUP_RP, [this](TaskContext /*context*/)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_APPLAUD);
                me->GetMotionMaster()->Initialize();
                Talk(SAY_PEON_DIES);

                if (++PeonKilledCount == 4)
                {
                    Talk(SAY_INTRO_2);
                    DoAction(ACTION_CANCEL_INTRO);
                    if (Unit* target = me->SelectNearestPlayer(80.0f))
                    {
                        AttackStart(target);
                    }
                }
            });
        }
    }

    void IntroRP()
    {
        scheduler.Schedule(500ms, GROUP_RP, [this](TaskContext context)
        {
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
            me->SetFacingTo(4.572762489318847656f);

            scheduler.Schedule(500ms, GROUP_RP, [this](TaskContext /*context*/)
            {
                scheduler.Schedule(2500ms, GROUP_RP, [this](TaskContext /*context*/)
                {
                    PeonRoleplay roleplayData = Acore::Containers::SelectRandomContainerElement(PeonRoleplayData);
                    DoCast(me, roleplayData.spellId);
                    Talk(roleplayData.textId);
                    me->GetMotionMaster()->Initialize();
                });
            });
            context.Repeat(16400ms, 28500ms);
        });
    }

    void JustEngagedWith(Unit* who) override
    {
        if (who->GetEntry() == NPC_PEON)
        {
            return;
        }

        _JustEngagedWith();
        DoAction(ACTION_CANCEL_INTRO);

        scheduler.CancelAll();

        scheduler.Schedule(12150ms, 19850ms, [this](TaskContext context)
        {
            if (me->HealthBelowPct(90))
            {
                DoCastRandomTarget(SPELL_DEATH_COIL, 0, 30.0f, true);
            }
            context.Repeat();
        }).Schedule(8100ms, 17300ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_SHADOW_FISSURE, 0, 60.0f, true);
            context.Repeat(8450ms, 9450ms);
        }).Schedule(10950ms, 21850ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SHADOW_CLEAVE);
            context.Repeat(1200ms, 23900ms);
        });

        if (PeonKilledCount < 4)
        {
            Talk(SAY_SKIP_INTRO);
        }
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_CANCEL_INTRO)
        {
            scheduler.CancelGroup(GROUP_RP);
            me->SetInCombatWithZone();
            return;
        }
        else if (action == ACTION_START_INTRO)
        {
            IntroRP();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!UpdateVictim())
            return;

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        if (!me->HealthBelowPct(25))
            DoMeleeAttackIfReady();
    }

private:
    uint8 PeonEngagedCount = 0;
    uint8 PeonKilledCount = 0;
};

class spell_tsh_shadow_bolt : public SpellScript
{
    PrepareSpellScript(spell_tsh_shadow_bolt);

    void SelectRandomPlayer(WorldObject*& target)
    {
        if (Creature* caster = GetCaster()->ToCreature())
        {
            if (Unit* randomTarget = caster->AI()->SelectTarget(SelectTargetMethod::Random, 0, 100.0f))
            {
                target = randomTarget;
            }
        }
    }

    void Register() override
    {
        OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_tsh_shadow_bolt::SelectRandomPlayer, EFFECT_0, TARGET_UNIT_TARGET_ENEMY);
    }
};

class spell_target_fissures : public SpellScript
{
    PrepareSpellScript(spell_target_fissures);

    void HandleEffect(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetHitUnit(), SPELL_LESSER_SHADOW_FISSURE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_target_fissures::HandleEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class at_rp_nethekurse : public OnlyOnceAreaTriggerScript
{
public:
    at_rp_nethekurse() : OnlyOnceAreaTriggerScript("at_rp_nethekurse") { }

    bool _OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (instance->GetBossState(DATA_NETHEKURSE) != DONE && instance->GetBossState(DATA_NETHEKURSE) != IN_PROGRESS)
            {
                if (Creature* nethekurse = instance->GetCreature(DATA_NETHEKURSE))
                {
                    nethekurse->AI()->DoAction(ACTION_START_INTRO);
                }
            }
        }
        return false;
    }
};

void AddSC_boss_grand_warlock_nethekurse()
{
    RegisterShatteredHallsCreatureAI(boss_grand_warlock_nethekurse);
    RegisterSpellScript(spell_tsh_shadow_bolt);
    RegisterSpellScript(spell_target_fissures);
    new at_rp_nethekurse();
}
