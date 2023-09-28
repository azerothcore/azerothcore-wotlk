-- DB update 2023_09_24_00 -> 2023_09_24_01
--
UPDATE `acore_string` SET `content_default` = '%d - (entry: %d) |cffffffff|Hcreature:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r',
`locale_deDE` = '%d - (entry: %d) |cffffffff|Hcreature:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r',
`locale_zhCN` = '%d%s - (entry: %d) |cffffffff|H生物:%d|h[%s X:%f Y:%f Z:%f 地图号:%d]|h|r' WHERE `entry` = 515;
