-- DB update 2025_06_06_00 -> 2025_06_06_01
-- Sets SpecialFlags from 0 to 1, allowing Fine Gold Thread to be repeatable.
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags` | 1 WHERE (`ID` = 4785);
