-- Deadly Gladiator is missing from all four lower PvP title achievements.
-- Add alternatives; retain the existing Season 6-8 and lower-rank criteria.
DELETE FROM `achievement_criteria_dbc` WHERE `ID` IN (20000, 20001, 20002, 20003);
INSERT INTO `achievement_criteria_dbc` (`ID`, `Achievement_Id`, `Type`, `Quantity`,
    `Description_Lang_enUS`, `Flags`, `Ui_Order`) VALUES
    (20000, 2090, 74, 1, 'Deadly Gladiator', 2, 8),
    (20001, 2091, 74, 1, 'Deadly Gladiator', 2, 5),
    (20002, 2092, 74, 1, 'Deadly Gladiator', 2, 6),
    (20003, 2093, 74, 1, 'Deadly Gladiator', 2, 7);

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (20000, 20001, 20002, 20003);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
    (20000, 23, 157, 0, ''),
    (20001, 23, 157, 0, ''),
    (20002, 23, 157, 0, ''),
    (20003, 23, 157, 0, '');
