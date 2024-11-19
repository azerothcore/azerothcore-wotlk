-- DB update 2021_12_15_00 -> 2021_12_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_15_00 2021_12_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638832657384544715'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638832657384544715');

UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_tharnarian' WHERE `entry`=3701;
UPDATE `creature_template` SET `ScriptName`='npc_rabid_thistle_bear' WHERE `entry`=2164;
UPDATE `gameobject_template` SET `ScriptName`='go_bear_trap' WHERE `entry`=109515;
UPDATE `gameobject_template` SET `AIName`='' WHERE `entry`=111148;
DELETE FROM `smart_scripts` WHERE `entryorguid`=111148 AND `source_type`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2164 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=216400 AND `source_type`=9;
DELETE FROM `smart_scripts` WHERE `entryorguid`=3701 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=370100 AND `source_type`=9;

-- Condition for source Spell implicit target condition type Object entry guid
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=9439 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 9439, 0, 0, 31, 0, 3, 2164, 0, 0, 0, 0, '', 'Bear Captured in Trap (effect 0) will hit the potential target of the spell if target is Rabid Thistle Bear.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_16_00' WHERE sql_rev = '1638832657384544715';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
