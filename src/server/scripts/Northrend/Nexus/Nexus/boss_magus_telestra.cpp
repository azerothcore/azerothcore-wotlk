/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "nexus.h"

enum Spells
{
    // Main
    SPELL_ICE_NOVA                  = 47772,
    SPELL_FIREBOMB                  = 47773,
    
    SPELL_GRAVITY_WELL              = 47756,
    SPELL_TELESTRA_BACK             = 47714,
    SPELL_BURNING_WINDS             = 46308,
    SPELL_START_SUMMON_CLONES       = 47710,

    SPELL_FIRE_MAGUS_SUMMON         = 47707,
    SPELL_FROST_MAGUS_SUMMON        = 47709,
    SPELL_ARCANE_MAGUS_SUMMON       = 47708,

    SPELL_FIRE_MAGUS_DEATH          = 47711,
    SPELL_ARCANE_MAGUS_DEATH        = 47713,

    SPELL_WEAR_CHRISTMAS_HAT        = 61400
};

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_KILL                        = 1,
    SAY_DEATH                       = 2,
    SAY_MERGE                       = 3,
    SAY_SPLIT                       = 4
};

enum Misc
{
    NPC_FIRE_MAGUS                  = 26928,
    NPC_FROST_MAGUS                 = 26930,
    NPC_ARCANE_MAGUS                = 26929,

    ACHIEVEMENT_SPLIT_PERSONALITY   = 2150,

    GAME_EVENT_WINTER_VEIL          = 2,
};

enum Events
{
    EVENT_MAGUS_ICE_NOVA            = 1,
    EVENT_MAGUS_FIREBOMB            = 2,
    EVENT_MAGUS_GRAVITY_WELL        = 3,
    EVENT_MAGUS_HEALTH1             = 4,
    EVENT_MAGUS_HEALTH2             = 5,
    EVENT_MAGUS_FAIL_ACHIEVEMENT    = 6,
    EVENT_MAGUS_MERGED              = 7,
    EVENT_MAGUS_RELOCATE            = 8,
    EVENT_KILL_TALK                 = 9
};

class boss_magus_telestra : public CreatureScript
{
    public:
        boss_magus_telestra() : CreatureScript("boss_magus_telestra") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_magus_telestraAI>(creature);
        }

        struct boss_magus_telestraAI : public BossAI
        {
            boss_magus_telestraAI(Creature* creature) : BossAI(creature, DATA_MAGUS_TELESTRA_EVENT)
            {
            }

            uint8 copiesDied;
            bool achievement;

            void Reset()
            {
                BossAI::Reset();
                copiesDied = 0;
                achievement = true;

                if (IsHeroic() && sGameEventMgr->IsActiveEvent(GAME_EVENT_WINTER_VEIL) && !me->HasAura(SPELL_WEAR_CHRISTMAS_HAT))
                    me->AddAura(SPELL_WEAR_CHRISTMAS_HAT, me);
            }

            uint32 GetData(uint32 data) const
            {
                if (data == me->GetEntry())
                    return achievement;
                return 0;
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                Talk(SAY_AGGRO);

                events.ScheduleEvent(EVENT_MAGUS_ICE_NOVA, 10000);
                events.ScheduleEvent(EVENT_MAGUS_FIREBOMB, 0);
                events.ScheduleEvent(EVENT_MAGUS_GRAVITY_WELL, 20000);
                events.ScheduleEvent(EVENT_MAGUS_HEALTH1, 1000);
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_MAGUS_HEALTH2, 1000);
            }

            void AttackStart(Unit* who)
            {
                if (who && me->Attack(who, true))
                    me->GetMotionMaster()->MoveChase(who, 20.0f);
            }

            void JustDied(Unit* killer)
            {
                BossAI::JustDied(killer);
                Talk(SAY_DEATH);
            }

            void KilledUnit(Unit*)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_KILL);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                summon->SetInCombatWithZone();
            }

            void SpellHit(Unit* caster, const SpellInfo* spellInfo)
            {
                if (spellInfo->Id >= SPELL_FIRE_MAGUS_DEATH && spellInfo->Id <= SPELL_ARCANE_MAGUS_DEATH && caster->ToCreature())
                {
                    events.ScheduleEvent(EVENT_MAGUS_FAIL_ACHIEVEMENT, 5000);
                    caster->ToCreature()->DespawnOrUnsummon(1000);

                    if (++copiesDied >= 3)
                    {
                        copiesDied = 0;
                        events.CancelEvent(EVENT_MAGUS_FAIL_ACHIEVEMENT);
                        events.ScheduleEvent(EVENT_MAGUS_MERGED, 5000);
                        me->CastSpell(me, SPELL_BURNING_WINDS, true);
                    }
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_MAGUS_HEALTH1:
                        if (me->HealthBelowPct(51))
                        {
                            me->CastSpell(me, SPELL_START_SUMMON_CLONES, false);
                            events.ScheduleEvent(EVENT_MAGUS_RELOCATE, 3500);
                            Talk(SAY_SPLIT);
                            break;
                        }
                        events.ScheduleEvent(EVENT_MAGUS_HEALTH1, 1000);
                        break;
                    case EVENT_MAGUS_HEALTH2:
                        if (me->HealthBelowPct(11))
                        {
                            me->CastSpell(me, SPELL_START_SUMMON_CLONES, false);
                            events.ScheduleEvent(EVENT_MAGUS_RELOCATE, 3500);
                            Talk(SAY_SPLIT);
                            break;
                        }
                        events.ScheduleEvent(EVENT_MAGUS_HEALTH2, 1000);
                        break;
                    case EVENT_MAGUS_FIREBOMB:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, SPELL_FIREBOMB, false);
                        events.ScheduleEvent(EVENT_MAGUS_FIREBOMB, 3000);
                        break;
                    case EVENT_MAGUS_ICE_NOVA:
                        me->CastSpell(me, SPELL_ICE_NOVA, false);
                        events.ScheduleEvent(EVENT_MAGUS_ICE_NOVA, 15000);
                        break;
                    case EVENT_MAGUS_GRAVITY_WELL:
                        me->CastSpell(me, SPELL_GRAVITY_WELL, false);
                        events.ScheduleEvent(EVENT_MAGUS_GRAVITY_WELL, 15000);
                        break;
                    case EVENT_MAGUS_FAIL_ACHIEVEMENT:
                        achievement = false;
                        break;
                    case EVENT_MAGUS_RELOCATE:
                        me->NearTeleportTo(505.04f, 88.915f, -16.13f, 2.98f);
                        break;
                    case EVENT_MAGUS_MERGED:
                        me->CastSpell(me, SPELL_TELESTRA_BACK, true);
                        me->RemoveAllAuras();
                        Talk(SAY_MERGE);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class spell_boss_magus_telestra_summon_telestra_clones : public SpellScriptLoader
{
    public:
        spell_boss_magus_telestra_summon_telestra_clones() : SpellScriptLoader("spell_boss_magus_telestra_summon_telestra_clones") { }

        class spell_boss_magus_telestra_summon_telestra_clones_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_boss_magus_telestra_summon_telestra_clones_AuraScript);

            bool Load()
            {
                return GetUnitOwner()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_FIRE_MAGUS_SUMMON, true);
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_FROST_MAGUS_SUMMON, true);
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_ARCANE_MAGUS_SUMMON, true);

                GetUnitOwner()->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                GetUnitOwner()->SetControlled(true, UNIT_STATE_STUNNED);
                GetUnitOwner()->ToCreature()->LoadEquipment(0, true);

            }

            void HandleRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                GetUnitOwner()->SetControlled(false, UNIT_STATE_STUNNED);
                GetUnitOwner()->ToCreature()->LoadEquipment(1, true);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_boss_magus_telestra_summon_telestra_clones_AuraScript::HandleApply, EFFECT_1, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_boss_magus_telestra_summon_telestra_clones_AuraScript::HandleRemove, EFFECT_1, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_boss_magus_telestra_summon_telestra_clones_AuraScript();
        }
};

class spell_boss_magus_telestra_gravity_well : public SpellScriptLoader
{
    public:
        spell_boss_magus_telestra_gravity_well() : SpellScriptLoader("spell_boss_magus_telestra_gravity_well") { }

        class spell_boss_magus_telestra_gravity_well_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_boss_magus_telestra_gravity_well_SpellScript);

            void SelectTarget(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::RandomCheck(50));
            }

            void HandlePull(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                Unit* target = GetHitUnit();
                if (!target)
                    return;

                Position pos;
                if (target->GetDistance(GetCaster()) < 5.0f)
                {
                    pos.Relocate(GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), GetCaster()->GetPositionZ()+1.0f);
                    float o = frand(0, 2*M_PI);
                    target->MovePositionToFirstCollision(pos, 20.0f, o);
                    pos.m_positionZ += frand(5.0f, 15.0f);
                }
                else
                    pos.Relocate(GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), GetCaster()->GetPositionZ()+1.0f);

                float speedXY = float(GetSpellInfo()->Effects[effIndex].MiscValue) * 0.1f;
                float speedZ = target->GetDistance(pos) / speedXY * 0.5f * Movement::gravity;

                target->GetMotionMaster()->MoveJump(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), speedXY, speedZ);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_boss_magus_telestra_gravity_well_SpellScript::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnEffectHitTarget += SpellEffectFn(spell_boss_magus_telestra_gravity_well_SpellScript::HandlePull, EFFECT_0, SPELL_EFFECT_PULL_TOWARDS_DEST);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_boss_magus_telestra_gravity_well_SpellScript();
        }
};

class achievement_split_personality : public AchievementCriteriaScript
{
    public:
        achievement_split_personality() : AchievementCriteriaScript("achievement_split_personality")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            return target->GetAI()->GetData(target->GetEntry());
        }
};

void AddSC_boss_magus_telestra()
{
    new boss_magus_telestra();
    new spell_boss_magus_telestra_summon_telestra_clones();
    new spell_boss_magus_telestra_gravity_well();
    new achievement_split_personality();
}
