INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613242843051334000');

/* Adjust Position and remove piece of Ham from Reese Langston
   Source: https://wow.gamepedia.com/Reese_Langston
*/

UPDATE `creature_equip_template` SET `ItemID2` = 0 WHERE (`CreatureID` = 1327);

DELETE FROM `creature` WHERE (`id` = 1327) AND (`guid` IN (79751));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(79751, 1327, 0, 0, 0, 1, 1, 0, 1, -8606.001953, 383.925995, 102.923599, 3.79168, 310, 0, 0, 1003, 0, 0, 0, 0, 0, '', 0);
