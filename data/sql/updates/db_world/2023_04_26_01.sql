-- DB update 2023_04_26_00 -> 2023_04_26_01
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-146029, -146031));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-146029, 0, 1001, 1002, 1, 0, 100, 0, 6000, 6000, 16000, 16000, 0, 5, 273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Cultist - Out of Combat - Play Emote 273 (OneShotYes)'),
(-146029, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 5, 273, 0, 0, 0, 0, 0, 10, 146057, 0, 0, 0, 0, 0, 0, 0, 'Cabal Cultist - Out of Combat - Play Emote 273 (OneShotYes)'),
(-146029, 0, 1003, 1004, 1, 0, 100, 0, 10000, 10000, 16000, 16000, 0, 5, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Cultist - Out of Combat - Play Emote 11 (OneShotLaugh)'),
(-146029, 0, 1004, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 5, 274, 0, 0, 0, 0, 0, 10, 146057, 0, 0, 0, 0, 0, 0, 0, 'Cabal Cultist - Out of Combat - Play Emote 274 (OneShotNo)');

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|33554432 WHERE (`entry` IN (18631, 18633, 18635, 18637, 20640, 20638, 20641, 20646));
