-- DB update 2022_08_05_00 -> 2022_08_06_00
--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=28757;
INSERT INTO `spell_linked_spell` VALUES
(28757,28758,0,'Stalker\'s Ally');
