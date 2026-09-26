-- DB update 2026_09_15_01 -> 2026_09_15_02
--
-- The civilian flag blocks aggro outright, and no other Winterfall furbolg carries it.
UPDATE `creature_template` SET `flags_extra` = `flags_extra` & ~0x2 WHERE `entry` = 10916;
