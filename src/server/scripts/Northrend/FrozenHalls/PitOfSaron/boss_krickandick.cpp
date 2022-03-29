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

#include "Opcodes.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "Vehicle.h"
#include "WorldSession.h"
#include "pit_of_saron.h"

enum Yells
{
    SAY_AGGRO                           = 24,
    SAY_SLAY_1                          = 25,
    SAY_SLAY_2                          = 26,
    SAY_ORDER_STOP                      = 27,
    SAY_ORDER_BLOW                      = 28,
    SAY_TARGET_1                        = 29,
    SAY_TARGET_2                        = 30,
    SAY_TARGET_3                        = 31,
    EMOTE_KRICK_MINES                   = 32,
    EMOTE_ICK_POISON                    = 33,
};

#define EMOTE_ICK_CHASING               "%s is chasing you!"

enum Spells
{
    SPELL_TOXIC_WASTE                   = 69024,
    SPELL_MIGHTY_KICK                   = 69021,
    SPELL_SHADOW_BOLT                   = 69028,

    SPELL_PURSUIT                       = 68987,

    SPELL_POISON_NOVA                   = 68989,

    SPELL_EXPLOSIVE_BARRAGE_KRICK       = 69012,
    SPELL_EXPLOSIVE_BARRAGE_ICK         = 69263,
    SPELL_EXPLOSIVE_BARRAGE_SUMMON      = 69015,
    SPELL_EXPLODING_ORB_VISUAL          = 69017,
    SPELL_AUTO_GROW                     = 69020,
    SPELL_HASTY_GROW                    = 44851,
    SPELL_EXPLOSIVE_BARRAGE_DAMAGE      = 69019,
};

enum Events
{
    EVENT_SPELL_TOXIC_WASTE = 1,
    EVENT_SPELL_MIGHTY_KICK,
    EVENT_SPELL_SHADOW_BOLT,
    EVENT_SPECIAL,
    EVENT_SET_REACT_AGGRESSIVE,
};

class boss_ick : public CreatureScript
{
public:
    boss_ick() : CreatureScript("boss_ick") { }

    struct boss_ickAI : public ScriptedAI
    {
        boss_ickAI(Creature* creature) : ScriptedAI(creature)
        {
            pInstance = creature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            me->SetReactState(REACT_AGGRESSIVE);
            events.Reset();
            if (pInstance)
                pInstance->SetData(DATA_ICK, NOT_STARTED);
        }

        bool CanAIAttack(Unit const*  /*who*/) const override
        {
            return pInstance && pInstance->GetData(DATA_INSTANCE_PROGRESS) >= INSTANCE_PROGRESS_FINISHED_INTRO;
        }

        void EnterCombat(Unit* /*who*/) override
        {
            if (Creature* k = GetKrick())
                k->AI()->Talk(SAY_AGGRO);
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_TOXIC_WASTE, urand(3000, 5000));
            events.RescheduleEvent(EVENT_SPELL_MIGHTY_KICK, urand(10000, 20000));
            events.RescheduleEvent(EVENT_SPELL_SHADOW_BOLT, 10000);
            events.RescheduleEvent(EVENT_SPECIAL, 25000);

            if (pInstance)
                pInstance->SetData(DATA_ICK, IN_PROGRESS);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (!target || !spell)
                return;
            if (spell->Id == SPELL_PURSUIT && target->GetTypeId() == TYPEID_PLAYER)
            {
                WorldPacket data;

                ChatHandler::BuildChatPacket(data, CHAT_MSG_RAID_BOSS_EMOTE, LANG_UNIVERSAL, me, nullptr, EMOTE_ICK_CHASING);
                target->ToPlayer()->GetSession()->SendPacket(&data);

                AttackStart(target);
                me->SetReactState(REACT_PASSIVE);
                events.RescheduleEvent(EVENT_SET_REACT_AGGRESSIVE, 12000);
            }
        }

        Creature* GetKrick()
        {
            if (Vehicle* v = me->GetVehicleKit())
                if (Unit* p = v->GetPassenger(0))
                    return p->ToCreature();
            return (Creature*)nullptr;
        }

        void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
                if (Creature* krick = GetKrick())
                {
                    krick->InterruptNonMeleeSpells(true);
                    krick->RemoveAllAuras();
                    Position myPos(*me), exitPos;
                    float ang = me->GetOrientation() + 3 * M_PI / 2;
                    float dist = 3.0f;
                    exitPos.Relocate(myPos.GetPositionX() + dist * cos(ang), myPos.GetPositionY() + dist * std::sin(ang), 515.0f, M_PI);
                    exitPos.m_positionZ = me->GetMap()->GetHeight(exitPos.GetPositionX(), exitPos.GetPositionY(), exitPos.GetPositionZ());

                    if (exitPos.GetPositionZ() < 505.0f || exitPos.GetPositionZ() > 512.0f || !me->IsWithinLOS(exitPos.GetPositionX(), exitPos.GetPositionY(), exitPos.GetPositionZ()))
                        exitPos.Relocate(myPos);

                    krick->_ExitVehicle(&exitPos);
                    krick->AI()->DoAction(1);
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
                if (KrickCenterPos.GetExactDist(x, y, z) > 80.0f || z > KrickCenterPos.GetPositionZ() + 20.0f || z < KrickCenterPos.GetPositionZ() - 20.0f)
                {
                    me->SetHealth(me->GetMaxHealth());
                    EnterEvadeMode();
                    return;
                }
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_STUNNED))
                return;

            switch(events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_TOXIC_WASTE:
                    if (Creature* k = GetKrick())
                        if (!k->HasUnitState(UNIT_STATE_CASTING))
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                            {
                                k->CastSpell(target, SPELL_TOXIC_WASTE);
                                events.RepeatEvent(urand(7000, 10000));
                                break;
                            }
                    events.RepeatEvent(2500);
                    break;
                case EVENT_SPELL_MIGHTY_KICK:
                    me->CastSpell(me->GetVictim(), SPELL_MIGHTY_KICK, false);
                    events.RepeatEvent(urand(20000, 25000));
                    break;
                case EVENT_SPELL_SHADOW_BOLT:
                    if (Creature* k = GetKrick())
                        if (!k->HasUnitState(UNIT_STATE_CASTING))
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 35.0f, true))
                            {
                                k->CastSpell(target, SPELL_SHADOW_BOLT);
                                events.RepeatEvent(14000);
                                break;
                            }
                    events.RepeatEvent(2500);
                    break;
                case EVENT_SET_REACT_AGGRESSIVE:
                    me->SetReactState(REACT_AGGRESSIVE);
                    if (!UpdateVictim())
                        return;

                    break;
                case EVENT_SPECIAL:
                    switch(urand(0, 2))
                    {
                        case 0: // Pursuit
                            if (Creature* k = GetKrick())
                                k->AI()->Talk(RAND(SAY_TARGET_1, SAY_TARGET_2, SAY_TARGET_3));
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 70.0f, true))
                                me->CastSpell(target, SPELL_PURSUIT, false);
                            break;
                        case 1: // Poison Nova
                            if (Creature* k = GetKrick())
                            {
                                k->AI()->Talk(SAY_ORDER_BLOW);
                                Talk(EMOTE_ICK_POISON);
                            }
                            me->CastSpell(me, SPELL_POISON_NOVA, false);
                            break;
                        case 2: // Explosive Barrage
                            if (Creature* k = GetKrick())
                            {
                                k->AI()->Talk(SAY_ORDER_STOP);
                                k->AI()->Talk(EMOTE_KRICK_MINES);
                                k->InterruptNonMeleeSpells(false);
                                me->InterruptNonMeleeSpells(false);
                                k->CastSpell(k, SPELL_EXPLOSIVE_BARRAGE_KRICK, false);
                                me->CastSpell(me, SPELL_EXPLOSIVE_BARRAGE_ICK, false);
                            }
                            events.DelayEvents(20000);
                            break;
                    }
                    events.RepeatEvent(urand(25000, 30000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (pInstance)
                pInstance->SetData(DATA_ICK, DONE);
            me->RemoveAllAuras();
        }

        void KilledUnit(Unit* who) override
        {
            // if during pursuit ick kills his target, set to aggressive again
            if (who && me->GetVictim() && who->GetGUID() == me->GetVictim()->GetGUID())
                if (me->GetReactState() == REACT_PASSIVE)
                    me->SetReactState(REACT_AGGRESSIVE);

            if (who->GetTypeId() == TYPEID_PLAYER)
                if (Creature* k = GetKrick())
                    k->AI()->Talk(RAND(SAY_SLAY_1, SAY_SLAY_2));
        }

        void JustSummoned(Creature*  /*summon*/) override
        {
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<boss_ickAI>(creature);
    }
};

class boss_krick : public CreatureScript
{
public:
    boss_krick() : CreatureScript("boss_krick") { }

    struct boss_krickAI : public NullCreatureAI
    {
        boss_krickAI(Creature* creature) : NullCreatureAI(creature)
        {
            pInstance = creature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void DoAction(int32 a) override
        {
            if (a == 1)
            {
                me->setActive(true);
                events.RescheduleEvent(20, 0);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch(events.ExecuteEvent())
            {
                case 0:
                    break;
                case 20:
                    if (pInstance)
                    {
                        pInstance->SetData(DATA_INSTANCE_PROGRESS, INSTANCE_PROGRESS_FINISHED_KRICK_SCENE);

                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                        {
                            c->GetMotionMaster()->Clear();
                            c->UpdatePosition(SBSLeaderStartPos, true);
                            c->StopMovingOnCurrentPos();
                            c->AI()->Reset();
                        }
                    }

                    events.RescheduleEvent(1, 3000);
                    break;
                case 1:
                    Talk(SAY_OUTRO_KRICK_1);
                    if (pInstance)
                    {
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                        {
                            float angle = me->GetAngle(c);
                            me->SetFacingTo(angle);
                            float x = me->GetPositionX() + cos(angle) * 7.0f;
                            float y = me->GetPositionY() + std::sin(angle) * 7.0f;
                            c->GetMotionMaster()->MovePoint(0, x, y, me->GetPositionZ());
                        }

                        for (uint8 i = 0; i < 2; ++i)
                            if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_GUARD_1_GUID + i)))
                                c->DespawnOrUnsummon();
                    }

                    events.RescheduleEvent(2, 7000);
                    break;
                case 2:
                    if (pInstance)
                    {
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        {
                            c->setActive(true);
                            c->UpdatePosition(SBSTyrannusStartPos, true);
                            c->SetHomePosition(SBSTyrannusStartPos);
                        }
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                            c->AI()->Talk(c->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_KRICK_1 : SAY_SYLVANAS_KRICK_1);
                    }

                    events.RescheduleEvent(3, 6500);
                    break;
                case 3:
                    Talk(SAY_OUTRO_KRICK_2);

                    events.RescheduleEvent(4, 17000);
                    break;
                case 4:
                    if (pInstance)
                    {
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                            c->GetMotionMaster()->MovePath(PATH_BEGIN_VALUE + 10, false);
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                            c->AI()->Talk(c->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_KRICK_2 : SAY_SYLVANAS_KRICK_2);
                    }

                    events.RescheduleEvent(5, 6500);
                    break;
                case 5:
                    Talk(SAY_OUTRO_KRICK_3);

                    events.RescheduleEvent(6, 6500);
                    break;
                case 6:
                    if (pInstance)
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        {
                            c->SetFacingToObject(me);
                            c->AI()->Talk(SAY_TYRANNUS_KRICK_1);
                        }

                    events.RescheduleEvent(7, 4000);
                    break;
                case 7:
                    me->CastSpell(me, 69413, true);
                    me->SendMeleeAttackStop(me->GetVictim());
                    me->SetCanFly(true);
                    me->SetDisableGravity(true);
                    me->SendMovementFlagUpdate();
                    me->GetMotionMaster()->MoveTakeoff(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 9.0f, 0.5f * 7.0f);

                    events.RescheduleEvent(8, 2000);
                    break;
                case 8:
                    Talk(SAY_OUTRO_KRICK_4);

                    events.RescheduleEvent(9, 1500);
                    break;
                case 9:
                    if (pInstance)
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                            c->CastSpell(c, 69753, false);

                    me->SetReactState(REACT_PASSIVE);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                    me->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
                    me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                    me->AddUnitState(UNIT_STATE_DIED);

                    me->CastSpell(me, SPELL_KRICK_KILL_CREDIT, true);

                    me->RemoveAllAuras();
                    me->GetMotionMaster()->MoveFall(0, true);

                    events.RescheduleEvent(10, 5000);
                    break;
                case 10:
                    if (pInstance)
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                            c->AI()->Talk(SAY_TYRANNUS_KRICK_2);

                    events.RescheduleEvent(11, 9000);
                    break;
                case 11:
                    if (pInstance)
                    {
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                            c->GetMotionMaster()->MovePoint(1, 809.39f, 74.69f, 541.54f);
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                        {
                            c->AI()->Talk(c->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_KRICK_3 : SAY_SYLVANAS_KRICK_3);
                            c->GetMotionMaster()->MovePath(PATH_BEGIN_VALUE + 11, false);
                        }
                    }
                    me->setActive(false);
                    Unit::Kill(me, me);

                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<boss_krickAI>(creature);
    }
};

class spell_krick_explosive_barrage : public SpellScriptLoader
{
public:
    spell_krick_explosive_barrage() : SpellScriptLoader("spell_krick_explosive_barrage") { }

    class spell_krick_explosive_barrage_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_krick_explosive_barrage_AuraScript);

        void HandlePeriodicTick(AuraEffect const* /*aurEff*/)
        {
            PreventDefaultAction();
            if (Unit* caster = GetCaster())
                if (caster->GetTypeId() == TYPEID_UNIT)
                {
                    Map::PlayerList const& players = caster->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                        if (Player* player = itr->GetSource())
                            if (player->IsWithinDist(caster, 100.0f))
                                caster->CastSpell(player, SPELL_EXPLOSIVE_BARRAGE_SUMMON, true);
                }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_krick_explosive_barrage_AuraScript::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_krick_explosive_barrage_AuraScript();
    }
};

class spell_exploding_orb_auto_grow : public SpellScriptLoader
{
public:
    spell_exploding_orb_auto_grow() : SpellScriptLoader("spell_exploding_orb_auto_grow") { }

    class spell_exploding_orb_auto_grow_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_exploding_orb_auto_grow_AuraScript);

        void HandlePeriodicTick(AuraEffect const* aurEff)
        {
            if (aurEff->GetTickNumber() >= 16)
                if (Unit* target = GetTarget())
                {
                    PreventDefaultAction();
                    target->CastSpell(target, SPELL_EXPLOSIVE_BARRAGE_DAMAGE, false);
                    target->RemoveAurasDueToSpell(SPELL_HASTY_GROW);
                    target->RemoveAurasDueToSpell(SPELL_AUTO_GROW);
                    target->RemoveAurasDueToSpell(SPELL_EXPLODING_ORB_VISUAL);
                    if (target->GetTypeId() == TYPEID_UNIT)
                        target->ToCreature()->DespawnOrUnsummon(2000);
                }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_exploding_orb_auto_grow_AuraScript::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_exploding_orb_auto_grow_AuraScript();
    }
};

void AddSC_boss_ick()
{
    new boss_ick();
    new boss_krick();

    new spell_krick_explosive_barrage();
    new spell_exploding_orb_auto_grow();
}
