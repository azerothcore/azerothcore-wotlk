--
DELETE FROM `updates_include` WHERE `path` = '$/data/sql/updates/pending_db_auth'
INSERT INTO `updates_include` (`path`, `state`) VALUES ('$/data/sql/updates/pending_db_auth', 'CUSTOM');
