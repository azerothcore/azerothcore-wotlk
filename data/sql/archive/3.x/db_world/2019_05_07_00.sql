-- DB update 2019_05_06_00 -> 2019_05_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_06_00 2019_05_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1556522385066705884'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1556522385066705884');

-- Winterskorn Woodsman: Use emote 'STATE_WORK_CHOPWOOD' (234) instead of 'STATE_WORK_MINING' (233)
UPDATE `creature_addon` SET `emote` = 234 WHERE `emote` = 233 AND `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 23662);

-- Various Winterskorn Vrykul: Adjust position, orientation, emotes etc.
UPDATE `creature` SET `orientation` = 4.44648 WHERE `guid` = 106134;
UPDATE `creature` SET `orientation` = 5.32293 WHERE `guid` = 105907;
UPDATE `creature` SET `orientation` = 5.88842 WHERE `guid` = 105914;
UPDATE `creature` SET `orientation` = 6.00623 WHERE `guid` = 106157;
UPDATE `creature` SET `orientation` = 1.27587 WHERE `guid` = 106228;
UPDATE `creature` SET `orientation` = 4.80229 WHERE `guid` = 106276;
UPDATE `creature` SET `orientation` = 1.67247 WHERE `guid` = 106572;
UPDATE `creature` SET `position_x` = 2030.35, `position_y` = -4024.7, `position_z` = 221.943, `orientation` = 2.03606 WHERE `guid` = 106156;
UPDATE `creature` SET `position_x` = 1658.73, `position_y` = -4119.81, `position_z` = 274.861, `orientation` = 0.168438 WHERE `guid` = 106288;
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `guid` IN (106196,106283);
UPDATE `creature_addon` SET `bytes1` = 1, `bytes2` = 0, `emote` = 0 WHERE `guid` = 105907;
UPDATE `creature_addon` SET `emote` = 333 WHERE `guid` IN (106276,106211,106212);
UPDATE `creature_addon` SET `emote` = 375 WHERE `guid` = 106572;
UPDATE `creature_addon` SET `emote` = 0 WHERE `guid` = 106288;
DELETE FROM `creature_addon` WHERE `guid` = 105898;

-- Disable random movement for Winterskorn Rune-Caster (23668) and Winterskorn Oracle (23669) to prevent them from falling down the towers
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `id` IN (23668,23669);

-- Winterskorn Raider (riding on Proto-Drake): Increase flight speed by setting "move_type" to 1 (run)
UPDATE `waypoint_data` SET `move_type` = 1 WHERE `id` = 1063390;
UPDATE `waypoint_data` SET `move_type` = 1 WHERE `id` = 1063400;

-- Winterskorn Raider: Allow mounted combat
UPDATE `creature_template` SET `type_flags` = 2048 WHERE `entry` = 23665;

-- Winterskorn Shield-Maiden: Spar with other Vrykul
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23663 AND `source_type` = 0 AND `id` BETWEEN 4 AND 11;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(23663,0,4,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23663,3,0,0,0,0,0,0,'Winterskorn Shield-Maiden - Out of Combat - Say Line 1 (Winterskorn Shield-Maiden)'),
(23663,0,5,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23663,3,0,0,0,0,0,0,'Winterskorn Shield-Maiden - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Shield-Maiden)'),
(23663,0,6,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23664,3,0,0,0,0,0,0,'Winterskorn Shield-Maiden - Out of Combat - Say Line 1 (Winterskorn Warrior)'),
(23663,0,7,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23664,3,0,0,0,0,0,0,'Winterskorn Shield-Maiden - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Warrior)'),
(23663,0,8,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23665,3,0,0,0,0,0,0,'Winterskorn Shield-Maiden - Out of Combat - Say Line 1 (Winterskorn Raider)'),
(23663,0,9,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23665,3,0,0,0,0,0,0,'Winterskorn Shield-Maiden - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Raider)'),
(23663,0,10,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23666,3,0,0,0,0,0,0,'Winterskorn Shield-Maiden - Out of Combat - Say Line 1 (Winterskorn Berserker)'),
(23663,0,11,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23666,3,0,0,0,0,0,0,'Winterskorn Shield-Maiden - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Berserker)');

-- Winterskorn Warrior: Spar with other Vrykul
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23664 AND `source_type` = 0 AND `id` BETWEEN 3 AND 10;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(23664,0,3,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23663,3,0,0,0,0,0,0,'Winterskorn Warrior - Out of Combat - Say Line 1 (Winterskorn Shield-Maiden)'),
(23664,0,4,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23663,3,0,0,0,0,0,0,'Winterskorn Warrior - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Shield-Maiden)'),
(23664,0,5,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23664,3,0,0,0,0,0,0,'Winterskorn Warrior - Out of Combat - Say Line 1 (Winterskorn Warrior)'),
(23664,0,6,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23664,3,0,0,0,0,0,0,'Winterskorn Warrior - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Warrior)'),
(23664,0,7,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23665,3,0,0,0,0,0,0,'Winterskorn Warrior - Out of Combat - Say Line 1 (Winterskorn Raider)'),
(23664,0,8,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23665,3,0,0,0,0,0,0,'Winterskorn Warrior - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Raider)'),
(23664,0,9,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23666,3,0,0,0,0,0,0,'Winterskorn Warrior - Out of Combat - Say Line 1 (Winterskorn Berserker)'),
(23664,0,10,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23666,3,0,0,0,0,0,0,'Winterskorn Warrior - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Berserker)');

-- Winterskorn Raider: Spar with other Vrykul
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23665 AND `source_type` = 0 AND `id` BETWEEN 4 AND 11;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(23665,0,4,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23663,3,0,0,0,0,0,0,'Winterskorn Raider - Out of Combat - Say Line 1 (Winterskorn Shield-Maiden)'),
(23665,0,5,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23663,3,0,0,0,0,0,0,'Winterskorn Raider - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Shield-Maiden)'),
(23665,0,6,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23664,3,0,0,0,0,0,0,'Winterskorn Raider - Out of Combat - Say Line 1 (Winterskorn Warrior)'),
(23665,0,7,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23664,3,0,0,0,0,0,0,'Winterskorn Raider - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Warrior)'),
(23665,0,8,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23665,3,0,0,0,0,0,0,'Winterskorn Raider - Out of Combat - Say Line 1 (Winterskorn Raider)'),
(23665,0,9,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23665,3,0,0,0,0,0,0,'Winterskorn Raider - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Raider)'),
(23665,0,10,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23666,3,0,0,0,0,0,0,'Winterskorn Raider - Out of Combat - Say Line 1 (Winterskorn Berserker)'),
(23665,0,11,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23666,3,0,0,0,0,0,0,'Winterskorn Raider - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Berserker)');

-- Winterskorn Berserker: Spar with other Vrykul
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23666 AND `source_type` = 0 AND `id` BETWEEN 3 AND 10;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(23666,0,3,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23663,3,0,0,0,0,0,0,'Winterskorn Berserker - Out of Combat - Say Line 1 (Winterskorn Shield-Maiden)'),
(23666,0,4,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23663,3,0,0,0,0,0,0,'Winterskorn Berserker - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Shield-Maiden)'),
(23666,0,5,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23664,3,0,0,0,0,0,0,'Winterskorn Berserker - Out of Combat - Say Line 1 (Winterskorn Warrior)'),
(23666,0,6,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23664,3,0,0,0,0,0,0,'Winterskorn Berserker - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Warrior)'),
(23666,0,7,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23665,3,0,0,0,0,0,0,'Winterskorn Berserker - Out of Combat - Say Line 1 (Winterskorn Raider)'),
(23666,0,8,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23665,3,0,0,0,0,0,0,'Winterskorn Berserker - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Raider)'),
(23666,0,9,0,1,0,100,0,0,60000,15000,70000,0,1,1,0,0,0,0,0,11,23666,3,0,0,0,0,0,0,'Winterskorn Berserker - Out of Combat - Say Line 1 (Winterskorn Berserker)'),
(23666,0,10,0,1,0,100,0,0,5000,5000,10000,0,10,36,38,54,0,0,0,11,23666,3,0,0,0,0,0,0,'Winterskorn Berserker - Out of Combat - Play Emote ''ONESHOT_ATTACK1H'' (Winterskorn Berserker)');

-- Skorn Longhouse NW Bunny: Add fire effect (quest "Burn Skorn, Burn!")
UPDATE `smart_scripts` SET `link` = 1 WHERE `entryorguid` = 24098 AND `source_type` = 0 AND `id` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24098 AND `source_type` = 0 AND `id` IN (1,2);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(24098,0,1,0,61,0,100,0,0,0,0,0,0,67,1,5000,5000,0,0,0,1,0,0,0,0,0,0,0,0,'Skorn Longhouse NW Bunny - Linked - Create Timed Event ID 1'),
(24098,0,2,0,59,0,100,0,1,0,0,0,0,11,42346,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Skorn Longhouse NW Bunny - On Timed Event ID 1 - Cast \'Cosmetic - Flame Patch 2.0\' (42346)');

-- Skorn Longhouse NE Bunny: Add fire effect (quest "Burn Skorn, Burn!")
UPDATE `smart_scripts` SET `link` = 1 WHERE `entryorguid` = 24100 AND `source_type` = 0 AND `id` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24100 AND `source_type` = 0 AND `id` IN (1,2);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(24100,0,1,0,61,0,100,0,0,0,0,0,0,67,1,5000,5000,0,0,0,1,0,0,0,0,0,0,0,0,'Skorn Longhouse NE Bunny - Linked - Create Timed Event ID 1'),
(24100,0,2,0,59,0,100,0,1,0,0,0,0,11,42346,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Skorn Longhouse NE Bunny - On Timed Event ID 1 - Cast \'Cosmetic - Flame Patch 2.0\' (42346)');

-- Skorn Barracks Bunny: Add fire effect (quest "Burn Skorn, Burn!")
UPDATE `smart_scripts` SET `link` = 1 WHERE `entryorguid` = 24102 AND `source_type` = 0 AND `id` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24102 AND `source_type` = 0 AND `id` IN (1,2);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(24102,0,1,0,61,0,100,0,0,0,0,0,0,67,1,5000,5000,0,0,0,1,0,0,0,0,0,0,0,0,'Skorn Barracks Bunny - Linked - Create Timed Event ID 1'),
(24102,0,2,0,59,0,100,0,1,0,0,0,0,11,42346,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Skorn Barracks Bunny - On Timed Event ID 1 - Cast \'Cosmetic - Flame Patch 2.0\' (42346)');

-- Winterhoof Brave: Set react state to defensive; cast spell "Loan Spyglass" when selecting the gossip option "Please loan me that spyglass."
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24130;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24130 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(24130,0,0,0,54,0,100,0,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Winterhoof Brave - On Just Summoned - Set React State Defensive'),
(24130,0,1,0,62,0,100,0,8899,0,0,0,0,11,43103,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Winterhoof Brave - On Gossip Select Menu ID 8899 - Cast Spell ''Loan Spyglass'' (43103)');

-- Winterhoof Brave: Only show gossip option "Please loan me that spyglass." if "Brave's Spyglass" is not in the inventory
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 8899;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8899,0,0,0,2,0,33341,1,0,1,0,0,'','Winterhoof Brave - Loan Spyglass - Show gossip option only if ''Brave''s Spyglass'' not in inventory');

-- Westguard Sergeant: Set react state to defensive; cast spell "Loan Spyglass" when selecting the gossip option "Sergeant, loan me your spyglass."
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24060;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24060 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(24060,0,0,0,54,0,100,0,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Westguard Sergeant - On Just Summoned - Set React State Defensive'),
(24060,0,1,0,62,0,100,0,8886,0,0,0,0,11,43084,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Westguard Sergeant - On Gossip Select Menu ID 8886 - Cast Spell ''Loan Spyglass'' (43084)');

-- Westguard Sergeant: Only show gossip option "Sergeant, loan me your spyglass." if "Sergeant's Spyglass" is not in the inventory
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 8886;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8886,0,0,0,2,0,33336,1,0,1,0,0,'','Westguard Sergeant - Loan Spyglass - Show gossip option only if ''Sergeant''s Spyglass'' not in inventory');

-- Enable "Winterhoof Emblem" to also dismiss the Winterhoof Brave:
DELETE FROM `spell_script_names` WHERE `spell_id` = 43102;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`)
VALUES
(43102,'spell_item_summon_or_dismiss');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
