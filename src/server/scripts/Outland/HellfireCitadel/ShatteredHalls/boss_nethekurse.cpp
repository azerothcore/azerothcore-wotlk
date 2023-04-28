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

enum eGrandWarlockNethekurse
{
    SAY_INTRO                  = 0,
    SAY_INTRO_2                = 1,
    SAY_PEON_ATTACKED          = 2,
    SAY_PEON_DIES              = 3,
    SAY_SHADOW_SEAR            = 4,
    SAY_SHADOW_FISSURE         = 5,
    SAY_DEATH_COIL             = 6,
    SAY_SLAY                   = 7,
    SAY_DIE                    = 8,

    SPELL_DEATH_COIL_N         = 30500,
    SPELL_DEATH_COIL_H         = 35954,
    SPELL_DARK_SPIN            = 30502,
    SPELL_SHADOW_FISSURE       = 30496,
    SPELL_SHADOW_CLEAVE_N      = 30495,
    SPELL_SHADOW_SLAM_H        = 35953,

    // Spells used exclusively in RP
    SPELL_SHADOW_SEAR          = 30735,
    SPELL_DEATH_COIL           = 30741,

    EVENT_INTRO                = 1,
    EVENT_START_ATTACK         = 2,

    EVENT_STAGE_NONE           = 0,
    EVENT_STAGE_INTRO          = 1,
    EVENT_STAGE_TAUNT          = 2,
    EVENT_STAGE_MAIN           = 3,

    SETDATA_DATA               = 1,
    SETDATA_PEON_AGGRO         = 1,
    SETDATA_PEON_DEATH         = 2,
};

enum Creatures
{
    NPC_PEON                   = 17083
};

enum Groups
{
    GROUP_RP                   = 0,
};

enum Actions
{
    ACTION_START_INTRO         = 0,
    ACTION_CANCEL_INTRO        = 1,
    ACTION_START_COMBAT        = 2,
};

// ########################################################
// Grand Warlock Nethekurse
// ########################################################

float NethekurseIntroPath[4][3] =
{
    {184.78966f, 290.3699f, -8.18139f},
    {178.51125f, 278.97794f, -8.183065f},
    {171.82281f, 289.97687f, -8.185595f},
    {178.51125f, 287.97794f, -8.183065f}
};
class boss_grand_warlock_nethekurse : public CreatureScript
{
public:
    boss_grand_warlock_nethekurse() : CreatureScript("boss_grand_warlock_nethekurse") { }

    struct boss_grand_warlock_nethekurseAI : public BossAI
    {
        boss_grand_warlock_nethekurseAI(Creature* creature) : BossAI(creature, DATA_NETHEKURSE)
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
                        Talk(SAY_PEON_ATTACKED);
                    break;
                case SETDATA_PEON_DEATH:
                    if (PeonKilledCount >= 4)
                        return;

                    if (EventStage < EVENT_STAGE_TAUNT)
                    {
                        me->GetMotionMaster()->Clear();
                        me->SetFacingTo(4.572762489318847656f);
                        scheduler.Schedule(500ms, GROUP_RP, [this](TaskContext context)
                        {
                            me->HandleEmoteCommand(EMOTE_ONESHOT_APPLAUD);
                            Talk(SAY_PEON_DIES);
                        });
                    }
                    if (++PeonKilledCount == 4)
                        DoAction(ACTION_CANCEL_INTRO);
                    break;
            }
        }
        
        void AttackStart(Unit* who) override
        {
            if (EventStage < EVENT_STAGE_MAIN)
                return;

            if (me->Attack(who, true))
            {
                DoStartMovement(who);
            }
        }

        void MoveInLineOfSight(Unit* who) override { }

        void IntroRP()
        {
            scheduler.Schedule(500ms, GROUP_RP, [this](TaskContext context)
            {
                me->GetMotionMaster()->Clear();
                uint32 choicelocation = urand(0, 3);
                me->GetMotionMaster()->MovePoint(0, NethekurseIntroPath[choicelocation][0], NethekurseIntroPath[choicelocation][1], NethekurseIntroPath[choicelocation][2]);
                CastRandomPeonSpell();
                context.Repeat(19400ms, 31500ms);
            });
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            Talk(SAY_INTRO_2);
            LOG_ERROR("server", "Data {}", "combat start");
            scheduler.Schedule(12150ms, 19850ms, [this](TaskContext context)
            {
                if (me->HealthBelowPct(90))
                {
                    DoCastRandomTarget(DUNGEON_MODE(SPELL_DEATH_COIL_N, SPELL_DEATH_COIL_H), 0, 30.0f, true);
                }
                context.Repeat();
            }).Schedule(8100ms, 17300ms, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_SHADOW_FISSURE, 0, 60.0f, true);
                context.Repeat(8450ms, 9450ms);
            }).Schedule(10950ms, 21850ms, [this](TaskContext context)
            {
                DoCastVictim(DUNGEON_MODE(SPELL_SHADOW_CLEAVE_N, SPELL_SHADOW_SLAM_H));
                context.Repeat(1200ms, 23900ms);
            }).Schedule(1s, [this](TaskContext context)
            {
                if (me->HealthBelowPct(25))
                {
                    DoCastSelf(SPELL_DARK_SPIN);
                }
                else
                {
                    context.Repeat();
                }
            });
        }

        void CastRandomPeonSpell()
        {
            LOG_ERROR("server", "Data {}", "spellcast debug peon");
            uint32 choice = urand(1, 3);
            LOG_ERROR("server", "Data {}", std::to_string(choice).c_str());
            if (choice == 1)
            {
                Talk(SAY_SHADOW_SEAR);
                me->CastSpell(me, SPELL_SHADOW_SEAR, false);
                me->SetFullHealth();
            }
            else if (choice == 2)
            {
                Talk(SAY_SHADOW_FISSURE);
                me->CastSpell(me->FindNearestCreature(NPC_PEON, 40.0f), SPELL_SHADOW_FISSURE, true);
            }
            else if (choice == 3)
            {
                Talk(SAY_DEATH_COIL);
                me->CastSpell(me, SPELL_DEATH_COIL, false);
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
                LOG_ERROR("server", "Data {}", "intro done - all peons dead");
                events2.ScheduleEvent(EVENT_START_ATTACK, 1000);
                instance->SetBossState(DATA_NETHEKURSE, IN_PROGRESS);
                me->SetInCombatWithZone();
                return;
            }

            if (action != ACTION_START_INTRO)
            {
                return;
            }

            events2.ScheduleEvent(EVENT_INTRO, 90000);
            Talk(SAY_INTRO);
            LOG_ERROR("server", "Data {}", "event started");
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
                        AttackStart(target);
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
    };
    

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetShatteredHallsAI<boss_grand_warlock_nethekurseAI>(creature);
    }
};

class spell_tsh_shadow_sear : public SpellScriptLoader
{
public:
    spell_tsh_shadow_sear() : SpellScriptLoader("spell_tsh_shadow_sear") { }

    class spell_tsh_shadow_sear_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_tsh_shadow_sear_AuraScript);

        void CalculateDamageAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
            amount = 1000;
        }

        void Register() override
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_tsh_shadow_sear_AuraScript::CalculateDamageAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_tsh_shadow_sear_AuraScript();
    }
};

class spell_tsh_shadow_bolt : public SpellScriptLoader
{
public:
    spell_tsh_shadow_bolt() : SpellScriptLoader("spell_tsh_shadow_bolt") { }

    class spell_tsh_shadow_bolt_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_tsh_shadow_bolt_SpellScript);

        void SelectRandomPlayer(WorldObject*& target)
        {
            if (Creature* caster = GetCaster()->ToCreature())
            {
                std::list<Player*> playerList;
                Map::PlayerList const& players = caster->GetMap()->GetPlayers();
                for (auto itr = players.begin(); itr != players.end(); ++itr)
                    if (Player* player = itr->GetSource()->ToPlayer())
                        if (player->IsWithinDist(caster, 100.0f) && player->IsAlive())
                            playerList.push_back(player);

                if (!playerList.empty())
                    target = Acore::Containers::SelectRandomContainerElement(playerList);
            }
        }

        void Register() override
        {
            OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_tsh_shadow_bolt_SpellScript::SelectRandomPlayer, EFFECT_0, TARGET_UNIT_TARGET_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_tsh_shadow_bolt_SpellScript();
    }
};

class at_rp_nethekurse : public AreaTriggerScript
{
    public:
    at_rp_nethekurse() : AreaTriggerScript
    ("at_rp_nethekurse") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        if (player->IsGameMaster())
        {
            return false;
        }
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            LOG_ERROR("server", "Data {}", "AT Nethekurse reached by non-GM");
            if (Creature* nethekurse = instance->GetCreature(DATA_NETHEKURSE))
            {
                LOG_ERROR("server", "Data {}", "AT Nethekurse action started");
                nethekurse->AI()->DoAction(ACTION_START_INTRO);
            }           

            return true;
        }
        return false;
    }
};

void AddSC_boss_grand_warlock_nethekurse()
{
    new boss_grand_warlock_nethekurse();
    new spell_tsh_shadow_sear();
    new spell_tsh_shadow_bolt();
    new at_rp_nethekurse();
}
