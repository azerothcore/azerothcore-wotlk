-- DB update 2021_05_25_03 -> 2021_05_25_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_25_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_25_03 2021_05_25_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621414710329639831'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621414710329639831');

SET @SHIVER_BLADE := 5182;
SET @GESHARAHAN := 3398;

DELETE FROM `reference_loot_template` where `Item` = @SHIVER_BLADE;

DELETE FROM `creature_loot_template` WHERE `Entry` = @GESHARAHAN AND `Item` = @SHIVER_BLADE;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@GESHARAHAN, @SHIVER_BLADE, 0, 72.12, 0, 1, 0, 1, 1, "Gesharahan - Shiver Blade");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
