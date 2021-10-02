-- DB update 2021_08_19_01 -> 2021_08_20_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_19_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_19_01 2021_08_20_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629137505579314700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629137505579314700');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 17770 AND `spell_effect` = 29940;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (17770,29940,0,'Wolfshead Helm Energy');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_20_00' WHERE sql_rev = '1629137505579314700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
