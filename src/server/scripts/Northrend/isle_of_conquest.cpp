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

#include "BattlegroundIC.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum eIoCTurrent
{
    EVENT_RESTORE_FLAG          = 1
};

class npc_isle_of_conquest_turret : public CreatureScript
{
public:
    npc_isle_of_conquest_turret() : CreatureScript("npc_isle_of_conquest_turret") {}

    struct npc_isle_of_conquest_turretAI : public VehicleAI
    {
        npc_isle_of_conquest_turretAI(Creature* creature) : VehicleAI(creature), faction(0) { }

        uint32 faction;
        EventMap events;

        void JustDied(Unit* /*killer*/) override
        {
            if (me->GetEntry() == NPC_KEEP_CANNON)
            {
                faction = me->GetFaction();
                me->Respawn();
                me->UpdateEntry(NPC_BROKEN_KEEP_CANNON, nullptr, false);
                me->RemoveVehicleKit();
                me->SetNpcFlag(UNIT_NPC_FLAG_SPELLCLICK);
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_REPAIR_TURRET_DUMMY && me->GetEntry() == NPC_BROKEN_KEEP_CANNON)
            {
                me->UpdateEntry(NPC_KEEP_CANNON, nullptr, false);
                if (faction)
                    me->SetFaction(faction);
                me->CreateVehicleKit(510, NPC_KEEP_CANNON);
                me->RemoveNpcFlag(UNIT_NPC_FLAG_SPELLCLICK);
                events.ScheduleEvent(EVENT_RESTORE_FLAG, 4s);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_RESTORE_FLAG:
                    me->SetNpcFlag(UNIT_NPC_FLAG_SPELLCLICK);
                    break;
            }

            VehicleAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_isle_of_conquest_turretAI(creature);
    }
};

class npc_four_car_garage : public CreatureScript
{
public:
    npc_four_car_garage() : CreatureScript("npc_four_car_garage") {}

    struct npc_four_car_garageAI : public NullCreatureAI
    {
        npc_four_car_garageAI(Creature* creature) : NullCreatureAI(creature) { }

        void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) override
        {
            if (apply)
            {
                uint32 spellId = 0;

                switch (me->GetEntry())
                {
                    case NPC_DEMOLISHER:
                        spellId = SPELL_DRIVING_CREDIT_DEMOLISHER;
                        break;
                    case NPC_GLAIVE_THROWER_A:
                    case NPC_GLAIVE_THROWER_H:
                        spellId = SPELL_DRIVING_CREDIT_GLAIVE;
                        break;
                    case NPC_SIEGE_ENGINE_H:
                    case NPC_SIEGE_ENGINE_A:
                        spellId = SPELL_DRIVING_CREDIT_SIEGE;
                        break;
                    case NPC_CATAPULT:
                        spellId = SPELL_DRIVING_CREDIT_CATAPULT;
                        break;
                    default:
                        return;
                }

                me->CastSpell(who, spellId, true);
            }
        }

        void JustDied(Unit* killer) override
        {
            if (killer)
            {
                if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
                {
                    player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS, 1, 0, me);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_four_car_garageAI(creature);
    }
};

enum Events
{
    EVENT_TALK  = 1,
    EVENT_DESPAWN
};

enum Texts
{
    SAY_ONBOARD = 0
};

class npc_ioc_gunship_captain : public CreatureScript
{
public:
    npc_ioc_gunship_captain() : CreatureScript("npc_ioc_gunship_captain") { }

    struct npc_ioc_gunship_captainAI : public ScriptedAI
    {
        npc_ioc_gunship_captainAI(Creature* creature) : ScriptedAI(creature) { }

        void DoAction(int32 action) override
        {
            if (action == ACTION_GUNSHIP_READY)
            {
                DoCast(me, SPELL_SIMPLE_TELEPORT);
                _events.ScheduleEvent(EVENT_TALK, 3s);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_TALK:
                        _events.ScheduleEvent(EVENT_DESPAWN, 1s);
                        Talk(SAY_ONBOARD);
                        DoCast(me, SPELL_TELEPORT_VISUAL_ONLY);
                        break;
                    case EVENT_DESPAWN:
                        if (me->GetMap()->ToBattlegroundMap())
                            if (Battleground* bgIoC = me->GetMap()->ToBattlegroundMap()->GetBG())
                                bgIoC->DelCreature(BG_IC_NPC_GUNSHIP_CAPTAIN_1);
                        break;
                    default:
                        break;
                }
            }
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ioc_gunship_captainAI(creature);
    }
};

enum BossIoCEvents
{
    EVENT_CHECK_RAGE                = 1,
    EVENT_BRUTAL_STRIKE             = 2,
    EVENT_CRUSHING_LEAP             = 3,
    EVENT_DAGGER_THROW              = 4,
};

enum BossIoCSpells
{
    SPELL_IOCBOSS_BRUTAL_STRIKE     = 58460,
    SPELL_IOCBOSS_CRUSHING_LEAP     = 68506,
    SPELL_IOCBOSS_DAGGER_THROW      = 67280,
    SPELL_IOCBOSS_RAGE              = 66776,
};

class boss_isle_of_conquest : public CreatureScript
{
public:
    boss_isle_of_conquest() : CreatureScript("boss_isle_of_conquest") {}

    struct boss_isle_of_conquestAI : public ScriptedAI
    {
        boss_isle_of_conquestAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;
        bool rage;
        void Reset() override
        {
            events.Reset();
            rage = false;
        }

        void CheckRageBuff()
        {
            if (!rage)
            {
                if (me->GetDistance(me->GetHomePosition()) > 40.0f)
                {
                    rage = true;
                    me->CastSpell(me, SPELL_IOCBOSS_RAGE, true);
                }
            }
            else
            {
                if (me->GetDistance(me->GetHomePosition()) < 40.0f && std::abs(me->GetPositionZ() - me->GetHomePosition().GetPositionZ()) < 5.0f)
                {
                    rage = false;
                    me->RemoveAurasDueToSpell(SPELL_IOCBOSS_RAGE);
                }
            }
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            events.ScheduleEvent(EVENT_CHECK_RAGE, 2s);
            events.ScheduleEvent(EVENT_BRUTAL_STRIKE, 6s);
            events.ScheduleEvent(EVENT_CRUSHING_LEAP, 22s);
            events.ScheduleEvent(EVENT_DAGGER_THROW, 10s);
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
                case EVENT_CHECK_RAGE:
                    CheckRageBuff();
                    events.Repeat(2s);
                    break;
                case EVENT_BRUTAL_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_IOCBOSS_BRUTAL_STRIKE, false);
                    events.Repeat(6s);
                    break;
                case EVENT_CRUSHING_LEAP:
                    me->CastSpell(me, SPELL_IOCBOSS_CRUSHING_LEAP, false);
                    events.Repeat(22s);
                    break;
                case EVENT_DAGGER_THROW:
                    if (Unit* tgt = SelectTarget(SelectTargetMethod::Random))
                        me->CastSpell(tgt, SPELL_IOCBOSS_DAGGER_THROW, false);

                    events.Repeat(10s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_isle_of_conquestAI(creature);
    }
};

class spell_ioc_repair_turret_aura : public AuraScript
{
    PrepareAuraScript(spell_ioc_repair_turret_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_REPAIR_TURRET_DUMMY });
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
            GetTarget()->CastSpell(GetTarget(), SPELL_REPAIR_TURRET_DUMMY, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_ioc_repair_turret_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

enum blastCriteria
{
    SPELL_SEAFORIUM_BLAST         = 66676,
    SPELL_SEAFORIUM_BLAST_H       = 67814,
    SPELL_HUGE_SEAFORIUM_BLAST    = 66672,
    SPELL_HUGE_SEAFORIUM_BLAST_H  = 67813,
    SPELL_BOMB_INABLE_CREDIT      = 68366,
    SPELL_BOMB_INATION_CREDIT     = 68367
};

class spell_ioc_bomb_blast_criteria : public SpellScript
{
    PrepareSpellScript(spell_ioc_bomb_blast_criteria);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BOMB_INABLE_CREDIT, SPELL_BOMB_INATION_CREDIT });
    }

    void HandleGameObjectDamage(SpellEffIndex /*effIndex*/)
    {
        uint32 creditSpell = 0;
        Unit* owner = GetCaster()->GetOwner();
        if (!owner)
            return;

        uint32 spellId = GetSpellInfo()->Id;
        if (spellId == SPELL_SEAFORIUM_BLAST || spellId == SPELL_SEAFORIUM_BLAST_H)
            creditSpell = SPELL_BOMB_INABLE_CREDIT;
        else if (spellId == SPELL_HUGE_SEAFORIUM_BLAST || spellId == SPELL_HUGE_SEAFORIUM_BLAST_H)
            creditSpell = SPELL_BOMB_INATION_CREDIT;

        owner->CastSpell(owner, creditSpell, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_ioc_bomb_blast_criteria::HandleGameObjectDamage, EFFECT_1, SPELL_EFFECT_GAMEOBJECT_DAMAGE);
    }
};

class spell_ioc_gunship_portal : public SpellScript
{
    PrepareSpellScript(spell_ioc_gunship_portal);

    bool Load() override
    {
        return GetCaster()->GetTypeId() == TYPEID_PLAYER;
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        /*Player* caster = GetCaster()->ToPlayer();
         *
         * HACK: GetWorldLocation() returns real position and not transportposition.
         * ServertoClient: SMSG_MOVE_TELEPORT (0x0B39)
         * counter: 45
         * Tranpsort Guid: Full: xxxx Type: MOTransport Low: xxx
         * Transport Position X: 0 Y: 0 Z: 0 O: 0
         * Position: X: 7.305609 Y: -0.095246 Z: 34.51022 O: 0

        caster->TeleportTo(GetHitCreature()->GetWorldLocation(), TELE_TO_NOT_LEAVE_TRANSPORT);*/
    }

    void HandleScript2(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Player* caster = GetCaster()->ToPlayer();
        if (!caster->IsBeingTeleported())
            if (Battleground* bg = caster->GetBattleground())
                bg->DoAction(2 /**/, caster->GetGUID());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_ioc_gunship_portal::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        OnEffectHitTarget += SpellEffectFn(spell_ioc_gunship_portal::HandleScript2, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_ioc_parachute_ic_aura : public AuraScript
{
    PrepareAuraScript(spell_ioc_parachute_ic_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PARACHUTE_IC });
    }

    void HandleTriggerSpell(AuraEffect const* /*aurEff*/)
    {
        if (Player* target = GetTarget()->ToPlayer())
            if (target->m_movementInfo.fallTime > 2500 && !target->GetTransport())
                target->CastSpell(target, SPELL_PARACHUTE_IC, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_ioc_parachute_ic_aura::HandleTriggerSpell, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_ioc_launch : public SpellScript
{
    PrepareSpellScript(spell_ioc_launch);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetHitPlayer())
            player->AddAura(SPELL_LAUNCH_NO_FALLING_DAMAGE, player); // prevents falling damage
    }

    void Launch()
    {
        WorldLocation const* const position = GetExplTargetDest();

        if (Player* player = GetHitPlayer())
        {
            player->ExitVehicle();
            player->DisableSpline();
            player->GetMap()->PlayerRelocation(player, GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), GetCaster()->GetPositionZ(), GetCaster()->GetOrientation());

            float dist = position->GetExactDist2d(player->GetPositionX(), player->GetPositionY());
            float elevation = GetSpell()->m_targets.GetElevation();
            float speedZ = std::max(10.0f, float(50.0f * std::sin(elevation)));
            float speedXY = dist * 10.0f / speedZ;

            player->GetMotionMaster()->MoveJump(position->GetPositionX(), position->GetPositionY(), position->GetPositionZ(), speedXY, speedZ);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_ioc_launch::HandleScript, EFFECT_1, SPELL_EFFECT_FORCE_CAST);
        AfterHit += SpellHitFn(spell_ioc_launch::Launch);
    }
};

void AddSC_isle_of_conquest()
{
    new npc_isle_of_conquest_turret();
    new npc_four_car_garage();
    new npc_ioc_gunship_captain();
    new boss_isle_of_conquest();
    RegisterSpellScript(spell_ioc_repair_turret_aura);
    RegisterSpellScript(spell_ioc_bomb_blast_criteria);
    RegisterSpellScript(spell_ioc_gunship_portal);
    RegisterSpellScript(spell_ioc_parachute_ic_aura);
    RegisterSpellScript(spell_ioc_launch);
}
