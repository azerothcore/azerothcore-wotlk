-- DB update 2024_02_20_05 -> 2024_02_21_00
--
UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `id` = 185913 AND `guid` IN (14146, 14147, 14217, 14227, 14694, 14731, 14989);
UPDATE `gameobject` SET `spawntimesecs` = 900 WHERE `id` = 185928 AND `guid` = 14141;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 185928 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(185928, 1, 0, 1, 62, 0, 100, 0, 8687, 1, 0, 0, 0, 0, 134, 41004, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk summon'),
(185928, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk summon - linked close gossip'),
(185928, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 900, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk summon - despawn');
