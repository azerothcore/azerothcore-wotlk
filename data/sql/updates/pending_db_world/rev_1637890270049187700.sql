INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637890270049187700');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14460;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 14460);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14460, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 89, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blazing Invader - On Just Summoned - Start Random Movement'),
(14460, 0, 1, 0, 0, 0, 100, 0, 0, 11000, 10000, 16000, 0, 11, 23113, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blazing Invader - In Combat - Cast \'Blast Wave\'');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 179666;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 179666);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(179666, 1, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 12, 14460, 6, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fire Elemental Rift - On Respawn - Summon Creature \'Blazing Invader\''),
(179666, 1, 1, 0, 60, 0, 100, 0, 30000, 33000, 30000, 30000, 0, 12, 14460, 6, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fire Elemental Rift - On Update - Summon Creature \'Blazing Invader\''),
(179666, 1, 2, 0, 17, 0, 100, 0, 14460, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fire Elemental Rift - On Summoned Unit - Increase Summon counter'),
(179666, 1, 3, 0, 77, 0, 100, 0, 1, 3, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Summon counter set to 3 - Set Event Phase 1'),
(179666, 1, 4, 0, 77, 1, 100, 0, 1, 2, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'When Summon counter is 2 - Set Event Phase 0 (Phase 1)');
