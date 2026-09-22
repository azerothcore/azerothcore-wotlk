-- DB update 2026_08_31_01 -> 2026_08_31_02
-- Boomer XP-500 (entry 34192) - consolidated patch
-- - Keeps event 101 (direct contact, without LoS/detection checks) according to observed retail behavior
-- - Applies Defensive ReactState only to Mimiron Arena Bombots through negative GUID overrides
-- - Adds formations for the corridor Bombots before the tram

UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE (`entry` IN (34192, 34216));

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (34192));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 34192);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(34192, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - On Reset - Disable Auto Attack'),
(34192, 0, 1, 2, 101, 0, 100, 0, 1, 1, 500, 0, 0, 0, 11, 63801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - On 1 or More Players in Range - Cast \'Bomb Bot\''),
(34192, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - On 1 or More Players in Range - Kill Self');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-1975178, -1975179, -1975180, -1975181, -1975182, -1975183, -1975184, -1975185, -1975186, -1975187, -1975188, -1975189, -1975190, -1975191, -1975192, -1975193, -1975194, -1975195, -1975196, -1975197));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-1975178, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975178, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975179, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975179, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975180, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975180, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975181, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975181, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975182, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975182, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975183, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975183, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975184, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975184, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975185, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975185, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975186, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975186, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975187, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975187, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975188, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975188, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975189, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975189, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975190, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975190, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975191, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975191, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975192, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975192, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975193, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975193, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975194, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975194, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975195, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975195, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975196, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975196, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms'),
(-1975197, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Reset - Set Reactstate Defensive'),
(-1975197, 0, 1002, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 (Mimiron Arena) - On Just Died - Despawn In 2000 ms');

DELETE FROM `creature_formations` WHERE (`LeaderGUID` IN (136535, 136536, 136534, 136575));
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(136535, 136535, 0, 0, 3, 0, 0),
(136535, 136560, 0, 0, 3, 0, 0),
(136535, 136561, 0, 0, 3, 0, 0),
(136535, 136562, 0, 0, 3, 0, 0),
(136535, 136563, 0, 0, 3, 0, 0),
(136535, 136582, 0, 0, 3, 0, 0),
(136535, 136583, 0, 0, 3, 0, 0),
(136536, 136536, 0, 0, 3, 0, 0),
(136536, 136588, 0, 0, 3, 0, 0),
(136536, 136589, 0, 0, 3, 0, 0),
(136536, 136564, 0, 0, 3, 0, 0),
(136536, 136565, 0, 0, 3, 0, 0),
(136536, 136566, 0, 0, 3, 0, 0),
(136536, 136567, 0, 0, 3, 0, 0),
(136536, 136568, 0, 0, 3, 0, 0),
(136536, 136569, 0, 0, 3, 0, 0),
(136534, 136534, 0, 0, 3, 0, 0),
(136534, 136533, 0, 0, 3, 0, 0),
(136534, 136586, 0, 0, 3, 0, 0),
(136534, 136587, 0, 0, 3, 0, 0),
(136534, 136584, 0, 0, 3, 0, 0),
(136534, 136585, 0, 0, 3, 0, 0),
(136575, 136575, 0, 0, 3, 0, 0),
(136575, 136574, 0, 0, 3, 0, 0),
(136575, 136570, 0, 0, 3, 0, 0),
(136575, 136571, 0, 0, 3, 0, 0),
(136575, 136572, 0, 0, 3, 0, 0),
(136575, 136573, 0, 0, 3, 0, 0),
(136575, 136591, 0, 0, 3, 0, 0),
(136575, 136592, 0, 0, 3, 0, 0),
(136575, 136578, 0, 0, 3, 0, 0),
(136575, 136579, 0, 0, 3, 0, 0),
(136575, 136580, 0, 0, 3, 0, 0),
(136575, 136581, 0, 0, 3, 0, 0);
