INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1618660143408049500');

ALTER TABLE `gm_ticket`
	CHANGE COLUMN `closedBy` `closedBy` INT NOT NULL DEFAULT 0 AFTER `lastModifiedTime`,
	CHANGE COLUMN `resolvedBy` `resolvedBy` IN NOT NULL DEFAULT 0 COMMENT '-1 Closed by Console, >0 GUID of GM' AFTER `needMoreHelp`;
