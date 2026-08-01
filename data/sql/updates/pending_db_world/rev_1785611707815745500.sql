-- Mission: Eternal Flame

-- Halgrind Bunny 1
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23921;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23921);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23921, 0, 0, 0, 8, 0, 100, 0, 42564, 0, 0, 0, 0, 0, 11, 42632, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Halgrind Torch Bunny 01 - On Spellhit \'Ever-burning Torch\' - Cast \'Mission: Eternal Flame: Bunny 01 Kill Credit\''),
(23921, 0, 1, 0, 8, 0, 100, 0, 42564, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Halgrind Torch Bunny 01 - On Spellhit \'Ever-burning Torch\' - Summon Gameobject Group');

DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 23921 AND `summonerType` = 0;
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
(23921, 0, 0, 186457, 863.741, -4335.81, 175.882, 2.80998, 0, 0, 0.986285, 0.16505, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23921, 0, 0, 186459, 863.839, -4335.78, 175.87, 2.25147, 0, 0, 0.902585, 0.430512, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23921, 0, 0, 186457, 870.085, -4333.66, 175.913, 2.05949, 0, 0, 0.857167, 0.515038, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23921, 0, 0, 186457, 865.093, -4329.5, 184.862, 5.044, 0, 0, -0.580703, 0.814116, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23921, 0, 0, 186459, 870.059, -4333.67, 175.912, 3.26377, 0, 0, -0.998135, 0.0610518, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23921, 0, 0, 186459, 865.027, -4329.54, 184.859, 3.76991, 0, 0, -0.951056, 0.309017, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23921, 0, 0, 186457, 868.802, -4339.79, 182.212, 1.93731, 0, 0, 0.824125, 0.566408, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23921, 0, 0, 186459, 868.747, -4339.82, 182.209, 4.06662, 0, 0, -0.894934, 0.446199, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame');

-- Halgrind Bunny 2
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23922;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23922);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23922, 0, 0, 0, 8, 0, 100, 0, 42564, 0, 0, 0, 0, 0, 11, 42633, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Halgrind Torch Bunny 02 - On Spellhit \'Ever-burning Torch\' - Cast \'Mission: Eternal Flame: Bunny 02 Kill Credit\''),
(23922, 0, 1, 0, 8, 0, 100, 0, 42564, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Halgrind Torch Bunny 02 - On Spellhit \'Ever-burning Torch\' - Summon Gameobject Group');

DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 23922 AND `summonerType` = 0;
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
(23922, 0, 0, 186457, 989.369, -4306.89, 178.847, 5.60251, 0, 0, -0.333807, 0.942641, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23922, 0, 0, 186459, 989.394, -4306.69, 178.823, 1.44862, 0, 0, 0.66262, 0.748956, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23922, 0, 0, 186457, 990.37, -4312.48, 169.811, 6.14356, 0, 0, -0.0697556, 0.997564, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23922, 0, 0, 186457, 984.746, -4311.37, 170.311, 0.925024, 0, 0, 0.446198, 0.894935, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23922, 0, 0, 186459, 986.956, -4317.4, 175.751, 5.49779, 0, 0, -0.382683, 0.92388, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23922, 0, 0, 186459, 984.89, -4311.39, 170.28, 5.11382, 0, 0, -0.551936, 0.833886, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23922, 0, 0, 186457, 987, -4317.33, 175.794, 5.28835, 0, 0, -0.477159, 0.878817, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23922, 0, 0, 186459, 990.378, -4312.45, 169.814, 4.67748, 0, 0, -0.719339, 0.694659, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame');

-- Halgrind Bunny 3
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23923;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23923);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23923, 0, 0, 0, 8, 0, 100, 0, 42564, 0, 0, 0, 0, 0, 11, 42634, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Halgrind Torch Bunny 03 - On Spellhit \'Ever-burning Torch\' - Cast \'Mission: Eternal Flame: Bunny 03 Kill Credit\''),
(23923, 0, 1, 0, 8, 0, 100, 0, 42564, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Halgrind Torch Bunny 03 - On Spellhit \'Ever-burning Torch\' - Summon Gameobject Group');

DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 23923 AND `summonerType` = 0;
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
(23923, 0, 0, 186457, 1091.08, -4492.35, 199.826, 1.53589, 0, 0, 0.694658, 0.71934, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23923, 0, 0, 186459, 1090.99, -4492.31, 199.843, 4.34587, 0, 0, -0.824126, 0.566406, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23923, 0, 0, 186457, 1082.45, -4486.05, 197.245, 2.26893, 0, 0, 0.906307, 0.422619, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23923, 0, 0, 186457, 1088.52, -4486.68, 191.176, 2.65289, 0, 0, 0.970295, 0.241925, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23923, 0, 0, 186459, 1082.47, -4486.01, 197.243, 3.75246, 0, 0, -0.953716, 0.300708, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23923, 0, 0, 186459, 1088.55, -4486.6, 191.189, 5.79449, 0, 0, -0.241921, 0.970296, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23923, 0, 0, 186457, 1084.6, -4491.49, 190.98, 1.23918, 0, 0, 0.580703, 0.814116, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23923, 0, 0, 186459, 1084.63, -4491.51, 190.978, 2.58308, 0, 0, 0.961261, 0.27564, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame');

-- Halgrind Bunny 4
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23924;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23924);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23924, 0, 0, 0, 8, 0, 100, 0, 42564, 0, 0, 0, 0, 0, 11, 42635, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Halgrind Torch Bunny 04 - On Spellhit \'Ever-burning Torch\' - Cast \'Mission: Eternal Flame: Bunny 04 Kill Credit\''),
(23924, 0, 1, 0, 8, 0, 100, 0, 42564, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Halgrind Torch Bunny 04 - On Spellhit \'Ever-burning Torch\' - Summon Gameobject Group');

DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 23924 AND `summonerType` = 0;
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
(23924, 0, 0, 186457, 798.11, -4505.71, 186.714, 5.79449, 0, 0, -0.241921, 0.970296, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23924, 0, 0, 186459, 798.052, -4505.68, 186.727, 0.209439, 0, 0, 0.104528, 0.994522, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23924, 0, 0, 186457, 793.686, -4502.09, 187.292, 1.53589, 0, 0, 0.694658, 0.71934, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23924, 0, 0, 186457, 794.305, -4506.92, 196.746, 0.733038, 0, 0, 0.358368, 0.93358, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23924, 0, 0, 186459, 793.655, -4502.07, 187.294, 2.26893, 0, 0, 0.906307, 0.422619, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23924, 0, 0, 186459, 794.087, -4507.06, 196.769, 6.05629, 0, 0, -0.113203, 0.993572, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23924, 0, 0, 186457, 800.002, -4499.43, 192.178, 0.59341, 0, 0, 0.292371, 0.956305, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame'),
(23924, 0, 0, 186459, 800.015, -4499.37, 192.14, 5.23599, 0, 0, -0.5, 0.866025, 60, 'Halgrind Torch Bunny - Mission: Eternal Flame');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` IN (23921, 23922, 23923, 23924)) AND (`SourceId` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionValue1` = 186457);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 23921, 0, 0, 30, 1, 186457, 20, 0, 1, 0, 0, '', 'Don\'t spawn multiple fire gameobjects for quests \'Mission: Eternal Flame\' and \'Mission: Plague This!\''),
(22, 2, 23922, 0, 0, 30, 1, 186457, 20, 0, 1, 0, 0, '', 'Don\'t spawn multiple fire gameobjects for quests \'Mission: Eternal Flame\' and \'Mission: Plague This!\''),
(22, 2, 23923, 0, 0, 30, 1, 186457, 20, 0, 1, 0, 0, '', 'Don\'t spawn multiple fire gameobjects for quests \'Mission: Eternal Flame\' and \'Mission: Plague This!\''),
(22, 2, 23924, 0, 0, 30, 1, 186457, 20, 0, 1, 0, 0, '', 'Don\'t spawn multiple fire gameobjects for quests \'Mission: Eternal Flame\' and \'Mission: Plague This!\'');

-- Mission: Plague This!
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` = 24290);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24290);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24290, 0, 0, 0, 8, 0, 100, 0, 43404, 0, 0, 0, 0, 0, 11, 43419, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'New Agamand Plague Tank Bunny - On Spellhit \'Mission: Plague This!: Orehammer\'s Precision Bombs Dummy\' - Cast \'Mission: Plague This!: Kill Credit\'');

DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 24290 AND `summonerType` = 0;
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
-- 117615
(24290, 0, 0, 186457, 423.099, -4608.35, 247.876, 0.610863, 0, 0, 0.300705, 0.953717, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 0, 186459, 423.039, -4608.36, 247.832, 3.97935, 0, 0, -0.913545, 0.406738, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 0, 186457, 431.65, -4604.21, 252.061, 4.59022, 0, 0, -0.748956, 0.66262, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 0, 186459, 431.542, -4604.23, 252.05, 4.76475, 0, 0, -0.688354, 0.725374, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
-- 117616
(24290, 0, 1, 186457, 375.438, -4655.56, 251.9, 4.57276, 0, 0, -0.754709, 0.656059, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 1, 186459, 375.424, -4655.62, 251.928, 0.174532, 0, 0, 0.0871553, 0.996195, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 1, 186457, 369.526, -4663.41, 254.98, 0.471238, 0, 0, 0.233445, 0.97237, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 1, 186459, 369.434, -4663.53, 254.965, 3.9619, 0, 0, -0.91706, 0.39875, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
-- 117617
(24290, 0, 2, 186457, 357.424, -4498.92, 250.582, 4.7473, 0, 0, -0.694658, 0.71934, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 2, 186459, 357.5, -4499.03, 250.514, 4.72984, 0, 0, -0.700909, 0.713251, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 2, 186457, 352.185, -4490.65, 253.284, 2.91469, 0, 0, 0.993571, 0.113208, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 2, 186459, 352.146, -4490.48, 253.261, 6.16101, 0, 0, -0.0610485, 0.998135, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
-- 117618
(24290, 0, 3, 186457, 371.951, -4565.31, 250.922, 5.77704, 0, 0, -0.25038, 0.968148, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 3, 186459, 371.923, -4565.43, 250.925, 3.35105, 0, 0, -0.994521, 0.104536, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 3, 186457, 362.21, -4566.04, 254.082, 0.418879, 0, 0, 0.207911, 0.978148, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 3, 186459, 362.188, -4566.2, 254.066, 5.86431, 0, 0, -0.207911, 0.978148, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
-- 117619
(24290, 0, 4, 186457, 469.041, -4591.96, 251.803, 1.13446, 0, 0, 0.537299, 0.843392, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 4, 186459, 469.198, -4591.82, 251.922, 5.98648, 0, 0, -0.147809, 0.989016, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 4, 186457, 473.667, -4583.1, 255.491, 0.872664, 0, 0, 0.422618, 0.906308, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!'),
(24290, 0, 4, 186459, 473.587, -4583.14, 255.273, 0.785397, 0, 0, 0.382683, 0.92388, 60, 'New Agamand Plague Tank Bunny - Mission: Plague This!');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-117615, -117616, -117617, -117618, -117619));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-117615, 0, 1, 0, 8, 0, 100, 0, 43404, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'New Agamand Plague Tank Bunny - On Spellhit \'Mission: Plague This!: Orehammer\'s Precision Bombs Dummy\' - Summon Gameobject Group 0'),
(-117616, 0, 1, 0, 8, 0, 100, 0, 43404, 0, 0, 0, 0, 0, 241, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'New Agamand Plague Tank Bunny - On Spellhit \'Mission: Plague This!: Orehammer\'s Precision Bombs Dummy\' - Summon Gameobject Group 1'),
(-117617, 0, 1, 0, 8, 0, 100, 0, 43404, 0, 0, 0, 0, 0, 241, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'New Agamand Plague Tank Bunny - On Spellhit \'Mission: Plague This!: Orehammer\'s Precision Bombs Dummy\' - Summon Gameobject Group 2'),
(-117618, 0, 1, 0, 8, 0, 100, 0, 43404, 0, 0, 0, 0, 0, 241, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'New Agamand Plague Tank Bunny - On Spellhit \'Mission: Plague This!: Orehammer\'s Precision Bombs Dummy\' - Summon Gameobject Group 3'),
(-117619, 0, 1, 0, 8, 0, 100, 0, 43404, 0, 0, 0, 0, 0, 241, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'New Agamand Plague Tank Bunny - On Spellhit \'Mission: Plague This!: Orehammer\'s Precision Bombs Dummy\' - Summon Gameobject Group 4');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` IN (-117615, -117616, -117617, -117618, -117619)) AND (`SourceId` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionValue1` = 186457);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, -117615, 0, 0, 30, 1, 186457, 20, 0, 1, 0, 0, '', 'Don\'t spawn multiple fire gameobjects for quests \'Mission: Eternal Flame\' and \'Mission: Plague This!\''),
(22, 2, -117616, 0, 0, 30, 1, 186457, 20, 0, 1, 0, 0, '', 'Don\'t spawn multiple fire gameobjects for quests \'Mission: Eternal Flame\' and \'Mission: Plague This!\''),
(22, 2, -117617, 0, 0, 30, 1, 186457, 20, 0, 1, 0, 0, '', 'Don\'t spawn multiple fire gameobjects for quests \'Mission: Eternal Flame\' and \'Mission: Plague This!\''),
(22, 2, -117618, 0, 0, 30, 1, 186457, 20, 0, 1, 0, 0, '', 'Don\'t spawn multiple fire gameobjects for quests \'Mission: Eternal Flame\' and \'Mission: Plague This!\''),
(22, 2, -117619, 0, 0, 30, 1, 186457, 20, 0, 1, 0, 0, '', 'Don\'t spawn multiple fire gameobjects for quests \'Mission: Eternal Flame\' and \'Mission: Plague This!\'');
