-- DB update 2023_02_19_05 -> 2023_02_19_06
-- Fenrus the Devourer - Increase MaxDistance from 100 to 200
UPDATE `smart_scripts` SET `target_param2` = 200 WHERE `entryorguid` = 4274 AND `target_param1` = 4275;
