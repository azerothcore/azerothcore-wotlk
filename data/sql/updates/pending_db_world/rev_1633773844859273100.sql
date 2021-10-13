INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633773844859273100');

UPDATE `creature_template` SET `faction`=1998, `InhabitType`=3, WHERE `entry`=23543;
UPDATE `creature_template_addon` SET `Mount`=0 WHERE `entry`=23543;
