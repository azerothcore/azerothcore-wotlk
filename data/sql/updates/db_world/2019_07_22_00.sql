-- DB update 2019_07_21_00 -> 2019_07_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_21_00 2019_07_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1562779174835710547'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1562779174835710547');

-- Remove Socrethar SAI Script for credit
DELETE FROM `smart_scripts` WHERE `entryorguid` = 20132 AND `source_type` = 0;

-- Kaylaan 'kaylaan_the_lost'
DELETE FROM `creature` WHERE `id` = 20794;
DELETE FROM `creature_template` WHERE `entry` = 20794;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`)
VALUES
(20794, 0, 0, 0, 0, 0, 19978, 0, 0, 0, 'Kaylaan the Lost', '', NULL, 0, 71, 71, 1, 35, 0, 1.2, 1.14286, 1, 1, 299, 426, 0, 308, 7.5, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 262, 389, 48, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 20, 6, 1, 0, 0, 1, 0, 0, 'kaylaan_the_lost', 0);

-- Adyen 'adyen_the_lightbringer'
DELETE FROM `creature_template` WHERE `entry` = 61021;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`)
VALUES
(61021, 0, 0, 0, 0, 0, 17881, 0, 0, 0, 'Adyen the Lightwarden', NULL, NULL, 61021, 71, 71, 1, 1806, 1, 1, 1.14286, 1, 1, 296, 424, 0, 290, 4.6, 2000, 2000, 2, 32768, 2048, 0, 0, 0, 0, 0, 0, 260, 387, 37, 7, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14518, 13005, 13952, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 4, 1, 1, 0, 0, 1, 0, 0, 'adyen_the_lightbringer', 0);
DELETE FROM `creature_equip_template` WHERE `CreatureID` = 61021 AND `ID` = 1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (61021, 1, 24014, 0, 0, 18019);

-- Orelis 'exarch_orelis'
DELETE FROM `creature_template` WHERE `entry` = 50002;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`)
VALUES
(50002, 0, 0, 0, 0, 0, 20518, 0, 0, 0, 'Exarch Orelis', '', NULL, 8074, 69, 69, 1, 1806, 3, 1, 1.14286, 1, 0, 245, 346, 0, 298, 1, 2000, 2000, 1, 32768, 2048, 0, 0, 0, 0, 0, 0, 206, 302, 43, 10, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 29426, 16509, 13730, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'exarch_orelis', 0);
DELETE FROM `creature_equip_template` WHERE `CreatureID` = 50002 AND `ID` = 1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (50002, 1, 28488, 0, 0, 18019);

-- Karja 'anchorite_karja'
DELETE FROM `creature_template` WHERE `entry` = 50001;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`)
VALUES
(50001, 0, 0, 0, 0, 0, 18903, 0, 0, 0, 'Anchorite Karja', NULL, NULL, 8112, 69, 69, 1, 1806, 3, 1, 1.14286, 1, 0, 224, 316, 0, 282, 1, 2000, 2000, 2, 32768, 2048, 0, 0, 0, 0, 0, 0, 188, 280, 32, 10, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'anchorite_karja', 0);
DELETE FROM `creature_equip_template` WHERE `CreatureID` = 50001 AND `ID` = 1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (50001, 1, 14873, 0, 0, 18019);

-- trigger
DELETE FROM `creature_template` WHERE `entry` = 50004;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`)
VALUES
(50004, 0, 0, 0, 0, 0, 17881, 0, 0, 0, 'Adyen Trigger', NULL, NULL, 0, 1, 1, 0, 1806, 1, 1, 1.14286, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 1, 0, 128, 'deathblow_to_the_legion_trigger', 0);
DELETE FROM `creature` WHERE `id` = 50004;
INSERT INTO `creature` (`id`, `map`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES ('50004', '530', '17881', '4802.629883', '3775.419922', '210.529999', '5.490000');

-- Socrethar 'socrethar'
UPDATE `creature_template` SET `ScriptName` = 'socrethar', `faction` = 90, `flags_extra` = 2097152 WHERE `entry` = 20132;

-- Ishanah 'npc_ishanah'
UPDATE `creature_template` SET `ScriptName` = 'npc_ishanah' WHERE `entry` = 18538;

-- Orelis gossip text
DELETE FROM `gossip_menu` WHERE `MenuID` = 61021 AND `TextID` = 10210;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (61021, 10210);
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 61021 AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionIcon`, `OptionText`, `BoxBroadcastTextID`) VALUES ('61021', '1', 'I''m ready, Adyen', 18591);

-- Adyen waypath
DELETE FROM `waypoint_data` WHERE `id` = 610210;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(610210, 0, 4814.52, 3767.18, 210.535, 5.72712, 0, 0, 0, 100, 0),
(610210, 1, 4836.75, 3774.64, 207.521, 0.31875, 0, 0, 0, 100, 0),
(610210, 2, 4849.92, 3780.49, 203.479, 0.464049, 0, 0, 0, 100, 0),
(610210, 3, 4860.43, 3791.42, 199.593, 0.808459, 0, 0, 0, 100, 0),
(610210, 4, 4865.64, 3799.13, 199.073, 0.981247, 0, 0, 0, 100, 0),
(610210, 5, 4884.83, 3808.67, 198.972, 0.451103, 0, 0, 0, 100, 0),
(610210, 6, 4889.64, 3811.75, 202.37, 0.568913, 0, 0, 0, 100, 0),
(610210, 7, 4898.13, 3817.17, 208.018, 0.568913, 0, 0, 0, 100, 0),
(610210, 8, 4907.47, 3823.15, 211.487, 0.568913, 0, 0, 0, 100, 0),
(610210, 9, 4925.36, 3834.58, 211.494, 0.568913, 0, 0, 0, 100, 0);

-- Karja waypath
DELETE FROM `waypoint_data` WHERE `id` = 500020;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(500020, 0, 4808.67, 3776.1, 210.545, 0.185895, 0, 0, 0, 100, 0),
(500020, 1, 4808.06, 3770.48, 210.535, 5.71456, 0, 0, 0, 100, 0),
(500020, 2, 4816.65, 3772.83, 210.533, 6.09434, 0, 0, 0, 100, 0),
(500020, 3, 4834.06, 3775.74, 207.883, 0.27454, 0, 0, 0, 100, 0),
(500020, 4, 4846.48, 3781.56, 204.363, 0.570994, 0, 0, 0, 100, 0),
(500020, 5, 4860.04, 3793.51, 199.55, 0.726503, 0, 0, 0, 100, 0),
(500020, 6, 4863.97, 3800.26, 199.238, 1.0438, 0, 0, 0, 100, 0),
(500020, 7, 4884.2, 3811.66, 198.972, 0.512874, 0, 0, 0, 100, 0),
(500020, 8, 4888.17, 3814.1, 202.375, 0.552144, 0, 0, 0, 100, 0),
(500020, 9, 4896.61, 3819.3, 207.936, 0.552144, 0, 0, 0, 100, 0),
(500020, 10, 4905.55, 3824.81, 211.406, 0.552144, 0, 0, 0, 100, 0),
(500020, 11, 4920.23, 3834.34, 211.51, 0.575706, 0, 0, 0, 100, 0);

-- Orelis Waypath
DELETE FROM `waypoint_data` WHERE `id` = 500010;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(500010, 0, 4806.57, 3769.34, 210.538, 5.66707, 0, 0, 0, 100, 0),
(500010, 1, 4821.37, 3766.19, 210.374, 6.15008, 0, 0, 0, 100, 0),
(500010, 2, 4839.46, 3771.1, 207.53, 0.372697, 0, 0, 0, 100, 0),
(500010, 3, 4846.95, 3774.03, 206.033, 0.372697, 0, 0, 0, 100, 0),
(500010, 4, 4860.74, 3785.41, 200.083, 0.689998, 0, 0, 0, 100, 0),
(500010, 5, 4865.44, 3792.8, 199.435, 0.689998, 0, 0, 0, 100, 0),
(500010, 6, 4866.07, 3796.41, 199.129, 0.689998, 0, 0, 0, 100, 0),
(500010, 7, 4881.95, 3802.56, 198.972, 0.689998, 0, 0, 0, 100, 0),
(500010, 8, 4887.37, 3807.19, 198.972, 0.689998, 0, 0, 0, 100, 0),
(500010, 9, 4891.19, 3809.42, 202.444, 0.689998, 0, 0, 0, 100, 0),
(500010, 10, 4899.87, 3814.46, 208.038, 0.689998, 0, 0, 0, 100, 0),
(500010, 11, 4909.45, 3820.04, 211.488, 0.689998, 0, 0, 0, 100, 0),
(500010, 12, 4924.99, 3829.07, 211.494, 0.689998, 0, 0, 0, 100, 0);

-- Kaylaan Waypath
DELETE FROM `waypoint_data` WHERE `id` = 207940 OR `id` = 207941 OR `id` = 207942;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(207940, 0, 4955.27, 3896.54, 211.923, 4.59521, 0, 0, 0, 100, 0),
(207940, 1, 4951.58, 3879.44, 212.116, 2.49311, 0, 0, 0, 100, 0),
(207940, 2, 4943.43, 3862.68, 211.598, 4.18681, 0, 0, 0, 100, 0),
(207940, 3, 4941.09, 3856.62, 211.498, 4.63841, 0, 0, 0, 100, 0),
(207940, 4, 4942.28, 3852.59, 211.464, 4.99969, 0, 0, 0, 100, 0),
(207941, 0, 4939.37, 3848.5, 211.503, 4.09257, 0, 0, 0, 100, 0),
(207942, 1, 4943.81, 3840.37, 211.511, 4.97614, 0, 0, 0, 100, 0),
(207942, 0, 4943.32, 3842.17, 211.505, 5.27066, 0, 0, 0, 100, 0);

-- Ishanah Waypath
DELETE FROM `waypoint_data` WHERE `id` = 500050;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(500050, 0, 4937.61, 3832.38, 211.461, 0.534084, 0, 1, 0, 100, 0),
(500050, 1, 4941.01, 3835.17, 211.478, 0.687237, 0, 0, 0, 100, 0),
(500050, 2, 4941.84, 3836.43, 211.483, 0.993542, 0, 0, 0, 100, 0);

-- Kaylaan Text
DELETE FROM `creature_text` WHERE `CreatureID` = 20794;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextID`, `TextRange`, `comment`) VALUES
(20794, 0, 0, 'My heart has been filled with hate since our sworn enemies were allowed into our city.  I knew the one known as Voren''thal before he was called a Seer.  It was by his hand that my brother was slain.', 12, 0, 100, 0, 0, 0, 18394, 0, ''),
(20794, 1, 0, 'I turned that hate on the Illidari and the Burning Legion... but they weren''t the ones who betrayed us.  We were the naaru''s chosen!  We lived and died for them!', 12, 0, 100, 0, 0, 0, 18395, 0, ''),
(20794, 2, 0, 'Once the hatred in my heart became focused, everything became clear to me.  Shattrath must be destroyed and the naaru with it.', 12, 0, 100, 0, 0, 0, 18396, 0, ''),
(20794, 3, 0, 'You are wrong, Adyen.  My mind has never been clearer.', 12, 0, 100, 0, 0, 0, 18398, 0 ,''),
(20794, 4, 0, 'Yes... master.', 12, 0, 100, 0, 0, 0, 18409, 0 ,''),
(20794, 5, 0, 'Teacher...', 12, 0, 100, 0, 0, 0, 18399, 0 ,''),
(20794, 6, 0, 'No!  What have I done?', 14, 0, 100, 0, 0, 0, 18404, 0 ,''),
(20794, 7, 0, 'Light grant me strength!', 14, 0, 100, 0, 0, 0, 18405, 0 ,'');

-- Socrethar text
DELETE FROM `creature_text` WHERE `CreatureID` = 20132;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextID`, `TextRange`, `comment`) VALUES
(20132, 0, 0, 'Do not make me laugh.  Is this the mighty Aldor army that''s come to defeat me?', 14, 0, 100, 11, 0, 0, 18390, 0, ''),
(20132, 1, 0, 'Yes, let us settle this.  Before we begin, however, there''s somebody I''d like you to meet.', 14, 0, 100, 1, 0, 0, 18392, 0, ''),
(20132, 2, 0, 'Slay these dogs, Kaylaan!  Earn your place in the Burning Legion!', 14, 0, 100, 25, 0, 0, 18407, 0, ''),
(20132, 3, 0, 'What are you waiting for?  Finish them, young one.  Let your hatred burn!', 14, 0, 100, 53, 0, 0, 18408, 0, ''),
(20132, 4, 0, 'You foolish old hag... Why would I do that when I can have you both?', 14, 0, 100, 0, 0, 0, 18402, 0 ,''),
(20132, 5, 0, 'Oh, please!  This is sickening; I''m going to have to kill you all myself.', 14, 0, 100, 0, 0, 0, 18406, 0 ,'');

-- Adyen text
DELETE FROM `creature_text` WHERE `CreatureID` = 61021;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextID`, `TextRange`, `comment`) VALUES
(61021, 0, 0, 'We''re here for you, lost brother.  It is custom to offer you a chance to repent before you are destroyed.  We offer you this chance, as the naaru''s law commands.', 12, 0, 100, 0, 0, 0, 18389, 0, ''),
(61021, 1, 0, 'We may be few, Socrethar, but our faith is strong.  Something you will never understand.  Now that custom has been served, prepare to meet your end.', 12, 0, 100, 0, 0, 0, 18391, 0, ''),
(61021, 2, 0, 'How... how could you?!', 12, 0, 100, 0, 0, 0, 18393, 0, ''),
(61021, 3, 0, 'Socrethar is clouding your mind, Kaylaan!  You do not mean these words!  I remember training you when you were but a youngling.  Your will was strong even then!', 12, 0, 100, 0, 0, 0, 18397, 0, '');

-- Ishanah text
DELETE FROM `creature_text` WHERE `CreatureID` = 18538;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextID`, `TextRange`, `comment`) VALUES
(18538, 0, 0, 'The Light wants its lost son back, Socrethar.', 12, 0, 100, 0, 0, 0, 18400, 0, ''),
(18538, 1, 0, 'I offer myself in exchange.  You will have Ishanah, the High Priestess of the Aldor, as your prisoner if you release Kaylaan from your dark grasp.', 12, 0, 100, 0, 0, 0, 18401, 0, '');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
