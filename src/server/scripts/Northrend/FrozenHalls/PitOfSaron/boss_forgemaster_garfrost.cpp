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

#include "CreatureGroups.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
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

enum MiscData
{
    EQUIP_ID_SWORD                  = 49345,
    EQUIP_ID_MACE                   = 49344,
    GO_SARONITE_ROCK                = 196485,
};

Position const northForgePos = {722.5643f, -234.1615f, 527.182f, 2.16421f};
Position const southForgePos = {639.257f, -210.1198f, 529.015f, 0.523599f};

enum Spells
{
    SPELL_PERMAFROST                = 70326,
    SPELL_THROW_SARONITE            = 68788,
    SPELL_THUNDERING_STOMP          = 68771,

    SPELL_CHILLING_WAVE             = 68778,
    SPELL_DEEP_FREEZE               = 70381,
};

#define SPELL_FORGE_BLADE           RAID_MODE(68774, 70334)
#define SPELL_FORGE_MACE            RAID_MODE(68785, 70335)
#define SPELL_SARONITE_TRIGGERED    RAID_MODE(68789, 70851)

enum Events
{
    EVENT_SPELL_THROW_SARONITE  = 1,
    EVENT_JUMP,
    EVENT_SPELL_CHILLING_WAVE,
    EVENT_SPELL_DEEP_FREEZE,
};

class boss_garfrost : public CreatureScript
{
public:
    boss_garfrost() : CreatureScript("boss_garfrost") { }

    struct boss_garfrostAI : public ScriptedAI
    {
        boss_garfrostAI(Creature* creature) : ScriptedAI(creature)
        {
            pInstance = creature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        uint8 phase;
        bool bCanSayBoulderHit;

        void Reset() override
        {
            me->RemoveAura(SPELL_PERMAFROST);
            SetEquipmentSlots(true);
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            phase = 0;
            bCanSayBoulderHit = true;

            events.Reset();
            if (pInstance)
                pInstance->SetData(DATA_GARFROST, NOT_STARTED);
        }

        void SetData(uint32 id, uint32  /*data*/) override
        {
            if (id == 1 && pInstance)
                pInstance->SetData(DATA_ACHIEV_ELEVEN, 0);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->CastSpell(me, SPELL_PERMAFROST, true);

            Talk(SAY_AGGRO);
            DoZoneInCombat();
            events.RescheduleEvent(EVENT_SPELL_THROW_SARONITE, 5000ms, 7500ms);

            if (pInstance)
                pInstance->SetData(DATA_GARFROST, IN_PROGRESS);
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            if (phase == 0 && !HealthAbovePct(66) && !me->HasUnitState(UNIT_STATE_ROOT))
            {
                phase = 1;
                me->SetReactState(REACT_PASSIVE);
                me->SetTarget();
                me->SendMeleeAttackStop(me->GetVictim());
                events.DelayEvents(8s);
                me->CastSpell(me, SPELL_THUNDERING_STOMP, false);
                events.RescheduleEvent(EVENT_JUMP, 1250ms);
                return;
            }

            if (phase == 1 && !HealthAbovePct(33) && !me->HasUnitState(UNIT_STATE_ROOT))
            {
                events.CancelEvent(EVENT_SPELL_CHILLING_WAVE);
                phase = 2;
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
            if (type != EFFECT_MOTION_TYPE || id != 0)
                return;

            if (phase == 1)
            {
                me->SetControlled(true, UNIT_STATE_ROOT);
                me->CastSpell(me, SPELL_FORGE_BLADE, false);
                Talk(SAY_HP_66);
            }
            else if (phase == 2)
            {
                me->SetControlled(true, UNIT_STATE_ROOT);
                me->RemoveAurasDueToSpell(SPELL_FORGE_BLADE);
                me->CastSpell(me, SPELL_FORGE_MACE, false);
                Talk(SAY_HP_33);
            }
        }

        void SpellHitTarget(Unit*  /*target*/, SpellInfo const* spell) override
        {
            if (spell->Id == uint32(SPELL_SARONITE_TRIGGERED))
            {
                if (bCanSayBoulderHit)
                {
                    bCanSayBoulderHit = false;
                    Talk(SAY_BOULDER_HIT);
                }
            }
            if (spell->Id == uint32(SPELL_FORGE_BLADE))
            {
                events.RescheduleEvent(EVENT_SPELL_CHILLING_WAVE, 10000);
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
            else if (spell->Id == uint32(SPELL_FORGE_MACE))
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
                    if (CreatureGroup* f = me->GetFormation())
                    {
                        const CreatureGroup::CreatureGroupMemberType& m = f->GetMembers();
                        for (CreatureGroup::CreatureGroupMemberType::const_iterator itr = m.begin(); itr != m.end(); ++itr)
                            if (itr->first->IsAlive() && itr->first->IsInCombat() && !itr->first->IsInEvadeMode() && itr->first->IsAIEnabled)
                                itr->first->AI()->EnterEvadeMode();
                    }
                    return;
                }
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_THROW_SARONITE:
                    bCanSayBoulderHit = true;
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 140.0f, true))
                    {
                        Talk(WHISPER_BOULDER, target);
                        me->CastSpell(target, SPELL_THROW_SARONITE, false);
                    }
                    events.Repeat(12s + 500ms, 20s);
                    break;
                case EVENT_JUMP:
                    me->DisableRotate(true);
                    if (phase == 1)
                        me->GetMotionMaster()->MoveJump(northForgePos.GetPositionX(), northForgePos.GetPositionY(), northForgePos.GetPositionZ(), 25.0f, 15.0f, 0);
                    else if (phase == 2)
                        me->GetMotionMaster()->MoveJump(southForgePos.GetPositionX(), southForgePos.GetPositionY(), southForgePos.GetPositionZ(), 25.0f, 15.0f, 0);

                    break;
                case EVENT_SPELL_CHILLING_WAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CHILLING_WAVE, false);
                    events.Repeat(35s);
                    break;
                case EVENT_SPELL_DEEP_FREEZE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                    {
                        Talk(EMOTE_DEEP_FREEZE, target);
                        me->CastSpell(target, SPELL_DEEP_FREEZE, false);
                    }
                    events.Repeat(35s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_GARFROST, DONE);
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
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<boss_garfrostAI>(creature);
    }
};

class spell_garfrost_permafrost : public SpellScript
{
    PrepareSpellScript(spell_garfrost_permafrost);

    std::list<WorldObject*> targetList;

    void Unload() override
    {
        targetList.clear();
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (Unit* caster = GetCaster())
        {
            std::list<GameObject*> blockList;
            caster->GetGameObjectListWithEntryInGrid(blockList, GO_SARONITE_ROCK, 100.0f);

            if (!blockList.empty())
            {
                for (std::list<WorldObject*>::iterator itrU = targets.begin(); itrU != targets.end(); ++itrU)
                    if (WorldObject* target = (*itrU))
                    {
                        bool valid = true;
                        if (!caster->IsWithinMeleeRange(target->ToUnit()))
                            for (std::list<GameObject*>::const_iterator itr = blockList.begin(); itr != blockList.end(); ++itr)
                                if (!(*itr)->IsInvisibleDueToDespawn())
                                    if ((*itr)->IsInBetween(caster, target, 4.0f))
                                    {
                                        valid = false;
                                        break;
                                    }
                        if (valid)
                        {
                            if (Aura* aur = target->ToUnit()->GetAura(70336))
                                if (aur->GetStackAmount() >= 10 && caster->IsCreature())
                                    caster->ToCreature()->AI()->SetData(1, aur->GetStackAmount());
                            targetList.push_back(*itrU);
                        }
                    }
            }
            else
            {
                targetList = targets;
                return;
            }
        }

        targets = targetList;
    }

    void FilterTargetsNext(std::list<WorldObject*>& targets)
    {
        targets = targetList;
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_garfrost_permafrost::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_garfrost_permafrost::FilterTargetsNext, EFFECT_1, TARGET_UNIT_DEST_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_garfrost_permafrost::FilterTargetsNext, EFFECT_2, TARGET_UNIT_DEST_AREA_ENEMY);
    }
};

void AddSC_boss_garfrost()
{
    new boss_garfrost();

    RegisterSpellScript(spell_garfrost_permafrost);
}
