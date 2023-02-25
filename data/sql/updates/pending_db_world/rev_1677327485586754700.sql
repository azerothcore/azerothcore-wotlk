--
DELETE FROM `creature` WHERE `id1`=19823 AND `guid` IN (1007, 10994, 25745, 25746);
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`) VALUES
(1007 , 19823, 530, 1, -4486.58, 1998.88, 112.765, 0.113942, 300, 20, 1),
(10994, 19823, 530, 1, -4527.13, 2106.33, 38.1019, 0.221064, 300, 20, 1),
(25745, 19823, 530, 1, -4561.13, 2024.76, 92.2968, 5.31829, 300, 20, 1),
(25746, 19823, 530, 1, -4399.99, 2334.17, 28.1067, 0.071826, 300, 20, 1);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19823);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19823, 0, 0, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 11, 38223, 3, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Crazed Colossus - On Just Died - Cast \'Quest Credit: Crazed Colossus\''),
(19823, 0, 1, 0, 2, 0, 100, 1, 0, 75, 0, 0, 0, 11, 37947, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crazed Colossus - Between 0-75% Health - Cast \'Serverside - Summon Crazed Shardling\' (No Repeat)'),
(19823, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 11, 37948, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crazed Colossus - Between 0-50% Health - Cast \'Serverside - Summon Crazed Shardling\' (No Repeat)'),
(19823, 0, 3, 0, 2, 0, 100, 1, 0, 25, 0, 0, 0, 11, 37949, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crazed Colossus - Between 0-25% Health - Cast \'Serverside - Summon Crazed Shardling\' (No Repeat)');

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 0 WHERE `ID` IN (37947, 37948, 37949);
