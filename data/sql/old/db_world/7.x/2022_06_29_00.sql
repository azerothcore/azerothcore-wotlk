-- DB update 2022_06_28_05 -> 2022_06_29_00
-- fixed `Escape from Silverbrook` quest
UPDATE `smart_scripts` SET `event_flags`=512 WHERE `entryorguid`=2740900;
