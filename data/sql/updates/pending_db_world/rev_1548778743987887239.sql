INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1548778743987887239');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 32711;

DELETE FROM `creature` WHERE `guid` = 2023271;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`)
VALUES
(2023271,32751,571,0,0,1,1,28212,0,5808.4,583.112,652.386,5.0091,300,0,0,10635,0,0,0,0,0,'',0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 114764;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`)
VALUES
(114764,114764,0,0,515,0,0),
(114764,2023271,2,270,515,0,0);

DELETE FROM `creature_text` WHERE `CreatureID` IN (27047,32711,29506);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(27047, 0, 0, '', 16, 0, 100, 0, 0, 0, 0, 0, 'Invisible Stalker (Floating Only)'),
(32711, 0, 0, 'So peaceful...', 12, 0, 100, 0, 0, 0, 0, 0, 'Warp-Huntress Kula'),
(29506, 0, 0, 'Welcome traveler!', 12, 0, 100, 0, 0, 0, 0, 0, 'Orland Schaeffer');
