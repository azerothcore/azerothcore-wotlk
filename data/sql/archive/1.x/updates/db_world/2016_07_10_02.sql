ALTER TABLE world_db_version CHANGE COLUMN 2016_07_10_01 2016_07_10_02 bit;

/* Quest adding injury to insult, fix mob speed run, from 2.2 to 1.0 */
UPDATE `creature_template` SET `speed_run` = 1 WHERE `entry` = 24238;
