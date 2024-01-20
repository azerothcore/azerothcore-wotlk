-- DB update 2023_09_25_07 -> 2023_09_25_08
/*
##################################################
Argent Dawn Vendors:
- Argent Quartermaster Hasana (10856)
- Argent Quartermaster Lightspark (10857)
- Quartermaster Miranda Breechlock (11536)

Quests:
- Mantles of the Dawn (5504)
- Mantles of the Dawn (5507)
- Mantles of the Dawn (5513)

Shoulder Enchants:
- Flame Mantle of the Dawn (18169)
- Frost Mantle of the Dawn (18170)
- Arcane Mantle of the Dawn (18171)
- Nature Mantle of the Dawn (18172)
- Shadow Mantle of the Dawn (18173)

Follow-up Quests:
- Chromatic Mantle of the Dawn (5517)
- Chromatic Mantle of the Dawn (5521)
- Chromatic Mantle of the Dawn (5524)

Shoulder Enchant:
- Chromatic Mantle of the Dawn (18182)

Vendor should only sell shoulder enchants if the player has completed the appropriate quest.
##################################################
*/

-- Add the Mantle of the Dawn quests (5504, 5507, 5513) to an ExclusiveGroup
DELETE FROM `quest_template_addon` WHERE `ID` in (5504, 5507, 5513);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(5504, 0, 0, 0, 0, 0, 5504, 0, 0, 0, 0, 529, 0, 21000, 0, 0, 0),
(5507, 0, 0, 0, 0, 0, 5504, 0, 0, 0, 0, 529, 0, 21000, 0, 0, 0),
(5513, 0, 0, 0, 0, 0, 5504, 0, 0, 0, 0, 529, 0, 21000, 0, 0, 0);

-- Add the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) to an ExclusiveGroup, and remove the repeatable flag
DELETE FROM `quest_template_addon` WHERE `ID` in (5517, 5521, 5524);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(5517, 0, 0, 0, 0, 0, 5517, 0, 0, 0, 0, 529, 0, 42000, 0, 0, 0),
(5521, 0, 0, 0, 0, 0, 5517, 0, 0, 0, 0, 529, 0, 42000, 0, 0, 0),
(5524, 0, 0, 0, 0, 0, 5517, 0, 0, 0, 0, 529, 0, 42000, 0, 0, 0);

-- Make the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) require one of the Mantle of the Dawn quests (5504, 5507, 5513)
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19 AND `SourceEntry` IN (5517, 5521, 5524));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 5517, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Chromatic Mantle of the Dawn (5517) - Requires one of the Mantle of the Dawn quests (5504, 5507, 5513) rewarded'),
(19, 0, 5517, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Chromatic Mantle of the Dawn (5517) - Requires one of the Mantle of the Dawn quests (5504, 5507, 5513) rewarded'),
(19, 0, 5517, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Chromatic Mantle of the Dawn (5517) - Requires one of the Mantle of the Dawn quests (5504, 5507, 5513) rewarded'),

(19, 0, 5521, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Chromatic Mantle of the Dawn (5521) - Requires one of the Mantle of the Dawn quests (5504, 5507, 5513) rewarded'),
(19, 0, 5521, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Chromatic Mantle of the Dawn (5521) - Requires one of the Mantle of the Dawn quests (5504, 5507, 5513) rewarded'),
(19, 0, 5521, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Chromatic Mantle of the Dawn (5521) - Requires one of the Mantle of the Dawn quests (5504, 5507, 5513) rewarded'),

(19, 0, 5524, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Chromatic Mantle of the Dawn (5524) - Requires one of the Mantle of the Dawn quests (5504, 5507, 5513) rewarded'),
(19, 0, 5524, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Chromatic Mantle of the Dawn (5524) - Requires one of the Mantle of the Dawn quests (5504, 5507, 5513) rewarded'),
(19, 0, 5524, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Chromatic Mantle of the Dawn (5524) - Requires one of the Mantle of the Dawn quests (5504, 5507, 5513) rewarded');

-- Argent QuarterMaster Hasana (10856) Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 23 AND `SourceGroup` = 10856 AND `SourceEntry` IN (18169, 18170, 18171, 18172, 18173, 18182));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(23, 10856, 18169, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18169, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18169, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10856, 18170, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18170, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18170, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10856, 18171, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18171, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18171, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10856, 18172, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18172, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18172, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10856, 18173, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18173, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10856, 18173, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10856, 18182, 0, 1, 47, 0, 5517, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) is rewarded.'),
(23, 10856, 18182, 0, 2, 47, 0, 5521, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) is rewarded.'),
(23, 10856, 18182, 0, 3, 47, 0, 5524, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Hasana (10856) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) is rewarded.');

-- Argent QuarterMaster Lightspark (10857) Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 23 AND `SourceGroup` = 10857 AND `SourceEntry` IN (18169, 18170, 18171, 18172, 18173, 18182));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(23, 10857, 18169, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18169, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18169, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10857, 18170, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18170, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18170, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10857, 18171, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18171, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18171, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10857, 18172, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18172, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18172, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10857, 18173, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18173, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 10857, 18173, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 10857, 18182, 0, 1, 47, 0, 5517, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) is rewarded.'),
(23, 10857, 18182, 0, 2, 47, 0, 5521, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) is rewarded.'),
(23, 10857, 18182, 0, 3, 47, 0, 5524, 64, 0, 0, 0, 0, '', 'Argent Quartermaster Lightspark (10857) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) is rewarded.');

-- Quartermaster Miranda Breechlock (11536) Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 23 AND `SourceGroup` = 11536 AND `SourceEntry` IN (18169, 18170, 18171, 18172, 18173, 18182));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(23, 11536, 18169, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18169, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18169, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Flame Mantle of the Dawn (18169) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 11536, 18170, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18170, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18170, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Frost Mantle of the Dawn (18170) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 11536, 18171, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18171, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18171, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Arcane Mantle of the Dawn (18171) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 11536, 18172, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18172, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18172, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Nature Mantle of the Dawn (18172) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 11536, 18173, 0, 1, 47, 0, 5504, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18173, 0, 2, 47, 0, 5507, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),
(23, 11536, 18173, 0, 3, 47, 0, 5513, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Shadow Mantle of the Dawn (18173) if one of the Mantle of the Dawn quests (5504, 5507, 5513) is rewarded.'),

(23, 11536, 18182, 0, 1, 47, 0, 5517, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) is rewarded.'),
(23, 11536, 18182, 0, 2, 47, 0, 5521, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) is rewarded.'),
(23, 11536, 18182, 0, 3, 47, 0, 5524, 64, 0, 0, 0, 0, '', 'Quartermaster Miranda Breechlock (11536) - Only sell Chromatic Mantle of the Dawn (18182) if one of the Chromatic Mantle of the Dawn quests (5517, 5521, 5524) is rewarded.');
