-- DB update 2021_10_04_00 -> 2021_10_04_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_04_00 2021_10_04_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632846834101585427'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632846834101585427');

-- Correct Quest marker text
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Keeper Bel\'dugur at Apothecarium in the Undercity.' WHERE `ID` = 1013;

-- esES & esMX
UPDATE `quest_template_locale` SET `CompletedText` = 'Vuelve con: Guardián Bel\'dugur. Zona: Apothecarium de Entrañas.' WHERE `ID` = 1013 AND `locale` IN ('esES', 'esMX');

-- frFR
UPDATE `quest_template_locale` SET `CompletedText` = 'Retournez voir le Gardien Bel\'dugur au  à l\'Apothicarium à Undercity' WHERE `ID` = 1013 AND `locale` = 'frFR';


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_04_01' WHERE sql_rev = '1632846834101585427';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
