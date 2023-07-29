#include "ForgedInstanceManager.h"

std::map<uint32 /* bossId */, std::vector<PossibleLoot> /* possibleLoot*/> ForgedInstanceManager::loots = {};
std::vector<Completion> ForgedInstanceManager::completions = {};
std::map<uint32, uint32> ForgedInstanceManager::requierements = {};
std::map<uint32, ForgedInstanceManager::ForgedInstance> ForgedInstanceManager::encounters = {};
std::map<uint32 /* mapId */, Modifier /* Modifier */> ForgedInstanceManager::creaturesModifiers = {};

void ForgedInstanceManager::CreateLoot(uint32 bossId, Creature* boss)
{
    if (!boss)
        return;

    uint32 instanceId = boss->GetMap()->GetInstanceId();

    if (!IsInForgedInstance(instanceId))
        return;


    ForgedInstance ForgedInstance = GetForgedInstanceEncounter(instanceId);

    if (ForgedInstance.isRaid) {
        boss->loot.items.clear();
        std::vector<LootStoreItem> loots = GenerateForgedInstanceLoot(bossId, boss->GetLootMode());
        for (auto& item : loots) {
            boss->loot.AddItem(item);
        }
    }
    RewardEmblemsPlayers(boss->GetMap()->GetPlayers(), ForgedInstance.isRaid);
}

void ForgedInstanceManager::CreateLoot(uint32 bossId, GameObject* go)
{
    if (!go)
        return;

    uint32 instanceId = go->GetMap()->GetInstanceId();

    if (!IsInForgedInstance(instanceId))
        return;

    ForgedInstance ForgedInstance = GetForgedInstanceEncounter(instanceId);

    if (ForgedInstance.isRaid) {
        go->loot.clear();
        std::vector<LootStoreItem> loots = GenerateForgedInstanceLoot(bossId, go->GetLootMode());
        for (auto& item : loots) {
            go->loot.AddItem(item);
        }
    }
    RewardEmblemsPlayers(go->GetMap()->GetPlayers(), ForgedInstance.isRaid);
}

void ForgedInstanceManager::StartForgedInstance(Player* player, uint8 level)
{
    Group* group = player->GetGroup();

    if (!group) {
        ChatHandler(player->GetSession()).PSendSysMessage("You need to be in group to start this dungeon on Forged Difficulty.");
        return;
    }

    if (group->GetLeaderGUID() != player->GetGUID()) {
        ChatHandler(player->GetSession()).PSendSysMessage("You need to be the group leader to start this dungeon on Forged Difficulty.");
        return;
    }

    Map* map = player->GetMap();

    Group::MemberSlotList const& members = group->GetMemberSlots();
    uint32 instanceId = map->GetInstanceId();
    std::vector<uint64> playerGuidsDoNotMeetRequierement = {};

   /* for (auto itr = members.begin(); itr != members.end(); ++itr) {
        Player* GroupMember = ObjectAccessor::GetPlayer(map, itr->guid);
        if (!GroupMember) {
            ChatHandler(player->GetSession()).PSendSysMessage("Someone in your group is disconnected.");
            return;
        }
    }

    for (auto itr = members.begin(); itr != members.end(); ++itr) {
        if (Player* GroupMember = ObjectAccessor::GetPlayer(map, itr->guid)) {
            if (!CanDoForgedInstance(GroupMember, map->GetId()))
                playerGuidsDoNotMeetRequierement.push_back(GroupMember->GetGUID().GetCounter());
        }
    }

    if (playerGuidsDoNotMeetRequierement.size() > 0) {
        std::string names = "";
        for (auto guid : playerGuidsDoNotMeetRequierement) {
            if (Player* GroupMember = ObjectAccessor::GetPlayer(map, ObjectGuid(guid)))
                names += GroupMember->GetName() + (playerGuidsDoNotMeetRequierement.size() > 1 ? ", " :  ".");
        }

        ChatHandler(player->GetSession()).PSendSysMessage("Theses player(s) in your group do not meet the requirements to start : %s", names);
        return;
    } */

    for (auto itr = members.begin(); itr != members.end(); ++itr) {
        Player* GroupMember = ObjectAccessor::FindPlayer(itr->guid);
        if (GroupMember) {
            ChatHandler(GroupMember->GetSession()).PSendSysMessage("Your group leader started %s on ForgedInstance difficulty.", map->GetMapName());
        }
    }

    bool isRaid = map->IsRaid();
    ForgedInstanceManager::encounters[map->GetInstanceId()] = { map, group->GetGUID().GetCounter(), player, isRaid, {}, level};
}

void ForgedInstanceManager::AddKillCreditBoss(Player* player, uint32 bossId)
{
    auto completion = std::find_if(ForgedInstanceManager::completions.begin(), ForgedInstanceManager::completions.end(), [&](Completion const& completion)
    {
        return completion.bossId == bossId;
    });

    if (completion == ForgedInstanceManager::completions.end()) {
        completions.push_back({ player->GetGUID().GetCounter(), bossId });
        CharacterDatabase.Query("INSERT ForgedInstance_completions (guid, bossId) VALUES ({}, {})", player->GetGUID().GetCounter(), bossId);
    }
}

void ForgedInstanceManager::RemoveGuidCalculated(Creature* creature)
{
    if (!IsInForgedInstance(creature->GetInstanceId()))
        return;

    ForgedInstanceManager::encounters[creature->GetInstanceId()].creatureGuids.erase(std::remove(
        ForgedInstanceManager::encounters[creature->GetInstanceId()].creatureGuids.begin(),
        ForgedInstanceManager::encounters[creature->GetInstanceId()].creatureGuids.end(), creature->GetGUID().GetCounter()),
        ForgedInstanceManager::encounters[creature->GetInstanceId()].creatureGuids.end());
}

void ForgedInstanceManager::PreloadAllLoot()
{
    QueryResult result = WorldDatabase.Query("SELECT * FROM ForgedInstance_loot");

    if (result) {
        do
        {
            Field* fields = result->Fetch();
            uint32 bossId = fields[0].Get<uint32>();
            uint32 itemId = fields[1].Get<uint32>();
            uint32 quantity = fields[2].Get<uint32>();
            ForgedInstanceManager::loots[bossId].push_back({ itemId, quantity });
        } while (result->NextRow());
    }
}

void ForgedInstanceManager::PreloadAllCompletions()
{
    QueryResult result = CharacterDatabase.Query("SELECT * FROM ForgedInstance_completions");

    if (result) {
        do
        {
            Field* fields = result->Fetch();
            uint64 guid = fields[0].Get<uint64>();
            uint32 bossId = fields[1].Get<uint32>();
            ForgedInstanceManager::completions.push_back({ guid, bossId });
        } while (result->NextRow());
    }
}

void ForgedInstanceManager::PreloadAllRequierements()
{
    QueryResult result = WorldDatabase.Query("SELECT * FROM ForgedInstance_requierements");

    if (result) {
        do
        {
            Field* fields = result->Fetch();
            uint32 mapId = fields[0].Get<uint32>();
            uint32 bossId = fields[1].Get<uint32>();
            ForgedInstanceManager::requierements[mapId] = bossId;
        } while (result->NextRow());
    }
}

void ForgedInstanceManager::PreloadAllCreaturesIds()
{
    QueryResult result = WorldDatabase.Query("SELECT * FROM ForgedInstance_difficulty");
    if (result) {
        do
        {
            Field* fields = result->Fetch();
            uint32 mapId = fields[0].Get<uint32>();
            float spellMultiplier = fields[1].Get<float>();
            float meleeMultiplier = fields[2].Get<float>();
            float healthMultiplier = fields[3].Get<float>();
            float healthCoefficient = fields[4].Get<float>();
            ForgedInstanceManager::creaturesModifiers[mapId] = { spellMultiplier, meleeMultiplier, healthMultiplier, healthCoefficient };
        } while (result->NextRow());
    }
}

bool ForgedInstanceManager::CanDoForgedInstance(Player* player, uint32 mapId)
{
    auto it = ForgedInstanceManager::requierements.find(mapId);
    if (it == ForgedInstanceManager::requierements.end())
        return false;

    uint32 bossId = it->second;

    auto completion = std::find_if(ForgedInstanceManager::completions.begin(), ForgedInstanceManager::completions.end(), [&](Completion const& completion)
    {
        return completion.bossId == bossId;
    });

    if (completion == ForgedInstanceManager::completions.end())
        return false;

    return true;  
}

ForgedInstanceManager::ForgedInstance ForgedInstanceManager::GetForgedInstanceEncounter(uint32 instanceId)
{
    auto itr = ForgedInstanceManager::encounters.find(instanceId);
    if (itr != ForgedInstanceManager::encounters.end())
        return itr->second;

    return {};
}

void ForgedInstanceManager::ResetForgedInstance(Group* group, bool remove)
{
    for (auto it = ForgedInstanceManager::encounters.begin(); it != ForgedInstanceManager::encounters.end(); ++it)
    {
        if (it->second.groupGuid == group->GetGUID().GetCounter()) {
            it->second.creatureGuids.clear();
            if (remove) {
                ForgedInstanceManager::encounters.erase(it);
                return;
            }
        }
    }
}

void ForgedInstanceManager::AddCreatureCalculated(Map* map, uint64 guid)
{
    ForgedInstanceManager::encounters[map->GetInstanceId()].creatureGuids.push_back(guid);
}

void ForgedInstanceManager::RewardEmblemsPlayers(Map::PlayerList const& playerList, bool isRaid)
{
    if (playerList.IsEmpty())
        return;

    for (Map::PlayerList::const_iterator playerIteration = playerList.begin(); playerIteration != playerList.end(); ++playerIteration)
        if (playerIteration->GetSource()) {
            Player* p = playerIteration->GetSource();
            Group* group = p->GetGroup();

            if (!group)
                return;

            uint32 emblemId = sConfigMgr->GetOption<uint32>("RaidEmblemId", 40753);

            Group::MemberSlotList const& members = group->GetMemberSlots();
            for (auto itr = members.begin(); itr != members.end(); ++itr) {
                Player* GroupMember = ObjectAccessor::FindPlayer(itr->guid);
                if (GroupMember) {
                    GroupMember->AddItem(emblemId, isRaid ? 10 : 3);
                    GroupMember->AddItem(400506, isRaid ? 3 : 1);
                }
            }
            break;
        }



}

std::vector<LootStoreItem> ForgedInstanceManager::GenerateForgedInstanceLoot(uint32 bossId, uint8 lootMode)
{
    std::vector<LootStoreItem> loots = {};
    std::vector<PossibleLoot> possibleLoots = {};

    auto it = ForgedInstanceManager::loots.find(bossId);
    if (it != ForgedInstanceManager::loots.end())
        possibleLoots = it->second;

    if (possibleLoots.size() == 0)
        return loots;

    uint32 itemCount = 5;

    for (size_t i = 1; i <= itemCount; i++)
    {
        int random = rand() % possibleLoots.size();
        uint32 itemId = possibleLoots[random].ItemId;
        if (itemId) {
            auto founded = std::find_if(possibleLoots.begin(), possibleLoots.end(), [&](PossibleLoot const& loot)
            {
                return loot.ItemId == itemId;
            });
            possibleLoots.erase(founded);
            LootStoreItem storeItem = LootStoreItem(itemId, 0, 100, 0, lootMode, 0, 1, 1);
            loots.push_back(storeItem);
        }
    }
    return loots;
}

Modifier ForgedInstanceManager::GetModifier(uint32 mapId)
{
    auto it = ForgedInstanceManager::creaturesModifiers.find(mapId);
    if (it != ForgedInstanceManager::creaturesModifiers.end())
        return it->second;

    return {};
}

bool ForgedInstanceManager::IsInForgedInstance(uint32 instanceId)
{
    auto it = ForgedInstanceManager::encounters.find(instanceId);
    if (it != ForgedInstanceManager::encounters.end())
        return true;
        
    return false;
}

bool ForgedInstanceManager::IsInForgedInstance(Player* player)
{
    const uint32 instanceId = player->GetMap()->GetInstanceId();
    auto itr = ForgedInstanceManager::encounters.find(player->GetMap()->GetInstanceId());
    if (itr != ForgedInstanceManager::encounters.end())
        return true;
    return false;
}

bool ForgedInstanceManager::creatureAlreadyCalculated(uint32 instanceId, uint64 guid)
{
    auto itr = ForgedInstanceManager::encounters.find(instanceId);
    if (itr != ForgedInstanceManager::encounters.end())
        if (std::find(ForgedInstanceManager::encounters[instanceId].creatureGuids.begin(), ForgedInstanceManager::encounters[instanceId].creatureGuids.end(), guid)
            != ForgedInstanceManager::encounters[instanceId].creatureGuids.end())
                return true;

    return false;
}
