-- Bug Report #19575

-- Unlink from engineering quest chain:
-- 3638 (Goblin Engineering - Pledge of Secrecy)
-- 3640 (gnome engineering - pledge of secrecy, alliance)
-- 3642 (gnome engineering - pledge of secrecy, horde)
UPDATE `quest_template` SET `RewardNextQuest`=0 WHERE `ID`=3638 OR `ID`=3640 OR `ID`=3642;
UPDATE `quest_template` SET `RewardNextQuest`=3639 WHERE `ID`=3526 OR `ID`=3629 OR `ID`=3633 OR `ID`=4181;
UPDATE `quest_template` SET `RewardNextQuest`=3641 WHERE `ID`=3630 OR `ID`=3632 OR `ID`=3634;
UPDATE `quest_template` SET `RewardNextQuest`=3643 WHERE `ID`=3635 OR `ID`=3637;

-- Remove Pledge of Secrecy from creature_queststarter
DELETE FROM `creature_queststarter` WHERE `quest`=3638 OR `quest`=3640 OR `quest`=3642;
-- Remove Pledge of Secrecy from creature_questender
DELETE FROM `creature_questender` WHERE `quest`=3638 OR `quest`=3640 OR `quest`=3642;

-- Link quests together:
-- 3526, 3629, 3633, 4181 (Goblin Engineering) -> 3639 (Goblin Engineering - Show Your Work)
UPDATE `quest_template_addon` SET `PrevQuestID`=3633 WHERE `ID`=3639;
UPDATE `quest_template_addon` SET `NextQuestID`=3639 WHERE `ID`=3526 OR `ID`=3629 OR `ID`=3633 OR `ID`=4181;
-- 3630, 3632, 3634 (Gnome Engineering - Alliance) -> 3641 (Gnome Engineering - Show Your Work - Alliance)
UPDATE `quest_template_addon` SET `PrevQuestID`=3634 WHERE `ID`=3641;
UPDATE `quest_template_addon` SET `NextQuestID`=3641 WHERE `ID`=3630 OR `ID`=3632 OR `ID`=3634;
-- 3635, 3637 (Gnome Engineering - Horde) -> 3643 (Gnome Engineering - Show Your Work - Horde)
UPDATE `quest_template_addon` SET `PrevQuestID`=3635 WHERE `ID`=3643;
UPDATE `quest_template_addon` SET `NextQuestID`=3643 WHERE `ID`=3635 OR `ID`=3637;
