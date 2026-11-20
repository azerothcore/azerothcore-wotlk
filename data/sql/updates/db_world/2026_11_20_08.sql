-- DB update 2026_11_20_07 -> 2026_11_20_08
--
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5475;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(5475, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 5475 AND `source_type` = 2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5475, 2, 0, 0, 46, 0, 100, 0, 5475, 0, 0, 0, 0, 0, 223, 3, 0, 0, 0, 0, 0, 205, 14, 1, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Do Action ID 3');

-- Anub'arak Tap List
DELETE FROM `creature` WHERE `id` = 36099 AND `guid` = 13416;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(13416, 36099, 649, 0, 0, 15, 1, 0, 707.94617, 70.579865, 142.2023, 0, 604800, 0, 0, 1, 0, 0, 0, 0, 0, '', 50375, 1, NULL);
