/*
 * NostrumWoW Progression Module
 *
 * Enforces the phase level cap driven by a single config value:
 *
 *   Nostrum.ActivePhase = <0-7>
 *
 * The level cap and phase name are derived automatically from the phase table.
 * Changing ActivePhase and running `.reload config` is all that is needed to
 * advance the server to the next phase.
 *
 * Phase table:
 *   0 — Beta    (cap 80, no restriction)
 *   1 — Phase 1 (cap 19)
 *   2 — Phase 2 (cap 29)
 *   3 — Phase 3 (cap 39)
 *   4 — Phase 4 (cap 49)
 *   5 — Phase 5 (cap 60)
 *   6 — Phase 6 (cap 70)
 *   7 — Phase 7 (cap 80, WotLK — Death Knights unlocked)
 *
 * Content locks:
 *   Dungeon/raid map entry, login-inside-locked-map teleport, battleground
 *   queues, and LFG dungeon queues are all gated by the same phase table.
 */

#include "Chat.h"
#include "Common.h"
#include "Config.h"
#include "DBCStores.h"
#include "LFGMgr.h"
#include "Player.h"
#include "PlayerScript.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "WorldScript.h"

#include <unordered_map>

namespace
{

// ---------------------------------------------------------------------------
// Phase table
// ---------------------------------------------------------------------------

struct PhaseEntry
{
    uint8       cap;
    char const* name;
};

static constexpr PhaseEntry kPhases[8] =
{
    { 80, "Beta"    }, // 0 — no cap, 3× rates via mod-nostrum-rates
    { 19, "Phase 1" }, // 1
    { 29, "Phase 2" }, // 2
    { 39, "Phase 3" }, // 3
    { 49, "Phase 4" }, // 4
    { 60, "Phase 5" }, // 5 — vanilla endgame
    { 70, "Phase 6" }, // 6 — TBC
    { 80, "Phase 7" }, // 7 — WotLK
};

static constexpr uint8 kMaxPhase = 7;

// ---------------------------------------------------------------------------
// Content lock tables
// ---------------------------------------------------------------------------

// Maps instance map ID -> minimum progression phase required.
static const std::unordered_map<uint32, uint8> kInstanceUnlockPhase =
{
    // Phase 1 — level 19
    { 389, 1 }, // Ragefire Chasm
    { 36,  1 }, // Deadmines
    { 43,  1 }, // Wailing Caverns
    { 33,  1 }, // Shadowfang Keep

    // Phase 2 — level 29
    { 48,  2 }, // Blackfathom Deeps
    { 34,  2 }, // Stormwind Stockade
    { 90,  2 }, // Gnomeregan
    { 47,  2 }, // Razorfen Kraul

    // Phase 3 — level 39
    { 189, 3 }, // Scarlet Monastery
    { 129, 3 }, // Razorfen Downs

    // Phase 4 — level 49
    { 70,  4 }, // Uldaman
    { 209, 4 }, // Zul'Farrak
    { 349, 4 }, // Maraudon
    { 109, 4 }, // Sunken Temple / Temple of Atal'Hakkar

    // Phase 5 — Vanilla endgame
    { 230, 5 }, // Blackrock Depths
    { 229, 5 }, // Blackrock Spire (LBRS/UBRS)
    { 429, 5 }, // Dire Maul
    { 329, 5 }, // Stratholme
    { 289, 5 }, // Scholomance
    { 409, 5 }, // Molten Core
    { 469, 5 }, // Blackwing Lair
    { 309, 5 }, // Zul'Gurub
    { 249, 5 }, // Onyxia's Lair
    { 509, 5 }, // Ruins of Ahn'Qiraj
    { 531, 5 }, // Ahn'Qiraj Temple

    // Phase 6 — TBC
    { 543, 6 }, // Hellfire Citadel: Ramparts
    { 542, 6 }, // Hellfire Citadel: The Blood Furnace
    { 540, 6 }, // Hellfire Citadel: The Shattered Halls
    { 546, 6 }, // Coilfang: The Underbog
    { 547, 6 }, // Coilfang: The Slave Pens
    { 545, 6 }, // Coilfang: The Steamvault
    { 557, 6 }, // Auchindoun: Mana-Tombs
    { 558, 6 }, // Auchindoun: Auchenai Crypts
    { 556, 6 }, // Auchindoun: Sethekk Halls
    { 555, 6 }, // Auchindoun: Shadow Labyrinth
    { 553, 6 }, // Tempest Keep: The Botanica
    { 554, 6 }, // Tempest Keep: The Mechanar
    { 552, 6 }, // Tempest Keep: The Arcatraz
    { 269, 6 }, // Opening of the Dark Portal / Black Morass
    { 560, 6 }, // The Escape From Durnholde / Old Hillsbrad
    { 585, 6 }, // Magister's Terrace
    { 532, 6 }, // Karazhan
    { 544, 6 }, // Magtheridon's Lair
    { 565, 6 }, // Gruul's Lair
    { 548, 6 }, // Coilfang: Serpentshrine Cavern
    { 550, 6 }, // Tempest Keep / The Eye
    { 564, 6 }, // Black Temple
    { 534, 6 }, // The Battle for Mount Hyjal
    { 568, 6 }, // Zul'Aman
    { 580, 6 }, // Sunwell Plateau

    // Phase 7 — WotLK
    { 574, 7 }, // Utgarde Keep
    { 575, 7 }, // Utgarde Pinnacle
    { 576, 7 }, // The Nexus
    { 578, 7 }, // The Oculus
    { 599, 7 }, // Halls of Stone
    { 602, 7 }, // Halls of Lightning
    { 600, 7 }, // Drak'Tharon Keep
    { 604, 7 }, // Gundrak
    { 601, 7 }, // Azjol-Nerub
    { 619, 7 }, // Ahn'kahet: The Old Kingdom
    { 608, 7 }, // Violet Hold
    { 595, 7 }, // The Culling of Stratholme
    { 650, 7 }, // Trial of the Champion
    { 632, 7 }, // The Forge of Souls
    { 658, 7 }, // Pit of Saron
    { 668, 7 }, // Halls of Reflection
    { 533, 7 }, // Naxxramas (WotLK 3.3.5a map entry)
    { 615, 7 }, // The Obsidian Sanctum
    { 616, 7 }, // The Eye of Eternity
    { 624, 7 }, // Vault of Archavon
    { 603, 7 }, // Ulduar
    { 649, 7 }, // Trial of the Crusader
    { 631, 7 }, // Icecrown Citadel
    { 724, 7 }, // The Ruby Sanctum
};

// Maps BattlegroundTypeId -> minimum progression phase required.
static const std::unordered_map<uint32, uint8> kBattlegroundUnlockPhase =
{
    { BATTLEGROUND_WS, 1 }, // Warsong Gulch
    { BATTLEGROUND_AB, 2 }, // Arathi Basin
    { BATTLEGROUND_AV, 5 }, // Alterac Valley
    { BATTLEGROUND_EY, 6 }, // Eye of the Storm
    { BATTLEGROUND_SA, 7 }, // Strand of the Ancients
    { BATTLEGROUND_IC, 7 }, // Isle of Conquest
};

// ---------------------------------------------------------------------------
// Config
// ---------------------------------------------------------------------------

struct ProgConfig
{
    bool    enabled             = true;
    uint8   activePhase         = 1;
    bool    gmBypass            = true;
    bool    loginAnnouncement   = true;
    bool    lockInstances       = true;
    bool    teleportOutLocked   = true;
    bool    lockBattlegrounds   = true;
    bool    lockLFG             = true;
    bool    debug               = false;
};

ProgConfig gCfg;

void LoadConfig()
{
    gCfg = {};

    gCfg.enabled = sConfigMgr->GetOption<bool>("Nostrum.Progression.Enable", true);

    uint32 phase = sConfigMgr->GetOption<uint32>("Nostrum.ActivePhase", 1);
    if (phase > kMaxPhase)
    {
        LOG_WARN("module", ">> NostrumProgression: ActivePhase {} out of range [0-{}], using 1",
            phase, kMaxPhase);
        phase = 1;
    }
    gCfg.activePhase = static_cast<uint8>(phase);

    gCfg.gmBypass            = sConfigMgr->GetOption<bool>("Nostrum.Progression.GmBypass",                    true);
    gCfg.loginAnnouncement   = sConfigMgr->GetOption<bool>("Nostrum.Progression.LoginAnnouncement",           true);
    gCfg.lockInstances       = sConfigMgr->GetOption<bool>("Nostrum.Progression.LockInstances",               true);
    gCfg.teleportOutLocked   = sConfigMgr->GetOption<bool>("Nostrum.Progression.TeleportOutOfLockedMapsOnLogin", true);
    gCfg.lockBattlegrounds   = sConfigMgr->GetOption<bool>("Nostrum.Progression.LockBattlegrounds",           true);
    gCfg.lockLFG             = sConfigMgr->GetOption<bool>("Nostrum.Progression.LockLFG",                     true);
    gCfg.debug               = sConfigMgr->GetOption<bool>("Nostrum.Progression.Debug",                       false);

    LOG_INFO("module", ">> NostrumProgression: {} — cap {} — enabled={} lockInstances={} lockBG={} lockLFG={}",
        kPhases[gCfg.activePhase].name,
        uint32(kPhases[gCfg.activePhase].cap),
        gCfg.enabled,
        gCfg.lockInstances,
        gCfg.lockBattlegrounds,
        gCfg.lockLFG);
}

// ---------------------------------------------------------------------------
// Lock helpers
// ---------------------------------------------------------------------------

bool IsInstanceMapUnlocked(uint32 mapId)
{
    if (!gCfg.enabled || gCfg.activePhase == 0)
        return true;

    auto itr = kInstanceUnlockPhase.find(mapId);
    if (itr == kInstanceUnlockPhase.end())
        return true;

    return gCfg.activePhase >= itr->second;
}

bool IsBattlegroundUnlocked(uint32 bgTypeId)
{
    if (!gCfg.enabled || gCfg.activePhase == 0)
        return true;

    auto itr = kBattlegroundUnlockPhase.find(bgTypeId);
    if (itr == kBattlegroundUnlockPhase.end())
        return true;

    return gCfg.activePhase >= itr->second;
}

void TeleportToHomebind(Player* player)
{
    player->TeleportTo(player->m_homebindMapId,
                       player->m_homebindX,
                       player->m_homebindY,
                       player->m_homebindZ,
                       0.0f);
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript — config reload
// ---------------------------------------------------------------------------

class NostrumProgressionWorldScript : public WorldScript
{
public:
    NostrumProgressionWorldScript() : WorldScript("NostrumProgressionWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD })
    {
    }

    void OnAfterConfigLoad(bool reload) override
    {
        LoadConfig();
        if (reload)
            LOG_INFO("module", ">> NostrumProgression: config reloaded");
    }
};

// ---------------------------------------------------------------------------
// PlayerScript — cap enforcement + content locks
// ---------------------------------------------------------------------------

class NostrumProgressionPlayerScript : public PlayerScript
{
public:
    NostrumProgressionPlayerScript() : PlayerScript("NostrumProgressionPlayerScript",
        {
            PLAYERHOOK_ON_LOGIN,
            PLAYERHOOK_ON_LEVEL_CHANGED,
            PLAYERHOOK_ON_GIVE_EXP,
            PLAYERHOOK_CAN_ENTER_MAP,
            PLAYERHOOK_CAN_JOIN_IN_BATTLEGROUND_QUEUE,
            PLAYERHOOK_CAN_BATTLEFIELD_PORT,
            PLAYERHOOK_CAN_JOIN_LFG,
        })
    {
    }

    // -----------------------------------------------------------------------
    // Login — level cap + teleport out of locked maps
    // -----------------------------------------------------------------------

    void OnPlayerLogin(Player* player) override
    {
        if (!gCfg.enabled)
            return;

        uint8       cap  = kPhases[gCfg.activePhase].cap;
        char const* name = kPhases[gCfg.activePhase].name;

        if (IsExempt(player))
        {
            if (gCfg.loginAnnouncement)
                ChatHandler(player->GetSession()).PSendSysMessage(
                    "[NostrumWoW] {} — Level cap: {} (GM bypass active)", name, uint32(cap));
            return;
        }

        if (player->GetLevel() > cap)
            EnforceCap(player, cap, name);

        if (gCfg.loginAnnouncement)
            ChatHandler(player->GetSession()).PSendSysMessage(
                "[NostrumWoW] {} — Current level cap: {}", name, uint32(cap));

        if (gCfg.lockInstances && gCfg.teleportOutLocked && !IsInstanceMapUnlocked(player->GetMapId()))
        {
            ChatHandler(player->GetSession()).SendSysMessage(
                "[NostrumWoW] You have been moved because this instance is locked in the current progression phase.");
            TeleportToHomebind(player);
        }
    }

    // -----------------------------------------------------------------------
    // Level change — cap enforcement
    // -----------------------------------------------------------------------

    void OnPlayerLevelChanged(Player* player, uint8 /*oldLevel*/) override
    {
        if (!gCfg.enabled || IsExempt(player))
            return;

        uint8 cap = kPhases[gCfg.activePhase].cap;
        if (player->GetLevel() > cap)
            EnforceCap(player, cap, kPhases[gCfg.activePhase].name);
    }

    // -----------------------------------------------------------------------
    // XP gate
    // -----------------------------------------------------------------------

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 /*xpSource*/) override
    {
        if (!gCfg.enabled || IsExempt(player))
            return;

        if (player->GetLevel() >= kPhases[gCfg.activePhase].cap)
            amount = 0;
    }

    // -----------------------------------------------------------------------
    // Map entry gate
    // -----------------------------------------------------------------------

    bool OnPlayerCanEnterMap(Player* player, MapEntry const* entry,
                             InstanceTemplate const* /*instance*/,
                             MapDifficulty const* /*mapDiff*/,
                             bool /*loginCheck*/) override
    {
        if (!gCfg.lockInstances || IsExempt(player))
            return true;

        uint32 mapId         = entry->MapID;
        bool   allowed       = IsInstanceMapUnlocked(mapId);

        if (gCfg.debug)
        {
            auto itr          = kInstanceUnlockPhase.find(mapId);
            uint8 required    = (itr != kInstanceUnlockPhase.end()) ? itr->second : 0;
            LOG_INFO("module.nostrum.progression",
                "Map entry check: player={} phase={} mapId={} required={} allowed={}",
                player->GetName(), uint32(gCfg.activePhase), mapId, uint32(required), allowed);
        }

        if (!allowed)
            ChatHandler(player->GetSession()).SendSysMessage(
                "[NostrumWoW] This instance is locked until a later progression phase.");

        return allowed;
    }

    // -----------------------------------------------------------------------
    // Battleground queue gate
    // -----------------------------------------------------------------------

    bool OnPlayerCanJoinInBattlegroundQueue(Player* player, ObjectGuid /*BattlemasterGuid*/,
                                            BattlegroundTypeId BGTypeID, uint8 /*joinAsGroup*/,
                                            GroupJoinBattlegroundResult& /*err*/) override
    {
        if (!gCfg.lockBattlegrounds || IsExempt(player))
            return true;

        uint32 bgType  = static_cast<uint32>(BGTypeID);
        bool   allowed = IsBattlegroundUnlocked(bgType);

        if (gCfg.debug)
        {
            auto itr       = kBattlegroundUnlockPhase.find(bgType);
            uint8 required = (itr != kBattlegroundUnlockPhase.end()) ? itr->second : 0;
            LOG_INFO("module.nostrum.progression",
                "BG queue check: player={} phase={} bgType={} required={} allowed={}",
                player->GetName(), uint32(gCfg.activePhase), bgType, uint32(required), allowed);
        }

        if (!allowed)
            ChatHandler(player->GetSession()).SendSysMessage(
                "[NostrumWoW] This battleground is locked until a later progression phase.");

        return allowed;
    }

    // Second-layer defence: catches port-in after a phase change.
    bool OnPlayerCanBattleFieldPort(Player* player, uint8 /*arenaType*/,
                                    BattlegroundTypeId BGTypeID, uint8 /*action*/) override
    {
        if (!gCfg.lockBattlegrounds || IsExempt(player))
            return true;

        uint32 bgType  = static_cast<uint32>(BGTypeID);
        bool   allowed = IsBattlegroundUnlocked(bgType);

        if (!allowed)
            ChatHandler(player->GetSession()).SendSysMessage(
                "[NostrumWoW] This battleground is locked until a later progression phase.");

        return allowed;
    }

    // -----------------------------------------------------------------------
    // LFG / Dungeon Finder gate
    //
    // dungeons is a set<uint32> of LFGDungeonEntry IDs (not map IDs).
    // We resolve each to its map ID via sLFGDungeonStore and check the lock
    // table.  If any selected dungeon resolves to a locked map, the queue is
    // blocked.
    // -----------------------------------------------------------------------

    bool OnPlayerCanJoinLfg(Player* player, uint8 /*roles*/,
                            lfg::LfgDungeonSet& dungeons,
                            const std::string& /*comment*/) override
    {
        if (!gCfg.lockLFG || IsExempt(player))
            return true;

        for (uint32 dungeonId : dungeons)
        {
            LFGDungeonEntry const* dungeon = sLFGDungeonStore.LookupEntry(dungeonId);
            if (!dungeon)
                continue;

            uint32 mapId   = dungeon->MapID;
            bool   allowed = IsInstanceMapUnlocked(mapId);

            if (gCfg.debug)
            {
                auto itr       = kInstanceUnlockPhase.find(mapId);
                uint8 required = (itr != kInstanceUnlockPhase.end()) ? itr->second : 0;
                LOG_INFO("module.nostrum.progression",
                    "LFG check: player={} phase={} dungeonId={} mapId={} required={} allowed={}",
                    player->GetName(), uint32(gCfg.activePhase), dungeonId, mapId, uint32(required), allowed);
            }

            if (!allowed)
            {
                ChatHandler(player->GetSession()).SendSysMessage(
                    "[NostrumWoW] One or more selected dungeons are locked until a later progression phase.");
                return false;
            }
        }

        return true;
    }

private:
    bool IsExempt(Player* player) const
    {
        return gCfg.gmBypass && player->GetSession()->GetSecurity() >= SEC_GAMEMASTER;
    }

    void EnforceCap(Player* player, uint8 cap, char const* phaseName) const
    {
        player->GiveLevel(cap);
        player->SetUInt32Value(PLAYER_XP, 0);
        ChatHandler(player->GetSession()).PSendSysMessage(
            "[NostrumWoW] Your level has been set to {} — {} cap enforced.", uint32(cap), phaseName);
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_progressionScripts()
{
    new NostrumProgressionWorldScript();
    new NostrumProgressionPlayerScript();
}
