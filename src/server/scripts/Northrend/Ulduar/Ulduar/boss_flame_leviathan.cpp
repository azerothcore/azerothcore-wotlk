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

#include "boss_flame_leviathan.h"
#include "AchievementCriteriaScript.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "GridNotifiers.h"
#include "Opcodes.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "ulduar.h"

void boss_flame_leviathan::boss_flame_leviathanAI::BindPlayers()
{
    me->GetMap()->ToInstanceMap()->PermBindAllPlayers();
}

void boss_flame_leviathan::boss_flame_leviathanAI::RadioSay(uint8 textid)
{
    if (Creature* r = me->SummonCreature(NPC_BRANN_RADIO, me->GetPositionX() - 150, me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 5000))
    {
        r->AI()->Talk(textid);
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::ActivateTowers()
{
    _towersCount = 0;
    me->ResetLootMode();
    for (uint32 i = EVENT_TOWER_OF_LIFE_DESTROYED; i <= EVENT_TOWER_OF_FLAMES_DESTROYED; ++i)
    {
        if (m_pInstance->GetData(i))
        {
            ++_towersCount;

            me->AddLootMode(1 << _towersCount);
            switch (i)
            {
                case EVENT_TOWER_OF_LIFE_DESTROYED:
                    me->AddAura(SPELL_TOWER_OF_LIFE, me);
                    events.RescheduleEvent(EVENT_FREYA, 30s);
                    break;
                case EVENT_TOWER_OF_STORM_DESTROYED:
                    me->AddAura(SPELL_TOWER_OF_STORMS, me);
                    events.RescheduleEvent(EVENT_THORIMS_HAMMER, 1min);
                    break;
                case EVENT_TOWER_OF_FROST_DESTROYED:
                    me->AddAura(SPELL_TOWER_OF_FROST, me);
                    events.RescheduleEvent(EVENT_HODIRS_FURY, 20s);
                    break;
                case EVENT_TOWER_OF_FLAMES_DESTROYED:
                    me->AddAura(SPELL_TOWER_OF_FLAMES, me);
                    events.RescheduleEvent(EVENT_MIMIRONS_INFERNO, 42s);
                    break;
            }
        }
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::TurnGates(bool _start, bool _death)
{
    if (!m_pInstance)
        return;

    if (_start)
    {
        // first one is ALWAYS turned on, unless leviathan is beaten
        GameObject* go = nullptr;
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_LIGHTNING_WALL2))))
            go->SetGoState(GO_STATE_READY);

        if (m_pInstance->GetData(TYPE_LEVIATHAN) == NOT_STARTED)
            if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(GO_LEVIATHAN_DOORS))))
                go->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
    }
    else
    {
        GameObject* go = nullptr;
        if (_death)
            if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_LIGHTNING_WALL1))))
                go->SetGoState(GO_STATE_ACTIVE);

        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_LIGHTNING_WALL2))))
            go->SetGoState(GO_STATE_ACTIVE);

        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(GO_LEVIATHAN_DOORS))))
        {
            if (m_pInstance->GetData(TYPE_LEVIATHAN) == SPECIAL || m_pInstance->GetData(TYPE_LEVIATHAN) == DONE)
                go->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
            else
                go->SetGoState(GO_STATE_READY);
        }
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::TurnHealStations(bool _apply)
{
    if (!m_pInstance)
        return;

    GameObject* go = nullptr;
    if (_apply)
    {
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_REPAIR_STATION1))))
            go->SetLootState(GO_READY);
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_REPAIR_STATION2))))
            go->SetLootState(GO_READY);
    }
    else
    {
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_REPAIR_STATION1))))
            go->SetLootState(GO_ACTIVATED);
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_REPAIR_STATION2))))
            go->SetLootState(GO_ACTIVATED);
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::ScheduleEvents()
{
    events.RescheduleEvent(EVENT_MISSILE, 5s);
    events.RescheduleEvent(EVENT_VENT, 20s);
    events.RescheduleEvent(EVENT_SPEED, 15s);
    events.RescheduleEvent(EVENT_SUMMON, 10s);
    events.RescheduleEvent(EVENT_SOUND_BEGINNING, 10s);
    events.RescheduleEvent(EVENT_POSITION_CHECK, 5s);

    events.RescheduleEvent(EVENT_PURSUE, 0ms);
}

void boss_flame_leviathan::boss_flame_leviathanAI::SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo)
{
    if (spellInfo->Id == SPELL_SYSTEMS_SHUTDOWN)
    {
        _shutdown = true; // ACHIEVEMENT

        Talk(FLAME_LEVIATHAN_EMOTE_OVERLOAD);
        Talk(FLAME_LEVIATHAN_EMOTE_REPAIR);
        Talk(FLAME_LEVIATHAN_SAY_OVERLOAD);

        events.DelayEvents(21ms);
        events.ScheduleEvent(EVENT_REINSTALL, 20ms);
    }
    else if (spellInfo->Id == 62522 /*SPELL_ELECTROSHOCK*/)
        me->InterruptNonMeleeSpells(false);
}

void boss_flame_leviathan::boss_flame_leviathanAI::JustDied(Unit*)
{
    // Despawn Lashers, do before summons clear
    summons.DoAction(ACTION_DESPAWN_ADDS);
    summons.DespawnAll();

    if (m_pInstance)
    {
        m_pInstance->SetData(TYPE_LEVIATHAN, DONE);
        m_pInstance->SetData(DATA_VEHICLE_SPAWN, VEHICLE_POS_NONE);
    }

    Talk(FLAME_LEVIATHAN_SAY_DEATH);

    TurnGates(false, true);
    BindPlayers();
}

void boss_flame_leviathan::boss_flame_leviathanAI::KilledUnit(Unit* who)
{
    if (who == me->GetVictim())
        events.RescheduleEvent(EVENT_PURSUE, 0ms);

    if (who->GetTypeId() == TYPEID_PLAYER)
        Talk(FLAME_LEVIATHAN_SAY_SLAY);
}

void boss_flame_leviathan::boss_flame_leviathanAI::SummonTowerHelpers(uint8 towerId)
{
    if (towerId == TOWER_OF_LIFE)
    {
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 374, -141, 411, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 374, -141, 411 + 40, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 382.9f, 74, 411.6f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 382.9f, 74, 411.6f + 40, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 159.4f, 64.1f, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 159.4f, 64.1f, 409.8f + 40, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 157.7f, -140.26f, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 157.7f, -140.26f, 409.8f + 40, 0, TEMPSUMMON_MANUAL_DESPAWN);
    }
    else if (towerId == TOWER_OF_FROST)
    {
        me->SummonCreature(NPC_HODIRS_FURY_TARGET, 343.4f, -77.5f, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_HODIRS_FURY_TARGET, 222, 41, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
    }
    else if (towerId == TOWER_OF_FLAMES)
    {
        me->SummonCreature(NPC_MIMIRONS_INFERNO_TARGET, 364.4f, -9.7f, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        //me->SummonCreature(NPC_MIMIRONS_INFERNO, 364.4f, -9.7f, 409.8f+40, 0, TEMPSUMMON_MANUAL_DESPAWN);
    }
    else if (towerId == TOWER_OF_STORMS)
    {
        for (uint8 i = 0; i < 8; ++i)
            me->SummonCreature(NPC_THORIM_HAMMER_TARGET, 157 + rand() % 200, -140 + rand() % 200, 409.8f, 0, TEMPSUMMON_TIMED_DESPAWN, 24000);
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::SpellHitTarget(Unit* target, SpellInfo const* spell)
{
    if (spell->Id != SPELL_PURSUED)
        return;

    for (SeatMap::const_iterator itr = target->GetVehicleKit()->Seats.begin(); itr != target->GetVehicleKit()->Seats.end(); ++itr)
    {
        if (Player* passenger = ObjectAccessor::GetPlayer(*me, itr->second.Passenger.Guid))
        {
            Talk(FLAME_LEVIATHAN_EMOTE_PURSUE, passenger);
            return;
        }
    }
}

void AddSC_boss_flame_leviathan()
{
    new boss_flame_leviathan();
    new boss_flame_leviathan_seat();
    new boss_flame_leviathan_defense_turret();
    new boss_flame_leviathan_overload_device();
    new npc_pool_of_tar();

    // Hard Mode
    new npc_freya_ward();
    new npc_thorims_hammer();
    new npc_mimirons_inferno();
    new npc_hodirs_fury();

    // Helpers
    new npc_brann_radio();
    new npc_storm_beacon_spawn();
    new boss_flame_leviathan_safety_container();
    new npc_mechanolift();

    // GOs
    new go_ulduar_tower();

    // Spells
    new spell_load_into_catapult();
    new spell_auto_repair();
    new spell_systems_shutdown();
    new spell_pursue();
    new spell_vehicle_throw_passenger();
    new spell_tar_blaze();
    new spell_vehicle_grab_pyrite();
    new spell_vehicle_circuit_overload();
    new spell_orbital_supports();
    new spell_thorims_hammer();
    new spell_transitus_shield_beam();
    new spell_shield_generator();
    new spell_demolisher_ride_vehicle();

    // Achievements
    new achievement_flame_leviathan_towers("achievement_flame_leviathan_orbital_bombardment", 1);
    new achievement_flame_leviathan_towers("achievement_flame_leviathan_orbital_devastation", 2);
    new achievement_flame_leviathan_towers("achievement_flame_leviathan_nuked_from_orbit", 3);
    new achievement_flame_leviathan_towers("achievement_flame_leviathan_orbituary", 4);
    new achievement_flame_leviathan_shutout();
    new achievement_flame_leviathan_garage("achievement_flame_leviathan_garage_chopper", NPC_VEHICLE_CHOPPER, 0);
    new achievement_flame_leviathan_garage("achievement_flame_leviathan_garage_siege_engine", NPC_SALVAGED_SIEGE_ENGINE, NPC_SALVAGED_SIEGE_ENGINE_TURRET);
    new achievement_flame_leviathan_garage("achievement_flame_leviathan_garage_demolisher", NPC_SALVAGED_DEMOLISHER, NPC_SALVAGED_DEMOLISHER_TURRET);
    new achievement_flame_leviathan_unbroken();
}
