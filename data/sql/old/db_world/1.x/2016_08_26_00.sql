ALTER TABLE version_db_world CHANGE COLUMN 2016_08_25_00 2016_08_26_00 bit;

DELETE FROM command WHERE name IN ('npc evade', 'debug send chatmessage');
