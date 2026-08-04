--
DELETE FROM `spell_script_names` WHERE `spell_id` = 45522;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (45522, 'spell_dispel_freed_soldier_debuff');

DELETE FROM `creature_text` WHERE (`CreatureID` = 25421);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25421, 0, 0, 'Rescued! You have my thanks and my aid, friend.', 12, 1, 100, 5, 0, 0, 24622, 0, 'Warsong Hold Shaman - Released'),
(25421, 0, 1, 'We will battle together to rid this quarry of the Scourge!', 12, 1, 100, 5, 0, 0, 24623, 0, 'Warsong Hold Shaman - Released'),
(25421, 1, 0, 'Ancestors be with you, hero. Farewell!', 12, 1, 100, 0, 0, 0, 24621, 0, 'Warsong Hold Shaman - Dismissed'),
(25421, 1, 1, 'Spirits watch over you, friend. I must make my return to Warsong Hold.', 12, 1, 100, 0, 0, 0, 24620, 0, 'Warsong Hold Shaman - Dismissed');

DELETE FROM `creature_text` WHERE (`CreatureID` = 25414);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25414, 0, 0, 'My axe is yours, hero! Together we will destroy these insects!', 12, 1, 100, 5, 0, 0, 24614, 0, 'Warsong Hold Warrior - Released'),
(25414, 0, 1, 'We will battle together to rid this quarry of the Scourge!', 12, 1, 100, 5, 0, 0, 24623, 0, 'Warsong Hold Warrior - Released'),
(25414, 1, 0, 'I must return to Warsong Hold. Battle hard, hero!', 12, 1, 100, 0, 0, 0, 24615, 0, 'Warsong Hold Warrior - Dismissed'),
(25414, 1, 1, 'I must return to Warsong Hold, hero. May you swim in the blood of our enemies and feast upon their sorrow!', 12, 1, 100, 0, 0, 0, 24616, 0, 'Warsong Hold Warrior - Dismissed'),
(25414, 1, 2, 'Farewell, friend. I must return to Warsong Hold.', 12, 1, 100, 0, 0, 0, 24617, 0, 'Warsong Hold Warrior - Dismissed'),
(25414, 1, 3, 'Until we meet again, hero. Duty calls!', 12, 1, 100, 0, 0, 0, 24618, 0, 'Warsong Hold Warrior - Dismissed');

DELETE FROM `creature_text` WHERE (`CreatureID` = 25420);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25420, 0, 0, 'By the fury of the Sunwell, I am released!', 12, 1, 100, 5, 0, 0, 24624, 0, 'Warsong Hold Mage - Released'),
(25420, 0, 1, 'Vengeance shall be mine! For Quel\'thalas! For the sin\'dorei!', 12, 1, 100, 5, 0, 0, 24625, 0, 'Warsong Hold Mage - Released'),
(25420, 1, 0, 'Farewell, friend. I must return to Warsong Hold.', 12, 1, 100, 0, 0, 0, 24617, 0, 'Warsong Hold Mage - Dismissed'),
(25420, 1, 1, 'Until we meet again, hero. Duty calls!', 12, 1, 100, 0, 0, 0, 24618, 0, 'Warsong Hold Mage - Dismissed');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25420;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25420);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25420, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45525, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - On Just Summoned - Cast \'Arcane Intellect\''),
(25420, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - On Just Summoned - Say Line'),
(25420, 0, 2, 0, 0, 0, 100, 0, 0, 0, 3400, 4800, 0, 0, 11, 14034, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - In Combat - Cast \'Fireball\''),
(25420, 0, 3, 0, 1, 0, 100, 1, 90000, 90000, 0, 0, 0, 0, 80, 2542000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - Out of Combat - Run Script (No Repeat)'),
(25420, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45522, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - On Just Died - Cast \'Dispel Freed Soldier Debuff\''),
(25420, 0, 5, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - On Just Summoned - Set Reactstate Defensive');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2542000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2542000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - Actionlist - Set Reactstate Passive'),
(2542000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - Actionlist - Say Line 1'),
(2542000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - Actionlist - Set Rooted On'),
(2542000, 9, 3, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 0, 11, 45522, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - Actionlist - Cast \'Dispel Freed Soldier Debuff\''),
(2542000, 9, 4, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 11, 41232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - Actionlist - Cast \'Teleport Visual Only\''),
(2542000, 9, 5, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Mage - Actionlist - Despawn Instant');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25414;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25414);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25414, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45517, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - On Just Summoned - Cast \'Commanding Shout\''),
(25414, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - On Just Summoned - Say Line 0'),
(25414, 0, 2, 0, 0, 0, 100, 0, 0, 0, 8400, 17000, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - In Combat - Cast \'Cleave\''),
(25414, 0, 3, 0, 1, 0, 100, 1, 90000, 90000, 0, 0, 0, 0, 80, 2541400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - Out of Combat - Run Script (No Repeat)'),
(25414, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45522, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - On Just Died - Cast \'Dispel Freed Soldier Debuff\''),
(25414, 0, 5, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - On Just Summoned - Set Reactstate Defensive');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2541400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2541400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - Actionlist - Set Reactstate Passive'),
(2541400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - Actionlist - Say Line 1'),
(2541400, 9, 2, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 69, 0, 0, 1, 0, 0, 0, 202, 30, 0, 1, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - Actionlist - Move To Random Point'),
(2541400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45522, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - Actionlist - Cast \'Dispel Freed Soldier Debuff\''),
(2541400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Warrior - Actionlist - Despawn Self');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25421;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25421);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25421, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - On Just Summoned - Say Line'),
(25421, 0, 1, 0, 0, 0, 100, 0, 0, 0, 12000, 16000, 0, 0, 11, 15499, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - In Combat - Cast \'Frost Shock\''),
(25421, 0, 2, 0, 1, 0, 100, 1, 90000, 90000, 0, 0, 0, 0, 80, 2542100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - Out of Combat - Run Script (No Repeat)'),
(25421, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45522, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - On Just Died - Cast \'Dispel Freed Soldier Debuff\''),
(25421, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - On Just Summoned - Set Reactstate Defensive');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2542100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2542100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - Actionlist - Set Reactstate Passive'),
(2542100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - Actionlist - Say Line 1'),
(2542100, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 45528, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - Actionlist - Cast \'Ghost Wolf\''),
(2542100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45522, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - Actionlist - Cast \'Dispel Freed Soldier Debuff\''),
(2542100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 1, 0, 0, 0, 202, 30, 0, 1, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - Actionlist - Move To Random Point'),
(2542100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Hold Shaman - Actionlist - Despawn Self');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25270;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25270);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25270, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2527000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Peon - On Just Summoned - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2527000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2527000, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Peon - Actionlist - Say Line 0'),
(2527000, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 69, 1, 0, 1, 0, 0, 0, 202, 30, 0, 1, 0, 0, 0, 0, 0, 'Warsong Peon - Actionlist - Move To Random Point'),
(2527000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Peon - Actionlist - Despawn Self');

UPDATE `creature_text` SET `Emote` = 5 WHERE (`CreatureID` = 25270);

-- Wow. Never needed to change a class before.
UPDATE `creature_template` SET `unit_class` = 2 WHERE (`entry` = 25421);
UPDATE `creature_template` SET `unit_class` = 2 WHERE (`entry` = 25420);
