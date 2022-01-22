-- DB update 2020_12_15_00 -> 2020_12_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_15_00 2020_12_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1607085889307075600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1607085889307075600');

-- What The Dragons Know - Horde
UPDATE `quest_poi_points` SET `X`=5892, `Y`=470 WHERE `QuestID`=24555 AND `Idx1`=0 AND `Idx2`=0;
-- What The Dragons Know - Alliance
UPDATE `quest_poi_points` SET `X`=5745, `Y`=720 WHERE `QuestID`=14444 AND `Idx1`=0 AND `Idx2`=0;

-- The Silver Covenant's Scheme - Horde
UPDATE `quest_poi_points` SET `X`=5892, `Y`=470 WHERE `QuestID`=24557 AND `Idx1`=1 AND `Idx2`=0;
UPDATE `quest_poi_points` SET `X`=5760, `Y`=715 WHERE `QuestID`=24557 AND `Idx1`=2 AND `Idx2`=0;

-- The Sunreaver Plan - Alliance
UPDATE `quest_poi_points` SET `X`=5745, `Y`=720 WHERE `QuestID`=14457 AND `Idx1`=1 AND `Idx2`=0;
UPDATE `quest_poi_points` SET `X`=5916, `Y`=554 WHERE  `QuestID`=14457 AND `Idx1`=2 AND `Idx2`=0;

-- A Suitable Disguise - Horde
UPDATE `quest_poi_points` SET `X`=5892, `Y`=470 WHERE `QuestID`=24556 AND `Idx1`=1 AND `Idx2`=0;
UPDATE `quest_poi_points` SET `X`=5806, `Y`=695 WHERE `QuestID`=24556 AND `Idx1`=2 AND `Idx2`=0;
-- A Suitable Disguise - Alliance
UPDATE `quest_poi_points` SET `X`=5745, `Y`=720 WHERE `QuestID`=20438 AND `Idx1`=1 AND `Idx2`=0;
UPDATE `quest_poi_points` SET `X`=5806, `Y`=695 WHERE `QuestID`=20438 AND `Idx1`=2 AND `Idx2`=0;

-- A Victory For The Sunreavers - Horde
UPDATE `quest_poi_points` SET `X`=5800, `Y`=792 WHERE `QuestID`=24800 AND `Idx1`=0 AND `Idx2`=0;
UPDATE `quest_poi_points` SET `X`=5800, `Y`=792 WHERE `QuestID`=24801 AND `Idx1`=0 AND `Idx2`=0;

-- A Victory For The Silver Covenant - Alliance
UPDATE `quest_poi_points` SET `X`=5796, `Y`=799 WHERE `QuestID`=24796 AND `Idx1`=0 AND `Idx2`=0;

-- Reforging The Sword - Alliance
UPDATE `quest_poi_points` SET `X`=5652, `Y`=2106 WHERE  `QuestID`=24461 AND `Idx1`=6 AND `Idx2`=0;

-- The Halls Of Reflection - Alliance
UPDATE `quest_poi_points` SET `X`=5652, `Y`=2106 WHERE  `QuestID`=24480 AND `Idx1`=2 AND `Idx2`=0;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
