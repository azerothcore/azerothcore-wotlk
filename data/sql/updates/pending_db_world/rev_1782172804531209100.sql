-- Quest 13142 "Banshee's Revenge" - Overthane Balargarde (NPC 31016) encounter, featuring Balargarde Elite (NPC 31030),
-- The Lich King (31083), Possessed Vardmadra (NPC 31029), Lady Nightswood (NPC 31087),
-- Safirdrang (NPC 31050) and hidden Chill target stalkers (NPC 31077)

-- `unit_flags` below are taken from the sniff data Dr-J posted on TrinityCore/TrinityCore#4841,
-- as are the spawn positions, waypoints and `creature_text` rows further down; they are not
-- invented here. 31016 reuses the curated shared CC-immunity set -354 (identical mechanics mask).
-- `ManaModifier` 2 on the two casters is from video evidence: both sustain a spell on a timer for
-- the whole fight, which the base pool does not cover.
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_overthane',
    `unit_flags`= 33088, `CreatureImmunitiesId`= -354, `ManaModifier`= 2 WHERE `entry`= 31016;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_safirdrang',
    `unit_flags`= 256, `ManaModifier`= 2 WHERE `entry`= 31050;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_elite',
    `unit_flags`= 256 WHERE `entry`= 31030;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_vardmadra',
    `unit_flags`= 33536 WHERE `entry`= 31029;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_nightswood' WHERE `entry`= 31087;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bansheesrevenge_lich_king',
    `unit_flags`= 768 WHERE `entry`= 31083;
-- The chill stalker only relays one spell on hit, which SmartAI covers - no C++ needed.
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='',
    `unit_flags`= 33555200 WHERE `entry`= 31077;

-- Remove legacy SAI, then give 31077 its relay script
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (31016, 31029, 31030, 31050, 31077, 31083, 31087);
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=31016;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31077, 0, 0, 0, 8, 0, 100, 0, 4020, 0, 0, 0, 0, 0, 11, 4307, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Safirdrang`s Chill Target - On Spellhit Safirdrang`s Chill - Cast Safirdrang`s Chill Relay');

-- Spawn auras and hover states. `visibilityDistanceType` 3 (Large, 200 yd) is kept from the base
-- rows: the drake, the boss and the Lich King all move well past the 100 yd normal range.
DELETE FROM `creature_template_addon` WHERE `entry` IN (31016, 31029, 31030, 31050, 31083);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(31016, 0, 0, 0, 1, 0, 3, '61081'),
(31029, 0, 0, 50331648, 1, 0, 3, '58102'),
(31030, 0, 26882, 0, 1, 0, 3, ''),
(31050, 0, 0, 50331648, 1, 0, 3, ''),
(31083, 0, 0, 0, 1, 0, 3, '34427');

-- War Horn of Jotunheim (GO 193028) summons Possessed Vardmadra (NPC 31029)
DELETE FROM `event_scripts` WHERE `id` = 20108;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(20108, 0, 10, 31029, 1800000, 0, 7116.824, 4308.362, 883.3842, 2.46227);

-- Safirdrang's Chill (4020) only cast on hidden Chill target stalkers (NPC 31077)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup`= 1 AND `SourceEntry`= 4020 AND `SourceId`= 0 AND `ElseGroup`= 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 4020, 0, 0, 31, 0, 3, 31077, 0, 0, 0, 0, '', 'Safirdrang`s Chill targets Safirdrang`s Chill Target');

-- Encounter dialogue
-- Rows below are the sniffed text; the one deviation is 31029 group 2, whose sniffed Emote 457
-- (EMOTE_ONESHOT_FLYTALK) is dropped: unlike groups 0 and 1 that line is spoken kneeling on the
-- ground, and a flying talk animation there breaks the kneel.
DELETE FROM `creature_text` WHERE `CreatureID` IN (31016, 31029, 31083, 31087);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextID`, `TextRange`, `comment`) VALUES
(31016, 1, 0, 'You dare to challenge me? You haven''t earned the right!', 14, 0, 100, 25, 0, 15633, 31597, 0, 'Banshee''s Revenge - Overthane Balargarde to Safirdrang'),
(31016, 2, 0, 'Vardmadra?! Did the Lich King send you personally?', 14, 0, 100, 66, 0, 15634, 31599, 0, 'Banshee''s Revenge - Overthane Balargarde to Possessed Vardmadra'),
(31016, 3, 0, 'Very well. I will dispatch these creatures. It is only an inconvenience. Prepare to die!', 14, 0, 100, 0, 0, 15635, 31600, 0, 'Banshee''s Revenge - Overthane Balargarde to Possessed Vardmadra'),
(31016, 4, 0, 'Safirdrang, let them feel the chill of Icecrown!', 14, 0, 100, 0, 0, 15636, 31601, 0, 'Banshee''s Revenge - Overthane Balargarde'),
(31016, 5, 0, 'STOP! Kneel you fools, it''s the Lich King!', 14, 0, 100, 0, 0, 15637, 31627, 0, 'Banshee''s Revenge - Overthane Balargarde to The Lich King'),
(31016, 6, 0, 'But, my lord...?', 14, 0, 100, 0, 0, 15638, 31635, 0, 'Banshee''s Revenge - Overthane Balargarde to The Lich King'),
(31016, 7, 0, 'DIE DOGS!', 14, 0, 100, 0, 0, 15639, 31637, 0, 'Banshee''s Revenge - Overthane Balargarde to The Lich King'),
(31029, 0, 0, 'He''s on his way!', 14, 0, 100, 457, 0, 15643, 31595, 0, 'Banshee''s Revenge - Possessed Vardmadra to Player'),
(31029, 1, 0, 'Wrong, Balargarde. You WILL accept this challenge!', 14, 0, 100, 457, 0, 15644, 31598, 0, 'Banshee''s Revenge - Possessed Vardmadra to Overthane Balargarde'),
(31029, 2, 0, 'My lord.', 14, 0, 100, 0, 0, 15645, 31631, 0, 'Banshee''s Revenge - Possessed Vardmadra to The Lich King'),
(31029, 3, 0, 'But...!', 14, 0, 100, 0, 0, 15646, 31633, 0, 'Banshee''s Revenge - Possessed Vardmadra to The Lich King'),
(31083, 0, 0, 'Honor guard stay where you are.', 14, 0, 100, 1, 0, 15600, 31628, 0, 'Banshee''s Revenge - The Lich King'),
(31083, 1, 0, 'Vardmadra. I''d wondered where you disappeared to. How is Iskalder?', 14, 0, 100, 6, 0, 15601, 31629, 0, 'Banshee''s Revenge - The Lich King'),
(31083, 2, 0, 'I see through your disguise, Lady Nightswood. YOU THINK THAT YOU CAN FOOL ME?!', 14, 0, 100, 5, 0, 15602, 31632, 0, 'Banshee''s Revenge - The Lich King'),
(31083, 3, 0, 'You may continue your combat, overthane.', 14, 0, 100, 25, 0, 15603, 31634, 0, 'Banshee''s Revenge - The Lich King'),
(31083, 4, 0, 'But nothing! Finish them! DO NOT FAIL ME, BALARGARDE!', 14, 0, 100, 5, 0, 15604, 31636, 0, 'Banshee''s Revenge - The Lich King to Overthane Balargarde'),
(31083, 5, 0, 'You have bested one of my finest, but your efforts are for naught.', 14, 0, 100, 1, 0, 15605, 31693, 0, 'Banshee''s Revenge - The Lich King'),
(31083, 6, 0, 'The frozen heart of Icecrown awaits....', 14, 0, 100, 1, 0, 15606, 31695, 0, 'Banshee''s Revenge - The Lich King'),
(31087, 0, 0, '%s smiles and flies off to return to possessing The Bone Witch.', 16, 0, 100, 0, 0, 0, 31697, 1, 'Banshee''s Revenge - Lady Nightswood emote');

-- Flight paths
DELETE FROM `waypoint_data` WHERE `id` IN (31029, 31050, 3105000, 31087, 3103001, 3103002, 3103003, 3103004, 3103005, 3103006);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
-- Possessed Vardmadra (NPC 31029)
(31029, 1, 7119.714, 4305.82, 883.7371),
(31029, 2, 7119.045, 4306.563, 883.7371),
(31029, 3, 7094.592, 4326.246, 879.7935),
(31029, 4, 7094.592, 4326.246, 879.7935),
-- Safirdrang (NPC 31050) enter
(31050, 1, 7097.518, 4417.555, 831.8486),
(31050, 2, 7097.292, 4416.581, 831.8486),
(31050, 3, 7097.876, 4416.293, 832.2352),
(31050, 4, 7096.67, 4412.85, 892.0963),
(31050, 5, 7083.72, 4365.534, 886.1511),
(31050, 6, 7083.72, 4365.534, 886.1511),
-- Safirdrang (NPC 31050) depart
(3105000, 1, 7053.937, 4377.317, 901.5513),
(3105000, 2, 7020.913, 4415.733, 938.7733),
(3105000, 3, 7014.491, 4475.228, 933.1346),
(3105000, 4, 7053.163, 4507.731, 899.1902),
-- Lady Nightswood (NPC 31087)
(31087, 1, 7079.599, 4301.017, 874.3533),
(31087, 2, 7082.374, 4283.685, 878.2528),
(31087, 3, 7093.269, 4251.247, 855.1418),
-- Balargarde Elite (NPC 31030)
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
