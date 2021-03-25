-- DB update 2019_04_13_00 -> 2020_02_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_auth' AND COLUMN_NAME = '2019_04_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_auth CHANGE COLUMN 2019_04_13_00 2020_02_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_auth WHERE sql_rev = '1579213352894781043'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1579213352894781043');

-- ADD NEW COLUMN
ALTER TABLE `account_access` ADD COLUMN `comment` VARCHAR(255) DEFAULT '';

-- UPDATE ACCOUNTS
/*!40000 ALTER TABLE `account_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;

-- UPDATE ACCOUNTS test1 test2
UPDATE `account`
INNER JOIN `account_access`
ON `account`.`id` = `account_access`.`id`
SET `account_access`.`comment` = 'Test account - Console Admin'
WHERE (`account`.`username` = 'test1' AND `account`.`sha_pass_hash` = '047ce22643f9b0bd6baeb18d51bf1075a4d43fc6') OR
(`account`.`username` = 'test2' AND `account`.`sha_pass_hash` = '10eb1ff16cf5380147e8281cd8080a210ecb3c53');

-- UPDATE ACCOUNTS test3 test4
UPDATE `account`
INNER JOIN `account_access`
ON `account`.`id` = `account_access`.`id`
SET `account_access`.`gmlevel` = 3, `account_access`.`comment` = 'Test account - Ingame Admin'
WHERE (`account`.`username` = 'test3' AND `account`.`sha_pass_hash` = 'e546bbf9ca93ae5291f0b441bb9ea2fa0c466176') OR
(`account`.`username` = 'test4' AND `account`.`sha_pass_hash` = '61015d83b456a9c6a7defdff07f55265f24097af');

-- UPDATE ACCOUNTS test5 test6
UPDATE `account`
INNER JOIN `account_access`
ON `account`.`id` = `account_access`.`id`
SET `account_access`.`gmlevel` = 2, `account_access`.`comment` = 'Test account - Major Game Master'
WHERE (`account`.`username` = 'test5' AND `account`.`sha_pass_hash` = 'dddeac4ffe5f286ec57b7a1ed63bf3a859debe1e') OR
(`account`.`username` = 'test6' AND `account`.`sha_pass_hash` = 'f1f94cdffd83c8c4182d66689077f92c807ab579');

-- UPDATE ACCOUNTS test7 test8
UPDATE `account`
INNER JOIN `account_access`
ON `account`.`id` = `account_access`.`id`
SET `account_access`.`gmlevel` = 1, `account_access`.`comment` = 'Test account - Minor Game Master'
WHERE (`account`.`username` = 'test7' AND `account`.`sha_pass_hash` = '6fcd35c35b127be1d9ca040b2b478eb366506ce2') OR
(`account`.`username` = 'test8' AND `account`.`sha_pass_hash` = '484332ccb02e284e4e0a04573c3fa417f4745fdf');

-- UPDATE ACCOUNTS test9 test10
UPDATE `account`
INNER JOIN `account_access`
ON `account`.`id` = `account_access`.`id`
SET `account_access`.`gmlevel` = 0, `account_access`.`comment` = 'Test account - Player'
WHERE (`account`.`username` = 'test9' AND `account`.`sha_pass_hash` = '4fce15ed251721f02754d5381ae9d0137b6a6a30') OR
(`account`.`username` = 'test10' AND `account`.`sha_pass_hash` = 'b22d249228e84ab493b39a2bd765bee9b7c0b350');


/*!40000 ALTER TABLE `account_access` ENABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
