-- DB update 2026_08_15_12 -> 2026_08_15_13
--
UPDATE `command` SET `help` = 'Syntax: .account 2fa setup <token>\nSets up two-factor authentication for this account.\nRun .account 2fa setup 1 to get your 2FA key, then confirm with .account 2fa setup <token>.' WHERE `name` = 'account 2fa setup';
