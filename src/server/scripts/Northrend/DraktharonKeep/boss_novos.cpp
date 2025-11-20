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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "drak_tharon_keep.h"
#include "SpellScript.h"

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
    SPELL_WRATH_OF_MISERY               = 50089
};

enum Misc
{
    NPC_CRYSTAL_CHANNEL_TARGET              = 26712,
    NPC_CRYSTAL_HANDLER                     = 26627,
    NPC_SUMMON_CRYSTAL_HANDLER_TARGET       = 27583,

    EVENT_KILL_TALK                         = 1,

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

// 26631
struct boss_novos : public BossAI
{
    boss_novos(Creature* creature) : BossAI(creature, DATA_NOVOS) { }

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
        scheduler.ClearValidator();

        ScheduleTimedEvent(3s, [&] {
            if (Creature* trigger = summons.GetCreatureWithEntry(NPC_CRYSTAL_CHANNEL_TARGET))
                trigger->CastSpell(trigger, SPELL_SUMMON_FETID_TROLL_CORPSE, true, nullptr, nullptr, me->GetGUID());
        }, 3s);

        ScheduleTimedEvent(9s, [&] {
            if (Creature* trigger = summons.GetCreatureWithEntry(NPC_CRYSTAL_CHANNEL_TARGET))
                trigger->CastSpell(trigger, SPELL_SUMMON_RISEN_SHADOWCASTER, true, nullptr, nullptr, me->GetGUID());
        }, 10s);

        ScheduleTimedEvent(30s, [&] {
            if (Creature* trigger = summons.GetCreatureWithEntry(NPC_CRYSTAL_CHANNEL_TARGET))
                trigger->CastSpell(trigger, SPELL_SUMMON_HULKING_CORPSE, true, nullptr, nullptr, me->GetGUID());
        }, 30s);

        scheduler.Schedule(70s, [this](TaskContext context) {
            if (me->HasAura(SPELL_BEAM_CHANNEL))
            {
                context.Repeat(2s);
                return;
            }

            scheduler.CancelAll();

            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
            me->InterruptNonMeleeSpells(false);

            scheduler.SetValidator([this] {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });

            ScheduleTimedEvent(5s, 10s, [&] {
                DoCastRandomTarget(SPELL_BLIZZARD);
            }, 12s, 25s);

            ScheduleTimedEvent(5s, 10s, [&] {
                DoCastRandomTarget(SPELL_WRATH_OF_MISERY);
            }, 8s, 16s);

            if (IsHeroic())
            {
                ScheduleTimedEvent(10s, [&] {
                    DoCastAOE(SPELL_SUMMON_MINIONS);
                }, 37s, 55s);
            }
        });

        for (Seconds timer : { 16s, 32s, 48s, 64s })
        {
            me->m_Events.AddEventAtOffset([&] {
                Talk(SAY_SUMMONING_ADDS);
                Talk(EMOTE_SUMMONING_ADDS);
                if (Creature* target = ObjectAccessor::GetCreature(*me, _stage ? _summonTargetLeftGUID : _summonTargetRightGUID))
                    target->CastSpell(target, SPELL_SUMMON_CRYSTAL_HANDLER, true, nullptr, nullptr, me->GetGUID());
                _stage = _stage ? 0 : 1;
            }, timer);
        }

        me->SetGuidValue(UNIT_FIELD_TARGET, ObjectGuid::Empty);
        me->RemoveAllAuras();
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);

        DoCastSelf(SPELL_ARCANE_BLAST, true);
        DoCastSelf(SPELL_ARCANE_FIELD, true);
        DoCastSelf(SPELL_DESPAWN_CRYSTAL_HANDLER, true);

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
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
        instance->SetBossState(DATA_NOVOS_CRYSTALS, DONE);
    }

    void KilledUnit(Unit*  /*victim*/) override
    {
        if (!events.HasTimeUntilEvent(EVENT_KILL_TALK))
        {
            Talk(SAY_KILL);
            events.ScheduleEvent(EVENT_KILL_TALK, 6s);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);

        // Phase 1
        if (me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
        {
            if (summon->GetEntry() != NPC_CRYSTAL_CHANNEL_TARGET && summon->GetEntry() != NPC_CRYSTAL_HANDLER)
                summon->SetReactState(REACT_DEFENSIVE);

            if (summon->GetEntry() == NPC_FETID_TROLL_CORPSE)
                summon->GetMotionMaster()->MovePoint(1, -373.56f, -770.86f, 28.59f);

            if (summon->EntryEquals(NPC_CRYSTAL_HANDLER))
                summon->SetInCombatWithZone();
        }
        // Phase 2
        else if (summon->GetEntry() != NPC_CRYSTAL_CHANNEL_TARGET)
            summon->SetInCombatWithZone();
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        if (summon->GetEntry() == NPC_FETID_TROLL_CORPSE)
            summon->DespawnOrUnsummon(10s);
    }

    void SummonMovementInform(Creature* summon, uint32 movementType, uint32 pathId) override
    {
        if (movementType == POINT_MOTION_TYPE && pathId == 1)
        {
            if (summon->GetEntry() == NPC_FETID_TROLL_CORPSE)
            {
                DoZoneInCombat(summon);
                _achievement = false;
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        events.Update(diff);

        if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
            DoSpellAttackIfReady(SPELL_FROSTBOLT);
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

// 51403
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

// 47336
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

// 59910
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

// 2057
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
    RegisterCreatureAIWithFactory(boss_novos, GetDraktharonKeepAI);
    RegisterSpellScript(spell_novos_despawn_crystal_handler);
    RegisterSpellScript(spell_novos_crystal_handler_death_aura);
    RegisterSpellScript(spell_novos_summon_minions);
    new achievement_oh_novos();
}
