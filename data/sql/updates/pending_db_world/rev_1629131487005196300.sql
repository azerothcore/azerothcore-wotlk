INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629131487005196300');

-- Replace LANG_PINFO_MUTED
UPDATE `acore_string` SET `content_default` = '│ Muted: (Reason: %s, Time: %s, Left %s, By: %s)',
`locale_koKR` = NULL,
`locale_frFR` = NULL,
`locale_deDE` = NULL,
`locale_zhCN` = NUll,
`locale_zhTW` = NULL,
`locale_esES` = NULL,
`locale_esMX` = NULL,
`locale_ruRU` = NULL
WHERE `entry` = 550;

-- LANG_COMMAND_DISABLE_CHAT_DELAYED
UPDATE `acore_string` SET `content_default` = '%s has disabled %s\'s chat for %s, effective at the player\'s next login. Reason: %s.',
`locale_koKR` = NULL,
`locale_frFR` = NULL,
`locale_deDE` = NULL,
`locale_zhCN` = NUll,
`locale_zhTW` = NULL,
`locale_esES` = NULL,
`locale_esMX` = NULL,
`locale_ruRU` = '%s отключил чат %s на %s, действующий при следующем входе игрока в игру. Причина: %s.' WHERE `entry` = 283;

-- LANG_YOUR_CHAT_DISABLED
UPDATE `acore_string` SET `content_default` = 'Your chat has been disabled for %s. By: %s. Reason: %s.',
`locale_koKR` = NULL,
`locale_frFR` = NULL,
`locale_deDE` = NULL,
`locale_zhCN` = NUll,
`locale_zhTW` = NULL,
`locale_esES` = NULL,
`locale_esMX` = NULL,
`locale_ruRU` = 'У вас отключен чат на %s. Отключил %s. Причина %s.' WHERE `entry` = 300;

-- LANG_YOU_DISABLE_CHAT
UPDATE `acore_string` SET `content_default` = 'You has disabled %s\'s chat for %u minutes. Reason: %s.',
`locale_koKR` = NULL,
`locale_frFR` = NULL,
`locale_deDE` = NULL,
`locale_zhCN` = NUll,
`locale_zhTW` = NULL,
`locale_esES` = NULL,
`locale_esMX` = NULL,
`locale_ruRU` = 'Вы отключили чат %s на %s. Причина: %s.' WHERE `entry` = 301;

-- LANG_COMMAND_MUTEMESSAGE_WORLD
UPDATE `acore_string` SET `content_default` = 'Server: %s has muted %s for %u minutes, reason: %s',
`locale_koKR` = NULL,
`locale_frFR` = NULL,
`locale_deDE` = NULL,
`locale_zhCN` = NUll,
`locale_zhTW` = NULL,
`locale_esES` = NULL,
`locale_esMX` = NULL,
`locale_ruRU` = 'Server: %s замутил %s на %s. Причина: %s' WHERE `entry` = 11003;
