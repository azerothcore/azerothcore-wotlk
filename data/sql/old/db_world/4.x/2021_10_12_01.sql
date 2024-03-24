-- DB update 2021_10_12_00 -> 2021_10_12_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_12_00 2021_10_12_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631986343234423300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631986343234423300');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x80000000 WHERE `entry` IN (
28684, /* Krik'thir the Gatewatcher */
36502, /* Devourer of Souls */
36658, /* Scourgelord Tyrannus */
32871, /* Algalon */
39863, /* Halion */
33186, /* Razorscale */
36626, /* Festergut */
32867, /* Steelbreaker - Assembly of Iron */
32927, /* Runemaster Molgeim - Assembly of Iron */
32857, /* Stormcaller Brundir - Assembly of Iron */
33350, /* Mimiron */
16060, /* Gothik the Harvester */
36678, /* Professor Putricide */
15990, /* Kel'Thuzad */
33993, /* Emalon the Storm Watcher */
17257, /* Magtheridon */
25315, /* Kil'jaeden */
15928, /* Thaddius */
32930, /* Kologarn */
32906, /* Freya */
36597, /* The Lich King */
36853, /* Sindragosa */
36855, /* Lady Deathwhisper */
37955 /* Blood-Queen Lana'thel */);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_12_01' WHERE sql_rev = '1631986343234423300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
