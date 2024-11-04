#ifndef BOTWANDERFUL_H_
#define BOTWANDERFUL_H_

#include "Position.h"

#include <functional>
#include <list>
#include <mutex>
#include <shared_mutex>
#include <unordered_map>

/*
NpcBot System by Trickerer (onlysuffering@gmail.com)
Original patch from: LordPsyan https://bitbucket.org/lordpsyan/trinitycore-patches/src/3b8b9072280e/Individual/11185-BOTS-NPCBots.patch
*/

class Creature;

enum class BotWPFlags : uint32
{
    BOTWP_FLAG_NONE                         = 0x00000000,
    BOTWP_FLAG_SPAWN                        = 0x00000001, // wandering bots can spawn at this WP location
    BOTWP_FLAG_ALLIANCE_ONLY                = 0x00000002, // only alliance bots can move here, SPAWN+A = only alliance bots can spawn at this WP location
    BOTWP_FLAG_HORDE_ONLY                   = 0x00000004, // only horde bots can move here, SPAWN+H = only horde bots can spawn at this WP location
    BOTWP_FLAG_CAN_BACKTRACK_FROM           = 0x00000008, // can move back to WPs links even if other links exist
    BOTWP_FLAG_MOVEMENT_IGNORES_FACTION     = 0x00000010, // ignore faction flags when trying to select this WP as move point
    BOTWP_FLAG_MOVEMENT_IGNORES_PATHING     = 0x00000020, // do not generate path between 2 WPs having this flag
    BOTWP_FLAG_BG_FLAG_DELIVER_TARGET       = 0x00000040, // <BG only> flag carrier destination marker
    BOTWP_FLAG_BG_FLAG_PICKUP_TARGET        = 0x00000080, // <BG only> flag pick/activate up marker
    BOTWP_FLAG_BG_BOSS_ROOM                 = 0x00000100, // <BG only> boss room to attack as group / defend
    BOTWP_FLAG_BG_MISC_OBJECTIVE_1          = 0x00000200, // <BG only> misc objective 1 (AV = mine)
    BOTWP_FLAG_BG_MISC_OBJECTIVE_2          = 0x00000400, // <BG only> misc objective 2 (AV = captain)
    BOTWP_FLAG_BG_OPTIONAL_PICKUP_1         = 0x00000800, // <BG only> optional pickup point 1 (WS = healNW, AB = stables)
    BOTWP_FLAG_BG_OPTIONAL_PICKUP_2         = 0x00001000, // <BG only> optional pickup point 2 (WS = bersNE, AB = farm)
    BOTWP_FLAG_BG_OPTIONAL_PICKUP_3         = 0x00002000, // <BG only> optional pickup point 3 (WS = healSE, AB = mill)
    BOTWP_FLAG_BG_OPTIONAL_PICKUP_4         = 0x00004000, // <BG only> optional pickup point 4 (WS = bersSW, AB = mine)
    BOTWP_FLAG_BG_OPTIONAL_PICKUP_5         = 0x00008000, // <BG only> optional pickup point 5 (AB = blacksmith)
    BOTWP_FLAG_MOVEMENT_FORCE_JUMP_BEGIN    = 0x00010000, // movement between 2 WPs having begin and end flags is forced to be a jump (prevent casting when falling from a cliff)
    BOTWP_FLAG_MOVEMENT_FORCE_JUMP_END      = 0x00020000, // movement between 2 WPs having begin and end flags is forced to be a jump (prevent casting when falling from a cliff)
    BOTWP_FLAG_END                          = 0x00040000,

    BOTWP_FLAG_ALLIANCE_OR_HORDE_ONLY       = BOTWP_FLAG_ALLIANCE_ONLY | BOTWP_FLAG_HORDE_ONLY,
    BOTWP_FLAG_ALLIANCE_SPAWN_POINT         = BOTWP_FLAG_SPAWN | BOTWP_FLAG_ALLIANCE_ONLY,
    BOTWP_FLAG_HORDE_SPAWN_POINT            = BOTWP_FLAG_SPAWN | BOTWP_FLAG_HORDE_ONLY,
    BOTWP_FLAG_ALLIANCE_FLAG_DELIVER_TARGET = BOTWP_FLAG_BG_FLAG_DELIVER_TARGET | BOTWP_FLAG_ALLIANCE_ONLY,
    BOTWP_FLAG_HORDE_FLAG_DELIVER_TARGET    = BOTWP_FLAG_BG_FLAG_DELIVER_TARGET | BOTWP_FLAG_HORDE_ONLY,
    BOTWP_FLAG_ALLIANCE_FLAG_PICKUP_TARGET  = BOTWP_FLAG_BG_FLAG_PICKUP_TARGET | BOTWP_FLAG_ALLIANCE_ONLY,
    BOTWP_FLAG_HORDE_FLAG_PICKUP_TARGET     = BOTWP_FLAG_BG_FLAG_PICKUP_TARGET | BOTWP_FLAG_HORDE_ONLY,
    BOTWP_FLAG_ALLIANCE_BOSS_ROOM           = BOTWP_FLAG_BG_BOSS_ROOM | BOTWP_FLAG_ALLIANCE_ONLY,
    BOTWP_FLAG_HORDE_BOSS_ROOM              = BOTWP_FLAG_BG_BOSS_ROOM | BOTWP_FLAG_HORDE_ONLY,
    BOTWP_FLAG_ALLIANCE_DEMIBOSS_ROOM       = BOTWP_FLAG_BG_MISC_OBJECTIVE_2 | BOTWP_FLAG_ALLIANCE_ONLY,
    BOTWP_FLAG_HORDE_DEMIBOSS_ROOM          = BOTWP_FLAG_BG_MISC_OBJECTIVE_2 | BOTWP_FLAG_HORDE_ONLY,
    BOTWP_FLAG_OPTIONAL_PICKUP              = (BOTWP_FLAG_BG_OPTIONAL_PICKUP_1 | BOTWP_FLAG_BG_OPTIONAL_PICKUP_2 | BOTWP_FLAG_BG_OPTIONAL_PICKUP_3 |
                                               BOTWP_FLAG_BG_OPTIONAL_PICKUP_4 | BOTWP_FLAG_BG_OPTIONAL_PICKUP_5),
    BOTWP_FLAG_WS_PICKUP_RESTORATION        = BOTWP_FLAG_BG_OPTIONAL_PICKUP_1 | BOTWP_FLAG_BG_OPTIONAL_PICKUP_3,
    BOTWP_FLAG_WS_PICKUP_BERSERKING         = BOTWP_FLAG_BG_OPTIONAL_PICKUP_2 | BOTWP_FLAG_BG_OPTIONAL_PICKUP_4,
};

enum class BotWPLevel : uint32
{
    BOTWP_LEVEL_ZERO                        = 0,
    BOTWP_LEVEL_ONE                         = 1,
};

constexpr uint32 WP_SPELL_ID_LINK_TO = 64034;
constexpr uint32 WP_SPELL_ID_LINK_FROM = 64036;

class WanderNode : public Position
{
public:
    struct WanderNodeLink
    {
        WanderNode* wp;
        uint32 weight;

        inline uint32 Id() const { return wp ? wp->GetWPId() : 0; }

        inline std::strong_ordering operator<=>(WanderNodeLink const& other) const noexcept = default;

        struct WeightExtractor {
            constexpr uint32 operator()(WanderNodeLink const& wpl) { return wpl.weight; }
            constexpr uint32 operator()(WanderNodeLink const* wpl) { return wpl->weight; }
        };
    };

private:
    using node_ltype = std::list<WanderNode*>;
    using node_ltype_c = std::list<WanderNode const*>;
    using node_mtype = std::unordered_map<uint32, node_ltype>;
    using node_lltype = std::list<WanderNodeLink>;

    using node_proc_ftype = std::function<void(WanderNode*)>;
    using node_proc_ftype_c = std::function<void(WanderNode const*)>;
    using node_check_ftype_c = std::function<bool(WanderNode const*)>;
    using node_proc_ltype = std::function<void(WanderNodeLink const&)>;

    using mutex_type = std::recursive_mutex;
    using lock_type = std::unique_lock<mutex_type>;

    static node_ltype ALL_WPS;
    static node_mtype ALL_WPS_PER_MAP;
    static node_mtype ALL_WPS_PER_ZONE;
    static node_mtype ALL_WPS_PER_AREA;

    template<class T, typename = void>
    struct is_container : std::false_type {};
    template<class T>
    struct is_container<T, std::void_t<decltype(std::declval<typename T::const_iterator>()), decltype(std::declval<T>().size())>> : std::true_type {};
    template<class T>
    static constexpr bool is_container_v = is_container<T>::value;

public:
    static uint32 nextWPId;

    static mutex_type* GetLock();

    static WanderNode* FindInAllWPs(uint32 wpId);
    static WanderNode* FindInAllWPs(Creature const* creature);
    static WanderNode* FindInMapWPs(uint32 mapId, Creature const* creature);
    static WanderNode* FindInMapWPs(uint32 mapId, uint32 wpId);
    static WanderNode* FindInMapWPs(uint32 mapId, node_check_ftype_c const& pred);
    static WanderNode* FindInZoneWPs(uint32 zoneId, node_check_ftype_c const& pred);
    static WanderNode* FindInAreaWPs(uint32 areaId, node_check_ftype_c const& pred);

    template<typename Func>
    static void DoForContainerWPLinks(WanderNode::node_lltype const& c, Func&& func) {
        static_assert(std::is_convertible_v<Func, node_proc_ltype>);
        for (auto const& wl : c)
            func(wl);
    }

    template<typename Container, typename Func>
    static void DoForContainerWPs(Container const& c, Func&& func) {
        static_assert(WanderNode::is_container_v<Container>);
        static_assert(std::is_same_v<std::decay_t<std::remove_pointer_t<typename Container::value_type>>, WanderNode>);
        static_assert(std::is_convertible_v<Func, node_proc_ftype>);
        //lock_type lock(*GetLock());
        for (auto* wp : c)
            func(wp);
    }

    static void DoForAllWPs(node_proc_ftype&& func);
    static void DoForAllMapWPs(uint32 mapId, node_proc_ftype_c&& func);
    static void DoForAllZoneWPs(uint32 zoneId, node_proc_ftype_c&& func);
    static void DoForAllAreaWPs(uint32 areaId, node_proc_ftype_c&& func);
    static size_t GetAllWPsCount();
    static size_t GetMapWPsCount(uint32 mapId);
    static size_t GetWPMapsCount();

    WanderNode(uint32 wpId, uint32 mapId, float x, float y, float z, float o, uint32 zoneId, uint32 areaId, std::string const& name);
    ~WanderNode();

    static void RemoveAllWPs();
    static void RemoveWP(WanderNode* wp);

    //utils
    WanderNode::node_lltype GetShortestPathLinks(WanderNode const* target, WanderNode::node_lltype const& base_links, BotWPLevel max_level_diff = BotWPLevel::BOTWP_LEVEL_ZERO) const;

    //base
    void SetCreature(Creature* creature);
    Creature* GetCreature() const;

    std::string FormatLinks() const;
    uint32 GetAverageLinkWeight(bool exclude_0 = false) const;

    void Link(WanderNodeLink&& wpl);
    void UnLink(uint32 wp_id);
    inline void UnLink(WanderNodeLink const& wpl) { return UnLink(wpl.Id()); }
    inline void UnLink(WanderNode const* wp) { return UnLink(wp->GetWPId()); }
    inline bool HasLink(uint32 wp_id) const { return GetLink(wp_id) != _links.cend(); }
    inline bool HasLink(WanderNodeLink const& wpl) const { return HasLink(wpl.Id()); }
    inline bool HasLink(WanderNode const* wp) const { return HasLink(wp->GetWPId()); }
    auto GetLinks() const -> typename std::add_const_t<WanderNode::node_lltype>& { return _links; }
    auto GetLink(uint32 wp_id) -> typename WanderNode::node_lltype::iterator {
        return std::ranges::find_if(_links, [=](WanderNodeLink const& wpl) { return wpl.Id() == wp_id; });
    }
    auto GetLink(uint32 wp_id) const -> typename WanderNode::node_lltype::const_iterator {
        return std::ranges::find_if(_links, [=](WanderNodeLink const& wpl) { return wpl.Id() == wp_id; });
    }

    void SetLinkWeight(uint32 wp_id, uint32 new_weight);

    void SetLevels(std::pair<uint8, uint8> levels) { std::tie(_minLevel, _maxLevel) = levels; }
    inline void SetLevels(uint8 minLevel, uint8 maxLevel) { SetLevels(std::pair{ minLevel, maxLevel }); }

    void SetFlags(BotWPFlags flags);
    void RemoveFlags(BotWPFlags flags);
    bool HasFlag(BotWPFlags flags) const;
    bool HasAllFlags(BotWPFlags flags) const;

    void SetName(std::string const& name) { _name = name; }

    void SetId(uint32 newid) { _wpId = newid; }

    std::string ToString(int32 link_weight = -1) const;

    uint32 GetWPId() const { return _wpId; }
    uint32 GetMapId() const { return _mapId; }
    uint32 GetZoneId() const { return _zoneId; }
    uint32 GetAreaId() const { return _areaId; }
    std::string const& GetName() const { return _name; }
    std::pair<uint8, uint8> GetLevels() const { return { _minLevel, _maxLevel }; }
    uint32 GetFlags() const { return _flags; }

    void SetupLinkFromAura() const;
    void SetupLinkToAura() const;

private:
    void _setLinkedBy(WanderNode const*/* lwp*/);
    void _setUnLinkedBy(WanderNode const*/* lwp*/);

    uint32 _wpId;
    const uint32 _mapId;
    const uint32 _zoneId;
    const uint32 _areaId;
    /*const*/ std::string _name;
    uint8 _minLevel;
    uint8 _maxLevel;
    uint32 _flags;

    node_lltype _links;
    uint32 _to_links_count;

    Creature* _creature;
};

#endif //BOTWANDERFUL_H_
