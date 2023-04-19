-- Prospector Ryedol (2910)
DELETE FROM `npc_vendor` WHERE `entry` = 2910;
UPDATE `creature_template` SET `npcflag` = `npcflag`&~(128) WHERE `entry` = 2910;
