-- DB update 2022_05_17_02 -> 2022_05_17_03
-- Goblin Land Mine, remove Hakkar sound on arming
UPDATE `creature_text` SET `Sound` = 0 WHERE `CreatureID` = 7527;
