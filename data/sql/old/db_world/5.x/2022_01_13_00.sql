-- DB update 2022_01_12_05 -> 2022_01_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_12_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_12_05 2022_01_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642054240860129732'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642054240860129732');

UPDATE `smart_scripts` SET `target_type`=0 WHERE `action_type`=25;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(27715, 27716, 27717, 27718, 27727) AND `action_type`=6;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(16769, 16977, 25321, 25322, 27615, 32495) AND `action_type`=22;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(27615, 16769) AND `action_type`=21;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(25416, 25418) AND `action_type`=85;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(30162, 30180, 28752, 28754, 28756) AND `action_type`=33;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(1140, 8538, 8539) AND `action_type`=39;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(1494, 12818, 30007, 14821, 15420, 15420, 18069, 18400, 18417, 18471, 19283, 19480, 20774) AND `action_type`=1;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(7207, 17853, 19720) AND `action_type`=15;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(8538, 30081, 30086, 30154) AND `action_type`=2;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(9520, 12818) AND `action_type`=53;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid`=28444 AND `action_type`=4;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid`=18471 AND `action_type`=26;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid`=22423 AND `action_type`=83;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid`=25401 AND `action_type`=64;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid`=29050 AND `action_type`=66;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(33519, 30081, 30086) AND `action_type`=33;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid`=37158 AND `action_type`=34;
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(11350, 11352, 11355, 11359);
UPDATE `smart_scripts` SET `target_type`=0 WHERE `entryorguid` IN(29861, 30475, 30829, 30830, 30838, 30839, 30840, 32357, 32400, 33306, 33382, 33383, 33384, 33519, 33558, 33559, 33561, 33562, 33564, 27220, 27238, 21926) AND `action_type`=11;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_13_00' WHERE sql_rev = '1642054240860129732';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
