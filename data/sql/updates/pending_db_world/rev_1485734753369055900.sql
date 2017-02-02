INSERT INTO version_db_world (`sql_rev`) VALUES ('1485734753369055900');
-- SET run_speed of (Thunder BluffSilvermoon, Undercity, Stormwind, Ironforge, Exodar, Gnomeregan and Darnassus Champion(s) from 2 to 1.38571)
UPDATE `creature_template` SET `speed_run` = 1.38571  WHERE `entry` IN (35325, 35326, 35327, 35328, 35329, 35330, 35331, 35332);

-- SET run_speed of (Colosos, Marshal Jacob Alerius, Ambrose Boltspark, Lana Stouthammer and Jaelyne Evensong from 2 to 1.14286)
UPDATE `creature_template` SET `speed_run` = 1.14286  WHERE `entry` IN (34657, 34701, 34702, 34703, 34705);
