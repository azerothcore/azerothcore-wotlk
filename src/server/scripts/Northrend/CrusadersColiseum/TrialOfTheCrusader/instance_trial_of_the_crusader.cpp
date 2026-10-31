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

#include "Containers.h"
#include "GameTime.h"
#include "Group.h"
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Vehicle.h"
#include "WorldStateDefines.h"
#include "trial_of_the_crusader.h"
#include <algorithm>
#include <array>

enum InstanceMisc
{
    VEHICLE_SNOBOLD_CARRIER         = 497,
    GO_PORTAL_TO_DALARAN            = 195682,
    ITEM_VALANYR                    = 46017,
    MAX_ATTEMPTS                    = 50,
    DEDICATED_INSANITY_ITEM_LEVEL   = 245,
};

enum InstanceSpells
{
    SPELL_BERSERK                   = 26662,
    SPELL_FEL_LIGHTNING             = 67888,
    SPELL_ARTHAS_PORTAL             = 51807,
    SPELL_DESTROY_FLOOR_KNOCKUP     = 68193,
};

enum NorthrendBeastsMask
{
    BEASTS_MASK_GORMOK_DEAD         = 0x01,
    BEASTS_MASK_JORMUNGARS_DEAD     = 0x02,
    BEASTS_MASK_ICEHOWL_DEAD        = 0x04,
    BEASTS_MASK_ALL_DEAD            = BEASTS_MASK_GORMOK_DEAD | BEASTS_MASK_JORMUNGARS_DEAD | BEASTS_MASK_ICEHOWL_DEAD,
    // Set once the next stage is let in, by the heroic timer or by the previous stage dying
    BEASTS_MASK_JORMUNGARS_RELEASED = 0x10,
    BEASTS_MASK_ICEHOWL_RELEASED    = 0x20,
};

// ToC 10 normal/heroic drops and item level 245 items bought with Emblems of Triumph, sorted for std::binary_search
constexpr std::array<uint32, 405> DedicatedInsanityItems =
{
    47658, 47659, 47660, 47661, 47662, 47664, 47665, 47666, 47667, 47668, 47670, 47671, 47672, 47673, 47674, 47675, 47677, 47678, 47681, 47682, 47684, 47685, 47686, 47687, 47688, 47689, 47690, 47691, 47692, 47693,
    47694, 47695, 47696, 47697, 47698, 47699, 47701, 47702, 47704, 47705, 47706, 47707, 47708, 47709, 47710, 47712, 47713, 47714, 47715, 47716, 47729, 47730, 47731, 47732, 47733, 47734, 47735, 47753, 47754, 47755,
    47756, 47757, 47768, 47769, 47770, 47771, 47772, 47778, 47779, 47780, 47781, 47782, 47803, 47804, 47805, 47806, 47807, 47915, 47916, 47917, 47918, 47919, 47920, 47921, 47922, 47923, 47924, 47925, 47926, 47927,
    47928, 47929, 47930, 47931, 47932, 47933, 47934, 47935, 47937, 47938, 47939, 47940, 47941, 47942, 47943, 47944, 47945, 47946, 47947, 47948, 47949, 47950, 47951, 47952, 47953, 47954, 47955, 47956, 47957, 47958,
    47959, 47960, 47961, 47962, 47963, 47964, 47965, 47966, 47967, 47968, 47969, 47970, 47971, 47972, 47973, 47974, 47975, 47976, 47977, 47978, 47979, 47983, 47984, 47985, 47986, 47987, 47988, 47989, 47990, 47991,
    47992, 47993, 47994, 47995, 47996, 47997, 47998, 47999, 48000, 48001, 48002, 48003, 48004, 48005, 48006, 48007, 48008, 48009, 48010, 48011, 48012, 48013, 48014, 48015, 48016, 48017, 48018, 48019, 48020, 48021,
    48022, 48023, 48024, 48025, 48026, 48027, 48028, 48030, 48032, 48034, 48036, 48038, 48039, 48040, 48041, 48042, 48043, 48044, 48045, 48046, 48047, 48048, 48049, 48050, 48051, 48052, 48053, 48054, 48055, 48056,
    48062, 48063, 48064, 48065, 48066, 48077, 48078, 48079, 48080, 48081, 48092, 48093, 48094, 48095, 48096, 48133, 48134, 48135, 48136, 48137, 48148, 48149, 48150, 48151, 48152, 48163, 48164, 48165, 48166, 48167,
    48178, 48179, 48180, 48181, 48182, 48193, 48194, 48195, 48196, 48197, 48208, 48209, 48210, 48211, 48212, 48223, 48224, 48225, 48226, 48227, 48238, 48239, 48240, 48241, 48242, 48255, 48256, 48257, 48258, 48259,
    48270, 48271, 48272, 48273, 48274, 48285, 48286, 48287, 48288, 48289, 48300, 48301, 48302, 48303, 48304, 48316, 48317, 48318, 48319, 48320, 48331, 48332, 48333, 48334, 48335, 48346, 48347, 48348, 48349, 48350,
    48361, 48362, 48363, 48364, 48365, 48376, 48377, 48378, 48379, 48380, 48391, 48392, 48393, 48394, 48395, 48430, 48446, 48450, 48452, 48454, 48461, 48462, 48463, 48464, 48465, 48481, 48482, 48483, 48484, 48485,
    48496, 48497, 48498, 48499, 48500, 48538, 48539, 48540, 48541, 48542, 48553, 48554, 48555, 48556, 48557, 48575, 48576, 48577, 48578, 48579, 48590, 48591, 48592, 48593, 48594, 48607, 48608, 48609, 48610, 48611,
    48622, 48623, 48624, 48625, 48626, 48637, 48638, 48639, 48640, 48641, 48657, 48658, 48659, 48660, 48661, 48666, 48667, 48668, 48669, 48670, 48671, 48672, 48673, 48674, 48675, 48693, 48695, 48697, 48699, 48701,
    48703, 48705, 48708, 48709, 48710, 48711, 48712, 48713, 48714, 48722, 48724, 49233, 49234, 49237, 49238
};

ObjectData const creatureData[] =
{
    { NPC_BARRETT_BEASTS,            DATA_BARRETT               },
    { NPC_BARRETT_BEASTS_HC,         DATA_BARRETT               },
    { NPC_BARRETT_JARAXXUS,          DATA_BARRETT               },
    { NPC_BARRETT_FACTION_CHAMPIONS, DATA_BARRETT               },
    { NPC_BARRETT_VALKYR,            DATA_BARRETT               },
    { NPC_BARRETT_LICH_KING,         DATA_BARRETT               },
    { NPC_TIRION,                    DATA_TIRION                },
    { NPC_FIZZLEBANG,                DATA_FIZZLEBANG            },
    { NPC_GARROSH,                   DATA_GARROSH               },
    { NPC_VARIAN,                    DATA_VARIAN                },
    { NPC_GORMOK,                    DATA_GORMOK                },
    { NPC_DREADSCALE,                DATA_DREADSCALE            },
    { NPC_ACIDMAW,                   DATA_ACIDMAW               },
    { NPC_ICEHOWL,                   DATA_ICEHOWL               },
    { NPC_BEASTS_COMBAT_STALKER,     DATA_BEASTS_COMBAT_STALKER },
    { NPC_JARAXXUS,                  DATA_JARAXXUS              },
    { NPC_LIGHTBANE,                 DATA_LIGHTBANE             },
    { NPC_DARKBANE,                  DATA_DARKBANE              },
    { NPC_LICH_KING,                 DATA_LICH_KING             },
    { NPC_ANUBARAK,                  DATA_ANUBARAK              },
    { 0,                             0                          }
};

ObjectData const gameObjectData[] =
{
    { GO_MAIN_GATE_DOOR,             DATA_MAIN_GATE             },
    { GO_EAST_PORTCULLIS,            DATA_ENTER_GATE            },
    { GO_WEB_DOOR,                   DATA_WEB_DOOR              },
    { GO_ARGENT_COLISEUM_FLOOR,      DATA_FLOOR                 },
    { 0,                             0                          }
};

struct instance_trial_of_the_crusader : public InstanceScript
{
    instance_trial_of_the_crusader(Map* map) : InstanceScript(map)
    {
        SetHeaders(DataHeader);
        SetBossNumber(MAX_ENCOUNTERS);
        LoadObjectData(creatureData, gameObjectData);
        Initialize();
    }

    void Initialize() override
    {
        _cleaned = false;
        _instanceProgress = INSTANCE_PROGRESS_INITIAL;
        _attemptsLeft = MAX_ATTEMPTS;
        _killCounter = 0;
        _northrendBeastsMask = 0;
        _achievementTimer = 0s;
        _dedicatedInsanity = true;
        _checkDedicatedInsanity = false;
        _noOneDied = true;
        _events.Reset();
        _events.RescheduleEvent(EVENT_CHECK_PLAYERS, 0ms);

        _championGUIDs.clear();
        _championPetGUIDs.clear();
    }

    void OnCreatureCreate(Creature* creature) override
    {
        InstanceScript::OnCreatureCreate(creature);

        switch (creature->GetEntry())
        {
            case NPC_ZHAAGRYM:
            case NPC_CAT:
                _championPetGUIDs.push_back(creature->GetGUID());
                break;
            default:
                break;
        }
    }

    void OnGameObjectCreate(GameObject* go) override
    {
        InstanceScript::OnGameObjectCreate(go);

        switch (go->GetEntry())
        {
            case GO_MAIN_GATE_DOOR:
            case GO_SOUTH_PORTCULLIS:
            case GO_NORTH_PORTCULLIS:
                HandleGameObject(ObjectGuid::Empty, false, go);
                break;
            case GO_WEB_DOOR:
            case GO_EAST_PORTCULLIS:
                HandleGameObject(ObjectGuid::Empty, true, go);
                break;
            case GO_ARGENT_COLISEUM_FLOOR:
                if (_instanceProgress == INSTANCE_PROGRESS_ANUB_ARAK)
                    go->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);
                break;
            default:
                break;
        }
    }

    void OnPlayerEnter(Player* player) override
    {
        InstanceScript::OnPlayerEnter(player);

        player->SendUpdateWorldState(WORLD_STATE_TRIAL_OF_THE_CRUSADER_UI_SHOW, instance->IsHeroic() ? 1 : 0);
        if (instance->IsHeroic())
            player->SendUpdateWorldState(WORLD_STATE_TRIAL_OF_THE_CRUSADER_UI_COUNT, _attemptsLeft);

        if (DoNeedCleanup(player))
            InstanceCleanup();

        if (GetBossState(BOSS_NORTHREND_BEASTS) == IN_PROGRESS)
            SetSnoboldCarrier(player, true);

        // if missing spawn anub'arak
        SpawnAnubArak();

        _events.RescheduleEvent(EVENT_CHECK_PLAYERS, 5s);
    }

    void OnUnitDeath(Unit* unit) override
    {
        if (_noOneDied && unit->IsPlayer())
        {
            _noOneDied = false;
            SaveToDB();
        }
    }

    void SetData(uint32 type, uint32 data) override
    {
        switch (type)
        {
            case TYPE_FAILED:
                if (instance->IsHeroic() && !_cleaned)
                {
                    if (_attemptsLeft > 0)
                        --_attemptsLeft;
                    DoUpdateWorldState(WORLD_STATE_TRIAL_OF_THE_CRUSADER_UI_COUNT, _attemptsLeft);
                }
                InstanceCleanup(true);
                SaveToDB();
                break;
            case TYPE_ANNOUNCER_GOSSIP_SELECT:
                if (instance->IsHeroic() && !_attemptsLeft)
                    break;

                switch (_instanceProgress)
                {
                    case INSTANCE_PROGRESS_INITIAL:
                        _events.RescheduleEvent(EVENT_SCENE_001, 0ms);
                        break;
                    case INSTANCE_PROGRESS_INTRO_DONE:
                        _events.RescheduleEvent(EVENT_SCENE_004, 0ms);
                        break;
                    case INSTANCE_PROGRESS_BEASTS_DEAD:
                        _events.RescheduleEvent(EVENT_SCENE_101, 0ms);
                        break;
                    case INSTANCE_PROGRESS_JARAXXUS_INTRO_DONE:
                        _events.RescheduleEvent(EVENT_JARAXXUS_ATTACK, 0ms);
                        break;
                    case INSTANCE_PROGRESS_JARAXXUS_DEAD:
                        _events.RescheduleEvent(EVENT_SCENE_201, 0ms);
                        break;
                    case INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD:
                        _events.RescheduleEvent(EVENT_SCENE_301, 0ms);
                        break;
                    case INSTANCE_PROGRESS_VALKYR_DEAD:
                        _events.RescheduleEvent(EVENT_SCENE_401, 0ms);
                        break;
                    default:
                        break;
                }
                break;
            case TYPE_GORMOK:
                if (data == DONE && !SetBeastDead(BEASTS_MASK_GORMOK_DEAD) && !(_northrendBeastsMask & BEASTS_MASK_JORMUNGARS_RELEASED))
                    _events.RescheduleEvent(EVENT_SCENE_005, 2500ms);
                break;
            case TYPE_JORMUNGAR:
                if (data == DONE)
                {
                    if (++_killCounter == 2)
                    {
                        if (Creature* acidmaw = GetCreature(DATA_ACIDMAW))
                            acidmaw->DespawnOrUnsummon(10s);
                        if (Creature* dreadscale = GetCreature(DATA_DREADSCALE))
                            dreadscale->DespawnOrUnsummon(10s);
                        if (_achievementTimer + 10s >= GameTime::GetGameTime())
                            DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_JORMUNGAR_ACHIEV);
                        _achievementTimer = 0s;

                        if (!SetBeastDead(BEASTS_MASK_JORMUNGARS_DEAD) && !(_northrendBeastsMask & BEASTS_MASK_ICEHOWL_RELEASED))
                            _events.RescheduleEvent(EVENT_SCENE_006, 2500ms);
                    }
                    else // first one died, start timer for achievement
                        _achievementTimer = GameTime::GetGameTime();
                }
                else
                    _achievementTimer = 0s;
                break;
            case TYPE_ICEHOWL:
                if (data == DONE)
                    SetBeastDead(BEASTS_MASK_ICEHOWL_DEAD);
                break;
            case TYPE_FACTION_CHAMPIONS:
                if (data == DONE)
                {
                    if (++_killCounter >= _championGUIDs.size())
                        SetBossState(BOSS_FACTION_CHAMPIONS, DONE);
                    else if (_killCounter == 1)
                        _achievementTimer = GameTime::GetGameTime();
                }
                break;
            case TYPE_FACTION_CHAMPIONS_START:
                _achievementTimer = 0s;
                for (ObjectGuid const& guid : _championGUIDs)
                    if (Creature* champion = instance->GetCreature(guid))
                        if (!champion->IsInCombat())
                            if (Unit* target = champion->SelectNearestTarget(200.0f))
                                champion->AI()->AttackStart(target);
                break;
            case TYPE_FACTION_CHAMPIONS_PLAYER_DIED:
                if (urand(0, 2) == 0)
                {
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        CreatureTalk(DATA_VARIAN, SAY_VARIAN_KILL_HORDE_PLAYER_1);
                    else
                        CreatureTalk(DATA_GARROSH, SAY_GARROSH_KILL_ALLIANCE_PLAYER_1);
                }
                break;
            default:
                break;
        }
    }

    uint32 GetData(uint32 type) const override
    {
        if (type == TYPE_INSTANCE_PROGRESS)
            return _instanceProgress;

        return 0;
    }

    bool SetBossState(uint32 type, EncounterState state) override
    {
        if (!InstanceScript::SetBossState(type, state))
            return false;

        switch (type)
        {
            case BOSS_NORTHREND_BEASTS:
                if (state == DONE)
                {
                    _northrendBeastsMask = 0;
                    _instanceProgress = INSTANCE_PROGRESS_BEASTS_DEAD;
                    SetSnoboldCarriers(false);
                    DespawnBeastsCombatStalker();
                    HandleGameObject(DATA_ENTER_GATE, true);
                    _events.CancelEvent(EVENT_NORTHREND_BEASTS_ENRAGE);
                    _events.RescheduleEvent(EVENT_SCENE_BEASTS_DONE, 2500ms);
                    SaveToDB();
                }
                break;
            case BOSS_JARAXXUS:
                if (state == IN_PROGRESS)
                    HandleGameObject(DATA_ENTER_GATE, false);
                else if (state == DONE)
                {
                    HandleGameObject(DATA_ENTER_GATE, true);
                    _instanceProgress = INSTANCE_PROGRESS_JARAXXUS_DEAD;
                    _events.RescheduleEvent(EVENT_SCENE_110, 2500ms);
                    SaveToDB();
                }
                break;
            case BOSS_FACTION_CHAMPIONS:
                if (state == DONE)
                {
                    if (Creature* tirion = GetCreature(DATA_TIRION))
                        tirion->CastSpell(tirion, SPELL_FACTION_CHAMPIONS_KILL_CREDIT, true);
                    _instanceProgress = INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD;
                    _events.RescheduleEvent(EVENT_SCENE_FACTION_CHAMPIONS_DEAD, 2500ms);

                    for (ObjectGuid const& guid : _championGUIDs)
                        if (Creature* champion = instance->GetCreature(guid))
                            champion->DespawnOrUnsummon(15s);
                    _championGUIDs.clear();
                    DespawnChampionPets();

                    if (Creature* tirion = GetCreature(DATA_TIRION))
                    {
                        Position const& center = Locs[LOC_CENTER];
                        if (GameObject* cache = tirion->SummonGameObject(GetCrusadersCacheEntry(), center.GetPositionX(), center.GetPositionY(), center.GetPositionZ(), center.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 630000000))
                            cache->SetLootRecipient(instance);
                    }

                    HandleGameObject(DATA_ENTER_GATE, true);

                    if (_achievementTimer + 60s >= GameTime::GetGameTime())
                        DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_RESILIENCE_WILL_FIX_IT_CREDIT);
                    _achievementTimer = 0s;

                    SaveToDB();
                }
                break;
            case BOSS_TWIN_VALKYR:
                if (state == DONE)
                {
                    _instanceProgress = INSTANCE_PROGRESS_VALKYR_DEAD;
                    DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, NPC_LIGHTBANE, 1);
                    DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, NPC_DARKBANE, 1);
                    _events.RescheduleEvent(EVENT_SCENE_VALKYR_DEAD, 2500ms);
                    HandleGameObject(DATA_ENTER_GATE, true);
                    SaveToDB();
                }
                break;
            case BOSS_ANUBARAK:
                if (state == IN_PROGRESS)
                    HandleGameObject(DATA_WEB_DOOR, false);
                else if (state == DONE)
                {
                    _instanceProgress = INSTANCE_PROGRESS_DONE;
                    HandleGameObject(DATA_ENTER_GATE, true);
                    HandleGameObject(DATA_WEB_DOOR, true);
                    SaveToDB();

                    if (Creature* tirion = GetCreature(DATA_TIRION))
                    {
                        tirion->UpdatePosition(Locs[LOC_TIRION_FINAL], true);
                        tirion->StopMovingOnCurrentPos();
                        tirion->SetFacingTo(Locs[LOC_TIRION_FINAL].GetOrientation());
                        _events.RescheduleEvent(EVENT_SCENE_501, 20s);
                    }
                    if (GameObject* floor = GetGameObject(DATA_FLOOR))
                        floor->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, nullptr, true);
                }
                break;
            default:
                break;
        }

        return true;
    }

    void Update(uint32 diff) override
    {
        _events.Update(diff);
        switch (_events.ExecuteEvent())
        {
            case EVENT_CHECK_PLAYERS:
                // Dedicated Insanity is checked on every other tick
                if (_checkDedicatedInsanity)
                    DoCheckDedicatedInsanity();
                _checkDedicatedInsanity = !_checkDedicatedInsanity;

                if (DoNeedCleanup())
                    InstanceCleanup();

                // Entering mounted loses the kit: the mount removal on arrival dismounts, which drops vehicle kits
                if (GetBossState(BOSS_NORTHREND_BEASTS) == IN_PROGRESS)
                    SetSnoboldCarriers(true);

                _events.Repeat(5s);
                break;
            case EVENT_OPEN_GATE:
                HandleGameObject(DATA_MAIN_GATE, true);
                break;
            case EVENT_CLOSE_GATE:
                HandleGameObject(DATA_MAIN_GATE, false);
                break;
            case EVENT_SCENE_001:
                CreatureTalk(DATA_TIRION, SAY_STAGE_0_01);
                _events.RescheduleEvent(EVENT_SCENE_002, 22s);
                break;
            case EVENT_SCENE_002:
                CreatureTalk(DATA_VARIAN, SAY_STAGE_0_03a);
                _events.RescheduleEvent(EVENT_SCENE_003, 5s);
                break;
            case EVENT_SCENE_003:
                CreatureTalk(DATA_GARROSH, SAY_STAGE_0_03h);
                _events.RescheduleEvent(EVENT_SCENE_004, 8s);
                break;
            case EVENT_SCENE_004:
                _instanceProgress = INSTANCE_PROGRESS_INTRO_DONE;
                SetBossState(BOSS_NORTHREND_BEASTS, IN_PROGRESS);

                CreatureTalk(DATA_TIRION, SAY_STAGE_0_02);
                HandleGameObject(DATA_MAIN_GATE, true);
                HandleGameObject(DATA_ENTER_GATE, false);

                // Keeps the raid in combat from the gate opening until the last beast dies
                if (Creature* stalker = instance->SummonCreature(NPC_BEASTS_COMBAT_STALKER, Locs[LOC_BEASTS_COMBAT_STALKER]))
                {
                    stalker->SetCombatPulseDelay(5);
                    stalker->AI()->DoZoneInCombat();
                }

                _events.RescheduleEvent(EVENT_SUMMON_GORMOK, 1s);
                if (instance->IsHeroic())
                {
                    _events.RescheduleEvent(EVENT_SCENE_005, 150s);
                    _events.RescheduleEvent(EVENT_SCENE_006, 340s);
                    _events.RescheduleEvent(EVENT_NORTHREND_BEASTS_ENRAGE, 520s);
                }
                break;
            case EVENT_NORTHREND_BEASTS_ENRAGE:
                for (uint32 type : { DATA_GORMOK, DATA_ACIDMAW, DATA_DREADSCALE, DATA_ICEHOWL })
                    if (Creature* beast = GetCreature(type))
                        if (beast->IsAlive())
                            beast->CastSpell(beast, SPELL_BERSERK, true);
                break;
            case EVENT_SUMMON_GORMOK:
                SetSnoboldCarriers(true);
                if (Creature* tirion = GetCreature(DATA_TIRION))
                    if (Creature* gormok = tirion->SummonCreature(NPC_GORMOK, Locs[LOC_BEHIND_GATE], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000))
                        gormok->GetMotionMaster()->MovePoint(0, Locs[LOC_GATE_FRONT].GetPositionX(), Locs[LOC_GATE_FRONT].GetPositionY(), Locs[LOC_GATE_FRONT].GetPositionZ());

                _events.RescheduleEvent(EVENT_GORMOK_ATTACK, 10s);
                _events.RescheduleEvent(EVENT_CLOSE_GATE, 6s);
                break;
            case EVENT_GORMOK_ATTACK:
                _northrendBeastsMask = 0;
                StartAttack(DATA_GORMOK);
                break;
            case EVENT_SCENE_005:
                _northrendBeastsMask |= BEASTS_MASK_JORMUNGARS_RELEASED;
                CreatureTalk(DATA_TIRION, SAY_STAGE_0_04);
                _events.RescheduleEvent(EVENT_OPEN_GATE, 3s);
                _events.RescheduleEvent(EVENT_SUMMON_DREADSCALE, 4s);
                break;
            case EVENT_SUMMON_DREADSCALE:
                if (Creature* tirion = GetCreature(DATA_TIRION))
                    if (Creature* dreadscale = tirion->SummonCreature(NPC_DREADSCALE, Locs[LOC_BEHIND_GATE], TEMPSUMMON_MANUAL_DESPAWN))
                        dreadscale->GetMotionMaster()->MovePoint(0, Locs[LOC_BEHIND_GATE].GetPositionX(), Locs[LOC_BEHIND_GATE].GetPositionY() - 25.0f, Locs[LOC_BEHIND_GATE].GetPositionZ());

                _events.RescheduleEvent(EVENT_SCENE_005_2, 4s);
                break;
            case EVENT_SUMMON_ACIDMAW:
                if (Creature* tirion = GetCreature(DATA_TIRION))
                    tirion->SummonCreature(NPC_ACIDMAW, Locs[LOC_ACIDMAW], TEMPSUMMON_MANUAL_DESPAWN);
                break;
            case EVENT_SCENE_005_2:
                if (Creature* dreadscale = GetCreature(DATA_DREADSCALE))
                    dreadscale->GetMotionMaster()->MovePoint(0, Locs[LOC_DREADSCALE].GetPositionX(), Locs[LOC_DREADSCALE].GetPositionY(), Locs[LOC_DREADSCALE].GetPositionZ());

                _events.RescheduleEvent(EVENT_SUMMON_ACIDMAW, 4300ms);
                _events.RescheduleEvent(EVENT_ACIDMAW_AND_DREADSCALE_ATTACK, 6700ms);
                break;
            case EVENT_ACIDMAW_AND_DREADSCALE_ATTACK:
                HandleGameObject(DATA_MAIN_GATE, false);
                StartAttack(DATA_DREADSCALE);
                StartAttack(DATA_ACIDMAW);
                break;
            case EVENT_SCENE_006:
                _northrendBeastsMask |= BEASTS_MASK_ICEHOWL_RELEASED;
                CreatureTalk(DATA_TIRION, SAY_STAGE_0_05);
                _events.RescheduleEvent(EVENT_OPEN_GATE, 2s);
                _events.RescheduleEvent(EVENT_SUMMON_ICEHOWL, 3s);
                break;
            case EVENT_SUMMON_ICEHOWL:
                if (Creature* tirion = GetCreature(DATA_TIRION))
                    if (Creature* icehowl = tirion->SummonCreature(NPC_ICEHOWL, Locs[LOC_BEHIND_GATE], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000))
                        icehowl->GetMotionMaster()->MovePoint(0, Locs[LOC_GATE_FRONT].GetPositionX(), Locs[LOC_GATE_FRONT].GetPositionY(), Locs[LOC_GATE_FRONT].GetPositionZ());

                _events.RescheduleEvent(EVENT_ICEHOWL_ATTACK, 10s);
                _events.RescheduleEvent(EVENT_CLOSE_GATE, 6s);
                break;
            case EVENT_ICEHOWL_ATTACK:
                StartAttack(DATA_ICEHOWL);
                break;
            case EVENT_SCENE_BEASTS_DONE:
                CreatureTalk(DATA_TIRION, SAY_STAGE_0_06);
                _events.RescheduleEvent(EVENT_SUMMON_BARRETT, 5200ms);
                break;
            case EVENT_SUMMON_BARRETT:
                SummonBarrett();
                break;
            case EVENT_SCENE_101:
                if (Creature* tirion = GetCreature(DATA_TIRION))
                {
                    HandleGameObject(DATA_MAIN_GATE, true);
                    tirion->AI()->Talk(SAY_STAGE_1_01);
                    if (Creature* fizzlebang = tirion->SummonCreature(NPC_FIZZLEBANG, Locs[LOC_BEHIND_GATE], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 300000))
                    {
                        fizzlebang->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        fizzlebang->GetMotionMaster()->MovePoint(0, Locs[LOC_BEHIND_GATE].GetPositionX(), Locs[LOC_BEHIND_GATE].GetPositionY() - 65.0f, Locs[LOC_BEHIND_GATE].GetPositionZ() - 1.0f);
                    }
                    _events.RescheduleEvent(EVENT_SCENE_102, 20s);

                    // move Icehowl to side, can't remove corpse because of loot!
                    if (Creature* icehowl = GetCreature(DATA_ICEHOWL))
                    {
                        icehowl->UpdatePosition(513.19f, 139.48f, 395.22f, 3 * M_PI / 2, true);
                        icehowl->StopMovingOnCurrentPos();
                        icehowl->DestroyForVisiblePlayers();
                    }
                }
                break;
            case EVENT_SCENE_102:
                HandleGameObject(DATA_MAIN_GATE, false);
                CreatureTalk(DATA_FIZZLEBANG, SAY_STAGE_1_02);
                _events.RescheduleEvent(EVENT_WILFRED_TALK_EMOTE, 3s);
                _events.RescheduleEvent(EVENT_WILFRED_STOP_TALK_EMOTE, 10400ms);
                _events.RescheduleEvent(EVENT_SCENE_103, 11s);
                break;
            case EVENT_WILFRED_TALK_EMOTE:
                if (Creature* fizzlebang = GetCreature(DATA_FIZZLEBANG))
                    fizzlebang->SetEmoteState(EMOTE_STATE_TALK);
                break;
            case EVENT_WILFRED_STOP_TALK_EMOTE:
                if (Creature* fizzlebang = GetCreature(DATA_FIZZLEBANG))
                    fizzlebang->SetEmoteState(EMOTE_ONESHOT_NONE);
                break;
            case EVENT_SCENE_103:
                if (Creature* fizzlebang = GetCreature(DATA_FIZZLEBANG))
                {
                    fizzlebang->AI()->Talk(SAY_STAGE_1_03);
                    if (Creature* trigger = fizzlebang->SummonCreature(NPC_PURPLE_GROUND, Locs[LOC_CENTER], TEMPSUMMON_MANUAL_DESPAWN))
                        _purpleGroundGUID = trigger->GetGUID();
                    if (Creature* portal = fizzlebang->SummonCreature(NPC_OPEN_PORTAL_TARGET, Locs[LOC_OPEN_PORTAL_TARGET], TEMPSUMMON_MANUAL_DESPAWN))
                        _portalGUID = portal->GetGUID();
                    fizzlebang->CastSpell(fizzlebang, SPELL_OPEN_PORTAL);
                }

                _events.RescheduleEvent(EVENT_SUMMON_JARAXXUS, 11s);
                break;
            case EVENT_SUMMON_JARAXXUS:
                if (Creature* fizzlebang = GetCreature(DATA_FIZZLEBANG))
                {
                    if (Creature* jaraxxus = fizzlebang->SummonCreature(NPC_JARAXXUS, Locs[LOC_CENTER], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000))
                        jaraxxus->GetMotionMaster()->MovePoint(0, Locs[LOC_CENTER].GetPositionX(), Locs[LOC_CENTER].GetPositionY() - 10.0f, Locs[LOC_CENTER].GetPositionZ());
                    fizzlebang->AI()->Talk(SAY_STAGE_1_04);
                }

                _events.RescheduleEvent(EVENT_WILFRED_TALK_EMOTE, 2600ms);
                _events.RescheduleEvent(EVENT_WILFRED_STOP_TALK_EMOTE, 8700ms);
                _events.RescheduleEvent(EVENT_SCENE_105, 3s);
                break;
            case EVENT_SCENE_105:
                if (Creature* jaraxxus = GetCreature(DATA_JARAXXUS))
                    jaraxxus->SetFacingTo(M_PI / 2);
                _events.RescheduleEvent(EVENT_SCENE_106, 10s);
                break;
            case EVENT_SCENE_106:
                CreatureTalk(DATA_JARAXXUS, SAY_STAGE_1_05);
                _events.RescheduleEvent(EVENT_SCENE_107, 5s);
                break;
            case EVENT_SCENE_107:
                CreatureTalk(DATA_FIZZLEBANG, SAY_STAGE_1_06);
                if (Creature* purpleGround = instance->GetCreature(_purpleGroundGUID))
                    purpleGround->DespawnOrUnsummon();
                _purpleGroundGUID.Clear();

                _events.RescheduleEvent(EVENT_SCENE_108, 800ms);
                break;
            case EVENT_SCENE_108:
                if (Creature* jaraxxus = GetCreature(DATA_JARAXXUS))
                {
                    jaraxxus->AI()->Talk(SAY_STAGE_1_06_1);
                    if (Creature* fizzlebang = GetCreature(DATA_FIZZLEBANG))
                    {
                        jaraxxus->CastSpell(fizzlebang, SPELL_FEL_LIGHTNING, true);
                        Unit::Kill(fizzlebang, fizzlebang);
                    }
                }

                _events.RescheduleEvent(EVENT_SCENE_109, 5s);
                break;
            case EVENT_SCENE_109:
                if (Creature* jaraxxus = GetCreature(DATA_JARAXXUS))
                    jaraxxus->SetFacingTo(3 * M_PI / 2);
                CreatureTalk(DATA_TIRION, SAY_STAGE_1_07);
                _events.RescheduleEvent(EVENT_JARAXXUS_ATTACK, 6s);
                break;
            case EVENT_JARAXXUS_ATTACK:
                _instanceProgress = INSTANCE_PROGRESS_JARAXXUS_INTRO_DONE;
                StartAttack(DATA_JARAXXUS);
                break;
            case EVENT_SCENE_110:
                CreatureTalk(DATA_TIRION, SAY_STAGE_1_08);
                _events.RescheduleEvent(EVENT_SCENE_111, 18s);
                break;
            case EVENT_SCENE_111:
                CreatureTalk(DATA_GARROSH, SAY_STAGE_1_09);
                _events.RescheduleEvent(EVENT_SCENE_112, 9s);
                break;
            case EVENT_SCENE_112:
                CreatureTalk(DATA_VARIAN, SAY_STAGE_1_10);
                _events.RescheduleEvent(EVENT_SCENE_113, 5s);
                break;
            case EVENT_SCENE_113:
                CreatureTalk(DATA_TIRION, SAY_STAGE_1_11);
                _events.RescheduleEvent(EVENT_SUMMON_BARRETT, 16s);
                break;
            case EVENT_SCENE_201:
                // move Jaraxxus to side, can't remove corpse because of loot!
                if (Creature* jaraxxus = GetCreature(DATA_JARAXXUS))
                {
                    jaraxxus->UpdatePosition(613.83f, 139.5f, 395.22f, 3 * M_PI / 2, true);
                    jaraxxus->StopMovingOnCurrentPos();
                    jaraxxus->DestroyForVisiblePlayers();
                }

                CreatureTalk(DATA_TIRION, SAY_STAGE_2_01);
                _events.RescheduleEvent(EVENT_SCENE_202, 9s);
                break;
            case EVENT_SCENE_202:
                if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                {
                    CreatureTalk(DATA_GARROSH, SAY_STAGE_2_02h);
                    _events.RescheduleEvent(EVENT_SCENE_203, 15s);
                }
                else
                {
                    CreatureTalk(DATA_VARIAN, SAY_STAGE_2_02a);
                    _events.RescheduleEvent(EVENT_SCENE_203, 18s);
                }
                break;
            case EVENT_SCENE_203:
                CreatureTalk(DATA_TIRION, SAY_STAGE_2_03);
                _events.RescheduleEvent(EVENT_SCENE_204, 5s);
                break;
            case EVENT_SCENE_204:
                if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                {
                    CreatureTalk(DATA_GARROSH, SAY_STAGE_2_04h);
                    _events.RescheduleEvent(EVENT_SCENE_205, 6s);
                }
                else
                {
                    CreatureTalk(DATA_VARIAN, SAY_STAGE_2_04a);
                    _events.RescheduleEvent(EVENT_SCENE_205, 5s);
                }

                _events.RescheduleEvent(EVENT_SUMMON_CHAMPIONS, 2500ms);
                break;
            case EVENT_SCENE_205:
                if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                    CreatureTalk(DATA_VARIAN, SAY_STAGE_2_05a);
                else
                    CreatureTalk(DATA_GARROSH, SAY_STAGE_2_05h);
                break;
            case EVENT_SUMMON_CHAMPIONS:
                SummonFactionChampions();
                HandleGameObject(DATA_ENTER_GATE, false);
                _events.RescheduleEvent(EVENT_CHAMPIONS_ATTACK, 4s);
                break;
            case EVENT_CHAMPIONS_ATTACK:
                for (ObjectGuid const& guid : _championGUIDs)
                {
                    if (Creature* champion = instance->GetCreature(guid))
                    {
                        champion->SetReactState(REACT_AGGRESSIVE);
                        champion->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        champion->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                    }
                }
                instance->DoForAllPlayers([](Player* player)
                {
                    player->AddToNotify(NOTIFY_AI_RELOCATION);
                });
                SetBossState(BOSS_FACTION_CHAMPIONS, IN_PROGRESS);
                break;
            case EVENT_SCENE_FACTION_CHAMPIONS_DEAD:
                CreatureTalk(DATA_TIRION, SAY_STAGE_2_06);
                SummonBarrett();
                break;
            case EVENT_SCENE_301:
                CreatureTalk(DATA_TIRION, SAY_STAGE_3_01);
                _events.RescheduleEvent(EVENT_SCENE_302, 13s);
                break;
            case EVENT_SCENE_302:
                CreatureTalk(DATA_TIRION, SAY_STAGE_3_02);
                _events.RescheduleEvent(EVENT_SCENE_303, 3s);
                break;
            case EVENT_SCENE_303:
                HandleGameObject(DATA_ENTER_GATE, false);
                if (Creature* tirion = GetCreature(DATA_TIRION))
                {
                    HandleGameObject(DATA_MAIN_GATE, true);
                    if (Creature* lightbane = tirion->SummonCreature(NPC_LIGHTBANE, Locs[LOC_VALKYR_RIGHT], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000))
                        lightbane->GetMotionMaster()->MovePoint(0, Locs[LOC_VALKYR_DEST_RIGHT].GetPositionX(), Locs[LOC_VALKYR_DEST_RIGHT].GetPositionY(), Locs[LOC_VALKYR_DEST_RIGHT].GetPositionZ());
                    if (Creature* darkbane = tirion->SummonCreature(NPC_DARKBANE, Locs[LOC_VALKYR_LEFT], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000))
                        darkbane->GetMotionMaster()->MovePoint(0, Locs[LOC_VALKYR_DEST_LEFT].GetPositionX(), Locs[LOC_VALKYR_DEST_LEFT].GetPositionY(), Locs[LOC_VALKYR_DEST_LEFT].GetPositionZ());
                }

                _events.RescheduleEvent(EVENT_SCENE_304, 6250ms);
                break;
            case EVENT_SCENE_304:
                HandleGameObject(DATA_MAIN_GATE, false);
                SetBossState(BOSS_TWIN_VALKYR, IN_PROGRESS);
                if (Creature* lightbane = GetCreature(DATA_LIGHTBANE))
                    lightbane->GetMotionMaster()->MovePoint(0, Locs[LOC_VALKYR_DEST_2_RIGHT].GetPositionX(), Locs[LOC_VALKYR_DEST_2_RIGHT].GetPositionY(), Locs[LOC_VALKYR_DEST_2_RIGHT].GetPositionZ());
                if (Creature* darkbane = GetCreature(DATA_DARKBANE))
                    darkbane->GetMotionMaster()->MovePoint(0, Locs[LOC_VALKYR_DEST_2_LEFT].GetPositionX(), Locs[LOC_VALKYR_DEST_2_LEFT].GetPositionY(), Locs[LOC_VALKYR_DEST_2_LEFT].GetPositionZ());

                _events.RescheduleEvent(EVENT_VALKYRIES_ATTACK, 3250ms);
                break;
            case EVENT_VALKYRIES_ATTACK:
                for (uint32 type : { DATA_LIGHTBANE, DATA_DARKBANE })
                {
                    if (Creature* valkyr = GetCreature(type))
                    {
                        valkyr->SetReactState(REACT_AGGRESSIVE);
                        valkyr->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    }
                }
                break;
            case EVENT_SCENE_VALKYR_DEAD:
                if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                    CreatureTalk(DATA_VARIAN, SAY_STAGE_3_03a);
                else
                    CreatureTalk(DATA_GARROSH, SAY_STAGE_3_03h);
                SummonBarrett();

                _events.RescheduleEvent(EVENT_SCENE_401, 60s);
                break;
            case EVENT_SCENE_401:
                if (Creature* barrett = GetCreature(DATA_BARRETT))
                    barrett->AI()->DoAction(ACTION_BARRETT_LEAVE);
                CreatureTalk(DATA_TIRION, SAY_STAGE_4_01);
                _events.RescheduleEvent(EVENT_SCENE_402, 20s);
                break;
            case EVENT_SCENE_402:
                HandleGameObject(DATA_ENTER_GATE, false);
                if (Creature* tirion = GetCreature(DATA_TIRION))
                {
                    if (Creature* lichKing = tirion->SummonCreature(NPC_LICH_KING, Locs[LOC_ARTHAS_PORTAL]))
                    {
                        lichKing->SetReactState(REACT_PASSIVE);
                        lichKing->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        lichKing->SetDisplayId(MODEL_INVISIBLE_STALKER);
                        lichKing->AI()->Talk(SAY_STAGE_4_02);
                        lichKing->SetVisible(false);
                    }
                }

                _events.RescheduleEvent(EVENT_SCENE_403, 2s);
                break;
            case EVENT_SCENE_403:
                if (Creature* tirion = GetCreature(DATA_TIRION))
                {
                    if (Creature* trigger = tirion->SummonCreature(NPC_WORLD_TRIGGER, Locs[LOC_ARTHAS_PORTAL], TEMPSUMMON_TIMED_DESPAWN, 60000))
                    {
                        trigger->SetReactState(REACT_PASSIVE);
                        trigger->CastSpell(trigger, SPELL_ARTHAS_PORTAL, true);
                    }
                }

                _events.RescheduleEvent(EVENT_SCENE_404, 2s);
                break;
            case EVENT_SCENE_404:
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                {
                    lichKing->SetDisplayId(lichKing->GetNativeDisplayId());
                    lichKing->SetVisible(true);
                    lichKing->GetMotionMaster()->MovePoint(0, Locs[LOC_ARTHAS]);
                }

                _events.RescheduleEvent(EVENT_SCENE_405, 3s);
                break;
            case EVENT_SCENE_405:
                CreatureTalk(DATA_TIRION, SAY_STAGE_4_03);
                _events.RescheduleEvent(EVENT_SCENE_406, 7s);
                break;
            case EVENT_SCENE_406:
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                {
                    lichKing->AI()->Talk(SAY_STAGE_4_04);
                    lichKing->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                }

                _events.RescheduleEvent(EVENT_SCENE_406_2, 2500ms);
                _events.RescheduleEvent(EVENT_SCENE_407, 12s);
                break;
            case EVENT_SCENE_406_2:
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                    lichKing->SetEmoteState(EMOTE_STATE_TALK);
                break;
            case EVENT_SCENE_407:
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                    lichKing->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                _events.RescheduleEvent(EVENT_SCENE_408, 4s);
                break;
            case EVENT_SCENE_408:
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                    lichKing->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
                _events.RescheduleEvent(EVENT_SCENE_409, 1500ms);
                break;
            case EVENT_SCENE_409:
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                {
                    if (GameObject* floor = GetGameObject(DATA_FLOOR))
                        floor->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);
                    lichKing->CastSpell(static_cast<Unit*>(nullptr), SPELL_DESTROY_FLOOR_KNOCKUP, true);
                    lichKing->SetVisible(false);
                    lichKing->SetDisplayId(MODEL_INVISIBLE_STALKER);
                    if (Creature* trigger = lichKing->FindNearestCreature(NPC_WORLD_TRIGGER, 500.0f, true))
                        trigger->DespawnOrUnsummon();

                    _instanceProgress = INSTANCE_PROGRESS_ANUB_ARAK;
                    SpawnAnubArak();
                }

                _events.RescheduleEvent(EVENT_SCENE_410, 2s);
                break;
            case EVENT_SCENE_410:
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                {
                    lichKing->SetVisible(true);
                    lichKing->AI()->Talk(SAY_STAGE_4_05);
                    lichKing->DespawnOrUnsummon(0ms);
                }
                break;
            case EVENT_SCENE_501:
                if (Creature* tirion = GetCreature(DATA_TIRION))
                {
                    tirion->AI()->Talk(SAY_STAGE_4_06);
                    tirion->SummonCreature(NPC_ARGENT_MAGE, Locs[LOC_MAGE]);
                    tirion->SummonGameObject(GO_PORTAL_TO_DALARAN, 668.15f, 134.57f, 142.12f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 630000000);
                }

                _events.RescheduleEvent(EVENT_SCENE_502, 20s);
                break;
            case EVENT_SCENE_502:
                if (uint32 tributeChest = GetTributeChestEntry())
                {
                    if (Creature* tirion = GetCreature(DATA_TIRION))
                    {
                        tirion->AI()->Talk(SAY_STAGE_4_07);
                        if (GameObject* chest = tirion->SummonGameObject(tributeChest, 665.12f, 143.78f, 142.12f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 90000000))
                        {
                            chest->SetRespawnTime(chest->GetRespawnDelay());
                            chest->SetLootRecipient(instance);
                        }
                    }
                }
                break;
            default:
                break;
        }
    }

    void ReadSaveDataMore(std::istringstream& data) override
    {
        data >> _instanceProgress;

        if (instance->IsHeroic())
        {
            uint32 dedicatedInsanity = 0;
            uint32 noOneDied = 0;
            data >> _attemptsLeft >> dedicatedInsanity >> noOneDied;
            _dedicatedInsanity = dedicatedInsanity != 0;
            _noOneDied = noOneDied != 0;
        }
    }

    void WriteSaveDataMore(std::ostringstream& data) override
    {
        data << _instanceProgress;

        if (instance->IsHeroic())
        {
            data << ' '
                << _attemptsLeft << ' '
                << (_dedicatedInsanity ? 1 : 0) << ' '
                << (_noOneDied ? 1 : 0);
        }
    }

    bool CheckAchievementCriteriaMeet(uint32 criteriaId, Player const* /*source*/, Unit const* /*target*/, uint32 /*miscvalue1*/) override
    {
        switch (criteriaId)
        {
            case ACHIEV_CRITERIA_UPPER_BACK_PAIN_10_N:
            case ACHIEV_CRITERIA_UPPER_BACK_PAIN_10_H:
                return CountCreaturesNearTirion(NPC_SNOBOLD_VASSAL, [](Creature const* snobold) { return snobold->GetVehicle() != nullptr; }) >= 2;
            case ACHIEV_CRITERIA_UPPER_BACK_PAIN_25_N:
            case ACHIEV_CRITERIA_UPPER_BACK_PAIN_25_H:
                return CountCreaturesNearTirion(NPC_SNOBOLD_VASSAL, [](Creature const* snobold) { return snobold->GetVehicle() != nullptr; }) >= 4;
            case ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_10_N:
            case ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_10_H:
            case ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_25_N:
            case ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_25_H:
                return CountCreaturesNearTirion(NPC_MISTRESS_OF_PAIN, [](Creature const* mistress) { return mistress->IsAlive(); }) >= 2;
            case ACHIEV_CRITERIA_A_TRIBUTE_TO_SKILL_10_PLAYER:
            case ACHIEV_CRITERIA_A_TRIBUTE_TO_SKILL_25_PLAYER:
                return _attemptsLeft >= 25;
            case ACHIEV_CRITERIA_A_TRIBUTE_TO_MAD_SKILL_10_PLAYER:
            case ACHIEV_CRITERIA_A_TRIBUTE_TO_MAD_SKILL_25_PLAYER:
                return _attemptsLeft >= 45;
            case ACHIEV_CRITERIA_A_TRIBUTE_TO_INSANITY_10_PLAYER:
            case ACHIEV_CRITERIA_A_TRIBUTE_TO_INSANITY_25_PLAYER:
            case ACHIEV_CRITERIA_REALM_FIRST_GRAND_CRUSADER:
                return _attemptsLeft == MAX_ATTEMPTS;
            case ACHIEV_CRITERIA_A_TRIBUTE_TO_IMMORTALITY_HORDE:
            case ACHIEV_CRITERIA_A_TRIBUTE_TO_IMMORTALITY_ALLIANCE:
                return _attemptsLeft == MAX_ATTEMPTS && _noOneDied;
            case ACHIEV_CRITERIA_A_TRIBUTE_TO_DEDICATED_INSANITY:
                return _attemptsLeft == MAX_ATTEMPTS && _dedicatedInsanity;
            default:
                return false;
        }
    }

private:
    void CreatureTalk(uint32 type, uint8 textId)
    {
        if (Creature* creature = GetCreature(type))
            creature->AI()->Talk(textId);
    }

    void StartAttack(uint32 type)
    {
        if (Creature* creature = GetCreature(type))
        {
            creature->SetReactState(REACT_AGGRESSIVE);
            creature->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            creature->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
            if (Unit* target = creature->SelectNearestTarget(200.0f))
            {
                creature->AI()->AttackStart(target);
                creature->AI()->DoZoneInCombat();
            }
        }
    }

    // Returns true when this death completes the encounter
    bool SetBeastDead(uint8 beastMask)
    {
        _northrendBeastsMask |= beastMask;
        if ((_northrendBeastsMask & BEASTS_MASK_ALL_DEAD) != BEASTS_MASK_ALL_DEAD)
            return false;

        SetBossState(BOSS_NORTHREND_BEASTS, DONE);
        return true;
    }

    uint32 GetBarrettEntry() const
    {
        switch (_instanceProgress)
        {
            case INSTANCE_PROGRESS_INITIAL:
            case INSTANCE_PROGRESS_INTRO_DONE:
                return instance->IsHeroic() ? NPC_BARRETT_BEASTS_HC : NPC_BARRETT_BEASTS;
            case INSTANCE_PROGRESS_BEASTS_DEAD:
            case INSTANCE_PROGRESS_JARAXXUS_INTRO_DONE:
                return NPC_BARRETT_JARAXXUS;
            case INSTANCE_PROGRESS_JARAXXUS_DEAD:
                return NPC_BARRETT_FACTION_CHAMPIONS;
            case INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD:
                return NPC_BARRETT_VALKYR;
            case INSTANCE_PROGRESS_VALKYR_DEAD:
                return NPC_BARRETT_LICH_KING;
            default:
                return 0;
        }
    }

    // Each stage has its own Barrett, who leaves once the stage is started from his gossip
    void SummonBarrett()
    {
        uint32 entry = (instance->IsHeroic() && !_attemptsLeft) ? 0 : GetBarrettEntry();
        if (Creature* barrett = GetCreature(DATA_BARRETT))
        {
            if (barrett->GetEntry() == entry && barrett->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
                return;

            barrett->DespawnOrUnsummon();
        }

        if (entry)
            instance->SummonCreature(entry, Locs[LOC_BARRETT]);
    }

    void SpawnAnubArak()
    {
        if (_instanceProgress != INSTANCE_PROGRESS_ANUB_ARAK)
            return;

        if (_attemptsLeft && !GetCreature(DATA_ANUBARAK))
            if (Creature* tirion = GetCreature(DATA_TIRION))
                tirion->SummonCreature(NPC_ANUBARAK, Locs[LOC_ANUB], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000);

        // Corpses keep their loot, so they are moved down to Anub'arak's chamber instead of despawned
        std::pair<uint32, Position> const corpses[] =
        {
            { DATA_ICEHOWL,   { 626.57f, 162.8f, 140.25f, 4.44f } },
            { DATA_JARAXXUS,  { 603.92f, 102.61f, 141.85f, 1.4f } },
            { DATA_LIGHTBANE, { 634.58f, 147.16f, 140.5f, 3.02f } },
            { DATA_DARKBANE,  { 630.88f, 131.39f, 140.8f, 3.02f } },
        };

        for (auto const& [type, pos] : corpses)
        {
            if (Creature* corpse = GetCreature(type))
            {
                corpse->UpdatePosition(pos, true);
                corpse->StopMovingOnCurrentPos();
                corpse->DestroyForVisiblePlayers();
            }
        }
    }

    void SummonFactionChampions()
    {
        bool const isAllianceRaid = GetTeamIdInInstance() == TEAM_ALLIANCE;

        // Each healer paired with the damage spec of the same class that replaces it
        std::vector<std::pair<uint32, uint32>> healers = isAllianceRaid ? std::vector<std::pair<uint32, uint32>>
        {
            { NPC_HORDE_DRUID_RESTORATION,     NPC_HORDE_DRUID_BALANCE          },
            { NPC_HORDE_PALADIN_HOLY,          NPC_HORDE_PALADIN_RETRIBUTION    },
            { NPC_HORDE_PRIEST_DISCIPLINE,     NPC_HORDE_PRIEST_SHADOW          },
            { NPC_HORDE_SHAMAN_RESTORATION,    NPC_HORDE_SHAMAN_ENHANCEMENT     },
        } : std::vector<std::pair<uint32, uint32>>
        {
            { NPC_ALLIANCE_DRUID_RESTORATION,  NPC_ALLIANCE_DRUID_BALANCE       },
            { NPC_ALLIANCE_PALADIN_HOLY,       NPC_ALLIANCE_PALADIN_RETRIBUTION },
            { NPC_ALLIANCE_PRIEST_DISCIPLINE,  NPC_ALLIANCE_PRIEST_SHADOW       },
            { NPC_ALLIANCE_SHAMAN_RESTORATION, NPC_ALLIANCE_SHAMAN_ENHANCEMENT  },
        };

        std::vector<uint32> champions = isAllianceRaid ? std::vector<uint32>
        {
            NPC_HORDE_DEATH_KNIGHT, NPC_HORDE_HUNTER, NPC_HORDE_MAGE, NPC_HORDE_ROGUE, NPC_HORDE_WARLOCK, NPC_HORDE_WARRIOR
        } : std::vector<uint32>
        {
            NPC_ALLIANCE_DEATH_KNIGHT, NPC_ALLIANCE_HUNTER, NPC_ALLIANCE_MAGE, NPC_ALLIANCE_ROGUE, NPC_ALLIANCE_WARLOCK, NPC_ALLIANCE_WARRIOR
        };

        // 10 man fights 2 healers and 4 damage dealers, 25 man 3 healers and 7 damage dealers
        Acore::Containers::RandomShuffle(healers);
        std::size_t const replacedHealers = instance->Is25ManRaid() ? 1 : 2;
        for (std::size_t i = 0; i < replacedHealers; ++i)
        {
            champions.push_back(healers.back().second);
            healers.pop_back();
        }

        if (!instance->Is25ManRaid())
            Acore::Containers::RandomResize(champions, champions.size() - 4);

        for (auto const& healer : healers)
            champions.push_back(healer.first);

        // _killCounter can still hold the Jormungar kill count from the Northrend Beasts
        _killCounter = 0;
        uint8 finalPosIndex = 10;
        for (uint32 entry : champions)
        {
            if (Creature* champion = instance->SummonCreature(entry, FactionChampionLoc[urand(0, 4) + (isAllianceRaid ? 0 : 5)]))
            {
                _championGUIDs.push_back(champion->GetGUID());
                // Horde raids get the final positions mirrored across the arena center
                Position const& finalPos = FactionChampionLoc[finalPosIndex];
                float const x = isAllianceRaid ? finalPos.GetPositionX() : Locs[LOC_CENTER].GetPositionX() * 2 - finalPos.GetPositionX();
                champion->SetHomePosition(x, finalPos.GetPositionY(), finalPos.GetPositionZ(), 0.0f);
                champion->GetMotionMaster()->MoveJump(x, finalPos.GetPositionY(), finalPos.GetPositionZ(), 20.0f, 20.0f);
            }
            ++finalPosIndex;
        }
    }

    uint32 GetCrusadersCacheEntry() const
    {
        switch (instance->GetDifficulty())
        {
            case RAID_DIFFICULTY_10MAN_NORMAL:
                return GO_CRUSADERS_CACHE_10;
            case RAID_DIFFICULTY_25MAN_NORMAL:
                return GO_CRUSADERS_CACHE_25;
            case RAID_DIFFICULTY_10MAN_HEROIC:
                return GO_CRUSADERS_CACHE_10_H;
            case RAID_DIFFICULTY_25MAN_HEROIC:
                return GO_CRUSADERS_CACHE_25_H;
            default:
                return 0;
        }
    }

    uint32 GetTributeChestEntry() const
    {
        if (!instance->IsHeroic())
            return 0;

        bool const is25Man = instance->Is25ManRaid();
        if (_attemptsLeft >= MAX_ATTEMPTS)
            return is25Man ? GO_TRIBUTE_CHEST_25H_99 : GO_TRIBUTE_CHEST_10H_99;
        if (_attemptsLeft >= 45)
            return is25Man ? GO_TRIBUTE_CHEST_25H_50 : GO_TRIBUTE_CHEST_10H_50;
        if (_attemptsLeft >= 25)
            return is25Man ? GO_TRIBUTE_CHEST_25H_45 : GO_TRIBUTE_CHEST_10H_45;
        return is25Man ? GO_TRIBUTE_CHEST_25H_25 : GO_TRIBUTE_CHEST_10H_25;
    }

    template <typename Predicate>
    std::size_t CountCreaturesNearTirion(uint32 entry, Predicate&& predicate)
    {
        Creature* tirion = GetCreature(DATA_TIRION);
        if (!tirion)
            return 0;

        std::list<Creature*> creatures;
        tirion->GetCreaturesWithEntryInRange(creatures, 200.0f, entry);
        return static_cast<std::size_t>(std::count_if(creatures.begin(), creatures.end(), predicate));
    }

    bool IsValidDedicatedInsanityItem(ItemTemplate const* item) const
    {
        if (!item) // should not happen, but checked in GetAverageItemLevel()
            return true;
        if (item->ItemLevel < DEDICATED_INSANITY_ITEM_LEVEL)
            return true;
        // Too powerful to allow despite its item level
        if (item->ItemId == ITEM_VALANYR)
            return false;
        // Also covers the items crafted from patterns that drop in ToC 10 normal/heroic
        if (item->ItemLevel == DEDICATED_INSANITY_ITEM_LEVEL && item->Bonding == BIND_WHEN_EQUIPPED)
            return true;

        return std::binary_search(DedicatedInsanityItems.begin(), DedicatedInsanityItems.end(), item->ItemId);
    }

    void DoCheckDedicatedInsanity()
    {
        if (!_dedicatedInsanity || _attemptsLeft < MAX_ATTEMPTS || instance->GetDifficulty() != RAID_DIFFICULTY_10MAN_HEROIC)
            return;

        for (auto const& itr : instance->GetPlayers())
        {
            // Out of combat players are skipped to keep the periodic scan cheap
            Player* player = itr.GetSource();
            if (!player || player->IsGameMaster() || !player->IsInCombat())
                continue;

            for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
            {
                Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
                if (item && !IsValidDedicatedInsanityItem(item->GetTemplate()))
                {
                    _dedicatedInsanity = false;
                    SaveToDB();
                    return;
                }
            }
        }
    }

    void DespawnChampionPets()
    {
        for (ObjectGuid const& guid : _championPetGUIDs)
            if (Creature* pet = instance->GetCreature(guid))
                pet->DespawnOrUnsummon();
        _championPetGUIDs.clear();
    }

    void DespawnBeastsCombatStalker()
    {
        if (Creature* stalker = GetCreature(DATA_BEASTS_COMBAT_STALKER))
            stalker->DespawnOrUnsummon();
    }

    // Retail makes every player a vehicle for the whole Northrend Beasts encounter so Snobold Vassals can ride them
    void SetSnoboldCarrier(Player* player, bool apply)
    {
        Vehicle* kit = player->GetVehicleKit();
        if (apply)
        {
            if (kit || !player->CreateVehicleKit(VEHICLE_SNOBOLD_CARRIER, 0))
                return;

            player->GetVehicleKit()->SetBoardableByPlayers(false);
        }
        else
        {
            if (!kit || kit->GetVehicleInfo()->m_ID != VEHICLE_SNOBOLD_CARRIER)
                return;

            player->RemoveVehicleKit();
        }

        WorldPacket data(SMSG_PLAYER_VEHICLE_DATA, player->GetPackGUID().size() + 4);
        data << player->GetPackGUID();
        data << uint32(apply ? VEHICLE_SNOBOLD_CARRIER : 0);
        player->SendMessageToSet(&data, true);

        if (apply)
        {
            data.Initialize(SMSG_ON_CANCEL_EXPECTED_RIDE_VEHICLE_AURA, 0);
            player->SendDirectMessage(&data);
        }
    }

    void SetSnoboldCarriers(bool apply)
    {
        instance->DoForAllPlayers([this, apply](Player* player)
        {
            SetSnoboldCarrier(player, apply);
        });
    }

    bool DoNeedCleanup(Player* ignoredPlayer = nullptr)
    {
        for (auto const& itr : instance->GetPlayers())
        {
            Player* player = itr.GetSource();
            if (player && player != ignoredPlayer && player->IsAlive() && !player->IsGameMaster())
            {
                _cleaned = false;
                return false;
            }
        }

        return true;
    }

    void InstanceCleanup(bool fromFailed = false)
    {
        if (_cleaned)
            return;
        _cleaned = true;

        // Read before the switch: the Jaraxxus respawned below sets his boss state back to NOT_STARTED in Reset()
        bool const encounterInProgress = IsEncounterInProgress();

        switch (_instanceProgress)
        {
            case INSTANCE_PROGRESS_INTRO_DONE:
                if (Creature* gormok = GetCreature(DATA_GORMOK))
                {
                    gormok->AI()->DoAction(ACTION_DESPAWN_SUMMONS);
                    gormok->DespawnOrUnsummon();
                }
                for (uint32 type : { DATA_ACIDMAW, DATA_DREADSCALE, DATA_ICEHOWL })
                    if (Creature* beast = GetCreature(type))
                        beast->DespawnOrUnsummon();
                DespawnBeastsCombatStalker();
                _northrendBeastsMask = 0;
                SetSnoboldCarriers(false);
                break;
            case INSTANCE_PROGRESS_BEASTS_DEAD:
                for (uint32 type : { DATA_FIZZLEBANG, DATA_JARAXXUS })
                    if (Creature* creature = GetCreature(type))
                        creature->DespawnOrUnsummon();
                if (Creature* purpleGround = instance->GetCreature(_purpleGroundGUID))
                    purpleGround->DespawnOrUnsummon();
                _purpleGroundGUID.Clear();
                if (Creature* portal = instance->GetCreature(_portalGUID))
                    portal->DespawnOrUnsummon();
                _portalGUID.Clear();
                break;
            case INSTANCE_PROGRESS_JARAXXUS_INTRO_DONE:
                if (Creature* jaraxxus = GetCreature(DATA_JARAXXUS))
                    jaraxxus->DespawnOrUnsummon();
                // Stays chained and unattackable until Barrett's gossip starts the retry
                if (Creature* tirion = GetCreature(DATA_TIRION))
                    if (Creature* jaraxxus = tirion->SummonCreature(NPC_JARAXXUS, Locs[LOC_CENTER], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000))
                        jaraxxus->CastSpell(jaraxxus, SPELL_JARAXXUS_CHAINS, true);
                // His Reset() has just set the state back to NOT_STARTED
                SetBossState(BOSS_JARAXXUS, FAIL);
                break;
            case INSTANCE_PROGRESS_JARAXXUS_DEAD:
                for (ObjectGuid const& guid : _championGUIDs)
                    if (Creature* champion = instance->GetCreature(guid))
                        champion->DespawnOrUnsummon();
                _championGUIDs.clear();
                DespawnChampionPets();
                break;
            case INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD:
                for (uint32 type : { DATA_DARKBANE, DATA_LIGHTBANE })
                {
                    if (Creature* valkyr = GetCreature(type))
                    {
                        valkyr->AI()->DoAction(ACTION_DESPAWN_SUMMONS);
                        valkyr->DespawnOrUnsummon();
                    }
                }
                break;
            case INSTANCE_PROGRESS_VALKYR_DEAD:
            case INSTANCE_PROGRESS_ANUB_ARAK:
                if (Creature* tirion = GetCreature(DATA_TIRION))
                    if (Creature* trigger = tirion->FindNearestCreature(NPC_WORLD_TRIGGER, 500.0f, true))
                        trigger->DespawnOrUnsummon();
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                    lichKing->DespawnOrUnsummon();

                if (Creature* anubarak = GetCreature(DATA_ANUBARAK))
                {
                    anubarak->AI()->DoAction(ACTION_DESPAWN_SUMMONS);
                    anubarak->DespawnOrUnsummon();
                }
                break;
            case INSTANCE_PROGRESS_DONE:
                if (GameObject* floor = GetGameObject(DATA_FLOOR))
                    floor->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, nullptr, true);
                break;
            default:
                break;
        }

        if (instance->IsHeroic() && _attemptsLeft > 0 && !fromFailed && encounterInProgress)
        {
            --_attemptsLeft;
            DoUpdateWorldState(WORLD_STATE_TRIAL_OF_THE_CRUSADER_UI_COUNT, _attemptsLeft);
        }

        HandleGameObject(DATA_MAIN_GATE, false);
        HandleGameObject(DATA_ENTER_GATE, true);
        HandleGameObject(DATA_WEB_DOOR, true);
        _killCounter = 0;
        // Barrett's gossip shows the retry text and options for encounters left at FAIL
        for (uint32 bossId = 0; bossId < MAX_ENCOUNTERS; ++bossId)
            if (GetBossState(bossId) == IN_PROGRESS)
                SetBossState(bossId, FAIL);
        SummonBarrett();
        _events.Reset();
        _events.RescheduleEvent(EVENT_CHECK_PLAYERS, 5s);
    }

    bool _cleaned;
    uint32 _instanceProgress;
    uint32 _attemptsLeft;
    uint8 _killCounter;
    uint8 _northrendBeastsMask;
    Seconds _achievementTimer;
    bool _dedicatedInsanity;
    bool _checkDedicatedInsanity;
    bool _noOneDied;
    EventMap _events;

    GuidVector _championGUIDs;
    // kept out of _championGUIDs, its size is the kill count that completes the encounter
    GuidVector _championPetGUIDs;
    ObjectGuid _purpleGroundGUID;
    ObjectGuid _portalGUID;
};

void AddSC_instance_trial_of_the_crusader()
{
    RegisterInstanceScript(instance_trial_of_the_crusader, MAP_TRIAL_OF_THE_CRUSADER);
}
