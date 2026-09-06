-- DB update 2025_09_06_01 -> 2025_09_06_02
--
-- Changes Scorn's spawn from Event 17 (Scourge Invasion) to 120 (Scourge Invasion - Boss in instance activation)
UPDATE `game_event_creature` SET `eventEntry` = 120 WHERE `guid` = 248652;

-- Adds "FORCE_GOSSIP" for Sever
UPDATE `creature_template` SET `type_flags` = 134217728 WHERE `entry` = 14682;
-- Adds "FORCE_GOSSIP" and changes from "Warrior" to "Paladin" for Balzaphon, Lady Falther'ess and Scorn
UPDATE `creature_template` SET `unit_class` = 2, `type_flags` = 134217728 WHERE `entry` IN (14684, 14686, 14690, 14693);
-- Makes Balzaphon and Revanchion immune to Charge
UPDATE `creature_template` SET `mechanic_immune_mask` = (`mechanic_immune_mask` | 2048) WHERE `entry` IN (14684, 14690);
-- Scorn immune to root
UPDATE `creature_template` SET `mechanic_immune_mask` = (`mechanic_immune_mask` | 64) WHERE `entry` IN (14693);

-- Adds SAI to Sever, Balzaphon, Lady Falther'ess, Revanchion and Lord Blackwood
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (14682, 14684, 14686, 14695);

-- Adds Spirit Particles (purple) to Lord Blackwood
UPDATE `creature_template_addon` SET `auras` = '28126' WHERE `entry` = 14695;

-- Adds Spirit Particles (purple) and Frost Armor to Revanchion
UPDATE `creature_template_addon` SET `auras` = '28126 12556' WHERE `entry` = 14690 ;

-- Adds SAI to Holding Pen (157819)
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 157819;

-- Adds Spirit Particles (purple) to Sever, Balzaphon, Revanchion and Scorn
DELETE FROM `creature_template_addon` WHERE `entry` IN (14684, 14686, 14690, 14693, 14682);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(14682, 0, 0, 0, 1, 0, 0, '28126'),  -- Sever
(14684, 0, 0, 0, 1, 0, 0, '28126'),  -- Balzaphon
(14690, 0, 0, 0, 1, 0, 0, '28126'),  -- Revanchion
(14693, 0, 0, 0, 1, 0, 0, '28126');  -- Scorn

-- Adds Server and Lady Falther'ess texts.
DELETE FROM `creature_text` WHERE `CreatureID` IN (14682, 14686);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14682, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 1191, 0, '[Sever] Sever goes into a frenzy! / %s goes into a frenzy!'),
(14686, 0, 0, 'Thank you for becoming my next victim!', 14, 0, 100, 0, 0, 0, 12429, 0, '[Lady Falther\'ess] Thank you for becoming my next victim!');

-- SmartGameObjectAI
-- 157819 (Holding Pen), when the "holding pen" is opened, saves data variable and sends to lady father'ess so it can be used after as a initatior of encounter with the player.
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryorguid` = 157819;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(157819, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Holding Pen - On Gameobject State Changed - Store Targetlist to Lady Falther\'ess'),
(157819, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 14686, 0, 0, 0, 0, 0, 0, 0, 'Holding Pen - On Gameobject State Changed - Send Target 1 to Lady Falther\'ess'),
(157819, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 14686, 0, 0, 0, 0, 0, 0, 0, 'Holding Pen - On Gameobject State Changed - Set Data 1 1 to Lady Falther\'ess');

-- SmartAI
-- Adds SAI logic to Sever, Balzaphon, Lady Falther'ess, Revanchion and Lord Blackwood
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (14682, 14684, 14686, 14690, 14695);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Sever
(14682, 0, 0, 0, 0, 0, 100, 0, 12000, 31000, 8000, 30000, 0, 0, 11, 17745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sever - In Combat - Cast \'Diseased Spit\''),
(14682, 0, 1, 2, 2, 0, 100, 0, 1, 50, 0, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sever - Between 1-50% Health - Cast \'Frenzy\''),
(14682, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sever - Between 1-50% Health - Say Line 0 "Sever goes into a frenzy!"'),
(14682, 0, 3, 0, 101, 0, 100, 0, 2, 10, 12500, 10000, 15000, 0, 11, 16508, 0, 0, 0, 0, 0, 17, 0, 10, 5, 0, 0, 0, 0, 0, 'Sever - On 2 or More Players in Range - Cast \'Intimidating Roar\''),
-- Balzaphon
(14684, 0, 0, 0, 0, 0, 100, 0, 2000, 7000, 2000, 5000, 0, 0, 11, 16799, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Balzaphon - In Combat - Cast \'Frostbolt\''),
(14684, 0, 1, 0, 0, 0, 100, 0, 6000, 12000, 7000, 15000, 0, 0, 11, 15244, 0, 0, 0, 0, 0, 5, 10, 0, 2, 0, 0, 0, 0, 0, 'Balzaphon - In Combat - Cast \'Cone of Cold\''),
(14684, 0, 2, 0, 0, 0, 100, 0, 10000, 20000, 12000, 20000, 0, 0, 11, 8398, 0, 0, 0, 0, 0, 5, 20, 0, 2, 0, 0, 0, 0, 0, 'Balzaphon - In Combat - Cast \'Frostbolt Volley\''),
-- Lady Falther'ess
(14686, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 28533, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - On Initialize - Cast \'Transform\' (Salma Saldean)'),
(14686, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - On Initialize - Set Faction 35 (Friendly)'),
(14686, 0, 2, 3, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - On Data Set 1 1 - Demorph'),
(14686, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - On Data Set 1 1 - Say Line 0 - Thank you for becoming my next victim! '),
(14686, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - On Data Set 1 1 - Set Faction 21 (Undead, Scourge)'),
(14686, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - On Data Set 1 1 - Start Attacking (Closest Player within 30 yards)'),
(14686, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 28126, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - On Data Set 1 1 - Add Aura \'Spirit Particles (purple)\''),
(14686, 0, 7, 0, 0, 0, 100, 0, 2500, 8000, 10000, 18000, 0, 0, 11, 22743, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - In Combat - Cast \'Ribbon of Souls\''),
(14686, 0, 8, 0, 0, 0, 100, 0, 17500, 20000, 19000, 22000, 0, 0, 11, 17105, 0, 0, 0, 0, 0, 5, 30, 1, 2, 17105, 0, 0, 0, 0, 'Lady Falther\'ess - In Combat - Cast \'Banshee Curse\''),
(14686, 0, 9, 0, 101, 0, 100, 0, 2, 10, 7500, 5000, 6000, 0, 11, 16838, 0, 0, 5, 0, 0, 17, 0, 5, 5, 0, 0, 0, 0, 0, 'Lady Falther\'ess - On 2 or More Players in Range - Cast \'Banshee Shriek\''),
-- Revanchion
(14690, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 12500, 14000, 0, 0, 11, 15245, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Revanchion - In Combat - Cast \'Shadow Bolt Volley\''),
(14690, 0, 1, 0, 0, 0, 100, 0, 13000, 16000, 14000, 18000, 0, 0, 11, 14907, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Revanchion - In Combat - Cast \'Frost Nova\''),
-- Lord Blackwood
(14695, 0, 0, 0, 0, 0, 100, 0, 8000, 16000, 20000, 20000, 0, 0, 11, 7964, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Blackwood - In Combat - Cast \'Smoke Bomb\''),
(14695, 0, 1, 0, 105, 0, 100, 0, 10000, 12000, 10000, 12000, 0, 5, 11, 11972, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Blackwood - On Hostile Casting in Range - Cast \'Shield Bash\''),
(14695, 0, 2, 0, 110, 0, 100, 0, 2000, 20000, 20000, 20000, 0, 1, 11, 20733, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Blackwood - On Melee Range Target - Cast \'Black Arrow\''),
(14695, 0, 3, 0, 110, 0, 100, 0, 0, 0, 2400, 2400, 0, 1, 11, 16496, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Blackwood - On Melee Range Target - Cast \'Shoot\'');
