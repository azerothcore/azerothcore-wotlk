-- DB update 2022_04_25_01 -> 2022_04_25_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_25_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_25_01 2022_04_25_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1650555535836713900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650555535836713900');

DELETE FROM `player_loot_template` WHERE (`Entry` IN (1, 0)) AND (`Item` IN (43323, 43314, 44809, 43324, 44808, 43322));
INSERT INTO `player_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(0, 43323, 0, 100, 1, 1, 0, 5, 5, 'Wintergrasp - Alliance - Quiver of Dragonbone Arrows'),
(1, 43323, 0, 100, 1, 1, 0, 5, 5, 'Wintergrasp - Horde - Quiver of Dragonbone Arrows'),
(0, 43314, 0, 100, 1, 1, 0, 5, 5, 'Wintergrasp - Alliance - Eternal Ember'),
(1, 43314, 0, 100, 1, 1, 0, 5, 5, 'Wintergrasp - Horde - Eternal Ember'),
(0, 44809, 0, 100, 1, 1, 0, 5, 5, 'Wintergrasp - Alliance - Horde Herb Pouch'),
(1, 43324, 0, 100, 1, 1, 0, 5, 5, 'Wintergrasp - Horde - Alliance Herb Pouch'),
(0, 44808, 0, 100, 1, 1, 0, 5, 5, 'Wintergrasp - Alliance - Imbued Horde Armor'),
(1, 43322, 0, 100, 1, 1, 0, 5, 5, 'Wintergrasp - Horde - Enchanted Alliance Breastplates');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 28) AND (`SourceGroup` IN (0, 1)) AND (`SourceEntry` IN (43323, 43314, 44809, 43324, 44808, 43322));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(28, 0, 43323, 0, 0, 23, 0, 4587, 0, 0, 0, 0, 0, '', 'Alliance - Quiver of Dragonbone Arrows - drop in The Forest of Shadows'),
(28, 0, 43323, 0, 0, 47, 0, 13154, 8, 0, 0, 0, 0, '', 'Alliance - Quiver of Dragonbone Arrows - drop while quest 13154 is in progress'),
(28, 0, 43323, 0, 1, 23, 0, 4587, 0, 0, 0, 0, 0, '', 'Alliance - Quiver of Dragonbone Arrows - drop in The Forest of Shadows'),
(28, 0, 43323, 0, 1, 47, 0, 13196, 8, 0, 0, 0, 0, '', 'Alliance - Quiver of Dragonbone Arrows - drop while quest 13196 is in progress'),
(28, 1, 43323, 0, 0, 23, 0, 4587, 0, 0, 0, 0, 0, '', 'Horde - Quiver of Dragonbone Arrows - drop in The Forest of Shadows'),
(28, 1, 43323, 0, 0, 47, 0, 13193, 8, 0, 0, 0, 0, '', 'Horde - Quiver of Dragonbone Arrows - drop while quest 13193 is in progress'),
(28, 1, 43323, 0, 1, 23, 0, 4587, 0, 0, 0, 0, 0, '', 'Horde - Quiver of Dragonbone Arrows - drop in The Forest of Shadows'),
(28, 1, 43323, 0, 1, 47, 0, 13199, 8, 0, 0, 0, 0, '', 'Horde - Quiver of Dragonbone Arrows - drop while quest 13199 is in progress'),
(28, 0, 43314, 0, 0, 23, 0, 4584, 0, 0, 0, 0, 0, '', 'Alliance - Eternal Ember - drop in The Cauldron of Flames'),
(28, 0, 43314, 0, 0, 47, 0, 13197, 8, 0, 0, 0, 0, '', 'Alliance - Eternal Ember - drop while quest 13197 is in progress'),
(28, 0, 43314, 0, 1, 23, 0, 4584, 0, 0, 0, 0, 0, '', 'Alliance - Eternal Ember - drop in The Cauldron of Flames'),
(28, 0, 43314, 0, 1, 47, 0, 236, 8, 0, 0, 0, 0, '', 'Alliance - Eternal Ember - drop while quest 236 is in progress'),
(28, 1, 43314, 0, 0, 23, 0, 4584, 0, 0, 0, 0, 0, '', 'Horde - Eternal Ember - drop in The Cauldron of Flames'),
(28, 1, 43314, 0, 0, 47, 0, 13191, 8, 0, 0, 0, 0, '', 'Horde - Eternal Ember - drop while quest 13191 is in progress'),
(28, 1, 43314, 0, 1, 23, 0, 4584, 0, 0, 0, 0, 0, '', 'Horde - Eternal Ember - drop in The Cauldron of Flames'),
(28, 1, 43314, 0, 1, 47, 0, 13200, 8, 0, 0, 0, 0, '', 'Horde - Eternal Ember - drop while quest 13200 is in progress'),
(28, 0, 44809, 0, 0, 23, 0, 4590, 0, 0, 0, 0, 0, '', 'Alliance - Horde Herb Pouch - drop in The Steppe of Life'),
(28, 0, 44809, 0, 0, 47, 0, 13156, 8, 0, 0, 0, 0, '', 'Alliance - Horde Herb Pouch - drop while quest 13156 is in progress'),
(28, 0, 44809, 0, 1, 23, 0, 4590, 0, 0, 0, 0, 0, '', 'Alliance - Horde Herb Pouch - drop in The Steppe of Life'),
(28, 0, 44809, 0, 1, 47, 0, 13195, 8, 0, 0, 0, 0, '', 'Alliance - Horde Herb Pouch - drop while quest 13195 is in progress'),
(28, 1, 43324, 0, 0, 23, 0, 4590, 0, 0, 0, 0, 0, '', 'Horde - Alliance Herb Pouch - drop in The Steppe of Life'),
(28, 1, 43324, 0, 0, 47, 0, 13194, 8, 0, 0, 0, 0, '', 'Horde - Alliance Herb Pouch - drop while quest 13194 is in progress'),
(28, 1, 43324, 0, 1, 23, 0, 4590, 0, 0, 0, 0, 0, '', 'Horde - Alliance Herb Pouch - drop in The Steppe of Life'),
(28, 1, 43324, 0, 1, 47, 0, 13201, 8, 0, 0, 0, 0, '', 'Horde - Alliance Herb Pouch - drop while quest 13201 is in progress'),
(28, 0, 44808, 0, 0, 23, 0, 4585, 0, 0, 0, 0, 0, '', 'Alliance - Imbued Horde Armor - drop in Glacial Falls'),
(28, 0, 44808, 0, 0, 47, 0, 13198, 8, 0, 0, 0, 0, '', 'Alliance - Imbued Horde Armor - drop while quest 13198 is in progress'),
(28, 0, 44808, 0, 1, 23, 0, 4585, 0, 0, 0, 0, 0, '', 'Alliance - Imbued Horde Armor - drop in Glacial Falls'),
(28, 0, 44808, 0, 1, 47, 0, 13153, 8, 0, 0, 0, 0, '', 'Alliance - Imbued Horde Armor - drop while quest 13153 is in progress'),
(28, 1, 43322, 0, 0, 23, 0, 4585, 0, 0, 0, 0, 0, '', 'Horde - Enchanted Alliance Breastplates - drop in Glacial Falls'),
(28, 1, 43322, 0, 0, 47, 0, 13192, 8, 0, 0, 0, 0, '', 'Horde - Enchanted Alliance Breastplates - drop while quest 13192 is in progress'),
(28, 1, 43322, 0, 1, 23, 0, 4585, 0, 0, 0, 0, 0, '', 'Horde - Enchanted Alliance Breastplates - drop in Glacial Falls'),
(28, 1, 43322, 0, 1, 47, 0, 13202, 8, 0, 0, 0, 0, '', 'Horde - Enchanted Alliance Breastplates - drop while quest 13202 is in progress');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_25_02' WHERE sql_rev = '1650555535836713900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
