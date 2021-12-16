-- DB update 2021_12_12_02 -> 2021_12_12_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_12_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_12_02 2021_12_12_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638926789289565100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638926789289565100');

/* Remove Remove Oil of Immolation, Restorative Potion, Lesser Stoneshield Potion, Elixir of Detect Undead, 
Elixir of Greater Intellect, Iron Ore and Eternium Ore from creature loot tables where they do not belong.
*/

DELETE FROM `creature_loot_template` WHERE (`Item` IN (8956, 9030, 4623, 9144, 9154, 9179, 23427, 2772));

/* Goblin Rocket Fuel - some NPCs still drop this, no blanket delete necessary
*/

DELETE FROM `creature_loot_template` WHERE (`Entry` = 9201) AND (`Item` IN (9061));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 12178) AND (`Item` IN (9061));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 13136) AND (`Item` IN (9061));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 13416) AND (`Item` IN (9061));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 22576) AND (`Item` IN (9061));

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_12_03' WHERE sql_rev = '1638926789289565100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
