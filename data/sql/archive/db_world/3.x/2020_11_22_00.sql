-- DB update 2020_11_21_00 -> 2020_11_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_21_00 2020_11_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1592648244203077800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1592648244203077800');

ALTER TABLE `player_factionchange_titles`
	ADD `alliance_comment` TEXT AFTER `alliance_id`,
	ADD `horde_comment` TEXT AFTER `horde_id`;
	
DELETE FROM `player_factionchange_titles` WHERE `alliance_id` IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,48,75,113,126,146,147,148,149) AND `horde_id` IN (15,16,17,18,19,20,21,22,23,24,25,26,27,28,47,76,153,127,152,154,151,150);
INSERT INTO `player_factionchange_titles` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
(1, "Private <name>", 15, "Scout <name>"),
(2, "Corporal <name>", 16, "Grunt <name>"),
(3, "Sergeant <name>", 17, "Sergeant <name>"),
(4, "Master Sergeant <name>", 18, "Senior Sergeant <name>"),
(5, "Sergeant Major <name>", 19, "First Sergeant <name>"),
(6, "Knight <name>", 20, "Stone Guard"),
(7, "Knight-Lieutenant <name>", 21, "Blood Guard <name>"),
(8, "Knight-Captain <name>", 22, "Legionnaire <name>"),
(9, "Knight-Champion <name>", 23, "Centurion <name>"),
(10, "Lieutenant Commander <name>", 24, "Champion <name>"),
(11, "Commander <name>", 25, "Lieutenant General <name>"),
(12, "Marshal  <name>", 26, "General <name>"),
(13, "Field Marshal <name>", 27, "Warlord <name>"),
(14, "Grand Marshal <name>", 28, "High Warlord <name>"),
(48, "Justicar <name>", 47, "Conqueror <name>"),
(75, "Flame Warden <name>", 76, "Flame Keeper <name>"),
(113, "<name> of Gnomeregan", 153, "<name> of Thunder Bluff"),
(126, "<name> of the Alliance", 127, "<name> if the Horde"),
(146, "<name> of the Exodar", 152, "<name> of Silvermoon"),
(147, "<name> of Darnassus", 154, "<name> of the Undercity"),
(148, "<name> of Ironforge", 151, "<name> of Sen'jin"),
(149, "<name> of Stormwind", 150, "<name> of Orgrimmar");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
