-- Despawn hostile Burning Legion creatures camped around the Dark Portal
-- on both the Azeroth (Blasted Lands) and Outland (Hellfire Peninsula) sides.
--
-- These spawns turn the portal stairs into a corpse run for any fresh L58
-- character stepping through for the first time. On a hardcore (one-life)
-- realm that is permadeath-by-geography rather than gameplay, so we clear
-- the immediate combat zone on both pads. Honor Hold, Thrallmar, Sons of
-- Lothar, and Nethergarde guards remain - the portal still feels defended,
-- just no longer surrounded by aggressive elites.
--
-- Position filters constrain the delete to the actual Stair of Destiny
-- area on each map; the creature ID lists are also each-portal-only in
-- stock data, but the position filter is defence-in-depth in case
-- upstream ever moves the entries elsewhere.
--
-- AZEROTH side (map 0, around the Dark Portal at -11840,-3197):
--   6010 Felhound            (lvl 54-55 elite, faction 90) - 7 spawns
--   6011 Felguard Sentry     (lvl 54-55 elite, faction 90) - 6 spawns
--   7668 Servant of Razelikh (lvl 57    elite, faction 90) - 6 spawns
--   Filter: within 250yd of the portal entrance.
--
-- OUTLAND side (map 530, around the Stair of Destiny at -247,911):
--   16959 Dread Tactician     (lvl 70    elite, faction 1752) - 2 spawns
--   18977 Felguard Destroyer  (lvl 60    elite, faction 90)   - 3 spawns
--   19005 Wrath Master        (lvl 71    elite, faction 1754) - 2 spawns
--   19299 Deathwhisperer      (lvl 69-70 elite, faction 1752) - 5 spawns
--   Filter: within 800yd of the portal landing (covers the full ramp).
--
-- Total: 31 creature spawns removed plus their creature_addon rows.

-- Clear addon rows first so we don't leave orphans.
DELETE FROM `creature_addon` WHERE `guid` IN (
    SELECT `guid` FROM `creature`
    WHERE (`map` = 0
           AND `id1` IN (6010, 6011, 7668)
           AND POW(`position_x` - (-11840), 2) + POW(`position_y` - (-3197), 2) < POW(250, 2))
       OR (`map` = 530
           AND `id1` IN (16959, 18977, 19005, 19299)
           AND POW(`position_x` - (-247), 2) + POW(`position_y` - 911, 2) < POW(800, 2))
);

DELETE FROM `creature`
WHERE (`map` = 0
       AND `id1` IN (6010, 6011, 7668)
       AND POW(`position_x` - (-11840), 2) + POW(`position_y` - (-3197), 2) < POW(250, 2))
   OR (`map` = 530
       AND `id1` IN (16959, 18977, 19005, 19299)
       AND POW(`position_x` - (-247), 2) + POW(`position_y` - 911, 2) < POW(800, 2));
