-- DB update 2023_10_21_06 -> 2023_10_22_00
SET @As_Probability=100;
SET @AE_Probability=50;
-- ------------------------------Scarlet Sorcerer-----------------------------
-- Scarlet Sorcerer say
DELETE FROM `creature_text` WHERE `CreatureID`=4294;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- AshbringerEvent Talk
 (4294, 0, 0, 'I am unworthy, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12380, 0, 'Scarlet Sorcerer'),
 (4294, 0, 1, 'Have you come to save this world? To cleanse it?', 12, 0, @As_Probability, 0, 0, 0, 12381, 0, 'Scarlet Sorcerer'),
 (4294, 0, 2, 'My $g Lord:Lady;, please allow me to live long enough to see you purge this world of the infidels.', 12, 0, @As_Probability, 0, 0, 0, 12382, 0, 'Scarlet Sorcerer'),
 (4294, 0, 3, 'And so it begins...', 12, 0, @As_Probability, 0, 0, 0, 12383, 0, 'Scarlet Sorcerer'),
 (4294, 0, 4, 'Take me with you, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12384, 0, 'Scarlet Sorcerer'),
 (4294, 0, 5, 'Ashbringer...', 12, 0, @As_Probability, 0, 0, 0, 12378, 0, 'Scarlet Sorcerer'),
 (4294, 0, 6, 'Kneel! Kneel before the Ashbringer!', 12, 0, @As_Probability, 0, 0, 0, 12379, 0, 'Scarlet Sorcerer'),
-- On Aggro Talk
 (4294, 1, 0, 'You carry the taint of the Scourge.  Prepare to enter the Twisting Nether.', 12, 7, 25, 0, 0, 0, 2625, 0, 'Scarlet Sorcerer'),
 (4294, 1, 1, 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge\'s taint.', 12, 7, 25, 0, 0, 0, 2626, 0, 'Scarlet Sorcerer'),
 (4294, 1, 2, 'The Light condemns all who harbor evil.  Now you will die!', 12, 7, 25, 0, 0, 0, 2627, 0, 'Scarlet Sorcerer'),
 (4294, 1, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 25, 0, 0, 0, 2628, 0, 'Scarlet Sorcerer');

-- Scarlet Sorcerer SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4294;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4294);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4294, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - On Aggro - Say Line 1'),
(4294, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 15000, 25000, 0, 0, 11, 6146, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - In Combat - Cast Slow'),
(4294, 0, 2, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 0, 0, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - In Combat - Cast Frostbolt'),
(4294, 0, 3, 0, 0, 0, 100, 0, 14000, 29000, 19000, 28000, 0, 0, 11, 9672, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - In Combat - Cast Blizzard'),
(4294, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - Between 0-15% Health - Flee For Assist'),
-- AshbringerEvent
(4294, 0, 5, 0, 8, 0, 100, 769, 28441, 0, 0, 0, 0, 0, 80, 429400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - spellhit_target - AshbringerEvent');

-- AshbringerEvent Timed Actionlis
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 429400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(429400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - On Script - Set_Faction Friend'),
(429400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - On Script - stop movement'),
(429400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - On Script - Set Facing player'),
(429400, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - On Script - SetStandState UNIT_STAND_STATE_STAND'),
(429400, 9, 4, 0, 0, 0, 100, 0, 500, 2500, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent  - On Script -  SetSheath  SHEATH_STATE_UNARMED'),
(429400, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - On Script -  SetSheath  UNIT_STAND_STATE_KNEEL'),
(429400, 9, 6, 0, 0, 0, @AE_Probability, 0, 1000, 2000, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - On Script - Talk 0');

-- ------------------------------Scarlet Myrmidon-----------------------------
-- Scarlet Myrmidon say
DELETE FROM `creature_text` WHERE `CreatureID`=4295;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- AshbringerEvent Talk
 (4295, 0, 0, 'I am unworthy, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12380, 0, 'Scarlet Myrmidon'),
 (4295, 0, 1, 'Have you come to save this world? To cleanse it?', 12, 0, @As_Probability, 0, 0, 0, 12381, 0, 'Scarlet Myrmidon'),
 (4295, 0, 2, 'My $g Lord:Lady;, please allow me to live long enough to see you purge this world of the infidels.', 12, 0, @As_Probability, 0, 0, 0, 12382, 0, 'Scarlet Myrmidon'),
 (4295, 0, 3, 'And so it begins...', 12, 0, @As_Probability, 0, 0, 0, 12383, 0, 'Scarlet Myrmidon'),
 (4295, 0, 4, 'Take me with you, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12384, 0, 'Scarlet Myrmidon'),
 (4295, 0, 5, 'Ashbringer...', 12, 0, @As_Probability, 0, 0, 0, 12378, 0, 'Scarlet Myrmidon'),
 (4295, 0, 6, 'Kneel! Kneel before the Ashbringer!', 12, 0, @As_Probability, 0, 0, 0, 12379, 0, 'Scarlet Myrmidon'),
-- On Aggro Talk
 (4295, 1, 0, 'You carry the taint of the Scourge.  Prepare to enter the Twisting Nether.', 12, 7, 25, 0, 0, 0, 2625, 0, 'Scarlet Myrmidon'),
 (4295, 1, 1, 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge\'s taint.', 12, 7, 25, 0, 0, 0, 2626, 0, 'Scarlet Myrmidon'),
 (4295, 1, 2, 'The Light condemns all who harbor evil.  Now you will die!', 12, 7, 25, 0, 0, 0, 2627, 0, 'Scarlet Myrmidon'),
 (4295, 1, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 25, 0, 0, 0, 2628, 0, 'Scarlet Myrmidon'),
 (4295, 2, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 1191, 0, 'Scarlet Myrmidon');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4295;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4295);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4295, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Myrmidon - On Aggro - Say Line 1'),
(4295, 0, 1, 2, 2, 0, 100, 1, 0, 40, 0, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Myrmidon - Between 0-40% Health - Cast Frenzy'),
(4295, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Myrmidon - Between 0-40% Health - Say Line 2'),
-- AshbringerEvent
(4295, 0, 3, 0, 8, 0, 100, 769, 28441, 0, 0, 0, 0, 0, 80, 429400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Myrmidon - spellhit_target - AshbringerEvent');


-- ------------------------------Scarlet Defender -----------------------------
-- Scarlet Defender  say
DELETE FROM `creature_text` WHERE `CreatureID`=4298;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- AshbringerEvent Talk
 (4298, 0, 0, 'I am unworthy, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12380, 0, 'Scarlet Defender'),
 (4298, 0, 1, 'Have you come to save this world? To cleanse it?', 12, 0, @As_Probability, 0, 0, 0, 12381, 0, 'Scarlet Defender'),
 (4298, 0, 2, 'My $g Lord:Lady;, please allow me to live long enough to see you purge this world of the infidels.', 12, 0, @As_Probability, 0, 0, 0, 12382, 0, 'Scarlet Defender'),
 (4298, 0, 3, 'And so it begins...', 12, 0, @As_Probability, 0, 0, 0, 12383, 0, 'Scarlet Defender'),
 (4298, 0, 4, 'Take me with you, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12384, 0, 'Scarlet Defender'),
 (4298, 0, 5, 'Ashbringer...', 12, 0, @As_Probability, 0, 0, 0, 12378, 0, 'Scarlet Defender'),
 (4298, 0, 6, 'Kneel! Kneel before the Ashbringer!', 12, 0, @As_Probability, 0, 0, 0, 12379, 0, 'Scarlet Defender'),
-- On Aggro Talk
 (4298, 1, 0, 'You carry the taint of the Scourge.  Prepare to enter the Twisting Nether.', 12, 7, 25, 0, 0, 0, 2625, 0, 'Scarlet Defender'),
 (4298, 1, 1, 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge\'s taint.', 12, 7, 25, 0, 0, 0, 2626, 0, 'Scarlet Defender'),
 (4298, 1, 2, 'The Light condemns all who harbor evil.  Now you will die!', 12, 7, 25, 0, 0, 0, 2627, 0, 'Scarlet Defender'),
 (4298, 1, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 25, 0, 0, 0, 2628, 0, 'Scarlet Defender');

-- Scarlet Defender  SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4298;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4298);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4298, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 3637, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - On Reset - Cast Improved Blocking III'),
(4298, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - On Aggro - Say Line 1'),
(4298, 0, 2, 0, 0, 0, 100, 0, 0, 2000, 180000, 180000, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - In Combat - Cast Defensive Stance'),
(4298, 0, 3, 0, 13, 0, 100, 0, 8000, 11000, 0, 0, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - Victim Casting - Cast Shield Bash'),
(4298, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - Between 0-15% Health - Flee For Assist'),
-- AshbringerEvent
(4298, 0, 5, 0, 8, 0, 100, 769, 28441, 0, 0, 0, 0, 0, 80, 429400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - spellhit_target - AshbringerEvent');

-- ------------------------------Scarlet Chaplain -----------------------------
-- Scarlet Chaplain say--
DELETE FROM `creature_text` WHERE `CreatureID`=4299;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- AshbringerEvent Talk
 (4299, 0, 0, 'I am unworthy, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12380, 0, 'Ashbringer Event'),
 (4299, 0, 1, 'Have you come to save this world? To cleanse it?', 12, 0, @As_Probability, 0, 0, 0, 12381, 0, 'Ashbringer Event'),
 (4299, 0, 2, 'My $g Lord:Lady;, please allow me to live long enough to see you purge this world of the infidels.', 12, 0, @As_Probability, 0, 0, 0, 12382, 0, 'Scarlet Chaplain'),
 (4299, 0, 3, 'And so it begins...', 12, 0, @As_Probability, 0, 0, 0, 12383, 0, 'Scarlet Chaplain'),
 (4299, 0, 4, 'Take me with you, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12384, 0, 'Scarlet Chaplain'),
 (4299, 0, 5, 'Ashbringer...', 12, 0, @As_Probability, 0, 0, 0, 12378, 0, 'Scarlet Chaplain'),
 (4299, 0, 6, 'Kneel! Kneel before the Ashbringer!', 12, 0, @As_Probability, 0, 0, 0, 12379, 0, 'Scarlet Chaplain'),
-- On Aggro Talk
 (4299, 1, 0, 'You carry the taint of the Scourge.  Prepare to enter the Twisting Nether.', 12, 7, 25, 0, 0, 0, 2625, 0, 'Scarlet Chaplain'),
 (4299, 1, 1, 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge\'s taint.', 12, 7, 25, 0, 0, 0, 2626, 0, 'Scarlet Chaplain'),
 (4299, 1, 2, 'The Light condemns all who harbor evil.  Now you will die!', 12, 7, 25, 0, 0, 0, 2627, 0, 'Scarlet Chaplain'),
 (4299, 1, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 25, 0, 0, 0, 2628, 0, 'Scarlet Chaplain');

-- Scarlet Chaplain SmartAI--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4299;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4299);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4299, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1200000, 1200000, 0, 0, 11, 1006, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - Out of Combat - Cast Inner Fire'),
(4299, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - On Aggro - Say Line 1'),
(4299, 0, 2, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - On Aggro - Set Event Phase'),
(4299, 0, 3, 0, 16, 1, 100, 0, 6066, 40, 8000, 8000, 0, 0, 11, 6066, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - Friendly Missing Buff - Cast Power Word: Shield'),
(4299, 0, 4, 0, 14, 0, 100, 0, 400, 40, 8000, 8000, 0, 0, 11, 8362, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - Friendly Missing Health - Cast Renew'),
(4299, 0, 5, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - Between 0-15% Health - Flee For Assist'),

-- AshbringerEvent
(4299, 0, 6, 0, 8, 0, 100, 769, 28441, 0, 0, 0, 0, 0, 80, 429400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - spellhit_target - AshbringerEvent');

-- ------------------------------Scarlet Wizard -----------------------------
-- Scarlet Wizard say---
DELETE FROM `creature_text` WHERE `CreatureID`=4300;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- AshbringerEvent Talk
 (4300, 0, 0, 'I am unworthy, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12380, 0, 'Scarlet Wizard'),
 (4300, 0, 1, 'Have you come to save this world? To cleanse it?', 12, 0, @As_Probability, 0, 0, 0, 12381, 0, 'Scarlet Wizard'),
 (4300, 0, 2, 'My $g Lord:Lady;, please allow me to live long enough to see you purge this world of the infidels.', 12, 0, @As_Probability, 0, 0, 0, 12382, 0, 'Scarlet Wizard'),
 (4300, 0, 3, 'And so it begins...', 12, 0, @As_Probability, 0, 0, 0, 12383, 0, 'Scarlet Wizard'),
 (4300, 0, 4, 'Take me with you, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12384, 0, 'Scarlet Wizard'),
 (4300, 0, 5, 'Ashbringer...', 12, 0, @As_Probability, 0, 0, 0, 12378, 0, 'Scarlet Wizard'),
 (4300, 0, 6, 'Kneel! Kneel before the Ashbringer!', 12, 0, @As_Probability, 0, 0, 0, 12379, 0, 'Scarlet Wizard'),
-- On Aggro Talk
 (4300, 1, 1, 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge\'s taint.', 12, 7, 25, 0, 0, 0, 2626, 0, 'Scarlet Wizard'),
 (4300, 1, 2, 'The Light condemns all who harbor evil.  Now you will die!', 12, 7, 25, 0, 0, 0, 2627, 0, 'Scarlet Wizard'),
 (4300, 1, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 25, 0, 0, 0, 2628, 0, 'Scarlet Wizard');

-- Scarlet Wizard SmartAI---
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4300;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4300, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Wizard - On Aggro - Say Line 1'),
(4300, 0, 1, 0, 106, 0, 100, 0, 2000, 6000, 7000, 11000, 0, 10, 11, 8439, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Wizard - In Combat - Cast Arcane Explosion'),
(4300, 0, 2, 0, 0, 0, 100, 0, 1000, 5000, 30000, 30000, 0, 0, 11, 2601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Wizard - In Combat - Cast Fire Shield III'),
(4300, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Wizard - Between 0-15% Health - Flee For Assist'),
-- AshbringerEvent
(4300, 0, 4, 0, 8, 0, 100, 769, 28441, 0, 0, 0, 0, 0, 80, 429400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Wizard - spellhit_target - AshbringerEvent');

-- ------------------------------Scarlet Centurion -----------------------------
-- Scarlet Centurion  say--
DELETE FROM `creature_text` WHERE `CreatureID`=4301;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- AshbringerEvent Talk
 (4301, 0, 0, 'I am unworthy, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12380, 0, 'Scarlet Centurion'),
 (4301, 0, 1, 'Have you come to save this world? To cleanse it?', 12, 0, @As_Probability, 0, 0, 0, 12381, 0, 'Scarlet Centurion'),
 (4301, 0, 2, 'My $g Lord:Lady;, please allow me to live long enough to see you purge this world of the infidels.', 12, 0, @As_Probability, 0, 0, 0, 12382, 0, 'Scarlet Centurion'),
 (4301, 0, 3, 'And so it begins...', 12, 0, @As_Probability, 0, 0, 0, 12383, 0, 'Scarlet Centurion'),
 (4301, 0, 4, 'Take me with you, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12384, 0, 'Scarlet Centurion'),
 (4301, 0, 5, 'Ashbringer...', 12, 0, @As_Probability, 0, 0, 0, 12378, 0, 'Scarlet Centurion'),
 (4301, 0, 6, 'Kneel! Kneel before the Ashbringer!', 12, 0, @As_Probability, 0, 0, 0, 12379, 0, 'Scarlet Centurion'),
-- On Aggro Talk
 (4301, 1, 0, 'You carry the taint of the Scourge.  Prepare to enter the Twisting Nether.', 12, 7, 25, 0, 0, 0, 2625, 0, 'Scarlet Centurion'),
 (4301, 1, 1, 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge\'s taint.', 12, 7, 25, 0, 0, 0, 2626, 0, 'Scarlet Centurion'),
 (4301, 1, 2, 'The Light condemns all who harbor evil.  Now you will die!', 12, 7, 25, 0, 0, 0, 2627, 0, 'Scarlet Centurion'),
 (4301, 1, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 25, 0, 0, 0, 2628, 0, 'Scarlet Centurion');

-- Scarlet Centurion  SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4301;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4301);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4301, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Centurion - On Aggro - Say Line 1'),
(4301, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 50000, 70000, 0, 0, 11, 31403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Centurion - In Combat - Cast Battle Shout'),
(4301, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Centurion - Between 0-15% Health - Flee For Assist'),
-- AshbringerEvent
(4301, 0, 3, 0, 8, 0, 100, 769, 28441, 0, 0, 0, 0, 0, 80, 429400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Centurion - spellhit_target - AshbringerEvent');

-- ------------------------------Scarlet Champion-- ------------------------------
-- Scarlet Champion say--
DELETE FROM `creature_text` WHERE `CreatureID`=4302;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- AshbringerEvent Talk
 (4302, 0, 0, 'I am unworthy, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12380, 0, 'Scarlet Champion'),
 (4302, 0, 1, 'Have you come to save this world? To cleanse it?', 12, 0, @As_Probability, 0, 0, 0, 12381, 0, 'Scarlet Champion'),
 (4302, 0, 2, 'My $g Lord:Lady;, please allow me to live long enough to see you purge this world of the infidels.', 12, 0, @As_Probability, 0, 0, 0, 12382, 0, 'Scarlet Champion'),
 (4302, 0, 3, 'And so it begins...', 12, 0, @As_Probability, 0, 0, 0, 12383, 0, 'Scarlet Champion'),
 (4302, 0, 4, 'Take me with you, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12384, 0, 'Scarlet Champion'),
 (4302, 0, 5, 'Ashbringer...', 12, 0, @As_Probability, 0, 0, 0, 12378, 0, 'Scarlet Champion'),
 (4302, 0, 6, 'Kneel! Kneel before the Ashbringer!', 12, 0, @As_Probability, 0, 0, 0, 12379, 0, 'Scarlet Champion'),
-- On Aggro Talk
 (4302, 1, 0, 'You carry the taint of the Scourge.  Prepare to enter the Twisting Nether.', 12, 7, 25, 0, 0, 0, 2625, 0, 'Scarlet Champion'),
 (4302, 1, 1, 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge\'s taint.', 12, 7, 25, 0, 0, 0, 2626, 0, 'Scarlet Champion'),
 (4302, 1, 2, 'The Light condemns all who harbor evil.  Now you will die!', 12, 7, 25, 0, 0, 0, 2627, 0, 'Scarlet Champion'),
 (4302, 1, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 25, 0, 0, 0, 2628, 0, 'Scarlet Champion');
-- Scarlet Champion SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = ''  WHERE `entry` = 4302;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4302);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4302, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Champion - On Aggro - Say Line 1'),
(4302, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 6000, 9000, 0, 0, 11, 17143, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Champion - In Combat - Cast Holy Strike'),
(4302, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Champion - Between 0-15% Health - Flee For Assist'),
-- AshbringerEvent
(4302, 0, 3, 0, 8, 0, 100, 769, 28441, 0, 0, 0, 0, 0, 80, 429400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Champion - spellhit_target - AshbringerEvent');

-- ------------------------------Scarlet Abbot -------
-- Scarlet Abbot say--
DELETE FROM `creature_text` WHERE `CreatureID`=4303;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- AshbringerEvent Talk
 (4303, 0, 0, 'I am unworthy, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12380, 0, 'Scarlet Abbot'),
 (4303, 0, 1, 'Have you come to save this world? To cleanse it?', 12, 0, @As_Probability, 0, 0, 0, 12381, 0, 'Scarlet Abbot'),
 (4303, 0, 2, 'My $g Lord:Lady;, please allow me to live long enough to see you purge this world of the infidels.', 12, 0, @As_Probability, 0, 0, 0, 12382, 0, 'Scarlet Abbot'),
 (4303, 0, 3, 'And so it begins...', 12, 0, @As_Probability, 0, 0, 0, 12383, 0, 'Scarlet Abbot'),
 (4303, 0, 4, 'Take me with you, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12384, 0, 'Scarlet Abbot'),
 (4303, 0, 5, 'Ashbringer...', 12, 0, @As_Probability, 0, 0, 0, 12378, 0, 'Scarlet Abbot'),
 (4303, 0, 6, 'Kneel! Kneel before the Ashbringer!', 12, 0, @As_Probability, 0, 0, 0, 12379, 0, 'Scarlet Abbot'),
-- On Aggro Talk
 (4303, 1, 0, 'You carry the taint of the Scourge.  Prepare to enter the Twisting Nether.', 12, 7, 25, 0, 0, 0, 2625, 0, 'Scarlet Abbot'),
 (4303, 1, 1, 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge\'s taint.', 12, 7, 25, 0, 0, 0, 2626, 0, 'Scarlet Abbot'),
 (4303, 1, 2, 'The Light condemns all who harbor evil.  Now you will die!', 12, 7, 25, 0, 0, 0, 2627, 0, 'Scarlet Abbot'),
 (4303, 1, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 25, 0, 0, 0, 2628, 0, 'Scarlet Abbot'),
 (4303, 2, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 24144, 0, 'Scarlet Abbot');

-- Scarlet Abbot SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4303;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4303);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4303, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - On Aggro - Say Line 1'),
(4303, 0, 1, 0, 14, 0, 100, 0, 400, 40, 8000, 8000, 0, 0, 11, 8362, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - Friendly Missing Health - Cast Renew'),
(4303, 0, 2, 0, 14, 0, 100, 0, 600, 40, 4000, 8000, 0, 0, 11, 6064, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - Friendly Missing Health - Cast Heal'),
(4303, 0, 3, 4, 2, 0, 100, 1, 0, 40, 0, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - Between 0-40% Health - Cast Frenzy'),
(4303, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - Between 0-40% Health - Say Line 2'),
-- AshbringerEvent
(4303, 0, 5, 0, 8, 0, 100, 769, 28441, 0, 0, 0, 0, 0, 80, 429400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - spellhit_target - AshbringerEvent');


-- ------------------------------Scarlet Monk -------
-- Scarlet Monk say --
DELETE FROM `creature_text` WHERE `CreatureID`=4540;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- AshbringerEvent TALK
 (4540, 0, 0, 'I am unworthy, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12380, 0, 'Scarlet Monk'),
 (4540, 0, 1, 'Have you come to save this world? To cleanse it?', 12, 0, @As_Probability, 0, 0, 0, 12381, 0, 'Scarlet Monk'),
 (4540, 0, 2, 'My $g Lord:Lady;, please allow me to live long enough to see you purge this world of the infidels.', 12, 0, @As_Probability, 0, 0, 0, 12382, 0, 'Scarlet Monk'),
 (4540, 0, 3, 'And so it begins...', 12, 0, @As_Probability, 0, 0, 0, 12383, 0, 'Scarlet Monk'),
 (4540, 0, 4, 'Take me with you, $g sir:ma\'am;.', 12, 0, @As_Probability, 0, 0, 0, 12384, 0, 'Scarlet Monk'),
 (4540, 0, 5, 'Ashbringer...', 12, 0, @As_Probability, 0, 0, 0, 12378, 0, 'Scarlet Monk'),
 (4540, 0, 6, 'Kneel! Kneel before the Ashbringer!', 12, 0, @As_Probability, 0, 0, 0, 12379, 0, 'Scarlet Monk'),
-- On Aggro TALK
 (4540, 1, 0, 'You carry the taint of the Scourge.  Prepare to enter the Twisting Nether.', 12, 7, 25, 0, 0, 0, 2625, 0, 'Scarlet Monk'),
 (4540, 1, 1, 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge\'s taint.', 12, 7, 25, 0, 0, 0, 2626, 0, 'Scarlet Monk'),
 (4540, 1, 2, 'The Light condemns all who harbor evil.  Now you will die!', 12, 7, 25, 0, 0, 0, 2627, 0, 'Scarlet Monk'),
 (4540, 1, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 25, 0, 0, 0, 2628, 0, 'Scarlet Monk');

-- Scarlet Monk SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 4540);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4540);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4540, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - On Reset - Cast Thrash'),
(4540, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - On Aggro - Say Line 1'),
(4540, 0, 2, 0, 13, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - Victim Casting - Cast Kick'),
(4540, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - Between 0-15% Health - Flee For Assist'),
-- AshbringerEvent
(4540, 0, 4, 0, 8, 0, 100, 769, 28441, 0, 0, 0, 0, 0, 80, 429400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - spellhit_target - AshbringerEvent');
