-- DB update 2019_07_06_00 -> 2019_07_06_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_06_00 2019_07_06_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1561359418814877200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561359418814877200');

-- Kargath Grunt should have axe equiped https://wow.gamepedia.com/Kargath_Grunt
UPDATE `creature_equip_template` SET `ItemID1`=5287 WHERE `CreatureID`=8155;
UPDATE `creature_addon` SET `bytes2`=1 WHERE `guid`=6898;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
