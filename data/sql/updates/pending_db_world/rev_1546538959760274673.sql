INSERT INTO version_db_world (`sql_rev`) VALUES ('1546538959760274673');

ALTER TABLE `game_event`
ADD COLUMN `announce` tinyint(3) unsigned NOT NULL DEFAULT 2 COMMENT '0 dont announce, 1 announce, 2 value from config' AFTER `world_event`;

ALTER TABLE `game_event`
  CHANGE `start_time` `start_time` TIMESTAMP NULL DEFAULT NULL COMMENT 'Absolute start date, the event will never start before',
  CHANGE `end_time` `end_time` TIMESTAMP NULL DEFAULT NULL COMMENT 'Absolute end date, the event will never start after';

UPDATE `game_event` SET `start_time`=NULL WHERE `start_time`='0000-00-00 00:00:00';
UPDATE `game_event` SET `end_time`=NULL WHERE `end_time`='0000-00-00 00:00:00';
