INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638732367384844600');

-- Greatfather Winter Gossip
UPDATE `creature_template` SET `gossip_menu_id` = 5232, `type_flags`=`type_flags`|134217728 WHERE `entry` = 13444;

-- Greatfather Winter's Helper
DELETE FROM `creature` WHERE `guid`=845849;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(845849, 15745, 0, 0, 0, 1, 1, 0, 0, -4912.68, -976.28, 501.533, 2.49582, 300, 0, 0, 1003, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `game_event_creature` WHERE `eventEntry` = 2 AND `guid` = 845849;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(2, 845849);
