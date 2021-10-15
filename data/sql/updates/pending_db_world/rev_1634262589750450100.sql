INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634262589750450100');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (19244, 19647);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES
('19244', '24259', 'Spell Lock - Rank 1');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES
('19647', '24259', 'Spell Lock - Rank 2');
