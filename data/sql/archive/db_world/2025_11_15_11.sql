-- DB update 2025_11_15_10 -> 2025_11_15_11

-- Add Immune To PC, Immune To Npc, Stunned, Prevent Emotes, Feign Death and remove All Dynamic Flags (Sniffed)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |256|512|262144|536870912, `unit_flags2` = `unit_flags2` |1, `dynamicflags` = 0  WHERE (`entry` = 26514);

-- Add Aura (Sniffed)
DELETE FROM `creature_template_addon` WHERE (`entry` = 26514);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(26514, 0, 0, 0, 0, 0, 0, '29266');

-- Add Disable Gravity and Rooted (Sniffed)
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 26514);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(26514, 0, 0, 1, 1, 0, 0, 0);
