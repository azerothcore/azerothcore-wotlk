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

#include "CreatureGroups.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SharedDefines.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "pit_of_saron.h"

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_HP_66                       = 1,
    SAY_HP_33                       = 2,
    SAY_DEATH                       = 3,
    SAY_SLAY                        = 4,
    SAY_BOULDER_HIT                 = 5,
    WHISPER_BOULDER                 = 6,
    EMOTE_DEEP_FREEZE               = 7,
};

enum Equipment
{
    EQUIP_ID_SWORD                  = 49345,
    EQUIP_ID_MACE                   = 49344,
};

enum GameObjects
{
    GO_SARONITE_ROCK                = 196485,
};

Position const NorthForgePos = {722.5643f, -234.1615f, 527.182f, 2.16421f};
Position const SouthForgePos = {639.257f, -210.1198f, 529.015f, 0.523599f};

enum Spells
{
    SPELL_PERMAFROST                = 70326,
    SPELL_PERMAFROST_DEBUFF         = 70336,
    SPELL_THROW_SARONITE            = 68788,
    SPELL_THUNDERING_STOMP          = 68771,

    SPELL_CHILLING_WAVE             = 68778,
    SPELL_DEEP_FREEZE               = 70381,

    SPELL_FORGE_BLADE               = 68774,
    SPELL_FORGE_MACE                = 68785,
    SPELL_SARONITE_TRIGGERED        = 68789,
};

enum Events
{
    EVENT_SPELL_THROW_SARONITE  = 1,
    EVENT_JUMP,
    EVENT_SPELL_CHILLING_WAVE,
    EVENT_SPELL_DEEP_FREEZE,
};

enum Phases
{
    PHASE_ONE,
    PHASE_FORGE_BLADE,
    PHASE_FORGE_MACE,
};

enum MovePoints
{
    POINT_FORGE                     = 0,
};

class boss_garfrost : public CreatureScript
{
public:
    boss_garfrost() : CreatureScript("boss_garfrost") { }

    struct boss_garfrostAI : public ScriptedAI
    {
        boss_garfrostAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = creature->GetInstanceScript();
        }

        void Reset() override
        {
            me->RemoveAura(SPELL_PERMAFROST);
            SetEquipmentSlots(true);
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            _phase = PHASE_ONE;
            _canSayBoulderHit = true;

            events.Reset();
            _instance->SetData(DATA_GARFROST, NOT_STARTED);
        }

        void SetData(uint32 type, uint32 /*data*/) override
        {
            if (type == DATA_ACHIEV_ELEVEN)
                _instance->SetData(DATA_ACHIEV_ELEVEN, 0);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            DoCastSelf(SPELL_PERMAFROST, true);

            Talk(SAY_AGGRO);
            DoZoneInCombat();
            events.RescheduleEvent(EVENT_SPELL_THROW_SARONITE, 5s, 7500ms);

            _instance->SetData(DATA_GARFROST, IN_PROGRESS);
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            if (_phase == PHASE_ONE && !HealthAbovePct(66) && !me->HasUnitState(UNIT_STATE_ROOT))
            {
                _phase = PHASE_FORGE_BLADE;
                me->SetReactState(REACT_PASSIVE);
                me->SetTarget();
                me->SendMeleeAttackStop(me->GetVictim());
                events.DelayEvents(8s);
                me->CastSpell(me, SPELL_THUNDERING_STOMP, false);
                events.RescheduleEvent(EVENT_JUMP, 1250ms);
                return;
            }

            if (_phase == PHASE_FORGE_BLADE && !HealthAbovePct(33) && !me->HasUnitState(UNIT_STATE_ROOT))
            {
                events.CancelEvent(EVENT_SPELL_CHILLING_WAVE);
                _phase = PHASE_FORGE_MACE;
                me->SetReactState(REACT_PASSIVE);
                me->SetTarget();
                me->SendMeleeAttackStop(me->GetVictim());
                events.DelayEvents(8s);
                me->CastSpell(me, SPELL_THUNDERING_STOMP, false);
                events.RescheduleEvent(EVENT_JUMP, 1250ms);
                return;
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != EFFECT_MOTION_TYPE || id != POINT_FORGE)
                return;

            if (_phase == PHASE_FORGE_BLADE)
            {
                me->SetControlled(true, UNIT_STATE_ROOT);
                if (me->CastSpell(me, SPELL_FORGE_BLADE, false) == SPELL_CAST_OK)
                {
                    events.RescheduleEvent(EVENT_SPELL_CHILLING_WAVE, 10s);
                    SetEquipmentSlots(false, EQUIP_ID_SWORD);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    me->DisableRotate(false);
                    if (me->GetVictim())
                    {
                        AttackStart(me->GetVictim());
                        me->SetTarget(me->GetVictim()->GetGUID());
                    }
                }
                Talk(SAY_HP_66);
            }
            else if (_phase == PHASE_FORGE_MACE)
            {
                me->SetControlled(true, UNIT_STATE_ROOT);
                me->RemoveAurasDueToSpell(sSpellMgr->GetSpellIdForDifficulty(SPELL_FORGE_BLADE, me));
                if (me->CastSpell(me, SPELL_FORGE_MACE, false) == SPELL_CAST_OK)
                {
                    events.RescheduleEvent(EVENT_SPELL_DEEP_FREEZE, 10s);
                    SetEquipmentSlots(false, EQUIP_ID_MACE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    me->DisableRotate(false);
                    if (me->GetVictim())
                    {
                        AttackStart(me->GetVictim());
                        me->SetTarget(me->GetVictim()->GetGUID());
                    }
                }
                Talk(SAY_HP_33);
            }
        }

        void SpellHitTarget(Unit* /*target*/, SpellInfo const* spell) override
        {
            if (spell->Id == sSpellMgr->GetSpellIdForDifficulty(SPELL_SARONITE_TRIGGERED, me))
            {
                if (_canSayBoulderHit)
                {
                    _canSayBoulderHit = false;
                    Talk(SAY_BOULDER_HIT);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (me->GetVictim())
            {
                float x, y, z;
                me->GetVictim()->GetPosition(x, y, z);
                if (x < 600.0f || x > 770.0f || y < -270.0f || y > -137.0f || z < 514.0f || z > 550.0f)
                {
                    me->SetHealth(me->GetMaxHealth());
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    if (CreatureGroup* formation = me->GetFormation())
                    {
                        for (auto const& [member, formationInfo] : formation->GetMembers())
                            if (member->IsAlive() && member->IsInCombat() && !member->IsInEvadeMode() && member->IsAIEnabled)
                                member->AI()->EnterEvadeMode();
                    }
                    return;
                }
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_THROW_SARONITE:
                    _canSayBoulderHit = true;
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 140.0f, true))
                    {
                        Talk(WHISPER_BOULDER, target);
                        DoCast(target, SPELL_THROW_SARONITE);
                    }
                    events.Repeat(12s + 500ms, 20s);
                    break;
                case EVENT_JUMP:
                    me->DisableRotate(true);
                    if (_phase == PHASE_FORGE_BLADE)
                        me->GetMotionMaster()->MoveJump(NorthForgePos.GetPositionX(), NorthForgePos.GetPositionY(), NorthForgePos.GetPositionZ(), 25.0f, 15.0f, POINT_FORGE);
                    else if (_phase == PHASE_FORGE_MACE)
                        me->GetMotionMaster()->MoveJump(SouthForgePos.GetPositionX(), SouthForgePos.GetPositionY(), SouthForgePos.GetPositionZ(), 25.0f, 15.0f, POINT_FORGE);

                    break;
                case EVENT_SPELL_CHILLING_WAVE:
                    DoCastVictim(SPELL_CHILLING_WAVE);
                    events.Repeat(35s);
                    break;
                case EVENT_SPELL_DEEP_FREEZE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                    {
                        Talk(EMOTE_DEEP_FREEZE, target);
                        DoCast(target, SPELL_DEEP_FREEZE);
                    }
                    events.Repeat(35s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            _instance->SetData(DATA_GARFROST, DONE);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                Talk(SAY_SLAY);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            ScriptedAI::EnterEvadeMode(why);
        }

    private:
        InstanceScript* _instance;
        uint8 _phase;
        bool _canSayBoulderHit;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<boss_garfrostAI>(creature);
    }
};

class spell_garfrost_permafrost : public SpellScript
{
    PrepareSpellScript(spell_garfrost_permafrost);

    void Unload() override
    {
        _targetList.clear();
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (Unit* caster = GetCaster())
        {
            std::list<GameObject*> blockList;
            caster->GetGameObjectListWithEntryInGrid(blockList, GO_SARONITE_ROCK, 100.0f);

            if (!blockList.empty())
            {
                for (WorldObject* target : targets)
                {
                    if (!target)
                        continue;

                    bool valid = true;
                    if (!caster->IsWithinMeleeRange(target->ToUnit()))
                        for (GameObject* block : blockList)
                            if (!block->IsInvisibleDueToDespawn() && block->IsInBetween(caster, target, 4.0f))
                            {
                                valid = false;
                                break;
                            }

                    if (valid)
                    {
                        if (Aura* aura = target->ToUnit()->GetAura(SPELL_PERMAFROST_DEBUFF))
                            if (aura->GetStackAmount() >= 10 && caster->IsCreature())
                                caster->ToCreature()->AI()->SetData(DATA_ACHIEV_ELEVEN, aura->GetStackAmount());
                        _targetList.push_back(target);
                    }
                }
            }
            else
            {
                _targetList = targets;
                return;
            }
        }

        targets = _targetList;
    }

    void FilterTargetsNext(std::list<WorldObject*>& targets)
    {
        targets = _targetList;
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_garfrost_permafrost::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_garfrost_permafrost::FilterTargetsNext, EFFECT_1, TARGET_UNIT_DEST_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_garfrost_permafrost::FilterTargetsNext, EFFECT_2, TARGET_UNIT_DEST_AREA_ENEMY);
    }

private:
    std::list<WorldObject*> _targetList;
};

void AddSC_boss_garfrost()
{
    new boss_garfrost();

    RegisterSpellScript(spell_garfrost_permafrost);
}
