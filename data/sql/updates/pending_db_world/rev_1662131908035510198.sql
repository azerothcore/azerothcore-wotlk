--
UPDATE `creature_template` SET `npcflag` = `npcflag`&~(4096) WHERE `entry` IN (16280, 16278);
