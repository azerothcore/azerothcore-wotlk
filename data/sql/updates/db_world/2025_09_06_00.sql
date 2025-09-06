-- DB update 2025_09_05_01 -> 2025_09_06_00
--
SET @CGUID:=12891;
DELETE FROM `creature` WHERE (`id1` = 16786) AND (`guid` = (@CGUID));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(@CGUID, 16786, 0, 0, 0, 0, 0, 1, 1, 0, -4926.95, -981.718, 501.55, 2.0071299076080322, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', '', 0);

DELETE FROM `game_event_creature` WHERE `guid` = @CGUID;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES(17, @CGUID);
