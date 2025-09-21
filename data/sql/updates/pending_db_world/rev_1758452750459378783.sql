--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (66050, 62062, 66052) AND `spell_effect` IN (49357, 52845);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(62062, 49357, 0, 'Brewfest Holiday Mount'),
(66052, 49357, 0, 'Brewfest Holiday Mount'),
(66050, 52845, 0, 'Brewfest Holiday Mount Reverse');
