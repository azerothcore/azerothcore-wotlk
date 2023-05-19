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

enum Says
{
    SAY_INTRO                  = 0,
    SAY_INTRO_2                = 1,
    SAY_PEON_ATTACKED          = 2,
    SAY_PEON_DIES              = 3,
    SAY_SHADOW_SEAR            = 4,
    SAY_SHADOW_FISSURE         = 5,
    SAY_DEATH_COIL             = 6,
    SAY_SLAY                   = 7,
    SAY_DIE                    = 8
};

enum Spells
{
    SPELL_DEATH_COIL           = 30500,
    SPELL_DARK_SPIN            = 30502,
    SPELL_SHADOW_FISSURE       = 30496,
    SPELL_SHADOW_CLEAVE        = 30495,

    SPELL_SHADOW_SEAR          = 30735,
    SPELL_DEATH_COIL_RP        = 30741,
    SPELL_SHADOW_FISSURE_RP    = 30745
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

float NethekurseIntroPath[4][3] =
{
    {184.78966f, 290.3699f,   -8.18139f},
    {178.51125f, 278.779022f, -8.183065f},
    {171.82281f, 289.97687f,  -8.185595f},
    {178.51125f, 287.97794f,  -8.183065f}
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

    EventMap events2;

    void Reset() override
    {
        EventStage = EVENT_STAGE_NONE;
        _Reset();
        events2.Reset();
        ScheduleHealthCheckEvent(25, [&] {
            DoCastSelf(SPELL_DARK_SPIN);
        });
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

        switch (value)
        {
            case SETDATA_PEON_AGGRO:
                if (PeonEngagedCount >= 4)
                    return;

                if (EventStage < EVENT_STAGE_TAUNT)
                {
                    Talk(SAY_PEON_ATTACKED);
                }
                break;
            case SETDATA_PEON_DEATH:
                if (PeonKilledCount >= 4)
                    return;

                if (EventStage < EVENT_STAGE_TAUNT)
                {
                    PeonDieRP();
                }
                if (++PeonKilledCount == 4)
                {
                    DoAction(ACTION_CANCEL_INTRO);
                }
                break;
        }
    }

    void PeonDieRP()
    {
        me->GetMotionMaster()->Clear();
        me->SetFacingTo(4.572762489318847656f);
        scheduler.Schedule(500ms, GROUP_RP, [this](TaskContext /*context*/)
        {
            me->HandleEmoteCommand(EMOTE_ONESHOT_APPLAUD);
            Talk(SAY_PEON_DIES);
        });
    }

    void AttackStart(Unit* who) override
    {
        if (EventStage < EVENT_STAGE_MAIN)
            return;

        if (me->Attack(who, true))
        {
            DoStartMovement(who);
            CombatEventScheduler();
        }
    }

    void CombatEventScheduler()
    {
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
    }

    void MoveInLineOfSight(Unit* /*who*/) override
    {
        if (EventStage == EVENT_STAGE_NONE)
        {
            if (me->SelectNearestPlayer(30.0f))
            {
                DoAction(ACTION_CANCEL_INTRO);
            }
        }
    }

    void IntroRP()
    {
        scheduler.Schedule(500ms, GROUP_RP, [this](TaskContext context)
        {
            me->GetMotionMaster()->Clear();
            scheduler.Schedule(500ms, GROUP_RP, [this](TaskContext /*context*/)
            {
                uint32 choicelocation = urand(1, 3);
                me->GetMotionMaster()->MoveIdle();
                me->GetMotionMaster()->MovePoint(0, NethekurseIntroPath[choicelocation][0], NethekurseIntroPath[choicelocation][1], NethekurseIntroPath[choicelocation][2]);
                scheduler.Schedule(2500ms, GROUP_RP, [this, choicelocation](TaskContext /*context*/)
                {
                    CastRandomPeonSpell(choicelocation);
                });
            });
            context.Repeat(16400ms, 28500ms);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        if (EventStage == EVENT_STAGE_NONE)
        {
            DoAction(ACTION_CANCEL_INTRO);
            CombatEventScheduler();
        }
    }

    void CastRandomPeonSpell(uint32 choice)
    {
        if (choice == 1)
        {
            Talk(SAY_DEATH_COIL);
            me->CastSpell(me, SPELL_DEATH_COIL_RP, false);
        }
        else if (choice == 2)
        {
            Talk(SAY_SHADOW_FISSURE);
            me->CastSpell(me, SPELL_SHADOW_FISSURE_RP, false);
        }
        else if (choice == 3)
        {
            Talk(SAY_SHADOW_SEAR);
            me->CastSpell(me, SPELL_SHADOW_SEAR, false);
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
            introDone = true;
            scheduler.CancelGroup(GROUP_RP);
            events2.ScheduleEvent(EVENT_START_ATTACK, 1000);
            instance->SetBossState(DATA_NETHEKURSE, IN_PROGRESS);
            me->SetInCombatWithZone();
            Talk(SAY_INTRO_2);
            me->SetHomePosition(NethekurseIntroPath[3][0], NethekurseIntroPath[3][1], NethekurseIntroPath[3][2], 4.572762489318847656f);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_ATTACKABLE_1);
            return;
        }

        if (action != ACTION_START_INTRO)
            return;

        if (ATreached == true)
            return;

        ATreached = true;
        me->SetUnitFlag(UNIT_FLAG_NOT_ATTACKABLE_1);
        events2.ScheduleEvent(EVENT_INTRO, 90000);
        Talk(SAY_INTRO);
        EventStage = EVENT_STAGE_INTRO;
        instance->SetBossState(DATA_NETHEKURSE, IN_PROGRESS);
        me->SetInCombatWithZone();
        IntroRP();
    }

    void UpdateAI(uint32 diff) override
    {
        events2.Update(diff);
        scheduler.Update(diff);
        uint32 eventId = events2.ExecuteEvent();
        if (EventStage < EVENT_STAGE_MAIN && instance->GetBossState(DATA_NETHEKURSE) == IN_PROGRESS)
        {
            if (eventId == EVENT_INTRO)
            {
                EventStage = EVENT_STAGE_TAUNT;
            }
            else if (eventId == EVENT_START_ATTACK)
            {
                EventStage = EVENT_STAGE_MAIN;
                if (Unit* target = me->SelectNearestPlayer(50.0f))
                {
                    AttackStart(target);
                }
                DoAction(ACTION_CANCEL_INTRO);
                return;
            }
        }

        if (!UpdateVictim())
            return;

        if (EventStage < EVENT_STAGE_MAIN || me->HasUnitState(UNIT_STATE_CASTING))
            return;

        if (!me->HealthBelowPct(25))
            DoMeleeAttackIfReady();
    }

private:
    uint8 PeonEngagedCount = 0;
    uint8 PeonKilledCount = 0;
    uint8 EventStage;
    bool introDone;
    bool ATreached = false;
};

class spell_tsh_shadow_sear : public AuraScript
{
    PrepareAuraScript(spell_tsh_shadow_sear);

    void CalculateDamageAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        amount = 0;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_tsh_shadow_sear::CalculateDamageAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_tsh_shadow_bolt : public SpellScript
{
    PrepareSpellScript(spell_tsh_shadow_bolt);

    void SelectRandomPlayer(WorldObject*& target)
    {
        if (Creature* caster = GetCaster()->ToCreature())
        {
            std::list<Player*> playerList;
            Map::PlayerList const& players = caster->GetMap()->GetPlayers();
            for (auto itr = players.begin(); itr != players.end(); ++itr)
            {
                if (Player* player = itr->GetSource()->ToPlayer())
                {
                    if (player->IsWithinDist(caster, 100.0f) && player->IsAlive())
                    {
                        playerList.push_back(player);
                    }
                }
            }

            if (!playerList.empty())
            {
                target = Acore::Containers::SelectRandomContainerElement(playerList);
            }
        }
    }

    void Register() override
    {
        OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_tsh_shadow_bolt::SelectRandomPlayer, EFFECT_0, TARGET_UNIT_TARGET_ENEMY);
    }
};

class at_rp_nethekurse : public AreaTriggerScript
{
public:
    at_rp_nethekurse() : AreaTriggerScript("at_rp_nethekurse") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        if (player->IsGameMaster())
        {
            return false;
        }
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
    RegisterSpellScript(spell_tsh_shadow_sear);
    RegisterSpellScript(spell_tsh_shadow_bolt);
    new at_rp_nethekurse();
}
