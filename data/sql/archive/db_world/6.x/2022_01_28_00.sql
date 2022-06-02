-- DB update 2022_01_27_05 -> 2022_01_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_27_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_27_05 2022_01_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643306934509705956'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643306934509705956');

SET @REF := 20000;
SET @REFGREY0 := @REF;
SET @REFBEAST := @REF + 2;
SET @REFSPIDER := @REF + 4;

-- *** Update Food Loot Chance ***

DELETE FROM `reference_loot_template` WHERE `Entry` BETWEEN @REF + 14 AND @REF + 18;

-- Food Reference loot for level 1 to 5
SET @REFFOOD0 := @REF + 14;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@REFFOOD0,159,0,33,0,1,1,1,1, 'Food 1-5 - Refreshing Spring Water'),
(@REFFOOD0,4536,0,67,0,1,1,1,1, 'Food 1-5 - Shiny Red Apple');

-- Food Reference loot for level 1 to 5
SET @REFFOOD1 := @REF + 15;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@REFFOOD1,159,0,33,0,1,1,1,1, 'Food 1-5 - Refreshing Spring Water'),
(@REFFOOD1,117,0,67,0,1,1,1,1, 'Food 1-5 - Tough Jerky');

-- Food Reference loot for level 1 to 5
SET @REFFOOD2 := @REF + 16;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@REFFOOD2,159,0,33,0,1,1,1,1, 'Food 1-5 - Refreshing Spring Water'),
(@REFFOOD2,4604,0,67,0,1,1,1,1, 'Food 1-5 - Forest Mushroom Cap');

-- Food Reference loot for level 1 to 5
SET @REFFOOD3 := @REF + 17;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@REFFOOD3,159,0,33,0,1,1,1,1, 'Food 1-5 - Refreshing Spring Water'),
(@REFFOOD3,2070,0,67,0,1,1,1,1, 'Food 1-5 - Darnassian Bleu');

-- Food Reference loot for level 1 to 5
SET @REFFOOD4 := @REF + 18;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@REFFOOD4,159,0,33,0,1,1,1,1, 'Food 1-5 - Refreshing Spring Water'),
(@REFFOOD4,4540,0,67,0,1,1,1,1, 'Food 1-5 - Tough Hunk of Bread');

-- Remove some bad loot
UPDATE `creature_template` SET `lootid`=0 WHERE `entry` IN (416,1733,2673,2674,3193,14872,14874,14884);
DELETE FROM `creature_loot_template` WHERE `entry` IN (416,1733,2673,2674,3193,14872,14874,14884);

-- Update loot for various level 1 - 5 npcs

-- Update loot for Entry 704 : Ragged Timber Wolf
SET @NPC := 704;
DELETE FROM `creature_loot_template` WHERE `Entry`=@NPC;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@NPC,0,@REFBEAST,100,0,1,0,1,1, 'Ragged Timber Wolf - (Beast 1-5 EXP 0 ReferenceTable)'),
(@NPC,0,@REFBEAST,30,0,1,1,1,1, 'Ragged Timber Wolf - (Beast 1-5 EXP 0 ReferenceTable)'),
(@NPC,0,11111,.2,0,1,0,1,1, 'Ragged Timber Wolf - (Small Pouch ReferenceTable)'),
(@NPC,0,@REFGREY0,20,0,1,0,1,1, 'Ragged Timber Wolf - (Grey 1-5 EXP 0 ReferenceTable)'),
(@NPC,750,0,90,1,1,0,1,1, 'Ragged Timber Wolf - Tough Wolf Meat');

-- Update loot for Entry 1509 : Ragged Scavenger
SET @NPC := 1509;
DELETE FROM `creature_loot_template` WHERE `Entry`=@NPC;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@NPC,0,@REFBEAST,100,0,1,0,1,1, 'Ragged Scavenger - (Beast 1-5 EXP 0 ReferenceTable)'),
(@NPC,0,@REFBEAST,30,0,1,1,1,1, 'Ragged Scavenger - (Beast 1-5 EXP 0 ReferenceTable)'),
(@NPC,0,11111,.2,0,1,0,1,1, 'Ragged Scavenger - (Small Pouch ReferenceTable)'),
(@NPC,0,@REFGREY0,20,0,1,0,1,1, 'Ragged Scavenger - (Grey 1-5 EXP 0 ReferenceTable)'),
(@NPC,3265,0,90,1,1,0,1,1, 'Ragged Scavenger - Scavenger Paw');

-- Update loot for Entry 1513 : Mangy Duskbat
SET @NPC := 1513;
DELETE FROM `creature_loot_template` WHERE `Entry`=@NPC;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@NPC,0,@REFBEAST,100,0,1,0,1,1, 'Mangy Duskbat - (Beast 1-5 EXP 0 ReferenceTable)'),
(@NPC,0,@REFBEAST,30,0,1,1,1,1, 'Mangy Duskbat - (Beast 1-5 EXP 0 ReferenceTable)'),
(@NPC,0,11111,.2,0,1,0,1,1, 'Mangy Duskbat - (Small Pouch ReferenceTable)'),
(@NPC,0,@REFGREY0,20,0,1,0,1,1, 'Mangy Duskbat - (Grey 1-5 EXP 0 ReferenceTable)'),
(@NPC,3264,0,90,1,1,0,1,1, 'Mangy Duskbat - Duskbat Wing');

-- Update loot for Entry 1688 : Night Web Matriarch
SET @NPC := 1688;
DELETE FROM `creature_loot_template` WHERE `Entry`=@NPC;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@NPC,0,@REFSPIDER,100,0,1,0,1,1, 'Night Web Matriarch - (Spider 1-5 EXP 0 ReferenceTable)'),
(@NPC,0,@REFSPIDER,30,0,1,1,1,1, 'Night Web Matriarch - (Spider 1-5 EXP 0 ReferenceTable)'),
(@NPC,0,11111,.2,0,1,0,1,1, 'Night Web Matriarch - (Small Pouch ReferenceTable)'),
(@NPC,0,@REFGREY0,20,0,1,0,1,1, 'Night Web Matriarch - (Grey 1-5 EXP 0 ReferenceTable)'),
(@NPC,3261,0,2,0,1,0,1,1, 'Webwood Matriarch - Webbed Cloak');

-- Update loot for Entry 15644 : Wretched Urchin
SET @NPC := 15644;
DELETE FROM `creature_loot_template` WHERE `Entry`=@NPC;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@NPC,0,@REFFOOD4,100,0,1,0,1,1, 'Wretched Urchin - (Food 1-5 EXP 1 ReferenceTable)'),
(@NPC,0,@REFGREY0,30,0,1,0,1,1, 'Wretched Urchin - (Grey 1-5 EXP 0 ReferenceTable)'),
(@NPC,0,11111,.2,0,1,0,1,1, 'Wretched Urchin - (Small Pouch ReferenceTable)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_28_00' WHERE sql_rev = '1643306934509705956';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
