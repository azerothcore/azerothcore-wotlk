-- DB update 2023_02_19_01 -> 2023_02_19_02
--
DELETE FROM `npc_vendor` WHERE `entry` = 20130;
UPDATE `creature_template` SET `npcflag` = `npcflag`&~(128) WHERE `entry` = 20130;
