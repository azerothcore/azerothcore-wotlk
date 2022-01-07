INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641574598839293356');

-- remove ctm for creatures dalaran visitor (two fo them) by default they are just walkers but smart ai set them as runnings
-- this corrects the issue of them flying when they land in dalaran
DELETE FROM `creature_template_movement` WHERE  CreatureId AND (32596, 32597);
