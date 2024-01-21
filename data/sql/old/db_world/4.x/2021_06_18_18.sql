-- DB update 2021_06_18_17 -> 2021_06_18_18
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_18_17';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_18_17 2021_06_18_18 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623952547067832000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623952547067832000');

-- note: this is not ideal, it should be instead:
-- - an INSERT IGNORE containing the default DBC values
-- - and an UPDATE containing only the change
-- but the original author is gone and I do not know what fields are changing, so I'll leave it as it is
DELETE FROM `spell_dbc` WHERE (`ID` = 4511);
INSERT INTO `spell_dbc` VALUES (4511, 0, 0, 0, 301989888, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 10000, 0, 0, 4, 0, 0, 101, 0, 0, 12, 12, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 6, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72, 0, 211, 122, 0, 'Phase Shift','','','','','','','','', 0, 0, 0, 0, 0, 0, 0, 16712190,'','','','','','','','','', 0, 0, 0, 0, 0, 0, 0, 16712190, 'Shifts the imp out of phase with the world, making it unattackable unless it attacks.', null, null, null, null, null, null, null, null, 0, 0, 0, 0, 0, 0, 0, 16712190, 'Unattackable.','','','','','','','','', 0, 0, 0, 0, 0, 0, 0, 16712190, 0, 133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);

UPDATE `creature_template` SET `faction` = 73, `type_flags` = 4096, `ScriptName` = '' WHERE (`entry` = 416);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_18' WHERE sql_rev = '1623952547067832000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
