-- DB update 2023_07_08_09 -> 2023_07_09_00
UPDATE `npc_text` SET `BroadcastTextID0` = 0 WHERE `ID` = 15906 AND `BroadcastTextID0` = 40591; -- Unlink incorrect broadcast text
