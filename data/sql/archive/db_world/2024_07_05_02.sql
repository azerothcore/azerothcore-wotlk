-- DB update 2024_07_05_01 -> 2024_07_05_02
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18870);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18870, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Reset - Set Event Phase 0'),
(18870, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 34302, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Respawn - Cast \'Coalesce\''),
(18870, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Aggro - Set Event Phase 1'),
(18870, 0, 3, 4, 8, 1, 100, 0, 0, 2, 0, 0, 0, 0, 11, 34336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Holy\' - Cast \'Damage Reduction: Holy\' (Phase 1)'),
(18870, 0, 4, 5, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Holy\' - Say Line 1 (Phase 1)'),
(18870, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Holy\' - Set Event Phase 2 (Phase 1)'),
(18870, 0, 6, 7, 8, 1, 100, 0, 0, 4, 0, 0, 0, 0, 11, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Fire\' - Cast \'Damage Reduction: Fire\' (Phase 1)'),
(18870, 0, 7, 8, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Fire\' - Say Line 2 (Phase 1)'),
(18870, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Fire\' - Set Event Phase 3 (Phase 1)'),
(18870, 0, 9, 10, 8, 1, 100, 0, 0, 8, 0, 0, 0, 0, 11, 34335, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Nature\' - Cast \'Damage Reduction: Nature\' (Phase 1)'),
(18870, 0, 10, 11, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Nature\' - Say Line 3 (Phase 1)'),
(18870, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Nature\' - Set Event Phase 4 (Phase 1)'),
(18870, 0, 12, 13, 8, 1, 100, 0, 0, 16, 0, 0, 0, 0, 11, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Frost\' - Cast \'Damage Reduction: Frost\' (Phase 1)'),
(18870, 0, 13, 14, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Frost\' - Say Line 4 (Phase 1)'),
(18870, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Frost\' - Set Event Phase 5 (Phase 1)'),
(18870, 0, 15, 16, 8, 1, 100, 0, 0, 32, 0, 0, 0, 0, 11, 34338, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Shadow\' - Cast \'Damage Reduction: Shadow\' (Phase 1)'),
(18870, 0, 16, 17, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Shadow\' - Say Line 5 (Phase 1)'),
(18870, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Shadow\' - Set Event Phase 6 (Phase 1)'),
(18870, 0, 18, 19, 8, 1, 100, 0, 0, 64, 0, 0, 0, 0, 11, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Arcane\' - Cast \'Damage Reduction: Arcane\' (Phase 1)'),
(18870, 0, 19, 20, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Arcane\' - Say Line 6 (Phase 1)'),
(18870, 0, 20, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Spellhit \'Arcane\' - Set Event Phase 7 (Phase 1)'),
(18870, 0, 21, 0, 106, 0, 100, 0, 9000, 13000, 14000, 18000, 0, 8, 11, 22884, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - On Hostile in Range - Cast \'Psychic Scream\''),
(18870, 0, 22, 0, 0, 33, 100, 0, 0, 1000, 3000, 3500, 0, 0, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - In Combat - Cast \'Shadow Bolt\' (Phases 1 & 6)'),
(18870, 0, 23, 0, 0, 2, 100, 0, 0, 1000, 2500, 3000, 0, 0, 11, 15498, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - In Combat - Cast \'Holy Smite\' (Phase 2)'),
(18870, 0, 24, 0, 0, 4, 100, 0, 0, 1000, 3000, 3500, 0, 0, 11, 14034, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - In Combat - Cast \'Fireball\' (Phase 3)'),
(18870, 0, 25, 0, 0, 8, 100, 0, 0, 1000, 3000, 3500, 0, 0, 11, 12167, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - In Combat - Cast \'Lightning Bolt\' (Phase 4)'),
(18870, 0, 26, 0, 0, 16, 100, 0, 0, 1000, 3000, 3500, 0, 0, 11, 15497, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - In Combat - Cast \'Frostbolt\' (Phase 5)'),
(18870, 0, 27, 0, 0, 64, 100, 0, 0, 1000, 5000, 6000, 0, 0, 11, 38204, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidshrieker - In Combat - Cast \'Arcane Bolt\' (Phase 7)');

DELETE FROM `creature_text` WHERE (`CreatureID` = 18870);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18870, 1, 0, '%s absorbs the holy energy of the attack.', 16, 0, 0, 0, 0, 0, 17110, 0, 'Voidshrieker'),
(18870, 2, 0, '%s absorbs the fire energy of the attack.', 16, 0, 0, 0, 0, 0, 17105, 0, 'Voidshrieker'),
(18870, 3, 0, '%s absorbs the nature energy of the attack.', 16, 0, 0, 0, 0, 0, 17107, 0, 'Voidshrieker'),
(18870, 4, 0, '%s absorbs the frost energy of the attack.', 16, 0, 0, 0, 0, 0, 17106, 0, 'Voidshrieker'),
(18870, 5, 0, '%s absorbs the shadow energy of the attack.', 16, 0, 0, 0, 0, 0, 17108, 0, 'Voidshrieker'),
(18870, 6, 0, '%s absorbs the arcane energy of the attack.', 16, 0, 0, 0, 0, 0, 17109, 0, 'Voidshrieker');
