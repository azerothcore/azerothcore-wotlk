INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638125279373569035');

-- Fix event_type in Timed Actionlists
UPDATE `smart_scripts` SET `event_type`=0 WHERE `source_type`=9 AND `event_type`>0;
