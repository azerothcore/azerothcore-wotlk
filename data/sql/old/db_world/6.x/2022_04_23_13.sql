-- DB update 2022_04_23_12 -> 2022_04_23_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_23_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_23_12 2022_04_23_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648565976022955594'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648565976022955594');

UPDATE `quest_template_locale` SET `ObjectiveText1`="Goule écarlate revenue" WHERE `ID`=12698 AND `locale`="frFR";
UPDATE `quest_template_locale` SET `ObjectiveText1`="Обращено вурдалаков" WHERE `ID`=12698 AND `locale`="ruRU";
UPDATE `quest_template_locale` SET `ObjectiveText1`="Défenseur écarlate tué" WHERE `ID`=12701 AND `locale`="frFR";
UPDATE `quest_template_locale` SET `ObjectiveText1`="Убито защитников Алого ордена" WHERE `ID`=12701 AND `locale`="ruRU";
UPDATE `quest_template_locale` SET `ObjectiveText1`="Soldat de la Croisade écarlate tué",`ObjectiveText2`="Habitant de la Nouvelle-Avalon tué" WHERE `ID`=12722 AND `locale`="frFR";
UPDATE `quest_template_locale` SET `ObjectiveText1`="Убито солдат Алого ордена",`ObjectiveText2`="Убито граждан Нового Авалона" WHERE `ID`=12722 AND `locale`="ruRU";

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_23_13' WHERE sql_rev = '1648565976022955594';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
