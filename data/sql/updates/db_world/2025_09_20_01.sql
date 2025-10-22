-- DB update 2025_09_20_00 -> 2025_09_20_01
-- Update gossip option 0 to show after completing quest The Frostborn King 12873
UPDATE `conditions` SET `ConditionTypeOrReference` = 8, `ConditionValue1` = 12873, `Comment` = 'Show frostborn test gossip only after completing quest The Frostborn King 12873' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 9891 AND `SourceEntry` = 0 AND `ConditionValue1` = 12874;

-- Add new condition for gossip option 1 to show after accepting quest Pushed too Far 12869
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 9891 AND `SourceEntry` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES (15, 9891, 1, 0, 0, 9, 0, 12869, 0, 0, 0, 0, 0, '', 'Show wyrm battle gossip only after accepting quest Pushed too Far 12869');

-- Smart script to cast mount spell when player clicks "wyrm battle" gossip option
-- This makes the gossip behave the same as accepting quest 12869 (auto-mount on bird)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 29732 AND `source_type` = 0 AND `id` = 4;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES (29732, 0, 4, 0, 62, 0, 100, 0, 9891, 1, 0, 0, 11, 57049, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fjorlin Frostbrow - On Gossip Select Option 1 (Wyrm Battle) - Forcecast Summon Battle Eagle 57049');
