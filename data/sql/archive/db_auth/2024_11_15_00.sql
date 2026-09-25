-- DB update 2024_01_20_00 -> 2024_11_15_00
UPDATE `updates`
SET `state` = 'ARCHIVED'
WHERE `name` LIKE '2023_%';
