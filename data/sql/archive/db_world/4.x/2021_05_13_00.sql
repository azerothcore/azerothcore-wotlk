-- DB update 2021_05_12_00 -> 2021_05_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_12_00 2021_05_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620079973240388200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620079973240388200');

-- 
DELETE FROM `command` WHERE `name` LIKE 'account 2fa%';
DELETE FROM `command` WHERE `name`='account set 2fa';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('account 2fa', 0, 'Syntax: .account 2fa <setup/remove>'),
('account 2fa setup', 0, 'Syntax: .account 2fa setup
Sets up two-factor authentication for this account.'),
('account 2fa remove', 0, 'Syntax: .account 2fa remove <token>
Disables two-factor authentication for this account, if enabled.'),
('account set 2fa', 0, 'Syntax: .account set 2fa <account> <secret/off>
Provide a base32 encoded secret to setup two-factor authentication for the account.
Specify \'off\' to disable two-factor authentication for the account.');

DELETE FROM `acore_string` WHERE `entry` BETWEEN 87 AND 95;
DELETE FROM `acore_string` WHERE `entry` BETWEEN 188 AND 190;
INSERT INTO `acore_string` (`entry`,`content_default`) VALUES
(87, "UNKNOWN_ERROR"),
(88, "Two-factor authentication commands are not properly setup."),
(89, "Two-factor authentication is already enabled for this account."),
(90, "Invalid two-factor authentication token specified."),
(91, "In order to complete setup, you'll need to set up the device you'll be using as your second factor.
Your 2FA key: %s
Once you have set up your device, confirm by running .account 2fa setup <token> with the generated token."),
(92, "Two-factor authentication has been successfully set up."),
(93, "Two-factor authentication is not enabled for this account."),
(94, "To remove two-factor authentication, please specify a fresh two-factor token from your authentication device."),
(95, "Two-factor authentication has been successfully disabled."),
(188, "The provided two-factor authentication secret is too long."),
(189, "The provided two-factor authentication secret is not valid."),
(190, "Successfully enabled two-factor authentication for '%s' with the specified secret."); 

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
