-- DB update 2021_08_24_02 -> 2021_08_24_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_24_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_24_02 2021_08_24_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629289212399915700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629289212399915700');

# The first clear spot
SET @FIRST_POOL_ENTRY = 11676;
# The first clear spot after 2000 - 2000 is the start point of master mineral pools
SET @FIRST_MASTER_POOL_ENTRY = 2019;

CREATE TABLE TEMP_POOL_TEMPLATES (entry int, max_limit int, description char(64));
INSERT INTO TEMP_POOL_TEMPLATES VALUES
(@FIRST_MASTER_POOL_ENTRY + 0 , 1, 'Master Mineral Pool - Redridge Mountains'),
(@FIRST_MASTER_POOL_ENTRY + 1 , 1, 'Master Mineral Pool - Stranglethorn Vale'),
(@FIRST_MASTER_POOL_ENTRY + 2 , 1, 'Master Mineral Pool - Thousand Needles'),
(@FIRST_MASTER_POOL_ENTRY + 3 , 4, 'Master Mineral Pool - Searing Gorge'),
(@FIRST_MASTER_POOL_ENTRY + 4 , 1, 'Master Mineral Pool - Uldaman'),
(@FIRST_MASTER_POOL_ENTRY + 5 , 1, 'Master Mineral Pool - Desolace'),
(@FIRST_MASTER_POOL_ENTRY + 6 , 1, 'Master Mineral Pool - Darkshore'),
(@FIRST_MASTER_POOL_ENTRY + 7 , 1, 'Master Mineral Pool - Silverpine Forest'),
(@FIRST_MASTER_POOL_ENTRY + 8 , 1, 'Master Mineral Pool - Blackfathom Deeps'),
(@FIRST_MASTER_POOL_ENTRY + 9 , 1, 'Master Mineral Pool - Tanaris'),
(@FIRST_MASTER_POOL_ENTRY + 10, 1, 'Master Mineral Pool - Maraudon'),
(@FIRST_MASTER_POOL_ENTRY + 11, 1, 'Master Mineral Pool - Winterspring'),
(@FIRST_MASTER_POOL_ENTRY + 12, 1, 'Master Mineral Pool - Hellfire Peninsula'),
(@FIRST_MASTER_POOL_ENTRY + 13, 2, 'Master Mineral Pool - Nagrand'),
(@FIRST_MASTER_POOL_ENTRY + 14, 1, 'Master Mineral Pool - Terokkar Forest'),
(@FIRST_MASTER_POOL_ENTRY + 15, 1, 'Master Mineral Pool - Mana-Tombs'),
(@FIRST_MASTER_POOL_ENTRY + 16, 1, 'Master Mineral Pool - The Underbog'),
(@FIRST_MASTER_POOL_ENTRY + 17, 1, 'Master Mineral Pool - Zangarmarsh'),
(@FIRST_POOL_ENTRY + 0 , 1, 'Spawn Point 1 - Redridge Mountains - Zone 44'),
(@FIRST_POOL_ENTRY + 1 , 1, 'Spawn Point 1 - Stranglethorn Vale - Zone 33'),
(@FIRST_POOL_ENTRY + 2 , 1, 'Spawn Point 2 - Stranglethorn Vale - Zone 33'),
(@FIRST_POOL_ENTRY + 3 , 1, 'Spawn Point 3 - Stranglethorn Vale - Zone 33'),
(@FIRST_POOL_ENTRY + 4 , 1, 'Spawn Point 1 - Thousand Needles - Zone 400'),
(@FIRST_POOL_ENTRY + 5 , 1, 'Spawn Point 1 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 6 , 1, 'Spawn Point 2 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 7 , 1, 'Spawn Point 3 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 8 , 1, 'Spawn Point 4 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 9 , 1, 'Spawn Point 5 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 10, 1, 'Spawn Point 6 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 11, 1, 'Spawn Point 7 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 12, 1, 'Spawn Point 8 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 13, 1, 'Spawn Point 1 - Uldaman - Zone 1337'),
(@FIRST_POOL_ENTRY + 14, 1, 'Spawn Point 1 - Desolace - Zone 405'),
(@FIRST_POOL_ENTRY + 15, 1, 'Spawn Point 1 - Darkshore - Zone 148'),
(@FIRST_POOL_ENTRY + 16, 1, 'Spawn Point 1 - Silverpine Forest - Zone 130'),
(@FIRST_POOL_ENTRY + 17, 1, 'Spawn Point 1 - Blackfathom Deeps - Zone 719'),
(@FIRST_POOL_ENTRY + 18, 1, 'Spawn Point 1 - Tanaris - Zone 440'),
(@FIRST_POOL_ENTRY + 19, 1, 'Spawn Point 1 - Maraudon - Zone 2100'),
(@FIRST_POOL_ENTRY + 20, 1, 'Spawn Point 2 - Maraudon - Zone 2100'),
(@FIRST_POOL_ENTRY + 21, 1, 'Spawn Point 3 - Maraudon - Zone 2100'),
(@FIRST_POOL_ENTRY + 22, 1, 'Spawn Point 1 - Winterspring - Zone 618'),
(@FIRST_POOL_ENTRY + 23, 1, 'Spawn Point 1 - Hellfire Peninsula - Zone 3483'),
(@FIRST_POOL_ENTRY + 24, 1, 'Spawn Point 2 - Hellfire Peninsula - Zone 3483'),
(@FIRST_POOL_ENTRY + 25, 1, 'Spawn Point 1 - Nagrand - Zone 3518'),
(@FIRST_POOL_ENTRY + 26, 1, 'Spawn Point 2 - Nagrand - Zone 3518'),
(@FIRST_POOL_ENTRY + 27, 1, 'Spawn Point 3 - Nagrand - Zone 3518'),
(@FIRST_POOL_ENTRY + 28, 1, 'Spawn Point 4 - Nagrand - Zone 3518'),
(@FIRST_POOL_ENTRY + 29, 1, 'Spawn Point 5 - Nagrand - Zone 3518'),
(@FIRST_POOL_ENTRY + 30, 1, 'Spawn Point 1 - Terokkar Forest - Zone 3519'),
(@FIRST_POOL_ENTRY + 31, 1, 'Spawn Point 2 - Terokkar Forest - Zone 3519'),
(@FIRST_POOL_ENTRY + 32, 1, 'Spawn Point 3 - Terokkar Forest - Zone 3519'),
(@FIRST_POOL_ENTRY + 33, 1, 'Spawn Point 1 - Mana-Tombs - Zone 3792'),
(@FIRST_POOL_ENTRY + 34, 1, 'Spawn Point 1 - The Underbog - Zone 3716'),
(@FIRST_POOL_ENTRY + 35, 1, 'Spawn Point 1 - Zangarmarsh - Zone 3521');

CREATE TABLE TEMP_POOL_POOL_ENTRIES (pool_id int, mother_pool int, chance int, description char(64));
INSERT INTO TEMP_POOL_POOL_ENTRIES VALUES
(@FIRST_POOL_ENTRY + 0 , @FIRST_MASTER_POOL_ENTRY + 0, 0, 'Spawn Point 1 - Redridge Mountains - Zone 44'),
(@FIRST_POOL_ENTRY + 1 , @FIRST_MASTER_POOL_ENTRY + 1, 0, 'Spawn Point 1 - Stranglethorn Vale - Zone 33'),
(@FIRST_POOL_ENTRY + 2 , @FIRST_MASTER_POOL_ENTRY + 1, 0, 'Spawn Point 2 - Stranglethorn Vale - Zone 33'),
(@FIRST_POOL_ENTRY + 3 , @FIRST_MASTER_POOL_ENTRY + 1, 0, 'Spawn Point 3 - Stranglethorn Vale - Zone 33'),
(@FIRST_POOL_ENTRY + 4 , @FIRST_MASTER_POOL_ENTRY + 2, 0, 'Spawn Point 1 - Thousand Needles - Zone 400'),
(@FIRST_POOL_ENTRY + 5 , @FIRST_MASTER_POOL_ENTRY + 3, 0, 'Spawn Point 1 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 6 , @FIRST_MASTER_POOL_ENTRY + 3, 0, 'Spawn Point 2 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 7 , @FIRST_MASTER_POOL_ENTRY + 3, 0, 'Spawn Point 3 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 8 , @FIRST_MASTER_POOL_ENTRY + 3, 0, 'Spawn Point 4 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 9 , @FIRST_MASTER_POOL_ENTRY + 3, 0, 'Spawn Point 5 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 10, @FIRST_MASTER_POOL_ENTRY + 3, 0, 'Spawn Point 6 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 11, @FIRST_MASTER_POOL_ENTRY + 3, 0, 'Spawn Point 7 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 12, @FIRST_MASTER_POOL_ENTRY + 3, 0, 'Spawn Point 8 - Searing Gorge - Zone 51'),
(@FIRST_POOL_ENTRY + 13, @FIRST_MASTER_POOL_ENTRY + 4, 0, 'Spawn Point 1 - Uldaman - Zone 1337'),
(@FIRST_POOL_ENTRY + 14, @FIRST_MASTER_POOL_ENTRY + 5, 0, 'Spawn Point 1 - Desolace - Zone 405'),
(@FIRST_POOL_ENTRY + 15, @FIRST_MASTER_POOL_ENTRY + 6, 0, 'Spawn Point 1 - Darkshore - Zone 148'),
(@FIRST_POOL_ENTRY + 16, @FIRST_MASTER_POOL_ENTRY + 7, 0, 'Spawn Point 1 - Silverpine Forest - Zone 130'),
(@FIRST_POOL_ENTRY + 17, @FIRST_MASTER_POOL_ENTRY + 8, 0, 'Spawn Point 1 - Blackfathom Deeps - Zone 719'),
(@FIRST_POOL_ENTRY + 18, @FIRST_MASTER_POOL_ENTRY + 9, 0, 'Spawn Point 1 - Tanaris - Zone 440'),
(@FIRST_POOL_ENTRY + 19, @FIRST_MASTER_POOL_ENTRY + 10, 0, 'Spawn Point 1 - Maraudon - Zone 2100'),
(@FIRST_POOL_ENTRY + 20, @FIRST_MASTER_POOL_ENTRY + 10, 0, 'Spawn Point 2 - Maraudon - Zone 2100'),
(@FIRST_POOL_ENTRY + 21, @FIRST_MASTER_POOL_ENTRY + 10, 0, 'Spawn Point 3 - Maraudon - Zone 2100'),
(@FIRST_POOL_ENTRY + 22, @FIRST_MASTER_POOL_ENTRY + 11, 0, 'Spawn Point 1 - Winterspring - Zone 618'),
(@FIRST_POOL_ENTRY + 23, @FIRST_MASTER_POOL_ENTRY + 12, 0, 'Spawn Point 1 - Hellfire Peninsula - Zone 3483'),
(@FIRST_POOL_ENTRY + 24, @FIRST_MASTER_POOL_ENTRY + 12, 0, 'Spawn Point 2 - Hellfire Peninsula - Zone 3483'),
(@FIRST_POOL_ENTRY + 25, @FIRST_MASTER_POOL_ENTRY + 13, 0, 'Spawn Point 1 - Nagrand - Zone 3518'),
(@FIRST_POOL_ENTRY + 26, @FIRST_MASTER_POOL_ENTRY + 13, 0, 'Spawn Point 2 - Nagrand - Zone 3518'),
(@FIRST_POOL_ENTRY + 27, @FIRST_MASTER_POOL_ENTRY + 13, 0, 'Spawn Point 3 - Nagrand - Zone 3518'),
(@FIRST_POOL_ENTRY + 28, @FIRST_MASTER_POOL_ENTRY + 13, 0, 'Spawn Point 4 - Nagrand - Zone 3518'),
(@FIRST_POOL_ENTRY + 29, @FIRST_MASTER_POOL_ENTRY + 13, 0, 'Spawn Point 5 - Nagrand - Zone 3518'),
(@FIRST_POOL_ENTRY + 30, @FIRST_MASTER_POOL_ENTRY + 14, 0, 'Spawn Point 1 - Terokkar Forest - Zone 3519'),
(@FIRST_POOL_ENTRY + 31, @FIRST_MASTER_POOL_ENTRY + 14, 0, 'Spawn Point 2 - Terokkar Forest - Zone 3519'),
(@FIRST_POOL_ENTRY + 32, @FIRST_MASTER_POOL_ENTRY + 14, 0, 'Spawn Point 3 - Terokkar Forest - Zone 3519'),
(@FIRST_POOL_ENTRY + 33, @FIRST_MASTER_POOL_ENTRY + 15, 0, 'Spawn Point 1 - Mana-Tombs - Zone 3792'),
(@FIRST_POOL_ENTRY + 34, @FIRST_MASTER_POOL_ENTRY + 16, 0, 'Spawn Point 1 - The Underbog - Zone 3716'),
(@FIRST_POOL_ENTRY + 35, @FIRST_MASTER_POOL_ENTRY + 17, 0, 'Spawn Point 1 - Zangarmarsh - Zone 3521');

CREATE TABLE TEMP_POOL_ENTRIES (guid int, pool_entry int, chance int, description char(64));
INSERT INTO TEMP_POOL_ENTRIES VALUES 
(5656 , @FIRST_POOL_ENTRY + 0 , 0 , 'Spawn Point 1 - Tin'), # chance inspired by spawn point 74 (pool_entry 4473)
(5749 , @FIRST_POOL_ENTRY + 0 , 20, 'Spawn Point 1 - Silver'),

(5879 , @FIRST_POOL_ENTRY + 1 , 20, 'Spawn Point 1 - Gold'), # chance inspired by spawn point 74 (pool_entry 4473)
(6470 , @FIRST_POOL_ENTRY + 1 , 0 , 'Spawn Point 1 - Iron'),

(63539, @FIRST_POOL_ENTRY + 2 , 0 , 'Spawn Point 2 - Iron'), # chance inspired by spawn point 74 (pool_entry 4473)
(65223, @FIRST_POOL_ENTRY + 2 , 20, 'Spawn Point 2 - Silver'),

(40019, @FIRST_POOL_ENTRY + 3 , 0 , 'Spawn Point 3 - Iron'), # chance inspired by spawn point 74 (pool_entry 4473)
(6187 , @FIRST_POOL_ENTRY + 3 , 0 , 'Spawn Point 3 - Iron'),

(6524 , @FIRST_POOL_ENTRY + 4 , 0 , 'Spawn Point 1 - Iron'), # chance inspired by spawn point 74 (pool_entry 4473)
(17159, @FIRST_POOL_ENTRY + 4 , 0 , 'Spawn Point 1 - Tin'),

(5850 , @FIRST_POOL_ENTRY + 5 , 20, 'Spawn Point 1 - Gold'), # chance is inspired by spawn point 112 (pool_entry 4211)
(7234 , @FIRST_POOL_ENTRY + 5 , 50, 'Spawn Point 1 - Mithril'),
(9535 , @FIRST_POOL_ENTRY + 5 , 20, 'Spawn Point 1 - Truesilver'),
(58117, @FIRST_POOL_ENTRY + 5 , 10, 'Spawn Point 1 - Dark Iron'),

(33606, @FIRST_POOL_ENTRY + 6 , 20, 'Spawn Point 2 - Gold'), # chance inspired by spawn point 46 (pool_entry 4645)
(34816, @FIRST_POOL_ENTRY + 6 , 0 , 'Spawn Point 2 - Mithril'),

(10004, @FIRST_POOL_ENTRY + 7 , 0 , 'Spawn Point 3 - Mithril'), # chance inspired by spawn point 46 (pool_entry 4645)
(35299, @FIRST_POOL_ENTRY + 7 , 20, 'Spawn Point 3 - Truesilver'),

(373  , @FIRST_POOL_ENTRY + 8 , 80, 'Spawn Point 4 - Small Thorium Vein'), # chance inspired by spawn 232 (pool_entry 4331)
(10214, @FIRST_POOL_ENTRY + 8 , 0 , 'Spawn Point 4 - Dark Iron'),

(10007, @FIRST_POOL_ENTRY + 9 , 80, 'Spawn Point 5 - Small Thorium Vein'), # chance inspired by spawn 232 (pool_entry 4331)
(64842, @FIRST_POOL_ENTRY + 9 , 0 , 'Spawn Point 5 - Dark Iron'),

(10103, @FIRST_POOL_ENTRY + 10, 80, 'Spawn Point 6 - Small Thorium Vein'), # chance inspired by spawn 232 (pool_entry 4331)
(56457, @FIRST_POOL_ENTRY + 10, 0 , 'Spawn Point 6 - Dark Iron'),

(10165, @FIRST_POOL_ENTRY + 11, 80, 'Spawn Point 7 - Small Thorium Vein'), # chance inspired by spawn 232 (pool_entry 4331)
(64838, @FIRST_POOL_ENTRY + 11, 0 , 'Spawn Point 7 - Dark Iron'),

(258  , @FIRST_POOL_ENTRY + 12, 80, 'Spawn Point 8 - Small Thorium Vein'), # chance inspired by spawn 232 (pool_entry 4331)
(56819, @FIRST_POOL_ENTRY + 12, 0 , 'Spawn Point 8 - Dark Iron'),

(13024, @FIRST_POOL_ENTRY + 13, 20, 'Spawn Point 1 - Silver'), # chance inspired by spawn point 74 (pool_entry 4473)
(33204, @FIRST_POOL_ENTRY + 13, 0 , 'Spawn Point 1 - Iron'),

(29207, @FIRST_POOL_ENTRY + 14, 50, 'Spawn Point 1 - Truesilver'), # chance inspired by spawn point 46 (pool_entry 4645)
(63514, @FIRST_POOL_ENTRY + 14, 50, 'Spawn Point 1 - Gold'),

(30160, @FIRST_POOL_ENTRY + 15, 20, 'Spawn Point 1 - Silver'), # chance inspired by spawn point 74 (pool_entry 4473)
(48554, @FIRST_POOL_ENTRY + 15, 0 , 'Spawn Point 1 - Tin'),

(35547, @FIRST_POOL_ENTRY + 16, 0 , 'Spawn Point 1 - Tin'), # chance inspired by spawn point 74 (pool_entry 4473)
(42971, @FIRST_POOL_ENTRY + 16, 20, 'Spawn Point 1 - Silver'),

(48120, @FIRST_POOL_ENTRY + 17, 0 , 'Spawn Point 1 - Tin'), # chance inspired by spawn point 74 (pool_entry 4473)
(63507, @FIRST_POOL_ENTRY + 17, 20, 'Spawn Point 1 - Silver'),

(5999 , @FIRST_POOL_ENTRY + 18, 20, 'Spawn Point 1 - Gold'), # chance inspired by spawn point 46 (pool_entry 4645)
(65300, @FIRST_POOL_ENTRY + 18, 0 , 'Spawn Point 1 - Mithril'),

(7232 , @FIRST_POOL_ENTRY + 19, 0 , 'Spawn Point 1 - Mithril'), # chance inspired by spawn point 46 (pool_entry 4645)
(9239 , @FIRST_POOL_ENTRY + 19, 20, 'Spawn Point 1 - Truesilver'),

(7180 , @FIRST_POOL_ENTRY + 20, 0 , 'Spawn Point 2 - Mithril'), # chance inspired by spawn point 46 (pool_entry 4645)
(9406 , @FIRST_POOL_ENTRY + 20, 20, 'Spawn Point 2 - Truesilver'),

(63965, @FIRST_POOL_ENTRY + 21, 0 , 'Spawn Point 3 - Mithril'), # chance inspired by spawn point 46 (pool_entry 4645)
(32922, @FIRST_POOL_ENTRY + 21, 20, 'Spawn Point 3 - Truesilver'),

(9445 , @FIRST_POOL_ENTRY + 22, 0 , 'Spawn Point 1 - Truesilver'), # chance inspired by spawn point 46 (pool_entry 4645)
(18433, @FIRST_POOL_ENTRY + 22, 30, 'Spawn Point 1 - Rich Thorium'),

(42301, @FIRST_POOL_ENTRY + 23, 0 , 'Spawn Point 1 - Fel Iron'), # chance inspired by spawn point 46 (pool_entry 4870)
(61963, @FIRST_POOL_ENTRY + 23, 10, 'Spawn Point 1 - Khorium'), # No reference for fel iron chance, but khorium is seemingly rare

(64873, @FIRST_POOL_ENTRY + 24, 0 , 'Spawn Point 2 - Fel Iron'), # chance inspired by spawn point 46 (pool_entry 4870)
(64885, @FIRST_POOL_ENTRY + 24, 10, 'Spawn Point 2 - Khorium'), # No reference for fel iron chance, but khorium is seemingly rare

(21915, @FIRST_POOL_ENTRY + 25, 10, 'Spawn Point 1 - Khorium'), # chance inspired by spawn point 46 (pool_entry 4870)
(61931, @FIRST_POOL_ENTRY + 25, 0 , 'Spawn Point 1 - Adamantite'),

(21924, @FIRST_POOL_ENTRY + 26, 30, 'Spawn Point 2 - Rich Adamantite'), # chance inspired by spawn point 1 (pool_entry 4870)
(61927, @FIRST_POOL_ENTRY + 26, 0 , 'Spawn Point 2 - Adamantite'),

(40200, @FIRST_POOL_ENTRY + 27, 30, 'Spawn Point 3 - Rich Adamantite'), # chance inspired by spawn point 1 (pool_entry 4870)
(61919, @FIRST_POOL_ENTRY + 27, 0 , 'Spawn Point 3 - Adamantite'),

(42414, @FIRST_POOL_ENTRY + 28, 30, 'Spawn Point 4 - Rich Adamantite'), # chance inspired by spawn point 1 (pool_entry 4870)
(42431, @FIRST_POOL_ENTRY + 28, 0 , 'Spawn Point 4 - Adamantite'),

(61935, @FIRST_POOL_ENTRY + 29, 0 , 'Spawn Point 5 - Adamantite'), # chance inspired by spawn point 1 (pool_entry 4870)
(63206, @FIRST_POOL_ENTRY + 29, 30, 'Spawn Point 5 - Rich Adamantite'),

(40271, @FIRST_POOL_ENTRY + 30, 0 , 'Spawn Point 1 - Adamantite'), # chance inspired by spawn point 1 (pool_entry 4870)
(61962, @FIRST_POOL_ENTRY + 30, 10, 'Spawn Point 1 - Khorium'),

(14124, @FIRST_POOL_ENTRY + 31, 0 , 'Spawn Point 2 - Adamantite'), # chance inspired by spawn point 1 (pool_entry 4870)
(61966, @FIRST_POOL_ENTRY + 31, 10, 'Spawn Point 2 - Khorium'),

(28489, @FIRST_POOL_ENTRY + 32, 0 , 'Spawn Point 3 - Adamantite'), # chance inspired by spawn point 1 (pool_entry 4870)
(64887, @FIRST_POOL_ENTRY + 32, 10, 'Spawn Point 3 - Khorium'),

(43147, @FIRST_POOL_ENTRY + 33, 0 , 'Spawn Point 1 - Adamantite'), # chance inspired by spawn point 1 (pool_entry 4870)
(63197, @FIRST_POOL_ENTRY + 33, 30, 'Spawn Point 1 - Rich Adamantite'),

(61906, @FIRST_POOL_ENTRY + 34, 0 , 'Spawn Point 1 - Adamantite'), # chance inspired by spawn point 1 (pool_entry 4870)
(63200, @FIRST_POOL_ENTRY + 34, 30, 'Spawn Point 1 - Rich Adamantite'),

(34924, @FIRST_POOL_ENTRY + 35, 0 , 'Spawn Point 1 - Adamantite'), # chance inspired by spawn point 1 (pool_entry 4870)
(64884, @FIRST_POOL_ENTRY + 35, 30, 'Spawn Point 1 - Rich Adamantite');

# Deletes any entries with the guids - Should not delete any
DELETE FROM `pool_template` WHERE `entry` IN (SELECT `entry` FROM TEMP_POOL_TEMPLATES);
DELETE FROM `pool_gameobject` WHERE `pool_entry` IN (SELECT `pool_entry` FROM TEMP_POOL_ENTRIES);
DELETE FROM `pool_pool` WHERE `pool_id` IN (SELECT `pool_id` FROM TEMP_POOL_POOL_ENTRIES);
DELETE FROM `pool_pool` WHERE `mother_pool` IN (SELECT `mother_pool` FROM TEMP_POOL_POOL_ENTRIES);
# Deletes any entries with pool_entry - Should not delete any
DELETE FROM `pool_gameobject` WHERE `guid` IN (SELECT `guid` FROM TEMP_POOL_ENTRIES);


INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) SELECT `entry`, `max_limit`, `description` FROM TEMP_POOL_TEMPLATES;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) SELECT `pool_id`, `mother_pool`, `chance`, `description` FROM TEMP_POOL_POOL_ENTRIES;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) SELECT `guid`, `pool_entry`, `chance`, `description` FROM TEMP_POOL_ENTRIES;

DROP TABLE TEMP_POOL_TEMPLATES;
DROP TABLE TEMP_POOL_POOL_ENTRIES;
DROP TABLE TEMP_POOL_ENTRIES;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_24_03' WHERE sql_rev = '1629289212399915700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
