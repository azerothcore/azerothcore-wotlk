--
SET @ENTRY := 10074;
DELETE FROM `acore_string` WHERE `entry` = @ENTRY;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_esES`, `locale_esMX`) VALUES
(@ENTRY, 'Halaa is defenseless!', '¡Halaa está indefenso!', '¡Halaa está indefenso!');
