-- DB update 2022_05_23_02 -> 2022_05_23_03
-- Flamebringer fix flying animation while on ground
UPDATE `creature_template_movement` SET `Flight` = 0 WHERE `CreatureId` = 27292;

-- Flamebringer remove all auras before mounting
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27292;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27292;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(27292, 0, 0, 1, 62, 0, 100, 512, 9512, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamebringer - On Gossip Option 0 Selected - Remove all auras'),
(27292, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 11, 48606, 3, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamebringer - On Gossip Option 0 Selected - Cast \'Flamebringer Summon Cue\''),
(27292, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamebringer - On Gossip Option 0 Selected - Close Gossip'),
(27292, 0, 3, 4, 54, 0, 100, 512, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamebringer - On Just Summoned - Remove Npc Flags Gossip'),
(27292, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamebringer - On Just Summoned - Set Reactstate Passive'),
(27292, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 85, 48600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamebringer - On Just Summoned - Invoker Cast \'Ride Flamebringer\''),
(27292, 0, 6, 0, 28, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamebringer - On Passenger Removed - Despawn Instant');
