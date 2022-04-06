-- DB update 2022_01_09_01 -> 2022_01_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_09_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_09_01 2022_01_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641556717798866910'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641556717798866910');

UPDATE `smart_scripts` SET `target_param2`=0 WHERE `entryorguid`=12939100 AND `source_type`=9 AND `id`=11 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=0 WHERE `entryorguid` IN(3113505, 3113504, 3113503, 3113502, 3113501, 3113500) AND `source_type`=9 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param1`=1 WHERE `entryorguid`=1835100 AND `source_type`=9 AND `id`=3 AND `link`=0;
UPDATE `smart_scripts` SET `action_param1`=1 WHERE `entryorguid`=496101 AND `source_type`=9 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=33522 AND `source_type`=0 AND `id`=0 AND `link`=1;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=30886 AND `source_type`=0 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=29261 AND `source_type`=0 AND `id` IN(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15) AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=28308 AND `source_type`=0 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=27476 AND `source_type`=0 AND `id`=16 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=27199 AND `source_type`=0 AND `id` IN(1,2) AND `link`=3;
UPDATE `smart_scripts` SET `action_param4`=1 WHERE `entryorguid`=25624 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid` IN(24536, 28565, 29775) AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=24484 AND `source_type`=0 AND `id`=3 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=24484 AND `source_type`=0 AND `id`=5 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=23689 AND `source_type`=0 AND `id`=3 AND `link`=5;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=21409 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param3`=1  WHERE `entryorguid`=21387 AND `source_type`=0 AND `id`=11 AND `link`=0;
UPDATE `smart_scripts` SET `target_param2`=1 WHERE `entryorguid`=17359 AND `source_type`=0 AND `id`=7 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=15491 AND `source_type`=0 AND `id`=8 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=10290 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=9117 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=7853 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=7790 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=6557 AND `source_type`=0 AND `id`=2 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=6266 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=3568 AND `source_type`=0 AND `id`=3 AND `link`=4;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=2921 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param2`=1 WHERE `entryorguid`=2068 AND `source_type`=0 AND `id`=0 AND `link`=1;
UPDATE `smart_scripts` SET `action_param2`=1 WHERE `entryorguid`=2067 AND `source_type`=0 AND `id`=0 AND `link`=1;
UPDATE `smart_scripts` SET `action_param2`=1 WHERE `entryorguid` IN(2068, 2067, 2066, 2065, 2064, 2063, 2062, 2061, 2060) AND `source_type`=0 AND `id`=0 AND `link`=1;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=253 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param3`=1 WHERE `entryorguid`=15491 AND `source_type`=0 AND `id`=9 AND `link`=0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_10_00' WHERE sql_rev = '1641556717798866910';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
