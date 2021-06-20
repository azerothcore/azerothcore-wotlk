/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "BattlegroundIC.h"
#include "SpellScript.h"
#include "CombatAI.h"
#include "PassiveAI.h"
#include "SpellAuras.h"
#include "Player.h"

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

            void JustDied(Unit* )
            {
                if (me->GetEntry() == NPC_KEEP_CANNON)
                {
                    faction = me->getFaction();
                    me->Respawn();
                    me->UpdateEntry(NPC_BROKEN_KEEP_CANNON, NULL, false);
                    me->RemoveVehicleKit();
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
                }
            }

            void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo)
            {
                if (spellInfo->Id == SPELL_REPAIR_TURRET_DUMMY && me->GetEntry() == NPC_BROKEN_KEEP_CANNON)
                {
                    me->UpdateEntry(NPC_KEEP_CANNON, NULL, false);
                    if (faction)
                        me->setFaction(faction);
                    me->CreateVehicleKit(510, NPC_KEEP_CANNON);
                    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
                    events.ScheduleEvent(EVENT_RESTORE_FLAG, 4000);
                }
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_RESTORE_FLAG:
                        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
                        break;
                }

                VehicleAI::UpdateAI(diff);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
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

            void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply)
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

            void JustDied(Unit* killer)
            {
                if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
                    player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS, 1, 0, me);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
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

            void DoAction(int32 action)
            {
                if (action == ACTION_GUNSHIP_READY)
                {
                    DoCast(me, SPELL_SIMPLE_TELEPORT);
                    _events.ScheduleEvent(EVENT_TALK, 3000);
                }
            }

            void UpdateAI(uint32 diff)
            {
                _events.Update(diff);
                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_TALK:
                            _events.ScheduleEvent(EVENT_DESPAWN, 1000);
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

        CreatureAI* GetAI(Creature* creature) const
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
            void Reset() 
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
                    if (me->GetDistance(me->GetHomePosition()) < 40.0f && abs(me->GetPositionZ() - me->GetHomePosition().GetPositionZ()) < 5.0f)
                    {
                        rage = false;
                        me->RemoveAurasDueToSpell(SPELL_IOCBOSS_RAGE);
                    }
                }
            }

            void EnterCombat(Unit*  /*who*/)
            {
                events.ScheduleEvent(EVENT_CHECK_RAGE, 2000);
                events.ScheduleEvent(EVENT_BRUTAL_STRIKE, 6000);
                events.ScheduleEvent(EVENT_CRUSHING_LEAP, 22000);
                events.ScheduleEvent(EVENT_DAGGER_THROW, 10000);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.GetEvent())
                {
                    case EVENT_CHECK_RAGE:
                        CheckRageBuff();
                        events.RepeatEvent(2000);
                        break;
                    case EVENT_BRUTAL_STRIKE:
                        me->CastSpell(me->GetVictim(), SPELL_IOCBOSS_BRUTAL_STRIKE, false);
                        events.RepeatEvent(6000);
                        break;
                    case EVENT_CRUSHING_LEAP:
                        me->CastSpell(me, SPELL_IOCBOSS_CRUSHING_LEAP, false);
                        events.RepeatEvent(22000);
                        break;
                    case EVENT_DAGGER_THROW:
                        if (Unit* tgt = SelectTarget(SELECT_TARGET_RANDOM))
                            me->CastSpell(tgt, SPELL_IOCBOSS_DAGGER_THROW, false);
                        
                        events.RepeatEvent(10000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_isle_of_conquestAI(creature);
        }
};

class spell_ioc_repair_turret : public SpellScriptLoader
{
    public:
        spell_ioc_repair_turret() : SpellScriptLoader("spell_ioc_repair_turret") { }

        class spell_ioc_repair_turret_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_ioc_repair_turret_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
                    GetTarget()->CastSpell(GetTarget(), SPELL_REPAIR_TURRET_DUMMY, true);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_ioc_repair_turret_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_ioc_repair_turret_AuraScript();
        }
};

enum blastCriteria
{
    SPELL_SEAFORIUM_BLAST           = 66676,
    SPELL_HUGE_SEAFORIUM_BLAST      = 66672,

    SPELL_BOMB_INABLE_CREDIT        = 68366,
    SPELL_BOMB_INATION_CREDIT       = 68367,
};

class spell_ioc_bomb_blast_criteria : public SpellScriptLoader
{
    public:
        spell_ioc_bomb_blast_criteria() : SpellScriptLoader("spell_ioc_bomb_blast_criteria") { }

        class spell_ioc_bomb_blast_criteria_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ioc_bomb_blast_criteria_SpellScript);

            void HandleGameObjectDamage(SpellEffIndex  /*effIndex*/)
            {
                Unit* owner = GetCaster()->GetOwner();
                if (!owner)
                    return;

                if (GetSpellInfo()->Id == SPELL_SEAFORIUM_BLAST)
                    owner->CastSpell(owner, SPELL_BOMB_INABLE_CREDIT, true);
                else if (GetSpellInfo()->Id == SPELL_HUGE_SEAFORIUM_BLAST)
                    owner->CastSpell(owner, SPELL_BOMB_INATION_CREDIT, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_ioc_bomb_blast_criteria_SpellScript::HandleGameObjectDamage, EFFECT_1, SPELL_EFFECT_GAMEOBJECT_DAMAGE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ioc_bomb_blast_criteria_SpellScript();
        }
};

class spell_ioc_gunship_portal : public SpellScriptLoader
{
    public:
        spell_ioc_gunship_portal() : SpellScriptLoader("spell_ioc_gunship_portal") { }

        class spell_ioc_gunship_portal_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ioc_gunship_portal_SpellScript);

            bool Load()
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

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_ioc_gunship_portal_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
                OnEffectHitTarget += SpellEffectFn(spell_ioc_gunship_portal_SpellScript::HandleScript2, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ioc_gunship_portal_SpellScript();
        }
};

class spell_ioc_parachute_ic : public SpellScriptLoader
{
    public:
        spell_ioc_parachute_ic() : SpellScriptLoader("spell_ioc_parachute_ic") { }

        class spell_ioc_parachute_ic_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_ioc_parachute_ic_AuraScript)

            void HandleTriggerSpell(AuraEffect const* /*aurEff*/)
            {
                if (Player* target = GetTarget()->ToPlayer())
                    if (target->m_movementInfo.fallTime > 2500 && !target->GetTransport())
                        target->CastSpell(target, SPELL_PARACHUTE_IC, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_ioc_parachute_ic_AuraScript::HandleTriggerSpell, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_ioc_parachute_ic_AuraScript();
        }
};

class spell_ioc_launch : public SpellScriptLoader
{
    public:
        spell_ioc_launch() : SpellScriptLoader("spell_ioc_launch") { }

        class spell_ioc_launch_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ioc_launch_SpellScript);

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
                    float speedZ = std::max(10.0f, float(50.0f * sin(elevation)));
                    float speedXY = dist * 10.0f / speedZ;

                    player->GetMotionMaster()->MoveJump(position->GetPositionX(), position->GetPositionY(), position->GetPositionZ(), speedXY, speedZ);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_ioc_launch_SpellScript::HandleScript, EFFECT_1, SPELL_EFFECT_FORCE_CAST);
                AfterHit += SpellHitFn(spell_ioc_launch_SpellScript::Launch);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ioc_launch_SpellScript();
        }
};

void AddSC_isle_of_conquest()
{
    new npc_isle_of_conquest_turret();
    new npc_four_car_garage();
    new npc_ioc_gunship_captain();
    new boss_isle_of_conquest();
    new spell_ioc_repair_turret();
    new spell_ioc_bomb_blast_criteria();
    new spell_ioc_gunship_portal();
    new spell_ioc_parachute_ic();
    new spell_ioc_launch();
}
