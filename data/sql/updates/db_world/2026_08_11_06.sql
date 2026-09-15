-- DB update 2026_08_11_05 -> 2026_08_11_06
--
-- Spawn the missing Heart of the Mountain object (165554) next to the Secret Safe
-- in Blackrock Depths and stop its quest item from dropping from the Secret Safe
-- itself (closes issue 9736). Position from cmangos wotlk-db, respawn time from
-- cmangos classic-db/tbc-db. The short respawn lets every group member on the
-- quest loot their own Heart, since the chest is consumable. The quest item in
-- loot 11160 is already QuestRequired.
DELETE FROM `gameobject` WHERE `guid` = 57 AND `id` = 165554;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(57, 165554, 230, 0, 0, 1, 1, 802.907, -356.401, -48.9423, -0.785397, 0, 0, -0.382683, 0.92388, 10, 100, 1, '', 0, NULL);

DELETE FROM `gameobject_loot_template` WHERE `Entry` = 161495 AND `Item` = 11309;
