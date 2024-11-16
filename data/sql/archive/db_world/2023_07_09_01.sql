-- DB update 2023_07_09_00 -> 2023_07_09_01
UPDATE `creature_text` SET `Text` = 'FIRE IN THE HOLE!', `Type` = 14, `BroadcastTextId` = 32326 WHERE (`CreatureID` = 7998) AND (`GroupID` = 19) AND (`ID` = 0);
UPDATE `creature_text` SET `BroadcastTextId` = 4446 WHERE `CreatureID` = 7998 AND `GroupID` = 20 AND `ID` = 0;
