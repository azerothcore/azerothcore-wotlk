-- Quest 13142 "Banshee's Revenge" - Overthane Balargarde encounter.
-- The SmartAI implementation is replaced by C++ (zone_icecrown.cpp); this update
-- wires the creatures to the new scripts and provides the supporting data.

-- Attach the C++ AIs and clear the legacy SmartAI / apply the encounter unit flags.
-- NOTE: AzerothCore has no `creature_template`.`InhabitType` column (TC-only); flight is stored in
-- `creature_template_movement`. 31050/31030/31029/31087 are already `Flight`=1 in the base data, so no
-- movement rows are needed here.
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_overthane',
    `unit_flags`=33088 WHERE `entry`=31016;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_safirdrang',
    `unit_flags`=256 WHERE `entry`=31050;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_elite' WHERE `entry`=31030;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_vardmadra',
    `unit_flags`=33536 WHERE `entry`=31029;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_nightswood' WHERE `entry`=31087;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_lich_king',
    `unit_flags`=768 WHERE `entry`=31083;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_chill_target',
    `unit_flags`=33555200 WHERE `entry`=31077;

-- The Balargarde Elites use a cosmetic proto-drake mount (creature_addon mount 26882) and fly their own
-- patrols, so the custom proto-drake vehicle NPC (310300) is removed (clean up any earlier import of it).
DELETE FROM `creature_template` WHERE `entry`=310300;
DELETE FROM `creature_template_model` WHERE `CreatureID`=310300;
DELETE FROM `creature_template_movement` WHERE `CreatureId`=310300;
DELETE FROM `creature_template_addon` WHERE `entry`=310300;

-- Remove the legacy SmartAI rows for the encounter creatures (source_type 0) and Overthane's
-- timed action list (source_type 9, entryorguid 31016).
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (31016, 31029, 31030, 31050, 31077, 31083, 31087);
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=31016;

-- Cosmetic spawn auras / hover anim states. The elite (31030) gets the cosmetic proto-drake mount (26882).
DELETE FROM `creature_template_addon` WHERE `entry` IN (31016, 31029, 31030, 31050, 31083);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(31016, 0, 0, 0, 1, 0, 0, '61081'),
(31029, 0, 0, 50331648, 1, 0, 0, '58102'),
(31030, 0, 26882, 0, 1, 0, 3, ''),
(31050, 0, 0, 50331648, 1, 0, 0, ''),
(31083, 0, 0, 0, 1, 0, 0, '34427');

-- War Horn of Jotunheim (event 20108) now summons Possessed Vardmadra to start the event.
DELETE FROM `event_scripts` WHERE `id`=20108;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(20108, 0, 10, 31029, 1800000, 0, 7116.824, 4308.362, 883.3842, 2.46227);

-- Safirdrang's Chill (4020) only affects the chill target stalkers.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=4020 AND `SourceId`=0 AND `ElseGroup`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 4020, 0, 0, 31, 0, 3, 31077, 0, 0, 0, 0, '', 'Safirdrangs Chill targets Safirdrangs Chill Target');

-- Encounter dialogue.
DELETE FROM `creature_text` WHERE `CreatureID` IN (31016, 31029, 31083);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextID`, `TextRange`, `comment`) VALUES
(31016, 1, 0, 'You dare to challenge me? You haven''t earned the right!', 14, 0, 100, 25, 0, 15633, 31597, 0, 'Overthane Balargarde to Safirdrang'),
(31016, 2, 0, 'Vardmadra?! Did the Lich King send you personally?', 14, 0, 100, 66, 0, 15634, 31599, 0, 'Overthane Balargarde to Possessed Vardmadra'),
(31016, 3, 0, 'Very well. I will dispatch these creatures. It is only an inconvenience. Prepare to die!', 14, 0, 100, 0, 0, 15635, 31600, 0, 'Overthane Balargarde to Possessed Vardmadra'),
(31016, 4, 0, 'Safirdrang, let them feel the chill of Icecrown!', 14, 0, 100, 0, 0, 15636, 31601, 0, 'Overthane Balargarde'),
(31016, 5, 0, 'STOP! Kneel you fools, it''s the Lich King!', 14, 0, 100, 0, 0, 15637, 31627, 0, 'Overthane Balargarde to The Lich King'),
(31016, 6, 0, 'But, my lord...?', 14, 0, 100, 0, 0, 15638, 31635, 0, 'Overthane Balargarde to The Lich King'),
(31016, 7, 0, 'DIE DOGS!', 14, 0, 100, 0, 0, 15639, 31637, 0, 'Overthane Balargarde to The Lich King'),
(31029, 0, 0, 'He''s on his way!', 14, 0, 100, 457, 0, 15643, 31595, 0, 'Possessed Vardmadra to Player'),
(31029, 1, 0, 'Wrong, Balargarde. You WILL accept this challenge!', 14, 0, 100, 457, 0, 15644, 31598, 0, 'Possessed Vardmadra to Overthane Balargarde'),
(31029, 2, 0, 'My lord.', 14, 0, 100, 457, 0, 15645, 31631, 0, 'Possessed Vardmadra to The Lich King'),
(31029, 3, 0, 'But...!', 14, 0, 100, 0, 0, 15646, 31633, 0, 'Possessed Vardmadra to The Lich King'),
(31083, 0, 0, 'Honor guard stay where you are.', 14, 0, 100, 1, 0, 15600, 31628, 0, 'The Lich King'),
(31083, 1, 0, 'Vardmadra. I''d wondered where you disappeared to. How is Iskalder?', 14, 0, 100, 6, 0, 15601, 31629, 0, 'The Lich King'),
(31083, 2, 0, 'I see through your disguise, Lady Nightswood. YOU THINK THAT YOU CAN FOOL ME?!', 14, 0, 100, 5, 0, 15602, 31632, 0, 'The Lich King'),
(31083, 3, 0, 'You may continue your combat, overthane.', 14, 0, 100, 25, 0, 15603, 31634, 0, 'The Lich King'),
(31083, 4, 0, 'But nothing! Finish them! DO NOT FAIL ME, BALARGARDE!', 14, 0, 100, 5, 0, 15604, 31636, 0, 'The Lich King to Overthane Balargarde'),
(31083, 5, 0, 'You have bested one of my finest, but your efforts are for naught.', 14, 0, 100, 1, 0, 15605, 31693, 0, 'The Lich King'),
(31083, 6, 0, 'The frozen heart of Icecrown awaits....', 14, 0, 100, 1, 0, 15606, 31695, 0, 'The Lich King');

-- Flight paths used by the C++ encounter (MovePath / PathSource::WAYPOINT_MGR).
DELETE FROM `waypoint_data` WHERE `id` IN (31029, 31050, 3105000, 31087, 31083, 3103001, 3103002, 3103003, 3103004, 3103005, 3103006);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
-- Possessed Vardmadra intro
(31029, 1, 7119.714, 4305.82, 883.7371),
(31029, 2, 7119.045, 4306.563, 883.7371),
(31029, 3, 7094.592, 4326.246, 879.7935),
(31029, 4, 7094.592, 4326.246, 879.7935),
-- Safirdrang intro (carries Overthane in)
(31050, 1, 7097.518, 4417.555, 831.8486),
(31050, 2, 7097.292, 4416.581, 831.8486),
(31050, 3, 7097.876, 4416.293, 832.2352),
(31050, 4, 7096.67, 4412.85, 892.0963),
(31050, 5, 7083.72, 4365.534, 886.1511),
(31050, 6, 7083.72, 4365.534, 886.1511),
-- Safirdrang depart (after Overthane dies)
(3105000, 1, 7053.937, 4377.317, 901.5513),
(3105000, 2, 7020.913, 4415.733, 938.7733),
(3105000, 3, 7014.491, 4475.228, 933.1346),
(3105000, 4, 7053.163, 4507.731, 899.1902),
-- Lady Nightswood escape
(31087, 1, 7079.599, 4301.017, 874.3533),
(31087, 2, 7082.374, 4283.685, 878.2528),
(31087, 3, 7093.269, 4251.247, 855.1418),
-- The Lich King walk
(31083, 1, 7092.936, 4343.906, 871.9753),
(31083, 2, 7094.104, 4331.222, 871.5023),
(31083, 3, 7092.936, 4343.906, 871.9331),
(31083, 4, 7088.768, 4385.59, 872.3639),
-- Balargarde Elite patrols
(3103001, 1, 7108.212, 4429.457, 837.8948),
(3103001, 2, 7108.282, 4428.459, 837.8948),
(3103001, 3, 7106.677, 4418.644, 890.2556),
(3103001, 4, 7105.132, 4316.933, 890.2556),
(3103001, 5, 7105.132, 4316.933, 890.2556),
(3103002, 1, 7092.335, 4432.937, 836.562),
(3103002, 2, 7092.213, 4431.944, 836.562),
(3103002, 3, 7088.707, 4422.627, 890.4507),
(3103002, 4, 7042.402, 4334.195, 890.4507),
(3103002, 5, 7042.402, 4334.195, 890.4507),
(3103003, 1, 7118.292, 4433.163, 837.6826),
(3103003, 2, 7118.448, 4432.175, 837.6826),
(3103003, 3, 7118.339, 4415.652, 891.2397),
(3103003, 4, 7116.423, 4360.689, 891.2397),
(3103003, 5, 7116.423, 4360.689, 891.2397),
(3103004, 1, 7084.022, 4439.456, 834.9834),
(3103004, 2, 7083.883, 4438.466, 834.9834),
(3103004, 3, 7084.125, 4439.286, 835.0841),
(3103004, 4, 7078.116, 4422.103, 891.0005),
(3103004, 5, 7052.648, 4376.112, 891.0005),
(3103004, 6, 7052.648, 4376.112, 891.0005),
(3103005, 1, 7111.17, 4446.118, 838.3093),
(3103005, 2, 7111.292, 4445.125, 838.3093),
(3103005, 3, 7097.193, 4415.753, 886.4199),
(3103005, 4, 7091.205, 4393.473, 886.4199),
(3103005, 5, 7091.205, 4393.473, 886.4199),
(3103006, 1, 7095.478, 4449.356, 836.9002),
(3103006, 2, 7095.443, 4448.357, 836.9002),
(3103006, 3, 7052.521, 4434.108, 838.8722),
(3103006, 4, 7003.175, 4398.929, 844.0392),
(3103006, 5, 6988.518, 4335.11, 856.9001),
(3103006, 6, 7018.119, 4279.629, 875.7885),
(3103006, 7, 7067.475, 4300.513, 892.5076),
(3103006, 8, 7067.475, 4300.513, 892.5076);
