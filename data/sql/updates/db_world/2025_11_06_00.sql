-- DB update 2025_11_05_00 -> 2025_11_06_00

-- Remove NPC Flag, Unit Flag and set RegenHealth
UPDATE `creature_template` SET `npcflag` = `npcflag` &~ 16777216, `unit_flags` = `unit_flags` &~ 2, `RegenHealth` = 1 WHERE (`entry` = 28782);

-- Update SmartAI (Acherus Deathcharger and Dark Rider of Acherus)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (28768, 28782));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (28768, 28782));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28782, 0, 0, 1, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Passenger Removed - Set Home Position'),
(28782, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 2082, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Passenger Removed - Set Faction 2082'),
(28782, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Passenger Removed - Add Npc Flags Spellclick'),
(28782, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Passenger Removed - Remove Flags Not Selectable'),
(28782, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Passenger Removed - Say Line 0'),
(28782, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Passenger Removed - Evade'),
(28782, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Passenger Removed - Set Rooted On'),
(28782, 0, 7, 8, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 377, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Passenger Removed - Play Emote 377'),
(28782, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Passenger Removed - Despawn In 3000 ms'),
(28782, 0, 9, 10, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Respawn - Set Flags Not Selectable'),
(28782, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Respawn - Remove Npc Flags Spellclick'),
(28782, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Respawn - Set Faction 16'),
(28782, 0, 12, 0, 27, 0, 100, 512, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Deathcharger - On Passenger Boarded - Set Rooted Off'),
(28768, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 6000, 6000, 0, 0, 11, 52372, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rider of Acherus - In Combat - Cast \'Icy Touch\''),
(28768, 0, 1, 0, 0, 0, 100, 0, 3000, 3000, 6000, 6000, 0, 0, 11, 52374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rider of Acherus - In Combat - Cast \'Blood Strike\''),
(28768, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 6000, 6000, 0, 0, 11, 50688, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rider of Acherus - In Combat - Cast \'Plague Strike\''),
(28768, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 203, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rider of Acherus - On Just Died - Exit vehicle');

-- Set Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (1, 3, 8)) AND (`SourceEntry` = 28782) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 32) AND (`ConditionTarget` = 0) AND (`ConditionValue1` IN (8, 16)) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 8, 28782, 0, 0, 32, 0, 16, 0, 0, 0, 0, 0, '', 'Only despawn Archerus Deathcharger if dismounting unit is player'),
(22, 1, 28782, 0, 0, 32, 0, 8, 0, 0, 0, 0, 0, '', 'Event only occurs when Passenger is an NPC');
