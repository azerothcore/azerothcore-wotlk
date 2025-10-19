--
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 29120 AND `groupId` = 1 AND `entry` = 22515;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(29120, 0, 1, 22515, 549.622, 352.047, 240.8899, 3.45575, 8, 0, 'Anub''arak - Group 1 - World Trigger');

-- Update comments
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29216);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29216, 0, 0, 0, 0, 0, 100, 2, 5000, 8000, 6000, 6000, 0, 0, 11, 53618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Guardian - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(29216, 0, 1, 0, 0, 0, 100, 4, 5000, 8000, 6000, 6000, 0, 0, 11, 59350, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Guardian - In Combat - Cast \'Sunder Armor\' (Heroic Dungeon)'),
(29216, 0, 2, 0, 0, 0, 100, 0, 2000, 3000, 8000, 8000, 0, 0, 11, 52532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Guardian - In Combat - Cast \'Strike\'');

-- Update comments
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29217);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29217, 0, 0, 0, 0, 0, 100, 2, 5000, 8000, 18000, 22000, 0, 0, 11, 53616, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Venomancer - In Combat - Cast \'Poison Bolt Volley\' (Normal Dungeon)'),
(29217, 0, 1, 0, 0, 0, 100, 4, 5000, 8000, 18000, 22000, 0, 0, 11, 59360, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Venomancer - In Combat - Cast \'Poison Bolt Volley\' (Heroic Dungeon)'),
(29217, 0, 2, 0, 0, 0, 100, 2, 2000, 3000, 7000, 7000, 0, 0, 11, 53617, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Venomancer - In Combat - Cast \'Poison Bolt\' (Normal Dungeon)'),
(29217, 0, 3, 0, 0, 0, 100, 4, 2000, 3000, 7000, 7000, 0, 0, 11, 59359, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Venomancer - In Combat - Cast \'Poison Bolt\' (Heroic Dungeon)');

SET @CGUID := 127529;
DELETE FROM `creature` WHERE (`id1` = 22515) AND (`guid` BETWEEN @CGUID+0 AND @CGUID+7);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(@CGUID+0, 22515, 0, 0, 601, 0, 0, 3, 1, 0, 478.739, 252.85, 250.544, 0.0523599, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', '', 0),
(@CGUID+1, 22515, 0, 0, 601, 0, 0, 3, 1, 0, 621.319, 268.482, 250.544, 3.33358,  300, 0, 0, 1, 0, 0, 0, 0, 0, '', '', 0),
(@CGUID+2, 22515, 0, 0, 601, 0, 0, 3, 1, 0, 622.904, 252.945, 250.544, 3.12414,  300, 0, 0, 1, 0, 0, 0, 0, 0, '', '', 0),
(@CGUID+3, 22515, 0, 0, 601, 0, 0, 3, 1, 0, 478.149, 269.009, 250.544, 6.12611,  300, 0, 0, 1, 0, 0, 0, 0, 0, '', '', 0),
(@CGUID+4, 22515, 0, 0, 601, 0, 0, 3, 1, 0, 478.547, 297.045, 250.544, 5.79449,  300, 0, 0, 1, 0, 0, 0, 0, 0, '', '', 0),
(@CGUID+5, 22515, 0, 0, 601, 0, 0, 3, 1, 0, 478.291, 224.827, 250.235, 0.401426, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', '', 0),
(@CGUID+6, 22515, 0, 0, 601, 0, 0, 3, 1, 0, 620.622, 298.263, 250.544, 3.7001,   300, 0, 0, 1, 0, 0, 0, 0, 0, '', '', 0),
(@CGUID+7, 22515, 0, 0, 601, 0, 0, 3, 1, 0, 620.704, 224.562, 250.232, 2.53073,  300, 0, 0, 1, 0, 0, 0, 0, 0, '', '', 0);

-- Update comments, bump jump range from 50 to 100 yards
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29213);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29213, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 97, 20, 10, 1, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Darter - On Respawn - Jump To Pos'),
(29213, 0, 1, 0, 0, 0, 100, 2, 4000, 5000, 7000, 7000, 0, 0, 11, 53602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Darter - In Combat - Cast \'Dart\' (Normal Dungeon)'),
(29213, 0, 2, 0, 0, 0, 100, 4, 4000, 5000, 7000, 7000, 0, 0, 11, 59349, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Darter - In Combat - Cast \'Dart\' (Heroic Dungeon)');

-- Update comment and remove visual
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29214) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29214, 0, 1, 0, 67, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 5, 11, 52540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Assassin - On Behind Target - Cast \'Backstab\''),
(29214, 0, 2, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 0, 0, 28, 53611, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Assassin - In Combat - Remove Aura \'Anub`ar Assasssin Visual Passive\' (No Repeat)');

UPDATE `spell_script_names` SET `ScriptName`='spell_azjol_nerub_carrion_beetles' WHERE `spell_id`=53520 AND `ScriptName`='spell_azjol_nerub_carrion_beetels';
