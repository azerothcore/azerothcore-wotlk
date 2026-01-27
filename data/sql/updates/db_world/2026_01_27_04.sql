-- DB update 2026_01_27_03 -> 2026_01_27_04
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28203);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28203, 0, 0, 1, 8, 0, 100, 512, 50918, 0, 0, 0, 0, 0, 11, 50919, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorged Lurking Basilisk - On Spellhit \'Gluttonous Lurkers: Create Basilisk Crystals Cover\' - Cast \'Create Basilisk Crystals\''),
(28203, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorged Lurking Basilisk - On Spellhit \'Gluttonous Lurkers: Create Basilisk Crystals Cover\' - Despawn Instant');

DELETE FROM `creature_template_addon` WHERE (`entry` = 28203);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(28203, 0, 0, 0, 1, 0, 0, '50917');

DELETE FROM `npc_spellclick_spells` WHERE  `npc_entry` = 28203 AND `spell_id` = 50919;
