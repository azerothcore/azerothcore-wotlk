INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1621780938723425400');

ALTER TABLE `mail` 
ADD COLUMN `auctionId` INT DEFAULT 0 NOT NULL AFTER `checked`; 
