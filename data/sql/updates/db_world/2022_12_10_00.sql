-- DB update 2022_12_09_00 -> 2022_12_10_00
--
UPDATE `creature_template` SET `unit_class` = 2 WHERE `entry` IN (19287, 19288, 19290);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19391;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19391) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19391, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 10000, 15000, 0, 11, 3551, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Felguard Lieutenant - In Combat - Cast \'Skull Crack\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19288;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19288) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19288, 0, 0, 0, 0, 0, 100, 0, 15000, 15000, 30000, 30000, 0, 11, 9081, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dreadknight - In Combat - Cast \'Shadow Bolt Volley\''),
(19288, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 5000, 10000, 0, 11, 16583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dreadknight - In Combat - Cast \'Shadow Shock\''),
(19288, 0, 2, 0, 0, 0, 100, 0, 8000, 16000, 8000, 16000, 0, 11, 20825, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dreadknight - In Combat - Cast \'Shadow Bolt\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19290;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19290) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19290, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 30000, 30000, 0, 11, 12888, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Invading Anguisher - In Combat - Cast \'Cause Insanity\''),
(19290, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 30000, 35000, 0, 11, 19279, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Invading Anguisher - In Combat - Cast \'Devouring Plague\''),
(19290, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 20000, 25000, 0, 11, 11639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Invading Anguisher - In Combat - Cast \'Shadow Word: Pain\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19286;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19286) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19286, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 15000, 20000, 0, 11, 32901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Invading Fel Stalker - In Combat - Cast \'Carnivorous Bite\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19287;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19287) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19287, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 12000, 24000, 0, 11, 11829, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Invading Voidwalker - In Combat - Cast \'Flamestrike\''),
(19287, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 5000, 10000, 0, 11, 20825, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Invading Voidwalker - In Combat - Cast \'Shadow Bolt\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19406;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19406) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19406, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 4000, 8000, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Huntsman - In Combat - Cast \'Strike\''),
(19406, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 8000, 12000, 0, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Huntsman - In Combat - Cast \'Backhand\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19407;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19407) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19407, 0, 0, 0, 2, 0, 100, 0, 30, 40, 0, 0, 0, 11, 13874, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Azuremyst Vindicator - Between 40-30% Health - Cast \'Divine Shield\''),
(19407, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 12000, 16000, 0, 11, 13005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azuremyst Vindicator - In Combat - Cast \'Hammer of Justice\''),
(19407, 0, 2, 0, 0, 0, 100, 0, 1000, 1000, 30000, 30000, 0, 11, 33127, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azuremyst Vindicator - In Combat - Cast \'Seal of Command\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19320;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19320) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19320, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 6000, 12000, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Argent Protector - In Combat - Cast \'Shield Bash\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19365;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19365) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19365, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 3000, 3000, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Argent Bowman - In Combat - Cast \'Shoot\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19366;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19366) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19366, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 3000, 3000, 0, 11, 10277, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Argent Hunter - In Combat - Cast \'Throw\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19285;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19285) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19285, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 12000, 18000, 0, 11, 8873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Invading Infernal - In Combat - Cast \'Flame Breath\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19284;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19284);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19284, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 15000, 20000, 0, 11, 11977, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Invading Felguard - In Combat - Cast \'Rend\'');

DELETE FROM `creature_text` WHERE `CreatureID` = 19385;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(19385, 0, 0, 'Marshals... brothers and sisters of the sword. I\'d rather fight alongside you than an army of thousands. We are lions! You know what\'s waiting through these demons and beyond that Dark Portal? Immortality! Take it! ', 14, 0, 100, 0, 0, 0, 16545, 0, 'Lord Marshal Raynor - On Spawn'),
(19385, 1, 0, 'Everyone fights. No one quits.', 12, 0, 100, 0, 0, 0, 16549, 0, 'Lord Marshal Raynor - On Spawn'),
(19385, 1, 1, 'Let us therefore brace ourselves to our duty, and so bear ourselves, that if the Humans of Azeroth last for a thousand years, men will still say, \'This was their finest hour..', 12, 0, 100, 0, 0, 0, 16546, 0, 'Lord Marshal Raynor - Random'),
(19385, 1, 2, 'This day we fight!! By all that you hold dear in these good lands, I bid you stand, heroes of Azeroth!', 12, 0, 100, 0, 0, 0, 16551, 0, 'Lord Marshal Raynor - Random'),
(19385, 1, 3, 'Yes. Fight and you may die. Run and you will live, but for how long? The devils are upon us! And those not here, dying in their villages weeks from now, would they be willing to trade all the days from this day to that, for one chance to come here and stop these horrors from invading our world?', 12, 0, 100, 0, 0, 0, 16548, 0, 'Lord Marshal Raynor - Random'),
(19385, 1, 4, 'Hold your ground! Hold your ground! Sons of the Alliance! Of the Horde! My brothers and sisters! I see in your eyes the same fear that would wither my own heart. A day may come when our courage fails, when we forsake our friends and break our fellowships... but it is not this day!', 12, 0, 100, 0, 0, 0, 16550, 0, 'Lord Marshal Raynor - Random'),
(19385, 1, 5, 'We few, we happy few, we band of brothers and sisters. For those today that shed their blood with me. Shall be my kin; be they never so vile, This day shall gentle their conditions.', 12, 0, 100, 0, 0, 0, 16552, 0, 'Lord Marshal Raynor - Random'),
(19385, 1, 6, 'And those in Azeroth now a-bed shall think themselves accursed they were not here, And hold their valor cheap whiles any speaks that fought with us upon this dark day.', 12, 0, 100, 0, 0, 0, 16553, 0, 'Lord Marshal Raynor - Random'),
(19385, 1, 7, 'It is time for us as kingdoms and as individuals to set aside our long-standing feuds and unite. The tides of an unwinnable war are upon us, and we must seek refuge on higher ground, lest we be swept away by the flood of darkness.', 12, 0, 100, 0, 0, 0, 16547, 0, 'Lord Marshal Raynor - Random'),
(19385, 2, 0, 'Argent Dawn! We go to gather more aid! Fight on, brothers and sisters. And know that you will not long fight alone!', 14, 0, 100, 0, 0, 0, 16934, 0, 'Lord Marshal Raynor - Despawn');
