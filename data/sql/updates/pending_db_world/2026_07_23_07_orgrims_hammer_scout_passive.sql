-- Issue #26753: "Orgrim's Hammer Scout" (32201) attacks players on approach even though
-- it should be neutral (confirmed against retail, live-tested). Creature::InitializeReactState()
-- defaults every non-totem/trigger/critter/spirit-healer creature to REACT_AGGRESSIVE
-- regardless of faction - tried two different factions (714, then 1978 matching its
-- Orgrim's Hammer crew siblings) and both still resulted in aggressive behavior, since
-- react state, not faction, is what governs whether it initiates combat on its own.
-- Force it passive on spawn/reset instead, matching the standard convention already used
-- elsewhere in this DB (e.g. "Valhalas Vargul - On Reset - Set React Passive").
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32201;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 32201 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32201, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrim''s Hammer Scout - On Reset - Set React Passive');
