-- Fix Troll Patrol / Congratulations! quest aura mechanics
-- Congratulations! should be available after completing Troll Patrol when player has
-- On Patrol Heartbeat Script (53707) aura but NOT On Patrol (51573) aura

-- Commander Kunz SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28039;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28039);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28039, 0, 0, 0, 19, 0, 100, 0, 12563, 0, 0, 0, 0, 0, 75, 53707, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Kunz - On Quest Accept (Troll Patrol 12563) - Add Aura On Patrol Heartbeat Script'),
(28039, 0, 1, 0, 19, 0, 100, 0, 12501, 0, 0, 0, 0, 0, 75, 53707, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Kunz - On Quest Accept (Troll Patrol 12501) - Add Aura On Patrol Heartbeat Script'),
(28039, 0, 2, 0, 19, 0, 100, 0, 12587, 0, 0, 0, 0, 0, 75, 53707, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Kunz - On Quest Accept (Troll Patrol 12587) - Add Aura On Patrol Heartbeat Script'),
(28039, 0, 3, 0, 20, 0, 100, 0, 12563, 0, 0, 0, 0, 0, 28, 51573, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Kunz - On Quest Reward (Troll Patrol 12563) - Remove Aura On Patrol'),
(28039, 0, 4, 0, 20, 0, 100, 0, 12501, 0, 0, 0, 0, 0, 28, 51573, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Kunz - On Quest Reward (Troll Patrol 12501) - Remove Aura On Patrol'),
(28039, 0, 5, 0, 20, 0, 100, 0, 12587, 0, 0, 0, 0, 0, 28, 51573, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Kunz - On Quest Reward (Troll Patrol 12587) - Remove Aura On Patrol'),
(28039, 0, 6, 0, 20, 0, 100, 0, 12604, 0, 0, 0, 0, 0, 28, 53707, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Kunz - On Quest Reward (Congratulations! 12604) - Remove Aura On Patrol Heartbeat Script');

-- Update conditions for Congratulations! (12604)
-- Should require Heartbeat aura (53707) and NOT have On Patrol aura (51573)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` = 12604;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 12604, 0, 0, 1, 0, 53707, 0, 0, 0, 0, 0, '', 'Congratulations! - Requires On Patrol Heartbeat Script aura'),
(19, 0, 12604, 0, 0, 1, 0, 51573, 0, 0, 1, 0, 0, '', 'Congratulations! - Requires NOT having On Patrol aura');

-- Remove redundant RewardSpell from quest 12501 (SmartAI handles aura on accept)
UPDATE `quest_template` SET `RewardSpell` = 0 WHERE `ID` = 12501;

-- Fix missing SourceSpellID for Troll Patrol quest 12563
UPDATE `quest_template_addon` SET `SourceSpellID` = 51573 WHERE `ID` = 12563;
