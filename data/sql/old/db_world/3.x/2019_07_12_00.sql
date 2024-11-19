-- DB update 2019_07_11_00 -> 2019_07_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_11_00 2019_07_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1561967531437429600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561967531437429600');

UPDATE `creature` SET `unit_flags` = 512 WHERE `guid` = 200984;

DELETE FROM `creature_text` WHERE `CreatureID` = 32315 AND `GroupID` BETWEEN 15 AND 18;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(32315,15,0,'The paladin still lives? Is it possible, Highlord? Could he have survived?',12,0,0,6,0,17107,37051,0,'High Overlord Saurfang - SAY_SAURFANG_INTRO_1'),
(32315,16,0,'Then we must save him! If we rescue Bolvar Fordragon, we may quell the unrest between the Alliance and the Horde.',12,0,0,5,0,17108,37053,0,'High Overlord Saurfang - SAY_SAURFANG_INTRO_2'),
(32315,17,0,'Our mission is now clear: The Lich King will answer for his crimes and we will save Highlord Bolvar Fordragon!',12,0,0,15,0,17109,37054,0,'High Overlord Saurfang - SAY_SAURFANG_INTRO_3'),
(32315,18,0,'Kor\'kron, prepare Orgrim\'s Hammer for its final voyage! Champions, our gunship will find a point to dock on the upper reaches of the citadel. Meet us there!',14,0,0,22,0,17110,37055,0,'High Overlord Saurfang - SAY_SAURFANG_INTRO_4');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
