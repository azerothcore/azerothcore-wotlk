INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561966083359604300');

DELETE FROM `creature_questender` WHERE `id`=15350 AND `quest` IN (8367,13476);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES 
('15350', '8367'),
('15350', '13476');
