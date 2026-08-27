-- DB update 2026_08_27_05 -> 2026_08_27_06
-- [Howling Fjord] The Delicate Sound of Thunder (timing race):
-- make the Rocket Jump speed buff (44626) atomic with the flight.
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 44608 AND `spell_effect` = 44626;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24825);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24825, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 75, 44643, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Just Summoned - Add Aura \'Reputation and Language\''),
(24825, 0, 1, 0, 28, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 44643, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Passenger Removed - Remove Aura \'Reputation and Language\''),
(24825, 0, 2, 11, 72, 0, 100, 512, 1, 0, 0, 0, 0, 0, 11, 44626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action Done - Cast Rocket Jump speed buff'),
(24825, 0, 3, 12, 72, 0, 100, 512, 2, 0, 0, 0, 0, 0, 11, 44626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action Done - Cast Rocket Jump speed buff'),
(24825, 0, 4, 13, 72, 0, 100, 512, 3, 0, 0, 0, 0, 0, 11, 44626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action Done - Cast Rocket Jump speed buff'),
(24825, 0, 5, 14, 72, 0, 100, 512, 4, 0, 0, 0, 0, 0, 11, 44626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action Done - Cast Rocket Jump speed buff'),
(24825, 0, 6, 15, 72, 0, 100, 512, 5, 0, 0, 0, 0, 0, 11, 44626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action Done - Cast Rocket Jump speed buff'),
(24825, 0, 7, 16, 72, 0, 100, 512, 6, 0, 0, 0, 0, 0, 11, 44626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action Done - Cast Rocket Jump speed buff'),
(24825, 0, 8, 0, 58, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 44626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Path 0 Finished - Remove Aura \'Rocket Jump\''),
(24825, 0, 9, 0, 31, 0, 100, 512, 44609, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Target Spellhit \'Bluff\' - Say Line 0'),
(24825, 0, 10, 0, 8, 0, 100, 512, 44626, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Spellhit \'Rocket Jump\' - Say Line 1'),
(24825, 0, 11, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 2, 24826, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - Rocket Jump - Start flight path Level 1'),
(24825, 0, 12, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 2, 24827, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - Rocket Jump - Start flight path Level 2'),
(24825, 0, 13, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 2, 24828, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - Rocket Jump - Start flight path Ground Level'),
(24825, 0, 14, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 2, 24831, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - Rocket Jump - Start flight path Level 1 Return'),
(24825, 0, 15, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 2, 24829, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - Rocket Jump - Start flight path Ground Level Return'),
(24825, 0, 16, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 2, 24832, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - Rocket Jump - Start flight path Level 2 Return'),
(24825, 0, 17, 0, 57, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 44626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Escort Stopped - Remove Aura Rocket Jump'),
(24825, 0, 18, 0, 28, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 44626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Passenger Removed - Remove Aura Rocket Jump');
