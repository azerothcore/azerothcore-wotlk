-- DB update 2026_03_01_04 -> 2026_03_01_05
--
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 1557 AND `summonerType` = 1;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(1557, 1, 0, 1946, 2471.2383, 15.430718, 24.04098, 0.22952774167060852, 4, 30000, 'Lillith\'s Dinner Table - Lillith Nefara');

DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 1557 AND `summonerType` = 1;
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
(1557, 1, 0, 1558, 2485.39306640625, 22.17523956298828125, 27.59094619750976562, 4.206246376037597656, 0, 0, -0.86162853240966796, 0.50753939151763916, 120, 'Lillith\'s Dinner Table - Candle of Beckoning');

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 1557);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1557, 1, 0, 0, 20, 0, 100, 0, 410, 0, 0, 0, 0, 0, 107, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lillith\'s Dinner Table - On Quest \'The Dormant Shade\' Finished - Summon Creature \'Lillith Nefara\''),
(1557, 1, 1, 0, 20, 0, 100, 0, 410, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lillith\'s Dinner Table - On Quest \'The Dormant Shade\' Finished - Summon Gameobject \'Candle of Beckoning\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1946;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1946);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1946, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lillith Nefara - On Aggro - Say Line');
