-- DB update 22024_07_26_00 -> 2024_07_26_01
--
DELETE FROM `command` WHERE `name`='account set email';

INSERT INTO `command` (`name`, `security`, `help`) VALUES
('account set email', 4, 'Syntax: .account set email <account> <email> <email confirmation>\nAdds an email to the account.');

DELETE FROM `acore_string` WHERE `entry` IN (875);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(875, 'Your email can\'t be longer than 255 characters, email not changed!', NULL, NULL, NULL, '您的电子邮件无法超过255个字符，电子邮件没有改变！', NULL, NULL, NULL, NULL);