-- DB update 2022_07_05_00 -> 2022_07_05_01
-- fixed `Anatoly Will Talk` quest
UPDATE `smart_scripts` SET `event_flags`= 512 WHERE `entryorguid`= 2762600;
