-- DB update 2026_05_24_02 -> 2026_05_25_00
-- Hide Whispering Wind (30848) during Wintergrasp battle.
-- Aura 52107 phases the creature out while war is active; the other five
-- small WG elementals (30842, 30845, 30846, 30847, 30849) already have it
-- in creature_template_addon — 30848 was missed.
DELETE FROM `creature_template_addon` WHERE `entry` = 30848;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(30848, 0, 0, 0, 1, 0, 0, '52107');
