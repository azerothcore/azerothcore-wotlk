-- Fix Troll Patrol quests not granting Congratulations! bonus quest
UPDATE `quest_template_addon` SET `SourceSpellID` = 51573 WHERE `ID` = 12563;
UPDATE `quest_template` SET `RewardSpell` = 53707 WHERE `ID` IN (12563, 12587);
