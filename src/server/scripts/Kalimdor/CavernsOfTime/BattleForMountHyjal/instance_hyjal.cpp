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

#include "Chat.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "hyjal.h"

/* Battle of Mount Hyjal encounters:
0 - Rage Winterchill event
1 - Anetheron event
2 - Kaz'rogal event
3 - Azgalor event
4 - Archimonde event
*/

DoorData const DoorsData[] =
{
    { GO_HORDE_ENCAMPMENT_PORTAL,  DATA_ANETHERON,  DOOR_TYPE_PASSAGE },
    { GO_NIGHT_ELF_VILLAGE_PORTAL, DATA_AZGALOR,    DOOR_TYPE_PASSAGE },
    { 0,                           0,               DOOR_TYPE_PASSAGE }
};

ObjectData const CreatureData[] =
{
    { NPC_WINTERCHILL, DATA_WINTERCHILL },
    { NPC_ANETHERON,   DATA_ANETHERON   },
    { NPC_KAZROGAL,    DATA_KAZROGAL    },
    { NPC_AZGALOR,     DATA_AZGALOR     },
    { NPC_ARCHIMONDE,  DATA_ARCHIMONDE  },
    { NPC_THRALL,      DATA_THRALL      },
    { NPC_JAINA,       DATA_JAINA       },
    { NPC_TYRANDE,     DATA_TYRANDE     },
    { 0,               0                }
};

Milliseconds HyjalWaveTimers[4][MAX_WAVES_STANDARD]
{
    { 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 190000ms, 0ms },    // Winterchill
    { 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 190000ms, 0ms },    // Anetheron
    { 130000ms, 155000ms, 130000ms, 155000ms, 130000ms, 130000ms, 155000ms, 225000ms, 0ms },    // Kaz'rogal
    { 130000ms, 190000ms, 190000ms, 190000ms, 130000ms, 155000ms, 190000ms, 225000ms, 0ms }     // Azgalor
};

Milliseconds HyjalRetreatTimers[2][MAX_WAVES_RETREAT]
{
    { 10000ms, 6000ms , 0ms },   // Alliance
    { 10000ms, 40000ms, 0ms }    // Horde
};

Milliseconds HyjalNightElfWaveTimers[1][MAX_WAVES_NIGHT_ELF]
{
    { 0ms }
};

class instance_hyjal : public InstanceMapScript
{
public:
    instance_hyjal() : InstanceMapScript("instance_hyjal", 534) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_mount_hyjal_InstanceMapScript(map);
    }

    struct instance_mount_hyjal_InstanceMapScript : public InstanceScript
    {
        instance_mount_hyjal_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(EncounterCount);
            LoadDoorData(DoorsData);
            LoadObjectData(CreatureData, nullptr);
        }

        void Initialize() override
        {
            BossWave = TO_BE_DECIDED;
            Retreat = 0;
            Trash = 0;
            CurrentWave = 0;
            EncounterNPCs.clear();
            SummonedNPCs.clear();
            BaseAlliance.clear();
            BaseHorde.clear();
            InfernalTargets.clear();
            BaseNightElf.clear();
            RoaringFlameAlliance.clear();
            RoaringFlameHorde.clear();
            AncientGemAlliance.clear();
            AncientGemHorde.clear();
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_ANCIENT_GEM:
                    if (go->GetPositionY() > -2500.f)
                        AncientGemAlliance.insert(go->GetGUID());
                    else
                        AncientGemHorde.insert(go->GetGUID());
                    go->DespawnOrUnsummon();
                    break;
                case GO_FLAME:
                    if (go->GetPositionX() < 5360.f)
                        RoaringFlameAlliance.insert(go->GetGUID());
                    else
                        RoaringFlameHorde.insert(go->GetGUID());
                    go->DespawnOrUnsummon();
                    break;
            }
            InstanceScript::OnGameObjectCreate(go);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                    // Alliance base
                case NPC_ALLIANCE_PEASANT:
                case NPC_ALLIANCE_KNIGHT:
                case NPC_ALLIANCE_FOOTMAN:
                case NPC_ALLIANCE_RIFLEMAN:
                case NPC_ALLIANCE_PRIEST:
                case NPC_ALLIANCE_SORCERESS:
                case NPC_JAINA:
                    BaseAlliance.insert(creature->GetGUID());
                    break;
                    // Horde base
                case NPC_HORDE_HEADHUNTER:
                case NPC_HORDE_SHAMAN:
                case NPC_HORDE_GRUNT:
                case NPC_HORDE_HEALING_WARD:
                case NPC_TAUREN_WARRIOR:
                case NPC_HORDE_WITCH_DOCTOR:
                case NPC_HORDE_PEON:
                case NPC_THRALL:
                    BaseHorde.insert(creature->GetGUID());
                    break;
                    // Elf base
                case NPC_DRUID_OF_THE_TALON:
                case NPC_DRUID_OF_THE_CLAW:
                case NPC_NELF_ANCIENT_PROT:
                case NPC_NELF_ANCIENT_OF_LORE:
                case NPC_NELF_ANCIENT_OF_WAR:
                case NPC_NELF_ARCHER:
                case NPC_NELF_HUNTRESS:
                case NPC_DRYAD:
                case NPC_TYRANDE:
                    BaseNightElf.insert(creature->GetGUID());
                    break;

                case NPC_INFERNAL_TARGET:
                    InfernalTargets.push_back(creature->GetGUID());
                    break;

                case NPC_WINTERCHILL:
                case NPC_ANETHERON:
                case NPC_KAZROGAL:
                case NPC_AZGALOR:
                case NPC_NECRO:
                case NPC_ABOMI:
                case NPC_GHOUL:
                case NPC_BANSH:
                case NPC_CRYPT:
                case NPC_STALK:
                case NPC_GARGO:
                case NPC_FROST:
                case NPC_INFER:
                    if (BossWave != TO_BE_DECIDED)
                        creature->AI()->DoAction(BossWave);
                    else if (Retreat)
                        creature->AI()->DoAction(Retreat);

                    if (creature->IsSummon() && BossWave != TO_BE_DECIDED)
                    {
                        if (CurrentWave == 0)
                            creature->SetDisableReputationGain(true);
                        DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, ++Trash);    // Update the instance wave count on new trash spawn
                        EncounterNPCs.insert(creature->GetGUID());             // Used for despawning on wipe
                    }
                    break;
                case NPC_TOWERING_INFERNAL:
                case NPC_LESSER_DOOMGUARD:
                case NPC_DIRE_WOLF:
                case NPC_GUARDIAN_ELEMENTAL:
                    if (creature->IsSummon())
                    {
                        SummonedNPCs.insert(creature->GetGUID());
                    }
                    break;
            }
            InstanceScript::OnCreatureCreate(creature);
        }

        void OnUnitDeath(Unit* unit) override
        {
            InstanceScript::OnUnitDeath(unit);

            if (Creature* creature = unit->ToCreature())
            {
                switch (creature->GetEntry())
                {
                    case NPC_NECRO:
                    case NPC_ABOMI:
                    case NPC_GHOUL:
                    case NPC_BANSH:
                    case NPC_CRYPT:
                    case NPC_GARGO:
                    case NPC_FROST:
                    case NPC_INFER:
                    case NPC_STALK:
                        if (creature->IsSummon())
                        {
                            if (BossWave != TO_BE_DECIDED)
                            {
                                DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, --Trash);    // Update the instance wave count on new trash death
                                EncounterNPCs.erase(creature->GetGUID());    // Used for despawning on wipe

                                if (Trash == 0) // It can reach negatives if trash spawned after a retreat are killed, it shouldn't affect anything. Also happens on retail
                                    SetData(DATA_SPAWN_WAVES, 1);
                            }
                        }
                        break;
                    case NPC_TOWERING_INFERNAL:
                    case NPC_LESSER_DOOMGUARD:
                    case NPC_DIRE_WOLF:
                    case NPC_GUARDIAN_ELEMENTAL:
                        SummonedNPCs.erase(creature->GetGUID());
                        break;
                    case NPC_WINTERCHILL:
                    case NPC_ANETHERON:
                    case NPC_KAZROGAL:
                    case NPC_AZGALOR:
                        if (Creature* jaina = GetCreature(DATA_JAINA))
                            jaina->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        if (Creature* thrall = GetCreature(DATA_THRALL))
                            thrall->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        SetData(DATA_RESET_WAVES, 1);
                        break;
                }
            }
            else if (unit->IsPlayer() && GetBossState(DATA_ARCHIMONDE) == IN_PROGRESS)
            {
                if (Creature* archimonde = GetCreature(DATA_ARCHIMONDE))
                    archimonde->AI()->SetGUID(unit->GetGUID(), GUID_GAIN_SOUL_CHARGE_PLAYER);
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_ALLIANCE_RETREAT:
                    BossWave = TO_BE_DECIDED;
                    Retreat = DATA_ALLIANCE_RETREAT;
                    // Spawn Ancient Gems
                    for (ObjectGuid const& guid : AncientGemAlliance)
                        if (GameObject* gem = instance->GetGameObject(guid))
                            gem->Respawn();

                    // Move all alliance NPCs near Jaina (only happens in this base, not Horde's)
                    if (Creature* jaina = GetCreature(DATA_JAINA))
                    {
                        for (ObjectGuid const& guid : BaseAlliance)
                        {
                            if (Creature* creature = instance->GetCreature(guid))
                            {
                                if (creature->IsAlive())
                                {
                                    float x, y, z;
                                    jaina->GetNearPoint(creature, x, y, z, 10.f, 0, jaina->GetAngle(creature));
                                    creature->SetWalk(true);
                                    creature->GetMotionMaster()->MovePoint(1, x, y, z);
                                }
                            }
                        }
                    }

                    // Despawn all alliance NPCs
                    scheduler.Schedule(21000ms, [this](TaskContext)
                        {
                            for (ObjectGuid const& guid : BaseAlliance)
                                if (Creature* creature = instance->GetCreature(guid))
                                    creature->DespawnOrUnsummon();

                            // Spawn Roaring Flame after a delay
                            scheduler.Schedule(30s, [this](TaskContext)
                                {
                                    for (ObjectGuid const& guid : RoaringFlameAlliance)
                                    {
                                        if (GameObject* flame = instance->GetGameObject(guid))
                                            flame->Respawn();
                                    }
                                });
                        });

                    // Spawn Overrun waves
                    ScheduleWaves(1ms, START_WAVE_ALLIANCE_RETREAT, MAX_WAVES_RETREAT, HyjalRetreatTimers[0]);

                    SaveToDB();
                    break;
                case DATA_HORDE_RETREAT:
                    BossWave = TO_BE_DECIDED;
                    Retreat = DATA_HORDE_RETREAT;
                    for (ObjectGuid const& guid : AncientGemHorde)
                    {
                        if (GameObject* gem = instance->GetGameObject(guid))
                            gem->Respawn();
                    }

                    if (Creature* jaina = GetCreature(DATA_JAINA))
                    {
                        for (ObjectGuid const& guid : BaseHorde)
                        {
                            if (Creature* creature = instance->GetCreature(guid))
                            {
                                if (creature->IsAlive())
                                {
                                    float x, y, z;
                                    jaina->GetNearPoint(creature, x, y, z, 10.f, 0, jaina->GetAngle(creature));
                                    creature->SetWalk(true);
                                    creature->GetMotionMaster()->MovePoint(1, x, y, z);
                                }
                            }
                        }
                    }

                    scheduler.Schedule(21000ms, [this](TaskContext)
                        {
                            for (ObjectGuid const& guid : BaseHorde)
                                if (Creature* creature = instance->GetCreature(guid))
                                    creature->DespawnOrUnsummon();

                            scheduler.Schedule(30s, [this](TaskContext)
                                {
                                    for (ObjectGuid const& guid : RoaringFlameHorde)
                                        if (GameObject* flame = instance->GetGameObject(guid))
                                            flame->Respawn();
                                });
                        });

                    ScheduleWaves(1ms, START_WAVE_HORDE_RETREAT, MAX_WAVES_RETREAT, HyjalRetreatTimers[1]);

                    SaveToDB();
                    break;
                case DATA_SPAWN_WAVES:
                    Retreat = 0;
                    if (GetBossState(DATA_WINTERCHILL) != DONE)
                    {
                        if (BossWave == TO_BE_DECIDED)
                            for (ObjectGuid const& guid : BaseAlliance)
                                if (Creature* creature = instance->GetCreature(guid))
                                    creature->Respawn();
                        BossWave = DATA_WINTERCHILL;
                        ScheduleWaves(1ms, START_WAVE_WINTERCHILL, MAX_WAVES_STANDARD, HyjalWaveTimers[DATA_WINTERCHILL]);
                    }
                    else if (GetBossState(DATA_ANETHERON) != DONE)
                    {
                        if (BossWave == TO_BE_DECIDED)
                            for (ObjectGuid const& guid : BaseAlliance)
                                if (Creature* creature = instance->GetCreature(guid))
                                    creature->Respawn();
                        BossWave = DATA_ANETHERON;
                        ScheduleWaves(1ms, START_WAVE_ANETHERON, MAX_WAVES_STANDARD, HyjalWaveTimers[DATA_ANETHERON]);
                    }
                    else if (GetBossState(DATA_KAZROGAL) != DONE)
                    {
                        if (BossWave == TO_BE_DECIDED)
                            for (ObjectGuid const& guid : BaseHorde)
                                if (Creature* creature = instance->GetCreature(guid))
                                    creature->Respawn();
                        BossWave = DATA_KAZROGAL;
                        ScheduleWaves(1ms, START_WAVE_KAZROGAL, MAX_WAVES_STANDARD, HyjalWaveTimers[DATA_KAZROGAL]);
                    }
                    else if (GetBossState(DATA_AZGALOR) != DONE)
                    {
                        if (BossWave == TO_BE_DECIDED)
                            for (ObjectGuid const& guid : BaseHorde)
                                if (Creature* creature = instance->GetCreature(guid))
                                    creature->Respawn();
                        BossWave = DATA_AZGALOR;
                        ScheduleWaves(1ms, START_WAVE_AZGALOR, MAX_WAVES_STANDARD, HyjalWaveTimers[DATA_AZGALOR]);
                    }
                    else if (GetBossState(DATA_ARCHIMONDE) != DONE)
                    {
                        BossWave = DATA_ARCHIMONDE;
                        ScheduleWaves(1ms, START_WAVE_NIGHT_ELF, MAX_WAVES_NIGHT_ELF, HyjalNightElfWaveTimers[0]);
                    }

                    if (BossWave != TO_BE_DECIDED)
                    {
                        DoUpdateWorldState(WORLD_STATE_WAVES, 0);
                        scheduler.Schedule(30s, [this](TaskContext context)
                        {
                            if (IsEncounterInProgress())
                            {
                                // Reset the instance if its empty.
                                // This is necessary because bosses get stuck fighting unreachable mobs.
                                // Remove this when we are sure pathing no longer causes this.
                                if (!instance->GetPlayersCountExceptGMs())
                                    SetData(DATA_RESET_ALLIANCE, 0);
                                else
                                    context.Repeat();
                            }
                        });
                    }

                    break;
                case DATA_SPAWN_INFERNALS:
                {
                    uint8 doubleInfernalCount = 2;
                    // Uses SmartAI
                    for (ObjectGuid const& guid : InfernalTargets)
                    {
                        if (Creature* target = instance->GetCreature(guid))
                        {
                            if (doubleInfernalCount > 0)
                            {
                                target->AI()->SetData(DATA_SPAWN_INFERNALS, 2); // Spawns 2 infernals, as there are only 6 spawns, some summon 2
                                doubleInfernalCount--;
                            }
                            else
                                target->AI()->SetData(DATA_SPAWN_INFERNALS, 1);
                        }
                    }
                }
                    break;
                case DATA_RESET_NIGHT_ELF:
                    if (Creature* archimonde = GetCreature(DATA_ARCHIMONDE))
                        archimonde->DespawnOrUnsummon(0s, 300s);
                    [[fallthrough]];
                case DATA_RESET_ALLIANCE:
                case DATA_RESET_HORDE:
                    if (GetBossState(DATA_ANETHERON) != DONE)
                    {
                        for (ObjectGuid const& guid : BaseAlliance)
                            if (Creature* creature = instance->GetCreature(guid))
                                creature->DespawnOrUnsummon(0s, 300s);
                    }

                    if (GetBossState(DATA_AZGALOR) != DONE)
                    {
                        for (ObjectGuid const& guid : BaseHorde)
                            if (Creature* creature = instance->GetCreature(guid))
                                creature->DespawnOrUnsummon(0s, 300s);
                    }

                    for (ObjectGuid const& guid : BaseNightElf)
                        if (Creature* creature = instance->GetCreature(guid))
                            creature->DespawnOrUnsummon(0s, 300s);

                    for (ObjectGuid const& guid : EncounterNPCs)
                        if (Creature* creature = instance->GetCreature(guid))
                            creature->DespawnOrUnsummon();

                    // also force despawn boss summons
                    for (ObjectGuid const& guid : SummonedNPCs)
                        if (Creature* creature = instance->GetCreature(guid))
                            creature->DespawnOrUnsummon();

                    if (BossWave != TO_BE_DECIDED && (GetBossState(BossWave) != DONE))
                        SetBossState(BossWave, NOT_STARTED);

                    SetData(DATA_RESET_WAVES, 0);
                    break;
                case DATA_RESET_WAVES:
                    scheduler.CancelGroup(CONTEXT_GROUP_WAVES);
                    EncounterNPCs.clear();
                    SummonedNPCs.clear();
                    CurrentWave = 0;
                    Trash = 0;
                    BossWave = TO_BE_DECIDED;
                    Retreat = 0;
                    DoUpdateWorldState(WORLD_STATE_WAVES, CurrentWave);
                    DoUpdateWorldState(WORLD_STATE_ENEMY, Trash);
                    DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, Trash);
                    break;
            }

            if (data == DONE)
            {
                SaveToDB();
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
            case DATA_WAVE_STATUS:
                return CurrentWave;
                break;
            case DATA_BOSS_WAVE:
                return BossWave;
            }
            return 0;
        }

        void ScheduleWaves(Milliseconds /* time */, uint8 startWaves, uint8 maxWaves, Milliseconds timerptr[])
        {
            // No overlapping!
            scheduler.CancelGroup(CONTEXT_GROUP_WAVES);
            Trash = 0;    // Reset counter here to avoid resetting the counter from scheduled waves. Required because creatures killed for RP events counts towards the kill counter as well, confirmed in Retail.

            scheduler.Schedule(1ms, [this, startWaves, maxWaves, timerptr](TaskContext context)
                {
                    // If all waves reached, cancel scheduling new ones
                    if (CurrentWave >= maxWaves)
                        return;

                    instance->SummonCreatureGroup(startWaves + CurrentWave);   // CurrentWave should be 0 when this function is first called

                    // Check if it's time to summon Infernals
                    if (GetBossState(DATA_KAZROGAL) == DONE && GetBossState(DATA_AZGALOR) != DONE)
                    {
                        switch (CurrentWave + 1)
                        {
                        case 3:
                        case 4:
                        case 7:
                            SetData(DATA_SPAWN_INFERNALS, 1);
                            break;
                        default:
                            break;
                        }
                    }

                    context.Repeat(timerptr[CurrentWave]);
                    if (++CurrentWave < maxWaves && BossWave != TO_BE_DECIDED)
                    {
                        DoUpdateWorldState(WORLD_STATE_WAVES, CurrentWave);
                        DoUpdateWorldState(WORLD_STATE_ENEMY, 1);
                    }

                    context.SetGroup(CONTEXT_GROUP_WAVES);
                });
        }

        void Update(uint32 diff) override
        {
            scheduler.Update(diff);
        }

        void OnPlayerInWaterStateUpdate(Player* player, bool inWater) override
        {
            if (inWater && player->GetAreaId() == AREA_NORDRASSIL)
            {
                player->CastSpell(player, SPELL_ETERNAL_SILENCE, true);
            }
        }

    protected:
        int32 Trash;
        uint8 CurrentWave;
        uint8 BossWave;
        uint8 Retreat;
        GuidSet EncounterNPCs;
        GuidSet SummonedNPCs;
        GuidSet BaseAlliance;
        GuidSet BaseHorde;
        GuidVector InfernalTargets;
        GuidSet BaseNightElf;
        GuidSet AncientGemAlliance;
        GuidSet AncientGemHorde;
        GuidSet RoaringFlameAlliance;
        GuidSet RoaringFlameHorde;
    };
};

void AddSC_instance_mount_hyjal()
{
    new instance_hyjal();
}
