-- DB update 2017_03_04_04 -> 2017_03_04_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_03_04_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_03_04_04 2017_03_04_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1486298304560758300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1486298304560758300');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (48778, 73313);
INSERT INTO `spell_linked_spell` (`spell_trigger` ,`spell_effect`, `type`, `comment`)  VALUES
(48778, 50772, 0, 'Acherus Deathcharger - Summon Unholy Mount Visual'),
(73313, 50772, 0, 'Crimson Deathcharger - Summon Unholy Mount Visual');--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
