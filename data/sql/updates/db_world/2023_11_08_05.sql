-- DB update 2023_11_08_04 -> 2023_11_08_05
-- Feranin
UPDATE `creature_template` SET `npcflag` = `npcflag`|512 WHERE `entry` = 19518;
