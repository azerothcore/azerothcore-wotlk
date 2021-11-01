ALTER TABLE world_db_version CHANGE COLUMN 2016_08_24_01 2016_08_25_00 bit;

RENAME TABLE `world_db_version` TO `version_db_world`;

ALTER TABLE `version_db_world`
ADD COLUMN `sql_rev` VARCHAR(100) NOT NULL FIRST,
ADD COLUMN `required_rev` VARCHAR(100) NULL AFTER `sql_rev`,
ADD PRIMARY KEY (`sql_rev`),
ENGINE=INNODB;

ALTER TABLE `version_db_world` ADD CONSTRAINT `required` FOREIGN KEY (`required_rev`) REFERENCES `version_db_world`(`sql_rev`);

