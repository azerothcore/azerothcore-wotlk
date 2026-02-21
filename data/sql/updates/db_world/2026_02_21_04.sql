-- DB update 2026_02_21_03 -> 2026_02_21_04
DELETE FROM `spell_script_names` WHERE `spell_id` IN (56105, 55873);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(56105, 'spell_malygos_vortex_dummy'),
(55873, 'spell_malygos_vortex_visual');

DELETE FROM `creature` WHERE `guid` IN (132304, 132305, 132306, 132307, 132308);
INSERT INTO `creature`
(`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
 `position_x`, `position_y`, `position_z`, `orientation`,
 `spawntimesecs`, `wander_distance`, `currentwaypoint`,
 `curhealth`, `curmana`, `MovementType`, `npcflag`,
 `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`)
VALUES
(132304,30090,616,0,0,3,1,0,754.733,1301.51,283.379,5.58505,3600,0,0,12600,0,0,0,0,0,'',0),
(132305,30090,616,0,0,3,1,0,754.521,1301.23,279.524,0.680678,3600,0,0,12600,0,0,0,0,0,'',0),
(132306,30090,616,0,0,3,1,0,754.356,1301.48,285.733,5.96903,3600,0,0,12600,0,0,0,0,0,'',0),
(132307,30090,616,0,0,3,1,0,754.192,1301.18,281.851,5.75959,3600,0,0,12600,0,0,0,0,0,'',0),
(132308,30090,616,0,0,3,1,0,754.688,1301.8,287.295,1.25664,3600,0,0,12600,0,0,0,0,0,'',0);

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|33554432, `VehicleId` = 214, `flags_extra` = `flags_extra`|2|128, `ScriptName` = '' WHERE `entry` = 30090;

DELETE FROM `creature_template_addon` WHERE `entry` = 30090;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(30090, 0, 0, 0, 0, 0, 0, '55883');
