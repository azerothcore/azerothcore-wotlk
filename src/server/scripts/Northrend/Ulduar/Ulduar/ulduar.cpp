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

#include "AreaTriggerScript.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "PassiveAI.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "Vehicle.h"
#include "ulduar.h"

enum Texts
{
    // Freya
    GOSSIP_MENU_FREYA           = 10324,
    NPC_TEXT_FREYA              = 14332,

    // Hodir
    GOSSIP_MENU_HODIR           = 10335,
    NPC_TEXT_HODIR              = 14326,

    // Mimiron
    GOSSIP_MENU_MIMIRON         = 10336,
    NPC_TEXT_MIMIRON            = 14334,

    // Thorim
    GOSSIP_MENU_THORIM          = 10337,
    NPC_TEXT_THORIM             = 14333,

    // Confirm assistance
    GOSSIP_MENU_CONFIRM         = 10333,
    NPC_TEXT_CONFIRM            = 14325,

    // Chosen
    SAY_KEEPER_CHOSEN_TO_PLAYER = 0,
    SAY_KEEPER_CHOSEN_ANNOUNCE  = 1,
};

enum UldActions
{
    ACTION_KEEPER_OUTRO         = 0,
};

enum UldNPCs
{
    NPC_WINTER_JORMUNGAR        = 34137,
    NPC_SNOW_MOUND_4            = 34146,
    NPC_SNOW_MOUND_6            = 34150,
    NPC_SNOW_MOUND_8            = 34151
};

enum UldGameObjects
{
    GOBJ_SNOW_MOUND             = 194907
};

enum UldSpells
{
    SPELL_SIMPLE_TELEPORT       = 12980,
    SPELL_KEEPER_TELEPORT       = 62940,
    SPELL_SNOW_MOUND_PARTICLES  = 64615,
    SPELL_ENERGY_SAP_10         = 64740
};

class npc_ulduar_keeper : public CreatureScript
{
public:
    npc_ulduar_keeper() : CreatureScript("npc_ulduar_keeper_gossip") { }

    struct npc_ulduar_keeperAI : public NullCreatureAI
    {
        npc_ulduar_keeperAI(Creature* creature) : NullCreatureAI(creature) { }

        void Reset() override
        {
            scheduler.Schedule(250ms, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_SIMPLE_TELEPORT);
            });
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_KEEPER_OUTRO)
            {
                switch (me->GetEntry())
                {
                    case NPC_FREYA_GOSSIP:
                        _keeper = KEEPER_FREYA;
                        break;
                    case NPC_HODIR_GOSSIP:
                        _keeper = KEEPER_HODIR;
                        break;
                    case NPC_MIMIRON_GOSSIP:
                        _keeper = KEEPER_MIMIRON;
                        break;
                    case NPC_THORIM_GOSSIP:
                        _keeper = KEEPER_THORIM;
                        break;
                    default:
                        return;
                }
                scheduler.Schedule(1s, [this](TaskContext /*context*/)
                {
                    DoCastSelf(SPELL_KEEPER_TELEPORT);
                });
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_TELEPORT)
            {
                me->DespawnOrUnsummon();
                me->GetInstanceScript()->SetData(TYPE_WATCHERS, _keeper);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            scheduler.Update(diff);
        }
    private:
        uint8 _keeper;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUlduarAI<npc_ulduar_keeperAI>(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        uint32 gossipMenuId = 0;
        uint32 gossipTextId = 0;
        switch (creature->GetEntry())
        {
            case NPC_FREYA_GOSSIP:
                gossipMenuId = GOSSIP_MENU_FREYA;
                gossipTextId = NPC_TEXT_FREYA;
                break;
            case NPC_HODIR_GOSSIP:
                gossipMenuId = GOSSIP_MENU_HODIR;
                gossipTextId = NPC_TEXT_HODIR;
                break;
            case NPC_MIMIRON_GOSSIP:
                gossipMenuId = GOSSIP_MENU_MIMIRON;
                gossipTextId = NPC_TEXT_MIMIRON;
                break;
            case NPC_THORIM_GOSSIP:
                gossipMenuId = GOSSIP_MENU_THORIM;
                gossipTextId = NPC_TEXT_THORIM;
                break;
        }

        AddGossipItemFor(player, gossipMenuId, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        SendGossipMenuFor(player, gossipTextId, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, GOSSIP_MENU_CONFIRM, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, NPC_TEXT_CONFIRM, creature);
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
            {
                creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                CloseGossipMenuFor(player);

                creature->AI()->Talk(SAY_KEEPER_CHOSEN_TO_PLAYER, player);
                creature->AI()->Talk(SAY_KEEPER_CHOSEN_ANNOUNCE);
                creature->AI()->DoAction(ACTION_KEEPER_OUTRO);
            }
        }
        return true;
    }
};

enum EnergySap
{
    SPELL_ENERGY_SAP_DAMAGE_1 = 64747,
    SPELL_ENERGY_SAP_DAMAGE_2 = 64863,
};

class spell_ulduar_energy_sap_aura : public AuraScript
{
    PrepareAuraScript(spell_ulduar_energy_sap_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ENERGY_SAP_DAMAGE_1, SPELL_ENERGY_SAP_DAMAGE_2 });
    }

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        if (Unit* target = GetTarget())
            target->CastSpell(target, (aurEff->GetId() == SPELL_ENERGY_SAP_10) ? SPELL_ENERGY_SAP_DAMAGE_1 : SPELL_ENERGY_SAP_DAMAGE_2, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_ulduar_energy_sap_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

struct npc_ulduar_snow_mound : public ScriptedAI
{
    npc_ulduar_snow_mound(Creature* creature) : ScriptedAI(creature)
    {
        _activated = false;
        _count = 0;
        _counter = 0;
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_activated && who->GetTypeId() == TYPEID_PLAYER)
        {
            if (me->GetExactDist2d(who) <= 10.0f && me->GetMap()->isInLineOfSight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 5.0f,
                who->GetPositionX(), who->GetPositionY(), who->GetPositionZ() + 5.0f, 2, LINEOFSIGHT_ALL_CHECKS, VMAP::ModelIgnoreFlags::Nothing))
            {
                _activated = true;
                me->RemoveAura(SPELL_SNOW_MOUND_PARTICLES);
                if (GameObject* go = me->FindNearestGameObject(GOBJ_SNOW_MOUND, 5.0f))
                {
                    go->Delete();
                }

                switch (me->GetEntry())
                {
                    case NPC_SNOW_MOUND_4:
                        _count = 4;
                        break;
                    case NPC_SNOW_MOUND_6:
                        _count = 6;
                        break;
                    case NPC_SNOW_MOUND_8:
                        _count = 8;
                        break;
                    default:
                        return;
                }

                _scheduler.Schedule(0s, [this](TaskContext context)
                {
                    _counter++;
                    float a = rand_norm() * 2 * M_PI; //needs verification from sniffs
                    float d = rand_norm() * 4.0f;
                    if (Creature* jormungar = me->SummonCreature(NPC_WINTER_JORMUNGAR, me->GetPositionX() + cos(a) * d, me->GetPositionY() + std::sin(a) * d, me->GetPositionZ() + 1.0f, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 300000))
                    {
                        jormungar->SetInCombatWithZone();
                    }
                    if (_counter < _count)
                    {
                        context.Repeat(2s);
                    }
                });
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

private:
    bool _activated;
    TaskScheduler _scheduler;
    uint8 _count;
    uint8 _counter;
};

class npc_ulduar_storm_tempered_keeper : public CreatureScript
{
public:
    npc_ulduar_storm_tempered_keeper() : CreatureScript("npc_ulduar_storm_tempered_keeper") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUlduarAI<npc_ulduar_storm_tempered_keeperAI>(creature);
    }

    struct npc_ulduar_storm_tempered_keeperAI : public ScriptedAI
    {
        npc_ulduar_storm_tempered_keeperAI(Creature* creature) : ScriptedAI(creature)
        {
            otherGUID.Clear();
        }

        EventMap events;
        ObjectGuid otherGUID;

        void Reset() override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            events.Reset();
            events.ScheduleEvent(1, 2s); // checking Separation Anxiety, Charged Sphere
            events.ScheduleEvent(2, 5s, 8s); // Forked Lightning
            events.ScheduleEvent(3, (me->GetEntry() == 33722 ? 20s : 50s)); // Summon Charged Sphere
            if (Creature* c = me->FindNearestCreature((me->GetEntry() == 33722 ? 33699 : 33722), 30.0f, true))
                otherGUID = c->GetGUID();
            else
                me->CastSpell(me, 63630, true); // Vengeful Surge
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Creature* c = ObjectAccessor::GetCreature(*me, otherGUID))
                c->CastSpell(c, 63630, true); // Vengeful Surge
        }

        void JustSummoned(Creature* s) override
        {
            if (Creature* c = ObjectAccessor::GetCreature(*me, otherGUID))
                s->GetMotionMaster()->MoveFollow(c, 0.0f, 0.0f);
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
                case 0:
                    break;
                case 1:
                    if (Creature* c = ObjectAccessor::GetCreature(*me, otherGUID))
                        if (c->IsAlive() && me->GetExactDist2d(c) > 45.0f)
                            me->CastSpell(me, 63539, true);
                    if (Creature* c = me->FindNearestCreature(33715, 2.0f, true))
                        if (c->IsSummon())
                            if (c->ToTempSummon()->GetSummonerGUID() != me->GetGUID())
                                me->CastSpell(me, 63528, true);
                    events.Repeat(2s);
                    break;
                case 2:
                    me->CastSpell(me->GetVictim(), 63541, false);
                    events.Repeat(10s, 14s);
                    break;
                case 3:
                    if (!me->HasAura(63630))
                        me->CastSpell(me, 63527, false);
                    events.Repeat(1min);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_ulduar_arachnopod_destroyer : public CreatureScript
{
public:
    npc_ulduar_arachnopod_destroyer() : CreatureScript("npc_ulduar_arachnopod_destroyer") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUlduarAI<npc_ulduar_arachnopod_destroyerAI>(creature);
    }

    struct npc_ulduar_arachnopod_destroyerAI : public ScriptedAI
    {
        npc_ulduar_arachnopod_destroyerAI(Creature* creature) : ScriptedAI(creature)
        {
            _spawnedMechanic = false;
            me->ApplySpellImmune(0, IMMUNITY_ID, 64919, true); // Ice Nova from Ice Turret
        }

        EventMap events;
        bool _spawnedMechanic;

        void Reset() override
        {
            events.Reset();
            events.ScheduleEvent(1, 5s, 8s); // Flame Spray
            events.ScheduleEvent(2, 3s, 6s); // Machine Gun
            events.ScheduleEvent(3, 1s); // Charged Leap
        }

        void PassengerBoarded(Unit* p, int8  /*seat*/, bool  /*apply*/) override
        {
            me->SetFaction(p->GetFaction());
            me->SetReactState(REACT_PASSIVE);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!_spawnedMechanic && me->HealthBelowPctDamaged(20, damage))
            {
                _spawnedMechanic = true;
                if (Creature* c = me->SummonCreature(34184, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN, 0))
                    c->AI()->AttackStart(me->GetVictim());
                me->InterruptNonMeleeSpells(false);
                me->CombatStop(true);
                me->SetReactState(REACT_PASSIVE);
                me->SetRegeneratingHealth(false);
                me->SetFaction(FACTION_PREY);
                me->SetNpcFlag(UNIT_NPC_FLAG_SPELLCLICK);
                me->CastSpell(me, 64770, true);
            }
        }

        void AttackStart(Unit* who) override
        {
            if (me->GetFaction() == FACTION_MONSTER_2)
                ScriptedAI::AttackStart(who);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (me->GetFaction() == FACTION_MONSTER_2)
                ScriptedAI::EnterEvadeMode(why);
        }

        void OnCharmed(bool  /*apply*/) override {}

        void UpdateAI(uint32 diff) override
        {
            if (me->GetFaction() != FACTION_MONSTER_2)
            {
                if (me->IsAlive() && (me->GetExactDist2dSq(2058.0f, 42.0f) < 25.0f * 25.0f || me->GetExactDist2dSq(2203.0f, 292.0f) < 25.0f * 25.0f || me->GetExactDist2dSq(2125.0f, 170.0f) > 160.0f * 160.0f))
                    Unit::Kill(me, me, false);
            }
            else
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case 0:
                        break;
                    case 1:
                        me->CastSpell(me->GetVictim(), RAID_MODE(64717, 65241), false);
                        events.Repeat(15s, 25s);
                        break;
                    case 2:
                        me->CastSpell(me->GetVictim(), RAID_MODE(64776, 65240), false);
                        events.Repeat(10s, 15s);
                        break;
                    case 3:
                        {
                            float dist = me->GetDistance(me->GetVictim());
                            if (dist > 10.0f && dist < 40.0f)
                            {
                                me->CastSpell(me->GetVictim(), 64779, false);
                                events.Repeat(25s);
                            }
                            else
                                events.Repeat(3s);
                        }
                        break;
                }

                DoMeleeAttackIfReady();
            }
        }
    };
};

class spell_ulduar_arachnopod_damaged_aura : public AuraScript
{
    PrepareAuraScript(spell_ulduar_arachnopod_damaged_aura);

    void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
    {
        if (Unit* caster = GetCaster())
            Unit::Kill(caster, caster, false);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_ulduar_arachnopod_damaged_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class AreaTrigger_at_celestial_planetarium_enterance : public AreaTriggerScript
{
public:
    AreaTrigger_at_celestial_planetarium_enterance()
        : AreaTriggerScript("at_celestial_planetarium_enterance")
    {
    }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (player->IsAlive())
            if (uint32 questId = (player->GetMap()->Is25ManRaid() ? 13816 : 13607 /*QUEST_CELESTIAL_PLANETARIUM*/))
                if (player->GetQuestStatus(questId) == QUEST_STATUS_INCOMPLETE)
                    player->AreaExploredOrEventHappens(questId);
        return false;
    }
};

struct npc_salvaged_siege_engine : public VehicleAI
{
    npc_salvaged_siege_engine(Creature* creature) : VehicleAI(creature) { }

    bool BeforeSpellClick(Unit* clicker) override
    {
        if (Vehicle* vehicle = me->GetVehicleKit())
        {
            if (vehicle->IsVehicleInUse())
            {
                if (Unit* turret = vehicle->GetPassenger(7))
                {
                    if (Vehicle* turretVehicle = me->GetVehicleKit())
                    {
                        if (!turretVehicle->IsVehicleInUse())
                        {
                            turret->HandleSpellClick(clicker);
                            return false;
                        }
                    }
                }
            }
        }

        return true;
    }
};

void AddSC_ulduar()
{
    new npc_ulduar_keeper();
    RegisterSpellScript(spell_ulduar_energy_sap_aura);
    RegisterUlduarCreatureAI(npc_ulduar_snow_mound);
    new npc_ulduar_storm_tempered_keeper();
    new npc_ulduar_arachnopod_destroyer();
    RegisterSpellScript(spell_ulduar_arachnopod_damaged_aura);
    new AreaTrigger_at_celestial_planetarium_enterance();
    RegisterCreatureAI(npc_salvaged_siege_engine);
}
