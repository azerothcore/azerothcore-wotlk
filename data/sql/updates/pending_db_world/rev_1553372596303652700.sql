INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553372596303652700');
DELETE FROM `creature_template_addon` WHERE `entry` = 33691; 
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(33691,0,0,0,0,0,'62019'); -- Rune of Summoning
