--
DELETE FROM `command` WHERE `name` = 'debug update';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('debug update', 3, 'Syntax: .debug update #index [#value]\n\nReads or writes the raw 32-bit update field at #index on the selected unit. With no #value, prints the current value; with #value, sets it. Writing an invalid value can crash the server.\nValid #index are the *_FIELD enums in src/server/game/Entities/Object/Updates/UpdateFields.h (UNIT_FIELD_* for creatures, PLAYER_FIELD_* for players).');
