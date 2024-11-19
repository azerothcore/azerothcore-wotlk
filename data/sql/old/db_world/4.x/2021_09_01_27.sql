-- DB update 2021_09_01_26 -> 2021_09_01_27
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_26';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_26 2021_09_01_27 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630344741636829281'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630344741636829281');

-- Add text to Tell me more about the history of Remulos and Zaetar option.
DELETE FROM `npc_text` WHERE `ID` = 6180;
INSERT INTO `npc_text` (`ID`, `text0_0`, `BroadcastTextID0`) VALUES (6180, 'You ask of the Sons of Cenarius, Remulos and Zaetar.$B$BMy father, Remulos, was strong and beautiful, and my uncle, Zaetar, very cunning and slight of build. While they were respected quite equally, Zaetar always felt as if he could never quite compare to the glory and attention he thought Remulos had.$B$BAfter my sisters and I were born, Zaetar, blinded by jealousy, set out to outdo his brother... He was the creator of his own end. The sadness it brings me has never lessened, even as time passes...)', 8962);

DELETE FROM `gossip_menu` WHERE `MenuID` = 5354;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (5354, 6181);

-- Add text to Please tell me more about Zaetar option
DELETE FROM `npc_text` WHERE `ID` = 6181;
INSERT INTO `npc_text` (`ID`, `text0_0`, `BroadcastTextID0`) VALUES (6181, 'Ah, Zaetar... <Celebras looks away.>$B$BMy father, Remulos, tried to stop him...$B$BZaetar was headstrong, and when he fell for an earthen elemental princess, my father knew that their union was cursed, but Zaetar refused to listen.$B$BThe centaur are the result of his mistake. They were born misshapen and hateful; my uncle Zaetar was killed by his own kin...$B$BThe evil princess, Theradras, still guards his remains here in the crystal caverns.', 8941);

DELETE FROM `gossip_menu` WHERE `MenuID` = 5351;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (5351, 6181);

-- Remove Why didn't Lord Vyletongue unite both parts of the scepter into one? gossip (not found on source)
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 5354);
-- Remove the chained gossip(You can access all the gossip clicking in the option that you want)
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 5347);

-- Change the gossip options to match the source
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 5349);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(5349, 0, 0, 'Please tell me more about Maraudon.', 8938, 1, 1, 5347, 0, 0, 0, '', 0, 0),
(5349, 1, 0, 'Please tell me more about Zaetar.', 8940, 1, 1, 5354, 0, 0, 0, '', 0, 0),
(5349, 2, 0, 'Tell me more about the history of Remulos and Zaetar.', 8961, 1, 1, 5148, 0, 0, 0, '', 0, 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_27' WHERE sql_rev = '1630344741636829281';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
