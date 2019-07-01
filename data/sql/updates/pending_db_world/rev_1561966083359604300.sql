INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561966083359604300');

DELETE FROM `creature_questender` WHERE `id`=15350 AND `quest` IN (8367,13476);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES 
('15350', '8367'),
('15350', '13476');

DELETE FROM `creature_queststarter` WHERE `id`=15351 AND `quest` IN (8371,13478);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES 
('15351', '8371'),
('15351', '13478');
