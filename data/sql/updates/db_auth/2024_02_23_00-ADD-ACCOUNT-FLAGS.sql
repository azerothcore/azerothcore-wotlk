-- Add the account_flags field to the account table
ALTER TABLE `acore_auth`.`account`   
	ADD COLUMN `account_flags` INT UNSIGNED ZEROFILL NULL AFTER `username`;