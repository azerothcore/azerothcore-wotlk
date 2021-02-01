-- DB update 2017_08_20_01 -> 2017_08_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_20_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_20_01 2017_08_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1503198096265931900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1503198096265931900');

-- make Franclorn Forgewright visible only for dead players
UPDATE `creature_template` SET `npcflag`=32771, `AIName`='' WHERE `entry`=8888;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 8888  AND `source_type` = 0;
UPDATE `creature_template_addon` SET `auras`=10848 WHERE `entry` IN (8888);
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
