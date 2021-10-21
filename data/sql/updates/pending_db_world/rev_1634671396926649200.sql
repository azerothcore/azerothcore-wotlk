INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634671396926649200');

DELETE FROM `spell_script_names` WHERE `spell_id`=58984;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=58984;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(58984,59646,0,'Shadowmeld: Sanctuary'),
(58984,62196,0,'Shadowmeld: Force deselect');
