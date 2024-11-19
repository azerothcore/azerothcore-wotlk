-- DB update 2021_07_07_00 -> 2021_07_07_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_00 2021_07_07_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625127147985789300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625127147985789300');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3376) AND (`Item` IN (5017, 5018, 5019));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3376, 5017, 0, 28, 1, 1, 0, 1, 1, 'Bael\'dun Soldier - Nitroglycerin'),
(3376, 5018, 0, 28, 1, 1, 0, 1, 1, 'Bael\'dun Soldier - Wood Pulp'),
(3376, 5019, 0, 28, 1, 1, 0, 1, 1, 'Bael\'dun Soldier - Sodium Nitrate');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3377) AND (`Item` IN (5017, 5018, 5019));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3377, 5017, 0, 29, 1, 1, 0, 1, 1, 'Bael\'dun Rifleman - Nitroglycerin'),
(3377, 5018, 0, 29, 1, 1, 0, 1, 1, 'Bael\'dun Rifleman - Wood Pulp'),
(3377, 5019, 0, 29, 1, 1, 0, 1, 1, 'Bael\'dun Rifleman - Sodium Nitrate');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3378) AND (`Item` IN (5017, 5018, 5019));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3378, 5017, 0, 28, 1, 1, 0, 1, 1, 'Bael\'dun Officer - Nitroglycerin'),
(3378, 5018, 0, 28, 1, 1, 0, 1, 1, 'Bael\'dun Officer - Wood Pulp'),
(3378, 5019, 0, 27, 1, 1, 0, 1, 1, 'Bael\'dun Officer - Sodium Nitrate');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 6668) AND (`Item` IN (5017, 5018, 5019));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6668, 5017, 0, 7, 1, 1, 0, 1, 1, 'Lord Cyrik Blackforge - Nitroglycerin'),
(6668, 5018, 0, 7, 1, 1, 0, 1, 1, 'Lord Cyrik Blackforge - Wood Pulp'),
(6668, 5019, 0, 7, 1, 1, 0, 1, 1, 'Lord Cyrik Blackforge - Sodium Nitrate');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_01' WHERE sql_rev = '1625127147985789300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
