-- DB update 2022_02_03_00 -> 2022_02_03_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_03_00 2022_02_03_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643734354433050200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643734354433050200');

UPDATE `creature_template` SET `gossip_menu_id` = 61026 WHERE `entry` = 3567;
UPDATE `creature_template` SET `npcflag` = 3 WHERE `entry` = 3567;
DELETE FROM `npc_text` WHERE `ID` = 50032;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (50032,
        'Well met, $N. It is good to see that $cs like yourself are taking an active part in protecting the groves.',
        'Well met, $N. It is good to see that $cs like yourself are taking an active part in protecting the groves.', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = 61026 AND `TextID` = 50032;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(61026, 50032);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_03_01' WHERE sql_rev = '1643734354433050200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
