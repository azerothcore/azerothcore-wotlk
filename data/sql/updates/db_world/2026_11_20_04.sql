-- DB update 2026_11_20_03 -> 2026_11_20_04
-- Skittering Scarab: ambient scarabs in Anub'arak's chamber, submerging and emerging at random until the pull
UPDATE `creature_template` SET `AIName` = 'SmartAI', `VerifiedBuild` = 50375 WHERE `entry` = 35763;

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 35763;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(35763, 1, 1, 0, 0, 0, 2, NULL);

-- They spawn submerged
DELETE FROM `creature_template_addon` WHERE `entry` = 35763;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(35763, 0, 0, 0, 1, 0, 0, '66845');

-- Week-long respawn: the pull despawns them for the rest of the lockout
DELETE FROM `creature` WHERE `id` = 35763 AND `guid` BETWEEN 13405 AND 13415;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(13405, 35763, 649, 0, 0, 15, 1, 0, 694.6233, 137.7882, 142.23717, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL), -- spawn point
(13406, 35763, 649, 0, 0, 15, 1, 0, 697.66144, 174.71875, 142.20274, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL), -- spawn point
(13407, 35763, 649, 0, 0, 15, 1, 0, 692.6567, 119.1391, 142.3587, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL), -- centre of wander area
(13408, 35763, 649, 0, 0, 15, 1, 0, 713.6024, 147.3993, 142.345, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL), -- spawn point
(13409, 35763, 649, 0, 0, 15, 1, 0, 726.1235, 142.0886, 142.4853, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL), -- centre of wander area
(13410, 35763, 649, 0, 0, 15, 1, 0, 763.7017, 161.28, 142.3107, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL), -- centre of wander area
(13411, 35763, 649, 0, 0, 15, 1, 0, 726.0035, 177.82292, 142.24991, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL), -- spawn point
(13412, 35763, 649, 0, 0, 15, 1, 0, 704.3458, 124.9365, 142.3107, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL), -- centre of wander area
(13413, 35763, 649, 0, 0, 15, 1, 0, 744.3939, 107.6207, 142.3455, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL), -- centre of wander area
(13414, 35763, 649, 0, 0, 15, 1, 0, 745.6689, 146.6562, 142.3419, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL), -- centre of wander area
(13415, 35763, 649, 0, 0, 15, 1, 0, 722.6933, 88.1701, 142.3107, 5.497787, 604800, 20, 0, 1, 0, 1, 0, 0, 0, '', 50375, 1, NULL); -- centre of wander area

-- Phase 1: emerged and wandering, phase 2: submerged, phase 3: submerged for good after Anub'arak's pull,
-- phase 4: submerged since spawn until players come near (the player check is 2D: at 60 yd the coliseum floor above, closest at the North Portcullis about 71 yd away, stays out of range)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 35763 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(35763, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On Reset - Set Event Phase 4'),
(35763, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On Link - Set Flags Not Selectable'),
(35763, 0, 2, 3, 1, 1, 100, 0, 16000, 31000, 16000, 31000, 0, 0, 11, 66845, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - Out of Combat - Cast \'Submerge\' (Phase 1)'),
(35763, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On Link - Set Event Phase 2'),
(35763, 0, 4, 0, 8, 0, 100, 0, 66845, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On Spellhit \'Submerge\' - Set Flags Not Selectable'),
(35763, 0, 5, 6, 1, 2, 100, 0, 1000, 6000, 8000, 23000, 0, 0, 28, 66845, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - Out of Combat - Remove Aura \'Submerge\' (Phase 2)'),
(35763, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On Link - Remove Flags Not Selectable'),
(35763, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 65982, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On Link - Cast \'Emerge\''),
(35763, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On Link - Set Event Phase 1'),
(35763, 0, 9, 10, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On Action 1 Done - Set Event Phase 3'),
(35763, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 66845, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On Link - Cast \'Submerge\' (Aura Not Present)'),
(35763, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On Link - Despawn In 3000 ms'),
(35763, 0, 12, 0, 101, 8, 100, 0, 1, 60, 1000, 1000, 1000, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skittering Scarab - On 1 Player Within 60 Yards - Set Event Phase 2 (Phase 4)');
