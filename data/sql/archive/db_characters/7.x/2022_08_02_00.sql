-- DB update 2022_05_24_00 -> 2022_08_02_00
--
UPDATE `characters` SET `taxi_path`=CONCAT('0 ', `taxi_path`) WHERE LENGTH(`taxi_path`) > 0;
