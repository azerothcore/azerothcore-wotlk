-- Make quest 5504 (Mantles of the Dawn) Horde-only
DELETE FROM `quest_template` WHERE (`ID` = 5504);
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES
(5504, 2, 60, 55, 28, 0, 0, 529, 0, 21000, 0, 0, 5, 0, 0, 5700, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 529, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 690, 'Mantles of the Dawn', 'Bring 10 Argent Dawn Valor Tokens to Quartermaster Hasana at the Bulwark, Western Plaguelands.', 'Your service to the Argent Dawn is to be commended, $N.  You are truly revered amongst us.  I have been authorized to make available for you to purchase one of the Dawn\'s most valued items - our magic resistance mantles.$B$BApplication of a mantle to your existing shoulder piece will enhance your resistance to the powers of magic in one of five potential ways.  As a sign of continued dedication to our cause, I ask for no less than ten of our valor tokens in exchange for access to these mantles.', '', 'Return to Argent Quartermaster Hasana at The Bulwark in Tirisfal Glades.', 0, 0, 0, 0, 0, 0, 0, 0, 12844, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, '', '', '', '', 12340);

-- Add the Mantles of the Dawn quests (5504, 5507, 5513) to an ExclusiveGroup
DELETE FROM `quest_template_addon` WHERE `ID` in (5504, 5507, 5513);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(5504, 0, 0, 0, 0, 0, 5504, 0, 0, 0, 0, 529, 0, 21000, 0, 0, 0),
(5507, 0, 0, 0, 0, 0, 5504, 0, 0, 0, 0, 529, 0, 21000, 0, 0, 0),
(5513, 0, 0, 0, 0, 0, 5504, 0, 0, 0, 0, 529, 0, 21000, 0, 0, 0);

/*
##################################################
Argent Dawn Vendors:
- Argent Quartermaster Hasana (10856)
- Argent Quartermaster Lightspark (10857)
- Quartermaster Miranda Breechlock (11536)

Shoulder Enchants:
- Flame Mantle of the Dawn (18169)
- Frost Mantle of the Dawn (18170)
- Arcane Mantle of the Dawn (18171)
- Nature Mantle of the Dawn (18172)
- Shadow Mantle of the Dawn (18173)
- Chromatic Mantle of the Dawn (18182)

Quests:
- Mantles of the Dawn (5504) - Horde Only
- Mantles of the Dawn (5507)
- Mantles of the Dawn (5513)

Vendor should only sell shoulder enchants if the player has completed one of the three quests.
##################################################
*/

-- Argent QuarterMaster Hasana (10856) Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 23 AND `SourceGroup` = 10856 AND `SourceEntry` IN (18169, 18170, 18171, 18172, 18173, 18182));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(23, 10856, 18169, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18169, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18169, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10856, 18170, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18170, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18170, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10856, 18171, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18171, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18171, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10856, 18172, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18172, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18172, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10856, 18173, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18173, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18173, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10856, 18182, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18182, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18182, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.');

-- Argent QuarterMaster Lightspark (10857) Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 23 AND `SourceGroup` = 10857 AND `SourceEntry` IN (18169, 18170, 18171, 18172, 18173, 18182));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(23, 10857, 18169, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18169, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18169, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10857, 18170, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18170, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18170, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10857, 18171, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18171, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18171, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10857, 18172, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18172, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18172, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10857, 18173, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18173, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18173, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10857, 18182, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18182, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18182, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.');

-- Quartermaster Miranda Breechlock (11536) Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 23 AND `SourceGroup` = 11536 AND `SourceEntry` IN (18169, 18170, 18171, 18172, 18173, 18182));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(23, 11536, 18169, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18169, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18169, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 11536, 18170, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18170, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18170, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 11536, 18171, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18171, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18171, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 11536, 18172, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18172, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18172, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 11536, 18173, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18173, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18173, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 11536, 18182, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18182, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18182, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Mantles of the Dawn quests (5504, 5507, 5513) is rewarded.');
