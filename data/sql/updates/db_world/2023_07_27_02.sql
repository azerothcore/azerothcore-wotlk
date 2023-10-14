-- DB update 2023_07_27_01 -> 2023_07_27_02
--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 29683 AND `spell_effect` = 32214;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(29683, 32214, 0, "Spotlight 20% player buff");
