INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649370784577886400');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 23414 AND `spell_effect` IN (-1856, -1857, -26889);
INSERT INTO spell_linked_spell (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(23414, -1856, 2, 'Nefarian Rogue class call - Vanish'),
(23414, -1857, 2, 'Nefarian Rogue class call - Vanish'),
(23414, -26889, 2, 'Nefarian Rogue class call - Vanish');
