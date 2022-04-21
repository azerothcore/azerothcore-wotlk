-- DB update 2021_12_04_00 -> 2021_12_04_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_04_00 2021_12_04_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637923012381502740'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637923012381502740');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 24016) AND (`Item` IN (18679));

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14457) AND (`Item` IN (18679));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14457, 18679, 0, 40, 0, 1, 0, 1, 1, '');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_04_01' WHERE sql_rev = '1637923012381502740';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
