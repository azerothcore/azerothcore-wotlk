-- DB update 2020_10_26_01 -> 2020_10_27_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_26_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_26_01 2020_10_27_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601361978416709800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601361978416709800');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

-- Reference: http://web.archive.org/web/20150630004928/https://www.wowhead.com/item=44563/pattern-fur-lining-arcane-resist
DELETE FROM `creature_loot_template` WHERE `entry` IN (31702, 32297) AND `item` = 44563;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(32297, 44563, 0, 0.19, 0, 1, 0, 1, 1),
(31702, 44563, 0, 0.06, 0, 1, 0, 1, 1);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
