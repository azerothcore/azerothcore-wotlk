--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -44873 AND `spell_effect` = 44874;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-44873, 44874, 0, 'on Flame Ring removal cast Flame Ring explosion (Brutallus - Madrigosa)');
