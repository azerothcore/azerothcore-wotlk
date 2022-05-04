--
DELETE FROM `updates_include` WHERE `path` = '$/data/sql/updates/pending_db_world'
INSERT INTO `updates_include` (`path`, `state`) VALUES ('$/data/sql/updates/pending_db_world', 'CUSTOM');
