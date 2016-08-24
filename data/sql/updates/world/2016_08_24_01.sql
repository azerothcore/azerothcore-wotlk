ALTER TABLE world_db_version CHANGE COLUMN 2016_08_24_00 2016_08_24_01 bit;

DELETE FROM `spell_bonus_data` WHERE `entry` IN (47632,47633);
