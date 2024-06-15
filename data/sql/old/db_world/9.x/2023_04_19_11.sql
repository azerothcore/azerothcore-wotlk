-- DB update 2023_04_19_10 -> 2023_04_19_11
-- Prospector Ryedol (2910)
DELETE FROM `npc_vendor` WHERE `entry` = 2910;
UPDATE `creature_template` SET `npcflag` = `npcflag`&~(128) WHERE `entry` = 2910;
