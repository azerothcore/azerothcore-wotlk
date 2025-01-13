-- DB update 2025_01_10_01 -> 2025_01_10_02
--
UPDATE `command` SET `help` = 'Syntax: .instance getbossstate [$Name]\nDisplays the state for every available encounter.\nIf no character name is provided, the current map will be used as target.' WHERE `name` = 'instance getbossstate';
