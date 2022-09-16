-- DB update 2021_10_10_28 -> 2021_10_10_29
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_28';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_28 2021_10_10_29 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633627685425341900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633627685425341900');

UPDATE `quest_template` SET `RequiredNpcOrGo1` = -181653 WHERE (`ID` = 9444);

DELETE FROM `creature_text` WHERE `CreatureId` = 17233 AND `groupid` BETWEEN 4 AND 7;

INSERT INTO `creature_text` (`CreatureId`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(17233, 4, 0, 'Why do you do this? Did I somehow wrong you in life?', 12, 0, 100, 0, 0, 0, 'Ghost of Uther Lightbringer '),
(17233, 5, 0, 'Ah, I see it now in your mind. This is the work of one of my former students... Mehlar Dawnblade. It is sad to know that his heart has turned so dark.', 12, 0, 100, 0, 0, 0, 'Ghost of Uther Lightbringer'),
(17233, 6, 0, 'Return to him. Return to Mehlor and tell him that I forgive him and that I understand why he believes what he does.', 12, 0, 100, 0, 0, 0, 'Ghost of Uther Lightbringer'),
(17233, 7, 0, 'I can only hope that he will see the Light and instead turn his energies to restoring once-beautiful Quel''Thalas.', 12, 0, 100, 0, 0, 0, 'Ghost of Uther Lightbringer');

DELETE FROM `conditions` WHERE `SourceEntry` IN (28806) AND `SourceTypeOrReferenceId`=13 AND `ConditionValue1`=5;
UPDATE `conditions` SET `ConditionValue1`=3, `ConditionValue2`=17066  WHERE `SourceEntry` IN (29172) AND `SourceTypeOrReferenceId`=13;
UPDATE `conditions` SET `ConditionValue1`=3, `ConditionValue2`=17066  WHERE `SourceEntry` IN (29531) AND `SourceTypeOrReferenceId`=13;
UPDATE `conditions` SET `ConditionValue1`=3, `ConditionValue2`=17066  WHERE `SourceEntry` IN (29831) AND `SourceTypeOrReferenceId`=13;

DELETE FROM `conditions` WHERE `SourceEntry` IN (30098) AND `SourceTypeOrReferenceId`=17;
DELETE FROM `conditions` WHERE `SourceEntry` IN (30098) AND `SourceTypeOrReferenceId`=13;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `COMMENT`) VALUES
(13, 2, 30098, 0, 0, 31, 0, 3, 17253, 0, 0, 0, 0, "", ""),
(13, 2, 30098, 0, 0, 29, 0, 17233, 20, 0, 1, 0, 0, "", ""),
(13, 1, 30098, 0, 0, 31, 0, 5, 182483, 0, 0, 0, 0, "", ""),
(13, 4, 30098, 0, 0, 31, 0, 5, 181653, 0, 0, 0, 0, "", "");

DELETE FROM `conditions` WHERE `SourceEntry` IN (17233) AND `SourceTypeOrReferenceId`=22;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `COMMENT`) VALUES
(22, 1, 17233, 0, 0, 6, 0, 67, 0, 0, 1, 0, 0, "", "");

UPDATE `event_scripts` SET `datalong2`=55000 WHERE `id`=10561;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17253 AND `source_type`=0 AND `id`=6;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17253, 0, 6, 0, 52, 0, 100, 0, 7, 17233, 0, 0, 32, 0, 0, 0, 0, 0, 0, 20, 182483, 20, 0, 0, 0, 0, 0, "Defile Uther's Tomb Trigger - On Text 7 Over - reset gob");
UPDATE `smart_scripts` SET `target_o`=0.2935 WHERE `entryorguid`=17238 AND `source_type`=0 AND `id`=16;
UPDATE `smart_scripts` SET `target_type`=21, `target_param1`=50 WHERE `entryorguid`=1723801 AND `source_type`=9 AND `id`=1;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_29' WHERE sql_rev = '1633627685425341900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
