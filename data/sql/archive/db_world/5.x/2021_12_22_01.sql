-- DB update 2021_12_22_00 -> 2021_12_22_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_22_00 2021_12_22_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640207292899393200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640207292899393200');

-- Flamewalker Priest - Remove items not reflected to tbc.wowhead
DELETE FROM `creature_loot_template` WHERE (`Entry` = 11662) AND (`Item` IN (
    10305,
    10306,
    10307,
    10308,
    10309,
    10310,
    13444,
    13490,
    14492,
    14499,
    14504,
    14506,
    14508,
    14557,
    15746,
    15765
));

-- Flamewalker Elite - Remove items not reflected to tbc.wowhead
DELETE FROM `creature_loot_template` WHERE (`Entry` = 11664) AND (`Item` IN (
    10305,
    10306,
    10307,
    10308,
    10309,
    10310,
    12697,
    12713,
    13444,
    13490,
    14492,
    14496,
    14504,
    14506,
    14508,
    15755,
    15757,
    15765,
    16051,
    16251,
    18646,
    18703,
    18803,
    18805,
    18806,
    18808,
    18809,
    18810,
    18811,
    18812,
    19139,
    19140
));

-- Flamewalker Elite - Add items missing accordingly to tbc.wowhead
DELETE FROM `creature_loot_template` WHERE `Entry` = 11664 AND `Item` IN (22390, 3465);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11664, 22390, 0, 0.1, 0, 1, 0, 1, 1, 'Flamewaker Elite - Plans: Persuader'),
(11664, 3475, 0, 0.1, 0, 1, 0, 1, 1, 'Flamewaker Elite - Cloak of Flames');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_22_01' WHERE sql_rev = '1640207292899393200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
