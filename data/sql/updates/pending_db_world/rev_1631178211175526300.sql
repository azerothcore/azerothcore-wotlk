INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631178211175526300');

DELETE FROM `smart_scripts` WHERE `entryorguid`=8983 AND `id` BETWEEN 3 AND 13;
INSERT INTO `smart_scripts` VALUES
(8983,0,3,0,4,0,100,0,0,0,0,0,0,34,31,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Golem Lord Argelmach - On Aggro - Set instance data 34'),
(8983,0,4,5,38,0,100,0,31,1,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Golem Lord Argelmach - On set 31 data - set react passive'),
(8983,0,5,6,61,0,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Golem Lord Argelmach - On set 31 data - set phase mask to 2'),
(8983,0,6,0,61,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Golem Lord Argelmach - On set 31 data - say 0'),
(8983,0,7,8,0,2,100,1,100,100,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Golem Lord Argelmach - IC - set phase mask to 4'),
(8983,0,8,9,61,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Golem Lord Argelmach - IC - set react passive'),
(8983,0,9,0,61,0,100,0,0,0,0,0,0,69,1,0,0,0,0,0,8,0,0,0,0,809.1331,22.008,-53.658,0,'Golem Lord Argelmach - On set 31 data - move to pos 1'),
(8983,0,10,11,34,0,100,0,8,1,0,0,0,34,32,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Golem Lord Argelmach - On pos 1 - set instance data 32'),
(8983,0,11,0,61,0,100,0,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Golem Lord Argelmach - On pos 1 - reset phase mask'),
(8983,0,12,13,25,0,100,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Golem Lord Argelmach - On reset - set react aggressive'),
(8983,0,13,0,61,0,100,0,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Golem Lord Argelmach - On reset - reset phase mask');

UPDATE `smart_scripts` SET `event_phase_mask`=1 WHERE `entryorguid`=8983 AND `id` BETWEEN 0 AND 2;

DELETE FROM `creature_text` WHERE `CreatureId`=8983;
INSERT INTO `creature_text` VALUES
(8983,0,0,'Intruders in the Manufactory? My constructs will destroy you!',12,0,100,0,0,0,5297,0,'Golem Lord Argelmach Say 0');
