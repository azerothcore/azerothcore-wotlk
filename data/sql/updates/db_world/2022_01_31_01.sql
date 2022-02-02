-- DB update 2022_01_31_00 -> 2022_01_31_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_31_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_31_00 2022_01_31_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642904052333135300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642904052333135300');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3281) AND (`Item` IN (4905));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3281, 4905, 0, 100, 1, 1, 0, 1, 1, 'Sarkoth - Sarkoth\'s Mangled Claw');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_31_01' WHERE sql_rev = '1642904052333135300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
