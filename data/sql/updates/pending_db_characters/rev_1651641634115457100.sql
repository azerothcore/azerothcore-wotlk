--
DELETE FROM `updates_include` WHERE `path` = '$/data/sql/updates/pending_db_characters'
INSERT INTO `updates_include` (`path`, `state`) VALUES ('$/data/sql/updates/pending_db_characters', 'CUSTOM');
