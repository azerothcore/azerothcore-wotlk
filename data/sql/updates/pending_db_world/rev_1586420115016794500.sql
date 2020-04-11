INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1586420115016794500');

ALTER TABLE `creature`
	CHANGE COLUMN `spawndist` `wander_distance` FLOAT NOT NULL DEFAULT '0' AFTER `spawntimesecs`;
	
DELETE FROM `command` WHERE `name` IN ('npc set spawndist', 'npc set wanderdistance');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('npc set wanderdistance', 3, 'Syntax: .npc set wanderdistance #dist\r\n\r\nAdjust wander distance of selected creature to dist.');

-- Loc3 = German Google Translate
UPDATE `acore_string` SET `content_default`='Wander distance changed to: %f', `content_loc3` = 'Wanderentfernung wurde auf %f abgeändert' WHERE `entry`=297;
