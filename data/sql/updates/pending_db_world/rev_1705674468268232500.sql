-- Fix Dalaran Toy Store Plane behaviour

-- Update creature 29802 'Cosmetic Toy Plane' with sniffed values
DELETE FROM `creature` WHERE (`id1` = 29802) AND (`guid` IN (105492));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(105492, 29802, 571, 1, 1, 0, 5809.88818359375, 683.577880859375, 653.68585205078125, 5.602106094360351562, 120, 0, 0, 0, 0, 0, "", 52237, 1, NULL);

-- ScriptedAI
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_cosmetic_toy_plane' WHERE (`entry` = 29802);
