-- DB update 2024_12_14_02 -> 2024_12_15_00
--
UPDATE `command` SET `help` = 'Syntax: .server set motd Optional($realmId) Optional($locale) $MOTD\r \r Set server Message of the day for the specified $realmId.\r If $realmId is not provided it will update for the current realm. \r Use $realmId -1 to set motd for all realms. If $locale is not provided enUS will be used.' WHERE (`name` = 'server set motd');

UPDATE `acore_string` SET `content_default` = 'Message of the day in realm {} and locale {} changed to:\r {}', `locale_deDE` = 'Nachricht des Tages für Realm {} und Sprache {} wurde geändert zu:\r {}', `locale_zhCN` = '每日消息更改为 in realm {} and locale {}:\r {}' WHERE (`entry` = 1101);
