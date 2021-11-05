INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636144391799645100');

UPDATE `creature_template` SET `AiName`='' WHERE `entry`=23090;
UPDATE `creature_template_addon` SET `auras`='18950 32199' WHERE `entry`=23090;
DELETE FROM `smart_scripts` WHERE `entryorguid`=23090;

UPDATE `creature_template_addon` SET `auras`='20540' WHERE `entry`=12856;
DELETE FROM `smart_scripts` WHERE `entryorguid`=12856 AND `id`=3;
