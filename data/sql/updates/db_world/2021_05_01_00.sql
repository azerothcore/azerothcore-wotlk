-- DB update 2021_04_30_05 -> 2021_05_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_30_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_30_05 2021_05_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1618990113391357800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618990113391357800');

-- Scourge Soulbinder
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32284;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 32284;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32284, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2500, 3000, 0, 11, 60814, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Scourge Soulbinder - In Combat CMC - Cast 'Frost Blast'"),
(32284, 0, 1, 0, 0, 0, 100, 0, 9000, 14000, 14000, 20000, 0, 11, 22744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Scourge Soulbinder - In Combat - Cast 'Chains of Ice'"),
(32284, 0, 2, 0, 0, 0, 100, 0, 12600, 25200, 16700, 32300, 0, 11, 17620, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Scourge Soulbinder - In Combat - Cast 'Drain Life'");

-- Pustulent Colossus
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32482;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 32482;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32482, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 10000, 15000, 0, 11, 28405, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Pustulent Colossus - In Combat - Cast 'Knockback'"),
(32482, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 11, 63546, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Pustulent Colossus - In Combat - Cast 'Stomp'");

-- Corp'rethar Guardian https://www.youtube.com/watch?v=RwVs6nKQIws
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32280;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 32280;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32280, 0, 0, 0, 0, 0, 100, 0, 10000, 10000, 20000, 25000, 0, 11, 54378, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Corp'rethar Guardian - In Combat - Cast 'Mortal Wound'"),
(32280, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 20000, 25000, 0, 11, 60927, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Corp'rethar Guardian - In Combat - Cast 'Infected Bite'");

-- Bone Sentinel
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32299;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 32299;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32299, 0, 0, 0, 0, 0, 100, 0, 7000, 9000, 9000, 11000, 0, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Bone Sentinel - In Combat - Cast 'Mortal Strike'");

-- Bone Guard
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32479;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 32479;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32479, 0, 0, 0, 0, 0, 100, 0, 7000, 9000, 9000, 11000, 0, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Bone Guard - In Combat - Cast 'Mortal Strike'");

-- Frostbrood Skytalon
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31137;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 31137 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31137, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 5000, 15000, 11, 60667, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Frostbrood Skytalon - In Combat - Cast 'Frost Breath'");

-- Necrotic Webspinner
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31747;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 31747;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31747, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 12000, 16000, 0, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Necrotic Webspinner - In Combat - Cast 'Poison'"),
(31747, 0, 1, 0, 0, 0, 100, 0, 1000, 3000, 10000, 15000, 0, 11, 745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Necrotic Webspinner - In Combat - Cast 'Web'");

-- Frostbrood Matriarch
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32492;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 32492;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32492, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 10000, 20000, 0, 11, 60667, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Frostbrood Matriarch - In Combat - Cast 'Frost Breath'");

-- Vargul Wanderer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32505;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 32505;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32505, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36788, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Vargul Wanderer - On aggro - Cast 'Diminish Soul'");

-- Ravaged Ghoul
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32502;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 32502;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32502, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 7000, 11000, 0, 11, 60873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Ravaged Ghoul - In Combat - Cast 'Festering Bite'"),
(32502, 0, 1, 0, 0, 0, 100, 0, 6300, 15200, 16700, 22300, 0, 11, 60872, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Ravaged Ghoul - In Combat - Cast 'Ravenous Claw'");

-- Harbinger of Horror
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32278;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 32278;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32278, 0, 0, 0, 0, 0, 100, 0, 9250, 12500, 16500, 23000, 0, 11, 18099, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Harbinger of Horror - In Combat - Cast 'Chill Nova'"),
(32278, 0, 1, 0, 0, 0, 100, 0, 4300, 7200, 11700, 13500, 0, 11, 60924, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Harbinger of Horror - In Combat - Cast 'Lich Slap'"),
(32278, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 18100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Harbinger of Horror - On aggro - Cast 'Frost Armor'"),
(32278, 0, 3, 0, 0, 0, 100, 0, 2000, 8000, 2000, 8000, 0, 11, 61747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Harbinger of Horror - In Combat - Cast 'Frostbolt'"),
(32278, 0, 4, 0, 0, 0, 100, 0, 7500, 12500, 9500, 17250, 0, 11, 12096, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, "Harbinger of Horror - In Combat - Cast 'Fear'");

-- Master Summoner Zarod
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30746;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 30746;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30746, 0, 0, 0, 0, 0, 100, 0, 9250, 12500, 16500, 23000, 0, 11, 11831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Master Summoner Zarod - In Combat - Cast 'Frost Nova'"),
(30746, 0, 1, 0, 0, 0, 100, 0, 5300, 9200, 11700, 13500, 0, 11, 28873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Master Summoner Zarod - In Combat - Cast 'Lich Slap'"),
(30746, 0, 2, 0, 0, 0, 100, 0, 2000, 5000, 2000, 5000, 0, 11, 9672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Master Summoner Zarod - In Combat - Cast 'Frostbolt'");

-- Update castFlags for Spiked Ghoul
UPDATE `smart_scripts` SET `action_param2`=0 WHERE `entryorguid`=30597 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param2`=0 WHERE `entryorguid`=30597 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- Chained Abomination
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30689;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 30689;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30689, 0, 0, 0, 0, 0, 100, 0, 4250, 7750, 9500, 13250, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Chained Abomination - In Combat - Cast 'Cleave'"),
(30689, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 2500, 5000, 0, 11, 50335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Chained Abomination - In Combat - Cast 'Scourge Hook'");

-- Bone Giant
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31815;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 31815;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31815, 0, 0, 0, 0, 0, 100, 0, 3500, 5750, 7500, 9250, 0, 11, 36405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Bone Giant - In Combat - Cast 'Stomp'");

-- Decomposed Ghoul | https://youtu.be/bK7krvoUMnY?t=60
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31812;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 31812;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31812, 0, 0, 0, 0, 0, 100, 0, 2500, 2500, 120000, 120000, 0, 11, 15716, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Decomposed Ghoul - In Combat - Cast 'Enrage'"),
(31812, 0, 1, 0, 0, 0, 100, 0, 5500, 7200, 11750, 17250, 0, 11, 12097, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Decomposed Ghoul - In Combat - Cast 'Pierce Armor'");

-- Frostskull Magus
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31813;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 31813;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31813, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 3000, 5000, 0, 11, 20297, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Frostskull Magus - In Combat - Cast 'Frostbolt'");

-- Fallen Hero's Spirit
DELETE FROM `smart_scripts` WHERE `entryorguid`=32149 AND `source_type`=0 AND `id`=2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32149, 0, 2, 0, 0, 0, 100, 0, 3000, 5200, 9200, 11500, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Fallen Hero's Spirit - In Combat - Cast 'Strike'");

-- Saronite Shaper
DELETE FROM `smart_scripts` WHERE `entryorguid`=31255 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31255, 0, 0, 0, 0, 0, 100, 0, 5200, 9500, 11750, 16250, 0, 11, 60960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Saronite Shaper - In Combat - Cast 'War Stomp'");

-- Skeletal Runesmith
DELETE FROM `smart_scripts` WHERE `entryorguid`=30921 AND `source_type`=0 AND `id`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30921, 0, 1, 0, 0, 0, 100, 0, 3200, 7500, 9750, 13250, 0, 11, 46202, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Skeletal Runesmith - In Combat - Cast 'Pierce Armor'");

-- Animated Laborer
DELETE FROM `smart_scripts` WHERE `entryorguid`=32267 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32267, 0, 0, 0, 0, 0, 100, 0, 3200, 5500, 7750, 13250, 0, 11, 48374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Animated Laborer - In Combat - Cast 'Puncture Wound'");

-- Risen Laborer
DELETE FROM `smart_scripts` WHERE `entryorguid`=30949 AND `source_type`=0 AND `id`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30949, 0, 1, 0, 0, 0, 100, 0, 3200, 5500, 7750, 13250, 0, 11, 48374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Risen Laborer - In Combat - Cast 'Puncture Wound'");

-- Reanimated Miner
DELETE FROM `smart_scripts` WHERE `entryorguid`=31843 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31843, 0, 0, 0, 0, 0, 100, 0, 3200, 5500, 7750, 13250, 0, 11, 48374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Reanimated Miner - In Combat - Cast 'Puncture Wound'"),
(31843, 0, 1, 0, 0, 0, 100, 0, 6500, 8250, 11500, 16250, 0, 11, 43104, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Reanimated Miner - In Combat - Cast 'Deep Wound'");


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
