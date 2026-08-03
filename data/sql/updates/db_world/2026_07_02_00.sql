-- DB update 2026_06_30_06 -> 2026_07_02_00
-- From ¦ to |
UPDATE `acore_string` SET `content_default` = REPLACE(`content_default`, '¦', '|') WHERE `content_default` LIKE '%¦%';
UPDATE `acore_string` SET `locale_koKR` = REPLACE(`locale_koKR`, '¦', '|') WHERE `locale_koKR` LIKE '%¦%';
UPDATE `acore_string` SET `locale_frFR` = REPLACE(`locale_frFR`, '¦', '|') WHERE `locale_frFR` LIKE '%¦%';
UPDATE `acore_string` SET `locale_deDE` = REPLACE(`locale_deDE`, '¦', '|') WHERE `locale_deDE` LIKE '%¦%';
UPDATE `acore_string` SET `locale_zhCN` = REPLACE(`locale_zhCN`, '¦', '|') WHERE `locale_zhCN` LIKE '%¦%';
UPDATE `acore_string` SET `locale_zhTW` = REPLACE(`locale_zhTW`, '¦', '|') WHERE `locale_zhTW` LIKE '%¦%';
UPDATE `acore_string` SET `locale_esES` = REPLACE(`locale_esES`, '¦', '|') WHERE `locale_esES` LIKE '%¦%';
UPDATE `acore_string` SET `locale_esMX` = REPLACE(`locale_esMX`, '¦', '|') WHERE `locale_esMX` LIKE '%¦%';
UPDATE `acore_string` SET `locale_ruRU` = REPLACE(`locale_ruRU`, '¦', '|') WHERE `locale_ruRU` LIKE '%¦%';

-- From │ to |
UPDATE `acore_string` SET `content_default` = REPLACE(`content_default`, '│', '|') WHERE `content_default` LIKE '%│%';
UPDATE `acore_string` SET `locale_koKR` = REPLACE(`locale_koKR`, '│', '|') WHERE `locale_koKR` LIKE '%│%';
UPDATE `acore_string` SET `locale_frFR` = REPLACE(`locale_frFR`, '│', '|') WHERE `locale_frFR` LIKE '%│%';
UPDATE `acore_string` SET `locale_deDE` = REPLACE(`locale_deDE`, '│', '|') WHERE `locale_deDE` LIKE '%│%';
UPDATE `acore_string` SET `locale_zhCN` = REPLACE(`locale_zhCN`, '│', '|') WHERE `locale_zhCN` LIKE '%│%';
UPDATE `acore_string` SET `locale_zhTW` = REPLACE(`locale_zhTW`, '│', '|') WHERE `locale_zhTW` LIKE '%│%';
UPDATE `acore_string` SET `locale_esES` = REPLACE(`locale_esES`, '│', '|') WHERE `locale_esES` LIKE '%│%';
UPDATE `acore_string` SET `locale_esMX` = REPLACE(`locale_esMX`, '│', '|') WHERE `locale_esMX` LIKE '%│%';
UPDATE `acore_string` SET `locale_ruRU` = REPLACE(`locale_ruRU`, '│', '|') WHERE `locale_ruRU` LIKE '%│%';

-- From +- to |--
UPDATE `acore_string` SET `locale_deDE` = REPLACE(`locale_deDE`, '+- ', '|-- ') WHERE `locale_deDE` LIKE '+- %';

-- From ├─ to |--
UPDATE `acore_string` SET `content_default` = REPLACE(`content_default`, '├─ ', '|-- ') WHERE `content_default` LIKE '├─%';
UPDATE `acore_string` SET `locale_koKR` = REPLACE(`locale_koKR`, '├─ ', '|-- ') WHERE `locale_koKR` LIKE '├─%';
UPDATE `acore_string` SET `locale_frFR` = REPLACE(`locale_frFR`, '├─ ', '|-- ') WHERE `locale_frFR` LIKE '├─%';
UPDATE `acore_string` SET `locale_deDE` = REPLACE(`locale_deDE`, '├─ ', '|-- ') WHERE `locale_deDE` LIKE '├─%';
UPDATE `acore_string` SET `locale_zhCN` = REPLACE(`locale_zhCN`, '├─ ', '|-- ') WHERE `locale_zhCN` LIKE '├─%';
UPDATE `acore_string` SET `locale_zhTW` = REPLACE(`locale_zhTW`, '├─ ', '|-- ') WHERE `locale_zhTW` LIKE '├─%';
UPDATE `acore_string` SET `locale_esES` = REPLACE(`locale_esES`, '├─ ', '|-- ') WHERE `locale_esES` LIKE '├─%';
UPDATE `acore_string` SET `locale_esMX` = REPLACE(`locale_esMX`, '├─ ', '|-- ') WHERE `locale_esMX` LIKE '├─%';
UPDATE `acore_string` SET `locale_ruRU` = REPLACE(`locale_ruRU`, '├─ ', '|-- ') WHERE `locale_ruRU` LIKE '├─%';

-- Translated with Claude by Anthropic
-- Corrected the Arguments "| OS: {} - Latency: {} ms" which lead to format errors. (OLD: "公会: {} ({}) 排名: {} 附注: {} 关闭附注: {}")
UPDATE `acore_string` SET `locale_zhCN` = '| 系统: {} - 延迟: {} 毫秒' WHERE `entry` = 749;

-- Corrected the Arguments "| Map: {}, Zone: {}" which lead to format errors. (OLD: "¦ 地图: {}, Area: {}, Zone: {})" and "¦ Karte: {}, Bereich: {}, Zone: {}"
UPDATE `acore_string` SET `locale_zhCN` = '| 地图: {}, 区域: {}' WHERE `entry` = 848;
UPDATE `acore_string` SET `locale_deDE` = '| Karte: {}, Gebiet: {}' WHERE `entry` = 848;
