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
    inline constexpr uint8_t ProtocolVersion = 1;

    // What the client asked for (after the BRND prefix is stripped).
    enum class AddonRequest : uint8_t { Hello, Char, Schedule, Status, Unknown };

    // ---- Snapshot POD inputs (adapter fills from Mgrs; no AC types) ----

    struct HelloFrame { uint8_t version = ProtocolVersion; bool enabled = false; };
    struct EventFrame { uint32_t zoneId = 0; uint8_t type = 0; uint16_t containmentPermille = 0; bool active = false; };
    struct ScheduleEntry { uint32_t zoneId = 0; uint8_t type = 0; uint8_t state = 0; uint32_t secondsRemaining = 0; };
    struct YouFrame { uint32_t points = 0; uint8_t tier = 0; };
    struct BrandFrame { uint8_t brand = 0; uint8_t level = 0; uint16_t strengthPermille = 0; };
    struct MasteryFrame { uint8_t system = 0; bool unlocked = false; uint8_t level = 0; uint16_t bonusPermille = 0; };
    struct LoadoutFrame { uint8_t activeBrand = 0; uint8_t archetype = 0; };
    struct ItemFrame { bool equipped = false; uint8_t brand = 0; uint8_t step = 0; uint8_t level = 0; uint16_t intensityPermille = 0; };
    struct AllegianceFrame { uint8_t id = 0; uint16_t efficiencyPermille = 0; };

    // Composite character-panel snapshot (one frame).
    struct CharSnapshot
    {
        std::vector<BrandFrame> brands;
        std::vector<MasteryFrame> masteries;
        LoadoutFrame loadout;
        ItemFrame item;
        AllegianceFrame allegiance;
    };

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
    bool operator==(CharSnapshot const&, CharSnapshot const&);

    // ---- Request parsing (client -> server) ----
    // `body` is the message with the leading "BRND\t" already removed. Never throws; an unknown or
    // malformed verb yields Unknown. For Hello, `outVersion` is set to the client's protocol version.
    AddonRequest ParseRequest(std::string_view body, uint8_t& outVersion);

    // Strips the "BRND\t" prefix from a raw incoming addon body. Returns false (and leaves outBody
    // untouched) if `raw` is not one of our frames.
    bool StripPrefix(std::string_view raw, std::string_view& outBody);

    // ---- Encoders (server -> client): each returns a full "BRND\t<KIND>\t..." frame ----
    std::string EncodeHello(HelloFrame const&);
    std::string EncodeEvent(EventFrame const&);
    // Packs as many entries as fit MaxFrame; sets `outTruncated` if any were dropped (never silent).
    std::string EncodeSchedule(std::vector<ScheduleEntry> const&, bool& outTruncated);
    std::string EncodeYou(YouFrame const&);
    std::string EncodeChar(CharSnapshot const&);

    // ---- Decoders (test + Lua-parity reference). Return false on malformed input; never throw ----
    bool DecodeHello(std::string_view frame, HelloFrame& out);
    bool DecodeEvent(std::string_view frame, EventFrame& out);
    bool DecodeSchedule(std::string_view frame, std::vector<ScheduleEntry>& out, bool& outTruncated);
    bool DecodeYou(std::string_view frame, YouFrame& out);
    bool DecodeChar(std::string_view frame, CharSnapshot& out);
}

#endif // MOD_BRANDING_SRC_CORE_ADDON_PROTOCOL_H
