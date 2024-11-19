-- DB update 2022_04_16_00 -> 2022_04_16_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_16_00 2022_04_16_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1649704204212585721'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649704204212585721');

DELETE FROM `item_template_locale` WHERE `ID`=13873 AND `locale` IN ('esES','esMX','ruRU','koKR','zhCN','frFR');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(13873, 'esES', 'Llave de la Sala de visión', '', 0),
(13873, 'esMX', 'Llave de la Sala de visión', '', 0),
(13873, 'ruRU', 'Ключ от смотровой', '', 0),
(13873, 'koKR', '강당 열쇠', '', 0),
(13873, 'zhCN', '观察室钥匙', '', 0),
(13873, 'frFR', 'Clé de la Chambre des visions', '', 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_16_01' WHERE sql_rev = '1649704204212585721';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
