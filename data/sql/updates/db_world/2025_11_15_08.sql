-- DB update 2025_11_15_07 -> 2025_11_15_08

-- Set Creature Template Addon (Amberpine Woodsman)
DELETE FROM `creature_template_addon` WHERE (`entry` = 27293);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(27293, 0, 0, 0, 1, 0, 0, '');

-- Update Spawn Points (Amberpine Woodsman)
UPDATE `creature` SET `position_x` = 3499.0676, `position_y` = -2838.0798, `position_z` = 202.27922, `orientation` = 2.89724, `Comment` = 'Has Guid SAI' WHERE (`id1` = 27293) AND (`guid` = 110578);
UPDATE `creature` SET `position_x` = 3497.1128, `position_y` = -2836.0088, `position_z` = 202.26859, `orientation` = 4.55530 WHERE (`id1` = 27293) AND (`guid` = 110579);
UPDATE `creature` SET `position_x` = 3474.6736, `position_y` = -2776.7188, `position_z` = 201.02751, `orientation` = 2.56563, `Comment` = 'Has Guid SAI' WHERE (`id1` = 27293) AND (`guid` = 110580);
UPDATE `creature` SET `position_x` = 3475.1519, `position_y` = -2774.3525, `position_z` = 200.75826, `orientation` = 3.59537 WHERE (`id1` = 27293) AND (`guid` = 110581);
UPDATE `creature` SET `position_x` = 3374.5999, `position_y` = -2805.997, `position_z` = 199.0484, `orientation` = 1.34390, `Comment` = 'Has Guid SAI' WHERE (`id1` = 27293) AND (`guid` = 110582);
UPDATE `creature` SET `position_x` = 3375.972, `position_y` = -2803.756, `position_z` = 199.01216, `orientation` = 3.99680 WHERE (`id1` = 27293) AND (`guid` = 110583);
UPDATE `creature` SET `position_x` = 3460.5964, `position_y` = -2902.6494, `position_z` = 201.07785, `orientation` = 5.89921, `Comment` = 'Has Guid SAI' WHERE (`id1` = 27293) AND (`guid` = 110602);
UPDATE `creature` SET `position_x` = 3460.07, `position_y` = -2904.9836, `position_z` = 201.10063, `orientation` = 0.52359 WHERE (`id1` = 27293) AND (`guid` = 110603);
UPDATE `creature` SET `position_x` = 3390.5305, `position_y` = -2862.014, `position_z` = 199.62068, `orientation` = 3.24631 WHERE (`id1` = 27293) AND (`guid` = 110604);
UPDATE `creature` SET `position_x` = 3390.0286, `position_y` = -2864.7012, `position_z` = 200.0756, `orientation` = 2.56563, `Comment` = 'Has Guid SAI' WHERE (`id1` = 27293) AND (`guid` = 110605);

-- Set Creature Addon (Amberpine Woodsman)
DELETE FROM `creature_addon` WHERE (`guid` IN (110578, 110579, 110580, 110581, 110582, 110583, 110602, 110603, 110604, 110605));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(110578, 0, 0, 8, 0, 0, 0, NULL),
(110579, 0, 0, 0, 0, 133, 0, NULL),
(110580, 0, 0, 8, 0, 0, 0, NULL),
(110581, 0, 0, 0, 0, 133, 0, NULL),
(110582, 0, 0, 8, 0, 0, 0, NULL),
(110583, 0, 0, 0, 0, 133, 0, NULL),
(110602, 0, 0, 8, 0, 0, 0, NULL),
(110603, 0, 0, 0, 0, 133, 0, NULL),
(110604, 0, 0, 0, 0, 133, 0, NULL),
(110605, 0, 0, 8, 0, 0, 0, NULL);

-- Remove Script Name and set SmartAI (Amberpine Woodsman)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 27293);

-- Set Guid SmartAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-110578, -110580, -110582, -110602, -110605));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-110578, 0, 0, 0, 1, 0, 100, 0, 1000, 3000, 500, 3000, 0, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amberpine Woodsman - Out of Combat - Play Emote 36'),
(-110580, 0, 0, 0, 1, 0, 100, 0, 1000, 3000, 500, 3000, 0, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amberpine Woodsman - Out of Combat - Play Emote 36'),
(-110582, 0, 0, 0, 1, 0, 100, 0, 1000, 3000, 500, 3000, 0, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amberpine Woodsman - Out of Combat - Play Emote 36'),
(-110602, 0, 0, 0, 1, 0, 100, 0, 1000, 3000, 500, 3000, 0, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amberpine Woodsman - Out of Combat - Play Emote 36'),
(-110605, 0, 0, 0, 1, 0, 100, 0, 1000, 3000, 500, 3000, 0, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amberpine Woodsman - Out of Combat - Play Emote 36');

-- Remove Script Name and set SmartAI (Tallhorn Stag)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 26363);

-- Set Comments (Tallhorn Stag)
UPDATE `creature` SET `Comment` = 'Has Personal SAI' WHERE (`id1` = 26363) AND (`guid` IN (119621, 119622, 119642, 119643, 119656));

-- Set Guid Sai (Tallhorn Stag)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-119621, -119622, -119642, -119643, -119656));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-119621, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 537166592, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Set Flags Immune To Players & Immune To NPC\'s & Stunned & Prevent Emotes From Chat Text'),
(-119621, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Set Flags Feign Death'),
(-119621, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 29266, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Cast \'Permanent Feign Death\''),
(-119622, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 537166592, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Set Flags Immune To Players & Immune To NPC\'s & Stunned & Prevent Emotes From Chat Text'),
(-119622, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Set Flags Feign Death'),
(-119622, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 29266, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Cast \'Permanent Feign Death\''),
(-119642, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 537166592, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Set Flags Immune To Players & Immune To NPC\'s & Stunned & Prevent Emotes From Chat Text'),
(-119642, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Set Flags Feign Death'),
(-119642, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 29266, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Cast \'Permanent Feign Death\''),
(-119643, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 537166592, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Set Flags Immune To Players & Immune To NPC\'s & Stunned & Prevent Emotes From Chat Text'),
(-119643, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Set Flags Feign Death'),
(-119643, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 29266, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Cast \'Permanent Feign Death\''),
(-119656, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 537166592, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Set Flags Immune To Players & Immune To NPC\'s & Stunned & Prevent Emotes From Chat Text'),
(-119656, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Set Flags Feign Death'),
(-119656, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 29266, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tallhorn Stag - On Respawn - Cast \'Permanent Feign Death\'');
