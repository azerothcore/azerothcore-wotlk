INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634231663747169200');

UPDATE `gameobject` SET `spawntimesecs`=7200 WHERE `guid` IN (45513,45515,45854,45869,45935,45937);
UPDATE `gameobject` SET `position_z`=47.4206 WHERE `guid`=5281;
UPDATE `gameobject` SET `position_z`=65.9905 WHERE `guid`=5276;
-- Correct object data to match the original
UPDATE `gameobject_template` SET `displayId`=4211 WHERE `entry`=176214;
UPDATE `gameobject_template` SET `type`=3 WHERE `entry`=176214;
UPDATE `gameobject_template` SET `Data1`=13622 WHERE `entry`=176214;
UPDATE `gameobject_template` SET `Data0`=43 WHERE `entry`=176214;
UPDATE `gameobject_template` SET `Data3`=1 WHERE `entry`=176214;
UPDATE `gameobject_template` SET `Data4`='0', `Data9`='0' WHERE `entry`=176214;
UPDATE `gameobject_template_addon` SET `faction`=0 WHERE `entry`=176214;
-- Duplicates
DELETE FROM `gameobject` WHERE `guid` IN (45512,45514,45853,45868,45934,45936);
