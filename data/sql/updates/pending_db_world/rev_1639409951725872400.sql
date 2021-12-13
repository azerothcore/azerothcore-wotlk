INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639409951725872400');

/* Assign Alchemist Arbington as Queststarter & Questender of 'The Key to Scholomance' ID 5505
*/

DELETE FROM `creature_queststarter` WHERE (`quest` = 5505) AND (`id` IN (10838, 11056));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(11056, 5505);

DELETE FROM `creature_questender` WHERE (`quest` = 5505) AND (`id` IN (10838, 11056));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(11056, 5505);