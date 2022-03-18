INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647530609689243500');

DELETE FROM `creature` WHERE `guid` = 84205 AND `id1` = 14459;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`,`equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(84205,14459,469,0,0,1,1,0,-7644.53,-1081.53,408.574,5.2709,10,0,0,42,0,0,0,0,0,'',0);

DELETE FROM `creature_text` WHERE `CreatureID` = 14459;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration` ,`Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14459, 0, 0, '%s flee as the controlling power of the orb is drained.', 16, 0, 100, 0, 0, 0, 9592, 3, '');
