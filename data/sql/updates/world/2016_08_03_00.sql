ALTER TABLE world_db_version CHANGE COLUMN 2016_08_01_00 2016_08_03_00 bit;

DELETE from spell_area where spell = 60815  and area = 14;
