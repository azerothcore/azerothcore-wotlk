-- DB update 2022_02_18_01 -> 2022_02_18_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_18_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_18_01 2022_02_18_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645202981799134977'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645202981799134977');

-- Fix equipment for PR #10453
UPDATE `creature` SET `equipment_id`=1 WHERE `guid` IN (45782,45783,45784,45785,45786,45787,45788);
-- Fix equipment for PR #9935
UPDATE `creature` SET `equipment_id`=1 WHERE `id1`=16333;
-- Fix equipment for PR #9818
UPDATE `creature` SET `equipment_id`=1 WHERE `id1`=16317;
-- Fix equipment for PR #9784
UPDATE `creature` SET `equipment_id`=1 WHERE `id1`=16315;
-- Fix equipment for PR #9751
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (16344,16469);
-- Fix equipment for PR #9750
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (16345,16346);
-- Fix equipment for PR #9696
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (16330,17210);
-- Fix equipment for PR #9693
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (16325,16326);
-- Fix equipment for PR #9678
UPDATE `creature` SET `equipment_id`=1 WHERE `id1`=16332;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_18_02' WHERE sql_rev = '1645202981799134977';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
