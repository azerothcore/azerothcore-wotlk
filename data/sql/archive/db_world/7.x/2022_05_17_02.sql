-- DB update 2022_05_17_01 -> 2022_05_17_02
-- (Quest) Coward Delivery... Under 30 Minutes or it's Free - Cast "Call Alliance Deserter" on accept
UPDATE `quest_template_addon` SET `SourceSpellID` = 45975 WHERE `ID` = 11711;
-- Valiance Keep Officer set NPC and PC immunity flags
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 768 WHERE `entry` = 25759;
