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
    SAY_DEATH                   = 6
};

enum Spells
{
    // Phase 1
    SPELL_FIREBALL_N                = 44189,
    SPELL_FIREBALL_H                = 46164,
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
    SPELL_POWER_FEEDBACK            = 44233
};

enum Misc
{
    EVENT_INIT_COMBAT           = 1,
    EVENT_SPELL_FIREBALL        = 2,
    EVENT_SPELL_PHOENIX         = 3,
    EVENT_SPELL_FLAMESTRIKE     = 4,
    EVENT_SPELL_SHOCK_BARRIER   = 5,
    EVENT_CHECK_HEALTH          = 6,
    EVENT_GRAVITY_LAPSE_1_1     = 7,
    EVENT_GRAVITY_LAPSE_1_2     = 8,
    EVENT_GRAVITY_LAPSE_2       = 9,
    EVENT_GRAVITY_LAPSE_3       = 10,
    EVENT_GRAVITY_LAPSE_4       = 11,
    EVENT_GRAVITY_LAPSE_5       = 12,
    EVENT_FINISH_TALK           = 13,

    ACTION_TELEPORT_PLAYERS     = 1,
    ACTION_KNOCKUP              = 2,
    ACTION_ALLOW_FLY            = 3,
    ACTION_REMOVE_FLY           = 4,

    CREATURE_ARCANE_SPHERE      = 24708
};

struct boss_felblood_kaelthas : public ScriptedAI
{
    boss_felblood_kaelthas(Creature* creature) : ScriptedAI(creature), summons(me)
    {
        instance = creature->GetInstanceScript();
        introSpeak = false;
    }

    InstanceScript* instance;
    EventMap events;
    EventMap events2;
    SummonList summons;
    bool introSpeak;

    void Reset() override
    {
        events.Reset();
        summons.DespawnAll();
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
        instance->SetBossState(DATA_KAELTHAS, NOT_STARTED);
        me->SetImmuneToAll(false);
    }

    void JustSummoned(Creature* summon) override
    {
        for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
            if (*itr == summon->GetGUID())
                return;
        summons.Summon(summon);
    }

    void InitializeAI() override
    {
        ScriptedAI::InitializeAI();
        me->SetImmuneToAll(true);
    }

    void JustDied(Unit*) override
    {
        instance->SetBossState(DATA_KAELTHAS, DONE);

        if (GameObject* orb = instance->GetGameObject(DATA_ESCAPE_ORB))
        {
            orb->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        instance->SetBossState(DATA_KAELTHAS, IN_PROGRESS);
        me->SetInCombatWithZone();

        events.ScheduleEvent(EVENT_SPELL_FIREBALL, 0);
        events.ScheduleEvent(EVENT_SPELL_PHOENIX, 15000);
        events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 22000);
        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);

        if (IsHeroic())
            events.ScheduleEvent(EVENT_SPELL_SHOCK_BARRIER, 50000);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!introSpeak && me->IsWithinDistInMap(who, 40.0f) && who->GetTypeId() == TYPEID_PLAYER)
        {
            Talk(SAY_AGGRO);
            introSpeak = true;
            events2.ScheduleEvent(EVENT_INIT_COMBAT, 35000);
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (damage >= me->GetHealth())
        {
            damage = me->GetHealth() - 1;
            if (me->isRegeneratingHealth())
            {
                me->SetRegeneratingHealth(false);
                me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                me->SetImmuneToAll(true);
                me->CombatStop();
                me->SetReactState(REACT_PASSIVE);
                LapseAction(ACTION_REMOVE_FLY);
                events.Reset();
                events2.ScheduleEvent(EVENT_FINISH_TALK, 6000);
                Talk(SAY_DEATH);
            }
        }
    }

    void LapseAction(uint8 action)
    {
        uint8 counter = 0;
        Map::PlayerList const& playerList = me->GetMap()->GetPlayers();
        for (Map::PlayerList::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr, ++counter)
            if (Player* player = itr->GetSource())
            {
                if (action == ACTION_TELEPORT_PLAYERS)
                    me->CastSpell(player, SPELL_GRAVITY_LAPSE_PLAYER + counter, true);
                else if (action == ACTION_KNOCKUP)
                    player->CastSpell(player, SPELL_GRAVITY_LAPSE_DOT, true, nullptr, nullptr, me->GetGUID());
                else if (action == ACTION_ALLOW_FLY)
                    player->CastSpell(player, SPELL_GRAVITY_LAPSE_FLY, true, nullptr, nullptr, me->GetGUID());
                else if (action == ACTION_REMOVE_FLY)
                {
                    player->RemoveAurasDueToSpell(SPELL_GRAVITY_LAPSE_FLY);
                    player->RemoveAurasDueToSpell(SPELL_GRAVITY_LAPSE_DOT);
                }
            }
    }

    void UpdateAI(uint32 diff) override
    {
        events2.Update(diff);
        switch (events2.ExecuteEvent())
        {
        case EVENT_INIT_COMBAT:
            me->SetImmuneToAll(false);
            if (Unit* target = SelectTargetFromPlayerList(50.0f))
                AttackStart(target);
            return;
        case EVENT_FINISH_TALK:
            me->KillSelf();
            return;
        }

        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (uint32 eventId = events.ExecuteEvent())
        {
        case EVENT_SPELL_FIREBALL:
            me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_FIREBALL_N, SPELL_FIREBALL_H), false);
            events.ScheduleEvent(EVENT_SPELL_FIREBALL, urand(3000, 4500));
            break;
        case EVENT_SPELL_FLAMESTRIKE:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
            {
                me->CastSpell(target, SPELL_FLAMESTRIKE_SUMMON, true);
                Talk(SAY_FLAMESTRIKE);
            }
            events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 25000);
            break;
        case EVENT_SPELL_SHOCK_BARRIER:
            me->CastSpell(me, SPELL_SHOCK_BARRIER, true);
            me->CastCustomSpell(SPELL_PYROBLAST, SPELLVALUE_MAX_TARGETS, 1, (Unit*)nullptr, false);
            events.ScheduleEvent(EVENT_SPELL_SHOCK_BARRIER, 50000);
            break;
        case EVENT_SPELL_PHOENIX:
            Talk(SAY_PHOENIX);
            me->CastSpell(me, SPELL_PHOENIX, false);
            events.ScheduleEvent(EVENT_SPELL_PHOENIX, 60000);
            break;
        case EVENT_CHECK_HEALTH:
            if (HealthBelowPct(50))
            {
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
                me->CastSpell(me, SPELL_TELEPORT_CENTER, true);
                events.Reset();

                me->StopMoving();
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveIdle();

                events.SetPhase(1);
                events.ScheduleEvent(EVENT_GRAVITY_LAPSE_1_1, 0);
                break;
            }
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 500);
            break;
        case EVENT_GRAVITY_LAPSE_1_1:
        case EVENT_GRAVITY_LAPSE_1_2:
            Talk(eventId == EVENT_GRAVITY_LAPSE_1_1 ? SAY_GRAVITY_LAPSE : SAY_RECAST_GRAVITY);
            me->CastSpell(me, SPELL_GRAVITY_LAPSE_INITIAL, false);
            events.ScheduleEvent(EVENT_GRAVITY_LAPSE_2, 2000);
            break;
        case EVENT_GRAVITY_LAPSE_2:
            LapseAction(ACTION_TELEPORT_PLAYERS);
            events.ScheduleEvent(EVENT_GRAVITY_LAPSE_3, 1000);
            break;
        case EVENT_GRAVITY_LAPSE_3:
            LapseAction(ACTION_KNOCKUP);
            events.ScheduleEvent(EVENT_GRAVITY_LAPSE_4, 1000);
            break;
        case EVENT_GRAVITY_LAPSE_4:
            LapseAction(ACTION_ALLOW_FLY);
            for (uint8 i = 0; i < 3; ++i)
                me->CastSpell(me, SPELL_SUMMON_ARCANE_SPHERE, true);

            me->CastSpell(me, SPELL_GRAVITY_LAPSE_CHANNEL, false);
            events.ScheduleEvent(EVENT_GRAVITY_LAPSE_5, 30000);
            break;
        case EVENT_GRAVITY_LAPSE_5:
            LapseAction(ACTION_REMOVE_FLY);
            me->InterruptNonMeleeSpells(false);
            Talk(SAY_TIRED);
            me->CastSpell(me, SPELL_POWER_FEEDBACK, false);
            events.ScheduleEvent(EVENT_GRAVITY_LAPSE_1_2, 10000);
            break;
        }

        if (events.GetPhaseMask() == 0)
            DoMeleeAttackIfReady();
    }
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

