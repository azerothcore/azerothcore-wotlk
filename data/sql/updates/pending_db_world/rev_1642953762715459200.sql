INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642953762715459200');

UPDATE `smart_scripts` SET `id`=19 WHERE `entryorguid`=12818 AND `source_type`=0 AND `id`=18 AND `event_type`=11;
UPDATE `smart_scripts` SET `link`=18 WHERE `entryorguid`=12818 AND `source_type`=0 AND `id`=17;
DELETE FROM `smart_scripts` WHERE `entryorguid`=12818 AND `source_type`=0 AND `id`=18;
INSERT INTO `smart_scripts` VALUES
(12818,0,18,0,61,0,100,0,0,0,0,0,0,26,6482,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Ruul Snowhoof - On Waypoint Finished - Quest Complete');
