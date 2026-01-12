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

#include "AreaDefines.h"
#include "CellImpl.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "Duration.h"
#include "GameEventMgr.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "GridNotifiersImpl.h"
#include "Object.h"
#include "ObjectDefines.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Unit.h"
#include "Weather.h"
#include "WeatherMgr.h"
#include "WorldState.h"
#include "scourge_invasion.h"
#include <chrono>

class go_necropolis : public GameObjectAI
{
public:
    go_necropolis(GameObject* gameobject) : GameObjectAI(gameobject)
    {
        me->setActive(true);
    }
};

struct npc_herald_of_the_lich_king : public ScriptedAI
{
    npc_herald_of_the_lich_king(Creature* creature) : ScriptedAI(creature)
    {
        me->SetReactState(REACT_PASSIVE);
    }

    void InitializeAI() override
    {
        //m_go->SetVisibilityModifier(3000.0f);
        me->setActive(true);
        ScheduleTimedEvent(5s, [&]() { Talk(HERALD_OF_THE_LICH_KING_SAY_ATTACK_RANDOM); }, 150ms, 1h);
    }

    void UpdateWeather(bool startEvent)
    {
        Weather* weather = me->GetMap()->GetOrGenerateZoneDefaultWeather(me->GetZoneId());
        if (weather)
        {
            if (startEvent)
                weather->SetWeather(WEATHER_TYPE_STORM, 0.25f);
            else
                weather->SetWeather(WEATHER_TYPE_RAIN, 0.0f);
        }
    }

    void DoAction(int32 action) override
    {
        if (action == EVENT_HERALD_OF_THE_LICH_KING_ZONE_START)
        {
            Talk(HERALD_OF_THE_LICH_KING_SAY_ATTACK_START);
            ChangeZoneEventStatus(true);
            UpdateWeather(true);
        }
        else if (action == EVENT_HERALD_OF_THE_LICH_KING_ZONE_STOP)
        {
            Talk(HERALD_OF_THE_LICH_KING_SAY_ATTACK_END);
            ChangeZoneEventStatus(false);
            UpdateWeather(false);
            me->DespawnOrUnsummon();
        }
    }

    void ChangeZoneEventStatus(bool startEvent)
    {
        switch (me->GetZoneId())
        {
            case AREA_WINTERSPRING:
                if (startEvent)
                {
                    if (!sGameEventMgr->IsActiveEvent(GAME_EVENT_SCOURGE_INVASION_WINTERSPRING))
                        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_WINTERSPRING, true);
                }
                else
                    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_WINTERSPRING, true);
                break;
            case AREA_TANARIS:
                if (startEvent)
                {
                    if (!sGameEventMgr->IsActiveEvent(GAME_EVENT_SCOURGE_INVASION_TANARIS))
                        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_TANARIS, true);
                }
                else
                    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_TANARIS, true);
                break;
            case AREA_AZSHARA:
                if (startEvent)
                {
                    if (!sGameEventMgr->IsActiveEvent(GAME_EVENT_SCOURGE_INVASION_AZSHARA))
                        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_AZSHARA, true);
                }
                else
                    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_AZSHARA, true);
                break;
            case AREA_BLASTED_LANDS:
                if (startEvent)
                {
                    if (!sGameEventMgr->IsActiveEvent(GAME_EVENT_SCOURGE_INVASION_BLASTED_LANDS))
                        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_BLASTED_LANDS, true);
                }
                else
                    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_BLASTED_LANDS, true);
                break;
            case AREA_EASTERN_PLAGUELANDS:
                if (startEvent)
                {
                    if (!sGameEventMgr->IsActiveEvent(GAME_EVENT_SCOURGE_INVASION_EASTERN_PLAGUELANDS))
                        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_EASTERN_PLAGUELANDS, true);
                }
                else
                    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_EASTERN_PLAGUELANDS, true);
                break;
            case AREA_BURNING_STEPPES:
                if (startEvent)
                {
                    if (!sGameEventMgr->IsActiveEvent(GAME_EVENT_SCOURGE_INVASION_BURNING_STEPPES))
                        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_BURNING_STEPPES, true);
                }
                else
                    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_BURNING_STEPPES, true);
                break;
            default:
                break;
        }

        sWorldState->Save(SAVE_ID_SCOURGE_INVASION);
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }
};

struct npc_necropolis : public ScriptedAI
{
    npc_necropolis(Creature* creature) : ScriptedAI(creature)
    {
        me->setActive(true);
    }

    void SpellHit(Unit* /* caster */, SpellInfo const* spell) override
    {
        if (me->HasAura(SPELL_COMMUNIQUE_TIMER_NECROPOLIS))
            return;

        if (spell->Id == SPELL_COMMUNIQUE_PROXY_TO_NECROPOLIS)
            DoCastSelf(SPELL_COMMUNIQUE_TIMER_NECROPOLIS, true);
    }
};

struct npc_necropolis_health : public ScriptedAI
{
    explicit npc_necropolis_health(Creature* creature) : ScriptedAI(creature)
    {
        me->SetFullHealth(); // RegenHealth is disabled
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH)
            DoCastSelf(SPELL_ZAP_NECROPOLIS, true); // deals damage to self

        // Just to make sure it finally dies!
        if (spell->Id == SPELL_ZAP_NECROPOLIS)
            if (++_zapCount >= 3)
                me->KillSelf();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* necropolis = GetClosestCreatureWithEntry(me, NPC_NECROPOLIS, ATTACK_DISTANCE))
            me->CastSpell(necropolis, SPELL_DESPAWNER_OTHER, true);

        SIRemaining remainingID;

        switch (me->GetZoneId())
        {
            case AREA_TANARIS:
                remainingID = SI_REMAINING_TANARIS;
                break;
            case AREA_BLASTED_LANDS:
                remainingID = SI_REMAINING_BLASTED_LANDS;
                break;
            case AREA_EASTERN_PLAGUELANDS:
                remainingID = SI_REMAINING_EASTERN_PLAGUELANDS;
                break;
            case AREA_BURNING_STEPPES:
                remainingID = SI_REMAINING_BURNING_STEPPES;
                break;
            case AREA_WINTERSPRING:
                remainingID = SI_REMAINING_WINTERSPRING;
                break;
            case AREA_AZSHARA:
                remainingID = SI_REMAINING_AZSHARA;
                break;
            default:
                return;
        }

        uint32 remaining = sWorldState->GetSIRemaining(remainingID);
        if (remaining > 0)
            sWorldState->SetSIRemaining(remainingID, (remaining - 1));
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
    {
        // Make sure necropoli despawn after SPELL_DESPAWNER_OTHER is triggered.
        if (spellInfo->Id == SPELL_DESPAWNER_OTHER && target->GetEntry() == NPC_NECROPOLIS)
        {
            DespawnNecropolis();
            dynamic_cast<Creature*>(target)->DespawnOrUnsummon();
            me->DespawnOrUnsummon();
        }
    }

    void DespawnNecropolis()
    {
        std::list<GameObject*> necropolisList;
        me->GetGameObjectListWithEntryInGrid(
            necropolisList,
            { GO_NECROPOLIS_TINY, GO_NECROPOLIS_SMALL, GO_NECROPOLIS_MEDIUM, GO_NECROPOLIS_BIG, GO_NECROPOLIS_HUGE },
            ATTACK_DISTANCE
        );
        for (GameObject* const& necropolis : necropolisList)
            necropolis->DespawnOrUnsummon();
    }

private:
    int _zapCount = 0; // 3 = death.
};

struct npc_necropolis_proxy : public ScriptedAI
{
    npc_necropolis_proxy(Creature* creature) : ScriptedAI(creature)
    {
        me->setActive(true);
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
    {
        switch (spellInfo->Id)
        {
            case SPELL_COMMUNIQUE_NECROPOLIS_TO_PROXIES:
                DoCastSelf(SPELL_COMMUNIQUE_PROXY_TO_RELAY, true);
                break;
            case SPELL_COMMUNIQUE_RELAY_TO_PROXY:
                DoCastSelf(SPELL_COMMUNIQUE_PROXY_TO_NECROPOLIS, true);
                break;
            case SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH:
                if (Creature* health = GetClosestCreatureWithEntry(me, NPC_NECROPOLIS_HEALTH, 200.0f))
                    me->CastSpell(health, SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH, true);
                break;
            default:
                break;
        }
    }

    void SpellHitTarget(Unit* /*target*/, SpellInfo const* spellInfo) override
    {
        // Make sure me despawn after SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH hits the target to avoid getting hit by Purple bolt again.
        if (spellInfo->Id == SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH)
            me->DespawnOrUnsummon();
    }
};

struct npc_necropolis_relay : public ScriptedAI
{
    npc_necropolis_relay(Creature* creature) : ScriptedAI(creature)
    {
        me->setActive(true);
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        switch (spell->Id)
        {
            case SPELL_COMMUNIQUE_PROXY_TO_RELAY:
                DoCastSelf(SPELL_COMMUNIQUE_RELAY_TO_CAMP, true);
                break;
            case SPELL_COMMUNIQUE_CAMP_TO_RELAY:
                DoCastSelf(SPELL_COMMUNIQUE_RELAY_TO_PROXY, true);
                break;
            case SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH:
                if (Creature* proxy = GetClosestCreatureWithEntry(me, NPC_NECROPOLIS_PROXY, 200.0f))
                    me->CastSpell(proxy, SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH, true);
                break;
            default:
                break;
        }
    }

    void SpellHitTarget(Unit* /*target*/, SpellInfo const* spell) override
    {
        // Make sure `me` despawns after SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH hits the target to avoid getting hit by Purple bolt again.
        if (spell->Id == SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH)
            me->DespawnOrUnsummon();
    }
};

struct npc_necrotic_shard : public ScriptedAI
{
    npc_necrotic_shard(Creature* creature) : ScriptedAI(creature)
    {
        me->setActive(true);
        me->SetReactState(REACT_PASSIVE);
        // No healing possible.
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_HEAL, true);
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_HEAL_PCT, true);
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_HEAL_MAX_HEALTH, true);
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_PERIODIC_HEAL, true);
    }

    void ScheduleMinionSpawnTask()
    {
        scheduler.Schedule(5s, [this](TaskContext context) // Spawn Minions every 5 seconds.
        {
            HandleShardMinionSpawnerSmall();
            context.Repeat(5s);
        });
    }

    // This is a placeholder for SPELL_MINION_SPAWNER_BUTTRESS [27888] which also activates unknown, not sniffable gameobjects
    // and happens every hour if a Damaged Necrotic Shard is active. The Cultists despawning after 1 hour,
    // so this just resets everything and spawn them again and Refill the Health of the Shard.
    void ScheduleCultistSpawnTask()
    {
        scheduler.Schedule(5s, [this](TaskContext context) // Spawn Cultists every 60 minutes.
        {
            DespawnShadowsOfDoom(); // Despawn all remaining Shadows before respawning the Cultists?
            SummonCultists();
            context.Repeat(1h);
        });
    }

    void ScheduleTasks()
    {
        if (me->GetEntry() == NPC_NECROTIC_SHARD)
        {
            // Just in case.
            std::list<Creature*> shardList;
            me->GetCreatureListWithEntryInGrid(
                shardList,
                { NPC_NECROTIC_SHARD, NPC_DAMAGED_NECROTIC_SHARD },
                CONTACT_DISTANCE
            );
            for (Creature* shard : shardList)
                if (shard != me)
                    shard->DespawnOnEvade();

            scheduler.Schedule(10s, [this](const TaskContext& /*context*/) // Check if Doodads are spawned 5 seconds after spawn. If not: spawn them
            {
                std::list<GameObject*> objectList;
                me->GetGameObjectListWithEntryInGrid(
                    objectList,
                    {GO_UNDEAD_FIRE, GO_UNDEAD_FIRE_AURA, GO_SKULLPILE_01, GO_SKULLPILE_02, GO_SKULLPILE_03, GO_SKULLPILE_04},
                    50.0f
                );

                for (GameObject* go : objectList)
                    if (go && !go->isSpawned())
                    {
                        go->SetRespawnTime(0);
                        go->Respawn();
                    }
            });
        }
        else if (me->GetEntry() == NPC_DAMAGED_NECROTIC_SHARD)
        {
            UpdateFindersAmount();
            ScheduleMinionSpawnTask();
            ScheduleCultistSpawnTask();
        }

        ScheduleTimedEvent(25s,
            [&]() -> void // Check if there are a summoning circle, otherwise despawn
        {
            if (!GetClosestGameObjectWithEntry(me, GO_SUMMON_CIRCLE, 2.0f))
            {
                DespawnEventDoodads();
                me->DespawnOrUnsummon();
            }
        }, 60s);
    }

    void Reset() override
    {
        scheduler.CancelAll();
        ScheduleTasks();
    }

    bool HasCampTypeAura()
    {
        return me->HasAnyAuras(SPELL_CAMP_TYPE_GHOST_SKELETON, SPELL_CAMP_TYPE_GHOST_GHOUL, SPELL_CAMP_TYPE_GHOUL_SKELETON);
    };

    void SpellHit(Unit* caster, SpellInfo const* spell) override
    {
        switch (spell->Id)
        {
            case SPELL_ZAP_CRYSTAL_CORPSE:
            {
                Creature::DealDamage(me, me, (me->GetMaxHealth() / 4), nullptr, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, nullptr, false);
                _zapCount++;
                if (_zapCount >= 4)
                    me->KillSelf();
                break;
            }
            case SPELL_COMMUNIQUE_RELAY_TO_CAMP:
            {
                me->CastSpell(static_cast<Unit*>(nullptr), SPELL_CAMP_RECEIVES_COMMUNIQUE, true);
                break;
            }
            case SPELL_CHOOSE_CAMP_TYPE:
            {
                _spellCampType = RAND(SPELL_CAMP_TYPE_GHOUL_SKELETON, SPELL_CAMP_TYPE_GHOST_GHOUL, SPELL_CAMP_TYPE_GHOST_SKELETON);
                DoCastSelf(_spellCampType, true);
                break;
            }
            case SPELL_CAMP_RECEIVES_COMMUNIQUE:
            {
                if (!HasCampTypeAura() && me->GetEntry() == NPC_NECROTIC_SHARD)
                {
                    UpdateFindersAmount();
                    DoCastSelf(SPELL_CHOOSE_CAMP_TYPE, true);
                    ScheduleMinionSpawnTask();
                }
                break;
            }
            case SPELL_FIND_CAMP_TYPE:
            {
                // Don't spawn more Minions than finders.
                if (_nearbyFinderCount < HasMinion(me, 60.0f))
                    return;

                static constexpr std::pair<uint32, uint32> auraSpellMap[] = {
                    {SPELL_CAMP_TYPE_GHOST_SKELETON, SPELL_PH_SUMMON_MINION_TRAP_GHOST_SKELETON},
                    {SPELL_CAMP_TYPE_GHOST_GHOUL,    SPELL_PH_SUMMON_MINION_TRAP_GHOST_GHOUL   },
                    {SPELL_CAMP_TYPE_GHOUL_SKELETON, SPELL_PH_SUMMON_MINION_TRAP_GHOUL_SKELETON}
                };

                for (auto const& [aura, spell] : auraSpellMap)
                    if (me->HasAura(aura))
                    {
                        caster->CastSpell(caster, spell, true);
                        break;
                    }
                break;
            }
            default:
                break;
        }
    }

    void SpellHitTarget(Unit* /*target*/, SpellInfo const* spellInfo) override
    {
        if (me->GetEntry() != NPC_DAMAGED_NECROTIC_SHARD)
            return;

        if (spellInfo->Id == SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH)
            me->DespawnOrUnsummon();
    }

    // Only Minions and the shard itself can deal damage.
    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (attacker && attacker->GetFactionTemplateEntry() != me->GetFactionTemplateEntry())
            damage = 0;
    }

    void JustDied(Unit* /*killer*/) override
    {
        switch (me->GetEntry())
        {
            case NPC_NECROTIC_SHARD:
                if (Creature* shard = me->SummonCreature(NPC_DAMAGED_NECROTIC_SHARD, me->GetPosition(), TEMPSUMMON_MANUAL_DESPAWN))
                {
                    uint32 spellId = _spellCampType ? _spellCampType : static_cast<uint32>(SPELL_CHOOSE_CAMP_TYPE);
                    shard->CastSpell(shard, spellId, true);
                    me->DespawnOrUnsummon();
                }
                break;
            case NPC_DAMAGED_NECROTIC_SHARD:
                // Buff Players.
                DoCastSelf(SPELL_SOUL_REVIVAL, true);
                // Sending the Death Bolt.
                if (Creature* relay = GetClosestCreatureWithEntry(me, NPC_NECROPOLIS_RELAY, 200.0f))
                    me->CastSpell(relay, SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH, true);
                DespawnCultists(); // Despawn remaining Cultists (should never happen).
                DespawnEventDoodads();
                sWorldState->Save(SAVE_ID_SCOURGE_INVASION);
                break;
            default:
                break;
        }
    }

    // This is a placeholder for SPELL_MINION_SPAWNER_SMALL [27887] which also activates unknown, not sniffable objects, which possibly checks whether a minion is in his range
    // and happens every 15 seconds for both, Necrotic Shard and Damaged Necrotic Shard.
    void HandleShardMinionSpawnerSmall()
    {
        uint32 spawnLimit = urand(1, 3); // Up to 3 spawns.
        uint32 spawned = 0;

        std::list<Creature*> finderList;
        GetCreatureListWithEntryInGrid(finderList, me, NPC_SCOURGE_INVASION_MINION_FINDER, 60.0f);
        if (finderList.empty())
            return;

        // On a fresh camp, first the minions are spawned close to the shard and then further and further out.
        finderList.sort(Acore::ObjectDistanceOrderPred(me));

        for (Creature* const& finder : finderList)
        {
            // Stop summoning Minions if we reached the max spawn amount.
            if (spawned == spawnLimit)
                break;

            // Skip dead finders.
            if (!finder->IsAlive())
                continue;

            // Don't take finders with Minions.
            if (HasMinion(finder))
                continue;

            // A finder disappears after summoning the spawner NPC (which summons the minion).
            // after 160-185 seconds a finder respawns on the same position as before.
            if (finder->CastSpell(me, SPELL_FIND_CAMP_TYPE, true) == SPELL_CAST_OK)
            {
                // Values are from Sniffs (rounded). Shortest and Longest respawn time from a finder on the same spot.
                finder->DespawnOrUnsummon(0s, randtime(150s, 200s)); // Delayed despawn to prevent stacked spawns
                spawned++;
            }
        }
    }

    // Respawn the Cultists.
    void SummonCultists()
    {
        std::list<GameObject*> summonerShieldList;
        me->GetGameObjectListWithEntryInGrid(summonerShieldList, GO_SUMMONER_SHIELD, INSPECT_DISTANCE);
        for (GameObject* const& summonerShield : summonerShieldList)
            summonerShield->DespawnOrUnsummon();

        // We don't have all positions sniffed from the Cultists, so why not using this code which placing them almost perfectly into the circle while B's positions are sometimes way off?
        if (GameObject* go = GetClosestGameObjectWithEntry(me, GO_SUMMON_CIRCLE, CONTACT_DISTANCE))
        {
            for (int i = 0; i < 4; ++i)
            {
                float angle = (float(i) * (M_PI / 2.f)) + go->GetOrientation();
                float x = go->GetPositionX() + 6.95f * std::cos(angle);
                float y = go->GetPositionY() + 6.75f * std::sin(angle);
                float z = go->GetPositionZ() + 5.0f;
                me->UpdateGroundPositionZ(x, y, z);
                me->SummonCreature(NPC_CULTIST_ENGINEER, x, y, z, angle - M_PI, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, IN_MILLISECONDS * HOUR);
            }
        }
    }

    static uint32 HasMinion(Unit* searcher, float searchDistance = ATTACK_DISTANCE)
    {
        uint32 minionCounter = 0;
        std::list<Creature*> minionList;

        searcher->GetCreatureListWithEntryInGrid(
            minionList,
            { NPC_SKELETAL_SHOCKTROOPER, NPC_GHOUL_BERSERKER, NPC_SPECTRAL_SOLDIER, NPC_LUMBERING_HORROR, NPC_BONE_WITCH, NPC_SPIRIT_OF_THE_DAMNED },
            searchDistance
        );
        for (Creature const* minion : minionList)
            if (minion && minion->IsAlive())
                minionCounter++;

        return minionCounter;
    }

    // Count all finders to limit Minions spawns.
    void UpdateFindersAmount()
    {
        _nearbyFinderCount = 0;
        std::list<Creature*> finderList;
        me->GetCreatureListWithEntryInGrid(finderList, NPC_SCOURGE_INVASION_MINION_FINDER, 60.0f);
        for (Creature const* finder : finderList)
            if (finder)
                _nearbyFinderCount++;
    }

    void DespawnCultists()
    {
        std::list<Creature*> cultistList;
        me->GetCreatureListWithEntryInGrid(cultistList, NPC_CULTIST_ENGINEER, INSPECT_DISTANCE);
        for (Creature* cultist : cultistList)
            if (cultist)
                cultist->DespawnOrUnsummon();
    }

    void DespawnShadowsOfDoom()
    {
        std::list<Creature*> shadowList;
        me->GetCreatureListWithEntryInGrid(shadowList, NPC_SHADOW_OF_DOOM, 200.0f);
        for (Creature* shadow : shadowList)
            if (shadow && shadow->IsAlive() && !shadow->IsInCombat())
                shadow->DespawnOrUnsummon();
    }

    // Remove Objects from the event around the Shard (Yes this is Blizzlike).
    void DespawnEventDoodads()
    {
        std::list<GameObject*> doodadList;
        me->GetGameObjectListWithEntryInGrid(
            doodadList,
            { GO_SUMMON_CIRCLE, GO_UNDEAD_FIRE, GO_UNDEAD_FIRE_AURA, GO_SKULLPILE_01, GO_SKULLPILE_02, GO_SKULLPILE_03, GO_SKULLPILE_04, GO_SUMMONER_SHIELD },
            60.0f
        );
        for (GameObject* const& doodad : doodadList)
        {
            doodad->SetRespawnDelay(-1);
            doodad->DespawnOrUnsummon();
        }

        std::list<Creature*> finderList;
        me->GetCreatureListWithEntryInGrid(
            finderList,
            NPC_SCOURGE_INVASION_MINION_FINDER,
            60.0f
        );

        for (Creature* const& finder : finderList)
            finder->DespawnOrUnsummon();
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

private:
    uint32 _spellCampType = 0;
    uint32 _nearbyFinderCount = 0;
    uint8 _zapCount = 0; // 4 = death.
};

/*
Minion Spawner
*/
struct npc_minion_spawner : public ScriptedAI
{
    npc_minion_spawner(Creature* creature) : ScriptedAI(creature)
    {
        me->SetReactState(REACT_PASSIVE);
    }

    void JustSummoned(Creature* summon) override
    {
        me->SetRespawnTime(0);
        me->SetCorpseDelay(0);
        summon->SetWanderDistance(1.0f);
        DoCastAOE(SPELL_MINION_SPAWN_IN);
    }

    void Reset() override
    {
        scheduler.Schedule(5s, [this](TaskContext const& /*context*/) // Spawn Minions every 5 seconds.
        {
            uint32 entry;

            switch (me->GetEntry())
            {
                case NPC_SCOURGE_INVASION_MINION_SPAWNER_GHOST_GHOUL:
                    entry = CanSpawnRareMinion()
                        ? RAND(NPC_SPIRIT_OF_THE_DAMNED, NPC_LUMBERING_HORROR)
                        : RAND(NPC_SPECTRAL_SOLDIER, NPC_GHOUL_BERSERKER);
                    break;
                case NPC_SCOURGE_INVASION_MINION_SPAWNER_GHOST_SKELETON:
                    entry = CanSpawnRareMinion()
                        ? RAND(NPC_SPIRIT_OF_THE_DAMNED, NPC_BONE_WITCH)
                        : RAND(NPC_SPECTRAL_SOLDIER, NPC_SKELETAL_SHOCKTROOPER);
                    break;

                case NPC_SCOURGE_INVASION_MINION_SPAWNER_GHOUL_SKELETON:
                    entry = CanSpawnRareMinion()
                        ? RAND(NPC_LUMBERING_HORROR, NPC_BONE_WITCH)
                        : RAND(NPC_GHOUL_BERSERKER, NPC_SKELETAL_SHOCKTROOPER);
                    break;

                default:
                    entry = NPC_GHOUL_BERSERKER; // just in case.
                    break;
            }
            if (Creature* minion = me->SummonCreature(entry, me->GetPosition(), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, IN_MILLISECONDS * HOUR))
            {
                minion->SetWanderDistance(1.0f);
                DoCastAOE(SPELL_MINION_SPAWN_IN);
            }
        });
    }

    bool CanSpawnRareMinion()
    {
        std::list<Creature*> uncommonMinionList;
        me->GetCreatureListWithEntryInGrid(
            uncommonMinionList,
            { NPC_LUMBERING_HORROR, NPC_BONE_WITCH, NPC_SPIRIT_OF_THE_DAMNED },
            100.0f
        );
        for (Creature const* minion : uncommonMinionList)
            if (minion)
                return false; // Already a rare found (dead or alive).

        /*
        The chance or timer for a Rare minion spawn is unknown, and I don't see an exact pattern for a spawn sequence.
        Sniffed are: 19669 Minions and 90 Rares (Ratio: 217 to 1).
        */
        uint32 chance = urand(1, 217);
        if (chance > 1)
            return false; // Above 1 = Minion, else Rare.

        return true;
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }
};

struct npc_cultist_engineer : public ScriptedAI
{
    npc_cultist_engineer(Creature* creature) : ScriptedAI(creature) { }

    void sGossipSelect(Player* player, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        player->DestroyItemCount(ITEM_NECROTIC_RUNE, 8, true);
        player->CastSpell(static_cast<Unit*>(nullptr), SPELL_SUMMON_BOSS, true); // Player summons a Shadow of Doom for 1 hour.
        DoCastSelf(SPELL_QUIET_SUICIDE, true);
    }

    void Reset() override
    {
        scheduler.CancelAll();
        me->SetReactState(REACT_PASSIVE);
        me->SetCorpseDelay(10); // Corpse despawns 10 seconds after a Shadow of Doom spawns.
        scheduler.Schedule(0s, [this](TaskContext const& /*context*/)
        {
            DoCastSelf(SPELL_CREATE_SUMMONER_SHIELD, true);
            DoCastSelf(SPELL_MINION_SPAWN_IN, true);
        }).Schedule(1s, [this](TaskContext const& /*context*/)
        {
             DoCastSelf(SPELL_BUTTRESS_CHANNEL, true);
        });
    }

    void JustDied(Unit*) override
    {
        scheduler.CancelAll();
        if (Creature* shard = GetClosestCreatureWithEntry(me, NPC_DAMAGED_NECROTIC_SHARD, 15.0f))
            shard->CastSpell(shard, SPELL_DAMAGE_CRYSTAL, true);

        if (GameObject* gameObject = GetClosestGameObjectWithEntry(me, GO_SUMMONER_SHIELD, CONTACT_DISTANCE))
            gameObject->Delete();
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }
};

struct npc_flameshocker : public CombatAI
{
    npc_flameshocker(Creature* creature) : CombatAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
        scheduler.Schedule(2s, [this](TaskContext context)
        {
            DoCastVictim(RAND(SPELL_FLAMESHOCKERS_TOUCH, SPELL_FLAMESHOCKERS_TOUCH2), true);
            context.Repeat(30s, 45s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastSelf(SPELL_FLAMESHOCKERS_REVENGE, true);
    }

    void UpdateAI(uint32 const diff) override
    {
        scheduler.Update(diff);
        if (!UpdateVictim())
            return;
        DoMeleeAttackIfReady();
    }
};

struct npc_pallid_horror : public ScriptedAI
{
    npc_pallid_horror(Creature* creature) : ScriptedAI(creature), _summons(me) { }

    void InitializeAI() override
    {
        _summons.DespawnAll();
        me->SetCorpseDelay(10); // Corpse despawns 10 seconds after a crystal spawns.
        UpdateWeather(true);
        ScheduleTasks();
        me->AddAura(SPELL_AURA_OF_FEAR, me);
        me->SetWalk(false);
    }

    void ScheduleTasks()
    {
        scheduler.Schedule(0s, [this](const TaskContext& /*context*/)
        {
            SummonFlameshockers();
        }).Schedule(1s, [this](TaskContext context)
        {
            Talk(PALLID_HORROR_SAY_RANDOM_YELL);
            context.Repeat(65s, 300s);
        }).Schedule(11s, 81s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_DAMAGE_VS_GUARDS, true);
            context.Repeat();
        }).Schedule(2s, [this](TaskContext context)
        {
            if (_summons.size() >= 30)
            {
                context.Repeat(10s);
                return;
            }

            std::list<Creature*> targets;
            FlameshockerCheck check;
            Acore::CreatureListSearcher<FlameshockerCheck> searcher(me, targets, check);
            Cell::VisitObjects(me, searcher, VISIBILITY_DISTANCE_NORMAL);

            if (!targets.empty())
            {
                Creature* target = Acore::Containers::SelectRandomContainerElement(targets);

                float x, y, z;
                target->GetNearPoint(target, x, y, z, 5.0f, 5.0f, 0.0f);
                if (Creature* creature = me->SummonCreature(NPC_FLAMESHOCKER, x, y, z, target->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5 * IN_MILLISECONDS))
                    _summons.Summon(creature);
            }
            context.Repeat(2s);
        });
    }

    void SummonFlameshockers()
    {
        uint32 const amount = urand(5, 9); // sniffed are group sizes of 5-9 shockers on spawn.
        for (uint32 i = 0; i < amount; ++i)
        {
            if (Creature* summon = me->SummonCreature(
                    NPC_FLAMESHOCKER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, HOUR * IN_MILLISECONDS))
            {
                float angle = static_cast<float>(i) * (M_PI / (static_cast<float>(amount) / 2.f)) + me->GetOrientation();
                summon->GetMotionMaster()->Clear(true);
                summon->GetMotionMaster()->MoveFollow(me, 2.5f, angle);
                _summons.Summon(summon);
            }
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summon->CastSpell(summon, SPELL_MINION_SPAWN_IN, true);
        summon->SetWalk(false);
    }

    void JustDied(Unit* /*unit*/) override
    {
        // wrong Varian: missing special event Varian NPC that uses the old model
        // if (Creature* creature = GetClosestCreatureWithEntry(me, NPC_VARIAN, VISIBILITY_DISTANCE_NORMAL))
            // creature->Say(1);
        if (Creature* creature = GetClosestCreatureWithEntry(me, NPC_LADY_SYLVANAS_WINDRUNNER, VISIBILITY_DISTANCE_NORMAL))
            creature->Say(SYLVANAS_SAY_ATTACK_END);

        // Kill all custom summoned Flameshockers.
        _summons.DoForAllSummons([](WorldObject* summon)
        {
            if (Creature* creature = summon->ToCreature())
                creature->KillSelf();
        });

        // Spawn necrotic crystal gobject
        DoCastSelf((me->GetZoneId() == AREA_UNDERCITY ? SPELL_SUMMON_FAINT_NECROTIC_CRYSTAL : SPELL_SUMMON_CRACKED_NECROTIC_CRYSTAL), true);

        TimePoint now = std::chrono::steady_clock::now();
        uint32 cityAttackTimer = urand(CITY_ATTACK_TIMER_MIN, CITY_ATTACK_TIMER_MAX);
        TimePoint nextAttack = now + std::chrono::seconds(cityAttackTimer);
        uint64 timeToNextAttack = std::chrono::duration_cast<std::chrono::minutes>(nextAttack - now).count();
        SITimers index = me->GetZoneId() == AREA_UNDERCITY ? SI_TIMER_UNDERCITY : SI_TIMER_STORMWIND;
        sWorldState->SetSITimer(index, nextAttack);
        sWorldState->SetPallidGuid(index, ObjectGuid());

        UpdateWeather(false);

        LOG_INFO("gameevent",
            "[Scourge Invasion Event] The Scourge has been defeated in {}, next attack starting in {} minutes",
            me->GetZoneId() == AREA_UNDERCITY ? "Undercity" : "Stormwind",
            timeToNextAttack);
    }

    void CorpseRemoved(uint32& /*respawnDelay*/) override
    {
        // Remove all custom summoned Flameshockers.
        _summons.DespawnAll();
    }

    void UpdateAI(uint32 const diff) override
    {
        scheduler.Update(diff);
        if (!UpdateVictim())
            return;
        DoMeleeAttackIfReady();
    }

    void UpdateWeather(bool startEvent)
    {
        Weather* weather = me->GetMap()->GetOrGenerateZoneDefaultWeather(me->GetZoneId());
        if (weather)
        {
            if (startEvent)
                weather->SetWeather(WEATHER_TYPE_STORM, 0.25f);
            else
                weather->SetWeather(WEATHER_TYPE_RAIN, 0.0f);
        }
    }

private:
    struct FlameshockerCheck
    {
        bool operator()(Creature* creature)
        {
            return !creature->IsCivilian() && creature->GetEntry() != NPC_FLAMESHOCKER;
        }
    };
    SummonList _summons;
};

// 28091 - Despawner, self (server-side)
class spell_despawner_self : public SpellScript
{
    PrepareSpellScript(spell_despawner_self);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({SPELL_SPIRIT_SPAWN_OUT});
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            if (!caster->IsInCombat())
                caster->CastSpell(caster, SPELL_SPIRIT_SPAWN_OUT, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_despawner_self::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 28345 - Communique Trigger (server-side)
class spell_communique_trigger : public SpellScript
{
    PrepareSpellScript(spell_communique_trigger);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({SPELL_COMMUNIQUE_CAMP_TO_RELAY});
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(static_cast<Unit*>(nullptr), SPELL_COMMUNIQUE_CAMP_TO_RELAY, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_communique_trigger::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 28265 - Scourge Strike
class spell_scourge_invasion_scourge_strike : public SpellScript
{
    PrepareSpellScript(spell_scourge_invasion_scourge_strike);

    SpellCastResult CheckCast()
    {
        Unit* target = GetExplTargetUnit();
        if (!target || target->IsPlayer() || target->IsCharmedOwnedByPlayerOrPlayer())
            return SPELL_FAILED_BAD_TARGETS;
        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_scourge_invasion_scourge_strike::CheckCast);
    }
};

void AddSC_scourge_invasion()
{
    RegisterGameObjectAI(go_necropolis);
    RegisterCreatureAI(npc_herald_of_the_lich_king);
    RegisterCreatureAI(npc_necropolis);
    RegisterCreatureAI(npc_necropolis_health);
    RegisterCreatureAI(npc_necropolis_proxy);
    RegisterCreatureAI(npc_necropolis_relay);
    RegisterCreatureAI(npc_necrotic_shard);
    RegisterCreatureAI(npc_minion_spawner);
    RegisterCreatureAI(npc_pallid_horror);
    RegisterCreatureAI(npc_cultist_engineer);
    RegisterCreatureAI(npc_flameshocker);
    RegisterSpellScript(spell_communique_trigger);
    RegisterSpellScript(spell_despawner_self);
    RegisterSpellScript(spell_scourge_invasion_scourge_strike);
}
