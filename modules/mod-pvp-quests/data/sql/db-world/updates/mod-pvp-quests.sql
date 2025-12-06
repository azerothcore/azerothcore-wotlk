--
SET @QUESTID = 50010;
SET @TITLE = 'First BG Victory';
DELETE FROM `quest_template` WHERE `ID` = @QUESTID;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `Flags`, `RewardItem1`, `RewardAmount1`, `LogTitle`, `LogDescription`, `QuestDescription`, `RequiredNpcOrGo1`, `RequiredNpcOrGoCount1`) VALUES
(@QUESTID, 2, -1, 70, 1, 0, 5, 4096, 0, 0, @TITLE, 'Battleground victory marker', 'Battleground victory marker', 0, 0);

DELETE FROM `quest_template_addon` WHERE (`ID` = @QUESTID);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(@QUESTID, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

SET @QUESTID = 50011;
SET @TITLE = 'First BG Defeat';
DELETE FROM `quest_template` WHERE `ID` = @QUESTID;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `Flags`, `RewardItem1`, `RewardAmount1`, `LogTitle`, `LogDescription`, `QuestDescription`, `RequiredNpcOrGo1`, `RequiredNpcOrGoCount1`) VALUES
(@QUESTID, 2, -1, 70, 1, 0, 5, 4096, 0, 0, @TITLE, 'Battleground defeat marker', 'Battleground defeat marker', 0, 0);

DELETE FROM `quest_template_addon` WHERE (`ID` = @QUESTID);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(@QUESTID, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
