-- DB update 2020_11_16_01 -> 2020_11_17_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_16_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_16_01 2020_11_17_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1605306538260467100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605306538260467100');

/* Match MinCount with MaxCount for [Emblem of Triumph] in boss loot. */

/* 1-2 => 1-1 */
UPDATE `creature_loot_template` SET `MaxCount`=1 WHERE `MaxCount`=2 AND `MinCount`=1 AND `Item`=47241 AND `Entry` IN
(
15989, /* Sapphiron 10-man */
33694, /* Stormcaller Brundir 25-man */
33724, /* Razorscale 25-man */
33885, /* XT-002 Deconstructor 25-man */
34175 /* Auriaya 25-man */
);

/* 1-2 => 2-2 */
UPDATE `creature_loot_template` SET `MinCount`=2 WHERE `MinCount`=1 AND `MaxCount`=2 AND `Item`=47241 AND `Entry` IN
(
15990 /* Kel'thuzad 10-man */
);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
