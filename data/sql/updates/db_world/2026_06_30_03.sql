-- DB update 2026_06_30_02 -> 2026_06_30_03
--
-- npcflag +SPELLCLICK
-- unit_flag -NON_ATTACKABLE, +NOT_SELECTABLE
UPDATE `creature_template` SET `faction` = 14, `npcflag` = `npcflag` | 16777216, `unit_flags` = (`unit_flags` & (~2)) | 33554432 WHERE (`entry` IN (30248, 31749));
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 31749;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES(31749, 61421, 0, 0);
