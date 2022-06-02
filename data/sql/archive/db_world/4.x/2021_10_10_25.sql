-- DB update 2021_10_10_24 -> 2021_10_10_25
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_24';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_24 2021_10_10_25 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633588844878179667'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633588844878179667');

-- Horde side Mission Accomplished! [5238] quests now have the blizz order
UPDATE `quest_template_addon` SET `PrevQuestID` = 5236 WHERE (`ID` = 5238);

-- Alliance side Mission Accomplished! [5237] quests now have the blizz order
UPDATE `quest_template_addon` SET `PrevQuestID` = 5226 WHERE (`ID` = 5237);

-- Faction

-- FLAGS
-- Alliance 1 Human , 4 Dwarf, 8 Night Elf, 64 Gnome ,1024	Draenei
-- Horde  2 Orc , 16 Undead, 32 Tauren, 128 Troll, 512 Blood Elf

-- Alliance Mission Accomplished! [5237]
-- Remove first horde flags and add alliance flags after
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`&~(2|16|32|128|512) WHERE (`ID` = 5237);
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`|1|4|8|64|1024 WHERE (`ID` = 5237);

-- Horde Mission Accomplished! [5238]
-- Remove first alliance flags and add horde flags after
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`&~(1|4|8|64|1024) WHERE (`ID` = 5238);
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`|2|16|32|128|512 WHERE (`ID` = 5238);

-- Quest givers and quest enders are switched

-- Switched from Commander Ashlam Valorfist to  High Executor Derrington
DELETE FROM `creature_queststarter` WHERE (`quest` = 5238) AND (`id` IN (10838, 10837));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(10837, 5238);

DELETE FROM `creature_questender` WHERE (`quest` = 5238) AND (`id` IN (10838, 10837));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(10837, 5238);

-- Switched from High Executor Derrington to  Commander Ashlam Valorfist
DELETE FROM `creature_queststarter` WHERE (`quest` = 5237) AND (`id` IN (10837, 10838));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(10838, 5237);

DELETE FROM `creature_questender` WHERE (`quest` = 5237) AND (`id` IN (10837, 10838));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(10838, 5237);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_25' WHERE sql_rev = '1633588844878179667';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
