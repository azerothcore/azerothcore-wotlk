-- DB update 2025_11_09_04 -> 2025_11_09_05
--
-- v11_2_5_63906
SET @VBUILD := 63906;

DELETE FROM `creature_template_addon` WHERE (`entry` = 28503);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(28503, 0, 0, 0, 0, 0, 0, '58837');

DELETE FROM `creature_template_addon` WHERE (`entry` = 28998);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(28998, 0, 0, 0, 0, 0, 0, '58837');

DELETE FROM `creature` WHERE (`id1` = 28998) AND (`guid` IN (1974609));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(1974609, 28998, 0, 0, 571, 0, 0, 1, 1, 0, 6175.2456, -2017.6545, 590.9613, 3.0019662, 300, 0, 0, 550001, 0, 0, 0, 0, 0, '', NULL, @VBUILD);

DELETE FROM `creature_template_addon` WHERE (`entry` = 28998);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(28998, 0, 0, 0, 1, 0, 0, '');

UPDATE `spell_target_position` SET `PositionX`=6161.15, `PositionY`=-2015.36, `PositionZ`=590.878, `Orientation`=6.283189773559570312, `VerifiedBuild`=@VBUILD WHERE `ID`=52863 AND `EffectIndex`=0;

UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` = 28717);

-- Update comments
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28498) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28498, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 1, 28498, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - On Just Summoned - Start Waypoint Path 28498'),
(28498, 0, 1, 2, 40, 0, 100, 512, 2, 0, 0, 0, 0, 0, 54, 83000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - On Point 2 of Path Any Reached - Pause Waypoint'),
(28498, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2849800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - On Point 2 of Path Any Reached - Run Script'),
(28498, 0, 3, 4, 40, 0, 100, 512, 3, 0, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 10, 127495, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - On Point 3 of Path Any Reached - Set Data 0 2'),
(28498, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - On Point 3 of Path Any Reached - Despawn Instant');

-- Disable gravity
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 29100);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(29100, 0, 0, 1, 0, 0, 0, 0);

-- Idle
UPDATE `creature` SET `MovementType` = 0, `wander_distance` = 0 WHERE `id1` = 29100 AND `guid` IN (112307, 112308, 112309, 112310);

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 202357;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 202357) AND (`source_type` = 1) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(202357, 1, 0, 0, 62, 0, 100, 0, 11091, 0, 0, 0, 0, 0, 11, 57553, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakuru\'s Last Wish - On Gossip Option 0 Selected - Cast \'Escape Voltarus\'');

-- Drakuru's Last Wish
UPDATE `gameobject_template_addon` SET `flags` = 32 WHERE (`entry` = 202357);

-- Skull and Portal spells target 'Totally Generic Bunny (JSB)'
DELETE FROM `creature` WHERE (`id1` = 28960) and `guid` IN (98914, 98920);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(98914, 28960, 0, 0, 571, 0, 0, 1, 1, 0, 6144.01, -2011.8, 590.963, 6.16101, 300, 0, 0, 4979, 0, 0, 0, 0, 0, '', '\'Throw Portal Crystal\' guid target', @VBUILD),
(98920, 28960, 0, 0, 571, 0, 0, 1, 1, 0, 6181.5137, -2032.4258, 590.96124, 1.01229, 300, 0, 0, 4979, 0, 0, 0, 0, 0, '', '\'Drakuru\'s Skull Missile\' guid target', @VBUILD);

UPDATE `conditions` SET `ConditionValue3` = 98914, `Comment` = 'target Totally Generic Bunny (JSB)' WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 54209) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 28960) AND (`ConditionValue3` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 54250) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 28960);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 54250, 0, 0, 31, 0, 3, 28960, 98920, 0, 0, 0, '', 'target Totally Generic Bunny (JSB)');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 54089) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 1) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 51966) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 54089, 0, 0, 1, 0, 51966, 0, 0, 0, 0, 0, '', 'Has Aura \'Scourge Disguise\'');

-- 54104 Blight Fog
UPDATE `creature_template_addon` SET `auras` = '54104' WHERE (`entry` = 28998);

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 28998 and `summonerType` = 0 AND `groupId` = 1;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(28998, 0, 1, 28931, 6184.1455, -1970.1699, 586.84186, 4.5902, 8, 0, 'Overlord Drakuru - Group 1 - Blightblood Troll'),
(28998, 0, 1, 28931, 6222.855, -2026.6315, 586.84186, 3.00197, 8, 0, 'Overlord Drakuru - Group 1 - Blightblood Troll'),
(28998, 0, 1, 28931, 6166.278, -2065.3123, 586.84186, 1.44862, 8, 0, 'Overlord Drakuru - Group 1 - Blightblood Troll'),
(28998, 0, 1, 28931, 6127.5117, -2008.6506, 586.84186, 6.16101, 8, 0, 'Overlord Drakuru - Group 1 - Blightblood Troll');

-- 54105 Blight Fog
DELETE FROM `spell_script_names` WHERE (`spell_id` = 54105);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(54105, 'spell_blight_fog');
