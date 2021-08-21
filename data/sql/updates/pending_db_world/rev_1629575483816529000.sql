INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629575483816529000');

DELETE FROM `acore_string` WHERE `entry` IN (30087, 30088, 30089);

INSERT INTO `acore_string` 
    (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) 
VALUES 
    (30087,'Accepting Invites: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (30088,'Accepting Invites: ON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (30089,'Accepting Invites: OFF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
