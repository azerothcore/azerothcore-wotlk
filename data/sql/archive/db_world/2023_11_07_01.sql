-- DB update 2023_11_07_00 -> 2023_11_07_01
-- Targrom
UPDATE `creature_template` SET `npcflag` = `npcflag`|512 WHERE `entry` = 19348;
