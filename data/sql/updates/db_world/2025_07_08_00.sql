-- DB update 2025_07_07_00 -> 2025_07_08_00

-- Set Spell Script
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_chapter2_persuasive_strike';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(52781, 'spell_chapter2_persuasive_strike');

-- Remove Flag Stunned from Scarlet Commanders
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 262144 WHERE (`entry` = 28936);

-- Remove c++ script and set SmartAI for Scarlet Crusaders/Preachers/Commanders/Marksmen
UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` IN (28610, 28936, 28939, 28940);

-- Scarlet Commander SmartAI
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28936) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28936, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 52221, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander - In Combat - Cast \'Heroic Strike\'');

-- Scarlet Crusader SmartAI
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28940) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28940, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 52221, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - In Combat - Cast \'Heroic Strike\'');

-- Scarlet Marksman SmartAI
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28610) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28610, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 32915, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Marksman - In Combat - Cast \'Raptor Strike\'');

-- Scarlet Preacher SmartAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28939);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28939, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 34809, 32, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Preacher - On Update - Cast \'Holy Fury\''),
(28939, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 8000, 12000, 0, 0, 11, 34809, 33, 0, 1, 0, 0, 26, 10, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Preacher - In Combat - Cast \'Holy Fury\''),
(28939, 0, 2, 0, 0, 0, 100, 0, 0, 0, 2500, 2500, 0, 0, 11, 15498, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Preacher - In Combat - Cast \'Holy Smite\''),
(28939, 0, 3, 0, 0, 0, 100, 0, 6000, 12000, 20000, 25000, 0, 0, 11, 19725, 32, 0, 1, 0, 0, 9, 28897, 0, 20, 1, 0, 0, 0, 0, 'Scarlet Preacher - In Combat - Cast \'Turn Undead\'');

-- Condition for Scarlet Commander
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 52781) AND (`SourceId` = 0) AND (`ElseGroup` = 3) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 28936) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 52781, 0, 3, 31, 1, 3, 28936, 0, 0, 27, 0, '', 'Persuasive Strike - Scarlet Commander');

-- Condition for Jesseriah McCree
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 52781) AND (`SourceId` = 0) AND (`ElseGroup` = 4) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 28964) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 52781, 0, 4, 31, 1, 3, 28964, 0, 0, 27, 0, '', 'Persuasive Strike - Scarlet Lord Jesseriah McCree');

-- Add Texts inside McCree's table (for a future implementation).
DELETE FROM `creature_text` WHERE (`CreatureID` = 28964);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28964, 1, 0, 'You\'ll be hanging in the gallows shortly, Scourge fiend!', 12, 0, 100, 0, 0, 0, 29160, 0, 'crusader SAY_CURSADER1'),
(28964, 1, 1, 'You\'ll have to kill me, monster. I will tell you NOTHING!', 12, 0, 100, 0, 0, 0, 29142, 0, 'crusader SAY_CURSADER2'),
(28964, 1, 2, 'You hit like a girl. Honestly. Is that the best you can do?', 12, 0, 100, 0, 0, 0, 29146, 0, 'crusader SAY_CURSADER3'),
(28964, 1, 3, 'ARGH! You burned my last good tabard!', 12, 0, 100, 0, 0, 0, 29162, 0, 'crusader SAY_CURSADER4'),
(28964, 1, 4, 'Argh... The pain... The pain is almost as unbearable as the lashings I received in grammar school when I was but a child.', 12, 0, 100, 0, 0, 0, 29143, 0, 'crusader SAY_CURSADER5'),
(28964, 1, 5, 'I used to work for Grand Inquisitor Isillien! Your idea of pain is a normal mid-afternoon for me!', 12, 0, 100, 0, 0, 0, 29161, 0, 'crusader SAY_CURSADER6'),
(28964, 2, 0, 'I\'ll tell you everything! STOP! PLEASE!', 12, 0, 100, 0, 0, 0, 29149, 0, 'break crusader SAY_PERSUADED1'),
(28964, 3, 0, 'We... We have only been told that the "Crimson Dawn" is an awakening. You... You see, the Light speaks to the High General. It is the Light...', 12, 0, 100, 0, 0, 0, 29150, 0, 'break crusader SAY_PERSUADED2'),
(28964, 4, 0, 'The Light that guides us. This movement was set in motion before you came... We... We do as we are told. It is what must be done.', 12, 0, 100, 0, 0, 0, 29151, 0, 'break crusader SAY_PERSUADED3'),
(28964, 5, 0, 'I know very litte else... The High General chooses who may go and who must stay behind. There\'s nothing else... You must believe me!', 12, 0, 100, 0, 0, 0, 29152, 0, 'break crusader SAY_PERSUADED4'),
(28964, 6, 0, 'LIES! The pain you are about to endure will be talked about for years to come!', 12, 0, 100, 0, 0, 0, 29163, 0, 'break crusader SAY_PERSUADED5'),
(28964, 7, 0, 'NO! PLEASE! There is one more thing that I forgot to mention... A courier comes soon... From Hearthglen. It...', 12, 0, 100, 0, 0, 0, 29153, 0, 'break crusader SAY_PERSUADED6'),
(28964, 8, 0, 'I\'ll tear the secrets from your soul! Tell me about the "Crimson Dawn" and your life may be spared!', 12, 0, 100, 0, 0, 0, 29138, 0, 'player SAY_PERSUADE1'),
(28964, 8, 1, 'Tell me what you know about "Crimson Dawn" or the beatings will continue!', 12, 0, 100, 0, 0, 0, 29134, 0, 'player SAY_PERSUADE2'),
(28964, 8, 2, 'I\'m through being courteous with your kind, human! What is the "Crimson Dawn?"', 12, 0, 100, 0, 0, 0, 29135, 0, 'player SAY_PERSUADE3'),
(28964, 8, 3, 'Is your life worth so little? Just tell me what I need to know about "Crimson Dawn" and I\'ll end your suffering quickly.', 12, 0, 100, 0, 0, 0, 29139, 0, 'player SAY_PERSUADE4'),
(28964, 8, 4, 'I can keep this up for a very long time, Scarlet dog! Tell me about the "Crimson Dawn!"', 12, 0, 100, 0, 0, 0, 29137, 0, 'player SAY_PERSUADE'),
(28964, 8, 5, 'What is the "Crimson Dawn?"', 12, 0, 100, 0, 0, 0, 29133, 0, 'player SAY_PERSUADE6'),
(28964, 8, 6, '"Crimson Dawn!" What is it! Speak!', 12, 0, 100, 0, 0, 0, 29136, 0, 'player SAY_PERSUADE7');
