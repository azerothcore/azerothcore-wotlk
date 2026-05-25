-- Clear the Burning Legion ambush at the Dark Portal on both sides.
--
-- On a hardcore (one-life) realm, walking through the Dark Portal at the
-- minimum level 58 means stepping straight into level 60-71 elite demons,
-- a SmartAI summon chain that keeps respawning a fresh ring of Wrath
-- Masters and Fel Soldiers, and a portal-event that has Alliance/Horde
-- NPCs running into the same meatgrinder. None of that is fun on a one-
-- life realm. We strip the immediate combat zone but leave Honor Hold,
-- Thrallmar, Sons of Lothar, Nethergarde, and the formation-staged
-- defenders standing, so the portal still feels defended.
--
-- This migration removes the offending spawns in three groups.
--
-- 1) AZEROTH side static spawns (map 0, around the portal at -11840,-3197):
--      6010 Felhound            (54-55 elite) x7 spawns
--      6011 Felguard Sentry     (54-55 elite) x6 spawns
--      7668 Servant of Razelikh (57    elite) x6 spawns
--    Filter: within 250yd of the portal entrance.
--
-- 2) OUTLAND side static spawns (map 530, around the portal at -247,911):
--      16959 Dread Tactician     (70    elite) x2 spawns
--      18977 Felguard Destroyer  (60    elite) x3 spawns (within 800yd)
--      19005 Wrath Master        (71    elite) x4 spawns - all four, not
--                                              just the ones within 800yd
--                                              (entry only used at the
--                                              Stair of Destiny, so wiping
--                                              the entry by map is safe)
--      19299 Deathwhisperer      (69-70 elite) x5 spawns (within 800yd)
--
-- 3) OUTLAND side event triggers (map 530) - these are the actual reason
--    Wrath Masters and Fel Soldiers keep returning even after the static
--    despawns above. Each Infernal Relay's SmartAI summons 2x Wrath Master
--    + 8x Fel Soldier on creation, on a 600s respawn loop, so leaving the
--    relays in place re-spawns the entire ambush every ten minutes.
--      19215 Infernal Relay (Hellfire)              x2 - source of the SAI
--                                                       summon chain
--      21075 Infernal Target (Hyjal)                x2 - casts the Infernal
--                                                       visual onto the
--                                                       relays
--      18967 Dark Assault - Alliance Portal Stalker x1 - triggers Alliance
--                                                       NPCs running out
--                                                       of the portal
--      18968 Dark Assault - Horde Portal Stalker    x1 - triggers Horde
--                                                       NPCs running out
--                                                       of the portal
--    Position filter (within 250yd of the portal) restricts each ID-based
--    delete to the Stair of Destiny instance, in case any of these entries
--    get reused elsewhere in future upstream data.
--
-- creature_addon rows for the affected GUIDs are cleared first to avoid
-- orphans. No game_event_creature, pool_creature, or linked_respawn rows
-- reference these GUIDs.

-- ===== Clean creature_addon rows for everything we are about to remove =====
DELETE FROM `creature_addon` WHERE `guid` IN (
    SELECT `guid` FROM `creature`
    WHERE -- Group 1: Azeroth side
          (`map` = 0
           AND `id1` IN (6010, 6011, 7668)
           AND POW(`position_x` - (-11840), 2)
             + POW(`position_y` - (-3197), 2) < POW(250, 2))
       -- Group 2: Outland side, static elite demons
       OR (`map` = 530
           AND `id1` IN (16959, 18977, 19299)
           AND POW(`position_x` - (-247), 2)
             + POW(`position_y` -    911,  2) < POW(800, 2))
       -- Group 2b: Wrath Master - wipe all four on map 530 (entry is
       -- only used at the Stair of Destiny)
       OR (`map` = 530 AND `id1` = 19005)
       -- Group 3: event triggers within 250yd of the portal landing
       OR (`map` = 530
           AND `id1` IN (18967, 18968, 19215, 21075)
           AND POW(`position_x` - (-247), 2)
             + POW(`position_y` -    911,  2) < POW(250, 2))
);

-- ===== Remove the spawns themselves =====
DELETE FROM `creature`
WHERE -- Group 1: Azeroth side
      (`map` = 0
       AND `id1` IN (6010, 6011, 7668)
       AND POW(`position_x` - (-11840), 2)
         + POW(`position_y` - (-3197), 2) < POW(250, 2))
   -- Group 2: Outland side, static elite demons
   OR (`map` = 530
       AND `id1` IN (16959, 18977, 19299)
       AND POW(`position_x` - (-247), 2)
         + POW(`position_y` -    911,  2) < POW(800, 2))
   -- Group 2b: all Wrath Master spawns on map 530
   OR (`map` = 530 AND `id1` = 19005)
   -- Group 3: event triggers within 250yd of the portal landing
   OR (`map` = 530
       AND `id1` IN (18967, 18968, 19215, 21075)
       AND POW(`position_x` - (-247), 2)
         + POW(`position_y` -    911,  2) < POW(250, 2));
