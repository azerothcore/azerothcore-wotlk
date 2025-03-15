/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "Chat.h"
#include "Config.h"
#include "Player.h"
#include "QueryResult.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "TaskScheduler.h"
#include "WarEffort.h"

WarEffort* WarEffort::instance()
{
    static WarEffort instance;
    return &instance;
}

void WarEffort::SaveData()
{
    CharacterDatabase.Query("UPDATE wareffort SET "
                            "bandages01 = {}, bandages02 = {}, bandages03 = {},"
                            "food01 = {}, food02 = {}, food03 = {},"
                            "herbs01 = {}, herbs02 = {}, herbs03 = {},"
                            "metals01 = {}, metals02 = {}, metals03 = {},"
                            "leather01 = {}, leather02 = {}, leather03 = {} "
                            "WHERE id = {} AND faction = {}",
        sWarEffort->materialsHorde[MATERIAL_WOOL], sWarEffort->materialsHorde[MATERIAL_MAGEWEAVE], sWarEffort->materialsHorde[MATERIAL_RUNECLOTH_B],
        sWarEffort->materialsHorde[MATERIAL_WOLF], sWarEffort->materialsHorde[MATERIAL_SALMON], sWarEffort->materialsHorde[MATERIAL_YELLOWTAIL_H],
        sWarEffort->materialsHorde[MATERIAL_PEACEBLOOM], sWarEffort->materialsHorde[MATERIAL_FIREBLOOM], sWarEffort->materialsHorde[MATERIAL_PURPLE_LOTUS_H],
        sWarEffort->materialsHorde[MATERIAL_TIN], sWarEffort->materialsHorde[MATERIAL_MITHRIL], sWarEffort->materialsHorde[MATERIAL_COOPER_H],
        sWarEffort->materialsHorde[MATERIAL_HEAVY_LEATHER], sWarEffort->materialsHorde[MATERIAL_RUGGER_LEATHER], sWarEffort->materialsHorde[MATERIAL_THICK_LEATHER_B],
        sConfigMgr->GetOption<uint32>("ModWarEffort.Id", 1), TEAM_HORDE
    );

    CharacterDatabase.Query("UPDATE wareffort SET "
                            "bandages01 = {}, bandages02 = {}, bandages03 = {},"
                            "food01 = {}, food02 = {}, food03 = {},"
                            "herbs01 = {}, herbs02 = {}, herbs03 = {},"
                            "metals01 = {}, metals02 = {}, metals03 = {},"
                            "leather01 = {}, leather02 = {}, leather03 = {} "
                            "WHERE id = {} AND faction = {}",
        sWarEffort->materialsAlliance[MATERIAL_LINEN], sWarEffort->materialsAlliance[MATERIAL_SILK], sWarEffort->materialsAlliance[MATERIAL_RUNECLOTH_A],
        sWarEffort->materialsAlliance[MATERIAL_ALBACORE], sWarEffort->materialsAlliance[MATERIAL_RAPTOR], sWarEffort->materialsAlliance[MATERIAL_YELLOWTAIL_A],
        sWarEffort->materialsAlliance[MATERIAL_STRANGLEKELP], sWarEffort->materialsAlliance[MATERIAL_ARTHAS_TEARS], sWarEffort->materialsAlliance[MATERIAL_PURPLE_LOTUS_A],
        sWarEffort->materialsAlliance[MATERIAL_IRON], sWarEffort->materialsAlliance[MATERIAL_THORIUM], sWarEffort->materialsAlliance[MATERIAL_COOPER_A],
        sWarEffort->materialsAlliance[MATERIAL_LIGHT_LEATHER], sWarEffort->materialsAlliance[MATERIAL_MEDIUM_LEATHER], sWarEffort->materialsAlliance[MATERIAL_THICK_LEATHER_A],
        sConfigMgr->GetOption<uint32>("ModWarEffort.Id", 1), TEAM_ALLIANCE
    );
}

void WarEffort::LoadData()
{
    if (QueryResult result = CharacterDatabase.Query("SELECT * FROM wareffort WHERE id = {}", sWarEffort->GetActiveEventId()))
    {
        do
        {
            if ((*result)[1].Get<uint32>() == TEAM_ALLIANCE)
            {
                sWarEffort->materialsAlliance[MATERIAL_LINEN] = (*result)[2].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_SILK] = (*result)[3].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_RUNECLOTH_A] = (*result)[4].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_ALBACORE] = (*result)[5].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_RAPTOR] = (*result)[6].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_YELLOWTAIL_A] = (*result)[7].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_STRANGLEKELP] = (*result)[8].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_ARTHAS_TEARS] = (*result)[9].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_PURPLE_LOTUS_A] = (*result)[10].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_IRON] = (*result)[11].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_THORIUM] = (*result)[12].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_COOPER_A] = (*result)[13].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_LIGHT_LEATHER] = (*result)[14].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_MEDIUM_LEATHER] = (*result)[15].Get<uint32>();
                sWarEffort->materialsAlliance[MATERIAL_THICK_LEATHER_A] = (*result)[16].Get<uint32>();
            }
            else
            {
                sWarEffort->materialsHorde[MATERIAL_WOOL] = (*result)[2].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_MAGEWEAVE] = (*result)[3].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_RUNECLOTH_B] = (*result)[4].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_WOLF] = (*result)[5].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_SALMON] = (*result)[6].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_YELLOWTAIL_H] = (*result)[7].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_PEACEBLOOM] = (*result)[8].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_FIREBLOOM] = (*result)[9].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_PURPLE_LOTUS_H] = (*result)[10].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_TIN] = (*result)[11].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_MITHRIL] = (*result)[12].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_COOPER_H] = (*result)[13].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_HEAVY_LEATHER] = (*result)[14].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_RUGGER_LEATHER] = (*result)[15].Get<uint32>();
                sWarEffort->materialsHorde[MATERIAL_THICK_LEATHER_B] = (*result)[16].Get<uint32>();
            }
        } while (result->NextRow());
    }

    if (IsWarEffortComplete(TEAM_NEUTRAL))
        isComplete = true;
};

bool WarEffort::IsBellowPercentGathered(uint8 material, uint8 team, float pct)
{
    switch (material)
    {
        case MATERIAL_CAT_BANDAGES:
            if (team == TEAM_ALLIANCE)
            {
                if ((sWarEffort->materialsAlliance[MATERIAL_LINEN] * pct) < (WarEffortMaterialsAlliance[MATERIAL_LINEN].Goal * pct))
                    return true;

                if ((sWarEffort->materialsAlliance[MATERIAL_SILK] * pct) < (WarEffortMaterialsAlliance[MATERIAL_SILK].Goal * pct))
                    return true;

                if ((sWarEffort->materialsAlliance[MATERIAL_RUNECLOTH_A] * pct) < (WarEffortMaterialsAlliance[MATERIAL_RUNECLOTH_A].Goal * pct))
                    return true;
            }
            else
            {
                if ((sWarEffort->materialsHorde[MATERIAL_WOOL] * pct) < (WarEffortMaterialsHorde[MATERIAL_WOOL].Goal * pct))
                    return true;

                if ((sWarEffort->materialsHorde[MATERIAL_MAGEWEAVE] * pct) < (WarEffortMaterialsHorde[MATERIAL_MAGEWEAVE].Goal * pct))
                    return true;

                if ((sWarEffort->materialsHorde[MATERIAL_RUNECLOTH_B] * pct) < (WarEffortMaterialsHorde[MATERIAL_RUNECLOTH_B].Goal * pct))
                    return true;
            }
            break;
        case MATERIAL_CAT_FOOD:
            if (team == TEAM_ALLIANCE)
            {
                if ((sWarEffort->materialsAlliance[MATERIAL_ALBACORE] * pct) < (WarEffortMaterialsAlliance[MATERIAL_ALBACORE].Goal * pct))
                    return true;

                if ((sWarEffort->materialsAlliance[MATERIAL_RAPTOR] * pct) < (WarEffortMaterialsAlliance[MATERIAL_RAPTOR].Goal * pct))
                    return true;

                if ((sWarEffort->materialsAlliance[MATERIAL_YELLOWTAIL_A] * pct) < (WarEffortMaterialsAlliance[MATERIAL_YELLOWTAIL_A].Goal * pct))
                    return true;
            }
            else
            {
                if ((sWarEffort->materialsHorde[MATERIAL_WOLF] * pct) < (WarEffortMaterialsHorde[MATERIAL_WOLF].Goal * pct))
                    return true;

                if ((sWarEffort->materialsHorde[MATERIAL_SALMON] * pct) < (WarEffortMaterialsHorde[MATERIAL_SALMON].Goal * pct))
                    return true;

                if ((sWarEffort->materialsHorde[MATERIAL_YELLOWTAIL_H] * pct) < (WarEffortMaterialsHorde[MATERIAL_YELLOWTAIL_H].Goal * pct))
                    return true;
            }
            break;
        case MATERIAL_CAT_HERBS:
            if (team == TEAM_ALLIANCE)
            {
                if ((sWarEffort->materialsAlliance[MATERIAL_STRANGLEKELP] * pct) < (WarEffortMaterialsAlliance[MATERIAL_STRANGLEKELP].Goal * pct))
                    return true;

                if ((sWarEffort->materialsAlliance[MATERIAL_ARTHAS_TEARS] * pct) < (WarEffortMaterialsAlliance[MATERIAL_ARTHAS_TEARS].Goal * pct))
                    return true;
 
                if ((sWarEffort->materialsAlliance[MATERIAL_PURPLE_LOTUS_A] * pct) < (WarEffortMaterialsAlliance[MATERIAL_PURPLE_LOTUS_A].Goal * pct))
                    return true;
            }
            else
            {
                if ((sWarEffort->materialsHorde[MATERIAL_PEACEBLOOM] * pct) < (WarEffortMaterialsHorde[MATERIAL_PEACEBLOOM].Goal * pct))
                    return true;
 
                if ((sWarEffort->materialsHorde[MATERIAL_FIREBLOOM] * pct) < (WarEffortMaterialsHorde[MATERIAL_FIREBLOOM].Goal * pct))
                    return true;

                if ((sWarEffort->materialsHorde[MATERIAL_PURPLE_LOTUS_H] * pct) < (WarEffortMaterialsHorde[MATERIAL_PURPLE_LOTUS_H].Goal * pct))
                    return true;
            }
            break;
        case MATERIAL_CAT_METAL:
                if (team == TEAM_ALLIANCE)
                {
                    if ((sWarEffort->materialsAlliance[MATERIAL_IRON] * pct) < (WarEffortMaterialsAlliance[MATERIAL_IRON].Goal * pct))
                        return true;
                }
                else if ((sWarEffort->materialsHorde[MATERIAL_TIN] * pct) < (WarEffortMaterialsHorde[MATERIAL_TIN].Goal * pct))
                    return true;
            break;
        case MATERIAL_CAT_LEATHER:
                if (team == TEAM_ALLIANCE)
                {
                    if ((sWarEffort->materialsAlliance[MATERIAL_LIGHT_LEATHER] * pct) < (WarEffortMaterialsAlliance[MATERIAL_LIGHT_LEATHER].Goal * pct))
                        return true;
                }
                else if ((sWarEffort->materialsHorde[MATERIAL_HEAVY_LEATHER] * pct) < (WarEffortMaterialsHorde[MATERIAL_HEAVY_LEATHER].Goal * pct))
                    return true;
            break;
        default:
            break;
    }

    return false;
}

bool WarEffort::IsWarEffortComplete(uint8 team)
{
    std::vector materialCats = { MATERIAL_CAT_BANDAGES, MATERIAL_CAT_FOOD, MATERIAL_CAT_HERBS, MATERIAL_CAT_METAL, MATERIAL_CAT_LEATHER };
    for (uint32 cat : materialCats)
    {
        if (team == TEAM_ALLIANCE)
        {
            if (IsBellowPercentGathered(cat, TEAM_ALLIANCE, 100.0f))
                return false;

        } else if (team == TEAM_HORDE)
        {
            if (IsBellowPercentGathered(cat, TEAM_HORDE, 100.0f))
                return false;
        }
        else
        {
            if (IsBellowPercentGathered(cat, TEAM_ALLIANCE, 100.0f))
                return false;

            if (IsBellowPercentGathered(cat, TEAM_HORDE, 100.0f))
                return false;
        }
    }

    return true;
}

void WarEffort::RemoveNearbyObject(uint32 entry, Unit* unit)
{
    if (GameObject* go = unit->FindNearestGameObject(entry, 50.0f))
        go->Delete();
}

void WarEffort::CheckGoal(Unit* unit, uint8 material, uint8 team)
{
    // @todo: This whole thing probably could be done better, but no time to find a better design right now.

    switch (material)
    {
        // Bandages
        case MATERIAL_CAT_BANDAGES:
        {
            if (team == TEAM_ALLIANCE)
            {
                if (sWarEffort->IsBellowPercentGathered(material, team, 0.20f))
                {
                    //
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.20f) && sWarEffort->IsBellowPercentGathered(material, team, 0.40f))
                {
                    if (!unit->FindNearestGameObject(GO_BANDAGES_ALLIANCE_TIER_1, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_BANDAGES_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_BANDAGES_ALLIANCE_TIER_1, pos, 0.0f, 0.0f, -0.886385f, -0.462949f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.40f) && sWarEffort->IsBellowPercentGathered(material, team, 0.60f))
                {
                    if (!unit->FindNearestGameObject(GO_BANDAGES_ALLIANCE_TIER_2, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_BANDAGES_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_BANDAGES_ALLIANCE_TIER_2, pos, 0.0f, 0.0f, -0.886385f, -0.462949f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.60f) && sWarEffort->IsBellowPercentGathered(material, team, 0.80))
                {
                    if (!unit->FindNearestGameObject(GO_BANDAGES_ALLIANCE_TIER_3, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_BANDAGES_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_BANDAGES_ALLIANCE_TIER_3, pos, 0.0f, 0.0f, -0.886385f, -0.462949f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.80) && sWarEffort->IsBellowPercentGathered(material, team, 1.0f))
                {
                    if (!unit->FindNearestGameObject(GO_BANDAGES_ALLIANCE_TIER_4, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_BANDAGES_ALLIANCE_TIER_1];
                       // unit->GetMap()->SummonGameObject(GO_BANDAGES_ALLIANCE_TIER_4, pos, 0.0f, 0.0f, -0.886385f, -0.462949f, 14 * DAY * MINUTE);
                    }
                }
                else
                {
                    if (!unit->FindNearestGameObject(GO_BANDAGES_ALLIANCE_TIER_5, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_BANDAGES_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_BANDAGES_ALLIANCE_TIER_5, pos, 0.0f, 0.0f, -0.886385f, -0.462949f, 14 * DAY * MINUTE);
                    }
                }
            }
            else
            {
                if (!unit->FindNearestGameObject(GO_BANDAGES_HORDE_INITIAL, 50.0f))
                {
                    Position pos = WarEffortGameobjectPositions[GO_BANDAGES_HORDE_INITIAL];
                    unit->GetMap()->SummonGameObject(GO_BANDAGES_HORDE_INITIAL, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                }

                if (!sWarEffort->IsBellowPercentGathered(material, team, 0.20f) && sWarEffort->IsBellowPercentGathered(material, team, 0.40f))
                {
                    if (!unit->FindNearestGameObject(GO_BANDAGES_HORDE_TIER_1, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_BANDAGES_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_BANDAGES_HORDE_TIER_1, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ() + 0.7f, pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.40f) && sWarEffort->IsBellowPercentGathered(material, team, 0.60f))
                {
                    if (!unit->FindNearestGameObject(GO_BANDAGES_HORDE_TIER_2, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_BANDAGES_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_BANDAGES_HORDE_TIER_2, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.60f) && sWarEffort->IsBellowPercentGathered(material, team, 0.80))
                {
                    if (!unit->FindNearestGameObject(GO_BANDAGES_HORDE_TIER_3, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_BANDAGES_HORDE_INITIAL];
                       // unit->GetMap()->SummonGameObject(GO_BANDAGES_HORDE_TIER_3, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.80) && sWarEffort->IsBellowPercentGathered(material, team, 1.0f))
                {
                    if (!unit->FindNearestGameObject(GO_BANDAGES_HORDE_TIER_4, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_BANDAGES_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_BANDAGES_HORDE_TIER_4, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else
                {
                    if (!unit->FindNearestGameObject(GO_BANDAGES_HORDE_TIER_5, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_BANDAGES_HORDE_INITIAL];
                       // unit->GetMap()->SummonGameObject(GO_BANDAGES_HORDE_TIER_5, pos, 0.0f, 0.0f, 0.0f, 0.0f, 0);
                    }
                }
            }

            break;
        }
        // Food
        case MATERIAL_CAT_FOOD:
            if (team == TEAM_ALLIANCE)
            {
                if (sWarEffort->IsBellowPercentGathered(material, team, 0.20f))
                {
                    //
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.20f) && sWarEffort->IsBellowPercentGathered(material, team, 0.40f))
                {
                    if (!unit->FindNearestGameObject(GO_FOOD_ALLIANCE_TIER_1, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_FOOD_ALLIANCE_TIER_1];
                       // unit->GetMap()->SummonGameObject(GO_FOOD_ALLIANCE_TIER_1, pos, 0.0f, 0.0f, -0.496055f, -0.868291f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.40f) && sWarEffort->IsBellowPercentGathered(material, team, 0.60f))
                {
                    sWarEffort->RemoveNearbyObject(GO_FOOD_ALLIANCE_TIER_1, unit);

                    if (!unit->FindNearestGameObject(GO_FOOD_ALLIANCE_TIER_2, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_FOOD_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_FOOD_ALLIANCE_TIER_2, pos, 0.0f, 0.0f, -0.496055f, -0.868291f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.60f) && sWarEffort->IsBellowPercentGathered(material, team, 0.80))
                {
                    sWarEffort->RemoveNearbyObject(GO_FOOD_ALLIANCE_TIER_2, unit);

                    if (!unit->FindNearestGameObject(GO_FOOD_ALLIANCE_TIER_3, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_FOOD_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_FOOD_ALLIANCE_TIER_3, pos, 0.0f, 0.0f, -0.496055f, -0.868291f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.80) && sWarEffort->IsBellowPercentGathered(material, team, 1.0f))
                {
                    sWarEffort->RemoveNearbyObject(GO_FOOD_ALLIANCE_TIER_3, unit);

                    if (!unit->FindNearestGameObject(GO_FOOD_ALLIANCE_TIER_4, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_FOOD_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_FOOD_ALLIANCE_TIER_4, pos, 0.0f, 0.0f, -0.496055f, -0.868291f, 14 * DAY * MINUTE);
                    }
                }
                else
                {
                    sWarEffort->RemoveNearbyObject(GO_FOOD_ALLIANCE_TIER_4, unit);

                    if (!unit->FindNearestGameObject(GO_FOOD_ALLIANCE_TIER_5, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_FOOD_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_FOOD_ALLIANCE_TIER_5, pos, 0.0f, 0.0f, -0.496055f, -0.868291f, 14 * DAY * MINUTE);
                    }
                }
            }
            else
            {
                if (!unit->FindNearestGameObject(GO_FOOD_HORDE_INITIAL, 50.0f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 0 - Horde - Food");
                    Position pos = WarEffortGameobjectPositions[GO_FOOD_HORDE_INITIAL];
                    unit->GetMap()->SummonGameObject(GO_FOOD_HORDE_INITIAL, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                }

                if (!sWarEffort->IsBellowPercentGathered(material, team, 0.20f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 1 - Horde - Food");

                    if (!unit->FindNearestGameObject(GO_FOOD_HORDE_TIER_1, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_FOOD_HORDE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_FOOD_HORDE_TIER_1, pos, 0.0f, 0.0f, -0.983634f, -0.180176f, 14 * DAY * MINUTE);
                    }
                }

                if (!sWarEffort->IsBellowPercentGathered(material, team, 0.40f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 2 - Horde - Food");

                    if (!unit->FindNearestGameObject(GO_FOOD_HORDE_TIER_2, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_FOOD_HORDE_TIER_2];
                        //unit->GetMap()->SummonGameObject(GO_FOOD_HORDE_TIER_2, pos, 0.0f, 0.0f, -0.982382f, 0.186883f, 14 * DAY * MINUTE);
                    }
                }

                if (!sWarEffort->IsBellowPercentGathered(material, team, 0.60f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 3 - Horde - Food");

                    if (!unit->FindNearestGameObject(GO_FOOD_HORDE_TIER_3, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_FOOD_HORDE_TIER_3];
                        //unit->GetMap()->SummonGameObject(GO_FOOD_HORDE_TIER_3, pos, 0.0f, 0.0f, -0.996204f, -0.0870461f, 14 * DAY * MINUTE);
                    }
                }

                if (!sWarEffort->IsBellowPercentGathered(material, team, 0.80f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 4 - Horde - Food");

                    if (!unit->FindNearestGameObject(GO_FOOD_HORDE_TIER_4, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_FOOD_HORDE_TIER_4];
                        //unit->GetMap()->SummonGameObject(GO_FOOD_HORDE_TIER_4, pos, 0.0f, 0.0f, -0.984112f, 0.177551f, 14 * DAY * MINUTE);
                    }
                }

                if (!sWarEffort->IsBellowPercentGathered(material, team, 1.0f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 5 - Horde - Food");

                    if (!unit->FindNearestGameObject(GO_FOOD_HORDE_TIER_5, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_FOOD_HORDE_TIER_5];
                        //unit->GetMap()->SummonGameObject(GO_FOOD_HORDE_TIER_5, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ() - 4.0f, pos.GetOrientation(), 0.0f, 0.0f, -0.92896f, 0.370181f, 14 * DAY * MINUTE);
                    }
                }
            }
            break;
        // Herbs
        case MATERIAL_CAT_HERBS:
            if (team == TEAM_ALLIANCE)
            {
                if (sWarEffort->IsBellowPercentGathered(material, team, 0.20f))
                {
                    // Already spawned by default
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.20f) && sWarEffort->IsBellowPercentGathered(material, team, 0.40f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 1 - Alliance - Herbs");
                    if (!unit->FindNearestGameObject(GO_HERBS_ALLIANCE_TIER_1, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_HERBS_ALLIANCE_TIER_1, pos, 0.0f, 0.0f, -0.522955f, -0.85236f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.40f) && sWarEffort->IsBellowPercentGathered(material, team, 0.60f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 2 - Alliance - Herbs");

                    if (!unit->FindNearestGameObject(GO_HERBS_ALLIANCE_TIER_2, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_HERBS_ALLIANCE_TIER_2, pos, 0.0f, 0.0f, -0.522955f, -0.85236f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.60f) && sWarEffort->IsBellowPercentGathered(material, team, 0.80))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 3 - Alliance - Herbs");

                    if (!unit->FindNearestGameObject(GO_HERBS_ALLIANCE_TIER_3, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_HERBS_ALLIANCE_TIER_3, pos, 0.0f, 0.0f, -0.522955f, -0.85236f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.80f) && sWarEffort->IsBellowPercentGathered(material, team, 1.0f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 4 - Alliance - Herbs");

                    if (!unit->FindNearestGameObject(GO_HERBS_ALLIANCE_TIER_4, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_ALLIANCE_TIER_1];
                       // unit->GetMap()->SummonGameObject(GO_HERBS_ALLIANCE_TIER_4, pos, 0.0f, 0.0f, -0.522955f, -0.85236f, 14 * DAY * MINUTE);
                    }
                }
                else
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 5 - Alliance - Herbs");

                    if (!unit->FindNearestGameObject(GO_HERBS_ALLIANCE_TIER_5, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_HERBS_ALLIANCE_TIER_5, pos, 0.0f, 0.0f, -0.522955f, -0.85236f, 14 * DAY * MINUTE);
                    }
                }
            }
            else
            {
                if (!unit->FindNearestGameObject(GO_HERBS_HORDE_INITIAL, 50.0f))
                {
                    Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                    unit->GetMap()->SummonGameObject(GO_HERBS_HORDE_INITIAL, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                }

                if (!sWarEffort->IsBellowPercentGathered(material, team, 0.20f) && sWarEffort->IsBellowPercentGathered(material, team, 0.40f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 1 - Horde - Herbs");

                    if (!unit->FindNearestGameObject(GO_HERBS_HORDE_TIER_1, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_HERBS_HORDE_TIER_1, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.40f) && sWarEffort->IsBellowPercentGathered(material, team, 0.60f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 2 - Horde - Herbs");

                    if (!unit->FindNearestGameObject(GO_HERBS_HORDE_TIER_2, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_HERBS_HORDE_TIER_2, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.60f) && sWarEffort->IsBellowPercentGathered(material, team, 0.80))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 3 - Horde - Herbs");

                    if (!unit->FindNearestGameObject(GO_HERBS_HORDE_TIER_3, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_HERBS_HORDE_TIER_3, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.80) && sWarEffort->IsBellowPercentGathered(material, team, 1.0f))
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 4 - Horde - Herbs");

                    if (!unit->FindNearestGameObject(GO_HERBS_HORDE_TIER_4, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_HERBS_HORDE_TIER_4, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else
                {
                    LOG_INFO("server.server", "WarEffort: Started stage 5 - Horde - Herbs");

                    if (!unit->FindNearestGameObject(GO_HERBS_HORDE_TIER_5, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_HERBS_HORDE_TIER_5, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
            }
            break;
        // Meetal
        case MATERIAL_CAT_METAL:
            if (team == TEAM_ALLIANCE)
            {
                if (sWarEffort->IsBellowPercentGathered(material, team, 0.20f))
                {
                    //
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.20f) && sWarEffort->IsBellowPercentGathered(material, team, 0.40f))
                {
                    if (!unit->FindNearestGameObject(GO_METAL_ALLIANCE_TIER_1, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_METAL_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_METAL_ALLIANCE_TIER_1, pos, 0.0f, 0.0f, -0.522955f, -0.85236f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.40f) && sWarEffort->IsBellowPercentGathered(material, team, 0.60f))
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_ALLIANCE_TIER_1, unit);

                    if (!unit->FindNearestGameObject(GO_METAL_ALLIANCE_TIER_2, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_METAL_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_METAL_ALLIANCE_TIER_2, pos, 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.60f) && sWarEffort->IsBellowPercentGathered(material, team, 0.80))
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_ALLIANCE_TIER_2, unit);

                    if (!unit->FindNearestGameObject(GO_METAL_ALLIANCE_TIER_3, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_METAL_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_METAL_ALLIANCE_TIER_3, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.80f) && sWarEffort->IsBellowPercentGathered(material, team, 1.0f))
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_ALLIANCE_TIER_3, unit);

                    if (!unit->FindNearestGameObject(GO_METAL_ALLIANCE_TIER_4, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_METAL_ALLIANCE_TIER_1];
                       // unit->GetMap()->SummonGameObject(GO_METAL_ALLIANCE_TIER_4, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_ALLIANCE_TIER_4, unit);

                    if (!unit->FindNearestGameObject(GO_METAL_ALLIANCE_TIER_5, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_METAL_ALLIANCE_TIER_1];
                        //unit->GetMap()->SummonGameObject(GO_METAL_ALLIANCE_TIER_5, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
            }
            else
            {
                if (!unit->FindNearestGameObject(GO_METAL_HORDE_INITIAL, 50.0f))
                {
                    Position pos = WarEffortGameobjectPositions[GO_METAL_HORDE_INITIAL];
                    unit->GetMap()->SummonGameObject(GO_METAL_HORDE_INITIAL, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), -0.0f, -0.0f, -0.987771f, 0.155913f, 14 * DAY * MINUTE);
                }

                if (!sWarEffort->IsBellowPercentGathered(material, team, 0.20f) && sWarEffort->IsBellowPercentGathered(material, team, 0.40f))
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_HORDE_INITIAL, unit);

                    if (!unit->FindNearestGameObject(GO_METAL_HORDE_TIER_1, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_METAL_HORDE_TIER_1, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.40f) && sWarEffort->IsBellowPercentGathered(material, team, 0.60f))
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_HORDE_TIER_1, unit);

                    if (!unit->FindNearestGameObject(GO_METAL_HORDE_TIER_2, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                       // unit->GetMap()->SummonGameObject(GO_METAL_HORDE_TIER_2, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.60f) && sWarEffort->IsBellowPercentGathered(material, team, 0.80))
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_HORDE_TIER_2, unit);

                    if (!unit->FindNearestGameObject(GO_METAL_HORDE_TIER_3, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                       // unit->GetMap()->SummonGameObject(GO_METAL_HORDE_TIER_3, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.80) && sWarEffort->IsBellowPercentGathered(material, team, 1.0f))
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_HORDE_TIER_3, unit);

                    if (!unit->FindNearestGameObject(GO_METAL_HORDE_TIER_4, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_METAL_HORDE_TIER_4, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_HORDE_TIER_4, unit);

                    if (!unit->FindNearestGameObject(GO_METAL_HORDE_TIER_5, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_HERBS_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_METAL_HORDE_TIER_5, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
            }
            break;
        // Leather
        case MATERIAL_CAT_LEATHER:
            if (team == TEAM_ALLIANCE)
            {
                if (sWarEffort->IsBellowPercentGathered(material, team, 0.20f))
                {
                    // Already spawned
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.20f) && sWarEffort->IsBellowPercentGathered(material, team, 0.40f))
                {
                    if (!unit->FindNearestGameObject(GO_LEATHER_ALLIANCE_TIER_1, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_LEATHER_ALLIANCE_TIER_1];
                       // unit->GetMap()->SummonGameObject(GO_LEATHER_ALLIANCE_TIER_1, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, -0.788872f, -0.614557f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.40f) && sWarEffort->IsBellowPercentGathered(material, team, 0.60f))
                {
                    sWarEffort->RemoveNearbyObject(GO_LEATHER_ALLIANCE_TIER_1, unit);

                    if (!unit->FindNearestGameObject(GO_LEATHER_ALLIANCE_TIER_2, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_LEATHER_ALLIANCE_TIER_1];
                       // unit->GetMap()->SummonGameObject(GO_LEATHER_ALLIANCE_TIER_2, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.60f) && sWarEffort->IsBellowPercentGathered(material, team, 0.80))
                {
                    sWarEffort->RemoveNearbyObject(GO_LEATHER_ALLIANCE_TIER_2, unit);

                    if (!unit->FindNearestGameObject(GO_LEATHER_ALLIANCE_TIER_3, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_LEATHER_ALLIANCE_TIER_1];
                      //  unit->GetMap()->SummonGameObject(GO_LEATHER_ALLIANCE_TIER_3, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.80) && sWarEffort->IsBellowPercentGathered(material, team, 1.0f))
                {
                    sWarEffort->RemoveNearbyObject(GO_LEATHER_ALLIANCE_TIER_3, unit);

                    if (!unit->FindNearestGameObject(GO_LEATHER_ALLIANCE_TIER_4, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_LEATHER_ALLIANCE_TIER_1];
                       // unit->GetMap()->SummonGameObject(GO_LEATHER_ALLIANCE_TIER_4, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else
                {
                    sWarEffort->RemoveNearbyObject(GO_LEATHER_ALLIANCE_TIER_4, unit);

                    if (!unit->FindNearestGameObject(GO_LEATHER_ALLIANCE_TIER_5, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_LEATHER_ALLIANCE_TIER_1];
                       // unit->GetMap()->SummonGameObject(GO_LEATHER_ALLIANCE_TIER_5, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
            }
            else
            {
                if (!unit->FindNearestGameObject(GO_LEATHER_HORDE_INITIAL, 50.0f))
                {
                    Position pos = WarEffortGameobjectPositions[GO_LEATHER_HORDE_INITIAL];
                    unit->GetMap()->SummonGameObject(GO_LEATHER_HORDE_INITIAL, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                }

                if (!sWarEffort->IsBellowPercentGathered(material, team, 0.20f) && sWarEffort->IsBellowPercentGathered(material, team, 0.40f))
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_HORDE_INITIAL, unit);

                    if (!unit->FindNearestGameObject(GO_LEATHER_HORDE_TIER_1, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_LEATHER_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_LEATHER_HORDE_TIER_1, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.40f) && sWarEffort->IsBellowPercentGathered(material, team, 0.60f))
                {
                    sWarEffort->RemoveNearbyObject(GO_METAL_HORDE_INITIAL, unit);

                    if (!unit->FindNearestGameObject(GO_LEATHER_HORDE_TIER_2, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_LEATHER_HORDE_INITIAL];
                       // unit->GetMap()->SummonGameObject(GO_LEATHER_HORDE_TIER_2, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.60f) && sWarEffort->IsBellowPercentGathered(material, team, 0.80))
                {
                    sWarEffort->RemoveNearbyObject(GO_LEATHER_HORDE_TIER_2, unit);

                    if (!unit->FindNearestGameObject(GO_LEATHER_HORDE_TIER_3, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_LEATHER_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_LEATHER_HORDE_TIER_3, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else if (!sWarEffort->IsBellowPercentGathered(material, team, 0.80f) && sWarEffort->IsBellowPercentGathered(material, team, 1.0f))
                {
                    sWarEffort->RemoveNearbyObject(GO_LEATHER_HORDE_TIER_3, unit);

                    if (!unit->FindNearestGameObject(GO_LEATHER_HORDE_TIER_4, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_LEATHER_HORDE_INITIAL];
                        //unit->GetMap()->SummonGameObject(GO_LEATHER_HORDE_TIER_4, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
                else
                {
                    sWarEffort->RemoveNearbyObject(GO_LEATHER_HORDE_TIER_4, unit);

                    if (!unit->FindNearestGameObject(GO_LEATHER_HORDE_TIER_5, 50.0f))
                    {
                        Position pos = WarEffortGameobjectPositions[GO_LEATHER_HORDE_INITIAL];
                       // unit->GetMap()->SummonGameObject(GO_LEATHER_HORDE_TIER_5, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 14 * DAY * MINUTE);
                    }
                }
            }
            break;
        default:
            break;
    }

    if (IsWarEffortComplete(TEAM_NEUTRAL))
    {
        if (!isComplete)
        {
            if (Player* player = unit->ToPlayer())
                ChatHandler(player->GetSession()).SendSysMessage("All the required War Effort resources have been gathered. The expedition presses on to Silithus!");

            isComplete = true;
        }
    }
};

std::string WarEffort::PrintOutMaterialCount(uint8 team)
{
    std::string output;

    if (team == TEAM_ALLIANCE)
    {
        for (WarEffortData data : WarEffortMaterialsAlliance)
            if (Quest const* quest = sObjectMgr->GetQuestTemplate(data.QuestId))
                if (ItemTemplate const* item = sObjectMgr->GetItemTemplate(quest->RequiredItemId[0]))
                    output.append(item->Name1 + " (" + Acore::ToString(materialsAlliance[data.Material] * data.Multiplier) + ") Goal:" + Acore::ToString(data.Goal) + "\n");
    }
    else
    {
        for (WarEffortData data : WarEffortMaterialsHorde)
            if (Quest const* quest = sObjectMgr->GetQuestTemplate(data.QuestId))
                if (ItemTemplate const* item = sObjectMgr->GetItemTemplate(quest->RequiredItemId[0]))
                    output.append(item->Name1 + " (" + Acore::ToString(materialsHorde[data.Material] * data.Multiplier) + ") Goal:" + Acore::ToString(data.Goal) + "\n");
    }

    return output;
};

// Add player scripts
class ModAQWarEffortPlayerScript : public PlayerScript
{
public:
    ModAQWarEffortPlayerScript() : PlayerScript("ModAQWarEffortPlayerScript", {
        PLAYERHOOK_ON_PLAYER_COMPLETE_QUEST
    }) { }

    void OnPlayerCompleteQuest(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_BANG_GONG && !sWarEffort->gongBanged)
        {
            sWarEffort->gongBanged = true;

            if (Creature* jon = player->FindNearestCreature(NPC_JONATHAN, 30.0f))
            {
                jon->AI()->Talk(0, player);

                jon->m_Events.AddEventAtOffset([jon]()
                {
                    jon->AI()->Talk(1);
                }, 2s);

                jon->m_Events.AddEventAtOffset([jon]()
                {
                    jon->AI()->Talk(2);
                }, 4s);

                jon->m_Events.AddEventAtOffset([jon]()
                {
                    jon->AI()->Talk(3);
                }, 6s);

                jon->m_Events.AddEventAtOffset([jon]()
                {
                    jon->AI()->Talk(4);
                }, 8s);

                jon->m_Events.AddEventAtOffset([jon]()
                {
                    if (Creature* rajaxx = jon->SummonCreature(15341, -8192.917969, 1530.618652, 4.195582, 6.252320, TEMPSUMMON_TIMED_DESPAWN, HOUR * IN_MILLISECONDS))
                    {
                        rajaxx->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NON_ATTACKABLE);
                        rajaxx->AI()->Talk(12);
                    }
                }, 10s);
            }

            return;
        }

        if (player->GetTeamId() == TEAM_ALLIANCE)
        {
            for (WarEffortData data : sWarEffort->WarEffortMaterialsAlliance)
            {
                if (quest->GetQuestId() == data.QuestId || quest->GetQuestId() == data.QuestId + 1 /* Repeatable ones */)
                {
                    ++sWarEffort->materialsAlliance[data.Material];
                        
                    if (player->IsGameMaster())
                    {
                        ChatHandler(player->GetSession()).SendSysMessage("WarEffort: Quest turned in, updating scores.");
                        ChatHandler(player->GetSession()).SendSysMessage(sWarEffort->PrintOutMaterialCount(player->GetTeamId()));
                    }

                    sWarEffort->SetSaveStatus(true);
                    sWarEffort->CheckGoal(player, data.MaterialCategory, player->GetTeamId());
                }
            }
        }
        else
        {
            for (WarEffortData data : sWarEffort->WarEffortMaterialsHorde)
            {
                if (quest->GetQuestId() == data.QuestId || quest->GetQuestId() == data.QuestId + 1 /* Repeatable ones */)
                {
                    ++sWarEffort->materialsHorde[data.Material];

                    if (player->IsGameMaster())
                    {
                        ChatHandler(player->GetSession()).SendSysMessage("WarEffort: Quest turned in, updating scores.");
                        ChatHandler(player->GetSession()).SendSysMessage(sWarEffort->PrintOutMaterialCount(player->GetTeamId()));
                    }

                    sWarEffort->SetSaveStatus(true);
                    sWarEffort->CheckGoal(player, data.MaterialCategory, player->GetTeamId());
                }
            }
        }
    }
};

class ModWarEffortWorldScript : public WorldScript
{
public:
    ModWarEffortWorldScript() : WorldScript("ModWarEffortWorldScript", {
        WORLDHOOK_ON_AFTER_CONFIG_LOAD,
        WORLDHOOK_ON_STARTUP,
        WORLDHOOK_ON_UPDATE,
        WORLDHOOK_ON_SHUTDOWN_INITIATE
    }) { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        ScheduleTasks();
    }

    void OnStartup() override
    {
        ScheduleTasks();
        sWarEffort->LoadData();
    }

    void OnUpdate(uint32 diff) override
    {
        if (sWarEffort->IsEnabled())
            _scheduler.Update(diff);
    }

    void ScheduleTasks()
    {
        if (sWarEffort->IsEnabled())
        {
            _scheduler.CancelAll();

            _scheduler.Schedule(1min, [](TaskContext context)
            {
                if (sWarEffort->IsSaveNeeded())
                {
                    sWarEffort->SaveData();
                    sWarEffort->SetSaveStatus(false);
                }

                if (sWarEffort->IsEnabled())
                    context.Repeat();
            });
        }
    }

    void OnShutdownInitiate(ShutdownExitCode /*code*/, ShutdownMask /*mask*/) override
    {
        if (sWarEffort->IsEnabled())
        {
            _scheduler.CancelAll();

            if (sWarEffort->IsSaveNeeded())
            {
                sWarEffort->SaveData();
                sWarEffort->SetSaveStatus(false);
            }
        }
    }

private:
    TaskScheduler _scheduler;
};

enum WarEffortQuartermasters
{
    GOSSIP_SHOW_METAL,
    GOSSIP_SHOW_HERBS,
    GOSSIP_SHOW_LEATHER,
    GOSSIP_SHOW_BANDAGES,
    GOSSIP_SHOW_FOOD
};

struct WhisperData
{
    std::string TextA;
    std::string TextH;
};

WhisperData const whisperData[MAX_MATERIAL_CATS] =
{
    {
        "Good question, $C. Last I was informed; we have managed to collect %u copper bars out of %u needed. Additionally, I am told that we have %u iron bars out %u, and %u out of %u thorium bars requested.",
        "Of the %u copper bars that we'll need, we have %u. The number for tin bar collection sits at %u out of %u needed. And, there have been %u of %u mithril bars smelted for the cause."
    },
    {
        "Herbs, herbs, hmmm, let me see here. Ah yes, here it is. To date we have accumulated %u out of %u stranglekelp, %u out of %u purple lotuses, and %u out of %u arthas' tears needed.",
        "I just received word on that. We currently have %u out of %u peacebloom, %u of %u firebloom, and %u out of %u purple lotus herbs requested."
    },
    {
        "I received an update on that just a moment ago. It looks like out of %u light leather needed, we have %u. As for the others, the report indicates that we've gathered %u out of %u medium leather, and %u out of our %u thick leather quota.",
        "Give me a moment; there are a lot of numbers to remember here. It looks like we have %u of %u heavy leather skins collected. As well, we have %u out of %u thick leather, and %u of %u rugged leather stockpiled."
    },
    {
        "Collection of bandages is proceeding according to schedule. As far as linen bandages are concerned, we've gathered %u of %u. Silk bandages have been tallied at %u out of %u, and we have %u out of %u runecloth bandages needed.",
        "Bandages? Why, do you intend to survive long enough to need them? Har! Very well, $R, I will tell you. Of the %u wool bandages needed, we have collected %u. Also to date, we have taken in %u out of %u mageweave bandages, and %u of %u runecloth bandages asked for."
    },
    {
        "On the cooked goods front it would appear that we've managed to collect and store away %u rainbow fin albacore, out of %u requested. Additionally, right now we have in %u of %u roast raptor and %u out of %u spotted yellowtail in cold storage.",
        "Food, now there's a subject I can sink my fangs into! I am told that we have %u of %u lean wolf steaks, %u out of %u spotted yellowtail, and %u of %u baked salmon on ice and stored away."
    }
};

struct npc_mod_war_effort_quartermaster : public ScriptedAI
{
    npc_mod_war_effort_quartermaster(Creature* creature) : ScriptedAI(creature) { }

    void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
    {
        std::string text = "Nothing to report.";

        switch (gossipListId)
        {
            case GOSSIP_SHOW_METAL:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    text = Acore::StringFormat(whisperData[gossipListId].TextA, sWarEffort->materialsAlliance[MATERIAL_COOPER_A] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_COOPER_A].Goal,
                        sWarEffort->materialsAlliance[MATERIAL_IRON] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_IRON].Goal,
                        sWarEffort->materialsAlliance[MATERIAL_THORIUM] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_THORIUM].Goal);
                }
                else
                {
                    text = Acore::StringFormat(whisperData[gossipListId].TextH, sWarEffort->WarEffortMaterialsHorde[MATERIAL_COOPER_H].Goal,
                        sWarEffort->materialsHorde[MATERIAL_COOPER_H] * 20, sWarEffort->materialsHorde[MATERIAL_TIN] * 20, sWarEffort->WarEffortMaterialsHorde[MATERIAL_TIN].Goal,
                        sWarEffort->materialsHorde[MATERIAL_MITHRIL] * 20, sWarEffort->WarEffortMaterialsHorde[MATERIAL_MITHRIL].Goal);
                }
                break;
            case GOSSIP_SHOW_HERBS:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    text = Acore::StringFormat(whisperData[gossipListId].TextA, sWarEffort->materialsAlliance[MATERIAL_STRANGLEKELP] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_STRANGLEKELP].Goal,
                        sWarEffort->materialsAlliance[MATERIAL_PURPLE_LOTUS_A] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_PURPLE_LOTUS_A].Goal,
                        sWarEffort->materialsAlliance[MATERIAL_ARTHAS_TEARS] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_ARTHAS_TEARS].Goal);
                }
                else
                {
                    text = Acore::StringFormat(whisperData[gossipListId].TextH, sWarEffort->materialsHorde[MATERIAL_PEACEBLOOM] * 20, sWarEffort->WarEffortMaterialsHorde[MATERIAL_PEACEBLOOM].Goal,
                        sWarEffort->materialsHorde[MATERIAL_FIREBLOOM] * 20, sWarEffort->WarEffortMaterialsHorde[MATERIAL_FIREBLOOM].Goal,
                        sWarEffort->materialsHorde[MATERIAL_PURPLE_LOTUS_H] * 20, sWarEffort->WarEffortMaterialsHorde[MATERIAL_PURPLE_LOTUS_H].Goal);
                }
                break;
            case GOSSIP_SHOW_LEATHER:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    text = Acore::StringFormat(whisperData[gossipListId].TextA, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_LIGHT_LEATHER].Goal, sWarEffort->materialsAlliance[MATERIAL_LIGHT_LEATHER] * 10,
                        sWarEffort->materialsAlliance[MATERIAL_MEDIUM_LEATHER] * 10, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_MEDIUM_LEATHER].Goal,
                        sWarEffort->materialsAlliance[MATERIAL_THICK_LEATHER_A] * 10, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_THICK_LEATHER_A].Goal);
                }
                else
                {
                    text = Acore::StringFormat(whisperData[gossipListId].TextH, sWarEffort->WarEffortMaterialsHorde[MATERIAL_HEAVY_LEATHER].Goal, sWarEffort->materialsHorde[MATERIAL_HEAVY_LEATHER] * 10,
                        sWarEffort->materialsHorde[MATERIAL_THICK_LEATHER_B] * 10, sWarEffort->WarEffortMaterialsHorde[MATERIAL_THICK_LEATHER_B].Goal,
                        sWarEffort->materialsHorde[MATERIAL_RUGGER_LEATHER] * 10, sWarEffort->WarEffortMaterialsHorde[MATERIAL_RUGGER_LEATHER].Goal);
                }
                break;
            case GOSSIP_SHOW_BANDAGES:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    text = Acore::StringFormat(whisperData[gossipListId].TextA, sWarEffort->materialsAlliance[MATERIAL_LINEN] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_LINEN].Goal,
                        sWarEffort->materialsAlliance[MATERIAL_SILK] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_SILK].Goal,
                        sWarEffort->materialsAlliance[MATERIAL_RUNECLOTH_A] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_RUNECLOTH_A].Goal);
                }
                else
                {
                    text = Acore::StringFormat(whisperData[gossipListId].TextH, sWarEffort->WarEffortMaterialsHorde[MATERIAL_WOOL].Goal,
                        sWarEffort->materialsHorde[MATERIAL_WOOL] * 20, sWarEffort->materialsHorde[MATERIAL_MAGEWEAVE] * 20, sWarEffort->WarEffortMaterialsHorde[MATERIAL_MAGEWEAVE].Goal,
                        sWarEffort->materialsHorde[MATERIAL_RUNECLOTH_B] * 20, sWarEffort->WarEffortMaterialsHorde[MATERIAL_RUNECLOTH_B].Goal);
                }
                break;
            case GOSSIP_SHOW_FOOD:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    text = Acore::StringFormat(whisperData[gossipListId].TextA, sWarEffort->materialsAlliance[MATERIAL_ALBACORE] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_ALBACORE].Goal,
                        sWarEffort->materialsAlliance[MATERIAL_RAPTOR] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_RAPTOR].Goal,
                        sWarEffort->materialsAlliance[MATERIAL_YELLOWTAIL_A] * 20, sWarEffort->WarEffortMaterialsAlliance[MATERIAL_YELLOWTAIL_A].Goal);
                }
                else
                {
                    text = Acore::StringFormat(whisperData[gossipListId].TextH, sWarEffort->materialsHorde[MATERIAL_WOLF] * 20, sWarEffort->WarEffortMaterialsHorde[MATERIAL_WOLF].Goal,
                        sWarEffort->materialsHorde[MATERIAL_YELLOWTAIL_H] * 20, sWarEffort->WarEffortMaterialsHorde[MATERIAL_YELLOWTAIL_H].Goal,
                        sWarEffort->materialsHorde[MATERIAL_SALMON] * 20, sWarEffort->WarEffortMaterialsHorde[MATERIAL_SALMON].Goal);
                }
                break;
        }

        me->Whisper(text, LANG_UNIVERSAL, player);
        CloseGossipMenuFor(player);
    }
};

class unit_wareffort_script : public UnitScript
{
public:
    unit_wareffort_script() : UnitScript("unit_wareffort_script", true, {
        UNITHOOK_ON_UNIT_DEATH
    }) { }

    void OnUnitDeath(Unit* me, Unit* /*killer*/) override
    {
        if (sWarEffort->IsEnabled())
        {
            switch (me->GetEntry())
            {
                case 12017:
                    if (InstanceScript* script = me->GetInstanceScript())
                    {
                        me->GetMap()->DoForAllPlayers([&](Player* player)
                        {
                            if (player->GetQuestStatus(8288) == QUEST_STATUS_INCOMPLETE)
                                player->AddItem(20383, 1);
                        });
                    }
                    break;
                case 15740: // C. of Zora
                    me->SummonCreature(15797, -6829.171387, 817.593201, 50.999222, 0.041836, TEMPSUMMON_TIMED_DESPAWN, HOUR * IN_MILLISECONDS);
                    break;
                case 15741: // C. of Regal
                    me->SummonCreature(15799, -6824.444824, 800.949890, 51.481289, 0.959970, TEMPSUMMON_TIMED_DESPAWN, HOUR * IN_MILLISECONDS);
                    break;
                case 15742: // C. of Ashi
                    me->SummonCreature(15798, -6818.498535, 795.476318, 50.651131, 1.092703, TEMPSUMMON_TIMED_DESPAWN, HOUR * IN_MILLISECONDS);
                    break;
            }
        }
    }
};

using namespace Acore::ChatCommands;

class wareffort_commandscript : public CommandScript
{
public:
    wareffort_commandscript() : CommandScript("wareffort_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable wareffortTable =
        {
            { "scores", HandleWareffortShowScores, SEC_MODERATOR, Console::Yes },
        };

        static ChatCommandTable commandTable =
        {
            { "wareffort", wareffortTable },
        };

        return commandTable;
    }

    static bool HandleWareffortShowScores(ChatHandler* handler)
    {
        handler->SendSysMessage("-- Alliance Gathered Resources --");
        handler->SendSysMessage(sWarEffort->PrintOutMaterialCount(TEAM_ALLIANCE));

        if (sWarEffort->IsWarEffortComplete(TEAM_ALLIANCE))
            handler->SendSysMessage("The Alliance has gathered all the required materials!");

        handler->SendSysMessage("-- Horde Gathered Resources --");
        handler->SendSysMessage(sWarEffort->PrintOutMaterialCount(TEAM_HORDE));

        if (sWarEffort->IsWarEffortComplete(TEAM_HORDE))
            handler->SendSysMessage("The Horde has gathered all the required materials!");

        if (sWarEffort->IsWarEffortComplete(TEAM_NEUTRAL))
            handler->SendSysMessage("All the required War Effort resources have been gathered. The expedition presses on to Silithus!");

        return true;
    }
};

// Add all scripts in one
void ModAQWarEffortPlayerScripts()
{
    new ModAQWarEffortPlayerScript();
    new ModWarEffortWorldScript();
    new unit_wareffort_script();
    RegisterCreatureAI(npc_mod_war_effort_quartermaster);
    new wareffort_commandscript();
}
