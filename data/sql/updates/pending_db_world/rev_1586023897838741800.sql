INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1586023897838741800');

-- Delete queststarter for creature 20482
DELETE FROM `creature_queststarter` WHERE `id` = 20482 AND `quest` IN (10975, 10976, 10977, 10981);

-- Update queststarter for quest 10982 to 22919 (was previously set to 20482)
UPDATE `creature_queststarter` SET `id`='22919' WHERE  `id`=20482 AND `quest`=10982;

-- Delete questender for creature 20482
DELETE FROM `creature_questender` WHERE `id` = 20482 AND `quest` IN (10975, 10976, 10977, 10981, 10982);

/* Notes

Image of Commander Ameer - Netherstorm Queststarter
- 10384 ok
- 10385 ok
- 10405 ok
- 10406 ok
- 10408 ok

Image of Commander Ameer - Blade's Edge Mountains Queststarter
- 10975 nok
- 10976 nok
- 10977 nok
- 10981 nok
- 10982 nok

-- Image of Commander Ameer - Netherstorm
.go 4019.941650 2317.070068 114.749313 530

-- Image of Commander Ameer - Blade's Edge Mountains
.go 3864.034424 5976.675293 290.619293 530

*/

