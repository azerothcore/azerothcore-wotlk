INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639761638374281200');

SET @THRASH_01 = 3391;
SET @THRASH_02 = 12787;
SET @THRASH_03 = 3417;
SET @THRASH_04 = 8876;

-- Removing Thrash from creatures that cast this spell that are not the ones specified.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`action_type` = 11) AND (`action_param1` = @THRASH_01) AND `entryorguid` NOT IN (478, 669, 1202, 1783, 1791, 2236, 2560, 2681, 2717, 2728, 3256, 3378, 3456, 3746, 4023, 4374, 4493, 4540, 4634, 4656, 4855, 5234, 5267, 5455, 5456, 5457, 5458, 5459, 5460, 5709, 5977, 6005, 6348, 7039, 7101, 7234, 7320, 8138, 8911, 8961, 9096, 9267, 9777, 10488, 10991, 11043, 11357, 11372, 11486, 11677, 11737, 11791, 12201, 12207, 12940, 14282, 14283, 14426, 14750, 14821, 14882, 16216, 18858, 18214, 22244, 22174, 21040, 22286, 21636, 18660, 19201, 18207);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`action_type` = 11) AND (`action_param1` = @THRASH_02) AND `entryorguid` NOT IN (1843, 16216, 24552, 25027, 25028, 29392);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`action_type` = 11) AND (`action_param1` = @THRASH_03) AND `entryorguid` NOT IN (11486, 15207, 15305);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`action_type` = 11) AND (`action_param1` = @THRASH_04) AND `entryorguid` NOT IN (16593, 17397, 18631, 23680, 29033);

-- Updating AIName from all creatures without any SmartAI Scripts
UPDATE `creature_template` 
INNER JOIN (SELECT `entryorguid`, COUNT(*) amount FROM `smart_scripts` GROUP BY `entryorguid`) counter
ON counter.entryorguid = creature_template.entry
SET creature_template.AIName = IF(counter.amount > 0, "SmartAI", "");
