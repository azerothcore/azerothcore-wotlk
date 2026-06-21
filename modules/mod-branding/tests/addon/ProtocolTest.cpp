#include "branding/addon/Protocol.h"
#include <gtest/gtest.h>
#include <string>

using namespace Branding::Addon;

namespace
{
    // Every emitted frame must be a single, prefixed, length-bounded line (§19.2).
    void ExpectWellFormed(std::string const& frame)
    {
        EXPECT_EQ(frame.rfind("BRND\t", 0), 0u) << "frame must start with the BRND prefix";
        EXPECT_LE(frame.size(), MaxFrame) << "frame must fit a CHAT_MSG_ADDON body";
        EXPECT_EQ(frame.find('\n'), std::string::npos) << "frame must contain no newline";
        EXPECT_EQ(frame.find('\r'), std::string::npos) << "frame must contain no carriage return";
    }
}

// ---- Request parsing (client -> server) ----

TEST(AddonProtocol, ParseRequestKnownVerbs)
{
    uint8_t version = 0;
    EXPECT_EQ(ParseRequest("HELLO\t1", version), AddonRequest::Hello);
    EXPECT_EQ(version, 1);

    EXPECT_EQ(ParseRequest("REQ\tCHAR", version), AddonRequest::Char);
    EXPECT_EQ(ParseRequest("REQ\tSCH", version), AddonRequest::Schedule);
    EXPECT_EQ(ParseRequest("REQ\tSTATUS", version), AddonRequest::Status);
}

TEST(AddonProtocol, ParseRequestRejectsGarbage)
{
    uint8_t version = 0;
    EXPECT_EQ(ParseRequest("", version), AddonRequest::Unknown);
    EXPECT_EQ(ParseRequest("REQ", version), AddonRequest::Unknown);
    EXPECT_EQ(ParseRequest("REQ\tNOPE", version), AddonRequest::Unknown);
    EXPECT_EQ(ParseRequest("\t\t\t", version), AddonRequest::Unknown);
    EXPECT_EQ(ParseRequest("hello\t1", version), AddonRequest::Unknown) << "verbs are case-sensitive";
    // A hostile, oversized body must not throw and must not match a real request.
    EXPECT_EQ(ParseRequest(std::string(10000, 'x'), version), AddonRequest::Unknown);
}

TEST(AddonProtocol, StripPrefix)
{
    std::string_view body;
    EXPECT_TRUE(StripPrefix("BRND\tREQ\tCHAR", body));
    EXPECT_EQ(body, "REQ\tCHAR");

    EXPECT_FALSE(StripPrefix("OTHER\tREQ\tCHAR", body));
    EXPECT_FALSE(StripPrefix("BRND", body)) << "prefix without separator is not a frame";
    EXPECT_FALSE(StripPrefix("", body));
}

// ---- Round-trip: Decode(Encode(x)) == x ----

TEST(AddonProtocol, HelloRoundTrip)
{
    HelloFrame in{ ProtocolVersion, true };
    std::string const frame = EncodeHello(in);
    ExpectWellFormed(frame);

    HelloFrame out;
    ASSERT_TRUE(DecodeHello(frame, out));
    EXPECT_EQ(in, out);
}

TEST(AddonProtocol, EventRoundTrip)
{
    EventFrame in{ 1519, 0, 623, true };   // Orgrimmar, Invasion, 62.3% contained, active
    std::string const frame = EncodeEvent(in);
    ExpectWellFormed(frame);

    EventFrame out;
    ASSERT_TRUE(DecodeEvent(frame, out));
    EXPECT_EQ(in, out);
}

TEST(AddonProtocol, YouRoundTrip)
{
    YouFrame in{ 275, 2 };   // 275 points, Silver tier
    std::string const frame = EncodeYou(in);
    ExpectWellFormed(frame);

    YouFrame out;
    ASSERT_TRUE(DecodeYou(frame, out));
    EXPECT_EQ(in, out);
}

TEST(AddonProtocol, ScheduleRoundTrip)
{
    std::vector<ScheduleEntry> in{
        { 1519, 0, 1, 240 },   // active, 240s remaining
        { 1537, 2, 0, 900 },   // cooldown, 900s remaining
        { 141, 1, 2, 30 },
    };
    bool truncated = true;
    std::string const frame = EncodeSchedule(in, truncated);
    ExpectWellFormed(frame);
    EXPECT_FALSE(truncated) << "a small list must fit without truncation";

    std::vector<ScheduleEntry> out;
    bool outTrunc = true;
    ASSERT_TRUE(DecodeSchedule(frame, out, outTrunc));
    EXPECT_FALSE(outTrunc);
    EXPECT_EQ(in, out);
}

TEST(AddonProtocol, ScheduleEmptyRoundTrip)
{
    std::vector<ScheduleEntry> const in;
    bool truncated = true;
    std::string const frame = EncodeSchedule(in, truncated);
    ExpectWellFormed(frame);
    EXPECT_FALSE(truncated);

    std::vector<ScheduleEntry> out{ { 1, 1, 1, 1 } };   // pre-populated; decode must clear
    bool outTrunc = false;
    ASSERT_TRUE(DecodeSchedule(frame, out, outTrunc));
    EXPECT_TRUE(out.empty());
}

// A list too large for one frame is truncated deterministically and flagged -- never silently split.
TEST(AddonProtocol, ScheduleTruncatesAndFlags)
{
    std::vector<ScheduleEntry> in;
    for (uint32_t i = 0; i < 200; ++i)
        in.push_back({ 1000 + i, 0, 1, 123456 });

    bool truncated = false;
    std::string const frame = EncodeSchedule(in, truncated);
    ExpectWellFormed(frame);
    EXPECT_TRUE(truncated) << "200 entries cannot fit 255 bytes";

    std::vector<ScheduleEntry> out;
    bool outTrunc = false;
    ASSERT_TRUE(DecodeSchedule(frame, out, outTrunc));
    EXPECT_TRUE(outTrunc) << "the truncation marker must survive the round-trip";
    EXPECT_LT(out.size(), in.size());
    EXPECT_FALSE(out.empty());
    // The kept prefix is exact (deterministic head of the list).
    for (std::size_t i = 0; i < out.size(); ++i)
        EXPECT_EQ(out[i], in[i]);
}

TEST(AddonProtocol, CharRoundTrip)
{
    CharSnapshot in;
    in.brands = { { 0, 12, 240 }, { 3, 50, 1000 } };       // Fire L12, Shadow L50 (maxed)
    in.masteries = { { 0, true, 30, 120 }, { 1, false, 0, 0 } };
    in.loadout = { 0, 2 };                                  // Fire, archetype 2
    in.item = { true, 0, 2, 5, 1350 };                      // Fire weapon, step 2 lvl 5, x1.35
    in.allegiance = { 1, 1150 };                            // Fire/Chaos, x1.15

    std::string const frame = EncodeChar(in);
    ExpectWellFormed(frame);

    CharSnapshot out;
    ASSERT_TRUE(DecodeChar(frame, out));
    EXPECT_EQ(in, out);
}

TEST(AddonProtocol, CharRoundTripEmptyBrands)
{
    CharSnapshot in;
    in.loadout = { 6, 0 };
    in.item = { false, 0, 0, 0, 0 };
    in.allegiance = { 0, 1000 };

    std::string const frame = EncodeChar(in);
    ExpectWellFormed(frame);

    CharSnapshot out;
    ASSERT_TRUE(DecodeChar(frame, out));
    EXPECT_EQ(in, out);
}

// Forward-compat: an unknown KIND or malformed body decodes to a clean failure, never a crash.
TEST(AddonProtocol, DecodeRejectsMalformed)
{
    HelloFrame hello;
    EXPECT_FALSE(DecodeHello("BRND\tWAT\t1", hello)) << "wrong KIND";
    EXPECT_FALSE(DecodeHello("garbage", hello));
    EXPECT_FALSE(DecodeHello("", hello));

    EventFrame ev;
    EXPECT_FALSE(DecodeEvent("BRND\tEVT", ev)) << "missing fields";
    EXPECT_FALSE(DecodeEvent("BRND\tEVT\tnotanumber\t0\t0\t1", ev));

    YouFrame you;
    EXPECT_FALSE(DecodeYou("BRND\tHELLO\t1\t0", you)) << "wrong KIND for YOU";
}

// ---- §14 Mastery lattice (MAST) ----

TEST(AddonProtocol, MasteryRoundTrip)
{
    MasterySnapshot in;
    in.pointsAvailable = 7;
    in.respecCost = 250;
    // Fire-Def (windowed, 4 axes incl. reach), one active cell; Shadow-Support (situational +
    // sustained, magnitude+reach only); Frost-Off (windowed, single-target -> 3 axes).
    in.cells.push_back({ 0, 0, 1, false, false, 18, 1, 0x0F, { 3, 1, 2, 1 }, true });
    in.cells.push_back({ 3, 2, 1, true, true, 5, 0, 0x0C, { 0, 0, 2, 1 }, false });
    in.cells.push_back({ 1, 1, 1, false, false, 9, 0, 0x07, { 2, 1, 1, 0 }, true });

    bool truncated = true;
    std::string const frame = EncodeMastery(in, truncated);
    ExpectWellFormed(frame);
    EXPECT_FALSE(truncated) << "three cells fit a single frame";

    MasterySnapshot out;
    bool outTrunc = true;
    ASSERT_TRUE(DecodeMastery(frame, out, outTrunc));
    EXPECT_FALSE(outTrunc);
    EXPECT_EQ(in, out);
}

TEST(AddonProtocol, MasteryEmptyRoundTrip)
{
    MasterySnapshot in;
    in.pointsAvailable = 0;
    in.respecCost = 0;

    bool truncated = true;
    std::string const frame = EncodeMastery(in, truncated);
    ExpectWellFormed(frame);
    EXPECT_FALSE(truncated);

    MasterySnapshot out;
    out.cells.push_back({ 9, 9, 9, true, true, 9, 9, 9, { 9, 9, 9, 9 }, true });   // must be cleared
    bool outTrunc = false;
    ASSERT_TRUE(DecodeMastery(frame, out, outTrunc));
    EXPECT_TRUE(out.cells.empty());
    EXPECT_EQ(in, out);
}

// Multi-mastery forward-compat: the active set is a per-cell flag list, so MORE THAN ONE cell may
// be active at once -- the wire model already supports running multiple masteries simultaneously.
TEST(AddonProtocol, MasterySupportsMultipleActiveCells)
{
    MasterySnapshot in;
    in.cells.push_back({ 0, 0, 1, false, false, 10, 0, 0x0F, { 1, 1, 1, 1 }, true });
    in.cells.push_back({ 1, 1, 1, false, false, 10, 0, 0x07, { 1, 1, 1, 0 }, true });
    in.cells.push_back({ 2, 2, 1, true, true, 10, 0, 0x0C, { 0, 0, 1, 1 }, false });

    bool truncated = false;
    std::string const frame = EncodeMastery(in, truncated);
    MasterySnapshot out;
    bool outTrunc = false;
    ASSERT_TRUE(DecodeMastery(frame, out, outTrunc));

    int activeCount = 0;
    for (auto const& c : out.cells)
        if (c.active)
            ++activeCount;
    EXPECT_EQ(activeCount, 2) << "multiple cells active simultaneously must survive the round-trip";
}

// A lattice too large for one frame truncates deterministically and flags -- never a silent split.
TEST(AddonProtocol, MasteryTruncatesAndFlags)
{
    MasterySnapshot in;
    for (uint32_t i = 0; i < 200; ++i)
        in.cells.push_back({ static_cast<uint8_t>(i % 7), static_cast<uint8_t>(i % 3), 1,
            false, false, 60, 1, 0x0F, { 99, 99, 99, 99 }, true });

    bool truncated = false;
    std::string const frame = EncodeMastery(in, truncated);
    ExpectWellFormed(frame);
    EXPECT_TRUE(truncated) << "200 cells cannot fit 255 bytes";

    MasterySnapshot out;
    bool outTrunc = false;
    ASSERT_TRUE(DecodeMastery(frame, out, outTrunc));
    EXPECT_TRUE(outTrunc) << "the truncation marker must survive";
    EXPECT_LT(out.cells.size(), in.cells.size());
    EXPECT_FALSE(out.cells.empty());
    for (std::size_t i = 0; i < out.cells.size(); ++i)
        EXPECT_EQ(out.cells[i], in.cells[i]) << "kept prefix is the deterministic head";
}

TEST(AddonProtocol, MasteryDecodeRejectsMalformed)
{
    MasterySnapshot out;
    bool trunc = false;
    EXPECT_FALSE(DecodeMastery("BRND\tCHAR\t0\t0\t\t", out, trunc)) << "wrong KIND";
    EXPECT_FALSE(DecodeMastery("BRND\tMAST\t0\t0", out, trunc)) << "missing fields";
    EXPECT_FALSE(DecodeMastery("BRND\tMAST\tx\t0\t\t", out, trunc)) << "non-numeric points";
    EXPECT_FALSE(DecodeMastery("BRND\tMAST\t0\t0\t0:0:1\t", out, trunc)) << "short cell record";
}

// ---- §14 client->server request grammar (§19.3 reserved) ----

TEST(AddonProtocol, ParseMasteryRequestVerbs)
{
    uint8_t version = 0;
    EXPECT_EQ(ParseRequest("REQ\tMAST", version), AddonRequest::Mastery);
    EXPECT_EQ(ParseRequest("ALLOC\t0\t0\t2\t3", version), AddonRequest::Allocate);
    EXPECT_EQ(ParseRequest("ARCH\t0\t1\t2", version), AddonRequest::Archetype);
    EXPECT_EQ(ParseRequest("RESPEC\t0\t0", version), AddonRequest::Respec);
}

TEST(AddonProtocol, AllocRequestRoundTrip)
{
    AllocRequest in{ 3, 1, 2, 4 };   // Shadow, Off tree, Magnitude axis, 4 points
    std::string const frame = EncodeAlloc(in);
    ExpectWellFormed(frame);

    std::string_view body;
    ASSERT_TRUE(StripPrefix(frame, body));
    AllocRequest out;
    ASSERT_TRUE(ParseAlloc(body, out));
    EXPECT_EQ(in, out);
}

TEST(AddonProtocol, ArchetypeRequestRoundTrip)
{
    ArchetypeRequest in{ 1, 0, 2 };
    std::string_view body;
    ASSERT_TRUE(StripPrefix(EncodeArchetype(in), body));
    ArchetypeRequest out;
    ASSERT_TRUE(ParseArchetype(body, out));
    EXPECT_EQ(in, out);
}

TEST(AddonProtocol, RespecRequestRoundTrip)
{
    RespecRequest in{ 4, 2 };
    std::string_view body;
    ASSERT_TRUE(StripPrefix(EncodeRespec(in), body));
    RespecRequest out;
    ASSERT_TRUE(ParseRespec(body, out));
    EXPECT_EQ(in, out);
}

TEST(AddonProtocol, RequestParsersRejectMalformed)
{
    AllocRequest a;
    EXPECT_FALSE(ParseAlloc("ALLOC\t0\t0\t2", a)) << "missing field";
    EXPECT_FALSE(ParseAlloc("ARCH\t0\t0\t2\t3", a)) << "wrong verb";
    EXPECT_FALSE(ParseAlloc("ALLOC\t0\t0\tx\t3", a)) << "non-numeric";

    ArchetypeRequest ar;
    EXPECT_FALSE(ParseArchetype("ARCH\t0\t0", ar));

    RespecRequest r;
    EXPECT_FALSE(ParseRespec("RESPEC\t0", r));
}
