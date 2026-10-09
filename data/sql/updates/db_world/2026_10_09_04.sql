-- DB update 2026_10_09_03 -> 2026_10_09_04
--
-- Rothin the Decaying stands still when silenced instead of closing to melee, because his Shadow
-- Bolt rows lack SMARTCAST_COMBAT_MOVE and his hand-rolled combat movement blocks the charge the
-- flag produces. Same conversion as 478d64959 did for the four Anub'ar casters.
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27355);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27355, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Aggro - Cast ''Shadow Bolt'''),
(27355, 0, 1, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - In Combat - Cast ''Shadow Bolt'''),
(27355, 0, 2, 0, 0, 0, 100, 0, 12000, 17000, 15000, 20000, 0, 0, 11, 51337, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - In Combat - Cast ''Shadowflame'''),
(27355, 0, 3, 0, 2, 0, 100, 1, 0, 30, 9500, 11000, 0, 0, 11, 51512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - Between 0-30% Health - Cast ''Aegis of Neltharion'' (No Repeat)'),
(27355, 0, 4, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Reset - Set Flags Immune To Players & Immune To NPC''s'),
(27355, 0, 5, 6, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Data Set 1 1 - Set Data 1 0'),
(27355, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Data Set 1 1 - Remove Flags Immune To Players & Immune To NPC''s'),
(27355, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Data Set 1 1 - Say Line 0'),
(27355, 0, 8, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Aggro - Say Line 1'),
(27355, 0, 9, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Just Died - Say Line 2');
