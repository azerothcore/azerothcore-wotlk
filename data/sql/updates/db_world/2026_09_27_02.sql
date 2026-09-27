-- DB update 2026_09_27_01 -> 2026_09_27_02
--
UPDATE `acore_string` SET
`content_default` = 'Removed itemID = {}, amount = {} from {} (GUID: {}, {}). Remaining: {}',
`locale_deDE` = 'Entferne itemID {}, Anzahl {} von {} (GUID: {}, {}). Verbleibend: {}',
`locale_zhCN` = '移除物品ID = {}, amount = {} from {} (GUID: {}, {}). 剩余: {}'
WHERE `entry` = 496;

DELETE FROM `acore_string` WHERE `entry` IN (35480, 35481, 35482);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_deDE`, `locale_zhCN`) VALUES
(35480, 'Removed itemID = {}, amount = {} from {} (GUID: {}, {}). No items remaining.', 'Entferne itemID {}, Anzahl {} von {} (GUID: {}, {}). Keine Gegenstände verbleibend.', '移除物品ID = {}, amount = {} from {} (GUID: {}, {}). 没有剩余物品.'),
(35481, 'online', 'online', '在线'),
(35482, 'offline', 'offline', '离线');
