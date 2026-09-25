-- DB update 2025_03_16_02 -> 2025_03_16_03
-- Remove SmartAI sql for NPC Jenny (25969)
DELETE FROM `smart_scripts`
WHERE `entryorguid` = 25969;

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_jenny' WHERE (`entry` = 25969);

-- spell 46340 Crates Carried
-- add custom attribute SPELL_ATTR0_CU_IGNORE_EVADE
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 46340;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(46340, 2048);
