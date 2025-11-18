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
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "SharedDefines.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "icecrown_citadel.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"

enum ScriptTexts
{
    SAY_STINKY_DEAD             = 0,
    SAY_AGGRO                   = 1,
    EMOTE_GAS_SPORE             = 2,
    EMOTE_WARN_GAS_SPORE        = 3,
    SAY_PUNGENT_BLIGHT          = 4,
    EMOTE_WARN_PUNGENT_BLIGHT   = 5,
    EMOTE_PUNGENT_BLIGHT        = 6,
    SAY_KILL                    = 7,
    SAY_BERSERK                 = 8,
    SAY_DEATH                   = 9,
};

enum Spells
{
    // Festergut
    SPELL_INHALE_BLIGHT         = 69165,
    SPELL_PUNGENT_BLIGHT        = 69195,
    SPELL_GASTRIC_BLOAT         = 72219, // 72214 is the proper way (with proc) but atm procs can't have cooldown for creatures
    SPELL_GASTRIC_EXPLOSION     = 72227,
    SPELL_GAS_SPORE             = 69278,
    SPELL_VILE_GAS              = 69240,
    SPELL_INOCULATED            = 69291,
    SPELL_MALLABLE_GOO_H        = 72296,

    // Stinky
    SPELL_MORTAL_WOUND          = 71127,
    SPELL_DECIMATE              = 71123,
    SPELL_PLAGUE_STENCH         = 71805,
};

uint32 const gaseousBlight[3]        = {69157, 69162, 69164};
uint32 const gaseousBlightVisual[3]  = {69126, 69152, 69154};

#define DATA_INOCULATED_STACK 69291

enum Events
{
    // Festergut
    EVENT_NONE,
    EVENT_BERSERK,
    EVENT_INHALE_BLIGHT,
    EVENT_VILE_GAS,
    EVENT_GAS_SPORE,
    EVENT_GASTRIC_BLOAT,
    EVENT_FESTERGUT_GOO,

    // Stinky
    EVENT_DECIMATE,
    EVENT_MORTAL_WOUND,
};

class boss_festergut : public CreatureScript
{
public:
    boss_festergut() : CreatureScript("boss_festergut") { }

    struct boss_festergutAI : public BossAI
    {
        boss_festergutAI(Creature* creature) : BossAI(creature, DATA_FESTERGUT)
        {
            _gasDummyGUID.Clear();
        }

        ObjectGuid _gasDummyGUID;
        uint32 _maxInoculatedStack;
        uint32 _inhaleCounter;

        void Reset() override
        {
            _maxInoculatedStack = 0;
            _inhaleCounter = 0;
            _Reset();
            events.Reset();
            if (Creature* gasDummy = me->FindNearestCreature(NPC_GAS_DUMMY, 100.0f, true))
            {
                _gasDummyGUID = gasDummy->GetGUID();
                for (uint8 i = 0; i < 3; ++i)
                    gasDummy->RemoveAurasDueToSpell(gaseousBlightVisual[i]);
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            if (!instance->CheckRequiredBosses(DATA_FESTERGUT, who->ToPlayer()))
            {
                EnterEvadeMode(EVADE_REASON_OTHER);
                instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                return;
            }

            events.ScheduleEvent(EVENT_BERSERK, 5min);
            events.ScheduleEvent(EVENT_INHALE_BLIGHT, 25s, 30s);
            events.ScheduleEvent(EVENT_GAS_SPORE, 20s, 25s);
            events.ScheduleEvent(EVENT_VILE_GAS, 30s, 40s, 1);
            events.ScheduleEvent(EVENT_GASTRIC_BLOAT, 12s + 500ms, 15s);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_FESTERGUT_GOO, 15s, 20s);

            me->setActive(true);
            Talk(SAY_AGGRO);
            DoZoneInCombat();

            if (Creature* gasDummy = me->FindNearestCreature(NPC_GAS_DUMMY, 100.0f, true))
                _gasDummyGUID = gasDummy->GetGUID();
            if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_PROFESSOR_PUTRICIDE)))
                professor->AI()->DoAction(ACTION_FESTERGUT_COMBAT);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);
            if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_PROFESSOR_PUTRICIDE)))
                professor->AI()->DoAction(ACTION_FESTERGUT_DEATH);

            RemoveBlight();
        }

        void JustReachedHome() override
        {
            _JustReachedHome();
            instance->SetBossState(DATA_FESTERGUT, FAIL);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            ScriptedAI::EnterEvadeMode(why);
            if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_PROFESSOR_PUTRICIDE)))
                professor->AI()->EnterEvadeMode(why);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer())
                Talk(SAY_KILL);
        }

        void RemoveBlight()
        {
            if (Creature* gasDummy = ObjectAccessor::GetCreature(*me, _gasDummyGUID))
                for (uint8 i = 0; i < 3; ++i)
                {
                    me->RemoveAurasDueToSpell(gaseousBlight[i]);
                    gasDummy->RemoveAurasDueToSpell(gaseousBlightVisual[i]);
                }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK2, true);
                    Talk(SAY_BERSERK);
                    break;
                case EVENT_INHALE_BLIGHT:
                    RemoveBlight();
                    if (_inhaleCounter == 3)
                    {
                        Talk(EMOTE_WARN_PUNGENT_BLIGHT);
                        Talk(SAY_PUNGENT_BLIGHT);
                        me->CastSpell(me, SPELL_PUNGENT_BLIGHT, false);
                        _inhaleCounter = 0;
                        events.RescheduleEvent(EVENT_GAS_SPORE, 20s, 25s);
                    }
                    else
                    {
                        me->CastSpell(me, SPELL_INHALE_BLIGHT, false);
                        // just cast and dont bother with target, conditions will handle it
                        ++_inhaleCounter;
                        if (_inhaleCounter < 3)
                            me->CastSpell(me, gaseousBlight[_inhaleCounter], true, nullptr, nullptr, me->GetGUID());
                    }

                    events.ScheduleEvent(EVENT_INHALE_BLIGHT, 34s);
                    break;
                case EVENT_GAS_SPORE:
                    Talk(EMOTE_WARN_GAS_SPORE);
                    Talk(EMOTE_GAS_SPORE);
                    me->CastCustomSpell(SPELL_GAS_SPORE, SPELLVALUE_MAX_TARGETS, RAID_MODE<int32>(2, 3, 2, 3), me);
                    events.ScheduleEvent(EVENT_GAS_SPORE, 40s, 45s);
                    events.DelayEventsToMax(20s, 1); // delay EVENT_VILE_GAS
                    break;
                case EVENT_VILE_GAS:
                    {
                        std::list<Unit*> targets;
                        uint32 minTargets = RAID_MODE<uint32>(3, 8, 3, 8);
                        SelectTargetList(targets, minTargets, SelectTargetMethod::Random, 0, -5.0f, true);
                        float minDist = 0.0f;
                        if (targets.size() >= minTargets)
                            minDist = -5.0f;

                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, minDist, true))
                            me->CastSpell(target, SPELL_VILE_GAS, false);
                        events.ScheduleEvent(EVENT_VILE_GAS, 28s, 35s, 1);
                        break;
                    }
                case EVENT_GASTRIC_BLOAT:
                    me->CastSpell(me->GetVictim(), SPELL_GASTRIC_BLOAT, false);
                    events.ScheduleEvent(EVENT_GASTRIC_BLOAT, 15s, 17s + 500ms);
                    break;
                case EVENT_FESTERGUT_GOO:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, NonTankTargetSelector(me)))
                        if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_PROFESSOR_PUTRICIDE)))
                            professor->CastSpell(target, SPELL_MALLABLE_GOO_H, true);
                    events.ScheduleEvent(EVENT_FESTERGUT_GOO, 15s, 20s);
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == DATA_INOCULATED_STACK && data > _maxInoculatedStack)
                _maxInoculatedStack = data;
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_INOCULATED_STACK)
                return _maxInoculatedStack;

            return 0;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<boss_festergutAI>(creature);
    }
};

class spell_festergut_pungent_blight : public SpellScript
{
    PrepareSpellScript(spell_festergut_pungent_blight);

    bool Load() override
    {
        return GetCaster()->IsCreature();
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster->IsCreature())
            return;

        // Get Inhaled Blight id for our difficulty
        uint32 blightId = sSpellMgr->GetSpellIdForDifficulty(uint32(GetEffectValue()), caster);

        // ...and remove it
        caster->RemoveAurasDueToSpell(blightId);
        caster->ToCreature()->AI()->Talk(EMOTE_PUNGENT_BLIGHT);

        if (InstanceScript* inst = caster->GetInstanceScript())
            if (Creature* professor = ObjectAccessor::GetCreature(*caster, inst->GetGuidData(DATA_PROFESSOR_PUTRICIDE)))
                professor->AI()->DoAction(ACTION_FESTERGUT_GAS);
    }

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->RemoveAurasDueToSpell(sSpellMgr->GetSpellIdForDifficulty(SPELL_INOCULATED, GetCaster()));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_festergut_pungent_blight::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        OnEffectHitTarget += SpellEffectFn(spell_festergut_pungent_blight::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_festergut_blighted_spores_aura : public AuraScript
{
    PrepareAuraScript(spell_festergut_blighted_spores_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_INOCULATED });
    }

    void ExtraEffect(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (Aura* a = aurEff->GetBase())
            if (a->GetDuration() > a->GetMaxDuration() - 1000) // this does not stack for different casters and previous is removed by new DoT, prevent it from giving inoculation in such case
                return;
        uint32 inoculatedId = sSpellMgr->GetSpellIdForDifficulty(SPELL_INOCULATED, GetTarget());
        uint8 inoculatedStack = 1;
        if (Aura* a = GetTarget()->GetAura(inoculatedId))
        {
            inoculatedStack += a->GetStackAmount();
            if (a->GetDuration() > a->GetMaxDuration() - 10000) // player may gain only one stack at a time, no matter how many spores explode near him
                return;
        }
        GetTarget()->CastSpell(GetTarget(), SPELL_INOCULATED, true);
        if (InstanceScript* instance = GetTarget()->GetInstanceScript())
            if (Creature* festergut = ObjectAccessor::GetCreature(*GetTarget(), instance->GetGuidData(DATA_FESTERGUT)))
                festergut->AI()->SetData(DATA_INOCULATED_STACK, inoculatedStack);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_festergut_blighted_spores_aura::ExtraEffect, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_festergut_gastric_bloat : public SpellScript
{
    PrepareSpellScript(spell_festergut_gastric_bloat);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_GASTRIC_EXPLOSION });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Aura const* aura = GetHitUnit()->GetAura(GetSpellInfo()->Id);
        if (!(aura && aura->GetStackAmount() == 10))
            return;

        GetHitUnit()->RemoveAurasDueToSpell(GetSpellInfo()->Id);
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_GASTRIC_EXPLOSION, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_festergut_gastric_bloat::HandleScript, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_festergut_gaseous_blight : public SpellScript
{
    PrepareSpellScript(spell_festergut_gaseous_blight);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_ORANGE_BLIGHT_RESIDUE });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* p = GetHitUnit()->ToPlayer())
        {
            if (Map* map = GetCaster()->GetMap())
            {
                uint32 questId = map->Is25ManRaid() ? QUEST_RESIDUE_RENDEZVOUS_25 : QUEST_RESIDUE_RENDEZVOUS_10;
                if (p->GetQuestStatus(questId) == QUEST_STATUS_INCOMPLETE)
                    p->CastSpell(p, SPELL_ORANGE_BLIGHT_RESIDUE, true);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_festergut_gaseous_blight::HandleScript, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class achievement_flu_shot_shortage : public AchievementCriteriaScript
{
public:
    achievement_flu_shot_shortage() : AchievementCriteriaScript("achievement_flu_shot_shortage") { }

    bool OnCheck(Player* /*source*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (target && target->IsCreature())
            return target->ToCreature()->AI()->GetData(DATA_INOCULATED_STACK) < 3;

        return false;
    }
};

class npc_stinky_icc : public CreatureScript
{
public:
    npc_stinky_icc() : CreatureScript("npc_stinky_icc") { }

    struct npc_stinky_iccAI : public ScriptedAI
    {
        npc_stinky_iccAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit* /*target*/) override
        {
            me->setActive(true);
            me->CastSpell(me, SPELL_PLAGUE_STENCH, true);
            events.ScheduleEvent(EVENT_DECIMATE, 20s, 25s);
            events.ScheduleEvent(EVENT_MORTAL_WOUND, 1500ms, 2500ms);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_DECIMATE:
                        me->CastSpell(me->GetVictim(), SPELL_DECIMATE, false);
                        events.ScheduleEvent(EVENT_DECIMATE, 20s, 25s);
                        break;
                    case EVENT_MORTAL_WOUND:
                        me->CastSpell(me->GetVictim(), SPELL_MORTAL_WOUND, false);
                        events.ScheduleEvent(EVENT_MORTAL_WOUND, 1500ms, 2500ms);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (InstanceScript* _instance = me->GetInstanceScript())
                if (Creature* festergut = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_FESTERGUT)))
                    if (festergut->IsAlive())
                        festergut->AI()->Talk(SAY_STINKY_DEAD);
        }

    private:
        EventMap events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_stinky_iccAI>(creature);
    }
};

void AddSC_boss_festergut()
{
    new boss_festergut();
    RegisterSpellScript(spell_festergut_pungent_blight);
    RegisterSpellScript(spell_festergut_blighted_spores_aura);
    RegisterSpellScript(spell_festergut_gastric_bloat);
    RegisterSpellScript(spell_festergut_gaseous_blight);
    new achievement_flu_shot_shortage();

    new npc_stinky_icc();
}
