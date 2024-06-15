-- DB update 2022_02_03_06 -> 2022_02_03_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_03_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_03_06 2022_02_03_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643309943188748904'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643309943188748904');

-- update current loot to 100% per wowhead
UPDATE `gameobject_loot_template` SET `Chance`=100 WHERE  `Entry`=11524 AND `Item`=11614;
UPDATE `gameobject_loot_template` SET `Chance`=100 WHERE  `Entry`=11525 AND `Item`=11615;
UPDATE `gameobject_loot_template` SET `Chance`=100 WHERE  `Entry`=13721 AND `Item`=12827;
UPDATE `gameobject_loot_template` SET `Chance`=100 WHERE  `Entry`=13722 AND `Item`=12830;

-- delete and insert for rerun locking the loot to skill id requirement for loot
-- none currently exist in acdb
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=4 AND `SourceGroup`IN ( 11524, 11525, 13721, 13722);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(4, 13722, 12830, 0, 0, 7, 0, 164, 285, 0, 0, 0, 0, '', 'Blacksmithing Plans - Plans Coruption while having Black Smith skill 285'),
(4, 13721, 12827, 0, 0, 7, 0, 164, 285, 0, 0, 0, 0, '', 'Blacksmithing Plans - Plans Serenity while having Black Smith skill 285'),
(4, 11524, 11614, 0, 0, 7, 0, 164, 285, 0, 0, 0, 0, '', 'Blacksmithing Plans - Plans Dark Iron Mail while having Black Smith skill 285'),
(4, 11525, 11615, 0, 0, 7, 0, 164, 285, 0, 0, 0, 0, '', 'Blacksmithing Plans - Plans Dark Iron Shoulder while having Black Smith skill 285');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_03_07' WHERE sql_rev = '1643309943188748904';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
