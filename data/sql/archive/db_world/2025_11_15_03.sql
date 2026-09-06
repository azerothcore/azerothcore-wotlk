-- DB update 2025_11_15_02 -> 2025_11_15_03
--
UPDATE `creature_template` SET `npcflag` = `npcflag` |65536 WHERE `entry` = 29944;
