-- Razorscale encounter rework: spell-based spawning via creature_summon_groups

-- Remove static spawns for creatures now managed by creature_summon_groups
DELETE FROM `creature` WHERE `id` IN (33210, 33287, 33816, 33259, 33233) AND `map` = 603;

-- Remove harpoon fire state static spawns (now in summon groups)
DELETE FROM `creature` WHERE `id` = 33282 AND `map` = 603;

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 33186;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
-- Group 1: Expedition NPCs (Commander, Engineers, Defenders, Trappers, Controllers)
(33186, 0, 1, 33210, 585.6672,  -104.4477, 391.6004, 1.518436, 8, 0, 'Expedition Commander'),
(33186, 0, 1, 33287, 592.5033,  -98.55198,  391.6004, 5.742133, 8, 0, 'Expedition Engineer'),
(33186, 0, 1, 33287, 589.5328,  -95.32281,  391.6004, 5.51524,  8, 0, 'Expedition Engineer'),
(33186, 0, 1, 33287, 594.3019,  -94.38184,  391.6004, 4.817109, 8, 0, 'Expedition Engineer'),
(33186, 0, 1, 33816, 600.7484,  -104.8482,  391.6082, 4.852015, 8, 0, 'Expedition Defender'),
(33186, 0, 1, 33816, 596.3798,  -110.2639,  391.6004, 4.852015, 8, 0, 'Expedition Defender'),
(33186, 0, 1, 33816, 576.5787,  -113.1111,  391.6004, 4.29351,  8, 0, 'Expedition Defender'),
(33186, 0, 1, 33816, 570.4106,  -108.7936,  391.6004, 4.13643,  8, 0, 'Expedition Defender'),
(33186, 0, 1, 33816, 588.7609,  -114.8663,  391.6004, 4.852015, 8, 0, 'Expedition Defender'),
(33186, 0, 1, 33816, 566.4739,  -103.6336,  391.6004, 4.363323, 8, 0, 'Expedition Defender'),
(33186, 0, 1, 33259, 583.61,    -110.9356,  391.6004, 4.939282, 8, 0, 'Expedition Trapper'),
(33186, 0, 1, 33259, 578.1771,  -107.6289,  391.6004, 4.852015, 8, 0, 'Expedition Trapper'),
(33186, 0, 1, 33259, 588.2538,  -108.7151,  391.6004, 4.991642, 8, 0, 'Expedition Trapper'),
(33186, 0, 1, 33233, 630.2436,  -276.2591,  392.3122, 1.797689, 8, 0, 'Razorscale Controller'),
(33186, 0, 1, 33233, 638.2416,  -272.1735,  392.1351, 1.815142, 8, 0, 'Razorscale Controller'),
(33186, 0, 1, 33233, 633.6514,  -287.3748,  391.8054, 1.797689, 8, 0, 'Razorscale Controller'),
(33186, 0, 1, 33233, 605.9334,  -140.0912,  391.6004, 4.485496, 8, 0, 'Razorscale Controller'),
(33186, 0, 1, 33233, 572.4106,  -138.6564,  393.9044, 4.764749, 8, 0, 'Razorscale Controller'),
(33186, 0, 1, 33233, 558.9486,  -142.9874,  391.6004, 4.764749, 8, 0, 'Razorscale Controller'),
(33186, 0, 1, 33233, 589.7287,  -137.1148,  393.9011, 4.485496, 8, 0, 'Razorscale Controller'),
-- Group 2: Harpoon Fire States (10-man)
(33186, 0, 2, 33282, 589.6996, -134.6657, 391.6004, 4.555309, 8, 0, 'Razorscale Harpoon Fire State (10M)'),
(33186, 0, 2, 33282, 572.0398, -136.2224, 391.2637, 4.642576, 8, 0, 'Razorscale Harpoon Fire State (10M)'),
-- Group 3: Harpoon Fire States (25-man)
(33186, 0, 3, 33282, 559.5352, -140.9866, 391.6004, 4.642576, 8, 0, 'Razorscale Harpoon Fire State (25M)'),
(33186, 0, 3, 33282, 606.2806, -137.2628, 391.6004, 4.537856, 8, 0, 'Razorscale Harpoon Fire State (25M)');

-- Update creature_template ScriptNames
UPDATE `creature_template` SET `ScriptName` = 'npc_razorscale_spawner' WHERE `entry` = 33245;
UPDATE `creature_template` SET `AIName` = 'NullCreatureAI' WHERE (`entry` = 33233);
UPDATE `creature_template` SET `ScriptName` = 'npc_expedition_commander' WHERE `entry` = 33210;
UPDATE `creature_template` SET `ScriptName` = 'npc_expedition_defender' WHERE `entry` = 33816;
UPDATE `creature_template` SET `ScriptName` = 'npc_expedition_trapper' WHERE `entry` = 33259;
UPDATE `creature_template` SET `ScriptName` = 'npc_expedition_engineer' WHERE `entry` = 33287;
UPDATE `creature_template` SET `ScriptName` = 'npc_razorscale_harpoon_fire_state' WHERE `entry` = 33282;
UPDATE `creature_template` SET `ScriptName` = 'npc_razorscale_dark_rune_guardian' WHERE `entry` = 33388;
UPDATE `creature_template` SET `ScriptName` = 'npc_razorscale_dark_rune_watcher' WHERE `entry` = 33453;
UPDATE `creature_template` SET `ScriptName` = 'npc_razorscale_dark_rune_sentinel' WHERE `entry` = 33846;
UPDATE `creature_template` SET `ScriptName` = 'npc_razorscale_devouring_flame' WHERE `entry` = 34188;

-- Razorscale Controller: set faction to friendly so it doesn't aggro players but can still cast
UPDATE `creature_template` SET `faction` = 35, `unit_flags` = 33554432 WHERE `entry` = 33233;

-- Update gameobject_template ScriptNames
UPDATE `gameobject_template` SET `ScriptName` = 'go_razorscale_harpoon' WHERE `entry` IN (194519, 194541, 194542, 194543);
UPDATE `gameobject_template` SET `ScriptName` = 'go_razorscale_mole_machine' WHERE `entry` = 194316;

-- Devouring Flame Stalker: cast aura on spawn
DELETE FROM `creature_template_addon` WHERE `entry` IN (34188, 34189);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(34188, 0, 0, 33554688, 0, 0, '64709'),
(34189, 0, 0, 33554688, 0, 0, '64709');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ( 'spell_razorscale_summon_iron_dwarves', 'spell_razorscale_fuse_armor', 'spell_razorscale_firebolt', 'spell_razorscale_flame_breath');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63968, 'spell_razorscale_summon_iron_dwarves'),
(63969, 'spell_razorscale_summon_iron_dwarves'),
(63970, 'spell_razorscale_summon_iron_dwarves'),
(64821, 'spell_razorscale_fuse_armor'),
(62669, 'spell_razorscale_firebolt'),
(63317, 'spell_razorscale_flame_breath'),
(64021, 'spell_razorscale_flame_breath');

-- Spell difficulty entries (core auto-resolves 10/25 man versions)
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (63317, 64709, 64758, 63809);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(63317, 63317, 64021, 0, 0), -- Flame Breath
(64709, 64709, 64734, 0, 0), -- Devouring Flame (Ground)
(64758, 64758, 64759, 0, 0), -- Chain Lightning
(63809, 63809, 64696, 0, 0); -- Lightning Bolt

-- Conditions for Expedition Trapper Shackle (62646) to only hit Razorscale (33186)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 62646;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 62646, 0, 0, 31, 0, 3, 33186, 0, 0, 0, 0, '', 'Effect_0 hits Razorscale');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 62646) AND (`SourceId` = 0) AND (`ElseGroup` = 1) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 33724) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 62646, 0, 1, 31, 0, 3, 33724, 0, 0, 0, 0, '', 'Effect_0 hits Razorscale (1)');

-- Conditions: only show gossip option when Razorscale encounter is not in progress
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 10314 AND `SourceEntry` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 10314, 0, 0, 0, 13, 0, 2, 3, 2, 1, 0, 0, '', 'Show gossip only when Razorscale is NOT done (BossState != DONE)');

-- Add Dark Rune Guardian (1) to 25-man Flame Breath 'TARGET_UNIT_CONE_ENTRY'
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 3) AND (`SourceEntry` = 64021) AND (`SourceId` = 0) AND (`ElseGroup` = 2) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 33850) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 64021, 0, 2, 31, 0, 3, 33850, 0, 0, 0, 0, '', 'Flame Breath - Dark Rune Guardian (1)');
