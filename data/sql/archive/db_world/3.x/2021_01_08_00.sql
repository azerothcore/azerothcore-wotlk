-- DB update 2021_01_07_01 -> 2021_01_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_07_01 2021_01_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606881109355464500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606881109355464500');

-- Text improvements

UPDATE `creature_text` SET `Text`='The Lich King is here? Then my destiny shall be fulfilled on this day! ' WHERE  `CreatureID`=37223 AND `GroupID`=27 AND `ID`=0;
UPDATE `creature_text` SET `Text`='Aye. ARRRRRRGHHHH... He... He is coming. You... You must...' WHERE  `CreatureID`=37225 AND `GroupID`=35 AND `ID`=0;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
