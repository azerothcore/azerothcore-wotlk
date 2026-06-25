#include "Protocol.h"

#include <charconv>

namespace Branding::Addon
{
    namespace
    {
        // Split `s` by `delim`, preserving empty tokens (including trailing ones) so a fixed-arity
        // frame always yields a fixed token count regardless of empty fields.
        std::vector<std::string_view> Split(std::string_view s, char delim)
        {
            std::vector<std::string_view> out;
            std::size_t start = 0;
            while (true)
            {
                std::size_t const pos = s.find(delim, start);
                if (pos == std::string_view::npos)
                {
                    out.push_back(s.substr(start));
                    break;
                }
                out.push_back(s.substr(start, pos - start));
                start = pos + 1;
            }
            return out;
        }

        // Parse an entire token as a base-10 unsigned integer. Rejects empty input, leading/trailing
        // junk, and signs. Never throws.
        bool ParseU32(std::string_view s, uint32_t& out)
        {
            if (s.empty())
                return false;

            uint32_t value = 0;
            auto const* const begin = s.data();
            auto const* const end = s.data() + s.size();
            auto const [ptr, ec] = std::from_chars(begin, end, value);
            if (ec != std::errc() || ptr != end)
                return false;

            out = value;
            return true;
        }

        bool ParseU8(std::string_view s, uint8_t& out)
        {
            uint32_t value = 0;
            if (!ParseU32(s, value) || value > 0xFF)
                return false;
            out = static_cast<uint8_t>(value);
            return true;
        }

        bool ParseU16(std::string_view s, uint16_t& out)
        {
            uint32_t value = 0;
            if (!ParseU32(s, value) || value > 0xFFFF)
                return false;
            out = static_cast<uint16_t>(value);
            return true;
        }

        bool ParseBool(std::string_view s, bool& out)
        {
            if (s == "0") { out = false; return true; }
            if (s == "1") { out = true; return true; }
            return false;
        }

        std::string FramePrefix(char const* kind)
        {
            std::string out = Prefix;
            out += Sep;
            out += kind;
            return out;
        }

        // A "TAG=payload" character-snapshot field: returns the payload, or false on a tag mismatch.
        bool Section(std::string_view field, std::string_view tag, std::string_view& outPayload)
        {
            if (field.size() < tag.size() + 1 || field.substr(0, tag.size()) != tag || field[tag.size()] != '=')
                return false;
            outPayload = field.substr(tag.size() + 1);
            return true;
        }
    }

    // ---- Equality ----

    bool operator==(HelloFrame const& a, HelloFrame const& b)
    {
        return a.version == b.version && a.enabled == b.enabled;
    }

    bool operator==(EventFrame const& a, EventFrame const& b)
    {
        return a.zoneId == b.zoneId && a.type == b.type
            && a.containmentPermille == b.containmentPermille && a.active == b.active;
    }

    bool operator==(ScheduleEntry const& a, ScheduleEntry const& b)
    {
        return a.zoneId == b.zoneId && a.type == b.type
            && a.state == b.state && a.secondsRemaining == b.secondsRemaining;
    }

    bool operator==(YouFrame const& a, YouFrame const& b)
    {
        return a.points == b.points && a.tier == b.tier;
    }

    bool operator==(BrandFrame const& a, BrandFrame const& b)
    {
        return a.brand == b.brand && a.level == b.level && a.strengthPermille == b.strengthPermille;
    }

    bool operator==(MasteryFrame const& a, MasteryFrame const& b)
    {
        return a.system == b.system && a.unlocked == b.unlocked
            && a.level == b.level && a.bonusPermille == b.bonusPermille;
    }

    bool operator==(LoadoutFrame const& a, LoadoutFrame const& b)
    {
        return a.activeBrand == b.activeBrand && a.archetype == b.archetype;
    }

    bool operator==(ItemFrame const& a, ItemFrame const& b)
    {
        return a.equipped == b.equipped && a.brand == b.brand && a.step == b.step
            && a.level == b.level && a.intensityPermille == b.intensityPermille;
    }

    bool operator==(AllegianceFrame const& a, AllegianceFrame const& b)
    {
        return a.id == b.id && a.efficiencyPermille == b.efficiencyPermille;
    }

    bool operator==(XpFrame const& a, XpFrame const& b)
    {
        return a.brand == b.brand && a.level == b.level && a.maxLevel == b.maxLevel
            && a.xpIntoLevel == b.xpIntoLevel && a.xpForLevel == b.xpForLevel && a.prestige == b.prestige;
    }

    bool operator==(CharSnapshot const& a, CharSnapshot const& b)
    {
        return a.brands == b.brands && a.masteries == b.masteries && a.loadout == b.loadout
            && a.item == b.item && a.allegiance == b.allegiance;
    }

    bool operator==(MasteryCellFrame const& a, MasteryCellFrame const& b)
    {
        for (uint8_t i = 0; i < AxisCount; ++i)
            if (a.alloc[i] != b.alloc[i])
                return false;
        return a.school == b.school && a.tree == b.tree && a.kind == b.kind
            && a.situational == b.situational && a.sustained == b.sustained && a.level == b.level
            && a.archetype == b.archetype && a.axisMask == b.axisMask && a.active == b.active;
    }

    bool operator==(MasterySnapshot const& a, MasterySnapshot const& b)
    {
        return a.pointsAvailable == b.pointsAvailable && a.respecCost == b.respecCost && a.cells == b.cells;
    }

    bool operator==(AllocRequest const& a, AllocRequest const& b)
    {
        return a.school == b.school && a.tree == b.tree && a.axis == b.axis && a.points == b.points;
    }

    bool operator==(ArchetypeRequest const& a, ArchetypeRequest const& b)
    {
        return a.school == b.school && a.tree == b.tree && a.archetype == b.archetype;
    }

    bool operator==(RespecRequest const& a, RespecRequest const& b)
    {
        return a.school == b.school && a.tree == b.tree;
    }

    // ---- Request parsing ----

    AddonRequest ParseRequest(std::string_view body, uint8_t& outVersion)
    {
        std::vector<std::string_view> const tok = Split(body, Sep);
        if (tok.empty() || tok[0].empty())
            return AddonRequest::Unknown;

        if (tok[0] == "HELLO")
        {
            if (tok.size() < 2 || !ParseU8(tok[1], outVersion))
                return AddonRequest::Unknown;
            return AddonRequest::Hello;
        }

        if (tok[0] == "REQ" && tok.size() >= 2)
        {
            if (tok[1] == "CHAR")   return AddonRequest::Char;
            if (tok[1] == "SCH")    return AddonRequest::Schedule;
            if (tok[1] == "STATUS") return AddonRequest::Status;
            if (tok[1] == "MAST")   return AddonRequest::Mastery;
        }

        if (tok[0] == "ALLOC")  return AddonRequest::Allocate;
        if (tok[0] == "ARCH")   return AddonRequest::Archetype;
        if (tok[0] == "RESPEC") return AddonRequest::Respec;

        return AddonRequest::Unknown;
    }

    bool ParseAlloc(std::string_view body, AllocRequest& out)
    {
        std::vector<std::string_view> const t = Split(body, Sep);
        if (t.size() != 5 || t[0] != "ALLOC")
            return false;
        AllocRequest r;
        if (!ParseU8(t[1], r.school) || !ParseU8(t[2], r.tree)
            || !ParseU8(t[3], r.axis) || !ParseU8(t[4], r.points))
            return false;
        out = r;
        return true;
    }

    bool ParseArchetype(std::string_view body, ArchetypeRequest& out)
    {
        std::vector<std::string_view> const t = Split(body, Sep);
        if (t.size() != 4 || t[0] != "ARCH")
            return false;
        ArchetypeRequest r;
        if (!ParseU8(t[1], r.school) || !ParseU8(t[2], r.tree) || !ParseU8(t[3], r.archetype))
            return false;
        out = r;
        return true;
    }

    bool ParseRespec(std::string_view body, RespecRequest& out)
    {
        std::vector<std::string_view> const t = Split(body, Sep);
        if (t.size() != 3 || t[0] != "RESPEC")
            return false;
        RespecRequest r;
        if (!ParseU8(t[1], r.school) || !ParseU8(t[2], r.tree))
            return false;
        out = r;
        return true;
    }

    bool StripPrefix(std::string_view raw, std::string_view& outBody)
    {
        std::string const head = FramePrefix("");   // "BRND\t"
        if (raw.size() < head.size() || raw.substr(0, head.size()) != head)
            return false;
        outBody = raw.substr(head.size());
        return true;
    }

    // ---- Encoders ----

    std::string EncodeHello(HelloFrame const& f)
    {
        std::string out = FramePrefix("HELLO");
        out += Sep; out += std::to_string(f.version);
        out += Sep; out += (f.enabled ? '1' : '0');
        return out;
    }

    std::string EncodeEvent(EventFrame const& f)
    {
        std::string out = FramePrefix("EVT");
        out += Sep; out += std::to_string(f.zoneId);
        out += Sep; out += std::to_string(f.type);
        out += Sep; out += std::to_string(f.containmentPermille);
        out += Sep; out += (f.active ? '1' : '0');
        return out;
    }

    std::string EncodeYou(YouFrame const& f)
    {
        std::string out = FramePrefix("YOU");
        out += Sep; out += std::to_string(f.points);
        out += Sep; out += std::to_string(f.tier);
        return out;
    }

    std::string EncodeXp(XpFrame const& f)
    {
        std::string out = FramePrefix("XPB");
        out += Sep; out += std::to_string(f.brand);
        out += Sep; out += std::to_string(f.level);
        out += Sep; out += std::to_string(f.maxLevel);
        out += Sep; out += std::to_string(f.xpIntoLevel);
        out += Sep; out += std::to_string(f.xpForLevel);
        out += Sep; out += (f.prestige ? '1' : '0');
        return out;
    }

    std::string EncodeSchedule(std::vector<ScheduleEntry> const& entries, bool& outTruncated)
    {
        outTruncated = false;
        std::string const base = FramePrefix("SCH");
        std::string records;

        for (ScheduleEntry const& e : entries)
        {
            std::string rec;
            if (!records.empty())
                rec += RecSep;
            rec += std::to_string(e.zoneId);     rec += FieldSep;
            rec += std::to_string(e.type);       rec += FieldSep;
            rec += std::to_string(e.state);      rec += FieldSep;
            rec += std::to_string(e.secondsRemaining);

            // Reserve room for the "\t<records>\t<marker>" tail incl. a possible truncation flag.
            std::size_t const projected = base.size() + 1 + records.size() + rec.size() + 2;
            if (projected > MaxFrame)
            {
                outTruncated = true;
                break;
            }
            records += rec;
        }

        std::string out = base;
        out += Sep; out += records;
        out += Sep; out += (outTruncated ? "T" : "");
        return out;
    }

    std::string EncodeChar(CharSnapshot const& s)
    {
        std::string out = FramePrefix("CHAR");

        out += Sep; out += "BRD=";
        for (std::size_t i = 0; i < s.brands.size(); ++i)
        {
            if (i) out += RecSep;
            BrandFrame const& b = s.brands[i];
            out += std::to_string(b.brand);            out += FieldSep;
            out += std::to_string(b.level);            out += FieldSep;
            out += std::to_string(b.strengthPermille);
        }

        out += Sep; out += "MST=";
        for (std::size_t i = 0; i < s.masteries.size(); ++i)
        {
            if (i) out += RecSep;
            MasteryFrame const& m = s.masteries[i];
            out += std::to_string(m.system);           out += FieldSep;
            out += (m.unlocked ? '1' : '0');           out += FieldSep;
            out += std::to_string(m.level);            out += FieldSep;
            out += std::to_string(m.bonusPermille);
        }

        out += Sep; out += "LDT=";
        out += std::to_string(s.loadout.activeBrand);  out += FieldSep;
        out += std::to_string(s.loadout.archetype);

        out += Sep; out += "ITM=";
        out += (s.item.equipped ? '1' : '0');          out += FieldSep;
        out += std::to_string(s.item.brand);           out += FieldSep;
        out += std::to_string(s.item.step);            out += FieldSep;
        out += std::to_string(s.item.level);           out += FieldSep;
        out += std::to_string(s.item.intensityPermille);

        out += Sep; out += "ALG=";
        out += std::to_string(s.allegiance.id);        out += FieldSep;
        out += std::to_string(s.allegiance.efficiencyPermille);

        return out;
    }

    std::string EncodeMastery(MasterySnapshot const& s, bool& outTruncated)
    {
        outTruncated = false;
        std::string const base = FramePrefix("MAST");
        std::string head = base;
        head += Sep; head += std::to_string(s.pointsAvailable);
        head += Sep; head += std::to_string(s.respecCost);

        std::string records;
        for (MasteryCellFrame const& c : s.cells)
        {
            std::string rec;
            if (!records.empty())
                rec += RecSep;
            rec += std::to_string(c.school);          rec += FieldSep;
            rec += std::to_string(c.tree);            rec += FieldSep;
            rec += std::to_string(c.kind);            rec += FieldSep;
            rec += (c.situational ? '1' : '0');       rec += FieldSep;
            rec += (c.sustained ? '1' : '0');         rec += FieldSep;
            rec += std::to_string(c.level);           rec += FieldSep;
            rec += std::to_string(c.archetype);       rec += FieldSep;
            rec += std::to_string(c.axisMask);
            for (uint8_t i = 0; i < AxisCount; ++i)
            {
                rec += FieldSep;
                rec += std::to_string(c.alloc[i]);
            }
            rec += FieldSep; rec += (c.active ? '1' : '0');

            // Reserve room for the "\t<records>\t<marker>" tail incl. a possible truncation flag.
            std::size_t const projected = head.size() + 1 + records.size() + rec.size() + 2;
            if (projected > MaxFrame)
            {
                outTruncated = true;
                break;
            }
            records += rec;
        }

        std::string out = head;
        out += Sep; out += records;
        out += Sep; out += (outTruncated ? "T" : "");
        return out;
    }

    std::string EncodeAlloc(AllocRequest const& r)
    {
        std::string out = FramePrefix("ALLOC");
        out += Sep; out += std::to_string(r.school);
        out += Sep; out += std::to_string(r.tree);
        out += Sep; out += std::to_string(r.axis);
        out += Sep; out += std::to_string(r.points);
        return out;
    }

    std::string EncodeArchetype(ArchetypeRequest const& r)
    {
        std::string out = FramePrefix("ARCH");
        out += Sep; out += std::to_string(r.school);
        out += Sep; out += std::to_string(r.tree);
        out += Sep; out += std::to_string(r.archetype);
        return out;
    }

    std::string EncodeRespec(RespecRequest const& r)
    {
        std::string out = FramePrefix("RESPEC");
        out += Sep; out += std::to_string(r.school);
        out += Sep; out += std::to_string(r.tree);
        return out;
    }

    // ---- Decoders ----

    bool DecodeHello(std::string_view frame, HelloFrame& out)
    {
        std::vector<std::string_view> const t = Split(frame, Sep);
        if (t.size() != 4 || t[0] != Prefix || t[1] != "HELLO")
            return false;
        return ParseU8(t[2], out.version) && ParseBool(t[3], out.enabled);
    }

    bool DecodeEvent(std::string_view frame, EventFrame& out)
    {
        std::vector<std::string_view> const t = Split(frame, Sep);
        if (t.size() != 6 || t[0] != Prefix || t[1] != "EVT")
            return false;
        return ParseU32(t[2], out.zoneId) && ParseU8(t[3], out.type)
            && ParseU16(t[4], out.containmentPermille) && ParseBool(t[5], out.active);
    }

    bool DecodeYou(std::string_view frame, YouFrame& out)
    {
        std::vector<std::string_view> const t = Split(frame, Sep);
        if (t.size() != 4 || t[0] != Prefix || t[1] != "YOU")
            return false;
        return ParseU32(t[2], out.points) && ParseU8(t[3], out.tier);
    }

    bool DecodeXp(std::string_view frame, XpFrame& out)
    {
        std::vector<std::string_view> const t = Split(frame, Sep);
        if (t.size() != 8 || t[0] != Prefix || t[1] != "XPB")
            return false;
        return ParseU8(t[2], out.brand) && ParseU8(t[3], out.level) && ParseU8(t[4], out.maxLevel)
            && ParseU32(t[5], out.xpIntoLevel) && ParseU32(t[6], out.xpForLevel) && ParseBool(t[7], out.prestige);
    }

    bool DecodeSchedule(std::string_view frame, std::vector<ScheduleEntry>& out, bool& outTruncated)
    {
        out.clear();
        std::vector<std::string_view> const t = Split(frame, Sep);
        if (t.size() != 4 || t[0] != Prefix || t[1] != "SCH")
            return false;

        outTruncated = (t[3] == "T");

        if (!t[2].empty())
        {
            for (std::string_view const rec : Split(t[2], RecSep))
            {
                std::vector<std::string_view> const f = Split(rec, FieldSep);
                if (f.size() != 4)
                    return false;
                ScheduleEntry e;
                if (!ParseU32(f[0], e.zoneId) || !ParseU8(f[1], e.type)
                    || !ParseU8(f[2], e.state) || !ParseU32(f[3], e.secondsRemaining))
                    return false;
                out.push_back(e);
            }
        }
        return true;
    }

    bool DecodeChar(std::string_view frame, CharSnapshot& out)
    {
        out = CharSnapshot{};
        std::vector<std::string_view> const t = Split(frame, Sep);
        if (t.size() != 7 || t[0] != Prefix || t[1] != "CHAR")
            return false;

        std::string_view brd, mst, ldt, itm, alg;
        if (!Section(t[2], "BRD", brd) || !Section(t[3], "MST", mst) || !Section(t[4], "LDT", ldt)
            || !Section(t[5], "ITM", itm) || !Section(t[6], "ALG", alg))
            return false;

        if (!brd.empty())
        {
            for (std::string_view const rec : Split(brd, RecSep))
            {
                std::vector<std::string_view> const f = Split(rec, FieldSep);
                if (f.size() != 3)
                    return false;
                BrandFrame b;
                if (!ParseU8(f[0], b.brand) || !ParseU8(f[1], b.level) || !ParseU16(f[2], b.strengthPermille))
                    return false;
                out.brands.push_back(b);
            }
        }

        if (!mst.empty())
        {
            for (std::string_view const rec : Split(mst, RecSep))
            {
                std::vector<std::string_view> const f = Split(rec, FieldSep);
                if (f.size() != 4)
                    return false;
                MasteryFrame m;
                if (!ParseU8(f[0], m.system) || !ParseBool(f[1], m.unlocked)
                    || !ParseU8(f[2], m.level) || !ParseU16(f[3], m.bonusPermille))
                    return false;
                out.masteries.push_back(m);
            }
        }

        {
            std::vector<std::string_view> const f = Split(ldt, FieldSep);
            if (f.size() != 2 || !ParseU8(f[0], out.loadout.activeBrand) || !ParseU8(f[1], out.loadout.archetype))
                return false;
        }

        {
            std::vector<std::string_view> const f = Split(itm, FieldSep);
            if (f.size() != 5 || !ParseBool(f[0], out.item.equipped) || !ParseU8(f[1], out.item.brand)
                || !ParseU8(f[2], out.item.step) || !ParseU8(f[3], out.item.level)
                || !ParseU16(f[4], out.item.intensityPermille))
                return false;
        }

        {
            std::vector<std::string_view> const f = Split(alg, FieldSep);
            if (f.size() != 2 || !ParseU8(f[0], out.allegiance.id) || !ParseU16(f[1], out.allegiance.efficiencyPermille))
                return false;
        }

        return true;
    }

    bool DecodeMastery(std::string_view frame, MasterySnapshot& out, bool& outTruncated)
    {
        out = MasterySnapshot{};
        std::vector<std::string_view> const t = Split(frame, Sep);
        if (t.size() != 6 || t[0] != Prefix || t[1] != "MAST")
            return false;

        if (!ParseU16(t[2], out.pointsAvailable) || !ParseU16(t[3], out.respecCost))
            return false;

        outTruncated = (t[5] == "T");

        if (!t[4].empty())
        {
            for (std::string_view const rec : Split(t[4], RecSep))
            {
                std::vector<std::string_view> const f = Split(rec, FieldSep);
                // 8 scalar fields + AxisCount alloc fields + 1 active flag.
                if (f.size() != static_cast<std::size_t>(9 + AxisCount))
                    return false;
                MasteryCellFrame c;
                if (!ParseU8(f[0], c.school) || !ParseU8(f[1], c.tree) || !ParseU8(f[2], c.kind)
                    || !ParseBool(f[3], c.situational) || !ParseBool(f[4], c.sustained)
                    || !ParseU8(f[5], c.level) || !ParseU8(f[6], c.archetype) || !ParseU8(f[7], c.axisMask))
                    return false;
                bool allocOk = true;
                for (uint8_t i = 0; i < AxisCount; ++i)
                    allocOk = allocOk && ParseU8(f[8 + i], c.alloc[i]);
                if (!allocOk || !ParseBool(f[8 + AxisCount], c.active))
                    return false;
                out.cells.push_back(c);
            }
        }
        return true;
    }
}
