-- DB update 2022_10_29_03 -> 2022_10_29_04
--
DELETE FROM `creature` WHERE `guid`=91799;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(91799,15353,0,1,1,1,-4918.64,-983.141,501.538,2.43867,300,0,0,1,0,0,0,0,0,'',0);

DELETE FROM `game_event_creature` WHERE `guid`=91799;
INSERT INTO `game_event_creature` VALUES
(12,91799);
