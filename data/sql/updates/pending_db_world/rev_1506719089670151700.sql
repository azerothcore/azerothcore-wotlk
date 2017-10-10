INSERT INTO version_db_world (`sql_rev`) VALUES ('1506719089670151700');

UPDATE creature_template SET flags_extra =+ 2 WHERE entry IN (69,299);
