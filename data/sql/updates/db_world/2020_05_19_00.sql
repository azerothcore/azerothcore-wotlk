-- DB update 2020_05_18_01 -> 2020_05_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_18_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_18_01 2020_05_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1587078801729376000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587078801729376000');

UPDATE `quest_template_addon` SET `PrevQuestID` = 13225 WHERE `ID` = 13300; -- Slaves to Saronite requires The Skybreaker
UPDATE `quest_template_addon` SET `PrevQuestID` = 13225 WHERE `ID` = 13336; -- Blood of the Chosen requires The Skybreaker
UPDATE `quest_template_addon` SET `PrevQuestID` = 13287 WHERE `ID` = 13288; -- That's Abominable (non-daily) requires Poke and Prod
UPDATE `quest_template_addon` SET `PrevQuestID` = 13288 WHERE `ID` = 13289; -- That's Abominable (daily) requires That's Abominable (non-daily)
UPDATE `quest_template_addon` SET `PrevQuestID` = 13332 WHERE `ID` = 13314; -- Get the Message requires Raise the Barricades
UPDATE `quest_template_addon` SET `PrevQuestID` = 13314 WHERE `ID` = 13333; -- Capture More Dispatches requires Get the Message
UPDATE `quest_template_addon` SET `PrevQuestID` = 13295 WHERE `ID` = 13297; -- Neutralizing the Plague requires Basic Chemistry
UPDATE `quest_template_addon` SET `PrevQuestID` = 13315 WHERE `ID` = 13320; -- Cannot Reproduce requires Sneak Preview
UPDATE `quest_template_addon` SET `PrevQuestID` = 13318 WHERE `ID` = 13323; -- Drag and Drop (daily) requires Drag and Drop (non-daily)
UPDATE `quest_template_addon` SET `PrevQuestID` = 13318 WHERE `ID` = 13342; -- Not a Bug (non-daily) requires Drag and Drop (non-daily)
UPDATE `quest_template_addon` SET `PrevQuestID` = 13342 WHERE `ID` = 13344; -- Not a Bug (daily) requires Not a Bug (non-daily)
UPDATE `quest_template_addon` SET `PrevQuestID` = 13345 WHERE `ID` = 13332; -- Raise the Barricades requires Need More Info
UPDATE `quest_template_addon` SET `PrevQuestID` = 13346 WHERE `ID` = 13350; -- No Rest For The Wicked (daily) requires No Rest For The Wicked (non-daily)
UPDATE `quest_template_addon` SET `PrevQuestID` = 13321 WHERE `ID` = 13322; -- Retest Now (daily) requires Retest Now (non-daily)
UPDATE `quest_template_addon` SET `PrevQuestID` = 13341 WHERE `ID` IN (13284, 13309); -- Assault by Air and Assault by Ground require Joining the Assault

DELETE FROM `quest_template_addon` WHERE `ID` IN (13294, 13231, 13296, 13286, 13290, 13298, 13315, 13319, 13318, 13334, 13339, 13338, 13345, 13341);
INSERT INTO `quest_template_addon` (`ID`, `PrevQuestID`) VALUES
(13294, 13287), -- Against the Giants requires Poke and Prod
(13231, 13225), -- The Broken Front requires The Skybreaker
(13296, 13225), -- Get to Ymirheim! requires The Skybreaker 
(13286, 13231), -- ...All the Help We Can Get. requires The Broken Front
(13290, 13231), -- Your Attention, Please requires The Broken Front
(13298, 13294), -- Coprous the Defiled requires Against the Giants
(13315, 13288), -- Sneak Preview requires That's Abominable! (non-daily)
(13319, 13315), -- Chain of Command requires Sneak Preview
(13318, 13315), -- Drag and Drop (non-daily) requires Sneak Preview
(13334, 13332), -- Bloodspattered Banners requires Raise the Barricades
(13339, 13335), -- Shatter the Shards requires Before the Gate of Horror
(13338, 13335), -- The Guardians of Corp'rethar requires Before the Gate of Horror
(13345, 13318), -- Need More Info requires Drag and Drop (non-daily)
(13341, 13225); -- Joining the Assault requires The Skybreaker

DELETE FROM `quest_template_addon` WHERE `id` = 13233;
INSERT INTO `quest_template_addon` (`id`, `PrevQuestID`, `SpecialFlags`) VALUES
(13233, 13231, 1); -- No Mercy! requires The Broken Front

UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` IN (13335,13337);
UPDATE `quest_template_addon` SET `NextQuestID` = 13335, `ExclusiveGroup` = -13335 WHERE `ID` IN (13334, 13337); -- Before the Gates of Horror requires Bloodspattered Banners and The Ironwall Rampart

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` = 13337;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 13337, 0, 0, 8, 0, 13332, 0, 0, 0, 0, 0, "", "Quest 'The Ironwall Rampart' requires quest 'Raise the Barricades' AND"),
(19, 0, 13337, 0, 0, 8, 0, 13346, 0, 0, 0, 0, 0, "", "Quest 'The Ironwall Rampart' requires quest 'No Rest For The Wicked (non-daily)' to be rewarded");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` IN (13418, 13419, 13386, 13258);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 13418, 0, 0, 25, 0, 54197, 0, 0, 0, 0, 0, "", "Quest 'Preparations for War (A)' requires spell 'Cold Weather Flying'"),
(19, 0, 13419, 0, 0, 25, 0, 54197, 0, 0, 0, 0, 0, "", "Quest 'Preparations for War (H)' requires spell 'Cold Weather Flying'"),
(19, 0, 13386, 0, 0, 8, 0, 13225, 0, 0, 0, 0, 0, "", "Quest 'Exploiting an Opening' requires quest 'The Skybreaker' to be rewarded AND"),
(19, 0, 13386, 0, 0, 8, 0, 12898, 0, 0, 0, 0, 0, "", "Quest 'Exploiting an Opening' requires quest 'The Shadow Vault (A)' to be rewarded"),
(19, 0, 13258, 0, 0, 8, 0, 13224, 0, 0, 0, 0, 0, "", "Quest 'Opportunity' requires quest 'Ogrim's Hammer' to be rewarded AND"),
(19, 0, 13258, 0, 0, 8, 0, 12899, 0, 0, 0, 0, 0, "", "Quest 'Opportunity' requires quest 'The Shadow Vault (H)' to be rewarded");

UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID`=13386;
DELETE FROM `quest_template_addon` WHERE `ID` IN (13278, 13404, 13382);
INSERT INTO `quest_template_addon` (`ID`, `PrevQuestID`, `SpecialFlags`) VALUES
(13278, 13277, 0), -- Coprous the Defiled requires Against the Giants
(13404, 13380, 1), -- Static Shock Troops: the Bombardment requires Leading the Charge
(13382, 13380, 1); -- Putting the Hertz: The Valley of Lost Hope requires Leading the Charge

DELETE FROM `quest_template_addon` WHERE `ID` IN (13224, 13225);
INSERT INTO `quest_template_addon` (`ID`, `NextQuestID`, `ExclusiveGroup`) VALUES
(13224, 13308, 13224), -- Mind Tricks requires Ogrim's Hammer OR
(13225, 13308, 13224); -- Mind Tricks requires The Skybreaker

DELETE FROM `disables` WHERE `sourceType` = 1 AND `entry` = 13381;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES
(1, 13381, 0, "Deprecated Quest: Watts My Target");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
