-- DB update 2026_05_10_00 -> 2026_05_10_01
--
-- Show character level in `.character deleted list` output
--
DELETE FROM `acore_string` WHERE `entry` IN (1016, 1017, 1018, 1026);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(1016, '| GUID       | Name                 | Level | Account                      | Delete Date         |', NULL, NULL, '| GUID       | Name                 | Level | Account                      | gelöscht am         |', '| 唯一标识符       | 名称                 | 等级 | 账号                      | 删除日期         |', NULL, NULL, NULL, NULL),
(1017, '| {} | {} | {} | {} ({}) | {} |', NULL, NULL, '| {} | {} | {} | {} ({}) | {} |', '| {} | {} | {} | {} ({}) | {} |', NULL, NULL, NULL, NULL),
(1018, '==================================================================================================', NULL, NULL, '==================================================================================================', '错误：510', NULL, NULL, NULL, NULL),
(1026, 'GUID: {} Name: {} Level: {} Account: {} ({}) Date: {}', NULL, NULL, 'GUID: {} Name: {} Level: {} Account: {} ({}) Datum: {}', '唯一标识符: {} 名称: {} 等级: {} 账号: {} ({}) 时间: {}', NULL, NULL, NULL, NULL);
