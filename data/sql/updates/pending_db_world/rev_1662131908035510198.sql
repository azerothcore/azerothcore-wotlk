--
UPDATE `creature_template` SET `npcflag` = `npcflag`&~(4096) WHERE (`entry` = 16280);
UPDATE `creature_template` set `npcflag` = `npcflag`&~(4096) where (`entry` = 16278);
