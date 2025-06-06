-- Removes: Watcher leesa'oh (9697) as pre-requesite from Observing the Sporelings (9701)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 9701);
