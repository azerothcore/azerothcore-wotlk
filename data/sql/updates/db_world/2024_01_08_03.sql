-- DB update 2024_01_08_02 -> 2024_01_08_03
-- Fix Orgrimmar Grunt directions for barber shop
UPDATE `npc_text` SET `BroadcastTextID0` = 0 WHERE `ID` = 13889;
