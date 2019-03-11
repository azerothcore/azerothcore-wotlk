-- DB update 2018_02_09_00 -> 2018_02_23_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_02_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_02_09_00 2018_02_23_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1518285097709086000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1518285097709086000');

-- Evilpriest #0001
-- Removed MECHANIC_INTERRUPT flag from Lady Malande/High Nethermancer Zerevor (Black Temple) 

UPDATE `creature_template` SET `mechanic_immune_mask` = '617299839' WHERE (`entry`='22951');
UPDATE `creature_template` SET `mechanic_immune_mask` = '617299839' WHERE (`entry`='22950');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
