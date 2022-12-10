-- DB update 2022_04_01_07 -> 2022_04_01_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_01_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_01_07 2022_04_01_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648290893075572700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648290893075572700');

UPDATE `creature_template` SET `npcflag`=16777216 WHERE `entry`=34072;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=34072;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(34072,51347,3,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_01_08' WHERE sql_rev = '1648290893075572700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
