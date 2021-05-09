INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620531160911239800');

-- Mosh'Ogg Warmonger Entry 709 --
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `guid` IN (277, 278, 821, 842, 844, 845, 847, 849, 851, 856, 1265, 1289, 1290, 1299, 1306);

-- Mosh'Ogg Mauler Entry 678 --
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `guid` IN (524, 629, 755, 853, 854, 1050, 1077);

-- Mosh'Ogg Shaman Entry 679 --
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `guid` IN (273, 274, 275, 276, 525, 624, 625, 627, 855);

-- Mosh'Ogg Lord Entry 680 --
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `guid` IN (521, 522, 526, 761);

-- Mosh'Ogg Spellcrafter Entry 710 --
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `guid` IN (527, 528, 623, 626, 628, 762, 1093);
