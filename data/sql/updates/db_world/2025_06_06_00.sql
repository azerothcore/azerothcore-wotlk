-- DB update 2025_06_05_03 -> 2025_06_06_00
-- Removes: Watcher leesa'oh (9697) as pre-requesite from Observing the Sporelings (9701)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 9701);
