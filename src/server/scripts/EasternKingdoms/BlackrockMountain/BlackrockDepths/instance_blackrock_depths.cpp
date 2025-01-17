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

#include "GameTime.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "blackrock_depths.h"

constexpr auto MAX_ENCOUNTER = 6;

enum Timers
{
    TIMER_TOMBOFTHESEVEN = 30000,
    TIMER_TOMB_START     = 1000,
    TIMER_TOMB_RESET     = 15000
};

enum Distances
{
    RADIUS_RING_OF_LAW      = 80,
    DISTANCE_EMPEROR_ROOM   = 125
};

enum PrincessQuests
{
    PRINCESS_QUEST_HORDE        = 4004,
    PRINCESS_QUEST_ALLIANCE     = 4363
};

enum GameObjects
{
    GO_ARENA1               = 161525,
    GO_ARENA2               = 161522,
    GO_ARENA3               = 161524,
    GO_ARENA4               = 161523,
    GO_SHADOW_LOCK          = 161460,
    GO_SHADOW_MECHANISM     = 161461,
    GO_SHADOW_GIANT_DOOR    = 157923,
    GO_SHADOW_DUMMY         = 161516,
    GO_BAR_KEG_SHOT         = 170607,
    GO_BAR_KEG_TRAP         = 171941,
    GO_BAR_DOOR             = 170571,
    GO_TOMB_ENTER           = 170576,
    GO_TOMB_EXIT            = 170577,
    GO_LYCEUM               = 170558,
    GO_SF_N                 = 174745, // Shadowforge Brazier North
    GO_SF_S                 = 174744, // Shadowforge Brazier South
    GO_GOLEM_ROOM_N         = 170573, // Magmus door North
    GO_GOLEM_ROOM_S         = 170574, // Magmus door Soutsh
    GO_THRONE_ROOM          = 170575, // Throne door
    GO_SPECTRAL_CHALICE     = 164869,
    GO_CHEST_SEVEN          = 169243,
};

enum MiscData
{
    SPELL_STONED    = 10255
};

class RestoreAttack : public BasicEvent
{
public:
    RestoreAttack(Creature* boss) : _boss(boss) {}

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        _boss->SetReactState(REACT_AGGRESSIVE);
        _boss->AI()->SetData(DATA_GOLEM_LORD_ARGELMACH_INIT, DONE);

        if (Unit* victim = _boss->GetVictim())
        {
            _boss->SetTarget(victim->GetGUID());
            _boss->GetMotionMaster()->MoveChase(victim);
        }

        return true;
    }

private:
    Creature* _boss;
};

class instance_blackrock_depths : public InstanceMapScript
{
public:
    instance_blackrock_depths() : InstanceMapScript("instance_blackrock_depths", 230) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_blackrock_depths_InstanceMapScript(map);
    }

    struct instance_blackrock_depths_InstanceMapScript : public InstanceScript
    {
        instance_blackrock_depths_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
        }

        uint32 encounter[MAX_ENCOUNTER];
        std::string str_data;

        ObjectGuid EmperorGUID;
        ObjectGuid PhalanxGUID;
        ObjectGuid MagmusGUID;
        ObjectGuid MoiraGUID;
        ObjectGuid PriestessGUID;
        ObjectGuid IronhandGUID[6];
        ObjectGuid CorenGUID;

        ObjectGuid GoArena1GUID;
        ObjectGuid GoArena2GUID;
        ObjectGuid GoArena3GUID;
        ObjectGuid GoArena4GUID;
        ObjectGuid GoShadowLockGUID;
        ObjectGuid GoShadowMechGUID;
        ObjectGuid GoShadowGiantGUID;
        ObjectGuid GoShadowDummyGUID;
        ObjectGuid GoBarKegGUID;
        ObjectGuid GoBarKegTrapGUID;
        ObjectGuid GoBarDoorGUID;
        ObjectGuid GoTombEnterGUID;
        ObjectGuid GoTombExitGUID;
        ObjectGuid GoLyceumGUID;
        ObjectGuid GoSFSGUID;
        ObjectGuid GoSFNGUID;
        ObjectGuid GoGolemNGUID;
        ObjectGuid GoGolemSGUID;
        ObjectGuid GoThroneGUID;
        ObjectGuid GoChestGUID;
        ObjectGuid GoSpectralChaliceGUID;

        uint32 BarAleCount;
        uint32 GhostKillCount;
        ObjectGuid TombBossGUIDs[7];
        uint32 tombResetTimer;
        uint32 TombTimer;
        uint32 TombEventCounter;
        uint32 OpenedCoofers;
        uint32 IronhandCounter;

        GuidList ArgelmachAdds;
        ObjectGuid ArgelmachGUID;

        TempSummon* TempSummonGrimstone = nullptr;
        Position GrimstonePositon = Position(625.559f, -205.618f, -52.735f, 2.609f);
        time_t timeRingFail = 0;
        uint8 arenaMobsToSpawn;
        uint8 arenaBossToSpawn;

        std::vector<ObjectGuid> ArenaSpectators;
        Position CenterOfRingOfLaw = Position(595.289, -186.56);

        ObjectGuid EmperorSenators[5];
        std::vector<ObjectGuid> EmperorSenatorsVector;
        Position EmperorSpawnPos = Position(1380.52, -831, 115);

        void OnPlayerEnter(Player* /* player */) override
        {
            ReplaceMoiraIfSaved(); // In case a player joins the party during the run
         //   SetData(TYPE_RING_OF_LAW, DONE);
        }

        void ReplaceMoiraIfSaved()
        {
            ObjectGuid* GUIDToReplace = &PriestessGUID; // default to having Moira
            ObjectGuid* GUIDToSpawn   = &MoiraGUID;
            uint32      NPCEntry      = NPC_MOIRA;
            bool        MoiraSaved    = true;

            // check if all players saved her.
            Map::PlayerList const& lPlayers = instance->GetPlayers();
            if (!lPlayers.IsEmpty())
            {
                for (Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr)
                {
                    if (Player* player = itr->GetSource())
                    {
                        // set to false if this player hasn't saved her. Another player can't put it to true.
                        MoiraSaved = MoiraSaved && ((player->GetQuestStatus(PRINCESS_QUEST_HORDE) == QUEST_STATUS_REWARDED)
                                                    || (player->GetQuestStatus(PRINCESS_QUEST_ALLIANCE) == QUEST_STATUS_REWARDED));
                    }
                }
            }

            // assign correct GUIDs and spawn targets
            if (MoiraSaved)
            {
                GUIDToReplace = &MoiraGUID;
                GUIDToSpawn   = &PriestessGUID;
                NPCEntry      = NPC_PRIESTESS;
            }

            if (Creature* CreatureToReplace = instance->GetCreature(*GUIDToReplace))
            {
                Creature* NewSpawn = instance->SummonCreature(NPCEntry, CreatureToReplace->GetPosition());
                CreatureToReplace->RemoveFromWorld();
                *GUIDToSpawn = NewSpawn->GetGUID();
            }
        }

        void Initialize() override
        {
            memset(&encounter, 0, sizeof(encounter));

            BarAleCount = 0;
            GhostKillCount = 0;
            TombTimer = TIMER_TOMB_START;
            TombEventCounter = 0;
            tombResetTimer   = 0;
            OpenedCoofers = 0;
            IronhandCounter  = 0;
            ArenaSpectators.clear();

            // these are linked to the dungeon and not how many times the arena started.
            arenaMobsToSpawn = urand(0, 5);
            arenaBossToSpawn = urand(0, 5);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_EMPEROR:
                    EmperorGUID = creature->GetGUID();
                    break;
                case NPC_PHALANX:
                    PhalanxGUID = creature->GetGUID();
                    break;
                case NPC_MOIRA:
                    MoiraGUID = creature->GetGUID();
                    break;
                case NPC_COREN_DIREBREW:
                    CorenGUID = creature->GetGUID();
                    break;
                case NPC_ANGERREL:
                    TombBossGUIDs[0] = creature->GetGUID();
                    break;
                case NPC_SEETHREL:
                    TombBossGUIDs[1] = creature->GetGUID();
                    break;
                case NPC_DOPEREL:
                    TombBossGUIDs[2] = creature->GetGUID();
                    break;
                case NPC_GLOOMREL:
                    TombBossGUIDs[3] = creature->GetGUID();
                    break;
                case NPC_VILEREL:
                    TombBossGUIDs[4] = creature->GetGUID();
                    break;
                case NPC_HATEREL:
                    TombBossGUIDs[5] = creature->GetGUID();
                    break;
                case NPC_DOOMREL:
                    TombBossGUIDs[6] = creature->GetGUID();
                    break;
                case NPC_MAGMUS:
                    MagmusGUID = creature->GetGUID();
                    if (!creature->IsAlive())
                        HandleGameObject(GoThroneGUID, true); // if Magmus is dead open door to last boss
                    break;
                case NPC_WEAPON_TECHNICIAN:
                case NPC_DOOMFORGE_ARCANASMITH:
                case NPC_RAGEREAVER_GOLEM:
                case NPC_WRATH_HAMMER_CONSTRUCT:
                    if (creature->IsAlive() && creature->GetPositionZ() < -51.5f && creature->GetPositionZ() > -55.f)
                    {
                        ArgelmachAdds.push_back(creature->GetGUID());
                    }
                    break;
                case NPC_GOLEM_LORD_ARGELMACH:
                    ArgelmachGUID = creature->GetGUID();
                    break;
                case NPC_IRONHAND_GUARDIAN:
                    IronhandGUID[IronhandCounter] = creature->GetGUID();
                    IronhandCounter++;
                    break;
                case NPC_ARENA_SPECTATOR:
                    ArenaSpectators.push_back(creature->GetGUID());
                    if (encounter[TYPE_RING_OF_LAW] == DONE) // added for crashes
                    {
                        creature->SetFaction(FACTION_NEUTRAL);
                        creature->SetReactState(REACT_DEFENSIVE);
                    }
                    break;
                case NPC_SHADOWFORGE_PEASANT:
                case NPC_SHADOWFORCE_CITIZEN: // both do the same
                    if (creature->GetDistance2d(CenterOfRingOfLaw.GetPositionX(), CenterOfRingOfLaw.GetPositionY()) < (float)RADIUS_RING_OF_LAW)
                    {
                        ArenaSpectators.push_back(creature->GetGUID());
                    }
                    if (encounter[TYPE_RING_OF_LAW] == DONE) // added for crashes
                    {
                        creature->SetFaction(FACTION_NEUTRAL);
                        creature->SetReactState(REACT_DEFENSIVE);
                    }
                    break;
                case NPC_SHADOWFORGE_SENATOR:
                    // keep track of Senators that are not too far from emperor. Can't really use emperor as creature due to him possibly not being spawned.
                    // some senators spawn at ring of law
                    if (creature->GetDistance2d(EmperorSpawnPos.GetPositionX(), EmperorSpawnPos.GetPositionY()) < (float)DISTANCE_EMPEROR_ROOM)
                    {
                        EmperorSenatorsVector.push_back(creature->GetGUID());
                    }
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_ARENA1:
                    GoArena1GUID = go->GetGUID();
                    break;
                case GO_ARENA2:
                    GoArena2GUID = go->GetGUID();
                    break;
                case GO_ARENA3:
                    GoArena3GUID = go->GetGUID();
                    break;
                case GO_ARENA4:
                    GoArena4GUID = go->GetGUID();
                    break;
                case GO_SHADOW_LOCK:
                    GoShadowLockGUID = go->GetGUID();
                    break;
                case GO_SHADOW_MECHANISM:
                    GoShadowMechGUID = go->GetGUID();
                    break;
                case GO_SHADOW_GIANT_DOOR:
                    GoShadowGiantGUID = go->GetGUID();
                    break;
                case GO_SHADOW_DUMMY:
                    GoShadowDummyGUID = go->GetGUID();
                    break;
                case GO_BAR_KEG_SHOT:
                    GoBarKegGUID = go->GetGUID();
                    break;
                case GO_BAR_KEG_TRAP:
                    GoBarKegTrapGUID = go->GetGUID();
                    break;
                case GO_BAR_DOOR:
                    GoBarDoorGUID = go->GetGUID();
                    break;
                case GO_TOMB_ENTER:
                    GoTombEnterGUID = go->GetGUID();
                    break;
                case GO_TOMB_EXIT:
                    GoTombExitGUID = go->GetGUID();
                    if (GhostKillCount >= 7)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    else
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_LYCEUM:
                    GoLyceumGUID = go->GetGUID();
                    break;
                case GO_SF_S:
                    GoSFSGUID = go->GetGUID();
                    break;
                case GO_SF_N:
                    GoSFNGUID = go->GetGUID();
                    break;
                case GO_GOLEM_ROOM_N:
                    GoGolemNGUID = go->GetGUID();
                    break;
                case GO_GOLEM_ROOM_S:
                    GoGolemSGUID = go->GetGUID();
                    break;
                case GO_THRONE_ROOM:
                    GoThroneGUID = go->GetGUID();
                    break;
                case GO_CHEST_SEVEN:
                    GoChestGUID = go->GetGUID();
                    break;
                case GO_SPECTRAL_CHALICE:
                    GoSpectralChaliceGUID = go->GetGUID();
                    break;
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            uint32 deadSenators = 0;
            switch (unit->GetEntry())
            {
                case NPC_WEAPON_TECHNICIAN:
                case NPC_DOOMFORGE_ARCANASMITH:
                case NPC_RAGEREAVER_GOLEM:
                case NPC_WRATH_HAMMER_CONSTRUCT:
                    ArgelmachAdds.remove(unit->GetGUID());
                    break;
                case NPC_MAGMUS:
                    SetData(TYPE_IRON_HALL, DONE);
                    break;
                case NPC_SHADOWFORGE_SENATOR:
                    deadSenators = 1; //hacky, but we cannot count the unit that just died through its state because OnUnitDeath() is called before the state is set.
                    for (const auto &senatorGUID: EmperorSenatorsVector)
                    {
                        if (Creature* senator = instance->GetCreature(senatorGUID))
                        {
                            if (!senator->IsAlive() || senator->isDying())
                            {
                                deadSenators++;
                            }
                        }
                    }

                    if (Creature* emperor = instance->GetCreature(EmperorGUID))
                    {
                        // send % of senators that died
                        emperor->AI()->SetData(0, (100 * deadSenators) / EmperorSenatorsVector.size());
                    }
                    break;
                case NPC_ANGERREL:
                case NPC_DOPEREL:
                case NPC_HATEREL:
                case NPC_VILEREL:
                case NPC_SEETHREL:
                case NPC_GLOOMREL:
                case NPC_DOOMREL:
                    GhostKillCount++;
                    if (GhostKillCount >= 7)
                    {
                        SetData(TYPE_TOMB_OF_SEVEN, DONE);
                    }
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            LOG_DEBUG("scripts.ai", "Instance Blackrock Depths: SetData update (Type: {} Data {})", type, data);

            switch (type)
            {
                case TYPE_RING_OF_LAW:
                    encounter[0] = data;
                    switch (data)
                    {
                    case IN_PROGRESS:
                        TempSummonGrimstone = instance->SummonCreature(NPC_GRIMSTONE, GrimstonePositon);
                        break;
                    case FAIL:
                        if (TempSummonGrimstone)
                        {
                            TempSummonGrimstone->RemoveFromWorld();
                            TempSummonGrimstone = nullptr;
                            timeRingFail = GameTime::GetGameTime().count();
                        }
                        SetData(TYPE_RING_OF_LAW, NOT_STARTED);
                        break;
                    case DONE:
                        for (auto const& itr : ArenaSpectators)
                        {
                            if (Creature* spectator = instance->GetCreature(itr))
                            {
                                spectator->SetFaction(FACTION_NEUTRAL);
                                spectator->SetReactState(REACT_DEFENSIVE);
                            }
                        }
                        break;
                    default:
                        break;
                    }
                    break;
                case TYPE_VAULT:
                    encounter[1] = data;
                    break;
                case TYPE_BAR:
                    if (data == SPECIAL)
                        ++BarAleCount;
                    else
                        encounter[2] = data;
                    break;
                case TYPE_TOMB_OF_SEVEN:
                    encounter[3] = data;
                    switch (data)
                    {
                        case IN_PROGRESS:
                            HandleGameObject(GoTombExitGUID, false);
                            HandleGameObject(GoTombEnterGUID, false);
                            break;
                        case DONE:
                            DoRespawnGameObject(GoChestGUID, DAY);
                            HandleGameObject(GoTombExitGUID, true);
                            HandleGameObject(GoTombEnterGUID, true);
                            break;
                    }
                    break;
                case TYPE_LYCEUM:
                    encounter[4] = data;
                    if (data == DONE)
                    {
                        HandleGameObject(GetGuidData(DATA_GOLEM_DOOR_N), true);
                        HandleGameObject(GetGuidData(DATA_GOLEM_DOOR_S), true);
                        if (Creature* magmus = instance->GetCreature(MagmusGUID))
                        {
                            magmus->AI()->Talk(0);
                        }
                        ReplaceMoiraIfSaved(); // Need to place the correct final boss, but we need her to be spawned first.
                    }
                    break;
                case TYPE_IRON_HALL:
                    encounter[5] = data;
                    switch (data)
                    {
                    case NOT_STARTED:
                    case IN_PROGRESS:
                        for (int i = 0; i < 6; i++)
                        {
                            if (Creature* ironhand = instance->GetCreature(IronhandGUID[i]))
                            {
                                ironhand->AI()->SetData(0, data == IN_PROGRESS);
                            }
                        }
                        break;
                    case DONE:
                        HandleGameObject(GetGuidData(DATA_THRONE_DOOR), true);
                        break;
                    default:
                        break;
                    }
                    break;
                case DATA_OPEN_COFFER_DOORS:
                    OpenedCoofers += 1;
                    if (OpenedCoofers == 12)
                    {
                        Position pos = {812.15f, -348.91f, -50.579f, 0.7f};
                        if (TempSummon* summon = instance->SummonCreature(NPC_WATCHMAN_DOOMGRIP, pos))
                            summon->SetTempSummonType(TEMPSUMMON_MANUAL_DESPAWN);
                    }
                    break;
                case DATA_GOLEM_LORD_ARGELMACH_INIT:
                {
                    if (Creature* argelmach = instance->GetCreature(ArgelmachGUID))
                    {
                        GuidList adds = ArgelmachAdds;
                        for (GuidList::const_iterator itr = adds.begin(); itr != adds.end();)
                        {
                            if (Creature* argelmachAdd = instance->GetCreature(*itr))
                            {
                                if (argelmachAdd->GetEntry() == NPC_WRATH_HAMMER_CONSTRUCT)
                                {
                                    argelmachAdd->RemoveAurasDueToSpell(SPELL_STONED);
                                    argelmachAdd->AI()->AttackStart(argelmach->GetVictim());
                                    itr = adds.erase(itr);
                                }
                                else if (argelmachAdd->GetEntry() == NPC_RAGEREAVER_GOLEM)
                                {
                                    if (argelmachAdd->IsWithinDist2d(argelmach, 10.f))
                                    {
                                        argelmachAdd->RemoveAurasDueToSpell(SPELL_STONED);
                                        argelmachAdd->AI()->AttackStart(argelmach->GetVictim());
                                        itr = adds.erase(itr);
                                    }
                                    else
                                        ++itr;
                                }
                                else
                                {
                                    ++itr;
                                }
                            }
                            else
                            {
                                ++itr;
                            }
                        }

                        if (!adds.empty())
                        {
                            argelmach->SetReactState(REACT_PASSIVE);
                            argelmach->SetTarget();
                            argelmach->AI()->SetData(DATA_GOLEM_LORD_ARGELMACH_INIT, IN_PROGRESS);
                        }
                        else
                        {
                            argelmach->AI()->SetData(DATA_GOLEM_LORD_ARGELMACH_INIT, DONE);
                        }
                    }
                    break;
                }
                case DATA_GOLEM_LORD_ARGELMACH_ADDS:
                {
                    if (Creature* argelmach = instance->GetCreature(ArgelmachGUID))
                    {
                        argelmach->HandleEmoteCommand(EMOTE_ONESHOT_SHOUT);
                        argelmach->m_Events.AddEvent(new RestoreAttack(argelmach), argelmach->m_Events.CalculateTime(3000));

                        for (ObjectGuid const& argelmachAddGUID : ArgelmachAdds)
                        {
                            if (Creature* argelmachAdd = instance->GetCreature(argelmachAddGUID))
                            {
                                if (!argelmachAdd->IsInCombat())
                                {
                                    argelmachAdd->RemoveAurasDueToSpell(SPELL_STONED);
                                    argelmachAdd->AI()->AttackStart(argelmach->GetVictim());
                                }
                            }
                        }
                    }
                    break;
                }
                default:
                    break;
            }

            if (data == DONE || GhostKillCount >= 7)
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << encounter[0] << ' ' << encounter[1] << ' ' << encounter[2] << ' '
                           << encounter[3] << ' ' << encounter[4] << ' ' << encounter[5] << ' ' << GhostKillCount;

                str_data = saveStream.str();

                SaveToDB();
                OUT_SAVE_INST_DATA_COMPLETE;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case TYPE_RING_OF_LAW:
                    return encounter[0];
                case TYPE_VAULT:
                    return encounter[1];
                case TYPE_BAR:
                    if (encounter[2] == IN_PROGRESS && BarAleCount == 3)
                        return SPECIAL;
                    else
                        return encounter[2];
                case TYPE_TOMB_OF_SEVEN:
                    return encounter[3];
                case TYPE_LYCEUM:
                    return encounter[4];
                case TYPE_IRON_HALL:
                    return encounter[5];
                case DATA_TIME_RING_FAIL:
                    return timeRingFail;
                case DATA_ARENA_MOBS:
                    return arenaMobsToSpawn;
                case DATA_ARENA_BOSS:
                    return arenaBossToSpawn;
            }
            return 0;
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
                case DATA_EMPEROR:
                    return EmperorGUID;
                case DATA_PHALANX:
                    return PhalanxGUID;
                case DATA_MOIRA:
                    return MoiraGUID;
                case DATA_COREN:
                    return CorenGUID;
                case DATA_ARENA1:
                    return GoArena1GUID;
                case DATA_ARENA2:
                    return GoArena2GUID;
                case DATA_ARENA3:
                    return GoArena3GUID;
                case DATA_ARENA4:
                    return GoArena4GUID;
                case DATA_GO_BAR_KEG:
                    return GoBarKegGUID;
                case DATA_GO_BAR_KEG_TRAP:
                    return GoBarKegTrapGUID;
                case DATA_GO_BAR_DOOR:
                    return GoBarDoorGUID;
                case DATA_SF_BRAZIER_N:
                    return GoSFNGUID;
                case DATA_SF_BRAZIER_S:
                    return GoSFSGUID;
                case DATA_THRONE_DOOR:
                    return GoThroneGUID;
                case DATA_GOLEM_DOOR_N:
                    return GoGolemNGUID;
                case DATA_GOLEM_DOOR_S:
                    return GoGolemSGUID;
                case DATA_GO_CHALICE:
                    return GoSpectralChaliceGUID;
                case DATA_MAGMUS:
                {
                    return MagmusGUID;
                }
            }

            return ObjectGuid::Empty;
        }

        std::string GetSaveData() override
        {
            return str_data;
        }

        void Load(const char* in) override
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            std::istringstream loadStream(in);
            loadStream >> encounter[0] >> encounter[1] >> encounter[2] >> encounter[3]
                       >> encounter[4] >> encounter[5] >> GhostKillCount;

            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (encounter[i] == IN_PROGRESS)
                    encounter[i] = NOT_STARTED;
            if (GhostKillCount > 0 && GhostKillCount < 7)
                GhostKillCount = 0;//reset tomb of seven event
            if (GhostKillCount >= 7)
                GhostKillCount = 7;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        void TombOfSevenEvent()
        {
            if (GhostKillCount < 7 && TombBossGUIDs[TombEventCounter])
            {
                if (Creature* boss = instance->GetCreature(TombBossGUIDs[TombEventCounter]))
                {
                    ++TombEventCounter;
                    boss->SetFaction(FACTION_DARK_IRON_DWARVES);
                    boss->SetImmuneToPC(false);

                    // find suitable target here.
                    Player* target = boss->SelectNearestPlayer(130);
                    if (target && boss->CanCreatureAttack(target, true))
                    {
                        boss->AI()->AttackStart(target);
                        boss->AI()->DoZoneInCombat();
                        tombResetTimer = TIMER_TOMB_RESET;
                    }
                }
            }
        }

        void TombOfSevenReset()
        {
            HandleGameObject(GoTombExitGUID, false);// close exit door
            HandleGameObject(GoTombEnterGUID, true);// open entrance door
            for (uint8 i = 0; i < 7; ++i)
            {
                if (Creature* boss = instance->GetCreature(TombBossGUIDs[i]))
                {
                    if (!boss->IsAlive())
                    {
                        //do not call EnterEvadeMode(), it will create infinit loops
                        boss->Respawn();
                        boss->RemoveAllAuras();
                        boss->GetThreatMgr().ClearAllThreat();
                        boss->CombatStop(true);
                        boss->LoadCreaturesAddon(true);
                        boss->GetMotionMaster()->MoveTargetedHome();
                        boss->SetLootRecipient(nullptr);
                    }
                    boss->SetFaction(FACTION_FRIENDLY);
                    boss->SetImmuneToPC(true); // think this is useless
                    if (i == 6) // doomrel needs explicit reset
                    {
                        boss->AI()->Reset();
                    }
                }
            }

            GhostKillCount = 0;
            TombEventCounter = 0;
            TombTimer = TIMER_TOMB_START;
            SetData(TYPE_TOMB_OF_SEVEN, NOT_STARTED);
        }

        bool CheckTombReset(uint32 diff)
        {
            bool anyBossAlive = false; // status of the bosses up until the current one
            for (uint8 i = 0; i < TombEventCounter; i++)
            {
                Creature* boss = instance->GetCreature(TombBossGUIDs[i]);
                if (boss)
                {
                    anyBossAlive |= boss->IsAlive();
                    if (boss->IsAlive() && boss->IsInCombat())
                    {
                        tombResetTimer = TIMER_TOMB_RESET;
                        return false;  // any boss in combat means we shouldn't reset.
                    }
                }
            }
            if (!anyBossAlive) // no boss alive, put reset timer back up
            {
                tombResetTimer = TIMER_TOMB_RESET;
            }
            tombResetTimer -= diff;
            return tombResetTimer < diff;
        }

        void Update(uint32 diff) override
        {
            if ((GetData(TYPE_TOMB_OF_SEVEN) == IN_PROGRESS) && GhostKillCount < 7)
            {
                if (TombTimer <= diff)
                {
                    TombTimer = TIMER_TOMBOFTHESEVEN;
                    TombOfSevenEvent();
                }
                else
                {
                    TombTimer -= diff;
                }

                if (CheckTombReset(diff))
                {
                    TombOfSevenReset();
                }
            }
        }
    };
};

void AddSC_instance_blackrock_depths()
{
    new instance_blackrock_depths();
}
