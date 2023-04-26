-- Anchorite Yazmina (23734)
UPDATE `creature_template` SET `npcflag` = `npcflag`&~(128) WHERE `entry` = 23734;
DELETE FROM `npc_vendor` WHERE `entry` = 23734;
