-- DB update 2022_05_11_00 -> 2022_05_11_01
-- Add major mattingly and overlord rhuntak creature_text
DELETE FROM `creature_text` WHERE `CreatureID` IN (14394, 14392);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(14394, 0, 0, 'Citizens and allies of Stormwind, on this day, history has been made. $n has laid waste to that which had attempted to usurp the rule of the kingdom. Gather round and join me in honoring our heroes.', 14, 0, 100, 0, 0, 0, 9495, 0, 'Major Mattingly'),
(14394, 1, 0, 'Behold the might of the Alliance! The dread lady, Onyxia, hangs from the arches! Let the rallying cry of the dragon slayer lift your spirits!', 14, 0, 100, 0, 0, 0, 9496, 0, 'Major Mattingly'),
(14392, 0, 0, 'People of the Horde, citizens of Orgrimmar, come, gather round and celebrate a hero of the Horde. On this day, $n, under the auspices of our glorious Warchief, laid a mortal blow against the Black Dragonflight. The brood mother, Onyxia, has been slain!', 14, 0, 100, 0, 0, 0, 9491, 0, 'overlord runthak'),
(14392, 1, 0, 'Bear witness to the undeniable power of your Warchief! Be lifted by the rallying cry of your dragon slayers!', 14, 0, 100, 0, 0, 0, 9492, 0, 'overlord runthak'),
(14392, 2, 0, 'NEFARIAN IS SLAIN! People of Orgrimmar, bow down before the might of $n and $g his:her; allies for they have laid a blow against the Black Dragonflight that is sure to stir the Aspects from their malaise! This defeat shall surely be felt by the father of the Black Flight: Deathwing reels in pain and anguish this day!', 14, 0, 100, 0, 0, 0, 9867, 0, 'overlord runthak'),
(14392, 3, 0, 'Be lifted by $n\'s accomplishment! Revel in $g his:her; rallying cry!', 14, 0, 100, 0, 0, 0, 9868, 0, 'overlord runthak');
-- Add major mattingly and rhuntak smartai
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (14394, 14392);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (14394, 14392)) OR (`source_type` = 9 AND `entryorguid` IN (1439400, 1439200, 1439201)); 
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14394, 0, 0, 1, 20, 0, 100, 512, 7496, 0, 0, 0, 0, 80, 1439400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Mattingly - On Quest Celebrating Good Times Finished - Run Script'),
(14394, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Mattingly - On Quest Celebrating Good Times Finished - Store Targetlist'),
(1439400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Mattingly - Actionlist - Set Active On'),
(1439400, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Mattingly - Actionlist - Remove Npc Flags Questgiver'),
(1439400, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 0, 8000, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Major Mattingly - Actionlist - Say Line 0'),
(1439400, 9, 3, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Major Mattingly - Actionlist - Say Line 1'),
(1439400, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 50, 179558, 7200, 1, 0, 0, 0, 8, 0, 0, 0, 0, -8971.19, 554.141, 105.972, -2.25147, 'Major Mattingly - Actionlist - Summon Gameobject \'The Severed Head of Onyxia\''),
(1439400, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 179558, 100, 0, 0, 0, 0, 0, 0, 'Major Mattingly - Actionlist - Activate Gameobject'),
(1439400, 9, 6, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 11, 22888, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Mattingly - Actionlist - Cast \'Rallying Cry of the Dragonslayer\''),
(1439400, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Mattingly - Actionlist - Add Npc Flags Questgiver'),
(1439400, 9, 8, 0, 0, 0, 100, 0, 7200000, 7200000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 14, 0, 179558, 0, 0, 0, 0, 0, 0, 'Major Mattingly - Actionlist - Despawn Instant'),
(1439400, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Mattingly - Actionlist - Set Active Off'),
(14392, 0, 0, 2, 20, 0, 100, 512, 7491, 0, 0, 0, 0, 80, 1439200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - On Quest \'For All To See\' Finished - Run Script'),
(14392, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - On Quest \'For All To See\' Finished - Store Targetlist'),
(14392, 0, 3, 5, 20, 0, 100, 512, 7784, 0, 0, 0, 0, 80, 1439201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - On Quest \'The Lord of Blackrock\' Finished - Run Script'),
(14392, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - On Quest \'The Lord of Blackrock\' Finished - Store Targetlist'),
(1439200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Set Active On'),
(1439200, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Remove Npc Flags Questgiver'),
(1439200, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 0, 8000, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Say Line 0'),
(1439200, 9, 3, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Say Line 1'),
(1439200, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 50, 179556, 7200, 1, 0, 0, 0, 8, 0, 0, 0, 0, 1536.94, -4409.44, 8.05935, 1.64061, 'Overlord Runthak - Actionlist - Summon Gameobject \'The Severed Head of Onyxia\''),
(1439200, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 179556, 100, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Activate Gameobject'),
(1439200, 9, 6, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 11, 22888, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Cast \'Rallying Cry of the Dragonslayer\''),
(1439200, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Add Npc Flags Questgiver'),
(1439200, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 7200000, 0, 0, 0, 0, 0, 14, 0, 179556, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Despawn In 7200000 ms'),
(1439200, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Set Active Off'),
(1439201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Set Active On'),
(1439201, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Remove Npc Flags Questgiver'),
(1439201, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 2, 8000, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Say Line 2'),
(1439201, 9, 3, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 1, 3, 10000, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Say Line 3'),
(1439201, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 50, 179881, 7200, 1, 0, 0, 0, 8, 0, 0, 0, 0, 1536.94, -4421.62, 7.55304, -1.15192, 'Overlord Runthak - Actionlist - Summon Gameobject \'The Severed Head of Nefarian\''),
(1439201, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 179881, 100, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Activate Gameobject'),
(1439201, 9, 6, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 11, 22888, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Cast \'Rallying Cry of the Dragonslayer\''),
(1439201, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Add Npc Flags Questgiver'),
(1439201, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 7200000, 0, 0, 0, 0, 0, 14, 0, 179881, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Despawn In 7200000 ms'),
(1439201, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - Actionlist - Set Active Off');
-- add conditions so the timed action does not happen if the gameobject is there. 
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 14392) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 179556) AND (`ConditionValue2` = 120) AND (`ConditionValue3` = 0) OR (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 4) AND (`SourceEntry` = 14392) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 179881) AND (`ConditionValue2` = 120) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 14392, 0, 0, 30, 0, 179556, 120, 0, 1, 0, 0, '', ''),
(22, 4, 14392, 0, 0, 30, 0, 179881, 120, 0, 1, 0, 0, '', '');
