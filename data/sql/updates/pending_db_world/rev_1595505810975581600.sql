INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595505810975581600');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25773;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25773) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25773, 0, 0, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Survivor - On Just Summoned - Say Line 0');

UPDATE `creature_template` SET `unit_flags` = 2 WHERE (`entry` = 25773);

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 25814;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25814);

UPDATE `creature_template` SET `ScriptName`='npc_fizzcrank_mechagnome' WHERE `entry`=25814;

DELETE FROM `creature_text` WHERE `CreatureID`=25814;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(25814, 1, 1, 'We are Mechagnome... resistance is futile.', 12, 0, 0, 0, 10000, 0, 25000, 0, 'SAY_AGGRO'),
(25814, 1, 2, 'The flesh is weak. We will make you better, stronger... faster.', 12, 0, 0, 0, 10000, 0, 25002, 0, 'SAY_AGGRO'),
(25814, 1, 3, 'We can decurse you, we have the technology.', 12, 0, 0, 0, 10000, 0, 25003, 0, 'SAY_AGGRO');

/*
-- original update
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25814;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25814);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25814, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Mechagnome - On Aggro - Say Line 1 (Phase 1) (No Repeat)'),
(25814, 0, 1, 3, 8, 0, 100, 0, 45980, 0, 0, 0, 0, 33, 25773, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Mechagnome - On Spellhit \'Re-Cursive Transmatter Injection\' - Quest Credit \'Re-Cursive\''),
(25814, 0, 2, 3, 8, 0, 100, 0, 46485, 0, 0, 0, 0, 33, 26096, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Mechagnome - On Spellhit \'The Greatmother\'s Soulcatcher\' - Quest Credit \'Souls of the Decursed\''),
(25814, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Mechagnome - On Spellhit \'The Greatmother\'s Soulcatcher\' - Despawn In 10 ms');
*/
