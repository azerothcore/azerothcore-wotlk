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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "drak_tharon_keep.h"

enum Yells
{
    SAY_AGGRO                           = 0,
    SAY_KILL                            = 1,
    SAY_DEATH                           = 2,
    SAY_SUMMONING_ADDS                  = 3,
    SAY_ARCANE_FIELD                    = 4,
    EMOTE_SUMMONING_ADDS                = 5
};

enum Spells
{
    SPELL_BEAM_CHANNEL                  = 52106,
    SPELL_ARCANE_BLAST                  = 49198,
    SPELL_ARCANE_FIELD                  = 47346,
    SPELL_SUMMON_FETID_TROLL_CORPSE     = 49103,
    SPELL_SUMMON_HULKING_CORPSE         = 49104,
    SPELL_SUMMON_RISEN_SHADOWCASTER     = 49105,
    SPELL_SUMMON_CRYSTAL_HANDLER        = 49179,
    SPELL_DESPAWN_CRYSTAL_HANDLER       = 51403,

    SPELL_SUMMON_MINIONS                = 59910,
    SPELL_COPY_OF_SUMMON_MINIONS        = 59933,
    SPELL_BLIZZARD                      = 49034,
    SPELL_FROSTBOLT                     = 49037,
    SPELL_TOUCH_OF_MISERY               = 50090
};

enum Misc
{
    NPC_CRYSTAL_CHANNEL_TARGET              = 26712,
    NPC_CRYSTAL_HANDLER                     = 26627,
    NPC_SUMMON_CRYSTAL_HANDLER_TARGET       = 27583,

    EVENT_SUMMON_FETID_TROLL                = 1,
    EVENT_SUMMON_SHADOWCASTER               = 2,
    EVENT_SUMMON_HULKING_CORPSE             = 3,
    EVENT_SUMMON_CRYSTAL_HANDLER            = 4,
    EVENT_CAST_OFFENSIVE_SPELL              = 5,
    EVENT_KILL_TALK                         = 6,
    EVENT_CHECK_PHASE                       = 7,
    EVENT_SPELL_SUMMON_MINIONS              = 8,

    ROOM_RIGHT  = 0,
    ROOM_LEFT   = 1,
    ROOM_STAIRS = 2
};

std::unordered_map<uint32, std::tuple <uint32, Position>> const npcSummon =
{
    { ROOM_RIGHT,   { NPC_SUMMON_CRYSTAL_HANDLER_TARGET,    { -341.31f, -724.40f, 28.57f, 0.0f } } },
    { ROOM_LEFT,    { NPC_SUMMON_CRYSTAL_HANDLER_TARGET,    { -408.87f, -730.21f, 28.58f, 0.0f } } },
    { ROOM_STAIRS,  { NPC_CRYSTAL_CHANNEL_TARGET,           { -378.40f, -813.13f, 59.74f, 0.0f } } },
};

class boss_novos : public CreatureScript
{
public:
    boss_novos() : CreatureScript("boss_novos") { }

    struct boss_novosAI : public BossAI
    {
        boss_novosAI(Creature* creature) : BossAI(creature, DATA_NOVOS)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
            instance->SetBossState(DATA_NOVOS_CRYSTALS, IN_PROGRESS);
            instance->SetBossState(DATA_NOVOS_CRYSTALS, NOT_STARTED);
            _crystalCounter = 0;
            _summonTargetRightGUID.Clear();
            _summonTargetLeftGUID.Clear();
            _stage = 0;

            me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

            _achievement = true;
        }

        uint32 GetData(uint32 data) const override
        {
            if (data == me->GetEntry())
                return uint32(_achievement);
            return 0;
        }

        void SetData(uint32 type, uint32) override
        {
            if (type == me->GetEntry())
                _achievement = false;
        }

        void MoveInLineOfSight(Unit*  /*who*/) override { }

        void JustEngagedWith(Unit* who) override
        {
            Talk(SAY_AGGRO);
            BossAI::JustEngagedWith(who);

            events.ScheduleEvent(EVENT_SUMMON_FETID_TROLL, 3s);
            events.ScheduleEvent(EVENT_SUMMON_SHADOWCASTER, 9s);
            events.ScheduleEvent(EVENT_SUMMON_HULKING_CORPSE, 30s);
            events.ScheduleEvent(EVENT_SUMMON_CRYSTAL_HANDLER, 20s);
            events.ScheduleEvent(EVENT_CHECK_PHASE, 80s);

            me->CastSpell(me, SPELL_ARCANE_BLAST, true);
            me->CastSpell(me, SPELL_ARCANE_FIELD, true);
            me->CastSpell(me, SPELL_DESPAWN_CRYSTAL_HANDLER, true);

            for (auto& itr : npcSummon)
            {
                uint32 summonEntry;
                Position summonPos;
                std::tie(summonEntry, summonPos) = itr.second;
                if (Creature* creature = me->SummonCreature(summonEntry, summonPos))
                    switch (itr.first)
                    {
                        case ROOM_LEFT:
                            _summonTargetLeftGUID = creature->GetGUID();
                            break;
                        case ROOM_RIGHT:
                            _summonTargetRightGUID = creature->GetGUID();
                            break;
                    }
            }

            me->SetGuidValue(UNIT_FIELD_TARGET, ObjectGuid::Empty);
            me->RemoveAllAuras();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }

        void JustDied(Unit* killer) override
        {
            Talk(SAY_DEATH);
            BossAI::JustDied(killer);
            instance->SetBossState(DATA_NOVOS_CRYSTALS, DONE);
        }

        void KilledUnit(Unit*  /*victim*/) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_KILL);
                events.ScheduleEvent(EVENT_KILL_TALK, 6s);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            if (me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE) && summon->GetEntry() != NPC_CRYSTAL_CHANNEL_TARGET && summon->GetEntry() != NPC_CRYSTAL_HANDLER)
                summon->SetReactState(REACT_DEFENSIVE);
            else if (summon->GetEntry() != NPC_CRYSTAL_CHANNEL_TARGET)
                summon->SetInCombatWithZone();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_SUMMON_FETID_TROLL:
                    if (Creature* trigger = summons.GetCreatureWithEntry(NPC_CRYSTAL_CHANNEL_TARGET))
                        trigger->CastSpell(trigger, SPELL_SUMMON_FETID_TROLL_CORPSE, true, nullptr, nullptr, me->GetGUID());
                    events.ScheduleEvent(EVENT_SUMMON_FETID_TROLL, 3s);
                    break;
                case EVENT_SUMMON_HULKING_CORPSE:
                    if (Creature* trigger = summons.GetCreatureWithEntry(NPC_CRYSTAL_CHANNEL_TARGET))
                        trigger->CastSpell(trigger, SPELL_SUMMON_HULKING_CORPSE, true, nullptr, nullptr, me->GetGUID());
                    events.ScheduleEvent(EVENT_SUMMON_HULKING_CORPSE, 30s);
                    break;
                case EVENT_SUMMON_SHADOWCASTER:
                    if (Creature* trigger = summons.GetCreatureWithEntry(NPC_CRYSTAL_CHANNEL_TARGET))
                        trigger->CastSpell(trigger, SPELL_SUMMON_RISEN_SHADOWCASTER, true, nullptr, nullptr, me->GetGUID());
                    events.ScheduleEvent(EVENT_SUMMON_SHADOWCASTER, 10s);
                    break;
                case EVENT_SUMMON_CRYSTAL_HANDLER:
                    if (_crystalCounter++ < 4)
                    {
                        Talk(SAY_SUMMONING_ADDS);
                        Talk(EMOTE_SUMMONING_ADDS);
                        if (Creature* target = ObjectAccessor::GetCreature(*me, _stage ? _summonTargetLeftGUID : _summonTargetRightGUID))
                            target->CastSpell(target, SPELL_SUMMON_CRYSTAL_HANDLER, true, nullptr, nullptr, me->GetGUID());
                        _stage = _stage ? 0 : 1;
                        events.ScheduleEvent(EVENT_SUMMON_CRYSTAL_HANDLER, 20s);
                    }
                    break;
                case EVENT_CHECK_PHASE:
                    if (me->HasAura(SPELL_BEAM_CHANNEL))
                    {
                        events.ScheduleEvent(EVENT_CHECK_PHASE, 2s);
                        break;
                    }
                    events.Reset();
                    events.ScheduleEvent(EVENT_CAST_OFFENSIVE_SPELL, 3s);
                    events.ScheduleEvent(EVENT_SPELL_SUMMON_MINIONS, 10s);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->InterruptNonMeleeSpells(false);
                    break;
                case EVENT_CAST_OFFENSIVE_SPELL:
                    if (!me->HasUnitState(UNIT_STATE_CASTING))
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                            me->CastSpell(target, RAND(SPELL_BLIZZARD, SPELL_FROSTBOLT, SPELL_TOUCH_OF_MISERY), false);

                    events.ScheduleEvent(EVENT_CAST_OFFENSIVE_SPELL, 500ms);
                    break;
                case EVENT_SPELL_SUMMON_MINIONS:
                    if (me->HasUnitState(UNIT_STATE_CASTING))
                    {
                        me->CastSpell(me, SPELL_SUMMON_MINIONS, false);
                        events.ScheduleEvent(EVENT_SPELL_SUMMON_MINIONS, 15s);
                        break;
                    }
                    events.ScheduleEvent(EVENT_SPELL_SUMMON_MINIONS, 500ms);
                    break;
            }
        }

        bool CheckEvadeIfOutOfCombatArea() const override
        {
            return !SelectTargetFromPlayerList(80.0f);
        }

    private:
        uint8 _crystalCounter;
        uint8 _stage;
        ObjectGuid _summonTargetRightGUID;
        ObjectGuid _summonTargetLeftGUID;

        bool _achievement;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetDraktharonKeepAI<boss_novosAI>(creature);
    }
};

class spell_novos_despawn_crystal_handler : public SpellScript
{
    PrepareSpellScript(spell_novos_despawn_crystal_handler);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BEAM_CHANNEL });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(GetCaster(), SPELL_BEAM_CHANNEL, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_novos_despawn_crystal_handler::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_novos_crystal_handler_death_aura : public AuraScript
{
    PrepareAuraScript(spell_novos_crystal_handler_death_aura);

    void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->InterruptNonMeleeSpells(false);
        if (GameObject* crystal = GetUnitOwner()->FindNearestGameObjectOfType(GAMEOBJECT_TYPE_DOOR, 5.0f))
            crystal->SetGoState(GO_STATE_READY);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_novos_crystal_handler_death_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_novos_summon_minions : public SpellScript
{
    PrepareSpellScript(spell_novos_summon_minions);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_COPY_OF_SUMMON_MINIONS });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        for (uint8 i = 0; i < 4; ++i)
            GetCaster()->CastSpell((Unit*)nullptr, SPELL_COPY_OF_SUMMON_MINIONS, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_novos_summon_minions::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class achievement_oh_novos : public AchievementCriteriaScript
{
public:
    achievement_oh_novos() : AchievementCriteriaScript("achievement_oh_novos") { }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetAI()->GetData(target->GetEntry());
    }
};

void AddSC_boss_novos()
{
    new boss_novos();
    RegisterSpellScript(spell_novos_despawn_crystal_handler);
    RegisterSpellScript(spell_novos_crystal_handler_death_aura);
    RegisterSpellScript(spell_novos_summon_minions);
    new achievement_oh_novos();
}
