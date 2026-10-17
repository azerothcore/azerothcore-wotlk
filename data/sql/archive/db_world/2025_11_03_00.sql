-- DB update 2025_11_01_03 -> 2025_11_03_00
--
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (53618, 53616, 53617, 53602);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(53618, 53618, 59350, 0, 0),
(53616, 53616, 59360, 0, 0),
(53617, 53617, 59359, 0, 0),
(53602, 53602, 59349, 0, 0);

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 29120 AND `entry` = 22515;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(29120, 0, 1, 22515, 549.622, 352.047, 240.8899, 3.45575, 8, 0, 'Anub''arak - Group 1 - World Trigger'),
(29120, 0, 2, 22515, 478.739, 252.85, 250.544, 0.0523599, 8, 0, 'Anub''arak - Group 2 - World Trigger'),
(29120, 0, 2, 22515, 621.319, 268.482, 250.544, 3.33358,  8, 0, 'Anub''arak - Group 2 - World Trigger'),
(29120, 0, 2, 22515, 622.904, 252.945, 250.544, 3.12414,  8, 0, 'Anub''arak - Group 2 - World Trigger'),
(29120, 0, 2, 22515, 478.149, 269.009, 250.544, 6.12611,  8, 0, 'Anub''arak - Group 2 - World Trigger'),
(29120, 0, 2, 22515, 478.547, 297.045, 250.544, 5.79449,  8, 0, 'Anub''arak - Group 2 - World Trigger'),
(29120, 0, 2, 22515, 478.291, 224.827, 250.235, 0.401426, 8, 0, 'Anub''arak - Group 2 - World Trigger'),
(29120, 0, 2, 22515, 620.622, 298.263, 250.544, 3.7001,   8, 0, 'Anub''arak - Group 2 - World Trigger'),
(29120, 0, 2, 22515, 620.704, 224.562, 250.232, 2.53073,  8, 0, 'Anub''arak - Group 2 - World Trigger');

-- Position where Anub'ar Guardian and Anub'ar Venomancer run to after spawning
SET @POS_X := 551.0095;
SET @POS_Y := 274.026;
SET @POS_Z := 223.89513;

-- Update comments, spelldifficulty_dbc
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29216);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29216, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 6000, 6000, 0, 0, 11, 53618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Guardian - In Combat - Cast \'Sunder Armor\''),
(29216, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 8000, 8000, 0, 0, 11, 52532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Guardian - In Combat - Cast \'Strike\''),
(29216, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 1, 0, 0, 0, 8, 0, 0, 0, 0, @POS_X, @POS_Y, @POS_Z, 0, 'Anub\'ar Guardian - On Just Summoned - Move To Position');

-- Update comments, spelldifficulty_dbc
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29217);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29217, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 18000, 22000, 0, 0, 11, 53616, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Venomancer - In Combat - Cast \'Poison Bolt Volley\''),
(29217, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 7000, 7000, 0, 0, 11, 53617, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Venomancer - In Combat - Cast \'Poison Bolt\''),
(29217, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 1, 0, 0, 0, 8, 0, 0, 0, 0, @POS_X, @POS_Y, @POS_Z, 0, 'Anub\'ar Venomancer - On Just Summoned - Move To Position');

-- Update comments, bump jump range from 50 to 100 yards, spelldifficulty_dbc
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29213);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29213, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 97, 20, 10, 1, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Darter - On Respawn - Jump To Pos'),
(29213, 0, 1, 0, 0, 0, 100, 0, 4000, 5000, 7000, 7000, 0, 0, 11, 53602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Darter - In Combat - Cast \'Dart\'');

-- Update comments, remove visual, bump jump range from 50 to 100 yards, spelldifficulty_dbc
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29214) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29214, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 97, 20, 10, 1, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Assassin - On Respawn - Jump To Pos'),
(29214, 0, 1, 0, 67, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 5, 11, 52540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Assassin - On Behind Target - Cast \'Backstab\''),
(29214, 0, 2, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 0, 0, 28, 53611, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Assassin - In Combat - Remove Aura \'Anub`ar Assasssin Visual Passive\' (No Repeat)');

UPDATE `spell_script_names` SET `ScriptName`='spell_azjol_nerub_carrion_beetles' WHERE `spell_id`=53520 AND `ScriptName`='spell_azjol_nerub_carrion_beetels';
