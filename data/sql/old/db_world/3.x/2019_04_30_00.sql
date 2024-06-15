-- DB update 2019_04_28_00 -> 2019_04_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_28_00 2019_04_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1555843331078984800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555843331078984800');

-- Leviroth SmartAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=26452;
DELETE FROM `smart_scripts` WHERE `entryorguid`=26452 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26452, 0, 0, 1, 8, 0, 100, 0, 47170, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leviroth - On Spellhit (Impale Leviroth) - Remove Unit flags (Immune to PC)'),
(26452, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46767, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leviroth - On Spellhit (Impale Leviroth) - Cast Cosmetic - Underwater Blood'),
(26452, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Leviroth - On Spellhit (Impale Leviroth) - Start Attack');

-- Trident of Naz'jan item
UPDATE `item_template` SET `ScriptName`="" WHERE `entry`=35850;
UPDATE `creature_template` SET `InhabitType`=2 WHERE `entry`=26452;

DELETE FROM `conditions` WHERE `SourceEntry`=47170 AND `SourceTypeOrReferenceId`=17;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `comment`) VALUES
(17, 0, 47170, 0, 0, 29, 0, 26452, 8, 0, 0, 0, 0, "", 'Spell Impale Leviroth can only be used within 8 yards of NPC Leviroth');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
