-- DB update 2021_06_18_01 -> 2021_06_18_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_18_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_18_01 2021_06_18_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623249558553944112'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623249558553944112');

DELETE FROM `creature_loot_template` WHERE `Item` = 9484 AND `Entry` IN (8127, 7267);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8127, 9484, 0, 0.01, 0, 1, 0, 1, 1, 'Antu\'Sul - Spellshock Leggings'),
(7267, 9484, 0, 0.01, 0, 1, 0, 1, 1, 'Cfieg Ukorz Sandscalp - Spellshock Leggings');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_02' WHERE sql_rev = '1623249558553944112';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
