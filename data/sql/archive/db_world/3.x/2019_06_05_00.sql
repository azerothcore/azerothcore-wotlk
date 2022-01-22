-- DB update 2019_06_03_01 -> 2019_06_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_03_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_03_01 2019_06_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1559215442284268490'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559215442284268490');

-- allow Fjorn to be targeted by "Hurl Boulder"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceGroup` = 0 AND `SourceEntry` = 55818 AND `ConditionTypeOrReference` = 31 AND `ConditionValue2` = 29503;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(17,0,55818,0,1,31,1,3,29503,0,0,0,0,'','Requires Fjorn');

-- remove references for spell "Hurl Boulder" as they are not needed anymore
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 55818;
DELETE FROM `spell_scripts` WHERE `id` = 55818;
DELETE FROM `spell_script_names` WHERE `spell_id` = 55818;

-- Stormforged Iron Giant
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 29375;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(29375,0,0,0,0,0,100,0,6000,12000,20000,26000,0,11,57741,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Stormforged Iron Giant - In Combat - Cast ''Shockwave'''),
(29375,0,1,2,8,0,100,0,55818,0,0,0,0,11,55528,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormforged Iron Giant - On Spellhit ''Hurl Boulder'' - Cast ''Summon Earthen'''),
(29375,0,2,3,61,0,100,0,0,0,0,0,0,11,55528,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormforged Iron Giant - Linked - Cast ''Summon Earthen'''),
(29375,0,3,4,61,0,100,0,0,0,0,0,0,11,55528,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormforged Iron Giant - Linked - Cast ''Summon Earthen'''),
(29375,0,4,5,61,0,100,0,0,0,0,0,0,11,55528,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormforged Iron Giant - Linked - Cast ''Summon Earthen'''),
(29375,0,5,0,61,0,100,0,0,0,0,0,0,11,55528,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormforged Iron Giant - Linked - Cast ''Summon Earthen'''),
(29375,0,6,0,0,0,100,0,1000,1000,5000,5000,0,123,5000,0,0,0,0,0,11,29927,10,0,0,0,0,0,0,'Stormforged Iron Giant - In Combat - Add Threat (Earthen Ironbane)');

-- Fjorn
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 29503;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(29503,0,0,0,0,0,100,0,7000,11000,9000,23000,0,11,57801,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Fjorn - In Combat - Cast ''Flame Breath'''),
(29503,0,1,0,0,0,100,0,12000,15000,30000,35000,0,11,55512,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Fjorn - In Combat - Cast ''Call of Earth'''),
(29503,0,2,3,8,0,100,0,55818,0,0,0,0,11,55528,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fjorn - On Spellhit ''Hurl Boulder'' - Cast ''Summon Earthen'''),
(29503,0,3,4,61,0,100,0,0,0,0,0,0,11,55528,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fjorn - Linked - Cast ''Summon Earthen'''),
(29503,0,4,5,61,0,100,0,0,0,0,0,0,11,55528,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fjorn - Linked - Cast ''Summon Earthen'''),
(29503,0,5,6,61,0,100,0,0,0,0,0,0,11,55528,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fjorn - Linked - Cast ''Summon Earthen'''),
(29503,0,6,0,61,0,100,0,0,0,0,0,0,11,55528,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fjorn - Linked - Cast ''Summon Earthen'''),
(29503,0,7,0,0,0,100,0,1000,1000,5000,5000,0,123,5000,0,0,0,0,0,11,29927,10,0,0,0,0,0,0,'Fjorn - In Combat - Add Threat (Earthen Ironbane)');

-- Earthen Ironbane
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 29927;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(29927,0,0,0,54,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,19,29375,30,0,0,0,0,0,0,'Earthen Ironbane - Is Summoned - Attack Start (Stormforged Iron Giant)'),
(29927,0,1,0,54,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,19,29503,30,0,0,0,0,0,0,'Earthen Ironbane - Is Summoned - Attack Start (Fjorn)'),
(29927,0,2,0,1,0,100,0,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Earthen Ironbane - Out of Combat - Despawn After 10 Seconds');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
