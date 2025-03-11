-- DB update 2023_09_15_00 -> 2023_09_15_01
ALTER TABLE `player_class_stats`
    ADD COLUMN `BaseHP` int unsigned NOT NULL DEFAULT '1' AFTER `Level`,
    ADD COLUMN `BaseMana` int unsigned NOT NULL DEFAULT '1' AFTER `BaseHP`;

UPDATE player_class_stats AS noo
JOIN player_classlevelstats AS ole ON noo.Class = ole.class AND noo.Level = ole.level
SET noo.BaseHP = ole.basehp, noo.BaseMana = ole.basemana;

DROP TABLE IF EXISTS `player_classlevelstats`;
