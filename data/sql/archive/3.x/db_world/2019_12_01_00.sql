-- DB update 2019_11_30_00 -> 2019_12_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_11_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_11_30_00 2019_12_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1572823869348028411'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1572823869348028411');

-- Freed Crusader SAI: Use last invoker (the player) as target for the talk action
UPDATE `smart_scripts` SET `target_type` = 7 WHERE `entryorguid` = 3027400 AND `source_type` = 9 AND `id` = 1;

-- Webbed Crusader SAI: Use self as target for the invoker cast (invoker is the player)
UPDATE `smart_scripts` SET `target_type` = 1 WHERE `entryorguid` = 30273 AND `source_type` = 0 AND `id` = 0;

-- Webbed Crusader: Use the same faction as it's counterpart 30273 (otherwise the roaming crusaders will attack them and the player can easily identify the save ones)
UPDATE `creature_template` SET `faction` = 14 WHERE `entry` = 30268;

-- Spell "Summon Freed Crusader": Use Source->Target instead of Target->Target (otherwise the last invoker would be the Webbed Crusader itself instead of the player)
UPDATE `spell_scripts` SET `datalong2` = 0 WHERE `id` = 56515;

-- Freed Crusader: Additional creature texts
DELETE FROM `creature_text` WHERE `CreatureID` = 30274;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(30274,0,0,'Might grace you, $c. Let the Scourge feel the fury of a million lost souls!',12,0,100,0,0,0,30976,0,'Freed Crusader'),
(30274,0,1,'Glory and strength to you, $c. I bless you with all the strength left in me. May this nightmare soon end!',12,0,100,0,0,0,30977,0,'Freed Crusader'),
(30274,0,2,'Wisdom of the ages upon you, noble $c.',12,0,100,0,0,0,30978,0,'Freed Crusader'),
(30274,0,3,'Thank you and farewell, friend. I must return to the Argent Vanguard.',12,0,100,0,0,0,30980,0,'Freed Crusader');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
