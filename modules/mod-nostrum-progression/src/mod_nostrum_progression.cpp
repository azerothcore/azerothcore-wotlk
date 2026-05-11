/*
 * NostrumWoW Progression Module
 *
 * Controls server content availability via a two-axis Era + Phase system:
 *
 *   Nostrum.Progression.Era   = 1  (1=Azeroth  2=Outland  3=Northrend)
 *   Nostrum.Progression.Phase = 1  (within-era phase number)
 *
 * Unlock rule:
 *   required era  < current era  → unlocked
 *   required era  > current era  → locked
 *   required era == current era  → unlocked if current phase >= required phase
 *
 * Level caps:
 *   Azeroth Phase 1: 19 | Phase 2: 29 | Phase 3: 39 | Phase 4: 49 | Phase 5+: 60
 *   Outland  (any phase): 70
 *   Northrend (any phase): 80
 *
 * Locks enforced:
 *   - Level cap (XP gate + level rollback)
 *   - Continent maps (530 Outland, 571 Northrend, 609 DK zone)
 *   - Instance/raid entry (per era+phase)
 *   - Battleground queues
 *   - LFG/Dungeon Finder queues
 *   - World boss spawns (despawned until their phase)
 *   - Badge/emblem currency purchases
 */

#include "AllCreatureScript.h"
#include "Chat.h"
#include "Common.h"
#include "Config.h"
#include "Creature.h"
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
// Era/Phase key
// ---------------------------------------------------------------------------

struct EraPhaseKey
{
    uint8 era;
    uint8 phase;
};

// ---------------------------------------------------------------------------
// Instance lock table  (map ID → minimum era/phase required)
// ---------------------------------------------------------------------------

static const std::unordered_map<uint32, EraPhaseKey> kInstanceLock =
{
    // ---- Era 1, Phase 1 (cap 19) ----
    { 389, {1,1} }, // Ragefire Chasm
    {  36, {1,1} }, // Deadmines
    {  43, {1,1} }, // Wailing Caverns
    {  33, {1,1} }, // Shadowfang Keep

    // ---- Era 1, Phase 2 (cap 29) ----
    {  48, {1,2} }, // Blackfathom Deeps
    {  34, {1,2} }, // Stormwind Stockade
    {  90, {1,2} }, // Gnomeregan
    {  47, {1,2} }, // Razorfen Kraul

    // ---- Era 1, Phase 3 (cap 39) ----
    { 189, {1,3} }, // Scarlet Monastery
    { 129, {1,3} }, // Razorfen Downs

    // ---- Era 1, Phase 4 (cap 49) ----
    {  70, {1,4} }, // Uldaman
    { 209, {1,4} }, // Zul'Farrak
    { 349, {1,4} }, // Maraudon
    { 109, {1,4} }, // Sunken Temple

    // ---- Era 1, Phase 5 — Vanilla endgame ----
    { 230, {1,5} }, // Blackrock Depths
    { 229, {1,5} }, // Blackrock Spire (LBRS/UBRS)
    { 429, {1,5} }, // Dire Maul
    { 329, {1,5} }, // Stratholme
    { 289, {1,5} }, // Scholomance
    { 409, {1,5} }, // Molten Core
    { 249, {3,3} }, // Onyxia's Lair (level 60 + level 80 — both gated at Northrend Phase 3)

    // ---- Era 1, Phase 6 — Blackwing Lair ----
    { 469, {1,6} }, // Blackwing Lair

    // ---- Era 1, Phase 7 — Zul'Gurub ----
    { 309, {1,7} }, // Zul'Gurub

    // ---- Era 1, Phase 8 — Ahn'Qiraj ----
    { 509, {1,8} }, // Ruins of Ahn'Qiraj (AQ20)
    { 531, {1,8} }, // Temple of Ahn'Qiraj (AQ40)

    // ---- Era 2, Phase 1 — TBC dungeons + opening raids ----
    { 543, {2,1} }, // Hellfire Citadel: Ramparts
    { 542, {2,1} }, // Hellfire Citadel: Blood Furnace
    { 540, {2,1} }, // Hellfire Citadel: Shattered Halls
    { 546, {2,1} }, // Coilfang: The Underbog
    { 547, {2,1} }, // Coilfang: The Slave Pens
    { 545, {2,1} }, // Coilfang: The Steamvault
    { 557, {2,1} }, // Auchindoun: Mana-Tombs
    { 558, {2,1} }, // Auchindoun: Auchenai Crypts
    { 556, {2,1} }, // Auchindoun: Sethekk Halls
    { 555, {2,1} }, // Auchindoun: Shadow Labyrinth
    { 553, {2,1} }, // Tempest Keep: The Botanica
    { 554, {2,1} }, // Tempest Keep: The Mechanar
    { 552, {2,1} }, // Tempest Keep: The Arcatraz
    { 269, {2,1} }, // Opening of the Dark Portal / Black Morass
    { 560, {2,1} }, // The Escape From Durnholde / Old Hillsbrad
    { 585, {2,1} }, // Magister's Terrace
    { 532, {2,1} }, // Karazhan
    { 544, {2,1} }, // Magtheridon's Lair
    { 565, {2,1} }, // Gruul's Lair

    // ---- Era 2, Phase 2 — Serpentshrine & Tempest Keep ----
    { 548, {2,2} }, // Coilfang: Serpentshrine Cavern
    { 550, {2,2} }, // Tempest Keep / The Eye

    // ---- Era 2, Phase 3 — Mount Hyjal & Black Temple ----
    { 534, {2,3} }, // The Battle for Mount Hyjal
    { 564, {2,3} }, // Black Temple
    { 568, {2,3} }, // Zul'Aman

    // ---- Era 2, Phase 4 — Sunwell ----
    { 580, {2,4} }, // Sunwell Plateau

    // ---- Era 3, Phase 1 — WotLK dungeons + opening raids ----
    { 574, {3,1} }, // Utgarde Keep
    { 575, {3,1} }, // Utgarde Pinnacle
    { 576, {3,1} }, // The Nexus
    { 578, {3,1} }, // The Oculus
    { 599, {3,1} }, // Halls of Stone
    { 602, {3,1} }, // Halls of Lightning
    { 600, {3,1} }, // Drak'Tharon Keep
    { 604, {3,1} }, // Gundrak
    { 601, {3,1} }, // Azjol-Nerub
    { 619, {3,1} }, // Ahn'kahet: The Old Kingdom
    { 608, {3,1} }, // Violet Hold
    { 595, {3,1} }, // The Culling of Stratholme
    { 650, {3,1} }, // Trial of the Champion
    { 632, {3,1} }, // The Forge of Souls
    { 658, {3,1} }, // Pit of Saron
    { 668, {3,1} }, // Halls of Reflection
    { 533, {3,1} }, // Naxxramas
    { 615, {3,1} }, // The Obsidian Sanctum
    { 616, {3,1} }, // The Eye of Eternity
    { 624, {3,1} }, // Vault of Archavon

    // ---- Era 3, Phase 2 — Ulduar ----
    { 603, {3,2} }, // Ulduar

    // ---- Era 3, Phase 3 — Trial of the Crusader & Onyxia 80 ----
    { 649, {3,3} }, // Trial of the Crusader
    // map 249 (Onyxia) is already in the table above at {3,3}

    // ---- Era 3, Phase 4 — Icecrown & Ruby Sanctum ----
    { 631, {3,4} }, // Icecrown Citadel
    { 724, {3,4} }, // The Ruby Sanctum
};

// ---------------------------------------------------------------------------
// Continent/map lock table  (map ID → minimum era/phase required)
// ---------------------------------------------------------------------------

static const std::unordered_map<uint32, EraPhaseKey> kMapLock =
{
    { 530, {2,1} }, // Outland
    { 571, {3,1} }, // Northrend
    { 609, {3,1} }, // Death Knight starting zone
};

// ---------------------------------------------------------------------------
// Battleground lock table
// ---------------------------------------------------------------------------

static const std::unordered_map<uint32, EraPhaseKey> kBattlegroundLock =
{
    { BATTLEGROUND_WS, {1,1} }, // Warsong Gulch
    { BATTLEGROUND_AB, {1,2} }, // Arathi Basin
    { BATTLEGROUND_AV, {1,5} }, // Alterac Valley
    { BATTLEGROUND_EY, {2,1} }, // Eye of the Storm
    { BATTLEGROUND_SA, {3,1} }, // Strand of the Ancients
    { BATTLEGROUND_IC, {3,1} }, // Isle of Conquest
};

// ---------------------------------------------------------------------------
// World boss lock table  (creature entry → minimum era/phase required)
// ---------------------------------------------------------------------------

static const std::unordered_map<uint32, EraPhaseKey> kWorldBossLock =
{
    {  6109, {1,5} }, // Azuregos
    { 12397, {1,5} }, // Lord Kazzak
    { 14887, {1,5} }, // Ysondre (Dragon of Nightmare)
    { 14888, {1,5} }, // Lethon  (Dragon of Nightmare)
    { 14889, {1,5} }, // Emeriss (Dragon of Nightmare)
    { 14890, {1,5} }, // Taerar  (Dragon of Nightmare)
    { 18728, {2,1} }, // Doom Lord Kazzak
    { 17711, {2,1} }, // Doomwalker
};

// ---------------------------------------------------------------------------
// Currency item lock table  (item entry → minimum era/phase required)
// ---------------------------------------------------------------------------

static const std::unordered_map<uint32, EraPhaseKey> kCurrencyItemLock =
{
    { 29434, {2,1} }, // Badge of Justice
    { 40752, {3,1} }, // Emblem of Heroism
    { 40753, {3,1} }, // Emblem of Valor
    { 45624, {3,2} }, // Emblem of Conquest
    { 47241, {3,3} }, // Emblem of Triumph
    { 49426, {3,4} }, // Emblem of Frost
};

// ---------------------------------------------------------------------------
// Config
// ---------------------------------------------------------------------------

struct ProgConfig
{
    bool    enabled             = true;
    uint8   era                 = 1;
    uint8   phase               = 1;
    bool    gmBypass            = true;
    bool    loginAnnouncement   = true;
    bool    lockInstances       = true;
    bool    lockMaps            = true;
    bool    lockBattlegrounds   = true;
    bool    lockLFG             = true;
    bool    lockWorldBosses     = true;
    bool    lockVendors         = true;
    bool    teleportOutLocked   = true;
    bool    debug               = false;
};

ProgConfig gCfg;

// ---------------------------------------------------------------------------
// Core helpers
// ---------------------------------------------------------------------------

bool IsUnlocked(uint8 reqEra, uint8 reqPhase)
{
    if (gCfg.era != reqEra)
        return gCfg.era > reqEra;
    return gCfg.phase >= reqPhase;
}

uint8 GetLevelCap()
{
    if (gCfg.era >= 3)
        return 80;
    if (gCfg.era == 2)
        return 70;
    // Era 1: phase 1-4 have individual caps, phase 5+ all 60
    static constexpr uint8 caps[] = { 0, 19, 29, 39, 49, 60, 60, 60, 60 };
    return caps[std::min<uint8>(gCfg.phase, 8)];
}

std::string GetPhaseName()
{
    static const char* eraNames[] = { "", "Azeroth", "Outland", "Northrend" };
    uint8 era = std::min<uint8>(gCfg.era, 3);
    return Acore::StringFormat("{} Era — Phase {}", eraNames[era], uint32(gCfg.phase));
}

bool IsInstanceLocked(uint32 mapId)
{
    auto it = kInstanceLock.find(mapId);
    if (it == kInstanceLock.end())
        return false;
    return !IsUnlocked(it->second.era, it->second.phase);
}

bool IsMapLocked(uint32 mapId)
{
    auto it = kMapLock.find(mapId);
    if (it == kMapLock.end())
        return false;
    return !IsUnlocked(it->second.era, it->second.phase);
}

void TeleportToHomebind(Player* player)
{
    player->TeleportTo(player->m_homebindMapId,
                       player->m_homebindX,
                       player->m_homebindY,
                       player->m_homebindZ,
                       0.0f);
}

void LoadConfig()
{
    gCfg = {};

    gCfg.enabled = sConfigMgr->GetOption<bool>("Nostrum.Progression.Enable", true);

    uint32 era = sConfigMgr->GetOption<uint32>("Nostrum.Progression.Era", 1);
    if (era < 1 || era > 3)
    {
        LOG_WARN("module", ">> NostrumProgression: Era {} out of range [1-3], using 1", era);
        era = 1;
    }
    gCfg.era = static_cast<uint8>(era);

    uint32 phase = sConfigMgr->GetOption<uint32>("Nostrum.Progression.Phase", 1);
    if (phase < 1)
        phase = 1;
    gCfg.phase = static_cast<uint8>(phase);

    gCfg.gmBypass          = sConfigMgr->GetOption<bool>("Nostrum.Progression.GmBypass",                       true);
    gCfg.loginAnnouncement = sConfigMgr->GetOption<bool>("Nostrum.Progression.LoginAnnouncement",               true);
    gCfg.lockInstances     = sConfigMgr->GetOption<bool>("Nostrum.Progression.LockInstances",                   true);
    gCfg.lockMaps          = sConfigMgr->GetOption<bool>("Nostrum.Progression.LockMaps",                        true);
    gCfg.lockBattlegrounds = sConfigMgr->GetOption<bool>("Nostrum.Progression.LockBattlegrounds",               true);
    gCfg.lockLFG           = sConfigMgr->GetOption<bool>("Nostrum.Progression.LockLFG",                         true);
    gCfg.lockWorldBosses   = sConfigMgr->GetOption<bool>("Nostrum.Progression.LockWorldBosses",                 true);
    gCfg.lockVendors       = sConfigMgr->GetOption<bool>("Nostrum.Progression.LockVendors",                     true);
    gCfg.teleportOutLocked = sConfigMgr->GetOption<bool>("Nostrum.Progression.TeleportOutOfLockedMapsOnLogin",  true);
    gCfg.debug             = sConfigMgr->GetOption<bool>("Nostrum.Progression.Debug",                           false);

    LOG_INFO("module", ">> NostrumProgression: {} — cap {} — enabled={} era={} phase={}",
        GetPhaseName(), uint32(GetLevelCap()), gCfg.enabled, uint32(gCfg.era), uint32(gCfg.phase));
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
            PLAYERHOOK_ON_BEFORE_TELEPORT,
            PLAYERHOOK_CAN_ENTER_MAP,
            PLAYERHOOK_CAN_JOIN_IN_BATTLEGROUND_QUEUE,
            PLAYERHOOK_CAN_BATTLEFIELD_PORT,
            PLAYERHOOK_CAN_JOIN_LFG,
            PLAYERHOOK_ON_BEFORE_BUY_ITEM_FROM_VENDOR,
        })
    {
    }

    // -----------------------------------------------------------------------
    // Login — level cap + teleport out of locked continents/instances
    // -----------------------------------------------------------------------

    void OnPlayerLogin(Player* player) override
    {
        if (!gCfg.enabled)
            return;

        uint8 cap = GetLevelCap();

        if (IsExempt(player))
        {
            if (gCfg.loginAnnouncement)
                ChatHandler(player->GetSession()).PSendSysMessage(
                    "[NostrumWoW] {} — Level cap: {} (GM bypass active)", GetPhaseName(), uint32(cap));
            return;
        }

        if (player->GetLevel() > cap)
            EnforceCap(player, cap);

        if (gCfg.loginAnnouncement)
            ChatHandler(player->GetSession()).PSendSysMessage(
                "[NostrumWoW] {} — Current level cap: {}", GetPhaseName(), uint32(cap));

        uint32 mapId = player->GetMapId();

        if (gCfg.lockMaps && IsMapLocked(mapId))
        {
            ChatHandler(player->GetSession()).SendSysMessage(
                "[NostrumWoW] You have been moved — this area is locked until a later Nostrum Era.");
            TeleportToHomebind(player);
            return;
        }

        if (gCfg.lockInstances && gCfg.teleportOutLocked && IsInstanceLocked(mapId))
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

        uint8 cap = GetLevelCap();
        if (player->GetLevel() > cap)
            EnforceCap(player, cap);
    }

    // -----------------------------------------------------------------------
    // XP gate
    // -----------------------------------------------------------------------

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 /*xpSource*/) override
    {
        if (!gCfg.enabled || IsExempt(player))
            return;

        if (player->GetLevel() >= GetLevelCap())
            amount = 0;
    }

    // -----------------------------------------------------------------------
    // Continent / map teleport gate
    // Covers: Dark Portal, boats, zeppelins, portals, hearthstone, summons.
    // -----------------------------------------------------------------------

    bool OnPlayerBeforeTeleport(Player* player, uint32 mapId, float /*x*/, float /*y*/,
                                float /*z*/, float /*orientation*/, uint32 /*options*/,
                                Unit* /*target*/) override
    {
        if (!gCfg.lockMaps || IsExempt(player))
            return true;

        if (!IsMapLocked(mapId))
            return true;

        if (gCfg.debug)
            LOG_INFO("module.nostrum.progression",
                "Map teleport blocked: player={} mapId={} era={} phase={}",
                player->GetName(), mapId, uint32(gCfg.era), uint32(gCfg.phase));

        ChatHandler(player->GetSession()).SendSysMessage(
            "[NostrumWoW] This area is locked until a later Nostrum Era.");
        return false;
    }

    // -----------------------------------------------------------------------
    // Instance map entry gate
    // -----------------------------------------------------------------------

    bool OnPlayerCanEnterMap(Player* player, MapEntry const* entry,
                             InstanceTemplate const* /*instance*/,
                             MapDifficulty const* /*mapDiff*/,
                             bool /*loginCheck*/) override
    {
        if (!gCfg.lockInstances || IsExempt(player))
            return true;

        uint32 mapId   = entry->MapID;
        bool   locked  = IsInstanceLocked(mapId);

        if (gCfg.debug)
        {
            auto it        = kInstanceLock.find(mapId);
            uint8 reqEra   = it != kInstanceLock.end() ? it->second.era   : 0;
            uint8 reqPhase = it != kInstanceLock.end() ? it->second.phase : 0;
            LOG_INFO("module.nostrum.progression",
                "Instance entry check: player={} mapId={} required=({},{}) current=({},{}) locked={}",
                player->GetName(), mapId, uint32(reqEra), uint32(reqPhase),
                uint32(gCfg.era), uint32(gCfg.phase), locked);
        }

        if (locked)
            ChatHandler(player->GetSession()).SendSysMessage(
                "[NostrumWoW] This instance is locked until a later progression phase.");

        return !locked;
    }

    // -----------------------------------------------------------------------
    // Battleground queue gate
    // -----------------------------------------------------------------------

    bool OnPlayerCanJoinInBattlegroundQueue(Player* player, ObjectGuid /*bmGuid*/,
                                            BattlegroundTypeId bgTypeId, uint8 /*joinAsGroup*/,
                                            GroupJoinBattlegroundResult& /*err*/) override
    {
        if (!gCfg.lockBattlegrounds || IsExempt(player))
            return true;

        auto it = kBattlegroundLock.find(static_cast<uint32>(bgTypeId));
        if (it == kBattlegroundLock.end())
            return true;

        bool allowed = IsUnlocked(it->second.era, it->second.phase);

        if (gCfg.debug)
            LOG_INFO("module.nostrum.progression",
                "BG queue check: player={} bgType={} required=({},{}) allowed={}",
                player->GetName(), uint32(bgTypeId),
                uint32(it->second.era), uint32(it->second.phase), allowed);

        if (!allowed)
            ChatHandler(player->GetSession()).SendSysMessage(
                "[NostrumWoW] This battleground is locked until a later progression phase.");

        return allowed;
    }

    // Second-layer defence: catches port-in after a phase change.
    bool OnPlayerCanBattleFieldPort(Player* player, uint8 /*arenaType*/,
                                    BattlegroundTypeId bgTypeId, uint8 /*action*/) override
    {
        if (!gCfg.lockBattlegrounds || IsExempt(player))
            return true;

        auto it = kBattlegroundLock.find(static_cast<uint32>(bgTypeId));
        if (it == kBattlegroundLock.end())
            return true;

        bool allowed = IsUnlocked(it->second.era, it->second.phase);

        if (!allowed)
            ChatHandler(player->GetSession()).SendSysMessage(
                "[NostrumWoW] This battleground is locked until a later progression phase.");

        return allowed;
    }

    // -----------------------------------------------------------------------
    // LFG / Dungeon Finder gate
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

            uint32 mapId  = dungeon->MapID;
            bool   locked = IsInstanceLocked(mapId);

            if (gCfg.debug)
            {
                auto it        = kInstanceLock.find(mapId);
                uint8 reqEra   = it != kInstanceLock.end() ? it->second.era   : 0;
                uint8 reqPhase = it != kInstanceLock.end() ? it->second.phase : 0;
                LOG_INFO("module.nostrum.progression",
                    "LFG check: player={} dungeonId={} mapId={} required=({},{}) locked={}",
                    player->GetName(), dungeonId, mapId,
                    uint32(reqEra), uint32(reqPhase), locked);
            }

            if (locked)
            {
                ChatHandler(player->GetSession()).SendSysMessage(
                    "[NostrumWoW] One or more selected dungeons are locked until a later progression phase.");
                return false;
            }
        }

        return true;
    }

    // -----------------------------------------------------------------------
    // Vendor currency item gate (badge/emblem purchases)
    // -----------------------------------------------------------------------

    void OnPlayerBeforeBuyItemFromVendor(Player* player, ObjectGuid /*vendorGuid*/,
                                         uint32 /*vendorSlot*/, uint32& itemEntry,
                                         uint8 /*count*/, uint8 /*bag*/, uint8 /*slot*/) override
    {
        if (!gCfg.lockVendors || IsExempt(player))
            return;

        auto it = kCurrencyItemLock.find(itemEntry);
        if (it == kCurrencyItemLock.end())
            return;

        if (IsUnlocked(it->second.era, it->second.phase))
            return;

        ChatHandler(player->GetSession()).SendSysMessage(
            "[NostrumWoW] This currency is locked until a later Nostrum phase.");
        itemEntry = 0; // cancel the purchase
    }

private:
    bool IsExempt(Player* player) const
    {
        return gCfg.gmBypass && player->GetSession()->GetSecurity() >= SEC_GAMEMASTER;
    }

    void EnforceCap(Player* player, uint8 cap) const
    {
        player->GiveLevel(cap);
        player->SetUInt32Value(PLAYER_XP, 0);
        ChatHandler(player->GetSession()).PSendSysMessage(
            "[NostrumWoW] The current Nostrum phase is capped at level {}.", uint32(cap));
    }
};

// ---------------------------------------------------------------------------
// AllCreatureScript — world boss spawn prevention
// ---------------------------------------------------------------------------

class NostrumProgressionCreatureScript : public AllCreatureScript
{
public:
    NostrumProgressionCreatureScript() : AllCreatureScript("NostrumProgressionCreatureScript") {}

    void OnCreatureAddWorld(Creature* creature) override
    {
        if (!gCfg.enabled || !gCfg.lockWorldBosses)
            return;

        auto it = kWorldBossLock.find(creature->GetEntry());
        if (it == kWorldBossLock.end())
            return;

        if (IsUnlocked(it->second.era, it->second.phase))
            return;

        LOG_INFO("module.nostrum.progression",
            "NostrumProgression: despawning locked world boss entry={} current=({},{})",
            creature->GetEntry(), uint32(gCfg.era), uint32(gCfg.phase));

        // Use a long forced respawn so it doesn't spam-respawn every few seconds.
        // When the phase advances, an admin can respawn manually via `.npc respawn`.
        creature->DespawnOrUnsummon(0ms, Seconds(7 * 24 * 3600));
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_progressionScripts()
{
    new NostrumProgressionWorldScript();
    new NostrumProgressionPlayerScript();
    new NostrumProgressionCreatureScript();
}
