-- DB update 2022_04_24_03 -> 2022_04_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_24_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_24_03 2022_04_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1650790172951548882'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650790172951548882');

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 13574) AND (`Item` IN (12812));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13574, 12812, 0, 100, 0, 1, 0, 1, 1, 'Unfired Plate Gauntlets - Unfired Plate Gauntlets');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=4 AND `SourceGroup`=13574;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 13574, 12812, 0, 0, 7, 0, 164, 225, 0, 0, 0, 0, '', 'Unfired Plate Gauntlets while having Blacksmithing skill 225');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_25_00' WHERE sql_rev = '1650790172951548882';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
