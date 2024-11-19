-- DB update 2024_05_27_01 -> 2024_05_27_02
--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -42201 AND `spell_effect` = 42205;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-42201, 42205, 0, 'Eternal Silence trigger Residue of Eternity on removal');
