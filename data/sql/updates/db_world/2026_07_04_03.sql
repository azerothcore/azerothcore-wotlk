-- DB update 2026_07_04_02 -> 2026_07_04_03
--
-- XT-002 Deconstructor: rework

-- Vehicle accessory: auto-spawn Heart of the Deconstructor when XT-002 spawns
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 33293 AND `accessory_entry` = 33329;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(33293, 33329, 0, 0, 'XT-002 Deconstructor - Heart', 6, 30000);

-- Spell script names for exposed heart and energy orb
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_xt002_exposed_heart', 'spell_xt002_energy_orb');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63849, 'spell_xt002_exposed_heart'),
(62826, 'spell_xt002_energy_orb');

-- Spell script name for Heart Overload periodic trigger (server-side spell 62791)
DELETE FROM `spell_script_names` WHERE `spell_id`=62791 AND `ScriptName`='spell_xt002_heart_overload_periodic';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62791, 'spell_xt002_heart_overload_periodic');

-- Update Gravity Bomb ScriptNames
UPDATE `spell_script_names` SET `ScriptName`='spell_xt002_gravity_bomb_aura' WHERE `spell_id` IN (63024, 64234) AND `ScriptName`='spell_xt002_gravity_bomb';

-- Spell script name for generic Submerge spell
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_xt002_submerged' AND `spell_id`=37751;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37751, 'spell_xt002_submerged');

-- Spell script name for generic Stand spell
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_xt002_stand' AND `spell_id`=37752;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37752, 'spell_xt002_stand');

-- Disable spell proc on Exposed Heart effect_1 (handled by script)
DELETE FROM `spell_proc` WHERE `SpellId`=63849;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(63849, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 0, 0, 0, 0);

-- Replace waypoint_data for XT-002 pre-combat patrol path
DELETE FROM `waypoint_data` WHERE `id`=1360540;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1360540,  1, 862.5053,   7.207682, 409.8612,        0,     0, 0, 0, 100, 0),
(1360540,  2, 863.4635,  25.65489,  409.8612,        0,     0, 0, 0, 100, 0),
(1360540,  3, 872.6903,  39.44819,  409.8355,        0, 11000, 0, 0, 100, 0), -- MovementInform: emote 468
(1360540,  4, 869.8901,  32.82189,  409.8509,        0,     0, 0, 0, 100, 0),
(1360540,  5, 854.8365,   9.631022, 409.8612,        0,     0, 0, 0, 100, 0),
(1360540,  6,  855.48,  -19.90913,  409.8787,        0,     0, 0, 0, 100, 0),
(1360540,  7, 852.1145, -44.87088,  409.8869,        0,     0, 0, 0, 100, 0),
(1360540,  8, 864.5853, -62.56917,  409.6369,        0,     0, 0, 0, 100, 0),
(1360540,  9, 876.4196, -77.23026,  409.9155,        0, 11000, 0, 0, 100, 0), -- MovementInform: emote 468
(1360540, 10, 878.3914, -79.4183,   409.9155,        0,     0, 0, 0, 100, 0),
(1360540, 11, 870.9197, -65.75331,  409.9155,        0,     0, 0, 0, 100, 0),
(1360540, 12, 880.2524, -33.8488,   409.9155,        0,     0, 0, 0, 100, 0),
(1360540, 13, 883.6281, -12.63596,  409.799,  3.159046, 30000, 0, 0, 100, 0); -- MovementInform: emote 10

DELETE FROM `waypoint_scripts` WHERE `guid`=5 and `id` = 1360540;
DELETE FROM `waypoint_scripts` WHERE `guid`=6 and `id` = 1360541;

-- Update script names for adds
UPDATE `creature_template` SET `ScriptName`='npc_scrapbot'      WHERE `entry`=33343;
UPDATE `creature_template` SET `ScriptName`='npc_pummeller'     WHERE `entry`=33344;
UPDATE `creature_template` SET `ScriptName`='npc_boombot'       WHERE `entry`=33346;
UPDATE `creature_template` SET `ScriptName`='npc_life_spark'    WHERE `entry`=34004;
UPDATE `creature_template` SET `ScriptName`='npc_xt_void_zone', `AIName` = '' WHERE `entry`=34001;

-- Base attack time for XT-002 (both 10 and 25) from 1800
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry` IN (33293, 33885);

-- Achievement script names
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_nerf_engineering' WHERE `ScriptName`='achievement_xt002_nerf_engineering';
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_nerf_gravity_bombs' WHERE `ScriptName`='achievement_xt002_nerf_gravity_bombs';

-- Achievement heartbreaker: type=11 script entries for hard mode (criteria 10072=25M, 10073=10M)
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10072,10073) AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(10072, 11, 0, 0, 'achievement_heartbreaker'),
(10073, 11, 0, 0, 'achievement_heartbreaker');

-- Mechanical immunities for Heart of the Deconstructor and XT-002 (both 10 and 25)
SET @ID := -427;

DELETE FROM `creature_immunities` WHERE `ID` = @ID;
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(@ID, 0, 0, 617299839, '98,124,144,145', 0, 0, 0, 'mech=0x26CB3F7F(CHARM|DISORIENTED|DISARM|DISTRACT|FEAR|GRIP|ROOT|SILENCE|SLEEP|SNARE|STUN|FREEZE|KNOCKOUT|POLYMORPH|BANISH|SHACKLE|TURN|HORROR|DAZE|SAPPED), flags=IMMUNITY_KNOCKBACK, effects=98(KNOCK_BACK),124(PULL_TOWARDS),144(KNOCK_BACK_DEST),145(PULL_TOWARDS_DEST)');

UPDATE `creature_template` SET `CreatureImmunitiesId` = @ID WHERE (`entry` IN (33329, 33995, 33293, 33885));

-- Cannot turn
UPDATE `creature_template` SET `unit_flags2` = `unit_flags2` | 32768 WHERE (`entry` IN (33329, 33995));

-- only hits XT-002
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 64799) AND (`SourceId` = 0) AND (`ElseGroup` IN (0, 1)) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` IN (33293, 33885)) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 64799, 0, 0, 31, 0, 3, 33293, 0, 0, 0, 0, '', 'target must be \'XT-002 Deconstructor\''),
(13, 1, 64799, 0, 1, 31, 0, 3, 33885, 0, 0, 0, 0, '', 'target must be \'XT-002 Deconstructor (1)\'');

UPDATE `spell_proc` SET `AttributesMask`=0, `DisableEffectsMask`=2 WHERE `SpellId`=63849;

-- Toy Piles: spawn at 4 corners of the room (positions from TC, map 603 Ulduar)
SET @CGUID := 12777;
SET @BUILD := 0;
DELETE FROM `creature` WHERE (`id` = 33337) AND (`guid` BETWEEN @CGUID+0 AND @CGUID+3);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(@CGUID+0, 33337, 603, 0, 0, 3, 1, 0, 897.908, 67.0764, 412.129, 3.92699, 180, 0, 0, 12600, 0, 0, 0, 0, 0, '', '', @BUILD),
(@CGUID+1, 33337, 603, 0, 0, 3, 1, 0, 898.099, -88.9115, 409.887, 2.23402, 180, 0, 0, 12600, 0, 0, 0, 0, 0, '', '', @BUILD),
(@CGUID+2, 33337, 603, 0, 0, 3, 1, 0, 793.096, -95.158, 409.887, 0.855211, 180, 0, 0, 12600, 0, 0, 0, 0, 0, '', '', @BUILD),
(@CGUID+3, 33337, 603, 0, 0, 3, 1, 0, 792.646, 65.3854, 414.147, 5.20108, 180, 0, 0, 12600, 0, 0, 0, 0, 0, '', '', @BUILD);

DELETE FROM `spell_script_names` WHERE `spell_id`=62826 AND `ScriptName`='spell_xt002_energy_orb';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_xt_toy_pile' WHERE (`entry` = 33337);
