-- DB update 2021_11_21_01 -> 2021_11_21_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_21_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_21_01 2021_11_21_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637093880615871400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637093880615871400');

DELETE FROM `smart_scripts` WHERE `entryorguid`=9217 AND `source_type`=0 AND `id` IN (5,6);
INSERT INTO `smart_scripts` VALUES
(9217,0,5,0,74,0,100,0,0,50,10000,10000,0,11,8365,0,0,0,0,0,9,0,0,0,0,0,0,0,0,'Spirestone Lord Magus - on friendly below 50%hp - cast Enlarge'),
(9217,0,6,0,74,0,100,0,0,30,30000,30000,0,11,6742,0,0,0,0,0,9,0,0,0,0,0,0,0,0,'Spirestone Lord Magus - on friendly below 30%hp - cast Bloodlust');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_21_02' WHERE sql_rev = '1637093880615871400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
