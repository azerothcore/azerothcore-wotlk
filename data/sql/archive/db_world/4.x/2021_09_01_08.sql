-- DB update 2021_09_01_07 -> 2021_09_01_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_07 2021_09_01_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630055966364700300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630055966364700300');

-- Set Honored rep requirement for the following quests:
-- 6645 - [Favor Amongst the Brotherhood, Core Leather]
-- 6646 - [Favor Amongst the Brotherhood, Blood of the Mountain]
-- 6642 - [Favor Amongst the Brotherhood, Dark Iron Ore]
-- 6643 - [Favor Amongst the Brotherhood, Fiery Core]
-- 6644 - [Favor Amongst the Brotherhood, Lava Core]
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 9000 WHERE `ID` IN ('6645', '6646', '6642', '6643', '6644');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_08' WHERE sql_rev = '1630055966364700300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
