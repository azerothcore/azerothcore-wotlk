ALTER TABLE world_db_version CHANGE COLUMN 2016_08_24_00 2016_08_24_01 bit;

UPDATE command SET security = 0 WHERE name = 'gm ingame';
