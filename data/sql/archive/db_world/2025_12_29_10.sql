-- DB update 2025_12_29_09 -> 2025_12_29_10
--
-- HARD_RESET
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 2147483648 WHERE (`entry` IN (28921, 31611));

DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (53406, 53317, 53394, 53330, 53322);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(53406, 53406, 59420, 0, 0),
(53317, 53317, 59343, 0, 0),
(53394, 53394, 59344, 0, 0),
(53330, 53330, 59348, 0, 0),
(53322, 53322, 59347, 0, 0);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (53406, 59420) AND `ScriptName` = 'spell_hadronox_web_grab';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(53406, 'spell_hadronox_web_grab'),
(59420, 'spell_hadronox_web_grab');

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 28921;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(28921, 0, 1, 28922, 529.691, 547.126, 731.916, 4.79965, 6, 45000, 'Hadronox - Group 1 - Anub''ar Crusher'),
(28921, 0, 1, 29117, 539.208, 549.754, 732.867, 4.55531, 6, 30000, 'Hadronox - Group 1 - Anub''ar Champion'),
(28921, 0, 1, 29118, 520.391, 548.789, 732.012, 5.0091, 6, 30000, 'Hadronox - Group 1 - Anub''ar Crypt Fiend'),
(28921, 0, 2, 28922, 493.477, 603.344, 760.563, 5.44024, 6, 45000, 'Hadronox - Group 2 - Anub''ar Crusher'),
(28921, 0, 2, 29117, 490.442, 604.335, 763.182, 5.6256, 6, 30000, 'Hadronox - Group 2 - Anub''ar Champion'),
(28921, 0, 2, 29119, 488.825, 609.282, 767.588, 5.59029, 6, 30000, 'Hadronox - Group 2 - Anub''ar Necromancer'),
(28921, 0, 3, 28922, 566.979, 602.571, 759.642, 3.88597, 6, 45000, 'Hadronox - Group 3 - Anub''ar Crusher'),
(28921, 0, 3, 29118, 569.348, 604.999, 763.214, 4.17983, 6, 30000, 'Hadronox - Group 3 - Anub''ar Crypt Fiend'),
(28921, 0, 3, 29119, 572.474, 607.411, 767.178, 3.94417, 6, 30000, 'Hadronox - Group 3 - Anub''ar Necromancer'),
(28921, 0, 4, 23472, 581.448, 608.841, 739.405, 1.72788,  6, 3600000, 'Hadronox - Group 4 - World Trigger'),
(28921, 0, 4, 23472, 477.016, 618.4, 771.515, 2.35619, 6, 3600000, 'Hadronox - Group 4 - World Trigger'),
(28921, 0, 4, 23472, 583.091, 617.371, 771.551, 0.645772, 6, 3600000, 'Hadronox - Group 4 - World Trigger');

DELETE FROM `creature` WHERE (`id1` = 23472) AND (`guid` IN (127376, 127377, 127378));
DELETE FROM `creature_addon` WHERE (`guid` IN (127376, 127377, 127378));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (29117, 29118, 29119));
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_anub_ar_crusher_champion' WHERE (`entry` = 29117);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_anub_ar_crusher_crypt_fiend' WHERE (`entry` = 29118);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_anub_ar_crusher_necromancer' WHERE (`entry` = 29119);

SET @SPAWN_X := 522.53107;
SET @SPAWN_Y := 544.91125;
SET @SPAWN_Z := 674.6791;
SET @SPAWN_O := 5.633617;
DELETE FROM `creature` WHERE (`id1` = 28921) AND (`guid` = 127401);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(127401, 28921, 0, 0, 601, 0, 0, 3, 1, 0, @SPAWN_X, @SPAWN_Y, @SPAWN_Z, @SPAWN_O, 86400, 0, 0, 154230, 0, 0, 0, 0, 0, '', NULL, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (3000012, 3000013) AND `point` IN (13, 14);
DELETE FROM `waypoint_data` WHERE `id` = 3000014 AND `point` IN (9, 10);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(3000012, 13, 538.0253, 529.9829, 686.0557, 0, 1, 0, 100, 0),
(3000012, 14, 532.7753, 535.2329, 681.0557, 0, 1, 0, 100, 0),
(3000013, 13, 538.0253, 529.9829, 686.0557, 0, 1, 0, 100, 0),
(3000013, 14, 532.7753, 535.2329, 681.0557, 0, 1, 0, 100, 0),
(3000014,  9, 538.0253, 529.9829, 686.0557, 0, 1, 0, 100, 0),
(3000014, 10, 532.7753, 535.2329, 681.0557, 0, 1, 0, 100, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (29062, 29063, 29064));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29062, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 12000, 18000, 0, 0, 11, 53317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Champion - In Combat - Cast \'Rend\''),
(29062, 0, 1, 0, 105, 0, 100, 0, 9000, 13000, 9000, 13000, 0, 5, 11, 53394, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Champion - On Hostile Casting in Range - Cast \'Pummel\''),
(29062, 0, 2, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Champion - On Just Died - Despawn In 10000 ms'),
(29062, 0, 3, 0, 1, 0, 100, 0, 10000, 10000, 1000, 1000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 11, 28921, 50, 1, 0, 0, 0, 0, 0, 'Anub\'ar Champion Out of Combat - Start Attacking'),
(29062, 0, 4, 0, 0, 0, 100, 0, 15000, 50000, 15000, 50000, 0, 0, 11, 53798, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Champion - In Combat - Cast \'Taunt\''),
(29063, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 9000, 12000, 0, 0, 11, 53330, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Crypt Fiend - In Combat - Cast \'Infected Wound\''),
(29063, 0, 1, 0, 0, 0, 100, 0, 9000, 12000, 13000, 17000, 0, 0, 11, 53322, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Crypt Fiend - In Combat - Cast \'Crushing Webs\''),
(29063, 0, 2, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Crypt Fiend - On Just Died - Despawn In 10000 ms'),
(29063, 0, 3, 0, 1, 0, 100, 0, 10000, 10000, 1000, 1000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 11, 28921, 50, 1, 0, 0, 0, 0, 0, 'Anub\'ar Crypt Fiend - Out of Combat - Start Attacking'),
(29063, 0, 4, 0, 0, 0, 100, 0, 15000, 50000, 15000, 50000, 0, 0, 11, 53798, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Crypt Fiend - In Combat - Cast \'Taunt\''),
(29064, 0, 0, 0, 1, 0, 100, 0, 0, 1000, 2000, 3000, 0, 0, 11, 53333, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Necromancer - Out of Combat - Cast \'Shadow Bolt\''),
(29064, 0, 2, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Necromancer - On Just Died - Despawn In 10000 ms'),
(29064, 0, 3, 0, 1, 0, 100, 0, 10000, 10000, 1000, 1000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 11, 28921, 50, 1, 0, 0, 0, 0, 0, 'Anub\'ar Necromancer Out of Combat - Start Attacking'),
(29064, 0, 4, 0, 0, 0, 100, 0, 15000, 50000, 15000, 50000, 0, 0, 11, 53798, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Necromancer - In Combat - Cast \'Taunt\'');
