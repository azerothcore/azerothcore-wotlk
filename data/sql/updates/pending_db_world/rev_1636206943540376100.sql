INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636206943540376100');

ALTER TABLE `updates` CHANGE `state` `state` ENUM('RELEASED','CUSTOM','MODULE','ARCHIVED') CHARSET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'RELEASED' NOT NULL COMMENT 'defines if an update is released or archived.';
