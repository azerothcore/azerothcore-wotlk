-- Spawns npc's from 13:00 - 17:00
UPDATE `game_event` SET `start_time`= '2016-10-30 13:00:00', `length` = 240,  `description`= 'Stranglethorn Fishing Extravaganza - The Crew' WHERE `eventEntry` = 62;

-- Quests can be turned in 14:00 - 17:00
DELETE FROM `game_event` WHERE `eventEntry` = 90;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
(90,'2016-10-30 14:00:00','2030-12-31 07:00:00',10080,180,0,0,'Stranglethorn Fishing Extravaganza - Turn-ins',0,2);

-- Assign script to Jang
UPDATE `creature_template` SET `scriptName`='npc_jang' WHERE `entry` = 15078;

-- Minimum fishing skill for Stranglethorn Vale Fishing Extravaganza quests is 150, also [Could I get a Fishing Flier?]
DELETE FROM `quest_template_addon` WHERE `ID` IN (8194, 8193, 8225, 8224, 8221, 8228, 8229);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(8194,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1),
(8193,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1),
(8225,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1),
(8224,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1),
(8221,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1),
(8228,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1),
(8229,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1);

-- Box on which Riggle Bassbait stands: linked to event 62 (The Crew)
UPDATE `game_event_gameobject` SET `eventEntry`= 62 WHERE `guid`= 164445;

-- Riggle Bassbait: use broadcast texts
UPDATE `creature_text` SET `BroadcastTextId` = 10608, `Text`='Let the Fishing Tournament BEGIN!' WHERE `CreatureID` = 15077 AND `GroupID` = 0;
UPDATE `creature_text` SET `BroadcastTextId` = 10609, `Text`='And the Tastyfish have gone for the week! I will remain for another hour to allow you to turn in your fish!' WHERE `CreatureID` = 15077 AND `GroupID` = 1;
UPDATE `creature_text` SET `BroadcastTextId` = 10610, `Text`='We have a winner! $n has won FIRST PLACE in the tournament!' WHERE `CreatureID` = 15077 AND `GroupID` = 2;

-- Fishbot 5000 quests: only available when event 90 (Turn-ins) is active
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19,0,8225,0,0,12,0,90,0,0,0,0,0,'','Fishing Extravaganza - Turn-ins active'),
(19,0,8224,0,0,12,0,90,0,0,0,0,0,'','Fishing Extravaganza - Turn-ins active'),
(19,0,8221,0,0,12,0,90,0,0,0,0,0,'','Fishing Extravaganza - Turn-ins active');
