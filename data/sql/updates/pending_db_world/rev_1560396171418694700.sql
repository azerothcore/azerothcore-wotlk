INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1560396171418694700');

UPDATE `gameobject_template_addon` SET `faction`='35' WHERE  `entry`=193070; -- Nexus Raid Platform now has faction 35, instead of 0 and is friendly to players.
UPDATE `gameobject_template` SET `Data0`='1500000' WHERE  `entry`=193070; -- Nexus Raid Platform has a lot more hp in order not to break in case any siege damage is taken, initial value was 100. (double safety)
