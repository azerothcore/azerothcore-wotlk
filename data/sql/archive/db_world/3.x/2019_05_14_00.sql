-- DB update 2019_05_13_01 -> 2019_05_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_13_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_13_01 2019_05_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1557180801797784400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1557180801797784400');

-- Healthy Dragon Scale https://www.wowdb.com/items/13920-healthy-dragon-scale
DELETE FROM `conditions` WHERE  `SourceGroup`=10678 AND `SourceEntry` IN (13920,5582) AND `ConditionValue1`=5529;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(1, 10678, 13920, 0, 0, 8, 0, 5529, 0, 0, 0, 0, 0, '', 'Healthy Dragon Scale drop if Quest 5529 rewarded');

UPDATE `creature_loot_template` SET `Chance`='6' WHERE `Entry`=10678 AND `Item`=13920;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
