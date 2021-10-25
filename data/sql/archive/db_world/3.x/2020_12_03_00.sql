-- DB update 2020_12_02_01 -> 2020_12_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_02_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_02_01 2020_12_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606373029735379400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606373029735379400');

-- Arthas - Frostmourne Improvements

UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` = 36954);
UPDATE `creature_equip_template` SET `ItemID1` = 0 WHERE (`CreatureID` = 37226);
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 37226;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 37226) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(37226, 0, 0, 0, 8, 0, 100, 0, 72729, 0, 0, 0, 0, 71, 0, 0, 49706, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Halls of Reflection - Arthas Frostmourne Equip');

-- Escape from Arthas (Final Encounter) Text Improvements

UPDATE `creature_text` SET `Text`='Your allies have arrived Jaina, just as you promised. You will all become powerful agents of the Scourge.' WHERE  `CreatureID`=36954 AND `GroupID`=101 AND `ID`=0;
UPDATE `creature_text` SET `Text`='Your allies have arrived Jaina, just as you promised. You will all become powerful agents of the Scourge.' WHERE  `CreatureID`=36954 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `Text`='He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!' WHERE  `CreatureID`=36955 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `Text`='He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!' WHERE  `CreatureID`=36955 AND `GroupID`=103 AND `ID`=0;
UPDATE `creature_text` SET `Text`='He\'s... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do what I can do hold him in place while we flee.' WHERE  `CreatureID`=37554 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `Text`='He\'s... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do what I can do hold him in place while we flee.' WHERE  `CreatureID`=37554 AND `GroupID`=102 AND `ID`=0;
UPDATE `broadcast_text` SET `FemaleText`='He\'s... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do what I can do hold him in place while we flee.' WHERE  `ID`=37168;
UPDATE `broadcast_text` SET `FemaleText`='He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!' WHERE  `ID`=36821;
UPDATE `broadcast_text` SET `MaleText`='Your allies have arrived Jaina, just as you promised. You will all become powerful agents of the Scourge.' WHERE  `ID`=37172;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
