SET @ENTRY:=35410;
DELETE FROM `acore_string` WHERE `entry`=@ENTRY;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(@ENTRY, 'Hello World from Skeleton-Module!', '', '', '', '', '', '¡Hola Mundo desde Skeleton-Module!', '¡Hola Mundo desde Skeleton-Module!', '');
