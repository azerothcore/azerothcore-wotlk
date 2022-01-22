INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1642821969869259834');

-- column `type` contains type of logged action
ALTER TABLE `log_money` ADD COLUMN `type` tinyint(1) NOT NULL COMMENT '1=COD,2=AH,3=GB DEPOSIT,4=GB WITHDRAW,5=MAIL,6=TRADE' AFTER `date`;
