-- DB update 2020_05_18_00 -> 2020_05_18_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_18_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_18_00 2020_05_18_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1587062218041221300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587062218041221300');

DELETE FROM `acore_string` WHERE `entry` IN (30081,30082);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(30081, "%s does not have itemID = %i, thus cannot be removed."),
(30082, "%s does not have that many of itemID = %i, thus none were removed.");

UPDATE `command` SET `help` = "Syntax: .additem #itemID/[#itemName]/#itemLink #itemCount\r\nAdds the specified item to you or the selected character.\nIf #itemCount is negative, you will remove #itemID." WHERE `name` = "additem";

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
