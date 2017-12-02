/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "pit_of_saron.h"
#include "SpellScript.h"
#include "SpellAuras.h"
#include "Player.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "CreatureGroups.h"

enum Yells
{
    SAY_AGGRO                       = 14,
    SAY_SLAY_1                      = 15,
    SAY_DEATH                       = 17,
    SAY_FORGE_1                     = 18,
    SAY_FORGE_2                     = 19,

    SAY_BOULDER_HIT                 = 16,
    EMOTE_DEEP_FREEZE               = 23,
};

#define EMOTE_THROW_SARONITE        "%s hurls a massive saronite boulder at you!"

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

        void Reset()
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

        void SetData(uint32 id, uint32  /*data*/)
        {
            if (id == 1 && pInstance)
                pInstance->SetData(DATA_ACHIEV_ELEVEN, 0);
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->CastSpell(me, SPELL_PERMAFROST, true);

            Talk(SAY_AGGRO);
            DoZoneInCombat();
            events.RescheduleEvent(EVENT_SPELL_THROW_SARONITE, urand(5000,7500));

            if (pInstance)
                pInstance->SetData(DATA_GARFROST, IN_PROGRESS);
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/)
        {
            if (phase == 0 && !HealthAbovePct(66) && !me->HasUnitState(UNIT_STATE_ROOT))
            {
                phase = 1;
                me->SetReactState(REACT_PASSIVE);
                me->SetTarget(0);
                me->SendMeleeAttackStop(me->GetVictim());
                events.DelayEvents(8000);
                me->CastSpell(me, SPELL_THUNDERING_STOMP, false);
                events.RescheduleEvent(EVENT_JUMP, 1250);
                return;
            }

            if (phase == 1 && !HealthAbovePct(33) && !me->HasUnitState(UNIT_STATE_ROOT))
            {
                events.CancelEvent(EVENT_SPELL_CHILLING_WAVE);
                phase = 2;
                me->SetReactState(REACT_PASSIVE);
                me->SetTarget(0);
                me->SendMeleeAttackStop(me->GetVictim());
                events.DelayEvents(8000);
                me->CastSpell(me, SPELL_THUNDERING_STOMP, false);
                events.RescheduleEvent(EVENT_JUMP, 1250);
                return;
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != EFFECT_MOTION_TYPE || id != 0)
                return;

            if (phase == 1)
            {
                me->SetControlled(true, UNIT_STATE_ROOT);
                me->CastSpell(me, SPELL_FORGE_BLADE, false);
                Talk(SAY_FORGE_1);
            }
            else if (phase == 2)
            {
                me->SetControlled(true, UNIT_STATE_ROOT);
                me->RemoveAurasDueToSpell(SPELL_FORGE_BLADE);
                me->CastSpell(me, SPELL_FORGE_MACE, false);
                Talk(SAY_FORGE_2);
            }
        }

        void SpellHitTarget(Unit*  /*target*/, const SpellInfo* spell)
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
                events.RescheduleEvent(EVENT_SPELL_DEEP_FREEZE, 10000);
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

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (me->GetVictim())
            {
                float x,y,z;
                me->GetVictim()->GetPosition(x, y, z);
                if (x<600.0f || x>770.0f || y<-270.0f || y>-137.0f || z<514.0f || z>550.0f)
                {
                    me->SetHealth(me->GetMaxHealth());
                    EnterEvadeMode();
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

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_THROW_SARONITE:
                    bCanSayBoulderHit = true;
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 140.0f, true))
                    {
                        WorldPacket data;
                        ChatHandler::BuildChatPacket(data, CHAT_MSG_RAID_BOSS_EMOTE, LANG_UNIVERSAL, me, NULL, EMOTE_THROW_SARONITE);
                        target->ToPlayer()->GetSession()->SendPacket(&data);
                        me->CastSpell(target, SPELL_THROW_SARONITE, false);
                    }
                    events.RepeatEvent(urand(12500,20000));
                    break;
                case EVENT_JUMP:
                    me->DisableRotate(true);
                    if (phase == 1)
                        me->GetMotionMaster()->MoveJump(northForgePos.GetPositionX(), northForgePos.GetPositionY(), northForgePos.GetPositionZ(), 25.0f, 15.0f, 0);
                    else if (phase == 2)
                        me->GetMotionMaster()->MoveJump(southForgePos.GetPositionX(), southForgePos.GetPositionY(), southForgePos.GetPositionZ(), 25.0f, 15.0f, 0);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_CHILLING_WAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CHILLING_WAVE, false);
                    events.RepeatEvent(35000);
                    break;
                case EVENT_SPELL_DEEP_FREEZE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                    {
                        Talk(EMOTE_DEEP_FREEZE, target);
                        me->CastSpell(target, SPELL_DEEP_FREEZE, false);
                    }
                    events.RepeatEvent(35000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_GARFROST, DONE);
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY_1);
        }

        void EnterEvadeMode()
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            ScriptedAI::EnterEvadeMode();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_garfrostAI(creature);
    }
};

class spell_garfrost_permafrost : public SpellScriptLoader
{
public:
    spell_garfrost_permafrost() : SpellScriptLoader("spell_garfrost_permafrost") { }

    class spell_garfrost_permafrost_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_garfrost_permafrost_SpellScript);

        std::list<WorldObject*> targetList;

        void Unload()
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
                                    if (aur->GetStackAmount() >= 10 && caster->GetTypeId() == TYPEID_UNIT)
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

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_garfrost_permafrost_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_garfrost_permafrost_SpellScript::FilterTargetsNext, EFFECT_1, TARGET_UNIT_DEST_AREA_ENEMY);
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_garfrost_permafrost_SpellScript::FilterTargetsNext, EFFECT_2, TARGET_UNIT_DEST_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_garfrost_permafrost_SpellScript();
    }
};

void AddSC_boss_garfrost()
{
    new boss_garfrost();

    new spell_garfrost_permafrost();
}
