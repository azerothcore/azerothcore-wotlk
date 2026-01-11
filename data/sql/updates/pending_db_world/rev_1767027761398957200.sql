-- From: "Account not exist: {}" to "No account with that name: {} was found."
UPDATE `acore_string` SET `content_default` = 'No account with that name: {} was found.' WHERE `entry` = 413;

DELETE FROM `acore_string` WHERE `entry` IN (604, 605, 606);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(604, 'No account with that IP: {} was found.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(605, 'No account with that e-mail: {} was found.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(606, '"Lookup command result Invalid in function: {} (file: {}, line: {})"', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- From: "No players found!" to "No characters were found!"
UPDATE `acore_string` SET `content_default` = 'No characters were found!' WHERE `entry` = 330;
