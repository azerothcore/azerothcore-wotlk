-- DB update 2019_05_26_01 -> 2019_05_26_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_26_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_26_01 2019_05_26_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1558481800224314500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558481800224314500');

-- Scarshield Spellbinder
UPDATE `smart_scripts` SET `event_flags` = 2, `event_type` = 63 WHERE `entryorguid` = 9098 AND `source_type` = 0 AND `id` = 0;

-- Tunneler
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 16968 AND `source_type` = 0 AND `id` = 7;

-- Vardmadra
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 30945 AND `source_type` = 0 AND `id` = 3;

-- Arakkoa Egg
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 20214 AND `source_type` = 0;

-- Forlorn Spirit
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 2044 AND `source_type` = 0 AND `id` = 0;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
