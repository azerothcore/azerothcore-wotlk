-- DB update 2021_10_31_05 -> 2021_11_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_31_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_31_05 2021_11_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633884280859489900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633884280859489900');

-- gandling
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_darkmaster_gandling' WHERE `entry` = 1853;

-- risen guardians
UPDATE `creature_template` SET `AIName` = '' , `ScriptName` = 'npc_risen_guardian' WHERE `entry` = 11598;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 11598 AND `source_type` = 0;

-- gates
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (177371, 177372, 177373, 177375, 177376, 177377) AND `source_type` = 1;
UPDATE `gameobject_template` SET `AIName` = '' WHERE `entry` IN (177371, 177372, 177373, 177375, 177376, 177377);

-- portal spells
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_scholomance_shadow_portal', 'spell_scholomance_shadow_portal_rooms');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_01_00' WHERE sql_rev = '1633884280859489900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
