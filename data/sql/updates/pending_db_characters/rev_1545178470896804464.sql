INSERT INTO version_db_characters (`sql_rev`) VALUES ('1545178470896804464');

ALTER TABLE `character_queststatus`
  ADD `itemcount5` smallint(5) unsigned NOT NULL DEFAULT '0' AFTER `itemcount4`,
  ADD `itemcount6` smallint(5) unsigned NOT NULL DEFAULT '0' AFTER `itemcount5`;