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
#include "SpellScriptLoader.h"
#include "magisters_terrace.h"
#include "MapReference.h"
#include "Player.h"
#include "SpellScript.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_PHOENIX                 = 1,
    SAY_FLAMESTRIKE             = 2,
    SAY_GRAVITY_LAPSE           = 3,
    SAY_TIRED                   = 4,
    SAY_RECAST_GRAVITY          = 5,
    SAY_DEATH                   = 6,
    SAY_AGGRO_2                 = 7
};

enum Spells
{
    // Phase 1
    SPELL_FIREBALL                  = 44189,
    SPELL_FLAMESTRIKE_SUMMON        = 44192,
    SPELL_PHOENIX                   = 44194,
    SPELL_SHOCK_BARRIER             = 46165,
    SPELL_PYROBLAST                 = 36819,

    // Phase 2
    SPELL_SUMMON_ARCANE_SPHERE      = 44265,
    SPELL_TELEPORT_CENTER           = 44218,
    SPELL_GRAVITY_LAPSE_INITIAL     = 44224,
    SPELL_GRAVITY_LAPSE_PLAYER      = 44219, // Till 44223, 5 players
    SPELL_GRAVITY_LAPSE_FLY         = 44227,
    SPELL_GRAVITY_LAPSE_DOT         = 44226,
    SPELL_GRAVITY_LAPSE_CHANNEL     = 44251,
    SPELL_POWER_FEEDBACK            = 44233,
    SPELL_CLEAR_FLIGHT              = 44232, // Does nothing currently

    SPELL_EMOTE_EXCLAMATION         = 48348,
    SPELL_EMOTE_POINT               = 48349,
    SPELL_EMOTE_ROAR                = 48350
};

enum Misc
{
    ACTION_TELEPORT_PLAYERS     = 1,
    ACTION_KNOCKUP              = 2,
    ACTION_ALLOW_FLY            = 3,
    ACTION_REMOVE_FLY           = 4,

    CREATURE_ARCANE_SPHERE      = 24708
};

struct boss_felblood_kaelthas : public BossAI
{
    boss_felblood_kaelthas(Creature* creature) : BossAI(creature, DATA_KAELTHAS) { }

    void Reset() override
    {
        BossAI::Reset();
        _gravityLapseCounter = 0;
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);

        ScheduleHealthCheckEvent(50, [&]{
            me->CastStop();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
            DoCastSelf(SPELL_TELEPORT_CENTER, true);
            scheduler.CancelAll();

            me->StopMoving();
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
            ScheduleTimedEvent(5s, [&]{
                summons.DoForAllSummons([&](WorldObject* summon){
                    if (Unit* player = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                        if (Creature* summonedCreature = summon->ToCreature())
                            summonedCreature->GetMotionMaster()->MoveChase(player);
                });
            }, 10s, 15s);
            GravityLapseSequence(true);
        });
    }

    void GravityLapseSequence(bool firstTime)
    {
        Talk(firstTime ? SAY_GRAVITY_LAPSE : SAY_RECAST_GRAVITY);
        DoCastSelf(SPELL_GRAVITY_LAPSE_INITIAL);
        scheduler.Schedule(2s, [this](TaskContext){
            LapseAction(ACTION_TELEPORT_PLAYERS);
        }).Schedule(3s, [this](TaskContext){
            LapseAction(ACTION_KNOCKUP);
        }).Schedule(4s, [this](TaskContext){
            LapseAction(ACTION_ALLOW_FLY);
            for (uint8 i = 0; i < 3; ++i)
                DoCastSelf(SPELL_SUMMON_ARCANE_SPHERE, true);
            DoCastSelf(SPELL_GRAVITY_LAPSE_CHANNEL);
            scheduler.Schedule(30s, [this](TaskContext){
                LapseAction(ACTION_REMOVE_FLY);
                me->InterruptNonMeleeSpells(false);
                Talk(SAY_TIRED);
                DoCastSelf(SPELL_POWER_FEEDBACK);
                scheduler.Schedule(10s, [this](TaskContext){
                    GravityLapseSequence(false);
                });
            });
        });
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        if (GameObject* orb = instance->GetGameObject(DATA_ESCAPE_ORB))
            orb->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        ScheduleTimedEvent(0ms, [&]{
            DoCastVictim(SPELL_FIREBALL);
        }, 3000ms, 4500ms);
        ScheduleTimedEvent(15s, [&]{
            Talk(SAY_PHOENIX);
            DoCastSelf(SPELL_PHOENIX);
        }, 60s);
        ScheduleTimedEvent(22s, [&]{
            DoCastRandomTarget(SPELL_FLAMESTRIKE_SUMMON, 0, 100.0f);
            Talk(SAY_FLAMESTRIKE);
        }, 25s);

        if (IsHeroic())
            ScheduleTimedEvent(50s, [&]{
                DoCastSelf(SPELL_SHOCK_BARRIER, true);
                me->CastCustomSpell(SPELL_PYROBLAST, SPELLVALUE_MAX_TARGETS, 1, (Unit*)nullptr, false);
            }, 50s);
    }

    void DoAction(int32 actionId) override
    {
        if (actionId == DATA_KAEL_INTRO)
        {
            uint32 counter = instance->GetPersistentData(DATA_KAEL_INTRO);
            instance->StorePersistentData(DATA_KAEL_INTRO, ++counter);

            if (counter == 6 && !me->IsInCombat())
            {
                me->SetEmoteState(EMOTE_STATE_TALK);
                Talk(SAY_AGGRO);

                me->m_Events.AddEventAtOffset([&] {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH_NO_SHEATHE);
                }, 15s);

                Talk(SAY_AGGRO_2, 20s);
                me->SetImmuneToAll(true);

                me->m_Events.AddEventAtOffset([&] {
                    me->ClearEmoteState();
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetImmuneToAll(false);
                }, 35s);
            }
        }
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask) override
    {
        if (damage >= me->GetHealth())
        {
            damage = me->GetHealth() - 1;
            if (me->isRegeneratingHealth())
            {
                me->CombatStop();
                me->CastStop();
                me->SetRegeneratingHealth(false);
                me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                me->SetImmuneToAll(true);
                me->SetReactState(REACT_PASSIVE);
                LapseAction(ACTION_REMOVE_FLY);
                scheduler.CancelAll();
                summons.DespawnAll();

                Talk(SAY_DEATH);
                DoCastSelf(SPELL_EMOTE_EXCLAMATION);

                me->m_Events.AddEventAtOffset([&] {
                    DoCastSelf(SPELL_EMOTE_POINT);
                }, 3s);

                me->m_Events.AddEventAtOffset([&] {
                    DoCastSelf(SPELL_EMOTE_ROAR);
                }, 7s);

                me->m_Events.AddEventAtOffset([&] {
                    DoCastSelf(SPELL_EMOTE_ROAR);
                    DoCastSelf(SPELL_CLEAR_FLIGHT);
                }, 9s);

                me->m_Events.AddEventAtOffset([&] {
                    me->KillSelf();
                }, 11s);
            }
        }
        BossAI::DamageTaken(attacker, damage, damagetype, damageSchoolMask);
    }

    void LapseAction(uint8 action)
    {
        _gravityLapseCounter = 0;
        me->GetMap()->DoForAllPlayers([&](Player* player)
        {
            if (player->IsGameMaster())
                return;

            if (action == ACTION_TELEPORT_PLAYERS)
                DoCast(player, SPELL_GRAVITY_LAPSE_PLAYER + _gravityLapseCounter, true);
            else if (action == ACTION_KNOCKUP)
                player->CastSpell(player, SPELL_GRAVITY_LAPSE_DOT, true, nullptr, nullptr, me->GetGUID());
            else if (action == ACTION_ALLOW_FLY)
                player->CastSpell(player, SPELL_GRAVITY_LAPSE_FLY, true, nullptr, nullptr, me->GetGUID());
            else if (action == ACTION_REMOVE_FLY)
            {
                player->RemoveAurasDueToSpell(SPELL_GRAVITY_LAPSE_FLY);
                player->RemoveAurasDueToSpell(SPELL_GRAVITY_LAPSE_DOT);
            }
            ++_gravityLapseCounter;
        });
    }
private:
    uint8 _gravityLapseCounter;
};

class spell_mt_phoenix_burn : public SpellScript
{
    PrepareSpellScript(spell_mt_phoenix_burn);

    void HandleAfterCast()
    {
        uint32 damage = CalculatePct(GetCaster()->GetMaxHealth(), 5);
        Unit::DealDamage(GetCaster(), GetCaster(), damage);
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_mt_phoenix_burn::HandleAfterCast);
    }
};

void AddSC_boss_felblood_kaelthas()
{
    RegisterMagistersTerraceCreatureAI(boss_felblood_kaelthas);
    RegisterSpellScript(spell_mt_phoenix_burn);
}
