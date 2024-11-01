#include "botdefine.h"
#include "botwanderful.h"
#include "DBCStores.h"
#include "SpellAuras.h"
#include "StringConvert.h"
#include "TemporarySummon.h"

#include <algorithm>
#include <iomanip>
#include <numeric>
#include <unordered_set>

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

WanderNode* WanderNode::FindInMapWPs(uint32 mapId, Creature const* creature)
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

WanderNode* WanderNode::FindInMapWPs(uint32 mapId, uint32 wpId)
{
    lock_type lock(*GetLock());

    auto cim = ALL_WPS_PER_MAP.find(mapId);
    if (cim == ALL_WPS_PER_MAP.cend())
        return nullptr;
    auto ci = std::find_if(ALL_WPS_PER_MAP.at(mapId).cbegin(), ALL_WPS_PER_MAP.at(mapId).cend(), [=](WanderNode const* wp) {
        return wp->GetWPId() == wpId;
    });

    return ci == ALL_WPS_PER_MAP.at(mapId).cend() ? nullptr : *ci;
}

WanderNode* WanderNode::FindInMapWPs(uint32 mapId, node_check_ftype_c const& pred)
{
    lock_type lock(*GetLock());

    auto cim = ALL_WPS_PER_MAP.find(mapId);
    if (cim == ALL_WPS_PER_MAP.cend())
        return nullptr;
    auto ci = std::find_if(ALL_WPS_PER_MAP.at(mapId).cbegin(), ALL_WPS_PER_MAP.at(mapId).cend(), pred);

    return ci == ALL_WPS_PER_MAP.at(mapId).cend() ? nullptr : *ci;
}

WanderNode* WanderNode::FindInZoneWPs(uint32 zoneId, node_check_ftype_c const& pred)
{
    lock_type lock(*GetLock());

    auto cim = ALL_WPS_PER_ZONE.find(zoneId);
    if (cim == ALL_WPS_PER_ZONE.cend())
        return nullptr;
    auto ci = std::find_if(ALL_WPS_PER_ZONE.at(zoneId).cbegin(), ALL_WPS_PER_ZONE.at(zoneId).cend(), pred);

    return ci == ALL_WPS_PER_ZONE.at(zoneId).cend() ? nullptr : *ci;
}

WanderNode* WanderNode::FindInAreaWPs(uint32 areaId, node_check_ftype_c const& pred)
{
    lock_type lock(*GetLock());

    auto cim = ALL_WPS_PER_AREA.find(areaId);
    if (cim == ALL_WPS_PER_AREA.cend())
        return nullptr;
    auto ci = std::find_if(ALL_WPS_PER_AREA.at(areaId).cbegin(), ALL_WPS_PER_AREA.at(areaId).cend(), pred);

    return ci == ALL_WPS_PER_AREA.at(areaId).cend() ? nullptr : *ci;
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
    _wpId(wpId), _mapId(mapId), _zoneId(zoneId), _areaId(areaId), _name(name), _minLevel(1u), _maxLevel(DEFAULT_MAX_LEVEL), _flags(0), _to_links_count(0),
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

WanderNode::node_lltype WanderNode::GetShortestPathLinks(WanderNode const* target, WanderNode::node_lltype const& base_links, BotWPLevel max_level_diff) const
{
    using NodeLinkList = WanderNode::node_lltype;
    using NodeLinkPList = std::vector<WanderNodeLink const*>;

    ASSERT(std::all_of(base_links.cbegin(), base_links.cend(), [this](WanderNodeLink const& wpl) { return HasLink(wpl.Id()); }));

    NodeLinkList retlist;
    if (this == target)
        retlist.push_back(WanderNodeLink{ .wp = const_cast<WanderNode*>(this), .weight = 10000 });
    else
    {
        std::list<std::pair<uint32 /*level*/, WanderNodeLink const*>> validLinks;
        for (WanderNodeLink const& link : base_links)
        {
            if (link.wp == target)
            {
                retlist.push_back(link);
                validLinks.clear();
                break;
            }

            if (link.wp->GetLinks().size() == 1 && link.wp->GetLinks().front().wp == this)
                continue;

            std::unordered_set<uint32> checked_links;
            checked_links.insert(GetWPId());
            NodeLinkPList vlinks_cur;
            NodeLinkList clinks;
            clinks.push_back(link);
            for (uint32 level = 0; !clinks.empty(); ++level)
            {
                for (WanderNodeLink const& wpl : clinks)
                {
                    if (wpl.wp->HasLink(target))
                        vlinks_cur.push_back(&link);
                }
                if (!vlinks_cur.empty())
                {
                    validLinks.emplace_back(level, &link);
                    break;
                }
                decltype(clinks) clinks_new;
                for (WanderNodeLink const& wpl : clinks)
                {
                    checked_links.insert(wpl.Id()); // cut off all ways back (2-ways, circular)
                    std::copy_if(wpl.wp->GetLinks().cbegin(), wpl.wp->GetLinks().cend(), std::back_inserter(clinks_new), [&checked_links](WanderNodeLink const& wpl) {
                        return !checked_links.contains(wpl.Id());
                    });
                }
                clinks = std::move(clinks_new);
            }
        }

        if (!validLinks.empty())
        {
            //only choose one of the shortest routes
            if (validLinks.size() > 1)
            {
                auto minlevel = std::numeric_limits<decltype(validLinks)::value_type::first_type>::max();
                for (auto const& vlp : validLinks)
                    minlevel = std::min<decltype(minlevel)>(minlevel, vlp.first);
                decltype(minlevel) inclevel = minlevel + AsUnderlyingType(max_level_diff);
                validLinks.remove_if([=, this](decltype(validLinks)::value_type const& p) {
                    return p.first > inclevel || (p.first > minlevel && p.second->wp->GetExactDist2d(target) > GetExactDist2d(target));
                });
            }
            for (decltype(validLinks)::value_type const& vt : validLinks)
                retlist.push_back(*vt.second);
        }
    }

    return retlist;
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

uint32 WanderNode::GetAverageLinkWeight(bool exclude_0/* = false*/) const
{
    if (GetLinks().empty())
        return 0;

    if (exclude_0)
    {
        uint32 zeros_count = 0;
        uint32 sum = 0;
        for (WanderNodeLink const& wpl : GetLinks())
        {
            sum += wpl.weight;
            if (wpl.weight == 0)
                ++zeros_count;
        }
        return sum / std::max<uint32>(1u, GetLinks().size() - zeros_count);
    }

    return static_cast<uint32>(std::accumulate(GetLinks().cbegin(), GetLinks().cend(), 0u, [](size_t total, WanderNodeLink const& wpl) { return total + wpl.weight; }) / GetLinks().size());
}

std::string WanderNode::FormatLinks() const
{
    std::ostringstream lss;
    for (WanderNodeLink const& wpl: _links)
        lss << uint32(wpl.Id()) << ':' << uint32(wpl.weight) << ' ';

    return lss.str();
}

void WanderNode::SetLinkWeight(uint32 wp_id, uint32 new_weight)
{
    auto lit = GetLink(wp_id);
    ASSERT(lit != GetLinks().cend());
    lit->weight = new_weight;
}

void WanderNode::SetFlags(BotWPFlags flags)
{
    _flags |= AsUnderlyingType(flags);
    if (Creature* wpc = GetCreature())
    {
        wpc->SetMaxPower(POWER_MANA, GetFlags());
        wpc->SetPower(POWER_MANA, GetFlags());
    }
}

void WanderNode::RemoveFlags(BotWPFlags flags)
{
    _flags &= ~AsUnderlyingType(flags);
    if (Creature* wpc = GetCreature())
    {
        wpc->SetMaxPower(POWER_MANA, GetFlags());
        wpc->SetPower(POWER_MANA, GetFlags());
    }
}

bool WanderNode::HasFlag(BotWPFlags flags) const
{
    return !!(_flags & AsUnderlyingType(flags));
}

bool WanderNode::HasAllFlags(BotWPFlags flags) const
{
    return (_flags & AsUnderlyingType(flags)) == AsUnderlyingType(flags);
}

std::string WanderNode::ToString(int32 link_weight/* = -1*/) const
{
    std::ostringstream wps;
    wps << "WP " << _wpId << (link_weight >= 0 ? (":" + Bcore::ToString(link_weight)) : std::string{})
        << " '" << _name << "', " << uint32(_links.size()) << " link(s) (avg weight " << GetAverageLinkWeight()
        << "), Map " << _mapId << ", Zone " << _zoneId << ", Area " << _areaId << ", minLvl " << uint32(_minLevel) << ", maxLvl " << uint32(_maxLevel)
        << " (" << std::setiosflags(std::ios_base::fixed) << std::setprecision(2) << "X: " << m_positionX << " Y: " << m_positionY << " Z: " << m_positionZ
        << "), flags: 0x" << std::hex << std::setw(8) << std::setfill('0') << _flags << std::dec;
    return wps.str();
}

void WanderNode::Link(WanderNodeLink&& wpl)
{
    if (!HasLink(wpl))
    {
        _links.push_back(std::move(wpl));
        wpl.wp->_setLinkedBy(this);
        SetupLinkFromAura();
    }
}
void WanderNode::UnLink(uint32 wp_id)
{
    auto lit = GetLink(wp_id);
    if (lit != _links.cend())
    {
        WanderNode* lwp = lit->wp;
        _links.erase(lit);
        lwp->_setUnLinkedBy(this);
        SetupLinkFromAura();
    }
}
void WanderNode::_setLinkedBy(WanderNode const*/* lwp*/)
{
    ++_to_links_count;
    SetupLinkToAura();
}
void WanderNode::_setUnLinkedBy(WanderNode const*/* lwp*/)
{
    --_to_links_count;
    SetupLinkToAura();
}
void WanderNode::SetupLinkFromAura() const
{
    if (Creature* wpc = GetCreature())
    {
        Aura* linkfrom = wpc->GetAura(WP_SPELL_ID_LINK_FROM);
        if (GetLinks().empty())
        {
            if (linkfrom)
                linkfrom->Remove();
            return;
        }
        if (!linkfrom)
            linkfrom = wpc->AddAura(WP_SPELL_ID_LINK_FROM, wpc);
        linkfrom->SetStackAmount((uint8)GetLinks().size());
    }
}
void WanderNode::SetupLinkToAura() const
{
    if (Creature* wpc = GetCreature())
    {
        Aura* linkto = wpc->GetAura(WP_SPELL_ID_LINK_TO);
        if (_to_links_count == 0)
        {
            if (linkto)
                linkto->Remove();
            return;
        }
        if (!linkto)
            linkto = wpc->AddAura(WP_SPELL_ID_LINK_TO, wpc);
        linkto->SetStackAmount((uint8)_to_links_count);
    }
}

#ifdef _MSC_VER
# pragma warning(pop)
#endif
