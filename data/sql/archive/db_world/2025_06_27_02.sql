-- DB update 2025_06_27_01 -> 2025_06_27_02
UPDATE `command` SET `help`='Syntax: .account create $account $password $email\r\n\r\nCreate account and set password to it.\r\n$email is optional, can be left blank.' WHERE `name`='account create';
