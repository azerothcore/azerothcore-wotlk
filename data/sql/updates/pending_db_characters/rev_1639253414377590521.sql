--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1639253414377590521');

ALTER TABLE `updates`   
  CHANGE `state` `state` ENUM('RELEASED','ARCHIVED','CUSTOM','MODULE') CHARSET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'RELEASED' NOT NULL COMMENT 'defines if an update is released or archived.';

--
-- END UPDATING QUERIES
--