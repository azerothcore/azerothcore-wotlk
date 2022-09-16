-- DB update 2021_09_01_02 -> 2021_09_01_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_02 2021_09_01_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629981420936961816'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629981420936961816');

-- Change the allowed race to this quest (Flags: Human 1, Dwarf 4, Night elf 8, Gnome 64, Draenei 1024)

-- Only human Grimand Elmore (1700)
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`&~(4|8|64|1024) WHERE (`ID` = 1700);
-- Only dwarfs and gnomes Klockmort Spannerspan (1704)
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`&~(1|8|1024) WHERE (`ID` = 1704);
-- Only night elves Mathiel (1703)
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`&~(1|4|64|1024) WHERE (`ID` = 1703);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_03' WHERE sql_rev = '1629981420936961816';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
