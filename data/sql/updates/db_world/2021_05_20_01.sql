-- DB update 2021_05_20_00 -> 2021_05_20_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_20_00 2021_05_20_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621007854827590200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621007854827590200');

UPDATE `spell_dbc` SET `NameSubtext_Lang_enUS` = 'Rank 1' WHERE `ID` = 1454;
UPDATE `spell_dbc` SET `NameSubtext_Lang_enUS` = 'Rank 2' WHERE `ID` = 1455;
UPDATE `spell_dbc` SET `NameSubtext_Lang_enUS` = 'Rank 3' WHERE `ID` = 1456;
UPDATE `spell_dbc` SET `NameSubtext_Lang_enUS` = 'Rank 4' WHERE `ID` = 11687;
UPDATE `spell_dbc` SET `NameSubtext_Lang_enUS` = 'Rank 5' WHERE `ID` = 11688;
UPDATE `spell_dbc` SET `NameSubtext_Lang_enUS` = 'Rank 6' WHERE `ID` = 11689;
UPDATE `spell_dbc` SET `NameSubtext_Lang_enUS` = 'Rank 7' WHERE `ID` = 27222;
UPDATE `spell_dbc` SET `NameSubtext_Lang_enUS` = 'Rank 8' WHERE `ID` = 57946;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
