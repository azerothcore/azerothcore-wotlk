INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629121385000760612');

UPDATE gameobject SET spawntimesecs = 2700 WHERE id = 142145 AND spawntimesecs <= 60;
