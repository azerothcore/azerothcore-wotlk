INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638455217402525600');

UPDATE `creature_questender` SET `id` = 13445 WHERE `quest` IN (7021,7024);

DELETE FROM `creature` WHERE `guid`=24 AND `id` = 13431;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(24, 13431, 1, 0, 0, 1, 1, 0, 0, -1234.51, 73.4529, 129.591, 2.80998, 300, 0, 0, 1003, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `game_event_creature` WHERE `eventEntry` = 24 AND `guid` = 24;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(24, 24);
