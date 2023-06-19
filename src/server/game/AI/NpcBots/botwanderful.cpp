#include "botwanderful.h"
#include "DBCStores.h"
#include "TemporarySummon.h"

#include <iomanip>

#ifdef _MSC_VER
# pragma warning(push, 4)
#endif

uint32 WanderNode::nextWPId = 0;
WanderNode::node_ltype WanderNode::ALL_WPS = {};
WanderNode::node_mtype WanderNode::ALL_WPS_PER_MAP = {};
WanderNode::node_mtype WanderNode::ALL_WPS_PER_ZONE = {};
WanderNode::node_mtype WanderNode::ALL_WPS_PER_AREA = {};

WanderNode::mutex_type* WanderNode::GetLock()
{
    static mutex_type _lock;
    return &_lock;
}

bool WanderNode::IsWP(Creature const* creature)
{
    if (!creature)
        return false;

    lock_type lock(*GetLock());

    return std::find_if(ALL_WPS.cbegin(), ALL_WPS.cend(), [=](WanderNode const* wp) {
        return wp->GetCreature() == creature;
    }) != ALL_WPS.cend();
}

WanderNode* WanderNode::FindInAllWPs(uint32 wpId)
{
    lock_type lock(*GetLock());

    auto ci = std::find_if(ALL_WPS.cbegin(), ALL_WPS.cend(), [wpId = wpId](WanderNode const* wp) {
        return wp->GetWPId() == wpId;
    });

    return ci == ALL_WPS.cend() ? nullptr : *ci;
}

WanderNode* WanderNode::FindInAllWPs(Creature const* creature)
{
    if (!creature)
        return nullptr;

    lock_type lock(*GetLock());

    auto ci = std::find_if(ALL_WPS.cbegin(), ALL_WPS.cend(), [=](WanderNode const* wp) {
        return wp->GetCreature() == creature;
    });

    return ci == ALL_WPS.cend() ? nullptr : *ci;
}

WanderNode* WanderNode::FindInMapWPs(Creature const* creature, uint32 mapId)
{
    if (!creature)
        return nullptr;

    lock_type lock(*GetLock());

    auto cim = ALL_WPS_PER_MAP.find(mapId);
    if (cim == ALL_WPS_PER_MAP.cend())
        return nullptr;
    auto ci = std::find_if(ALL_WPS_PER_MAP.at(mapId).cbegin(), ALL_WPS_PER_MAP.at(mapId).cend(), [=](WanderNode const* wp) {
        return wp->GetCreature() == creature;
    });

    return ci == ALL_WPS_PER_MAP.at(mapId).cend() ? nullptr : *ci;
}

WanderNode* WanderNode::FindInMapWPs(uint32 wpId, uint32 mapId)
{
    lock_type lock(*GetLock());

    auto cim = ALL_WPS_PER_MAP.find(mapId);
    if (cim == ALL_WPS_PER_MAP.cend())
        return nullptr;
    auto ci = std::find_if(ALL_WPS_PER_MAP.at(mapId).cbegin(), ALL_WPS_PER_MAP.at(mapId).cend(), [wpId = wpId](WanderNode const* wp) {
        return wp->GetWPId() == wpId;
    });

    return ci == ALL_WPS_PER_MAP.at(mapId).cend() ? nullptr : *ci;
}

void WanderNode::DoForAllWPs(node_proc_ftype&& func)
{
    lock_type lock(*GetLock());

    DoForContainerWPs(ALL_WPS, std::forward<node_proc_ftype>(func));
}

void WanderNode::DoForAllZoneWPs(uint32 zoneId, node_proc_ftype_c&& func)
{
    lock_type lock(*GetLock());

    node_mtype::const_iterator ci = ALL_WPS_PER_ZONE.find(zoneId);
    if (ci != ALL_WPS_PER_ZONE.end())
        DoForContainerWPs(ci->second, std::forward<node_proc_ftype_c>(func));
}

void WanderNode::DoForAllMapWPs(uint32 mapId, node_proc_ftype_c&& func)
{
    lock_type lock(*GetLock());

    node_mtype::const_iterator ci = ALL_WPS_PER_MAP.find(mapId);
    if (ci != ALL_WPS_PER_MAP.end())
        DoForContainerWPs(ci->second, std::forward<node_proc_ftype_c>(func));
}

void WanderNode::DoForAllAreaWPs(uint32 areaId, node_proc_ftype_c&& func)
{
    lock_type lock(*GetLock());

    node_mtype::const_iterator ci = ALL_WPS_PER_AREA.find(areaId);
    if (ci != ALL_WPS_PER_AREA.end())
        DoForContainerWPs(ci->second, std::forward<node_proc_ftype_c>(func));
}

size_t WanderNode::GetAllWPsCount()
{
    lock_type lock(*GetLock());

    return ALL_WPS.size();
}

size_t WanderNode::GetMapWPsCount(uint32 mapId)
{
    lock_type lock(*GetLock());

    node_mtype::const_iterator ci = ALL_WPS_PER_MAP.find(mapId);
    return ci != ALL_WPS_PER_MAP.end() ? ci->second.size() : 0u;
}

size_t WanderNode::GetWPMapsCount()
{
    lock_type lock(*GetLock());

    return ALL_WPS_PER_MAP.size();
}

WanderNode::WanderNode(uint32 wpId, uint32 mapId, float x, float y, float z, float o, uint32 zoneId, uint32 areaId, std::string const& name)
    : Position(x, y, z, o),
    _wpId(wpId), _mapId(mapId), _zoneId(zoneId), _areaId(areaId), _name(name), _minLevel(1u), _maxLevel(DEFAULT_MAX_LEVEL), _flags(0),
    _creature(nullptr)
{
    ASSERT(!!sMapStore.LookupEntry(_mapId), "WanderNode::Ctr(): Invalid value for _mapId");
    ASSERT(!!sAreaTableStore.LookupEntry(_zoneId), "WanderNode::Ctr(): Invalid value for _zoneId");
    ASSERT(!!sAreaTableStore.LookupEntry(_areaId), "WanderNode::Ctr(): Invalid value for _areaId");

    lock_type lock(*GetLock());

    ALL_WPS.push_back(this);
    ALL_WPS_PER_MAP[_mapId].push_back(this);
    ALL_WPS_PER_ZONE[_zoneId].push_back(this);
    ALL_WPS_PER_AREA[_areaId].push_back(this);
}

WanderNode::~WanderNode()
{
    RemoveWP(this);
}

void WanderNode::RemoveWP(WanderNode* wp)
{
    while (!wp->GetLinks().empty())
        wp->UnLink(wp->GetLinks().front());

    if (wp->GetCreature() && wp->GetCreature()->IsInWorld())
        wp->GetCreature()->ToTempSummon()->DespawnOrUnsummon();

    ALL_WPS_PER_AREA.at(wp->_areaId).remove(wp);
    ALL_WPS_PER_ZONE.at(wp->_zoneId).remove(wp);
    ALL_WPS_PER_MAP.at(wp->_mapId).remove(wp);
    ALL_WPS.remove(wp);

    //WE LET THE NODE LEAK for threadsafety
    //delete wp
}

void WanderNode::RemoveAllWPs()
{
    lock_type lock(*GetLock());

    while (!ALL_WPS.empty())
        RemoveWP(ALL_WPS.front());
}

void WanderNode::SetCreature(Creature* creature)
{
    if (creature != nullptr)
        ASSERT(!_creature);

    _creature = creature;
}

Creature* WanderNode::GetCreature() const
{
    return _creature;
}

std::string WanderNode::FormatLinks() const
{
    std::ostringstream lss;
    for (WanderNode* lwp : _links)
        lss << lwp->GetWPId() << ":0 "; //TODO: chance

    return lss.str();
}

void WanderNode::SetFlags(BotWPFlags flags)
{
    _flags |= AsUnderlyingType(flags);
}

void WanderNode::RemoveFlags(BotWPFlags flags)
{
    _flags &= ~AsUnderlyingType(flags);
}

bool WanderNode::HasFlag(BotWPFlags flags) const
{
    return !!(_flags & AsUnderlyingType(flags));
}

std::string WanderNode::ToString() const
{
    std::ostringstream wps;
    wps << "WP " << _wpId << " '" << _name << "', " << uint32(_links.size()) << " link(s)" << ", Map " << _mapId
        << ", Zone " << _zoneId << " (" << std::string(sAreaTableStore.LookupEntry(_zoneId)->area_name[0])
        << "), Area " << _areaId << " (" << std::string(sAreaTableStore.LookupEntry(_areaId)->area_name[0])
        << "), minLvl " << uint32(_minLevel) << ", maxLvl " << uint32(_maxLevel)
        << " (" << static_cast<Position const*>(this)->ToString() << ')'
        << ", flags: 0x" << std::hex << std::setw(8) << std::setfill('0') << _flags << std::dec;

    return wps.str();
}

#ifdef _MSC_VER
# pragma warning(pop)
#endif
