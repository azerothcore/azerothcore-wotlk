-- DB update 2022_09_07_03 -> 2022_09_07_04
--
UPDATE `creature_template` SET `npcflag` = `npcflag`&~(4096) WHERE `entry` IN (16280, 16278);
