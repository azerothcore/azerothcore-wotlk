INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626953516206751500');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 13278 AND `spell_effect` = 13493;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(13278, 13493, 0, 'Gnomish Death Ray');
