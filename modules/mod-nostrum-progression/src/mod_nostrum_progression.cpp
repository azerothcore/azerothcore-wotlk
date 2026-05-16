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
 *   Azeroth Phase 1: 19 | Phase 2: 29 | Phase 3: 39 | Phase 4: 49 | Phase 5: 59 | Phase 6+: 60
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
#include "AccountMgr.h"
#include "AccountScript.h"
#include "AreaTriggerScript.h"
#include "Chat.h"
#include "GameObject.h"
#include "AllGameObjectScript.h"
#include "Common.h"
#include "Config.h"
#include "Creature.h"
#include "DBCStores.h"
#include "LFGMgr.h"
#include "MapMgr.h"
#include "Player.h"
#include "PlayerScript.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "WorldScript.h"

#include <unordered_map>
#include <unordered_set>

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
    {  48, {1,1} }, // Blackfathom Deeps

    // ---- Era 1, Phase 2 (cap 29) ----
    {  34, {1,2} }, // Stormwind Stockade
    {  90, {1,2} }, // Gnomeregan
    {  47, {1,2} }, // Razorfen Kraul
    // Scarlet Monastery (base; wings gated individually via kAreaTriggerLock)
    { 189, {1,2} }, // - Graveyard, Library, Armory, Cathedral

    // ---- Era 1, Phase 3 (cap 39) ----
    { 129, {1,3} }, // Razorfen Downs
    {  70, {1,3} }, // Uldaman

    // ---- Era 1, Phase 4 (cap 49) ----
    { 209, {1,4} }, // Zul'Farrak
    { 349, {1,4} }, // Maraudon
    { 109, {1,4} }, // Sunken Temple
    { 230, {1,4} }, // Blackrock Depths (base; Upper City gated via kGameObjectLock)

    // ---- Era 1, Phase 5 — Road to 59  ----
    { 229, {1,5} }, // Blackrock Spire (LBRS/UBRS)
    { 429, {1,5} }, // Dire Maul
    { 329, {1,5} }, // Stratholme
    { 289, {1,5} }, // Scholomance

    // ---- Era 1, Phase 6 — Vanilla endgame ----
    { 409, {1,6} }, // Molten Core

    // ---- Era 1, Phase 7 — Blackwing Lair & Zul'Gurub ----
    { 469, {1,7} }, // Blackwing Lair
    { 309, {1,7} }, // Zul'Gurub

    // ---- Era 1, Phase 8 — Ahn'Qiraj ----
    { 509, {1,8} }, // Ruins of Ahn'Qiraj (AQ20)
    { 531, {1,8} }, // Temple of Ahn'Qiraj (AQ40)

    // ---- Era 2, Phase 1 — Road to 69 ----

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

    // ---- Era 2, Phase 2 — Karazhan, Gruul & Magtheridon ----
    { 532, {2,2} }, // Karazhan
    { 544, {2,2} }, // Magtheridon's Lair
    { 565, {2,2} }, // Gruul's Lair

    // ---- Era 2, Phase 3 — Serpentshrine & Tempest Keep ----
    { 548, {2,3} }, // Coilfang: Serpentshrine Cavern
    { 550, {2,3} }, // Tempest Keep / The Eye

    // ---- Era 2, Phase 4 — Mount Hyjal & Black Temple ----
    { 585, {2,4} }, // Magister's Terrace
    { 534, {2,4} }, // The Battle for Mount Hyjal
    { 564, {2,4} }, // Black Temple
    { 568, {2,4} }, // Zul'Aman

    // ---- Era 2, Phase 5 — Sunwell ----
    { 580, {2,5} }, // Sunwell Plateau

    // ---- Era 3, Phase 1 — WotLK dungeons ----
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

    // ---- Era 3, Phase 2 — Naxxramas, Obsidian Sanctum & Eye of Eternity ----
    { 533, {3,2} }, // Naxxramas
    { 615, {3,2} }, // The Obsidian Sanctum
    { 616, {3,2} }, // The Eye of Eternity
    { 624, {3,2} }, // Vault of Archavon

    // ---- Era 3, Phase 3 — Ulduar ----
    { 603, {3,3} }, // Ulduar

    // ---- Era 3, Phase 4 — Trial of the Crusader & Onyxia 80 ----
    { 650, {3,4} }, // Trial of the Champion
    { 649, {3,4} }, // Trial of the Crusader
    { 249, {3,4} }, // Onyxia's Lair (level 60 + level 80 — both gated at Northrend Phase 4)

    // ---- Era 3, Phase 5 — Icecrown & Ruby Sanctum ----
    { 632, {3,5} }, // The Forge of Souls
    { 658, {3,5} }, // Pit of Saron
    { 668, {3,5} }, // Halls of Reflection
    { 631, {3,5} }, // Icecrown Citadel
    { 724, {3,5} }, // The Ruby Sanctum
};

// ---------------------------------------------------------------------------
// Continent/map lock table  (map ID → minimum era/phase required)
// ---------------------------------------------------------------------------

static const std::unordered_map<uint32, EraPhaseKey> kMapLock =
{
    { 530, {2,1} }, // Outland (also contains Blood Elf/Draenei starting zones — see kMap530StartingZones)
    { 571, {3,1} }, // Northrend
    { 609, {3,1} }, // Death Knight starting zone
};

// Map 530 contains both Outland and the TBC starting zones. These zones are
// part of the base game and must remain accessible during Azeroth Era.
static const std::unordered_set<uint32> kMap530StartingZones =
{
    3430, // Eversong Woods
    3433, // Ghostlands
    3487, // Silvermoon City
    3479, // Ammen Vale (Azuremyst dock/coastal area)
    3524, // Azuremyst Isle
    3525, // Bloodmyst Isle
    3557, // The Exodar
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
    {  6109, {1,6} }, // Azuregos
    { 12397, {1,6} }, // Lord Kazzak
    { 14887, {1,6} }, // Ysondre (Dragon of Nightmare)
    { 14888, {1,6} }, // Lethon  (Dragon of Nightmare)
    { 14889, {1,6} }, // Emeriss (Dragon of Nightmare)
    { 14890, {1,6} }, // Taerar  (Dragon of Nightmare)
    { 18728, {2,2} }, // Doom Lord Kazzak
    { 17711, {2,2} }, // Doomwalker
};

// ---------------------------------------------------------------------------
// Currency item lock table  (item entry → minimum era/phase required)
// ---------------------------------------------------------------------------

static const std::unordered_map<uint32, EraPhaseKey> kCurrencyItemLock =
{
    { 29434, {2,2} }, // Badge of Justice

    { 40752, {3,2} }, // Emblem of Heroism
    { 40753, {3,2} }, // Emblem of Valor
    { 45624, {3,3} }, // Emblem of Conquest
    { 47241, {3,4} }, // Emblem of Triumph
    { 49426, {3,5} }, // Emblem of Frost
};

// ---------------------------------------------------------------------------
// Area trigger lock table  (AreaTrigger entry → minimum era/phase required)
//
// Used for instances that share a map ID but have wing-specific entry portals.
// Each entry is the AreaTrigger from areatrigger_teleport.sql.
// ---------------------------------------------------------------------------

static const std::unordered_map<uint32, EraPhaseKey> kAreaTriggerLock =
{
    //  45 = Scarlet Monastery — Graveyard entrance
    { 45,  {1,2} },
    // 614 = Scarlet Monastery — Library entrance
    { 614, {1,3} },
    // 612 = Scarlet Monastery — Armory entrance
    { 612, {1,3} },
    // 610 = Scarlet Monastery — Cathedral entrance
    { 610, {1,3} },
};

// ---------------------------------------------------------------------------
// GameObject lock table  (GO entry → minimum era/phase required)
//
// Used for doors/gates inside instances where multiple progression sections
// share the same map ID. Blocking is done via OnGossipHello, which fires
// before any type-specific handling in GameObject::Use().
//
// Bound to GOs via gameobject_template.ScriptName = 'nostrum_progression_go'.
// See: data/sql/custom/db_world/nostrum_progression_go_scripts.sql
//
// HOW TO FIND BRD DOOR ENTRIES
// Log in as GM inside Blackrock Depths and use:
//   .go object near 20
// to list nearby game objects with their GUIDs and entries.
// Cross-reference with `SELECT entry, name FROM gameobject_template WHERE entry = <X>;`
//
// BRD layout for reference:
//   Prison section  → accessible from Phase 4 (covered by kInstanceLock {1,4})
//   Upper City      → deeper routes past the Shadowforge Lock and beyond
//                     (gates, doors, portcullises leading toward Lord Incendius,
//                      Golem Lord Argelmach, Emperor Dagran Thaurissan)
// ---------------------------------------------------------------------------

static const std::unordered_map<uint32, EraPhaseKey> kGameObjectLock =
{
    // TODO: Add BRD Upper City gate/door GO entries here after testing in-game.
    //
    // Candidates to inspect with `.go object near 20` near the Prison→Upper City
    // boundary (the Shadowforge Lock corridor area):
    //
    //   { <entry>, {1,5} }, // Shadowforge Lock / gate to Upper BRD
    //   { <entry>, {1,5} }, // Portcullis / door deeper into Upper City
    //
    // Leave this empty until entries are confirmed — an empty map means no GOs
    // are blocked and the SQL file is a no-op until entries are populated.
    //
    { 170559, {1,5} }, // Shadowforge Gate - BRD Prison -> deeper BRD / Upper City
    { 170560, {1,5} }, // Shadowforge Gate - paired gate object
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

// Tracked GOs whose GO_FLAG_NOT_SELECTABLE we toggled based on phase.
// Used by config-reload to refresh flags when era/phase changes.
std::unordered_set<GameObject*> gTrackedLockedGOs;

// ---------------------------------------------------------------------------
// Core helpers
// ---------------------------------------------------------------------------

bool IsUnlocked(uint8 reqEra, uint8 reqPhase)
{
    if (gCfg.era != reqEra)
        return gCfg.era > reqEra;
    return gCfg.phase >= reqPhase;
}

// Apply or remove GO_FLAG_NOT_SELECTABLE based on current phase.
// Returns true if the GO is locked (flag was applied).
bool ApplyGOLock(GameObject* go)
{
    auto it = kGameObjectLock.find(go->GetEntry());
    if (it == kGameObjectLock.end())
        return false;

    if (IsUnlocked(it->second.era, it->second.phase))
    {
        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
        return false;
    }

    go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
    return true;
}

// Refresh all tracked GOs after a config reload.
void RefreshLockedGOs()
{
    // Erase destroyed/invalid GOs, then reapply flags.
    for (auto it = gTrackedLockedGOs.begin(); it != gTrackedLockedGOs.end(); )
    {
        if (!*it || !(*it)->IsInWorld())
        {
            it = gTrackedLockedGOs.erase(it);
            continue;
        }
        ApplyGOLock(*it);
        ++it;
    }
}

uint8 GetLevelCap()
{
    if (gCfg.era >= 3)
        return 80;
    if (gCfg.era == 2)
        return 70;
    // Era 1: phase 1-4 have individual caps, phase 5=59, phase 6+ all 60
    static constexpr uint8 caps[] = { 0, 19, 29, 39, 49, 59, 60, 60, 60 };
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

// Returns true if the player is on map 530 in a Blood Elf/Draenei starting
// zone that must stay accessible regardless of the Outland era lock.
bool IsInMap530StartingZone(Player* player)
{
    return player->GetMapId() == 530 &&
           kMap530StartingZones.count(player->GetZoneId()) > 0;
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
        {
            RefreshLockedGOs();
            LOG_INFO("module", ">> NostrumProgression: config reloaded");
        }
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

        if (gCfg.lockMaps && IsMapLocked(mapId) && !IsInMap530StartingZone(player))
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

    bool OnPlayerBeforeTeleport(Player* player, uint32 mapId, float x, float y,
                                float z, float /*orientation*/, uint32 /*options*/,
                                Unit* /*target*/) override
    {
        if (!gCfg.lockMaps || IsExempt(player))
            return true;

        if (!IsMapLocked(mapId))
            return true;

        // Map 530 contains Blood Elf/Draenei starting zones alongside Outland.
        // Allow teleports whose destination zone is a starting zone (covers boat
        // travel from Darkshore, graveyard respawns, hearthstones, etc.).
        // If the zone lookup returns 0 (map not yet loaded), allow rather than block
        // to avoid false-positives on boat/transport travel.
        if (mapId == 530)
        {
            uint32 destZone = sMapMgr->GetZoneId(player->GetPhaseMaskForSpawn(), mapId, x, y, z);
            if (gCfg.debug)
                LOG_INFO("module.nostrum.progression",
                    "Map 530 teleport: player={} destZone={} x={:.1f} y={:.1f} z={:.1f}",
                    player->GetName(), destZone, x, y, z);
            if (destZone == 0 || kMap530StartingZones.count(destZone))
                return true;
        }

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
// AllGameObjectScript — in-instance door/gate locks
//
// OnGameObjectAddWorld sets GO_FLAG_NOT_SELECTABLE on locked doors so the
// client never offers an interaction (no progress bar, no click).  This is
// the only reliable way to block GAMEOBJECT_TYPE_DOOR — OnGossipHello fires
// too late (after the client-side progress bar completes).
//
// CanGameObjectGossipHello is kept as a safety net: if the flag is somehow
// bypassed, it still sends the lock message and blocks Use().
// ---------------------------------------------------------------------------

class NostrumProgressionGameObjectScript : public AllGameObjectScript
{
public:
    NostrumProgressionGameObjectScript() : AllGameObjectScript("NostrumProgressionGameObjectScript") {}

    void OnGameObjectAddWorld(GameObject* go) override
    {
        if (!gCfg.enabled || !gCfg.lockInstances)
            return;

        if (kGameObjectLock.find(go->GetEntry()) == kGameObjectLock.end())
            return;

        // Always track so RefreshLockedGOs can toggle on config reload.
        gTrackedLockedGOs.insert(go);

        if (ApplyGOLock(go))
        {
            LOG_INFO("module.nostrum.progression",
                "NostrumProgression: locked GO entry={} current=({},{})",
                go->GetEntry(), uint32(gCfg.era), uint32(gCfg.phase));
        }
    }

    void OnGameObjectRemoveWorld(GameObject* go) override
    {
        gTrackedLockedGOs.erase(go);
    }

    bool CanGameObjectGossipHello(Player* player, GameObject* go) override
    {
        if (!gCfg.enabled || !gCfg.lockInstances)
            return false;

        if (gCfg.gmBypass && player->GetSession()->GetSecurity() >= SEC_GAMEMASTER)
            return false;

        auto it = kGameObjectLock.find(go->GetEntry());
        if (it == kGameObjectLock.end())
            return false;

        if (IsUnlocked(it->second.era, it->second.phase))
            return false;

        ChatHandler(player->GetSession()).SendSysMessage(
            "[NostrumWoW] This path unlocks in a later progression phase.");
        return true; // block — safety net if GO_FLAG_NOT_SELECTABLE was bypassed
    }
};

// ---------------------------------------------------------------------------
// AccountScript — block Death Knight creation before Era 3 Phase 1
// ---------------------------------------------------------------------------

class NostrumProgressionAccountScript : public AccountScript
{
public:
    NostrumProgressionAccountScript() : AccountScript("NostrumProgressionAccountScript",
        { ACCOUNTHOOK_CAN_ACCOUNT_CREATE_CHARACTER })
    {
    }

    bool CanAccountCreateCharacter(uint32 accountId, uint8 /*charRace*/, uint8 charClass) override
    {
        if (!gCfg.enabled)
            return true;

        if (charClass != CLASS_DEATH_KNIGHT)
            return true;

        if (gCfg.gmBypass && AccountMgr::GetSecurity(accountId) >= SEC_GAMEMASTER)
            return true;

        if (IsUnlocked(3, 1))
            return true;

        LOG_INFO("module.nostrum.progression",
            "NostrumProgression: DK creation blocked for account={} current=({},{})",
            accountId, uint32(gCfg.era), uint32(gCfg.phase));

        return false; // CHAR_CREATE_DISABLED sent to client
    }
};

// ---------------------------------------------------------------------------
// AreaTriggerScript — wing-specific instance entrance gates
// ---------------------------------------------------------------------------

class NostrumProgressionAreaTriggerScript : public AreaTriggerScript
{
public:
    NostrumProgressionAreaTriggerScript() : AreaTriggerScript("nostrum_progression_at") {}

    bool OnTrigger(Player* player, AreaTrigger const* trigger) override
    {
        if (!gCfg.enabled || !gCfg.lockInstances)
            return false;

        if (gCfg.gmBypass && player->GetSession()->GetSecurity() >= SEC_GAMEMASTER)
            return false;

        auto it = kAreaTriggerLock.find(trigger->entry);
        if (it == kAreaTriggerLock.end())
            return false;

        if (IsUnlocked(it->second.era, it->second.phase))
            return false;

        ChatHandler(player->GetSession()).SendSysMessage(
            "[NostrumWoW] This wing is locked until a later progression phase.");
        return true; // block default portal teleport
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
    new NostrumProgressionGameObjectScript();
    new NostrumProgressionAccountScript();
    new NostrumProgressionAreaTriggerScript();
}
