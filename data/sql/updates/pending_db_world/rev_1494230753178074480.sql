INSERT INTO version_db_world (`sql_rev`) VALUES ('1494230753178074480');

-- The boar hunter requires 12 kills, not 8
UPDATE `quest_template` SET `RequiredNpcOrGoCount1` = 12 where `ID` = 183;

-- Quest Westbrook Garrison Needs Help! has The Jasperlode Mine as prequest
UPDATE `quest_template_addon` SET `PrevQuestID` = 76 WHERE `ID` = 239;

-- The Everstill Bridge has The Lost Tools as prequest
UPDATE `quest_template_addon` SET `PrevQuestID` = 125 WHERE `ID` = 89;

-- Kurzen's Mystery follows Bad Medicine, not Colonel Kurzen
UPDATE `quest_template_addon` SET `PrevQuestId` = 204 WHERE `ID` = 207;

-- Spirits of the Stonemaul Hold follows The Essence of Enmity
UPDATE `quest_template_addon` SET `PrevQuestId` = 11161 WHERE `ID` = 11159;

-- Bungle in the jungle follows March of the Silithid (alliance: 4493, horde:4494), which follow Rise of the Silithid (alliance: 162, horde: 32)
UPDATE `quest_template_addon` SET `PrevQuestID` = 162, `NextQuestID` = 4496, `ExclusiveGroup` = 4493 WHERE `ID` = 4493;
UPDATE `quest_template_addon` SET `PrevQuestID` =  32, `NextQuestID` = 4496, `ExclusiveGroup` = 4493 WHERE `ID` = 4494;

-- Salve via hunting first time quest for alliance was not rewarding money or xp
UPDATE `quest_template` SET RewardXPDifficulty = 4, RewardBonusMoney = 3600 WHERE ID = 4103;
-- Salve via hunting repeatable quest for horde WAS!
UPDATE `quest_template` SET RewardXPDifficulty = 0, RewardBonusMoney =    0 WHERE ID = 5887;
