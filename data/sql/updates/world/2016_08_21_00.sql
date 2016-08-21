ALTER TABLE world_db_version CHANGE COLUMN 2016_08_14_02 2016_08_21_00 bit;

DELETE FROM `spell_bonus_data` WHERE `entry` IN (47632,47633);
