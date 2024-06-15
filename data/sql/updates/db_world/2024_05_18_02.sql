-- DB update 2024_05_18_01 -> 2024_05_18_02
-- add missing broadcastID to Elder Clearwater txt lines
UPDATE `creature_text` SET `BroadcastTextId` = '38218' WHERE `CreatureID` = '38294' AND `GroupID` = '1' AND `ID`='0';
UPDATE `creature_text` SET `BroadcastTextId` = '38222' WHERE `CreatureID` = '38294' AND `GroupID` = '3' AND `ID`='0';
