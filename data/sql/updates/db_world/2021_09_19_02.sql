-- DB update 2021_09_19_01 -> 2021_09_19_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_19_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_19_01 2021_09_19_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631624817554390205'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631624817554390205');

-- Flags: Orc 2, Undead 16, Tauren 32, Troll 128, Blood Elf 512

-- The Mindless Ones and Rattling the Rattlecages are now Horde only from undead only
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`|2|16|32|128|512 WHERE (`ID` IN (364, 3901));

-- Simple scroll, Encrypted Scroll, Hallowed Scroll, Glyphic Scroll and Tainted Scroll are now undead only from Horde only
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`&~(2|16|32|128|512) WHERE (`ID` IN (3095, 3096, 3097, 3098, 3099));

-- Remove the prerequisite quest of The Mindless Ones
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 364);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_19_02' WHERE sql_rev = '1631624817554390205';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
