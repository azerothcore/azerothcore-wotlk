-- DB update 2022_05_30_00 -> 2022_05_30_01
-- BroadcastTextId for Leviathan Mk II's plasma blast
UPDATE `creature_text` SET `BroadcastTextId` = 34217 WHERE `CreatureID` = 33432 AND `GroupID` = 0;
