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

#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "pit_of_saron.h"

enum Yells
{
    // Ick
    EMOTE_ICK_POISON_NOVA               = 0,
    EMOTE_ICK_CHASE                     = 1,

    // Krick
    SAY_AGGRO                           = 0,
    SAY_SLAY                            = 1,
    SAY_BARRAGE_1                       = 2,
    SAY_BARRAGE_2                       = 3,
    SAY_POISON_NOVA                     = 4,
    SAY_CHASE                           = 5,
};

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

    EVENT_OUTRO_RESET_LEADER,
    EVENT_OUTRO_KRICK_1,
    EVENT_OUTRO_LEADER_1,
    EVENT_OUTRO_KRICK_2,
    EVENT_OUTRO_LEADER_2,
    EVENT_OUTRO_KRICK_3,
    EVENT_OUTRO_TYRANNUS_1,
    EVENT_OUTRO_STRANGULATE,
    EVENT_OUTRO_KRICK_4,
    EVENT_OUTRO_KRICK_DIES,
    EVENT_OUTRO_TYRANNUS_2,
    EVENT_OUTRO_LEADER_3,
};

enum Actions
{
    ACTION_START_KRICK_OUTRO            = 1,
};

class boss_ick : public CreatureScript
{
public:
    boss_ick() : CreatureScript("boss_ick") { }

    struct boss_ickAI : public ScriptedAI
    {
        boss_ickAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = creature->GetInstanceScript();
        }

        void Reset() override
        {
            me->SetReactState(REACT_AGGRESSIVE);
            events.Reset();
            _instance->SetData(DATA_ICK, NOT_STARTED);
        }

        bool CanAIAttack(Unit const* /*who*/) const override
        {
            return _instance->GetData(DATA_INSTANCE_PROGRESS) >= INSTANCE_PROGRESS_FINISHED_INTRO;
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (Creature* krick = GetKrick())
                krick->AI()->Talk(SAY_AGGRO);
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_TOXIC_WASTE, 3s, 5s);
            events.RescheduleEvent(EVENT_SPELL_MIGHTY_KICK, 10s, 20s);
            events.RescheduleEvent(EVENT_SPELL_SHADOW_BOLT, 10s);
            events.RescheduleEvent(EVENT_SPECIAL, 25s);

            _instance->SetData(DATA_ICK, IN_PROGRESS);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (!target || !spell)
                return;
            if (spell->Id == SPELL_PURSUIT && target->IsPlayer())
            {
                Talk(EMOTE_ICK_CHASE, target);
                AttackStart(target);
                me->SetReactState(REACT_PASSIVE);
                events.RescheduleEvent(EVENT_SET_REACT_AGGRESSIVE, 12s);
            }
        }

        Creature* GetKrick()
        {
            if (Vehicle* vehicle = me->GetVehicleKit())
                if (Unit* passenger = vehicle->GetPassenger(0))
                    return passenger->ToCreature();
            return nullptr;
        }

        void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
                if (Creature* krick = GetKrick())
                {
                    krick->InterruptNonMeleeSpells(true);
                    krick->RemoveAllAuras();
                    Position myPos(*me);
                    Position exitPos;
                    float angle = me->GetOrientation() + 3 * M_PI / 2;
                    float dist = 3.0f;
                    exitPos.Relocate(myPos.GetPositionX() + dist * std::cos(angle), myPos.GetPositionY() + dist * std::sin(angle), 515.0f, M_PI);
                    exitPos.m_positionZ = me->GetMap()->GetHeight(exitPos.GetPositionX(), exitPos.GetPositionY(), exitPos.GetPositionZ());

                    if (exitPos.GetPositionZ() < 505.0f || exitPos.GetPositionZ() > 512.0f || !me->IsWithinLOS(exitPos.GetPositionX(), exitPos.GetPositionY(), exitPos.GetPositionZ()))
                        exitPos.Relocate(myPos);

                    krick->_ExitVehicle(&exitPos);
                    krick->AI()->DoAction(ACTION_START_KRICK_OUTRO);
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

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_TOXIC_WASTE:
                    if (Creature* krick = GetKrick())
                        if (!krick->HasUnitState(UNIT_STATE_CASTING))
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                            {
                                krick->CastSpell(target, SPELL_TOXIC_WASTE);
                                events.Repeat(7s, 10s);
                                break;
                            }
                    events.Repeat(2500ms);
                    break;
                case EVENT_SPELL_MIGHTY_KICK:
                    DoCastVictim(SPELL_MIGHTY_KICK);
                    events.Repeat(20s, 25s);
                    break;
                case EVENT_SPELL_SHADOW_BOLT:
                    if (Creature* krick = GetKrick())
                        if (!krick->HasUnitState(UNIT_STATE_CASTING))
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 35.0f, true))
                            {
                                krick->CastSpell(target, SPELL_SHADOW_BOLT);
                                events.Repeat(14s);
                                break;
                            }
                    events.Repeat(2500ms);
                    break;
                case EVENT_SET_REACT_AGGRESSIVE:
                    me->SetReactState(REACT_AGGRESSIVE);
                    if (!UpdateVictim())
                        return;

                    break;
                case EVENT_SPECIAL:
                    switch (urand(0, 2))
                    {
                        case 0: // Pursuit
                            if (Creature* krick = GetKrick())
                                krick->AI()->Talk(SAY_CHASE);
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 70.0f, true))
                                DoCast(target, SPELL_PURSUIT);
                            break;
                        case 1: // Poison Nova
                            if (Creature* krick = GetKrick())
                            {
                                krick->AI()->Talk(SAY_POISON_NOVA);
                                Talk(EMOTE_ICK_POISON_NOVA);
                            }
                            DoCastSelf(SPELL_POISON_NOVA);
                            break;
                        case 2: // Explosive Barrage
                            if (Creature* krick = GetKrick())
                            {
                                krick->AI()->Talk(SAY_BARRAGE_1);
                                krick->AI()->Talk(SAY_BARRAGE_2);
                                krick->InterruptNonMeleeSpells(false);
                                me->InterruptNonMeleeSpells(false);
                                krick->CastSpell(krick, SPELL_EXPLOSIVE_BARRAGE_KRICK, false);
                                DoCastSelf(SPELL_EXPLOSIVE_BARRAGE_ICK);
                            }
                            events.DelayEvents(20s);
                            break;
                        default:
                            break;
                    }
                    events.Repeat(25s, 30s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _instance->SetData(DATA_ICK, DONE);
            me->RemoveAllAuras();
        }

        void KilledUnit(Unit* who) override
        {
            // if during pursuit ick kills his target, set to aggressive again
            if (who && me->GetVictim() && who->GetGUID() == me->GetVictim()->GetGUID())
                if (me->GetReactState() == REACT_PASSIVE)
                    me->SetReactState(REACT_AGGRESSIVE);

            if (who->IsPlayer())
                if (Creature* krick = GetKrick())
                    krick->AI()->Talk(SAY_SLAY);
        }

    private:
        InstanceScript* _instance;
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
            _instance = creature->GetInstanceScript();
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_KRICK_OUTRO)
            {
                me->setActive(true);
                events.RescheduleEvent(EVENT_OUTRO_RESET_LEADER, 0ms);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_OUTRO_RESET_LEADER:
                    _instance->SetData(DATA_INSTANCE_PROGRESS, INSTANCE_PROGRESS_FINISHED_KRICK_SCENE);

                    if (Creature* leader = _instance->instance->GetCreature(_instance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                    {
                        leader->GetMotionMaster()->Clear();
                        leader->UpdatePosition(SBSLeaderStartPos, true);
                        leader->StopMovingOnCurrentPos();
                        leader->AI()->Reset();
                    }

                    events.RescheduleEvent(EVENT_OUTRO_KRICK_1, 3s);
                    break;
                case EVENT_OUTRO_KRICK_1:
                    Talk(SAY_OUTRO_KRICK_1);
                    if (Creature* leader = _instance->instance->GetCreature(_instance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                    {
                        float angle = me->GetAngle(leader);
                        me->SetFacingTo(angle);
                        float x = me->GetPositionX() + std::cos(angle) * 7.0f;
                        float y = me->GetPositionY() + std::sin(angle) * 7.0f;
                        leader->GetMotionMaster()->MovePoint(0, x, y, me->GetPositionZ());
                    }

                    for (uint8 i = 0; i < 2; ++i)
                        if (Creature* guard = _instance->instance->GetCreature(_instance->GetGuidData(DATA_GUARD_1_GUID + i)))
                            guard->DespawnOrUnsummon();

                    events.RescheduleEvent(EVENT_OUTRO_LEADER_1, 7s);
                    break;
                case EVENT_OUTRO_LEADER_1:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                    {
                        tyrannus->setActive(true);
                        tyrannus->UpdatePosition(SBSTyrannusStartPos, true);
                        tyrannus->SetHomePosition(SBSTyrannusStartPos);
                    }
                    if (Creature* leader = _instance->instance->GetCreature(_instance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                        leader->AI()->Talk(leader->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_KRICK_1 : SAY_SYLVANAS_KRICK_1);

                    events.RescheduleEvent(EVENT_OUTRO_KRICK_2, 6500ms);
                    break;
                case EVENT_OUTRO_KRICK_2:
                    Talk(SAY_OUTRO_KRICK_2);

                    events.RescheduleEvent(EVENT_OUTRO_LEADER_2, 17s);
                    break;
                case EVENT_OUTRO_LEADER_2:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        tyrannus->GetMotionMaster()->MoveWaypoint(PATH_TYRANNUS_KRICK_OUTRO, false);
                    if (Creature* leader = _instance->instance->GetCreature(_instance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                        leader->AI()->Talk(leader->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_KRICK_2 : SAY_SYLVANAS_KRICK_2);

                    events.RescheduleEvent(EVENT_OUTRO_KRICK_3, 6500ms);
                    break;
                case EVENT_OUTRO_KRICK_3:
                    Talk(SAY_OUTRO_KRICK_3);

                    events.RescheduleEvent(EVENT_OUTRO_TYRANNUS_1, 6500ms);
                    break;
                case EVENT_OUTRO_TYRANNUS_1:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                    {
                        tyrannus->SetFacingToObject(me);
                        tyrannus->AI()->Talk(SAY_TYRANNUS_KRICK_1);
                    }

                    events.RescheduleEvent(EVENT_OUTRO_STRANGULATE, 4s);
                    break;
                case EVENT_OUTRO_STRANGULATE:
                    DoCastSelf(SPELL_STRANGULATING, true);
                    me->SendMeleeAttackStop(me->GetVictim());
                    me->SetCanFly(true);
                    me->SetDisableGravity(true);
                    me->SendMovementFlagUpdate();
                    me->GetMotionMaster()->MoveTakeoff(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 9.0f, 0.5f * 7.0f);

                    events.RescheduleEvent(EVENT_OUTRO_KRICK_4, 2s);
                    break;
                case EVENT_OUTRO_KRICK_4:
                    Talk(SAY_OUTRO_KRICK_4);

                    events.RescheduleEvent(EVENT_OUTRO_KRICK_DIES, 1500ms);
                    break;
                case EVENT_OUTRO_KRICK_DIES:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        tyrannus->CastSpell(tyrannus, SPELL_NECROMANTIC_POWER, false);

                    me->SetReactState(REACT_PASSIVE);
                    me->SetUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
                    me->SetImmuneToAll(true);
                    me->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
                    me->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
                    me->AddUnitState(UNIT_STATE_DIED);

                    DoCastSelf(SPELL_KRICK_KILL_CREDIT, true);

                    me->RemoveAllAuras();
                    me->GetMotionMaster()->MoveFall(0, true);

                    events.RescheduleEvent(EVENT_OUTRO_TYRANNUS_2, 5s);
                    break;
                case EVENT_OUTRO_TYRANNUS_2:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        tyrannus->AI()->Talk(SAY_TYRANNUS_KRICK_2);

                    events.RescheduleEvent(EVENT_OUTRO_LEADER_3, 9s);
                    break;
                case EVENT_OUTRO_LEADER_3:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        tyrannus->GetMotionMaster()->MovePoint(POINT_TYRANNUS_KRICK_OUTRO_END, 809.39f, 74.69f, 541.54f);
                    if (Creature* leader = _instance->instance->GetCreature(_instance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                    {
                        leader->AI()->Talk(leader->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_KRICK_3 : SAY_SYLVANAS_KRICK_3);
                        leader->GetMotionMaster()->MoveWaypoint(PATH_LEADER_KRICK_OUTRO, false);
                    }
                    me->setActive(false);
                    me->KillSelf();

                    break;
                default:
                    break;
            }
        }

    private:
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<boss_krickAI>(creature);
    }
};

class spell_krick_explosive_barrage_aura : public AuraScript
{
    PrepareAuraScript(spell_krick_explosive_barrage_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_EXPLOSIVE_BARRAGE_SUMMON });
    }

    void HandlePeriodicTick(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* caster = GetCaster())
            if (caster->IsCreature())
            {
                for (auto const& ref : caster->GetMap()->GetPlayers())
                    if (Player* player = ref.GetSource())
                        if (player->IsWithinDist(caster, 100.0f))
                            caster->CastSpell(player, SPELL_EXPLOSIVE_BARRAGE_SUMMON, true);
            }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_krick_explosive_barrage_aura::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_exploding_orb_auto_grow_aura : public AuraScript
{
    PrepareAuraScript(spell_exploding_orb_auto_grow_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_EXPLOSIVE_BARRAGE_DAMAGE, SPELL_HASTY_GROW, SPELL_AUTO_GROW, SPELL_EXPLODING_ORB_VISUAL });
    }

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
                if (target->IsCreature())
                    target->ToCreature()->DespawnOrUnsummon(2s);
            }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_exploding_orb_auto_grow_aura::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_boss_ick()
{
    new boss_ick();
    new boss_krick();

    RegisterSpellScript(spell_krick_explosive_barrage_aura);
    RegisterSpellScript(spell_exploding_orb_auto_grow_aura);
}
