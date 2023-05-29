-- DB update 2022_05_06_02 -> 2022_05_06_03
-- Fix Valkyrion Harpoon Gun SAI to set rooted on passenger exit
UPDATE `smart_scripts` SET `event_type`=28, `event_flags`=0, `comment`='Valkyrion Harpoon Gun - On Passenger exit - Set Rooted On' WHERE `entryorguid`=30066;
