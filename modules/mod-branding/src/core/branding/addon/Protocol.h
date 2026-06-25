#ifndef MOD_BRANDING_SRC_CORE_ADDON_PROTOCOL_H
#define MOD_BRANDING_SRC_CORE_ADDON_PROTOCOL_H

#include <cstdint>
#include <string>
#include <string_view>
#include <vector>

// Pure wire codec for the client addon transport (§19.2). No AzerothCore includes: the adapter
// (`src/AddonProtocolMgr`) fills these POD snapshots from live Mgrs and performs the send/receive;
// this file only turns snapshots into `BRND\t...` frames and parses request lines. Floats cross the
// wire as permille integers (x1000) so the round-trip is exact. The Lua addon mirrors this grammar.
namespace Branding::Addon
{
    // Single prefix for all traffic both directions; tab-delimited fields, ';' between list records,
    // ':' between a record's sub-fields. CHAT_MSG_ADDON bodies are capped at 255 bytes server-side.
    inline constexpr char const* Prefix = "BRND";
    inline constexpr char Sep = '\t';
    inline constexpr char RecSep = ';';
    inline constexpr char FieldSep = ':';
    inline constexpr std::size_t MaxFrame = 255;
    // v2 adds the §14 Mastery lattice frame (MAST) + the client->server mastery request grammar
    // (REQ MAST / ALLOC / ARCH / RESPEC). A v1 client simply ignores MAST and never sends the new
    // requests, so the bump is backward-tolerant; HELLO still tells a mismatched client to update.
    // v3 appends the §14.11 selected role to the LDT loadout field (decode stays tolerant of the older
    // 2-field form -> role None), so a v2 client that reads only the first two LDT fields still works.
    inline constexpr uint8_t ProtocolVersion = 3;

    // What the client asked for (after the BRND prefix is stripped). The mastery verbs (Mastery,
    // Allocate, Archetype, Respec) are the §14 client->server channel reserved by §19.3 -- parsed
    // and tested here; live adapter wiring of a client->server path is future work (see §19.3).
    enum class AddonRequest : uint8_t { Hello, Char, Schedule, Status, Mastery, Allocate, Archetype, Respec, Unknown };

    // ---- Snapshot POD inputs (adapter fills from Mgrs; no AC types) ----

    struct HelloFrame { uint8_t version = ProtocolVersion; bool enabled = false; };
    struct EventFrame { uint32_t zoneId = 0; uint8_t type = 0; uint16_t containmentPermille = 0; bool active = false; };
    struct ScheduleEntry { uint32_t zoneId = 0; uint8_t type = 0; uint8_t state = 0; uint32_t secondsRemaining = 0; };
    struct YouFrame { uint32_t points = 0; uint8_t tier = 0; };
    struct BrandFrame { uint8_t brand = 0; uint8_t level = 0; uint16_t strengthPermille = 0; };
    struct MasteryFrame { uint8_t system = 0; bool unlocked = false; uint8_t level = 0; uint16_t bonusPermille = 0; };
    struct LoadoutFrame { uint8_t activeBrand = 0; uint8_t archetype = 0; uint8_t role = 0; };
    struct ItemFrame { bool equipped = false; uint8_t brand = 0; uint8_t step = 0; uint8_t level = 0; uint16_t intensityPermille = 0; };
    struct AllegianceFrame { uint8_t id = 0; uint16_t efficiencyPermille = 0; };

    // §14.13 / issue #54: the active brand's proficiency progression, for an XP-bar overlay. One
    // progression at a time, so this is a single fixed-arity frame (no list/truncation). `brand`
    // is the active BrandId (lets the bar tint by school -- cosmetic); `level`/`maxLevel` are the
    // §7.4 earned/cap levels; `xpIntoLevel`/`xpForLevel` locate progress within the level (bar fill
    // = into/for, a single level's span fits uint32); `prestige` ⇒ at max level (graduated, full).
    struct XpFrame
    {
        uint8_t  brand = 0;
        uint8_t  level = 0;
        uint8_t  maxLevel = 0;
        uint32_t xpIntoLevel = 0;
        uint32_t xpForLevel = 0;   // 0 at max level
        bool     prestige = false;
    };

    // Composite character-panel snapshot (one frame).
    struct CharSnapshot
    {
        std::vector<BrandFrame> brands;
        std::vector<MasteryFrame> masteries;
        LoadoutFrame loadout;
        ItemFrame item;
        AllegianceFrame allegiance;
    };

    // ---- §14 Mastery lattice (MAST frame) ----

    // The four §14.10 point-buy axes, on the wire in fixed order. Mirrors core ProcAxis
    // (Ppm, Duration, Magnitude, Reach) so the addon and core agree on index meaning.
    inline constexpr uint8_t AxisCount = 4;

    // One (school, tree) lattice cell as the client renders it (§14.4/§14.10). `axisMask` is the
    // applicable-axis bitmask (bit i set => axis i is tunable for this cell); `alloc[i]` is the
    // player's current point spend on axis i (0 for non-applicable axes). `kind` is the §7.9
    // EffectKind ordinal; `situational`/`sustained` carry the SM/SE + Support-aura flags so the UI
    // can label the cell. `level` is the EARNED mastery level for this school (§14.11 "earned"
    // layer, shared across specs). `archetype` is the selected proc archetype (§7.9 loadout).
    struct MasteryCellFrame
    {
        uint8_t  school = 0;        // BrandId ordinal (0..6)
        uint8_t  tree = 0;          // MasteryTree ordinal (0=Def,1=Off,2=Support)
        uint8_t  kind = 0;          // EffectKind ordinal
        bool     situational = false;
        bool     sustained = false;
        uint8_t  level = 0;         // earned mastery level for this school
        uint8_t  archetype = 0;     // selected proc archetype
        uint8_t  axisMask = 0;      // applicable §14.10 axes (bit per axis)
        uint8_t  alloc[AxisCount] = { 0, 0, 0, 0 };  // points spent per axis
        bool     active = false;    // is this cell one of the character's ACTIVE masteries?
        uint8_t  reachMode = 0;     // §14.4.2 ReachMode ordinal (0=None, 1=RadiusYards, 2=TargetCount):
                                    // lets the tooltip label the reach axis "N yd" vs "hits N targets"
    };

    // §14 mastery snapshot. `pointsAvailable` is the unspent point-buy budget the player may
    // allocate; `respecCost` is the §14.5/§7.9 friction token cost for a respec. `cells` is the
    // full lattice (server sends every authored cell; `active` flags the ones currently running).
    //
    // MULTI-MASTERY forward-compat: the active set is intentionally a property of the cell list
    // (each cell's `active` flag), NOT a single "active mastery" field -- a character will later run
    // MULTIPLE masteries at once and the wire/UI model must already represent that as a list.
    struct MasterySnapshot
    {
        uint16_t pointsAvailable = 0;
        uint16_t respecCost = 0;
        std::vector<MasteryCellFrame> cells;
    };

    // ---- Parsed client->server request payloads (§19.3 reserved grammar) ----

    // ALLOC: spend/restribute points on one cell's axis. school/tree identify the cell; axis is the
    // §14.10 ProcAxis ordinal; points is the desired new spend on that axis.
    struct AllocRequest { uint8_t school = 0; uint8_t tree = 0; uint8_t axis = 0; uint8_t points = 0; };
    // ARCH: select a proc archetype for a cell.
    struct ArchetypeRequest { uint8_t school = 0; uint8_t tree = 0; uint8_t archetype = 0; };
    // RESPEC: refund a cell's allocation (charges the §14.5 token, adapter-side).
    struct RespecRequest { uint8_t school = 0; uint8_t tree = 0; };

    // ---- Equality (for round-trip tests) ----
    bool operator==(HelloFrame const&, HelloFrame const&);
    bool operator==(EventFrame const&, EventFrame const&);
    bool operator==(ScheduleEntry const&, ScheduleEntry const&);
    bool operator==(YouFrame const&, YouFrame const&);
    bool operator==(BrandFrame const&, BrandFrame const&);
    bool operator==(MasteryFrame const&, MasteryFrame const&);
    bool operator==(LoadoutFrame const&, LoadoutFrame const&);
    bool operator==(ItemFrame const&, ItemFrame const&);
    bool operator==(AllegianceFrame const&, AllegianceFrame const&);
    bool operator==(XpFrame const&, XpFrame const&);
    bool operator==(CharSnapshot const&, CharSnapshot const&);
    bool operator==(MasteryCellFrame const&, MasteryCellFrame const&);
    bool operator==(MasterySnapshot const&, MasterySnapshot const&);
    bool operator==(AllocRequest const&, AllocRequest const&);
    bool operator==(ArchetypeRequest const&, ArchetypeRequest const&);
    bool operator==(RespecRequest const&, RespecRequest const&);

    // ---- Request parsing (client -> server) ----
    // `body` is the message with the leading "BRND\t" already removed. Never throws; an unknown or
    // malformed verb yields Unknown. For Hello, `outVersion` is set to the client's protocol version.
    AddonRequest ParseRequest(std::string_view body, uint8_t& outVersion);

    // §14 client->server payload parsers. Each returns false (leaving `out` untouched) on a wrong
    // verb or malformed body; never throws. Grammar mirrors the encoders below.
    //   BRND\tALLOC\t<school>\t<tree>\t<axis>\t<points>
    //   BRND\tARCH\t<school>\t<tree>\t<archetype>
    //   BRND\tRESPEC\t<school>\t<tree>
    bool ParseAlloc(std::string_view body, AllocRequest& out);
    bool ParseArchetype(std::string_view body, ArchetypeRequest& out);
    bool ParseRespec(std::string_view body, RespecRequest& out);

    // Strips the "BRND\t" prefix from a raw incoming addon body. Returns false (and leaves outBody
    // untouched) if `raw` is not one of our frames.
    bool StripPrefix(std::string_view raw, std::string_view& outBody);

    // ---- Encoders (server -> client): each returns a full "BRND\t<KIND>\t..." frame ----
    std::string EncodeHello(HelloFrame const&);
    std::string EncodeEvent(EventFrame const&);
    // Packs as many entries as fit MaxFrame; sets `outTruncated` if any were dropped (never silent).
    std::string EncodeSchedule(std::vector<ScheduleEntry> const&, bool& outTruncated);
    std::string EncodeYou(YouFrame const&);
    std::string EncodeXp(XpFrame const&);
    std::string EncodeChar(CharSnapshot const&);
    // §14 lattice. Packs as many cells as fit MaxFrame; sets `outTruncated` if any were dropped
    // (deterministic head, never a silent split -- same contract as EncodeSchedule).
    std::string EncodeMastery(MasterySnapshot const&, bool& outTruncated);

    // Request encoders (client side mirrors these in Lua; provided here for round-trip tests).
    std::string EncodeAlloc(AllocRequest const&);
    std::string EncodeArchetype(ArchetypeRequest const&);
    std::string EncodeRespec(RespecRequest const&);

    // ---- Decoders (test + Lua-parity reference). Return false on malformed input; never throw ----
    bool DecodeHello(std::string_view frame, HelloFrame& out);
    bool DecodeEvent(std::string_view frame, EventFrame& out);
    bool DecodeSchedule(std::string_view frame, std::vector<ScheduleEntry>& out, bool& outTruncated);
    bool DecodeYou(std::string_view frame, YouFrame& out);
    bool DecodeXp(std::string_view frame, XpFrame& out);
    bool DecodeChar(std::string_view frame, CharSnapshot& out);
    bool DecodeMastery(std::string_view frame, MasterySnapshot& out, bool& outTruncated);
}

#endif // MOD_BRANDING_SRC_CORE_ADDON_PROTOCOL_H
