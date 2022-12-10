ALTER TABLE characters_db_version CHANGE COLUMN 2016_08_15_00 2016_08_25_00 bit;

RENAME TABLE `characters_db_version` TO `version_db_characters`;

ALTER TABLE `version_db_characters`
ADD COLUMN `sql_rev` VARCHAR(100) NOT NULL FIRST,
ADD COLUMN `required_rev` VARCHAR(100) NULL AFTER `sql_rev`,
ADD PRIMARY KEY (`sql_rev`),
ENGINE=INNODB;

ALTER TABLE `version_db_characters` ADD CONSTRAINT `required` FOREIGN KEY (`required_rev`) REFERENCES `version_db_characters`(`sql_rev`);

