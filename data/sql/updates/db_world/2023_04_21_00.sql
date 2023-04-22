-- DB update 2023_04_20_00 -> 2023_04_21_00
-- Trigger SAI Areatrigger 173 if no Ravenclaw Apparition within 30 yards.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 173 AND `SourceId` = 2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 173, 2, 0, 29, 0, 2056, 30, 0, 1, 0, 0, '', 'Trigger Areatrigger 173 if no Ravenclaw Apparition within 30 yards');

-- Areatrigger - On Trigger - Summon Creature 'Ravenclaw Apparition' (The Dead Fields) for 5 minutes.
DELETE FROM `areatrigger_scripts` WHERE `entry` = 173;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (173, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`source_type` = 2 AND `entryorguid` = 173);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(173, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 0, 12, 2056, 3, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 1077, 1539, 28.89, 0, 'Areatrigger - On Trigger - Summon Creature \'Ravenclaw Apparition\' (The Dead Fields)');

-- Move creature_text from Thule Ravencla to Ravenclaw Apparition
DELETE FROM `creature_text` WHERE `CreatureID` IN (1947, 2056);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(2056, 0, 0, 'My minions...', 14, 0, 100, 0, 0, 0, 518, 0, 'Ravenclaw Apparition - Intro'),
(2056, 1, 0, 'The time for conquest approaches quickly.', 14, 0, 100, 0, 0, 0, 519, 0, 'Ravenclaw Apparition'),
(2056, 2, 0, 'Soon, your thirst for destruction will be quenched.', 14, 0, 100, 0, 0, 0, 520, 0, 'Ravenclaw Apparition'),
(2056, 3, 0, 'The rage burning within you will soon find fuel in our enemies.', 14, 0, 100, 0, 0, 0, 521, 0, 'Ravenclaw Apparition'),
(2056, 4, 0, 'I come with news of our conflict with the Rogue Undead.', 14, 0, 100, 0, 0, 0, 522, 0, 'Ravenclaw Apparition'),
(2056, 5, 0, 'The rebels of Lordaeron are small and weak, and know not the joy of serving our Lich King.', 14, 0, 100, 0, 0, 0, 523, 0, 'Ravenclaw Apparition'),
(2056, 6, 0, 'The Dark Lady\'s followers are blind to think they can stand against our might.', 14, 0, 100, 0, 0, 0, 525, 0, 'Ravenclaw Apparition'),
(2056, 7, 0, 'We grow strong, while our foes are surrounded by foes, and weakened by constant attacks.', 14, 0, 100, 0, 0, 0, 526, 0, 'Ravenclaw Apparition'),
(2056, 8, 0, 'Our Lord commands us to make ready for war!', 14, 0, 100, 0, 0, 0, 527, 0, 'Ravenclaw Apparition'),
(2056, 9, 0, 'Prepare yourselves, for we will soon launch an assault against they who called themselves "The Forsaken."', 14, 0, 100, 0, 0, 0, 528, 0, 'Ravenclaw Apparition'),
(2056, 10, 0, 'Make ready for battle, my creations.', 14, 0, 100, 0, 0, 0, 529, 0, 'Ravenclaw Apparition'),
(2056, 11, 0, 'We are the arm of His will.  And we will crush His foes into grave dust!', 14, 0, 100, 0, 0, 0, 530, 0, 'Ravenclaw Apparition'),
(2056, 12, 0, 'These undead rabble, and their dead-elf queen, will fall!', 14, 0, 100, 0, 0, 0, 531, 0, 'Ravenclaw Apparition'),
(2056, 13, 0, 'We will drive our foes from Silverpine, then bring the tides of war to their very capital!', 14, 0, 100, 0, 0, 0, 532, 0, 'Ravenclaw Apparition'),
(2056, 14, 0, 'Death and Praise for the Lich King!', 14, 0, 100, 0, 0, 0, 533, 0, 'Ravenclaw Apparition - Outro');

-- Ravenclaw Apparition
UPDATE `creature_template` SET `AIName` = 'NullCreatureAI', `ScriptName` = 'npc_ravenclaw_apparition' WHERE `entry` = 2056;

-- Rot Hide Gladerunner & Rot Hide Mystic - Add cheer emote (They share creature_text), this is probably better than a hardcode.
DELETE FROM `creature_text` WHERE `CreatureID` IN (1772,1773) AND `GroupID`=1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(1772, 1, 0, '%s cheers!', 16, 0, 100, 4, 0, 0, 3928, 0, 'Rot Hide Gladerunner - Cheer (Apparition event)'),
(1773, 1, 0, '%s cheers!', 16, 0, 100, 4, 0, 0, 3928, 0, 'Rot Hide Mystic - Cheer (Apparition event)');
