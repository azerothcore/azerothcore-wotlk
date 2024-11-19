-- DB update 2019_05_07_01 -> 2019_05_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_07_01 2019_05_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1556618006402506300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1556618006402506300');

DELETE FROM `command` WHERE `name` IN
("deserter instance add",
"deserter instance remove",
"deserter bg add",
"deserter bg remove");

 INSERT INTO `command` (`name`, `security`, `help`) VALUES
("deserter instance add", 3, "Syntax: .deserter instance add $time \n\n Adds the instance deserter debuff to your target with $time duration."),
("deserter instance remove", 3, "Syntax: .deserter instance remove \n\n Removes the instance deserter debuff from your target."),
("deserter bg add", 3, "Syntax: .deserter bg add $time \n\n Adds the bg deserter debuff to your target with $time duration."),
("deserter bg remove", 3, "Syntax: .deserter bg remove \n\n Removes the bg deserter debuff from your target.");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
