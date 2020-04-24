-- DB update 2020_04_23_00 -> 2020_04_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_04_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_04_23_00 2020_04_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1586845118268975400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1586845118268975400');

ALTER TABLE `holiday_dates` ADD COLUMN `holiday_duration` INT(10) UNSIGNED DEFAULT 0 NOT NULL AFTER `date_value`;
UPDATE `holiday_dates` SET `holiday_duration`= 360 WHERE `id`= 327;

-- Darkmoon Faire
UPDATE `game_event` SET `start_time`= '2020-01-05 00:01:00', `end_time`= '2030-01-01 06:00:00' WHERE `eventEntry`= 3;

-- Lunar Festival. Holiday ID: 327.
UPDATE `game_event` SET `start_time`='2020-01-24 00:01:00', `occurence`='525600', `length`='30240' WHERE `eventEntry`=7;
SET @HOLIDAYID := 327;
SET @DATEID := 14;
DELETE FROM `holiday_dates` WHERE `id`=@HOLIDAYID AND `date_id` IN (@DATEID, @DATEID+1, @DATEID+2, @DATEID+3, @DATEID+4, @DATEID+5);
INSERT INTO `holiday_dates` (`id`, `date_id`, `date_value`) VALUES -- DONE.
(@HOLIDAYID, @DATEID, 	335921152), -- 2020-01-24.
(@HOLIDAYID, @DATEID+1, 352681984), -- 2021-01-23.
(@HOLIDAYID, @DATEID+2, 369459200), -- 2022-01-23.
(@HOLIDAYID, @DATEID+3, 386236416), -- 2023-01-23.
(@HOLIDAYID, @DATEID+4, 403013632), -- 2024-01-23.
(@HOLIDAYID, @DATEID+5, 419774464); -- 2025-01-22.
UPDATE `holiday_dates` SET `holiday_duration`= 360 WHERE `id`= 327;

-- Love is in the air. Holiday ID: 423.
UPDATE `game_event` SET `start_time`='2020-02-08 00:01:00', `occurence`='525600', `length`='20160' WHERE `eventEntry`=8;
SET @HOLIDAYID := 423;
SET @DATEID := 10;
DELETE FROM `holiday_dates` WHERE `id`=@HOLIDAYID AND `date_id` IN (@DATEID, @DATEID+1, @DATEID+2, @DATEID+3, @DATEID+4, @DATEID+5);
INSERT INTO `holiday_dates` (`id`, `date_id`, `date_value`) VALUES -- DONE.
(@HOLIDAYID, @DATEID, 	336707584), -- 2020-02-08.
(@HOLIDAYID, @DATEID+1, 353468416), -- 2021-02-07.
(@HOLIDAYID, @DATEID+2, 370245632), -- 2022-02-07.
(@HOLIDAYID, @DATEID+3, 387022848), -- 2023-02-07.
(@HOLIDAYID, @DATEID+4, 403800064), -- 2024-02-07.
(@HOLIDAYID, @DATEID+5, 420560896); -- 2025-02-06.

-- Pilgrim's Bounty. Holiday ID: 404.
UPDATE `game_event` SET `start_time`='2020-11-23 01:00:00', `occurence`='525600', `length`='10080' WHERE `eventEntry`=26;
SET @HOLIDAYID := 404;
SET @DATEID := 11;
DELETE FROM `holiday_dates` WHERE `id`=@HOLIDAYID AND `date_id` IN (@DATEID, @DATEID+1, @DATEID+2, @DATEID+3, @DATEID+4, @DATEID+5);
INSERT INTO `holiday_dates` (`id`, `date_id`, `date_value`) VALUES -- DONE.
(@HOLIDAYID, @DATEID, 	346390592), -- 2020-11-23.
(@HOLIDAYID, @DATEID+1, 363167808), -- 2021-11-23.
(@HOLIDAYID, @DATEID+2, 379945024), -- 2022-11-23.
(@HOLIDAYID, @DATEID+3, 396722240), -- 2023-11-23.
(@HOLIDAYID, @DATEID+4, 413483072), -- 2024-11-22.
(@HOLIDAYID, @DATEID+5, 430260288); -- 2025-11-22.

-- Children's Week. Holiday ID: 201.
UPDATE `game_event` SET `start_time`='2020-05-01 00:01:00', `occurence`='525600', `length`='10080' WHERE `eventEntry`=10;
SET @HOLIDAYID := 201;
SET @DATEID := 16;
DELETE FROM `holiday_dates` WHERE `id`=@HOLIDAYID AND `date_id` IN (@DATEID, @DATEID+1, @DATEID+2, @DATEID+3, @DATEID+4, @DATEID+5);
INSERT INTO `holiday_dates` (`id`, `date_id`, `date_value`) VALUES -- DONE.
(@HOLIDAYID, @DATEID, 	339738624), -- 2020-05-01.
(@HOLIDAYID, @DATEID+1, 356515840), -- 2021-05-01.
(@HOLIDAYID, @DATEID+2, 373293056), -- 2022-05-01.
(@HOLIDAYID, @DATEID+3, 390070272), -- 2023-05-01.
(@HOLIDAYID, @DATEID+4, 406274048), -- 2024-04-30.
(@HOLIDAYID, @DATEID+5, 423051264); -- 2025-04-30.

-- Noblegarden. Holiday ID: 181.
UPDATE `game_event` SET `start_time`='2020-04-13 00:01:00', `occurence`='525600', `length`='10080' WHERE  `eventEntry`=9;
SET @HOLIDAYID := 181;
SET @DATEID := 13;
DELETE FROM `holiday_dates` WHERE `id`=@HOLIDAYID AND `date_id` IN (@DATEID, @DATEID+1, @DATEID+2, @DATEID+3, @DATEID+4, @DATEID+5);
INSERT INTO `holiday_dates` (`id`, `date_id`, `date_value`) VALUES -- DONE.
(@HOLIDAYID, @DATEID, 	338886656), -- 2020-04-13.
(@HOLIDAYID, @DATEID+1, 355663872), -- 2021-04-13.
(@HOLIDAYID, @DATEID+2, 372441088), -- 2022-04-13.
(@HOLIDAYID, @DATEID+3, 389218304), -- 2023-04-13.
(@HOLIDAYID, @DATEID+4, 405979136), -- 2024-04-12.
(@HOLIDAYID, @DATEID+5, 422756352); -- 2025-04-12.

-- Harvest Festival. Holiday ID: 321.
UPDATE `game_event` SET `start_time`='2020-09-29 00:01:00', `occurence`='525600', `length`='10080'  WHERE  `eventEntry`=11;
SET @HOLIDAYID := 321;
SET @DATEID := 14;
DELETE FROM `holiday_dates` WHERE `id`=@HOLIDAYID AND `date_id` IN (@DATEID, @DATEID+1, @DATEID+2, @DATEID+3, @DATEID+4, @DATEID+5);
INSERT INTO `holiday_dates` (`id`, `date_id`, `date_value`) VALUES -- DONE.
(@HOLIDAYID, @DATEID, 	344391680), -- 2020-09-29.
(@HOLIDAYID, @DATEID+1, 361168896), -- 2021-09-29.
(@HOLIDAYID, @DATEID+2, 377946112), -- 2022-09-29.
(@HOLIDAYID, @DATEID+3, 394723328), -- 2023-09-29.
(@HOLIDAYID, @DATEID+4, 411484160), -- 2024-09-28.
(@HOLIDAYID, @DATEID+5, 428261376); -- 2025-09-28.

-- Lunar Festival
UPDATE `game_event` SET `length` = 20160 WHERE `eventEntry` = 7;
UPDATE `holiday_dates` SET `holiday_duration`=336 WHERE `id`=327;

-- End Dates

UPDATE `game_event` SET `end_time` = '2030-12-31 06:00:00' WHERE `eventEntry` IN (3,  73,  81,  79,  53,  54,  77,  70,  80,  71,  65,  34,  35,  64,  63,  62,  43,  51,  36,  37,  69,  68,  67,  45,  44,  42,  41,  40,  39,  38,  52,  26,  27,  25,  24,  11,  12,  23,  21,  20,  19,  18,  14,  10,  9,  1,  2,  4,  30,  5,  15,  6,  29,  7,  8,  28,  16,  50,  72,  75,  74,  33,  76,  32,  78);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
