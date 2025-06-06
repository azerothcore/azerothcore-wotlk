-- DB update 2023_12_12_10 -> 2023_12_12_11
-- miscellaneous cleanups of midsummer spawns
-- 10177, 'Spire Scarab'
-- unlink spawns from midsummer (they're unrelated, all located in Blackrock Spire)
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 10177));

-- 181792, 'The Exodar'
-- road sign - remove duplicate spawn (guid 151026) that was linked to midsummer
DELETE FROM `game_event_gameobject` WHERE (`guid` = 151026);
DELETE FROM `gameobject` WHERE (`id` = 181792) AND (`guid` = 151026);

-- 181288 'Midsummer Bonfire'
-- remove ALL spawns - these are not required anymore and also do not show in any sniffs so far
DELETE FROM `game_event_gameobject` WHERE (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 181288));
DELETE FROM `gameobject` WHERE (`id` = 181288);

-- 16781, 'Midsummer Celebrant'
-- remove non-existend celebrants that do NOT show in any sniffs (completes TODO of PR #17549)
-- (These were located in Thunder Bluff Midsummer Camp which was completely manually placed with erroneous spawns)
DELETE FROM `creature` WHERE (`id1` = 16781) AND (`guid` IN (94531, 94547));
DELETE FROM `game_event_creature` WHERE (`guid` IN (94531, 94547));

-- 16781, 'Midsummer Celebrant'
-- update orientations (completes TODO of PR #17549)
UPDATE `creature` SET `orientation` = 5.19 WHERE (`id1` = 16781) AND (`guid` = 139128);
UPDATE `creature` SET `orientation` = 2.86 WHERE (`id1` = 16781) AND (`guid` = 139129);
UPDATE `creature` SET `orientation` = 5.94 WHERE (`id1` = 16781) AND (`guid` = 139130);
UPDATE `creature` SET `orientation` = 0.84 WHERE (`id1` = 16781) AND (`guid` = 139151);
UPDATE `creature` SET `orientation` = 0.73 WHERE (`id1` = 16781) AND (`guid` = 139153);
UPDATE `creature` SET `orientation` = 0.89 WHERE (`id1` = 16781) AND (`guid` = 139184);
UPDATE `creature` SET `Comment` = "orientation corrected manually (not sniffed)" WHERE (`id1` = 16781) AND (`guid` IN (139128, 139129, 139130, 139151, 139153, 139184));
