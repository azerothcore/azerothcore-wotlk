-- DB update 2021_07_20_00 -> 2021_07_21_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_20_00 2021_07_21_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626317015822404300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626317015822404300');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 7158) AND (`Item` IN (21377));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7158, 21377, 0, 49, 0, 1, 0, 1, 1, 'Deadwood Shaman - Deadwood Headdress Feather');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 7157) AND (`Item` IN (21377));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7157, 21377, 0, 48, 0, 1, 0, 1, 1, 'Deadwood Avenger - Deadwood Headdress Feather');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 7156) AND (`Item` IN (21377));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7156, 21377, 0, 49, 0, 1, 0, 1, 1, 'Deadwood Den Watcher - Deadwood Headdress Feather');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 7155) AND (`Item` IN (21377));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7155, 21377, 0, 27, 0, 1, 0, 1, 1, 'Deadwood Pathfinder - Deadwood Headdress Feather');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 7154) AND (`Item` IN (21377));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7154, 21377, 0, 28, 0, 1, 0, 1, 1, 'Deadwood Gardener - Deadwood Headdress Feather');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 7153) AND (`Item` IN (21377));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7153, 21377, 0, 30, 0, 1, 0, 1, 1, 'Deadwood Warrior - Deadwood Headdress Feather');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 9464) AND (`Item` IN (21377));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9464, 21377, 0, 28, 0, 1, 0, 1, 1, 'Overlord Ror - Deadwood Headdress Feather');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14342) AND (`Item` IN (21377));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14342, 21377, 0, 17, 0, 1, 0, 1, 1, 'Ragepaw - Deadwood Headdress Feather');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 9462) AND (`Item` IN (21377));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9462, 21377, 0, 39, 0, 1, 0, 1, 1, 'Chieftain Bloodmaw - Deadwood Headdress Feather');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_21_00' WHERE sql_rev = '1626317015822404300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
