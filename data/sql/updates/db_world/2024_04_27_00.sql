-- DB update 2024_04_25_01 -> 2024_04_27_00
-- Update gameobject 'AuctionNode' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (152583))
AND (`guid` IN (24));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(24, 152583, 1, 0, 0, 1, 1, -1257.8424072265625, 24.41799354553222656, 128.217498779296875, 2.888511419296264648, 0, 0, 0.99200439453125, 0.126203224062919616, 120, 255, 1, "", 50250, NULL);
