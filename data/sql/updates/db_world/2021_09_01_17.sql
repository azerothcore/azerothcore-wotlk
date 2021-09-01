-- DB update 2021_09_01_16 -> 2021_09_01_17
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_16';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_16 2021_09_01_17 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630147471003792720'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630147471003792720');

UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Bashana Runetotem at Elder Rise in Thunder Bluff.' WHERE `ID` = 6561;

-- frFR
UPDATE `quest_template_locale` SET `CompletedText` = 'Retournez voir Bashana Runetotem à Elder Rise, Thunder Bluff.' WHERE `ID` = 6561 AND `locale` = 'frFR';
-- zhCN
UPDATE `quest_template_locale` SET `CompletedText` = '在雷霆崖的长者高地找到芭莎娜符文图腾。.' WHERE `ID` = 6561 AND `locale` = 'zhCN';
-- ruRU
UPDATE `quest_template_locale` SET `CompletedText` = 'Вернитесь к Башану Руническому Тотему в Восстание Старейших, что в Громовом Утесе.' WHERE `ID` = 6561 AND `locale` = 'ruRU';
-- esMX
UPDATE `quest_template_locale` SET `CompletedText` = 'Regresa a: Bashana Runetotem. Zona: The Elder Rise, Cima del Trueno..' WHERE `ID` = 6561 AND `locale` = 'esMX';
-- esES
UPDATE `quest_template_locale` SET `CompletedText` = 'Regresa a: Bashana Runetotem. Zona: The Elder Rise, Cima del Trueno..' WHERE `ID` = 6561 AND `locale` = 'esES';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_17' WHERE sql_rev = '1630147471003792720';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
