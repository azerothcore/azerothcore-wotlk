-- Gundrak
-- Level 76-78 originally
-- map 604

-- NHC
-- update creature_template set minlevel = (minlevel + 50)  where entry in (select id1 from creature where map = 604);
-- update creature_template set maxlevel = (maxlevel + 50) where entry in (select id1 from creature where map = 604);

-- HC
-- select difficulty_entry_1 as entry from creature_template where entry in (select id1 from creature where map = 604);

-- update creature_template set minlevel = (minlevel + 50) where entry in (30942, 30941, 31370, 30530, 31368, 30932, 31365, 30929, 30927, 30933, 30926, 30938, 30930, 30928, 30935, 30931, 30937, 32778, 30939, 30936);
-- update creature_template set maxlevel = (maxlevel + 50) where entry in (30942, 30941, 31370, 30530, 31368, 30932, 31365, 30929, 30927, 30933, 30926, 30938, 30930, 30928, 30935, 30931, 30937, 32778, 30939, 30936);

-- 29630 Fanged Pit Viper -> updated manually, as not done via script above
UPDATE `creature_template` SET `minlevel` = 101, `maxlevel` = 101 WHERE (`entry` = 29630);

-- Dungeon updated to level 125+ for NHC and HC
INSERT INTO `dungeon_access_template` (`id`, `map_id`, `difficulty`, `min_level`, `max_level`, `min_avg_item_level`, `comment`) VALUES (90, 604, 0, 125, 0, 0, 'Gundrak (North entrance)');
INSERT INTO `dungeon_access_template` (`id`, `map_id`, `difficulty`, `min_level`, `max_level`, `min_avg_item_level`, `comment`) VALUES (91, 604, 1, 125, 0, 180, 'Gundrak (North entrance)');


