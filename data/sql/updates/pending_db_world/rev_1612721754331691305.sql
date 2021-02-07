INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612721754331691305');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 19512;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(19512, -19502, 1, 'Apply Salve - Sickly Critter Aura removed');
