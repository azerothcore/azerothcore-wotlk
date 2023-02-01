-- DB update 2023_01_25_00 -> 2023_01_25_01
DELETE FROM `player_class_stats` WHERE `class` = 6 AND `level` < 55;
DELETE FROM `player_classlevelstats` WHERE `class` = 6 AND `level` < 55;
