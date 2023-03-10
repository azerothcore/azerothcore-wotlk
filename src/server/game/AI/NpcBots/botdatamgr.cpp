#include "bot_ai.h"
#include "botdatamgr.h"
#include "botmgr.h"
#include "botspell.h"
#include "Containers.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "GroupMgr.h"
#include "Item.h"
#include "Log.h"
#include "Map.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "WorldDatabase.h"
/*
Npc Bot Data Manager by Trickerer (onlysuffering@gmail.com)
NpcBots DB Data management
%Complete: ???
*/

#ifdef _MSC_VER
# pragma warning(push, 4)
#endif

typedef std::unordered_map<uint32 /*entry*/, NpcBotData*> NpcBotDataMap;
typedef std::unordered_map<uint32 /*entry*/, NpcBotAppearanceData*> NpcBotAppearanceDataMap;
typedef std::unordered_map<uint32 /*entry*/, NpcBotExtras*> NpcBotExtrasMap;
typedef std::unordered_map<uint32 /*entry*/, NpcBotTransmogData*> NpcBotTransmogDataMap;
NpcBotDataMap _botsData;
NpcBotAppearanceDataMap _botsAppearanceData;
NpcBotExtrasMap _botsExtras;
NpcBotTransmogDataMap _botsTransmogData;
NpcBotRegistry _existingBots;

CreatureTemplateContainer _botsWanderCreatureTemplates;
std::unordered_map<uint32, EquipmentInfo const*> _botsWanderCreatureEquipmentTemplates;

static constexpr char const* WanderMapCreationQuery =
    "CREATE TABLE IF NOT EXISTS `creature_wander_nodes` ("
    "`id` int(10) unsigned NOT NULL,"
    "`mapid` smallint(5) unsigned NOT NULL DEFAULT '0',"
    "`zoneid` int(10) unsigned NOT NULL DEFAULT '0',"
    "`x` float NOT NULL DEFAULT '0',"
    "`y` float NOT NULL DEFAULT '0',"
    "`z` float NOT NULL DEFAULT '0',"
    "`o` float NOT NULL DEFAULT '0',"
    "`name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',"
    "PRIMARY KEY (`id`)"
    ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bot Wander Map'";
static constexpr float NODE_CONNECTION_DIST_MAX = 1800.f;
static constexpr float NODE_CONNECTION_DIST_MAX_GEN = 370.f;
static constexpr std::array wanderMapIds{ 0u, 1u };

static bool allBotsLoaded = false;

class BotTravelGraph
{
public:
    ~BotTravelGraph() {
        //order
        Tops.clear();
        Nodes.clear();
    }

    struct BotTravelNode : public WorldLocation
    {
        BotTravelNode(uint32 _mapId = MAPID_INVALID, float x = 0.f, float y = 0.f, float z = 0.f, float o = 0.f,
            uint32 _id = 0, uint32 _zoneId = 0, uint8 _minlevel = 0, uint8 _maxlevel = 0, std::string const& _name = "unknown") :
            WorldLocation(_mapId, x, y, z, o), id(_id), zoneId(_zoneId), minlevel(_minlevel), maxlevel(_maxlevel), name(_name) {}
        BotTravelNode(uint32 _mapId, Position const& pos, uint32 _id, uint32 _zoneId, uint8 _minlevel, uint8 _maxlevel, std::string const& _name) :
            WorldLocation(_mapId, pos), id(_id), zoneId(_zoneId), minlevel(_minlevel), maxlevel(_maxlevel), name(_name) {}

        uint32 id;
        uint32 zoneId;
        uint8 minlevel;
        uint8 maxlevel;
        std::string name;

        std::vector<BotTravelNode*> connections;
    };

    std::unordered_map<uint32 /*mapId*/, std::unordered_map<uint32, BotTravelNode>> Nodes;
    std::vector<BotTravelNode*> Tops; // single connection nodes

    // debug
    static constexpr size_t sizeofNode = sizeof(BotTravelNode);
} static WanderMap;

void GenerateWanderNodes()
{
    using NodeType = BotTravelGraph::BotTravelNode;

    for (GameTeleContainer::value_type const& tele_pair : sObjectMgr->GetGameTeleMap())
    {
        GameTele const& tele = tele_pair.second;
        if (std::find(std::cbegin(wanderMapIds), std::cend(wanderMapIds), tele.mapId) == wanderMapIds.cend())
            continue;

        Position pos(tele.position_x, tele.position_y, tele.position_z, tele.orientation);
        uint32 teleZoneId = sMapMgr->GetZoneId(PHASEMASK_NORMAL, tele.mapId, pos);
        auto [lvlmin, lvlmax] = BotDataMgr::GetZoneLevels(teleZoneId);
        if (lvlmin == 0 || lvlmax == 0)
            continue;

        WanderMap.Nodes[tele.mapId][tele_pair.first] = NodeType(tele.mapId, pos, tele_pair.first, teleZoneId, lvlmin, lvlmax, tele.name);
    }

    for (decltype(WanderMap.Nodes)::value_type& mapNodes1 : WanderMap.Nodes)
    {
        for (decltype(mapNodes1.second)::iterator it = mapNodes1.second.begin(); it != mapNodes1.second.end();)
        {
            for (auto& nodepair2 : WanderMap.Nodes.at(it->second.m_mapId))
            {
                if (it->first == nodepair2.first)
                    continue;

                float dist2d = it->second.GetExactDist2d(nodepair2.second);
                if (dist2d < NODE_CONNECTION_DIST_MAX_GEN)
                    it->second.connections.push_back(&nodepair2.second);
            }

            if (it->second.connections.empty())
                it = mapNodes1.second.erase(it);
            else
                ++it;
        }
    }

    uint32 total_nodes = 0;
    for (decltype(WanderMap.Nodes)::value_type& mapNodes1 : WanderMap.Nodes)
        total_nodes += mapNodes1.second.size();

    if (total_nodes == 0)
    {
        LOG_FATAL("server.loading", "Failed to generate wander points: no game_tele points added!");
        ASSERT(false);
    }

    LOG_INFO("server.loading", "Generated {} nodes, saving...", total_nodes);

    std::ostringstream ss;
    ss.setf(std::ios_base::fixed);
    ss.precision(4);
    ss << "INSERT INTO creature_wander_nodes (id, mapid, zoneid, x, y, z, o, name) VALUES ";
    for (auto const& vt : WanderMap.Nodes)
    {
        for (auto const& nvt : vt.second)
        {
            auto const& n = nvt.second;
            ss << '('
                << n.id << ',' << n.m_mapId << ',' << n.zoneId << ','
                << n.m_positionX << ',' << n.m_positionY << ',' << n.m_positionZ << ',' << n.GetOrientation() << ','
                << '\'' << n.name << '\''
                << "),";
        }
    }

    std::string qstring = ss.str();
    qstring.resize(qstring.size() - 1);
    //TC_LOG_INFO("scripts", "Executing: %s", qstring.c_str());

    WorldDatabase.DirectExecute(qstring.c_str());

    LOG_INFO("server.loading", "Successfully exported {} nodes", total_nodes);
}

void FillWanderMap()
{
    using NodeType = BotTravelGraph::BotTravelNode;

    //LOG_INFO("server.loading", "Loading bot wander map...");

    uint32 botoldMSTime = getMSTime();

    WorldDatabase.DirectExecute(WanderMapCreationQuery);
    QueryResult tableExists = WorldDatabase.Query("SELECT * from creature_wander_nodes LIMIT 1");
    if (!tableExists)
    {
        LOG_WARN("server.loading", "Table `creature_wander_nodes` is empty. Trying to re-generate nodes... (this is a one-time action)");
        GenerateWanderNodes();
    }

    QueryResult wres = WorldDatabase.Query("SELECT id, mapid, zoneid, x, y, z, o, name FROM creature_wander_nodes");
    if (!wres)
    {
        LOG_FATAL("server.loading", "Failed to load wander points: table `creature_wander_nodes` is empty!");
        ASSERT(false);
    }

    do
    {
        Field* fields = wres->Fetch();
        uint32 index = 0;

        uint32 id             = fields[  index].Get<uint32>();
        uint32 mapid          = fields[++index].Get<uint16>();

        if (std::find(std::cbegin(wanderMapIds), std::cend(wanderMapIds), mapid) == wanderMapIds.cend())
            continue;

        uint32 zoneId         = fields[++index].Get<uint32>();

        auto [lvlmin, lvlmax] = BotDataMgr::GetZoneLevels(zoneId);
        if (lvlmin == 0 || lvlmax == 0)
            continue;

        float x          = fields[++index].Get<float>();
        float y          = fields[++index].Get<float>();
        float z          = fields[++index].Get<float>();
        float o          = fields[++index].Get<float>();
        std::string name = fields[++index].Get<std::string>();

        WanderMap.Nodes[mapid][id] = NodeType(mapid, x, y, z, o, id, zoneId, lvlmin, lvlmax, name);

    } while (wres->NextRow());

    uint32 total_connections = 0;
    float mindist = 50000.f;
    float maxdist = 0.f;
    for (decltype(WanderMap.Nodes)::value_type& mapNodes1 : WanderMap.Nodes)
    {
        for (decltype(mapNodes1.second)::iterator it = mapNodes1.second.begin(); it != mapNodes1.second.end();)
        {
            for (auto& nodepair2 : WanderMap.Nodes.at(it->second.m_mapId))
            {
                if (it->first == nodepair2.first)
                    continue;

                float dist2d = it->second.GetExactDist2d(nodepair2.second);
                if (dist2d < NODE_CONNECTION_DIST_MAX)
                {
                    if (dist2d < mindist)
                        mindist = dist2d;
                    if (dist2d > maxdist)
                        maxdist = dist2d;

                    it->second.connections.push_back(&nodepair2.second);
                    if (nodepair2.second.connections.empty() ||
                        std::find(std::cbegin(nodepair2.second.connections), std::cend(nodepair2.second.connections), &it->second) == nodepair2.second.connections.cend())
                        ++total_connections;
                }
            }

            if (it->second.connections.empty())
                it = mapNodes1.second.erase(it);
            else
            {
                if (it->second.connections.size() == 1u)
                {
                    WanderMap.Tops.push_back(&it->second);
                    if (it->second.connections.front()->connections.size() == 1)
                        LOG_INFO("server.loading", "Node pair {}-{} is isolated!", it->second.id, it->second.connections.front()->id);
                }
                ++it;
            }
        }
    }

    uint32 total_nodes = 0;
    for (auto const& vt : WanderMap.Nodes)
    {
        total_nodes += vt.second.size();
        if (vt.second.empty())
        {
            LOG_FATAL("server.loading", "Failed to load wander points: no game_tele points added to map {}!", vt.first);
            ASSERT(false);
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} bot wander nodes on {} maps (total {} ribs, {} tops) in {} ms",
        total_nodes, uint32(WanderMap.Nodes.size()), total_connections, uint32(WanderMap.Tops.size()), GetMSTimeDiffToNow(botoldMSTime));
    LOG_INFO("server.loading", "Nodes distances: min = {}, max = {}", mindist, maxdist);
}

std::shared_mutex* BotDataMgr::GetLock()
{
    static std::shared_mutex _lock;
    return &_lock;
}

bool BotDataMgr::AllBotsLoaded()
{
    return allBotsLoaded;
}

void BotDataMgr::LoadNpcBots(bool spawn)
{
    if (allBotsLoaded)
        return;

    LOG_INFO("server.loading", "Starting NpcBot system...");

    GenerateBotCustomSpells();

    uint32 botoldMSTime = getMSTime();

    Field* field;
    uint8 index;

    //                                                      1       2     3     4     5          6
    QueryResult result = WorldDatabase.Query("SELECT entry, gender, skin, face, hair, haircolor, features FROM creature_template_npcbot_appearance");
    if (result)
    {
        do
        {
            field = result->Fetch();
            index = 0;
            uint32 entry = field[  index].Get<uint32>();

            NpcBotAppearanceData* appearanceData = new NpcBotAppearanceData();
            appearanceData->gender =    field[++index].Get<uint8>();
            appearanceData->skin =      field[++index].Get<uint8>();
            appearanceData->face =      field[++index].Get<uint8>();
            appearanceData->hair =      field[++index].Get<uint8>();
            appearanceData->haircolor = field[++index].Get<uint8>();
            appearanceData->features =  field[++index].Get<uint8>();

            _botsAppearanceData[entry] = appearanceData;

        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Bot appearance data loaded");
    }
    else
        LOG_INFO("server.loading", ">> Bots appearance data is not loaded. Table `creature_template_npcbot_appearance` is empty!");

    //                                          1      2
    result = WorldDatabase.Query("SELECT entry, class, race FROM creature_template_npcbot_extras");
    if (result)
    {
        do
        {
            field = result->Fetch();
            index = 0;
            uint32 entry =      field[  index].Get<uint32>();

            NpcBotExtras* extras = new NpcBotExtras();
            extras->bclass =    field[++index].Get<uint8>();
            extras->race =      field[++index].Get<uint8>();

            _botsExtras[entry] = extras;

        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Bot race data loaded");
    }
    else
        LOG_INFO("server.loading", ">> Bots race data is not loaded. Table `creature_template_npcbot_extras` is empty!");

    //                                              1     2        3
    result = CharacterDatabase.Query("SELECT entry, slot, item_id, fake_id FROM characters_npcbot_transmog");
    if (result)
    {
        do
        {
            field = result->Fetch();
            index = 0;
            uint32 entry =          field[  index].Get<uint32>();

            if (_botsTransmogData.count(entry) == 0)
                _botsTransmogData[entry] = new NpcBotTransmogData();

            //load data
            uint8 slot =            field[++index].Get<uint8>();
            uint32 item_id =        field[++index].Get<uint32>();
            uint32 fake_id =        field[++index].Get<uint32>();

            _botsTransmogData[entry]->transmogs[slot] = { item_id, fake_id };

        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Bot transmog data loaded");
    }
    else
        LOG_INFO("server.loading", ">> Bots transmog data is not loaded. Table `characters_npcbot_transmog` is empty!");

    //                                       0      1      2      3     4        5          6          7          8          9               10          11          12         13
    result = CharacterDatabase.Query("SELECT entry, owner, roles, spec, faction, equipMhEx, equipOhEx, equipRhEx, equipHead, equipShoulders, equipChest, equipWaist, equipLegs, equipFeet,"
    //   14          15          16         17         18            19            20             21             22         23
        "equipWrist, equipHands, equipBack, equipBody, equipFinger1, equipFinger2, equipTrinket1, equipTrinket2, equipNeck, spells_disabled FROM characters_npcbot");

    if (result)
    {
        uint32 botcounter = 0;
        uint32 datacounter = 0;
        std::set<uint32> botgrids;
        QueryResult infores;
        CreatureTemplate const* proto;
        NpcBotData* botData;
        std::list<uint32> entryList;

        do
        {
            field = result->Fetch();
            index = 0;
            uint32 entry =          field[  index].Get<uint32>();

            //load data
            botData = new NpcBotData(0, 0);
            botData->owner =        field[++index].Get<uint32>();
            botData->roles =        field[++index].Get<uint32>();
            botData->spec =         field[++index].Get<uint8>();
            botData->faction =      field[++index].Get<uint32>();

            for (uint8 i = BOT_SLOT_MAINHAND; i != BOT_INVENTORY_SIZE; ++i)
                botData->equips[i] = field[++index].Get<uint32>();

            std::string disabled_spells_str = field[++index].Get<std::string>();
            if (!disabled_spells_str.empty())
            {
                std::vector<std::string_view> tok = Acore::Tokenize(disabled_spells_str, ' ', false);
                for (std::vector<std::string_view>::size_type i = 0; i != tok.size(); ++i)
                	botData->disabled_spells.insert(*(Acore::StringTo<uint32>(tok[i])));
            }

            entryList.push_back(entry);
            _botsData[entry] = botData;
            ++datacounter;

        } while (result->NextRow());

    	LOG_INFO("server.loading", ">> Loaded {} bot data entries", datacounter);

        if (spawn)
        {
            for (std::list<uint32>::const_iterator itr = entryList.cbegin(); itr != entryList.cend(); ++itr)
            {
                uint32 entry = *itr;
                proto = sObjectMgr->GetCreatureTemplate(entry);
                if (!proto)
                {
            		LOG_ERROR("server.loading", "Cannot find creature_template entry for npcbot (id: {})!", entry);
                    continue;
                }
                //                                     1     2    3           4            5           6
        		infores = WorldDatabase.Query("SELECT guid, map, position_x, position_y"/*, position_z, orientation*/" FROM creature WHERE id1 = {}", entry);
                if (!infores)
                {
            		LOG_ERROR("server.loading", "Cannot spawn npcbot {} (id: {}), not found in `creature` table!", proto->Name.c_str(), entry);
                    continue;
                }

        		field = infores->Fetch();
        		uint32 tableGuid = field[0].Get<uint32>();
        		uint32 mapId = uint32(field[1].Get<uint16>());
        		float pos_x = field[2].Get<float>();
        		float pos_y = field[3].Get<float>();
        		//float pos_z = field[4].GetFloat();
        		//float ori = field[5].GetFloat();

        		CellCoord c = Acore::ComputeCellCoord(pos_x, pos_y);
        		GridCoord g = Acore::ComputeGridCoord(pos_x, pos_y);
                ASSERT(c.IsCoordValid(), "Invalid Cell coord!");
                ASSERT(g.IsCoordValid(), "Invalid Grid coord!");
                Map* map = sMapMgr->CreateBaseMap(mapId);
                map->LoadGrid(pos_x, pos_y);

                ObjectGuid Guid(HighGuid::Unit, entry, tableGuid);
        		LOG_DEBUG("server.loading", "bot {}: spawnId {}, full {}", entry, tableGuid, Guid.ToString().c_str());
                Creature* bot = map->GetCreature(Guid);
                if (!bot) //not in map, use storage
                {
                    //TC_LOG_DEBUG("server.loading", "bot %u: spawnId %u, is not in map on load", entry, tableGuid);
                    typedef Map::CreatureBySpawnIdContainer::const_iterator SpawnIter;
                    std::pair<SpawnIter, SpawnIter> creBounds = map->GetCreatureBySpawnIdStore().equal_range(tableGuid);
                    if (creBounds.first == creBounds.second)
                    {
                		LOG_ERROR("server.loading", "bot {} is not in spawns list, consider re-spawning it!", entry);
                        continue;
                    }
                    bot = creBounds.first->second;
                }
                ASSERT(bot);
                if (!bot->FindMap())
            		LOG_ERROR("server.loading", "bot {} is not in map!", entry);
                if (!bot->IsInWorld())
            		LOG_ERROR("server.loading", "bot {} is not in world!", entry);
                if (!bot->IsAlive())
                {
            		LOG_ERROR("server.loading", "bot {} is dead, respawning!", entry);
                    bot->Respawn();
                }

        		LOG_DEBUG("server.loading", ">> Spawned npcbot {} (id: {}, map: {}, grid: {}, cell: {})", proto->Name.c_str(), entry, mapId, g.GetId(), c.GetId());
                botgrids.insert(g.GetId());
                ++botcounter;
            }

    		LOG_INFO("server.loading", ">> Spawned {} npcbot(s) within {} grid(s) in {} ms", botcounter, uint32(botgrids.size()), GetMSTimeDiffToNow(botoldMSTime));
        }
    }
    else
        LOG_INFO("server.loading", ">> Loaded 0 npcbots. Table `characters_npcbot` is empty!");

    allBotsLoaded = true;

    GenerateWanderingBots();
}

void BotDataMgr::LoadNpcBotGroupData()
{
    LOG_INFO("server.loading", "Loading NPCBot Group members...");

    uint32 oldMSTime = getMSTime();

    CharacterDatabase.DirectExecute("DELETE FROM characters_npcbot_group_member WHERE guid NOT IN (SELECT guid FROM `groups`)");
    CharacterDatabase.DirectExecute("DELETE FROM characters_npcbot_group_member WHERE entry NOT IN (SELECT entry FROM characters_npcbot)");

    //                                                   0     1      2            3         4
    QueryResult result = CharacterDatabase.Query("SELECT guid, entry, memberFlags, subgroup, roles FROM characters_npcbot_group_member ORDER BY guid");
    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 NPCBot group members. DB table `characters_npcbot_group_member` is empty!");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 creature_id = fields[1].Get<uint32>();
        if (!SelectNpcBotExtras(creature_id))
        {
            LOG_WARN("server.loading", "Table `characters_npcbot_group_member` contains non-NPCBot creature {} which will not be loaded!", creature_id);
            continue;
        }

        if (Group* group = sGroupMgr->GetGroupByGUID(fields[0].Get<uint32>()))
            group->LoadCreatureMemberFromDB(creature_id, fields[2].Get<uint8>(), fields[3].Get<uint8>(), fields[4].Get<uint8>());
        else
            LOG_ERROR("misc", "BotDataMgr::LoadNpcBotGroupData: Consistency failed, can't find group (storage id: {})", fields[0].Get<uint32>());

        ++count;

    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} NPCBot group members in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
}

void BotDataMgr::GenerateWanderingBots()
{
    using NodeType = BotTravelGraph::BotTravelNode;

    const uint32 WANDERING_BOTS_COUNT = BotMgr::GetDesiredWanderingBotsCount();

    if (WANDERING_BOTS_COUNT == 0)
        return;

    FillWanderMap();

    LOG_INFO("server.loading", "Spawning wandering bots...");

    uint32 oldMSTime = getMSTime();

    std::map<uint8, std::set<uint32>> spareBotIdsPerClassMap;
    for (uint8 c = BOT_CLASS_WARRIOR; c < BOT_CLASS_END; ++c)
        if (c != BOT_CLASS_BM && BotMgr::IsClassEnabled(c) && spareBotIdsPerClassMap.find(c) == spareBotIdsPerClassMap.cend())
            spareBotIdsPerClassMap.insert({ c, {} });

    uint32 maxWanderingBots = 0;
    for (decltype(_botsExtras)::value_type const& vt : _botsExtras)
    {
        uint8 c = vt.second->bclass;
        if (c != BOT_CLASS_NONE && c != BOT_CLASS_BM && BotMgr::IsClassEnabled(c) && _botsData.find(vt.first) == _botsData.end())
        {
            ASSERT(spareBotIdsPerClassMap.find(c) != spareBotIdsPerClassMap.cend());
            spareBotIdsPerClassMap.at(c).insert(vt.first);
            ++maxWanderingBots;
        }
    }

    for (uint8 c = BOT_CLASS_WARRIOR; c < BOT_CLASS_END; ++c)
        if (spareBotIdsPerClassMap.find(c) != spareBotIdsPerClassMap.cend() && spareBotIdsPerClassMap.at(c).empty())
            spareBotIdsPerClassMap.erase(c);

    if (maxWanderingBots < WANDERING_BOTS_COUNT)
    {
        LOG_FATAL("server.loading", "Only {} out of {} bots of enabled classes aren't spawned. Desired amount of wandering bots ({}) cannot be created. Aborting!",
            maxWanderingBots, uint32(_botsExtras.size()), WANDERING_BOTS_COUNT);
        ASSERT(false);
    }

    uint32 bot_id = BOT_ENTRY_CREATE_BEGIN - 1;
    QueryResult result = CharacterDatabase.Query("SELECT value FROM worldstates WHERE entry = {}", uint32(BOT_GIVER_ENTRY));
    if (!result)
    {
        LOG_WARN("server.loading", "Next bot id for autogeneration is not found! Resetting! (client cache may interfere with names)");
        for (uint32 bot_cid : GetExistingNPCBotIds())
            if (bot_cid > bot_id)
                bot_id = bot_cid;
        CharacterDatabase.DirectExecute("INSERT INTO worldstates (entry, value, comment) VALUES ({}, {}, '{}')",
            uint32(BOT_GIVER_ENTRY), bot_id, "NPCBOTS MOD - last autogenerated bot entry");
    }
    else
        bot_id = result->Fetch()[0].Get<uint32>();

    ASSERT(bot_id > BOT_ENTRY_BEGIN);

    CreatureTemplateContainer const* all_templates = sObjectMgr->GetCreatureTemplates();

    auto find_bot_creature_template_by_botclass = [&spareBotIdsPerClassMap](uint8 b_class) -> CreatureTemplate const* {
        ASSERT(spareBotIdsPerClassMap.find(b_class) != spareBotIdsPerClassMap.cend());
        auto const& cSet = spareBotIdsPerClassMap.at(b_class);
        uint32 entry = cSet.size() == 1 ? *cSet.cbegin() : Acore::Containers::SelectRandomContainerElement(cSet);
        return sObjectMgr->GetCreatureTemplate(entry);
    };

    auto remove_bot_orig_entry_from_available = [&spareBotIdsPerClassMap](uint8 bclass, uint32 botId) {
        ASSERT(spareBotIdsPerClassMap.find(bclass) != spareBotIdsPerClassMap.cend());
        ASSERT(spareBotIdsPerClassMap.at(bclass).find(botId) != spareBotIdsPerClassMap.at(bclass).cend());
        spareBotIdsPerClassMap.at(bclass).erase(botId);
        if (spareBotIdsPerClassMap.at(bclass).empty())
            spareBotIdsPerClassMap.erase(bclass);
    };

    std::set<uint32> botgrids;
    for (int32 i = 0; i < int32(WANDERING_BOTS_COUNT); ++i) // i is unused as value
    {
        while (all_templates->find(++bot_id) != all_templates->cend()) {}

        uint8 bot_class = Acore::Containers::SelectRandomContainerElement(spareBotIdsPerClassMap).first;
        CreatureTemplate const* orig_template = find_bot_creature_template_by_botclass(bot_class);
        ASSERT(orig_template);

        CreatureTemplate& bot_template = _botsWanderCreatureTemplates[bot_id];
        //copy all fields
        //pointers to non-const objects: QueryData[TOTAL_LOCALES]
        bot_template = *orig_template;
        bot_template.Entry = bot_id;
        //bot_template.Name = bot_template.Name;
        bot_template.SubName = "";
        //possibly need to override whole array (and pointer)
        bot_template.InitializeQueryData();

        NpcBotExtras const* orig_extras = SelectNpcBotExtras(orig_template->Entry);
        ASSERT_NOTNULL(orig_extras);
        ChrRacesEntry const* rentry = sChrRacesStore.LookupEntry(orig_extras->race);

        NpcBotData* bot_data = new NpcBotData(bot_ai::DefaultRolesForClass(bot_class), rentry ? rentry->FactionID : 14, bot_ai::DefaultSpecForClass(bot_class));
        _botsData[bot_id] = bot_data;
        NpcBotExtras* bot_extras = new NpcBotExtras();
        bot_extras->bclass = bot_class;
        bot_extras->race = orig_extras->race;
        _botsExtras[bot_id] = bot_extras;
        if (NpcBotAppearanceData const* orig_apdata = SelectNpcBotAppearance(orig_template->Entry))
        {
            NpcBotAppearanceData* bot_apdata = new NpcBotAppearanceData();
            bot_apdata->face = orig_apdata->face;
            bot_apdata->features = orig_apdata->features;
            bot_apdata->gender = orig_apdata->gender;
            bot_apdata->hair = orig_apdata->hair;
            bot_apdata->haircolor = orig_apdata->haircolor;
            bot_apdata->skin = orig_apdata->skin;
            _botsAppearanceData[bot_id] = bot_apdata;
        }
        int8 beqId = 1;
        _botsWanderCreatureEquipmentTemplates[bot_id] = sObjectMgr->GetEquipmentInfo(orig_template->Entry, beqId);

        //We do not create CreatureData for generated bots

        NodeType const* spawnLoc = nullptr;
        do
        {
            auto const& spair = Acore::Containers::SelectRandomContainerElement(Acore::Containers::SelectRandomContainerElement(WanderMap.Nodes).second);
            if (spair.second.maxlevel >= GetMinLevelForBotClass(bot_class))
                spawnLoc = &spair.second;

        } while (spawnLoc == nullptr);

        CellCoord c = Acore::ComputeCellCoord(spawnLoc->m_positionX, spawnLoc->m_positionY);
        GridCoord g = Acore::ComputeGridCoord(spawnLoc->m_positionX, spawnLoc->m_positionY);
        ASSERT(c.IsCoordValid(), "Invalid Cell coord!");
        ASSERT(g.IsCoordValid(), "Invalid Grid coord!");
        Map* map = sMapMgr->CreateBaseMap(spawnLoc->m_mapId);
        map->LoadGrid(spawnLoc->m_positionX, spawnLoc->m_positionY);
        ASSERT(!map->Instanceable(), map->GetDebugInfo().c_str());

        LOG_INFO("server.loading", "Spawning wandering bot: {} ({}) class {} race {} fac {}, location: mapId {} {} ({})",
            bot_template.Name.c_str(), bot_id, uint32(bot_extras->bclass), uint32(bot_extras->race), bot_data->faction,
            spawnLoc->m_mapId, spawnLoc->ToString().c_str(), spawnLoc->name.c_str());
        Position spos;
        spos.Relocate(spawnLoc->m_positionX, spawnLoc->m_positionY, spawnLoc->m_positionZ, spawnLoc->GetOrientation());
        Creature* bot = new Creature();
        if (!bot->Create(map->GenerateLowGuid<HighGuid::Unit>(), map, PHASEMASK_NORMAL, bot_id, 0, spos.m_positionX, spos.m_positionY, spos.m_positionZ, 0.0f))
        {
            delete bot;
            LOG_FATAL("server.loading", "Creature is not created!");
            ASSERT(false);
        }
        if (!bot->LoadBotCreatureFromDB(0, map, true, true, bot_id, &spos))
        {
            delete bot;
            LOG_FATAL("server.loading", "Cannot load npcbot from DB!");
            ASSERT(false);
        }

        bot->GetBotAI()->SetTravelNodeCur(spawnLoc->id);

        remove_bot_orig_entry_from_available(bot_class, orig_template->Entry);

        botgrids.insert(g.GetId());
    }

    CharacterDatabase.Execute("UPDATE worldstates SET value = {} WHERE entry = {}", bot_id, uint32(BOT_GIVER_ENTRY));

    LOG_INFO("server.loading", ">> Spawned {} wandering bots in {} grids in {} ms",
        uint32(_botsWanderCreatureTemplates.size()), uint32(botgrids.size()), GetMSTimeDiffToNow(oldMSTime));
}

CreatureTemplate const* BotDataMgr::GetBotExtraCreatureTemplate(uint32 entry)
{
    CreatureTemplateContainer::const_iterator cit = _botsWanderCreatureTemplates.find(entry);
    return cit == _botsWanderCreatureTemplates.cend() ? nullptr : &cit->second;
}

EquipmentInfo const* BotDataMgr::GetBotEquipmentInfo(uint32 entry)
{
    decltype(_botsWanderCreatureEquipmentTemplates)::const_iterator cit = _botsWanderCreatureEquipmentTemplates.find(entry);
    if (cit == _botsWanderCreatureEquipmentTemplates.cend())
    {
        static int8 eqId = 1;
        return sObjectMgr->GetEquipmentInfo(entry, eqId);
    }
    else
        return cit->second;
}

void BotDataMgr::AddNpcBotData(uint32 entry, uint32 roles, uint8 spec, uint32 faction)
{
    //botData must be allocated explicitly
    NpcBotDataMap::iterator itr = _botsData.find(entry);
    if (itr == _botsData.end())
    {
        NpcBotData* botData = new NpcBotData(roles, faction, spec);
        _botsData[entry] = botData;

        CharacterDatabasePreparedStatement* bstmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_NPCBOT);
        //"INSERT INTO characters_npcbot (entry, roles, spec, faction) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
        bstmt->SetData(0, entry);
        bstmt->SetData(1, roles);
        bstmt->SetData(2, spec);
        bstmt->SetData(3, faction);
        CharacterDatabase.Execute(bstmt);

        return;
    }

    LOG_ERROR("sql.sql", "BotMgr::AddNpcBotData(): trying to add new data but entry already exists! entry = {}", entry);
}
NpcBotData const* BotDataMgr::SelectNpcBotData(uint32 entry)
{
    NpcBotDataMap::const_iterator itr = _botsData.find(entry);
    return itr != _botsData.cend() ? itr->second : nullptr;
}
void BotDataMgr::UpdateNpcBotData(uint32 entry, NpcBotDataUpdateType updateType, void* data)
{
    NpcBotDataMap::iterator itr = _botsData.find(entry);
    if (itr == _botsData.end())
        return;

    CharacterDatabasePreparedStatement* bstmt;
    switch (updateType)
    {
        case NPCBOT_UPDATE_OWNER:
            if (itr->second->owner == *(uint32*)(data))
                break;
            itr->second->owner = *(uint32*)(data);
            bstmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NPCBOT_OWNER);
            //"UPDATE characters_npcbot SET owner = ? WHERE entry = ?", CONNECTION_ASYNC
            bstmt->SetData(0, itr->second->owner);
            bstmt->SetData(1, entry);
            CharacterDatabase.Execute(bstmt);
            //break; //no break: erase transmogs
        [[fallthrough]];
        case NPCBOT_UPDATE_TRANSMOG_ERASE:
            bstmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_NPCBOT_TRANSMOG);
            //"DELETE FROM characters_npcbot_transmog WHERE entry = ?", CONNECTION_ASYNC
            bstmt->SetData(0, entry);
            CharacterDatabase.Execute(bstmt);
            break;
        case NPCBOT_UPDATE_ROLES:
            itr->second->roles = *(uint32*)(data);
            bstmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NPCBOT_ROLES);
            //"UPDATE character_npcbot SET roles = ? WHERE entry = ?", CONNECTION_ASYNC
            bstmt->SetData(0, itr->second->roles);
            bstmt->SetData(1, entry);
            CharacterDatabase.Execute(bstmt);
            break;
        case NPCBOT_UPDATE_SPEC:
            itr->second->spec = *(uint8*)(data);
            bstmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NPCBOT_SPEC);
            //"UPDATE characters_npcbot SET spec = ? WHERE entry = ?", CONNECTION_ASYNCH
            bstmt->SetData(0, itr->second->spec);
            bstmt->SetData(1, entry);
            CharacterDatabase.Execute(bstmt);
            break;
        case NPCBOT_UPDATE_FACTION:
            itr->second->faction = *(uint32*)(data);
            bstmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NPCBOT_FACTION);
            //"UPDATE characters_npcbot SET faction = ? WHERE entry = ?", CONNECTION_ASYNCH
            bstmt->SetData(0, itr->second->faction);
            bstmt->SetData(1, entry);
            CharacterDatabase.Execute(bstmt);
            break;
        case NPCBOT_UPDATE_DISABLED_SPELLS:
        {
            NpcBotData::DisabledSpellsContainer const* spells = (NpcBotData::DisabledSpellsContainer const*)(data);
            std::ostringstream ss;
            for (NpcBotData::DisabledSpellsContainer::const_iterator citr = spells->begin(); citr != spells->end(); ++citr)
                ss << (*citr) << ' ';

            bstmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NPCBOT_DISABLED_SPELLS);
            //"UPDATE characters_npcbot SET spells_disabled = ? WHERE entry = ?", CONNECTION_ASYNCH
            bstmt->SetData(0, ss.str());
            bstmt->SetData(1, entry);
            CharacterDatabase.Execute(bstmt);
            break;
        }
        case NPCBOT_UPDATE_EQUIPS:
        {
            Item** items = (Item**)(data);

            EquipmentInfo const* einfo = BotDataMgr::GetBotEquipmentInfo(entry);

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

            bstmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NPCBOT_EQUIP);
            //"UPDATE character_npcbot SET equipMhEx = ?, equipOhEx = ?, equipRhEx = ?, equipHead = ?, equipShoulders = ?, equipChest = ?, equipWaist = ?, equipLegs = ?,
            //equipFeet = ?, equipWrist = ?, equipHands = ?, equipBack = ?, equipBody = ?, equipFinger1 = ?, equipFinger2 = ?, equipTrinket1 = ?, equipTrinket2 = ?, equipNeck = ? WHERE entry = ?", CONNECTION_ASYNC
            CharacterDatabasePreparedStatement* stmt;
            uint8 k;
            for (k = BOT_SLOT_MAINHAND; k != BOT_INVENTORY_SIZE; ++k)
            {
                itr->second->equips[k] = items[k] ? items[k]->GetGUID().GetCounter() : 0;
                if (Item const* botitem = items[k])
                {
                    bool standard = false;
                    for (uint8 i = 0; i != MAX_EQUIPMENT_ITEMS; ++i)
                    {
                        if (einfo->ItemEntry[i] == botitem->GetEntry())
                        {
                            itr->second->equips[k] = 0;
                            bstmt->SetData(k, uint32(0));
                            standard = true;
                            break;
                        }
                    }
                    if (standard)
                        continue;

                    uint8 index = 0;
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_ITEM_INSTANCE);
                    //REPLACE INTO item_instance (itemEntry, owner_guid, creatorGuid, giftCreatorGuid, count, duration, charges, flags, enchantments, randomPropertyId, durability, playedTime, text, guid)
                    //VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC : 0-13
                    stmt->SetData(  index, botitem->GetEntry());
                    stmt->SetData(++index, botitem->GetOwnerGUID().GetCounter());
                    stmt->SetData(++index, botitem->GetGuidValue(ITEM_FIELD_CREATOR).GetCounter());
                    stmt->SetData(++index, botitem->GetGuidValue(ITEM_FIELD_GIFTCREATOR).GetCounter());
                    stmt->SetData(++index, botitem->GetCount());
                    stmt->SetData(++index, botitem->GetUInt32Value(ITEM_FIELD_DURATION));

                    std::ostringstream ssSpells;
                    for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
                        ssSpells << botitem->GetSpellCharges(i) << ' ';
                    stmt->SetData(++index, ssSpells.str());

                    stmt->SetData(++index, botitem->GetUInt32Value(ITEM_FIELD_FLAGS));

                    std::ostringstream ssEnchants;
                    for (uint8 i = 0; i < MAX_ENCHANTMENT_SLOT; ++i)
                    {
                        ssEnchants << botitem->GetEnchantmentId(EnchantmentSlot(i)) << ' ';
                        ssEnchants << botitem->GetEnchantmentDuration(EnchantmentSlot(i)) << ' ';
                        ssEnchants << botitem->GetEnchantmentCharges(EnchantmentSlot(i)) << ' ';
                    }
                    stmt->SetData(++index, ssEnchants.str());

                    stmt->SetData (++index, int16(botitem->GetItemRandomPropertyId()));
                    stmt->SetData(++index, uint16(botitem->GetUInt32Value(ITEM_FIELD_DURABILITY)));
                    stmt->SetData(++index, botitem->GetUInt32Value(ITEM_FIELD_CREATE_PLAYED_TIME));
                    stmt->SetData(++index, botitem->GetText());
                    stmt->SetData(++index, botitem->GetGUID().GetCounter());

                    trans->Append(stmt);

                    Item::DeleteFromInventoryDB(trans, botitem->GetGUID().GetCounter()); //prevent duplicates

                    bstmt->SetData(k, botitem->GetGUID().GetCounter());
                }
                else
                    bstmt->SetData(k, uint32(0));
            }

            bstmt->SetData(k, entry);
            trans->Append(bstmt);
            CharacterDatabase.CommitTransaction(trans);
            break;
        }
        case NPCBOT_UPDATE_ERASE:
        {
            NpcBotDataMap::iterator bitr = _botsData.find(entry);
            ASSERT(bitr != _botsData.end());
            delete bitr->second;
            _botsData.erase(bitr);
            bstmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_NPCBOT);
            //"DELETE FROM characters_npcbot WHERE entry = ?", CONNECTION_ASYNC
            bstmt->SetData(0, entry);
            CharacterDatabase.Execute(bstmt);
            break;
        }
        default:
            LOG_ERROR("sql.sql", "BotDataMgr:UpdateNpcBotData: unhandled updateType {}", uint32(updateType));
            break;
    }
}
void BotDataMgr::UpdateNpcBotDataAll(uint32 playerGuid, NpcBotDataUpdateType updateType, void* data)
{
    CharacterDatabasePreparedStatement* bstmt;
    switch (updateType)
    {
        case NPCBOT_UPDATE_OWNER:
            bstmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NPCBOT_OWNER_ALL);
            //"UPDATE characters_npcbot SET owner = ? WHERE owner = ?", CONNECTION_ASYNC
            bstmt->SetData(0, *(uint32*)(data));
            bstmt->SetData(1, playerGuid);
            CharacterDatabase.Execute(bstmt);
            //break; //no break: erase transmogs
        [[fallthrough]];
        case NPCBOT_UPDATE_TRANSMOG_ERASE:
            bstmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_NPCBOT_TRANSMOG_ALL);
            //"DELETE FROM characters_npcbot_transmog WHERE entry IN (SELECT entry FROM characters_npcbot WHERE owner = ?)", CONNECTION_ASYNC
            bstmt->SetData(0, playerGuid);
            CharacterDatabase.Execute(bstmt);
            break;
        //case NPCBOT_UPDATE_ROLES:
        //case NPCBOT_UPDATE_FACTION:
        //case NPCBOT_UPDATE_EQUIPS:
        default:
            LOG_ERROR("sql.sql", "BotDataMgr:UpdateNpcBotDataAll: unhandled updateType {}", uint32(updateType));
            break;
    }
}

void BotDataMgr::SaveNpcBotStats(NpcBotStats const* stats)
{
    CharacterDatabasePreparedStatement* bstmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_NPCBOT_STATS);
    //"REPLACE INTO characters_npcbot_stats
    //(entry, maxhealth, maxpower, strength, agility, stamina, intellect, spirit, armor, defense,
    //resHoly, resFire, resNature, resFrost, resShadow, resArcane, blockPct, dodgePct, parryPct, critPct,
    //attackPower, spellPower, spellPen, hastePct, hitBonusPct, expertise, armorPenPct) VALUES
    //(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC

    uint32 index = 0;
    bstmt->SetData(  index, stats->entry);
    bstmt->SetData(++index, stats->maxhealth);
    bstmt->SetData(++index, stats->maxpower);
    bstmt->SetData(++index, stats->strength);
    bstmt->SetData(++index, stats->agility);
    bstmt->SetData(++index, stats->stamina);
    bstmt->SetData(++index, stats->intellect);
    bstmt->SetData(++index, stats->spirit);
    bstmt->SetData(++index, stats->armor);
    bstmt->SetData(++index, stats->defense);
    bstmt->SetData(++index, stats->resHoly);
    bstmt->SetData(++index, stats->resFire);
    bstmt->SetData(++index, stats->resNature);
    bstmt->SetData(++index, stats->resFrost);
    bstmt->SetData(++index, stats->resShadow);
    bstmt->SetData(++index, stats->resArcane);
    bstmt->SetData(++index, stats->blockPct);
    bstmt->SetData(++index, stats->dodgePct);
    bstmt->SetData(++index, stats->parryPct);
    bstmt->SetData(++index, stats->critPct);
    bstmt->SetData(++index, stats->attackPower);
    bstmt->SetData(++index, stats->spellPower);
    bstmt->SetData(++index, stats->spellPen);
    bstmt->SetData(++index, stats->hastePct);
    bstmt->SetData(++index, stats->hitBonusPct);
    bstmt->SetData(++index, stats->expertise);
    bstmt->SetData(++index, stats->armorPenPct);

    CharacterDatabase.Execute(bstmt);
}

NpcBotAppearanceData const* BotDataMgr::SelectNpcBotAppearance(uint32 entry)
{
    NpcBotAppearanceDataMap::const_iterator itr = _botsAppearanceData.find(entry);
    return itr != _botsAppearanceData.cend() ? itr->second : nullptr;
}

NpcBotExtras const* BotDataMgr::SelectNpcBotExtras(uint32 entry)
{
    NpcBotExtrasMap::const_iterator itr = _botsExtras.find(entry);
    return itr != _botsExtras.cend() ? itr->second : nullptr;
}

NpcBotTransmogData const* BotDataMgr::SelectNpcBotTransmogs(uint32 entry)
{
    NpcBotTransmogDataMap::const_iterator itr = _botsTransmogData.find(entry);
    return itr != _botsTransmogData.cend() ? itr->second : nullptr;
}
void BotDataMgr::UpdateNpcBotTransmogData(uint32 entry, uint8 slot, uint32 item_id, uint32 fake_id, bool update_db)
{
    ASSERT(slot < BOT_TRANSMOG_INVENTORY_SIZE);

    NpcBotTransmogDataMap::const_iterator itr = _botsTransmogData.find(entry);
    if (itr == _botsTransmogData.cend())
        _botsTransmogData[entry] = new NpcBotTransmogData();

    _botsTransmogData[entry]->transmogs[slot] = { item_id, fake_id };

    if (update_db)
    {
        CharacterDatabasePreparedStatement* bstmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_NPCBOT_TRANSMOG);
        //"REPLACE INTO characters_npcbot_transmog (entry, slot, item_id, fake_id) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC
        bstmt->SetData(0, entry);
        bstmt->SetData(1, slot);
        bstmt->SetData(2, item_id);
        bstmt->SetData(3, fake_id);
        CharacterDatabase.Execute(bstmt);
    }
}

void BotDataMgr::ResetNpcBotTransmogData(uint32 entry, bool update_db)
{
    NpcBotTransmogDataMap::const_iterator itr = _botsTransmogData.find(entry);
    if (itr == _botsTransmogData.cend())
        return;

    if (update_db)
    {
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        for (uint8 i = 0; i != BOT_TRANSMOG_INVENTORY_SIZE; ++i)
        {
            if (_botsTransmogData[entry]->transmogs[i].first == 0 && _botsTransmogData[entry]->transmogs[i].second == 0)
                continue;

            CharacterDatabasePreparedStatement* bstmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_NPCBOT_TRANSMOG);
            //"REPLACE INTO characters_npcbot_transmog (entry, slot, item_id, fake_id) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC
            bstmt->SetData(0, entry);
            bstmt->SetData(1, i);
            bstmt->SetData(2, 0);
            bstmt->SetData(3, 0);
            trans->Append(bstmt);
        }

        if (trans->GetSize() > 0)
            CharacterDatabase.CommitTransaction(trans);
    }

    for (uint8 i = 0; i != BOT_TRANSMOG_INVENTORY_SIZE; ++i)
        _botsTransmogData[entry]->transmogs[i] = { 0, 0 };
}

void BotDataMgr::RegisterBot(Creature const* bot)
{
    if (_existingBots.find(bot) != _existingBots.end())
    {
        LOG_ERROR("entities.unit", "BotDataMgr::RegisterBot: bot {} ({}) already registered!",
            bot->GetEntry(), bot->GetName().c_str());
        return;
    }

    std::unique_lock<std::shared_mutex> lock(*GetLock());

    _existingBots.insert(bot);
    //TC_LOG_ERROR("entities.unit", "BotDataMgr::RegisterBot: registered bot %u (%s)", bot->GetEntry(), bot->GetName().c_str());
}
void BotDataMgr::UnregisterBot(Creature const* bot)
{
    if (_existingBots.find(bot) == _existingBots.end())
    {
        LOG_ERROR("entities.unit", "BotDataMgr::UnregisterBot: bot {} ({}) not found!",
            bot->GetEntry(), bot->GetName().c_str());
        return;
    }

    std::unique_lock<std::shared_mutex> lock(*GetLock());

    _existingBots.erase(bot);
    //TC_LOG_ERROR("entities.unit", "BotDataMgr::UnregisterBot: unregistered bot %u (%s)", bot->GetEntry(), bot->GetName().c_str());
}
Creature const* BotDataMgr::FindBot(uint32 entry)
{
    std::shared_lock<std::shared_mutex> lock(*GetLock());

    for (NpcBotRegistry::const_iterator ci = _existingBots.cbegin(); ci != _existingBots.cend(); ++ci)
    {
        if ((*ci)->GetEntry() == entry)
            return *ci;
    }
    return nullptr;
}
Creature const* BotDataMgr::FindBot(std::string_view name, LocaleConstant loc)
{
    std::wstring wname;
    if (Utf8toWStr(name, wname))
    {
        wstrToLower(wname);
        std::shared_lock<std::shared_mutex> lock(*GetLock());
        for (NpcBotRegistry::const_iterator ci = _existingBots.cbegin(); ci != _existingBots.cend(); ++ci)
        {
            std::string basename = (*ci)->GetName();
            if (CreatureLocale const* creatureInfo = sObjectMgr->GetCreatureLocale((*ci)->GetEntry()))
            {
                if (creatureInfo->Name.size() > loc && !creatureInfo->Name[loc].empty())
                    basename = creatureInfo->Name[loc];
            }

            std::wstring wbname;
            if (!Utf8toWStr(basename, wbname))
                continue;

            wstrToLower(wbname);
            if (wbname == wname)
                return *ci;
        }
    }

    return nullptr;
}

NpcBotRegistry const& BotDataMgr::GetExistingNPCBots()
{
    return _existingBots;
}

void BotDataMgr::GetNPCBotGuidsByOwner(std::vector<ObjectGuid> &guids_vec, ObjectGuid owner_guid)
{
    ASSERT(AllBotsLoaded());

    std::shared_lock<std::shared_mutex> lock(*GetLock());

    for (NpcBotRegistry::const_iterator ci = _existingBots.cbegin(); ci != _existingBots.cend(); ++ci)
    {
        if (_botsData[(*ci)->GetEntry()]->owner == owner_guid.GetCounter())
            guids_vec.push_back((*ci)->GetGUID());
    }
}

ObjectGuid BotDataMgr::GetNPCBotGuid(uint32 entry)
{
    ASSERT(AllBotsLoaded());

    std::shared_lock<std::shared_mutex> lock(*GetLock());

    for (NpcBotRegistry::const_iterator ci = _existingBots.cbegin(); ci != _existingBots.cend(); ++ci)
    {
        if ((*ci)->GetEntry() == entry)
            return (*ci)->GetGUID();
    }

    return ObjectGuid::Empty;
}

std::vector<uint32> BotDataMgr::GetExistingNPCBotIds()
{
    ASSERT(AllBotsLoaded());

    std::vector<uint32> existing_ids;
    existing_ids.reserve(_botsData.size());
    for (decltype(_botsData)::value_type const& bot_data_pair : _botsData)
        existing_ids.push_back(bot_data_pair.first);

    return existing_ids;
}

uint8 BotDataMgr::GetOwnedBotsCount(ObjectGuid owner_guid, uint32 class_mask)
{
    uint8 count = 0;
    for (decltype(_botsData)::value_type const& bdata : _botsData)
        if (bdata.second->owner == owner_guid.GetCounter() && (!class_mask || !!(class_mask & (1u << (_botsExtras[bdata.first]->bclass - 1)))))
            ++count;

    return count;
}

uint8 BotDataMgr::GetLevelBonusForBotRank(uint32 rank)
{
    switch (rank)
    {
        case CREATURE_ELITE_RARE:
            return 1;
        case CREATURE_ELITE_ELITE:
            return 2;
        case CREATURE_ELITE_RAREELITE:
            return 3;
        default:
            return 0;
    }
}

uint8 BotDataMgr::GetMaxLevelForMapId(uint32 mapId)
{
    switch (mapId)
    {
        case 0:
        case 1:
            return 60;
        case 530:
            return 70;
        case 571:
            return 80;
        default:
            return 80;
    }
}

uint8 BotDataMgr::GetMinLevelForBotClass(uint8 m_class)
{
    switch (m_class)
    {
        case BOT_CLASS_DEATH_KNIGHT:
            return 55;
        case BOT_CLASS_ARCHMAGE:
        case BOT_CLASS_SPELLBREAKER:
        case BOT_CLASS_NECROMANCER:
            return 20;
        case BOT_CLASS_DARK_RANGER:
            return 40;
        case BOT_CLASS_SPHYNX:
        case BOT_CLASS_DREADLORD:
            return 60;
        default:
            return 1;
    }
}

std::pair<uint8, uint8> BotDataMgr::GetZoneLevels(uint32 zoneId)
{
    //Only maps 0 and 1 are covered
    switch (zoneId)
    {
        case 1: // Dun Morogh
        case 12: // Elwynn Forest
        case 14: // Durotar
        case 85: // Tirisfal Glades
        case 141: // Teldrassil
        case 215: // Mulgore
        case 3430: // Eversong Woods
        case 3524: // Azuremyst Isle
            return { 1, 12 };
        case 38: // Loch Modan
        case 40: // Westfall
        case 130: // Silverpine Woods
        case 148: // Darkshore
        case 3433: // Ghostlands
        case 3525: // Bloodmyst Isle
            return { 8, 22 };
        case 17: // Barrens
        case 721: // Gnomeregan
            return { 8, 28 };
        case 44: // Redridge Mountains
            return { 13, 28 };
        case 406: // Stonetalon Mountains
            return { 13, 30 };
        case 10: // Duskwood
        case 11: // Wetlands
        case 267: // Hillsbrad Foothills
        case 331: // Ashenvale
            return { 18, 32 };
        case 400: // Thousand Needles
            return { 23, 38 };
        case 36: // Alterac Mountains
        case 45: // Arathi Highlands
        case 405: // Desolace
            return { 28, 42 };
        case 33: // Stranglethorn Valley
            return { 28, 48 };
        case 3: // Badlands
        case 8: // Swamp of Sorrows
        case 15: // Dustwallow Marsh
            return { 33, 48 };
        case 47: // Hinterlands
        case 357: // Feralas
        case 440: // Tanaris
            return { 38, 52 };
        case 4: // Blasted Lands
        case 16: // Azshara
        case 51: // Searing Gorge
            return { 43, 54 };
        case 490: // Un'Goro Crater
            return { 45, 56 };
        case 361: // Felwood
            return { 46, 56 };
        case 28: // Western Plaguelands
        case 46: // Burning Steppes
            return { 48, 56 };
        case 41: // Deadwind Pass
            return { 50, 60 };
        case 1377: // Silithus
            return { 53, 60 };
        case 139: // Eastern Plaguelands
        case 618: // Winterspring
            return { 53, 60 }; //63
        default:
            LOG_ERROR("scripts", "GetZoneLevels: no choice for zoneId {}", zoneId);
            return { 50, 60 };
    }
}

std::pair<uint32, Position const*> BotDataMgr::GetWanderMapNode(uint32 mapId, uint32 curNodeId, uint32 lastNodeId, uint8 lvl)
{
    decltype(WanderMap.Nodes)::const_iterator cit = WanderMap.Nodes.find(mapId);
    if (cit != WanderMap.Nodes.cend())
    {
        decltype(WanderMap.Nodes)::value_type::second_type::const_iterator ici = cit->second.find(curNodeId);
        if (ici != cit->second.cend())
        {
            std::vector<decltype(WanderMap)::BotTravelNode const*> convec;
            if (ici->second.connections.size() == 1)
                convec.push_back(ici->second.connections.front());
            else
            {
                uint8 minlevel = 255;
                for (auto const* con : ici->second.connections)
                {
                    if (con->id != lastNodeId && lvl >= con->minlevel && lvl <= con->maxlevel + 3)
                        convec.push_back(con);
                    if (con->maxlevel < minlevel)
                        minlevel = con->maxlevel;
                }
                if (convec.empty())
                {
                    for (auto const* con : ici->second.connections)
                    {
                        if (con->id != lastNodeId && con->maxlevel == minlevel)
                            convec.push_back(con);
                    }
                }
                if (convec.empty())
                {
                    for (auto const* con : ici->second.connections)
                    {
                        if (con->maxlevel == minlevel)
                            convec.push_back(con);
                    }
                }
                if (convec.empty())
                {
                    for (auto const* con : ici->second.connections)
                    {
                        if (con->id != lastNodeId)
                            convec.push_back(con);
                    }
                }
            }
            ASSERT(!convec.empty());
            auto* randomNode = (convec.size() == 1) ? convec.front() : Acore::Containers::SelectRandomContainerElement(convec);
            return std::make_pair(randomNode->id, static_cast<Position const*>(randomNode));
        }
    }

    return { 0, nullptr };
}

Position const* BotDataMgr::GetWanderMapNodePosition(uint32 mapId, uint32 nodeId)
{
    decltype(WanderMap.Nodes)::const_iterator cit = WanderMap.Nodes.find(mapId);
    if (cit != WanderMap.Nodes.cend())
    {
        decltype(WanderMap.Nodes)::value_type::second_type::const_iterator ici = cit->second.find(nodeId);
        if (ici != cit->second.cend())
            return static_cast<Position const*>(&ici->second);
    }
    return nullptr;
}

std::string BotDataMgr::GetWanderMapNodeName(uint32 mapId, uint32 nodeId)
{
    decltype(WanderMap.Nodes)::const_iterator cit = WanderMap.Nodes.find(mapId);
    if (cit != WanderMap.Nodes.cend())
    {
        decltype(WanderMap.Nodes)::value_type::second_type::const_iterator ici = cit->second.find(nodeId);
        if (ici != cit->second.cend())
            return ici->second.name;
    }
    return {};
}

#ifdef _MSC_VER
# pragma warning(pop)
#endif
