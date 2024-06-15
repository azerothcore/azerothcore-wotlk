-- DB update 2021_07_21_02 -> 2021_07_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_21_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_21_02 2021_07_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626532264671526700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626532264671526700');

-- We had 2 gossips with the id, and it was choosing the wrong one. So we insert into a new one id.
DELETE FROM `gossip_menu` WHERE `menuid` = 61025 and `textid` = 10041;

-- The line 10041 is the one needed for this character.
INSERT INTO `gossip_menu` (`menuid`, `textid` ) VALUES (61025 ,10041);

-- We update the character to use the new gossip id.
UPDATE `creature_template` SET `gossip_menu_id` = 61025, `faction` = 1604 WHERE (`entry` = 20406);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_22_00' WHERE sql_rev = '1626532264671526700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
