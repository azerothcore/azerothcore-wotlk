INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567713200326299359');

UPDATE `creature_template` SET `flags_extra`= 0 WHERE `entry` IN (26638,31351);
 
UPDATE `creature_template` SET `faction`= 16  WHERE `entry` IN (26620,31339);

DELETE FROM `creature_addon` WHERE `guid` = 127438;
INSERT INTO `creature_addon` (`guid`, `bytes2`, `emote`) VALUES 
(127438, 1, 36);

DELETE FROM `smart_scripts` WHERE `entryorguid`= 26623  AND `id` IN (10,11);
