ALTER TABLE auth_db_version CHANGE COLUMN 2016_08_25_00 2016_08_25_01 bit;

RENAME TABLE `auth_db_version` TO `version_db_auth`;

ALTER TABLE `version_db_auth`
ADD COLUMN `sql_rev` VARCHAR(100) NOT NULL FIRST,
ADD COLUMN `required_rev` VARCHAR(100) NULL AFTER `sql_rev`,
ADD PRIMARY KEY (`sql_rev`),
ENGINE=INNODB;

ALTER TABLE `version_db_auth` ADD CONSTRAINT `required` FOREIGN KEY (`required_rev`) REFERENCES `version_db_auth`(`sql_rev`);


