-- DB update 2020_11_28_01 -> 2020_11_28_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_28_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_28_01 2020_11_28_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1604614793984918900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1604614793984918900');
-- Pyrobuffet (57557)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=7 AND `SourceEntry`=57557 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=26 AND `ConditionTarget`=0 AND `ConditionValue1`=1 AND `ConditionValue2`=0 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 7, 57557, 0, 0, 26, 0, 1, 0, 0, 0, 0, 0, '', 'Pyrobuffet - Target players which has phase mask 1');

-- Twilight Torment (57935)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=7 AND `SourceEntry`=57935 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=26 AND `ConditionTarget`=0 AND `ConditionValue1`=1 AND `ConditionValue2`=0 AND `ConditionValue3`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceGroup`=0 AND `SourceEntry`=57935 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=26 AND `ConditionTarget`=1 AND `ConditionValue1`=1 AND `ConditionValue2`=0 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 57935, 0, 0, 26, 1, 1, 0, 0, 0, 0, 0, '', 'Twilight Torment - Target players which has phase mask 1');

-- Twilight Shift aura removes Twilight Torment
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=57620 AND `spell_effect`=-57935 AND `type`=0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(57620, -57935, 0, 'Twilight Shift aura removes Twilight Torment');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
