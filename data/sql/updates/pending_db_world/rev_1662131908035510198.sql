--
UPDATE `creature_template` SET `npcflag` = `npc_flag`&~(4096) WHERE (`entry` = 16280);
UPDATE `creature_template` set `npcflag` = `npc_flag`&~(4096) where (`entry` = 16278);
