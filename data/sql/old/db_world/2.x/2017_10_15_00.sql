DROP FUNCTION IF EXISTS packDate;
CREATE FUNCTION packDate (yy TINYINT UNSIGNED, mm TINYINT UNSIGNED, dd TINYINT UNSIGNED)
RETURNS INT UNSIGNED DETERMINISTIC
RETURN (yy << 24) | ((mm - 1) << 20) | ((dd - 1) << 14);

-- DB update 2017_09_26_00 -> 2017_10_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_10_14_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_10_14_02 2017_10_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1504044222560696700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1504044222560696700');

DROP TABLE IF EXISTS holiday_dates;
CREATE TABLE holiday_dates (
  id INT UNSIGNED NOT NULL,
  date_id TINYINT UNSIGNED NOT NULL,
  date_value INT UNSIGNED NOT NULL,
  PRIMARY KEY (id, date_id)
);

INSERT INTO holiday_dates VALUES
(181, 6, 220692480 + (1 << 14)), -- rescheduled
(181, 7, 238338048 + (1 << 14)),
(181, 8, 254869504 + (1 << 14)),
(181, 9, 270958592 + (1 << 14)),
(181, 10, 288635520), -- 7.2 (PTR) dbc
(181, 11, 305166976),
(181, 12, 322271872),
(201, 9, 221723264),
(201, 10, 238484096),
(201, 11, 255244928),
(201, 12, 272661120),
(201, 13, 289421952),
(201, 14, 305625728),
(201, 15, 322386560),
(321, 7, 210106368),
(321, 8, 226704000),
(321, 9, 243300992),
(321, 10, 260389504),
(321, 11, 276970112),
(321, 12, 294075008),
(321, 13, 310672000),
(327, 7, 218429440 + (7 << 14)),
(327, 8, 235207296),
(327, 9, 252967552),
(327, 10, 269499008),
(327, 11, 285555328),
(327, 12, 303184512),
(327, 13, 319224448),
(404, 4, 228997760),
(404, 5, 245758592),
(404, 6, 262519424),
(404, 7, 279263872),
(404, 8, 296024704),
(404, 9, 312785536),
(404, 10, 329661056),
(423, 3, 219185152 + (7 << 14)),
(423, 4, 236092032),
(423, 5, 252738176),
(423, 6, 269728384),
(423, 7, 286374528),
(423, 8, 303184512),
(423, 9, 319881856),

(374, 0, packDate(16, 12, 02)),
(375, 0, packDate(16, 12, 30)),
(376, 0, packDate(17, 02, 03)),
(374, 1, packDate(17, 03, 03)),
(375, 1, packDate(17, 03, 31)),
(376, 1, packDate(17, 04, 28)),
(374, 2, packDate(17, 06, 02)),
(375, 2, packDate(17, 06, 30)),
(376, 2, packDate(17, 08, 04)),
(374, 3, packDate(17, 09, 01)),
(375, 3, packDate(17, 09, 29)),
(376, 3, packDate(17, 11, 03)),
(374, 4, packDate(17, 12, 01)),
(375, 4, packDate(17, 12, 29)),
(376, 4, packDate(18, 02, 02)),
(374, 5, packDate(18, 03, 02)),
(375, 5, packDate(18, 03, 30)),
(376, 5, packDate(18, 05, 04)),
(374, 6, packDate(18, 06, 01)),
(375, 6, packDate(18, 06, 29)),
(376, 6, packDate(18, 08, 03)),
(374, 7, packDate(18, 08, 31)),
(375, 7, packDate(18, 09, 28)),
(376, 7, packDate(18, 11, 02)),
(374, 8, packDate(18, 11, 30)),
(375, 8, packDate(19, 01, 04)),
(376, 8, packDate(19, 02, 01)),
(374, 9, packDate(19, 03, 01)),
(375, 9, packDate(19, 03, 29)),
(376, 9, packDate(19, 05, 03)),
(374, 10, packDate(19, 05, 31)),
(375, 10, packDate(19, 06, 28)),
(376, 10, packDate(19, 08, 02)),
(374, 11, packDate(19, 08, 30)),
(375, 11, packDate(19, 10, 04)),
(376, 11, packDate(19, 11, 01)),
(374, 12, packDate(19, 11, 29)),
(375, 12, packDate(20, 01, 03)),
(376, 12, packDate(20, 01, 31)),
(374, 13, packDate(20, 02, 28)),
(375, 13, packDate(20, 04, 03)),
(376, 13, packDate(20, 05, 01)),
(374, 14, packDate(20, 05, 29)),
(375, 14, packDate(20, 07, 03)),
(376, 14, packDate(20, 07, 31)),
(374, 15, packDate(20, 09, 04)),
(375, 15, packDate(20, 10, 02)),
(376, 15, packDate(20, 10, 30)),
(374, 16, packDate(20, 12, 04)),
(375, 16, packDate(21, 01, 01)),
(376, 16, packDate(21, 01, 29)),
(374, 17, packDate(21, 02, 26)),
(375, 17, packDate(21, 04, 02)),
(376, 17, packDate(21, 04, 30)),
(374, 18, packDate(21, 06, 04)),
(375, 18, packDate(21, 07, 02)),
(376, 18, packDate(21, 07, 30)),
(374, 19, packDate(21, 09, 03)),
(375, 19, packDate(21, 10, 01)),
(376, 19, packDate(21, 10, 29)),
(374, 20, packDate(21, 12, 03)),
(375, 20, packDate(21, 12, 31)),
(376, 20, packDate(22, 02, 04)),
(374, 21, packDate(22, 03, 04)),
(375, 21, packDate(22, 04, 01)),
(376, 21, packDate(22, 04, 29)),
(374, 22, packDate(22, 06, 03)),
(375, 22, packDate(22, 07, 01)),
(376, 22, packDate(22, 07, 29)),
(374, 23, packDate(22, 09, 02)),
(375, 23, packDate(22, 09, 30)),
(376, 23, packDate(22, 11, 04)),
(374, 24, packDate(22, 12, 02)),
(375, 24, packDate(22, 12, 30)),
(376, 24, packDate(23, 02, 03)),
(374, 25, packDate(23, 03, 03)),
(375, 25, packDate(23, 03, 31)),
(376, 25, packDate(23, 04, 28));

UPDATE holiday_dates SET date_value = date_value & ~0x3FFF;

ALTER TABLE game_event ADD COLUMN holidayStage TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER holiday;

UPDATE game_event SET holiday = 424 WHERE eventEntry = 64;
UPDATE game_event SET holiday = 0 WHERE eventEntry = 63;
UPDATE game_event SET holiday = 374 WHERE eventEntry = 23;
UPDATE game_event SET holiday = 375 WHERE eventEntry = 110;
UPDATE game_event SET holiday = 376 WHERE eventEntry = 62;
UPDATE game_event SET holidayStage = 1 WHERE eventEntry IN (1, 2, 7, 8, 9, 10, 11, 12, 18, 19, 20, 21, 23, 24, 26, 50, 51, 53, 54, 62, 110);
UPDATE game_event SET holidayStage = 2 WHERE eventEntry IN (3, 4, 5);
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

DROP FUNCTION packDate;

