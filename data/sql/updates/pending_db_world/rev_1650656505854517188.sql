INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650656505854517188');

DELETE FROM `spell_proc_event` WHERE `entry` = '71602';
DELETE FROM `spell_proc_event` WHERE `entry` = '75465';

UPDATE `item_template` SET `spellppmRate_1` = 10 WHERE (`entry` = 54572);
UPDATE `item_template` SET `spellppmRate_1` = 10 WHERE (`entry` = 50353);
