INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633368419901196100');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 17500;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(17500, 17499, 0, 'Malown\'s Slam - trigger Surge of Strenght');
