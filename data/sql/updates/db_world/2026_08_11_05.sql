-- DB update 2026_08_11_04 -> 2026_08_11_05
-- Berserkers
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 43291) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 24221) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 43291, 0, 0, 31, 0, 3, 24221, 0, 0, 0, 0, '', 'Throw Bottle (43291) Targets Dragonflayer Berserker Target (24221)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24216);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24216, 0, 0, 0, 1, 0, 100, 0, 5000, 15000, 10000, 30000, 0, 0, 11, 43291, 0, 0, 0, 0, 0, 9, 24221, 0, 40, 1, 0, 0, 0, 0, 'Dragonflayer Berserker - Out of Combat - Cast \'Throw Bottle\'');

-- Daegarn
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24151);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24151, 0, 0, 0, 1, 0, 100, 0, 30000, 90000, 30000, 90000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daegarn - Out of Combat - Say Line'),
(24151, 0, 1, 0, 60, 0, 100, 0, 60000, 60000, 60000, 60000, 0, 0, 12, 24213, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 799.9138, -4718.5, -96.06109, 3.111555337905884, 'Daegarn - Every Minute - Try Summon Creature \'Firjus the Soul Crusher\' if no Event Creatures are up');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` = 24151) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 24151, 0, 0, 29, 1, 24213, 100, 0, 1, 0, 0, '', 'Firjus the Soul Crusher will not respawn if any creature of its summon chain is still alive'),
(22, 2, 24151, 0, 0, 29, 1, 24214, 100, 0, 1, 0, 0, '', 'Firjus the Soul Crusher will not respawn if any creature of its summon chain is still alive'),
(22, 2, 24151, 0, 0, 29, 1, 24215, 100, 0, 1, 0, 0, '', 'Firjus the Soul Crusher will not respawn if any creature of its summon chain is still alive'),
(22, 2, 24151, 0, 0, 29, 1, 23931, 100, 0, 1, 0, 0, '', 'Firjus the Soul Crusher will not respawn if any creature of its summon chain is still alive');

-- Val'kyr Watcher model was wrong as well
DELETE FROM `creature_template_model` WHERE (`CreatureID` = 24272);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(24272, 1, 24991, 1, 1, 51831),
(24272, 0, 10702, 1, 0, 51831);

-- Fight 1: Firjus the Soul Crusher
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24213);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24213, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Firjus the Soul Crusher - On Aggro - Say Line'),
(24213, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 12000, 15000, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Firjus the Soul Crusher - In Combat - Cast \'Cleave\''),
(24213, 0, 2, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 0, 11, 43348, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Firjus the Soul Crusher - In Combat - Cast \'Head Crush\''),
(24213, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24215, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 831.2024, -4688.374, -94.099174, 4.136430263519287109, 'Firjus the Soul Crusher - On Just Died - Summon Creature \'Jlarborn the Strategist\''),
(24213, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Firjus the Soul Crusher - On Just Summoned - Start Random Movement');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 29) AND (`SourceEntry` = 24213);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(29, 0, 24213, 0, 0, 29, 0, 24215, 100, 0, 1, 0, 0, '', 'Firjus the Soul Crusher will not respawn if any creature of its summon chain is still alive'),
(29, 0, 24213, 0, 0, 29, 0, 24214, 100, 0, 1, 0, 0, '', 'Firjus the Soul Crusher will not respawn if any creature of its summon chain is still alive'),
(29, 0, 24213, 0, 0, 29, 0, 23931, 100, 0, 1, 0, 0, '', 'Firjus the Soul Crusher will not respawn if any creature of its summon chain is still alive');

-- Fight 2: Jlarborn the Strategist
UPDATE `creature_template` SET `unit_flags` = 32768 WHERE (`entry` = 24215);

DELETE FROM `creature_text` WHERE (`CreatureID` = 24215);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24215, 0, 0, 'Firjus was unworthy! Test your battle progress against a true soldier of the Lich King!', 14, 0, 100, 53, 0, 0, 0, 0, 'Jlarborn the Strategist');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2421500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2421500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(2421500, 9, 1, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - Actionlist - Say Line'),
(2421500, 9, 2, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 797.5023, -4727.8794, -96.15342, 0, 'Jlarborn the Strategist - Actionlist - Move To Position');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2421501);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2421501, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - Actionlist - Start Random Movement'),
(2421501, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2421501, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24253, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 0, 823.1166, -4742.7383, -96.06108, 2.391101121902466, 'Jlarborn the Strategist - Actionlist - Summon Creature \'Dragonflayer Prisoner\''),
(2421501, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24253, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 0, 829.2104, -4721.347, -96.06109, 2.949606418609619, 'Jlarborn the Strategist - Actionlist - Summon Creature \'Dragonflayer Prisoner\''),
(2421501, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24253, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 0, 776.1712, -4746.432, -96.06109, 0.8552113175392151, 'Jlarborn the Strategist - Actionlist - Summon Creature \'Dragonflayer Prisoner\''),
(2421501, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24253, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 0, 813.3265, -4697.62, -96.06111, 4.24114990234375, 'Jlarborn the Strategist - Actionlist - Summon Creature \'Dragonflayer Prisoner\''),
(2421501, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24254, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 0, 780.1746, -4749.771, -96.06109, 1.0821040868759155, 'Jlarborn the Strategist - Actionlist - Summon Creature \'Dragonflayer Prisoner\''),
(2421501, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24253, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 0, 767.98413, -4716.7793, -96.06107, 5.98647928237915, 'Jlarborn the Strategist - Actionlist - Summon Creature \'Dragonflayer Prisoner\''),
(2421501, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24254, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 0, 807.8479, -4695.831, -96.06112, 4.398229598999023, 'Jlarborn the Strategist - Actionlist - Summon Creature \'Dragonflayer Prisoner\''),
(2421501, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 13, 186641, 0, 40, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - Actionlist - Open Cages');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24215);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24215, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2421500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - On Just Summoned - Run Script'),
(24215, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2421501, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - On Reached Point 1 - Run Script'),
(24215, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24214, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 832.83167, -4686.3647, -94.09917, 4.084070205688477, 'Jlarborn the Strategist - On Just Died - Summon Creature \'Yorus the Flesh Harvester\''),
(24215, 0, 3, 0, 0, 0, 100, 0, 4000, 5000, 15000, 16000, 0, 0, 11, 12169, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - In Combat - Cast \'Shield Block\''),
(24215, 0, 4, 0, 105, 0, 25, 0, 7000, 8000, 18000, 19000, 0, 5, 11, 38233, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - On Hostile Casting in Range - Cast \'Shield Bash\''),
(24215, 0, 5, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 0, 11, 8374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - In Combat - Cast \'Arcing Smash\'');

-- Fight 3: Yorus the Flesh Harvester
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24214);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24214, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2421500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yorus the Flesh Harvester - On Just Summoned - Run Script'),
(24214, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2421501, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yorus the Flesh Harvester - On Reached Point 1 - Run Script'),
(24214, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 23931, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 834.6791, -4684.6235, -94.09918, 4.084070205688476562, 'Yorus the Flesh Harvester - On Just Died - Summon Creature \'Oluf the Violent\''),
(24214, 0, 3, 0, 0, 0, 100, 0, 4000, 5000, 15000, 16000, 0, 0, 11, 12169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yorus the Flesh Harvester - In Combat - Cast \'Shield Block\''),
(24214, 0, 4, 0, 105, 0, 25, 0, 7000, 8000, 18000, 19000, 0, 5, 11, 38233, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Yorus the Flesh Harvester - On Hostile Casting in Range - Cast \'Shield Bash\''),
(24214, 0, 5, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 0, 11, 8374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Yorus the Flesh Harvester - In Combat - Cast \'Arcing Smash\'');

-- Fight 4: Oluf the Violent
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23931);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23931, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2421500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - On Just Summoned - Run Script'),
(23931, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2421501, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - On Reached Point 1 - Run Script'),
(23931, 0, 2, 0, 0, 0, 100, 0, 3000, 6000, 12000, 15000, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - In Combat - Cast \'Cleave\''),
(23931, 0, 3, 0, 0, 0, 100, 0, 8000, 9000, 28000, 29000, 0, 0, 11, 13730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - In Combat - Cast \'Demoralizing Shout\''),
(23931, 0, 4, 0, 0, 0, 100, 0, 7000, 7000, 21000, 21000, 0, 0, 11, 6533, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - In Combat - Cast \'Net\''),
(23931, 0, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 42870, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - In Combat - Cast \'Throw Dragonflayer Harpoon\''),
(23931, 0, 6, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 0, 11, 41057, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - In Combat - Cast \'Whirlwind\''),
(23931, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43326, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - On Just Died - Cast \'Drop Ancient Cipher\''),
(23931, 0, 8, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - On Just Died - Say Line 1');

-- Prisoners
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2425300, 2425301, 2425302, 2425303, 2425304, 2425305));
UPDATE `creature_template` SET `AIName` = '' WHERE (`entry` = 24253);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24253) AND (`source_type` = 0);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24254);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24254, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 4000, 6000, 0, 0, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Prisoner - In Combat - Cast \'Frostbolt\''),
(24254, 0, 1, 0, 106, 0, 100, 0, 10000, 30000, 20000, 40000, 0, 10, 11, 11831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Prisoner - On Hostile in Range - Cast \'Frost Nova\'');

UPDATE `creature` SET `unit_flags` = `unit_flags`|32768|512|256 WHERE `id` IN (24253, 24254) AND `guid` IN (113775, 113776, 113812, 113813, 113814, 113815, 113844, 113845, 113847, 113848, 113849, 113870, 113871);
