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

#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "trial_of_the_champion.h"

enum Spells
{
    SPELL_RAISE_DEAD_JAEREN         = 67715,
    SPELL_RAISE_DEAD_ARELAS         = 67705,
    SPELL_BK_FEIGN_DEATH            = 67691,
    SPELL_BLACK_KNIGHT_RES          = 67693,
    SPELL_BK_KILL_CREDIT            = 68663,

    // phase 1
    SPELL_PLAGUE_STRIKE             = 67724,
    SPELL_ICY_TOUCH                 = 67718,
    SPELL_DEATH_RESPITE             = 67745,
    SPELL_OBLITERATE                = 67725,

    // phase 2 (+ abilities from phase 1 without death respite)
    SPELL_ARMY_DEAD                 = 67761,
    SPELL_DESECRATION               = 67778,
    SPELL_BK_GHOUL_EXPLODE          = 67751,

    // phase 3
    SPELL_DEATH_BITE                = 67808,
    SPELL_MARKED_DEATH              = 67823,

    // ghouls
    SPELL_CLAW                      = 67774,
    SPELL_EXPLODE                   = 67729,
    SPELL_LEAP                      = 67749,
};

enum Phases
{
    PHASE_ONE                       = 1,
    PHASE_TWO                       = 2,
    PHASE_THREE                     = 3,
};

enum ModelIds
{
    MODEL_SKELETON                  = 29846,
    MODEL_GHOST                     = 21300
};

enum GryphonWaypoints
{
    WAYPOINT_GRYPHON_LANDING        = 12, // lands and pauses here, the instance resumes the run after the scene
};

struct boss_black_knight : public BossAI
{
    boss_black_knight(Creature* creature) : BossAI(creature, BOSS_BLACK_KNIGHT) { }

    void Reset() override
    {
        BossAI::Reset();
        _phase = PHASE_ONE;
        me->SetDisplayId(me->GetNativeDisplayId());
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->SetImmuneToAll(true);
        me->SetReactState(REACT_PASSIVE);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        me->DespawnOrUnsummon(1ms);
        BossAI::EnterEvadeMode(why);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/,
        SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
        {
            damage = 0;
            return;
        }

        if (_phase < PHASE_THREE && damage >= me->GetHealth())
        {
            damage = 0;
            me->SetHealth(me->GetMaxHealth());
            scheduler.CancelAll();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->RemoveAllAuras();
            me->SetControlled(true, UNIT_STATE_STUNNED);
            DoCastSelf(SPELL_BK_GHOUL_EXPLODE, true);
            summons.clear();

            DoCastSelf(SPELL_BK_FEIGN_DEATH, true);
            me->SetUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
            me->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
            me->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
            me->AddUnitState(UNIT_STATE_DIED);
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_DESPAWN_SUMMONS)
        {
            summons.DespawnAll();
        }
        else if (action == ACTION_START_ENCOUNTER)
        {
            if (!instance)
                return;

            instance->SetBossState(BOSS_BLACK_KNIGHT, IN_PROGRESS);
            Talk(SAY_BK_AGGRO);
            bool const isHorde = instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE;
            DoCastAOE(isHorde ? SPELL_RAISE_DEAD_JAEREN : SPELL_RAISE_DEAD_ARELAS);
            if (Creature* announcer = instance->GetCreature(DATA_ANNOUNCER))
                announcer->DespawnOrUnsummon();

            scheduler.CancelAll();
            scheduler.Schedule(2500ms, PHASE_ONE, [this](TaskContext /*context*/)
            {
                if (!instance || summons.empty())
                    return;

                if (Creature* ghoul = me->GetMap()->GetCreature(*summons.begin()))
                    if (urand(0, 1))
                        /// @todo: Multiple variations + not always happening, from video sources,
                        /// needs sniff to transition from DB.
                        ghoul->Yell("[Zombie] .... . Brains ....", LANG_UNIVERSAL);
            });
            SchedulePhaseOneAbilities();
        }
    }

    void SchedulePhaseOneAbilities()
    {
        scheduler.Schedule(7s, 9s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastVictim(SPELL_PLAGUE_STRIKE);
            context.Repeat(10s, 12s);
        });
        scheduler.Schedule(3500ms, 7s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ICY_TOUCH);
            context.Repeat(5s, 6s);
        });
        scheduler.Schedule(13s, 15s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_DEATH_RESPITE, 0, 50.0f, true);
            context.Repeat(13s, 15s);
        });
        scheduler.Schedule(11s, 19s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastVictim(SPELL_OBLITERATE);
            context.Repeat(15s, 17s);
        });
    }

    void SchedulePhaseTwoAbilities()
    {
        scheduler.Schedule(7s, 9s, PHASE_TWO, [this](TaskContext context)
        {
            DoCastVictim(SPELL_PLAGUE_STRIKE);
            context.Repeat(10s, 12s);
        });
        scheduler.Schedule(3500ms, 7s, PHASE_TWO, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ICY_TOUCH);
            context.Repeat(5s, 6s);
        });
        scheduler.Schedule(11s, 19s, PHASE_TWO, [this](TaskContext context)
        {
            DoCastVictim(SPELL_OBLITERATE);
            context.Repeat(15s, 17s);
        });
        scheduler.Schedule(2s, 3s, PHASE_TWO, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_DESECRATION, 0, 50.0f, true);
            context.Repeat(14s, 17s);
        });
    }

    void SchedulePhaseThreeAbilities()
    {
        scheduler.Schedule(2s, PHASE_THREE, [this](TaskContext context)
        {
            DoCastAOE(SPELL_DEATH_BITE);
            context.Repeat(2s, 4s);
        });
        scheduler.Schedule(1s, PHASE_THREE, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_MARKED_DEATH, 0, 0.0f, true);
            context.Repeat(9s);
        });
    }

    void SpellHitTarget(Unit* /*target*/, SpellInfo const* spell) override
    {
        if (spell->Id != SPELL_BLACK_KNIGHT_RES)
            return;

        me->SetHealth(me->GetMaxHealth());
        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->SetImmuneToAll(false);
        me->SetControlled(false, UNIT_STATE_STUNNED);

        me->RemoveUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
        me->RemoveUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        me->RemoveDynamicFlag(UNIT_DYNFLAG_DEAD);
        me->ClearUnitState(UNIT_STATE_DIED);

        ++_phase;

        switch (_phase)
        {
            case PHASE_TWO:
                me->SetDisplayId(MODEL_SKELETON);
                Talk(SAY_BK_PHASE_2);
                DoCastSelf(SPELL_ARMY_DEAD);

                scheduler.CancelAll();
                SchedulePhaseTwoAbilities();
                break;
            case PHASE_THREE:
                me->SetDisplayId(MODEL_GHOST);
                Talk(SAY_BK_PHASE_3);

                scheduler.CancelAll();
                SchedulePhaseThreeAbilities();
                break;
            default:
                EnterEvadeMode(EVADE_REASON_OTHER);
                break;
        }
    }

    void JustSummoned(Creature* summon) override
    {
        BossAI::JustSummoned(summon);
        if (Unit* target = summon->SelectNearestTarget(200.0f))
            summon->AI()->AttackStart(target);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_BK_KILL_PLAYER);
    }

    void JustDied(Unit* killer) override
    {
        DoCastAOE(SPELL_BK_KILL_CREDIT, true);
        Talk(SAY_BK_DEATH);
        if (me->ToTempSummon())
            me->ToTempSummon()->SetTempSummonType(TEMPSUMMON_MANUAL_DESPAWN);

        BossAI::JustDied(killer);
    }

private:
    uint8 _phase = PHASE_ONE;
};

struct npc_black_knight_skeletal_gryphon : public npc_escortAI
{
    npc_black_knight_skeletal_gryphon(Creature* creature) : npc_escortAI(creature) { }

    void Reset() override
    {
        Start(false);
        SetDespawnAtEnd(true);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->SetImmuneToAll(true);
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_RESUME_ESCORT)
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
            SetEscortPaused(false);
        }
    }

    using CreatureAI::WaypointReached;
    void WaypointReached(uint32 point) override
    {
        if (point == WAYPOINT_GRYPHON_LANDING)
        {
            SetEscortPaused(true);
            me->SetOrientation(3.62f);
            me->SetControlled(true, UNIT_STATE_ROOT);
            me->DisableRotate(true);
            me->SetFacingTo(3.62f);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_MOUNT_SPECIAL);
            if (InstanceScript* instance = me->GetInstanceScript())
                instance->SetData(DATA_SKELETAL_GRYPHON_LANDED, 0);
        }
    }
};

struct npc_black_knight_ghoul : public CreatureAI
{
    npc_black_knight_ghoul(Creature* creature) : CreatureAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.CancelAll();

        if (me->GetEntry() == NPC_RISEN_JAEREN || me->GetEntry() == NPC_RISEN_ARELAS)
        {
            scheduler.Schedule(1s, [this](TaskContext context)
            {
                if (Unit* victim = me->GetVictim())
                    if (me->GetDistance(victim) > 5.0f && me->GetDistance(victim) < 30.0f)
                    {
                        DoCast(victim, SPELL_LEAP);
                        return; // the leap is used once, it is not repeated
                    }

                context.Repeat(1s);
            });
        }

        scheduler.Schedule(3s, 4s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CLAW);
            context.Repeat(6s, 8s);
        });
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_BK_GHOUL_EXPLODE)
        {
            me->RemoveUnitFlag(UNIT_FLAG_STUNNED);
            DoCastSelf(SPELL_EXPLODE);
        }
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
};

class spell_black_knight_ghoul_claw : public SpellScript
{
    PrepareSpellScript(spell_black_knight_ghoul_claw);

    void HandleSpellHit(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            caster->GetThreatMgr().ResetAllThreat();
            if (Unit* target = caster->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 30.0f))
            {
                caster->AddThreat(target, 100.0f);
                caster->GetAI()->AttackStart(target);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_black_knight_ghoul_claw::HandleSpellHit, EFFECT_0,
            SPELL_EFFECT_WEAPON_PERCENT_DAMAGE);
    }
};

class spell_black_knight_ghoul_explode : public SpellScript
{
    PrepareSpellScript(spell_black_knight_ghoul_explode);

    void HandleSpellHit(SpellEffIndex /*effIndex*/)
    {
        if (GetHitUnit()->IsPlayer())
            if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                instance->SetData(DATA_ACHIEVEMENT_IVE_HAD_WORSE, 0);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_black_knight_ghoul_explode::HandleSpellHit, EFFECT_0,
            SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

void AddSC_boss_black_knight()
{
    RegisterTrialOfTheChampionCreatureAI(boss_black_knight);
    RegisterTrialOfTheChampionCreatureAI(npc_black_knight_skeletal_gryphon);
    RegisterTrialOfTheChampionCreatureAI(npc_black_knight_ghoul);
    RegisterSpellScript(spell_black_knight_ghoul_claw);
    RegisterSpellScript(spell_black_knight_ghoul_explode);
}
